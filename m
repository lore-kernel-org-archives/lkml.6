Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FFBC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B34E21473
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J18qmaQg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B34E21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733113AbeHFSNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:13:23 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45872 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730724AbeHFSNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:13:23 -0400
Received: by mail-pg1-f195.google.com with SMTP id f1-v6so6416091pgq.12;
        Mon, 06 Aug 2018 09:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lpseXCozhj4Lnwlm39GbYbPDVhnHvO8cfqBhSXIH6Y0=;
        b=J18qmaQgwM3nY15TUaN2euXyH46HM7gM+jyXBs2bG0VAmcklhSTHAP1/Yzbtnr2bJ+
         RUGijj7GZHpFiPrhPwCe1aXTs1YhF9678WpSalxrzEsHy6hE2epnvbDe4GI0cdk9btQA
         oHm/t1tSfMawrEZf8n2bVldtAtVX5WwF8PkUVUj30vDIwJ8TjxChzHtKXHHx+WZWF5Z5
         qJjiV3nUL5gth5SVDasJ3fU1YkqsRtuGb7sTkGvNPQgDP3/leHb3iXDwSWyfaWqT9AZs
         jRHWodZimKhXcljQwUAdO2b37m6IE1EwutAIl89SqkYkcTVbMf0CmMQ6flNnwJkJWCNW
         YH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lpseXCozhj4Lnwlm39GbYbPDVhnHvO8cfqBhSXIH6Y0=;
        b=uQxhDulTQWKi0PlzD4F2E2xaGWUmsiXhCdIP961TsRiyEmPwnSgd90g90SczJdbgeH
         /0zdhxvYNSLiBa5xHLg9hMCscc8ZuFnNwDLJW+wH70yVG2BEthCaOteg0uAIuDmEWVNv
         5jjtb3t77LRCSVi0ubQfKOuLpV1Qwr63GpML/+ysKECTlZKQFz1smli3bnub6bZo/ijN
         B5ulDqN1RYylICd4a/DNHg68VLh0i3Me4GEQLiompFnRthafz5FLyiJIIrrMkAcoDblJ
         hc8ix5GkuodZkOBhGNvy7ccI23On+3dqOzSXe+tsOOKuYo+7NNR2OZA+ZMQ8Hfj1UYGb
         TLnQ==
X-Gm-Message-State: AOUpUlG3w368caHh8syVDYsIoHoW+4LuJC6sEv6o9Gvb6m0Bo1RKi3Tn
        CpoHLVumS34sxuI99qkKdbH9QADp
X-Google-Smtp-Source: AAOMgpdhRw5F0Y3dHiAdbrbg5aZMTipb6sO8zyXYyYaHhPeFkSDSgzAIQ+OU6pby/Lq/QQIVPK0xZg==
X-Received: by 2002:a65:5a01:: with SMTP id y1-v6mr13775978pgs.125.1533571417111;
        Mon, 06 Aug 2018 09:03:37 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id f5-v6sm13197664pga.58.2018.08.06.09.03.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 09:03:36 -0700 (PDT)
Subject: Re: [PATCH] USB: OHCI: ohci-sm501: complete URBs in BH context
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1533355279-26725-1-git-send-email-linux@roeck-us.net>
 <20180806083730.GA32650@infradead.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <cbbcbe2c-28c6-faa1-4ef4-8e59c486e2a4@roeck-us.net>
Date:   Mon, 6 Aug 2018 09:03:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180806083730.GA32650@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2018 01:37 AM, Christoph Hellwig wrote:
> On Fri, Aug 03, 2018 at 09:01:19PM -0700, Guenter Roeck wrote:
>> Testing an USB drive connected to ohci-sm501 results in a large number
>> of runtime warnings.
> 
> As far as I can tell this driver uses the HCD_LOCAL_MEM feature flag
> for memory declared using dma_declare_coherent_memory.  Unlike the
> mormal dma mapping interfaces this special case can actually be freed
> from interrupt context, and we have a fix for this warning queued
> up in linux-next:
> 
> http://git.infradead.org/users/hch/dma-mapping.git/commitdiff/d27fb99f62af7b79c542d161aa5155ed57271ddc
> 
> That being said I'm generally very unhappy how dma_init_coherent_memory
> turned out.  The idea was to allow device local memory to be hidden
> behind the DMA API, but in general we use it either as a way to declare
> special uncache system memory (which would really be the plaform codes
> job), or as a magic bounce buffer like in the USB code.  I plan to
> eventually untangle this, but it is going to take some time.
> 

Yes, I can confirm that the warning is gone in -next. Problem solved,
except of course there are still the warnings about the missing
coherent_dma_mask.

sm501-usb sm501-usb: SM501 OHCI
sm501-usb sm501-usb: new USB bus registered, assigned bus number 1
WARNING: CPU: 0 PID: 1 at ./include/linux/dma-mapping.h:516 ohci_init+0x194/0x2d8

Is that warning also not warranted for the given use case, or is
the missing mask indeed necessary ? It is easy to add - see
https://lore.kernel.org/patchwork/patch/971411/ - but I do wonder
if that change is appropriate.

Thanks,
Guenter
