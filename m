Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DAFC43612
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 19:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73FCC2171F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 19:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uNzxpy0R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbeLZTHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 14:07:53 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37482 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbeLZTHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 14:07:53 -0500
Received: by mail-wr1-f66.google.com with SMTP id s12so16375996wrt.4;
        Wed, 26 Dec 2018 11:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZFO+vMdaKlndOmBDCu/FO1yVJAZXLcFFOHafEPkeYQU=;
        b=uNzxpy0R8bdRvgeYvKCQetHNIwoaobMO+mbAlcc7CZWMRfOMKvzGMGwbMctFFDU8HW
         zshlmzXJ6qObGAyPynXoGOKsg1Xw4KSWbwkbnbKiLJ8aHuJIO+aq5ZLlVa+FpFAMsmQ7
         9b6a6JqSPAT+fdkCzdPyhcVXXgPHYIedwZpcEAuZPE40by2novW7K0IwW6fnTjxauJsI
         0OHLindG6NtB3kkD4a+UvsGCJmpmoEgVSys+gfTs9rZgZdw8qurZ4wsn+x0rxTVlaL60
         q3cYOHFZBYrL2g216BjfdFL+ZAIusxJkwqeJFQDTIFjkq9oGtySNMKojRvvV+i3jlMUR
         s8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZFO+vMdaKlndOmBDCu/FO1yVJAZXLcFFOHafEPkeYQU=;
        b=Pp1QpYAHtlCkk4Jt1kgL0dseaqC6Fq5kXJXhyFGoBx9XzTOdp1I+h5cLSHvHnkpVSl
         QuJzS7rd8Wk+g3We27AuktionDq8C/taGn8cKzbPFLbQcJtJVoMfSM95kpicjltPL7rB
         10o0+C2UMlQ2h5Z6P9s0SjFI2IRO0VduE2m2hFUx63Y8t33JyeLpZ5krJuNs212mL2rN
         +2FfIheHjjYpe9SEFfi+ArDJFIjQr/WhlN8eQZjV/GGM74kh6slaTuHh3EvkFyaAVyY7
         eSOBdp9dWP/6h4BIKVb3sZy6W5Riu12JaGkz8tqHvkn+E4XND+a6fQvZywkt3BosxHnz
         +NdA==
X-Gm-Message-State: AJcUukd+Z45PEbrDXCyi3JXC0ZGJL3cyRj3guqOVVwrl0s4PT1PMBhvk
        HczHWAZnB6cLEb8qWOhRN+g=
X-Google-Smtp-Source: ALg8bN4sBu7X5xAV8Nirj5SxyltqBcKANmpRYMXUmSKOR6++VPRNzKLsu3SmXkONbJO1oYnYtr6MZg==
X-Received: by 2002:a5d:6549:: with SMTP id z9mr18856081wrv.116.1545851270707;
        Wed, 26 Dec 2018 11:07:50 -0800 (PST)
Received: from [192.168.42.184] (cst-prg-83-217.cust.vodafone.cz. [46.135.83.217])
        by smtp.gmail.com with ESMTPSA id z7sm23618543wrw.22.2018.12.26.11.07.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Dec 2018 11:07:49 -0800 (PST)
Subject: Re: [PATCH v4 0/2] spi: Add Renesas R-Car Gen3 RPC SPI driver
To:     Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        boris.brezillon@bootlin.com, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        sergei.shtylyov@cogentembedded.com
Cc:     juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
References: <1545634358-17485-1-git-send-email-masonccyang@mxic.com.tw>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <80223417-2919-97c7-d9e3-0d0511a5a517@gmail.com>
Date:   Wed, 26 Dec 2018 20:06:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <1545634358-17485-1-git-send-email-masonccyang@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/24/18 7:52 AM, Mason Yang wrote:
> Hi Mark,
> 
> This Renesas R-Car Gen3 RPC SPI driver is based on Boris's new
> spi-mem direct mapping read/write mode [1][2].

Again, the RPC is NOT a SPI controller, it is dual SPI/HF controller.

[...]

-- 
Best regards,
Marek Vasut
