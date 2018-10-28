Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3D4ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 08:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0616220843
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 08:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRNwATZk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0616220843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbeJ1RmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 13:42:01 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36039 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbeJ1RmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 13:42:00 -0400
Received: by mail-wm1-f65.google.com with SMTP id a8-v6so5052418wmf.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 01:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pOIRE+CaWXH2EDxLGxrirvTk6/hDOabgNALf4zKPJKE=;
        b=TRNwATZkvWu3udZlLJ8rshpJG+f8367rxW6Vocy+Gc33Sq40XRxn+DUYRszUqk2LFt
         /l6/s0QyNkvSBpLIKzmp5tYRJH01AUMvAceXjfvTim5Ln0EtPUQTfSPCVZmTc9A1yWbM
         tXeU0lzYC+wYVMYLL2BQ/cXkyzMFIYywru4hb4yab1NNDD57xICc9eOACqveq2031zpS
         tX4t44LJtBhGnV9ZlXP4S3N2sTbunhqIs/ALcQ4lpcVmLDjHiPQ/FWGwXoC+3vSoBtMF
         v5FaiNEdK1CwE1fjB2rNL0fex4v0YhghMBwTjcSJAxwOYVBOF1K2bYI/2HSLYi20Exti
         aKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pOIRE+CaWXH2EDxLGxrirvTk6/hDOabgNALf4zKPJKE=;
        b=b8cmuAixsdGbu0g+NhlY9NCgbg46/hUcCMdfULKrkSw7JiGgA8iD/hbToa3BsG8dcD
         /j2UaHqUGcLawvWgrE7yvJmlYtBuJ50LndpZVyR/04pZSmChbq6NTZzqhd8Sn1YwcsdV
         Wf9Qq023haXubdcm7NMX++lLH9Uj0+LzixDj1PY2xKLSqvlWhfSNv0s8Obb4rQkdQSTR
         yjF/WVDMmN3Xx/U3PQO7W/Ut3en01nUJhdxdMkbsgfqwcqsQUmXs/A7TT5fAbObAcVne
         p9MZzvn36/tqmXl+22AlkTDtYfnNlHjTvgVheU3XiXPY5Ke9oQPMFQe5/uVAgl/vhCDq
         J42A==
X-Gm-Message-State: AGRZ1gK7mM/GXZYkq3fHrhTZ4scWYu1IrPgJLPGHlN/iSLNZ+TQU5lme
        vA5ZdmN4rKRQFRr/37UFTyvWczMM
X-Google-Smtp-Source: AJdET5fOFAXmGolwdKHimIkuo8p1+nzVsjEzpp6jEP/dZLTiHw77Ioek3h2cwKOA+PyyTOIVG+1jsg==
X-Received: by 2002:a1c:7d8e:: with SMTP id y136-v6mr3043707wmc.140.1540717077330;
        Sun, 28 Oct 2018 01:57:57 -0700 (PDT)
Received: from ?IPv6:2a02:8108:85c0:57c8:bc68:3d44:305d:951f? ([2a02:8108:85c0:57c8:bc68:3d44:305d:951f])
        by smtp.gmail.com with ESMTPSA id c184-v6sm6595820wma.15.2018.10.28.01.57.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 01:57:56 -0700 (PDT)
Subject: Re: [PATCH 4/5] staging: rtl8188eu: change return type of
 rtw_hal_xmit()
To:     Joe Perches <joe@perches.com>, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20181027202850.25636-1-straube.linux@gmail.com>
 <20181027202850.25636-4-straube.linux@gmail.com>
 <bcb65c2930ae7efd78183f744059f2d29a743b88.camel@perches.com>
 <8fbc5be59d4d6d0216db2e9c47a74c45e709e1fd.camel@perches.com>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <eb1c3902-e282-2fe6-63dc-23795f2e2e6f@gmail.com>
Date:   Sun, 28 Oct 2018 09:57:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <8fbc5be59d4d6d0216db2e9c47a74c45e709e1fd.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/18 1:08 AM, Joe Perches wrote:
> On Sat, 2018-10-27 at 15:57 -0700, Joe Perches wrote:
>> On Sat, 2018-10-27 at 22:28 +0200, Michael Straube wrote:
>>> The function rtw_hal_xmit() returns true or false.
>>> Change the return type from s32 to bool.
>> []
>>> diff --git a/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
>> []
>>> @@ -598,7 +598,7 @@ bool rtl8188eu_xmitframe_complete(struct adapter *adapt,
>>>    *	true	dump packet directly
>>>    *	false	enqueue packet
>>>    */
>>> -s32 rtw_hal_xmit(struct adapter *adapt, struct xmit_frame *pxmitframe)
>>> +bool rtw_hal_xmit(struct adapter *adapt, struct xmit_frame *pxmitframe)
>>>   {
>>>   	s32 res;
>>
>> Does "s32 res" need changing to bool too?
> 
> Perhaps all the functions regardless of types
> with returns of only _SUCCESS and _FAIL could be
> converted to bool.
> 

"s32 res" is not used for return value, so it does not need changing to bool.
But it could be converted too.

I'll keep that, and converting functions only returning _SUCCESS and _FAIL to
bool, in mind for future patches. Thanks.

Perhaps _SUCCESS / _FAIL could be replaced with true / false throughout the
driver to get rid of the defines? Or is that a bad idea?

Regards,
Michael


