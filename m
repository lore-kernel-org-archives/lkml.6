Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F93C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 425D2214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="FzlVFacR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbfAJK0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 05:26:06 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34630 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbfAJK0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 05:26:05 -0500
Received: by mail-lj1-f196.google.com with SMTP id u89-v6so9220943lje.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 02:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SBb86NMsHZ5zps+6tloB3NYJDPBdSU6IL/CZyxV0S9Y=;
        b=FzlVFacRA/R+4Y4MHxn3FgqVh8KQH2b/3VtkvqJthWFBglUM0hGNSiA0IVcsBKgc3s
         ZChbfJDlVATnbb+mmwbDsTxkr4WLiPPDJWJm46aZHN3IeJVbDD4VFLlj4ujBAc5TmElM
         5oxIzjfyXS5S51FSU0LbXS5XK5MYkRahf7xNAhU01LggXf1AJ0FmOvsr7byu0ppKW93M
         9vP0vjdHXHWHSCPLUdl+mxXeWdlH54e8VkfyEis7N9VqqnSMsEfKgE13vIOODYw6gbNw
         V26U3py3oCueF23d5VV3rlLsFsaSBbGlRn5f9jF4ZPjF7uOtBoK3v5X6NBm4eC2+DJmU
         jSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=SBb86NMsHZ5zps+6tloB3NYJDPBdSU6IL/CZyxV0S9Y=;
        b=Qrnpnin8Ngjk8Ojygw23ufSqmQkzCgPME0F2RjcepFnjz7J+/hlEcNiteTOHcOZuEl
         kNHTQAtZpJ+qYg0ZNCjratAjg71TmmZaj8a5AP96KW4zcl2OQ04vNuaTSdhoRo40Ndym
         hH5eLt4deSD2HtErqW3zLTX03QzM5TiQaNT+tA4ZKsaKy9YMn8YC2zPVp9NLymy5fkjQ
         9vZh391pHpnVDGGrdsUKEdbKYiuoCXwYl0McMgK+StG/Vg0LJyw4Uq5KcCuwwKqWlEl/
         FdAxLQYhM6IeC2OlhxW1Y3UaFD9O/O+mnmlknHqE6tvZlrEK1VuO76JMCBWXZwMorqO0
         qpdg==
X-Gm-Message-State: AJcUukegCgGf2Oy8iBtgL4eUiiopJQjmgEs2L+0XTG9KTLCKN6TuO/oj
        HCsO5wTnT3GBQ1YkHrGfQIYUNA==
X-Google-Smtp-Source: ALg8bN4H9oq7U8dO7P24L7Xw2SJKHOTDPQXfIihMWdPymAeZxodxStBBiN5uZWZ/lFVyUGIckds7sg==
X-Received: by 2002:a2e:9a16:: with SMTP id o22-v6mr5479034lji.112.1547115963779;
        Thu, 10 Jan 2019 02:26:03 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.83.122])
        by smtp.gmail.com with ESMTPSA id h3sm13915957lfj.25.2019.01.10.02.26.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 02:26:02 -0800 (PST)
Subject: Re: [PATCH v5 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
To:     Boris Brezillon <bbrezillon@kernel.org>
Cc:     Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        marek.vasut@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, boris.brezillon@bootlin.com,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
References: <1546921020-20436-1-git-send-email-masonccyang@mxic.com.tw>
 <1546921020-20436-2-git-send-email-masonccyang@mxic.com.tw>
 <74a5fba6-a77e-f71b-ce49-405fee8e0fda@cogentembedded.com>
 <20190110111601.1dad05a0@bbrezillon>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <dd36d2b3-c0e3-f6a3-56f1-c96f4ae59ece@cogentembedded.com>
Date:   Thu, 10 Jan 2019 13:26:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190110111601.1dad05a0@bbrezillon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/2019 01:16 PM, Boris Brezillon wrote:

>>> Add a driver for Renesas R-Car Gen3 RPC-IF SPI controller.
>>>
>>> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>  
>>
>>    You now need to add:
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> May I ask why?

   v5 includes my signed read mode workaround patch.

MBR, Sergei
