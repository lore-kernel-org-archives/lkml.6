Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C26C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36A1C20672
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="Rwm3uFgA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36A1C20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbeLLQla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 11:41:30 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33561 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbeLLQl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 11:41:26 -0500
Received: by mail-lf1-f65.google.com with SMTP id i26so14054078lfc.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 08:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CvGD0GTq9G5XxY4JwRepFdT8HYK5EqjNd5yit2zalY4=;
        b=Rwm3uFgARf+lbWSU0+qY/N1bwUdEDFTW5fdzF70POm4XyXyPbiPgiFC7Xu1t8mJPxC
         3+LiUUUfFzYhNe+vUUaofLcgvk9SuMOeq6H3gFyKQF6cm8Jdnj06E4TZtnkfveEd+kMW
         X9Fys29SEXZnNPu6JldRL+ny+ImR7pOLJ5vNobVjp9ueIIAoNHbLJ9sMrB2quG604ZIJ
         7rMJalARDRN0IvYUFXa96D5tnbWPgSHzxgf1HgcSSFgukkOXmH7t4HEYJ8aeEh1IRKC0
         6iZzOS7VLVEL61cwhwdSp36k/VoByFXYujKBFE1bH2kst/zSKtgDiRa+y3IAo7tuY1QP
         O9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=CvGD0GTq9G5XxY4JwRepFdT8HYK5EqjNd5yit2zalY4=;
        b=J+H6/reV56RMrPTiE57EkvP1KIu0AtVFooVZTsViRwQal1VNCtdclJFgH0akq+XB+p
         KAg1KuYy7ks6flFiFBlUNrW2kCnKgu/Y0vHWkIm0vQksU1oKxaqbx/0mvIeax28lu6mt
         D+f8xmumUpUhFRE/v2nWF8jVeGUZW7qwf5zSNwIct5tGA4Aa/WNvQ8CwQRF38jvhJv7D
         UY4QYVa1587aOFhMiehxLHm9o3ZxfJIFkXriiK5OAZAeQYH9KIbHKRjZetXrh390Ei/N
         niN2VdG3kQS39EgVqnuJnTlrgZfQOod5hEyueKVhAW1tgDplMrhNNspbsvpW2wm4SrZ0
         0MeA==
X-Gm-Message-State: AA+aEWZPvyIJD4IakybtimNpsYOuSjrXq4GEasIWdlMZ93Z97YgYDD0e
        82EdBEIrYqNfm470/GdceKEeeg==
X-Google-Smtp-Source: AFSGD/Wxh+WgqOLugKtkza5Wj/r0VftUvoFJXs9nOLwecbApfmJ/YUP1zm3jZATUKCLBs5DNkMJWRg==
X-Received: by 2002:a19:fc09:: with SMTP id a9mr12866360lfi.21.1544632884425;
        Wed, 12 Dec 2018 08:41:24 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.85.181])
        by smtp.gmail.com with ESMTPSA id u12-v6sm3340898ljk.79.2018.12.12.08.41.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 08:41:23 -0800 (PST)
Subject: Re: [PATCH v3 2/2] dt-binding: spi: Document Renesas R-Car Gen3 RPC
 controller bindings
To:     Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        marek.vasut@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, boris.brezillon@bootlin.com,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
References: <1544181199-3373-1-git-send-email-masonccyang@mxic.com.tw>
 <1544181199-3373-3-git-send-email-masonccyang@mxic.com.tw>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <89a88758-dc9f-d805-c123-d46bf9c9bda7@cogentembedded.com>
Date:   Wed, 12 Dec 2018 19:41:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1544181199-3373-3-git-send-email-masonccyang@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Should be "dt-bindings: " in the subject...

MBR, Sergei
