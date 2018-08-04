Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E114C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 18:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21714217CC
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 18:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="1C1+ft4S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21714217CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbeHDUKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 16:10:17 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40722 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbeHDUKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 16:10:16 -0400
Received: by mail-lf1-f68.google.com with SMTP id y200-v6so6303424lfd.7
        for <linux-kernel@vger.kernel.org>; Sat, 04 Aug 2018 11:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tkIpkZ26AXWGXdW3d3XZadwWYnWzVcvjOqUrW5yGx+4=;
        b=1C1+ft4S44IshHI+o8g+SQ5Mjx9/fe39dm7WOcbMjXhSOmoW9Ktc+RIAXNjOX7OAbE
         W/SYAb8y2LNuudYwOAGylmEBFTBikZ6xWBlVGQz4gV22CO0meyytFJ5uu6q28fMemASJ
         arB8LUjBo7yQJWjowtQoJxFXPd2lax2m6s7MWzSa1Nh+6XDVarxSuockzKOV9NrI4G+8
         3hxFzWxzh1QVLT8gtJ1Hk4WjnGO26lvwAcBZCbosOYfm0g0QGY8B24jtGDrQ69RxVBWk
         zohrShlCkHzq0FLcSeKCWcRS8vqfqGppaV4Hq8qV0vNdMfkFOhrClmONy9PqmnphMljK
         FJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=tkIpkZ26AXWGXdW3d3XZadwWYnWzVcvjOqUrW5yGx+4=;
        b=sj7UVufHD+Vck0KmxduiO3VMNx5G6b1OKovnkO+iHvphd4PDamxbzY8E1v2kAUmV5h
         yKiisvgkzZTmn5bOIX9qla2YhYvU0enHa9raYK7TludOADx+2Cv1FZgyuzrhUlcckZbW
         U5lYZRBX5+hnr2jhhDT4c0ztl4v6B8tGRQii91/9bsikU+XkZ2poEYYz3irktlELYSF9
         3jIdzimAiKWlZyko/51y1wnRup6ux3pT1IlG5HmOMzLFCbmLpecDstFTCzO3PpYfoBBh
         kaN16YLWJ2jnya7OA0O7MmWz8K6h1fwgK/HM2push6ULLgCX3PaxQaSJoRCSEo6GVWKV
         BwxQ==
X-Gm-Message-State: AOUpUlH5UPrjgvJrFL8RIAPif/yPhBsf6RqgWdQJCemkQ3ZpsAhs0Az1
        tJ7iXTjtnWzdpXL46amKDos/5PdHqZ4=
X-Google-Smtp-Source: AAOMgpe1aDqMW8ElXj9Oeq1tgVaucJGbkhaUbBKGoJozoQ8te4JBK6oU+owjRe4m6gsFrwMe6azF+Q==
X-Received: by 2002:a19:e546:: with SMTP id c67-v6mr7377685lfh.135.1533406126606;
        Sat, 04 Aug 2018 11:08:46 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.81.84])
        by smtp.gmail.com with ESMTPSA id p64-v6sm1395863lje.59.2018.08.04.11.08.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 11:08:45 -0700 (PDT)
Subject: Re: [PATCH] net: Remove some unneeded semicolon
To:     zhong jiang <zhongjiang@huawei.com>, davem@davemloft.net,
        wensong@linux-vs.org, horms@verge.net.au, ja@ssi.bg
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1533382901-17922-1-git-send-email-zhongjiang@huawei.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <a274184c-c8e8-37de-492c-596f038337d0@cogentembedded.com>
Date:   Sat, 4 Aug 2018 21:08:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1533382901-17922-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2018 02:41 PM, zhong jiang wrote:

> That semicolon is not unneeded , Just remove them.

   s/un//, right? ;-)
   That and you suddenly switch from singular to plural.

> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

MBR, Sergei
