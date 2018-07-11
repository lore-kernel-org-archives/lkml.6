Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D959C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B9F208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSEzX9gm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53B9F208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388344AbeGKOBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:01:40 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36064 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388100AbeGKOBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:01:40 -0400
Received: by mail-ed1-f65.google.com with SMTP id t3-v6so19277189eds.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 06:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5ppfIWV42iPf32sidEqVaV6HHF2yz5imJelvpaNiIIw=;
        b=YSEzX9gm40HWzhFy0nMYmhopPs9q6iQ6GydOmJU+IMqBS45gw19iISU78kGHY3XXOk
         VyhfvhPKNTDGYCpPWoMFelI2pHx5W6HY5VnjGk9juVIlxQo9oUAUmGG2cobUcsfuOZjv
         /UShz+D39pBN6qzOwlzkEGbi8Q0BD4ppTmkfCfBswyTo5k8u5sGOwjzMNqP+to9hsneM
         R1+ntPpuDvKcQDjg8fGYHGhJkBenxTb5VN1dP35MW8PHSbW8dFcVrJxAwR1Mrktsxj5d
         C1TizbGwhsGvorAsgB0NAPLwA0f8Y4YzqyfotkcjC/3fCJUIgmInMvfrcNIeCp7FTtDi
         g3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5ppfIWV42iPf32sidEqVaV6HHF2yz5imJelvpaNiIIw=;
        b=S+3HyCyGW5ZrEu0vl6tVf4cxZofSz/e2/XHLT8Hd5y0fEBZDnpALc5MsQExcABnb5g
         GBLb/rQsTlEmbIyK6wzdRAFwVzJWx5ijRiVaQ94Z5glhbQZKS6rRDoCJ9tyQZFn0HcGz
         GlkHArIT0syEJr69AK3oJABnlBmHlw+1SFIDAiO4C3pB6+miuz95IdXXLFW4uHhhTJRi
         F23IsE3hIRE2g3hf0n5I1bi/zhMtH5wJUv3fA+ravQuu4IAGc9/5NdGzTgUsLGHjGHGb
         1QGRoVRKfoEoGTZX3ZLU1Ltx/sU5/FEsxUKBR17WJ38A0H+RztPSejLiuSKJSB3TULst
         l2Gg==
X-Gm-Message-State: APt69E10l9sFSvOEIOqNVKMg0M0BoeBT4Y+bgD5FQOooL8uQ3fyzPxvB
        kZi2tIlSZCuO8uttW45WE93TpNWW
X-Google-Smtp-Source: AAOMgpdl3ida1M2oI4AVUSdQVK4Lxzsebwfz+/itJd7g8nyKqNFAAy2nl7nzDR/kHFzGSve03awDJg==
X-Received: by 2002:a50:a93c:: with SMTP id l57-v6mr27618727edc.229.1531317431198;
        Wed, 11 Jul 2018 06:57:11 -0700 (PDT)
Received: from [192.168.1.4] (x4db0e292.dyn.telefonica.de. [77.176.226.146])
        by smtp.gmail.com with ESMTPSA id f3-v6sm5322209eds.92.2018.07.11.06.57.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 06:57:10 -0700 (PDT)
Subject: Re: [PATCH 3/6] staging: rtl8723bs: fix indentation
From:   Michael Straube <straube.linux@gmail.com>
To:     Joe Perches <joe@perches.com>, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20180708103855.12473-1-straube.linux@gmail.com>
 <20180708103855.12473-3-straube.linux@gmail.com>
 <194c5239a1ef9a1f472bad7c5bcc6e3b7675b0ec.camel@perches.com>
 <b7468cdd-1555-ef61-b475-3d4677aa423a@gmail.com>
Message-ID: <005bbcfc-402d-db85-8f5a-1b64cfe6b612@gmail.com>
Date:   Wed, 11 Jul 2018 15:57:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <b7468cdd-1555-ef61-b475-3d4677aa423a@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/18 19:36, Michael Straube wrote:
> On 07/08/18 18:46, Joe Perches wrote:
>> On Sun, 2018-07-08 at 12:38 +0200, Michael Straube wrote:
>>
>> uint rtw_is_cckratesonly_included(u8 *rate)
>> {
>>     while (*rate) {
>>         u8 r = *rate & 0x7f;
>>
>>         if (r != 2 && r != 4 && r != 11 && r != 22)
>>             return false;
>>         rate++;
>>     }
>>
>>     return true;
>> }
>>
> 
> The patch has been added to staging-testing already.
> I will send patches with your suggestions the next days.

Would it be preferred to declare the variable at the functions beginning,
or doesn't it matter regarding coding style?

uint rtw_is_cckratesonly_included(u8 *rate)
{
         u8 r;

         while (*rate) {
                 r = *rate & 0x7f;
         ...

Best,
Michael

