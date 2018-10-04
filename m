Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B85C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3892020652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pYA+H5A+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3892020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbeJDWsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 18:48:16 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39581 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbeJDWsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 18:48:16 -0400
Received: by mail-wm1-f65.google.com with SMTP id q8-v6so9539570wmq.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 08:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YQNqJyo22cJiLb3h/AkBgmQKPtaWnQd8Whczc9WQTiw=;
        b=pYA+H5A+vfPDRsB/kdB9rduGR0fHF3wlzRAFS59yawgJv0jaaBFiAHajH9yVkIlvIu
         viOZOCvJizyEWzm1dTusPbpVFv0w2/xHwVvbLoichYLbpSXjsqo8gVLeg58ObUWM1E7U
         ziRXK/i6MtPtddFTz/jSVW9zIHpVjq+iOOsUee99YLF/zMfwMCumdxhFNz+Jyu8x3BM4
         PXTabIOHUCbICTBpUBORxaydWdrmgQTvna4NKaeLMHu6OI9S0PR98tum2HJ779IFKd3N
         huetFGDyxk4Gos5OwWeQnR+Z7HQR9pnWXjI6pA74HH8WmYNPRilkdC3vw82CAuDsS12I
         1TMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YQNqJyo22cJiLb3h/AkBgmQKPtaWnQd8Whczc9WQTiw=;
        b=onSi9Z5z7r5EYrTJWYOzAktUx7mVpfl6PhsOGmicXCCKwu53qZ6FjXFFGfUuYETUVL
         x+gx6nZyaHFOLEkA8ll0xHcC6LapoU41QvFadjM3MPMHhVVuGIW6ShYq31aYv24I2cCD
         ZmbkJftgMHv3fODlpCpkOh4E30cYLtGFCfh9ou5e2G5MpnTfxU+0LLVYsHQYlA13u20k
         8Rj/ttu0dzcFMN5D9lPNiXSDX48NEqMQCkrUjR7cxmAcR1WGbdNT7ZvheemCpSL/uFU1
         5uIEKb3xtM0FCsTDQ1dDGgKIuJ2kad9vCM8QSk0DIq6g6bTxZqvAMb9iImkJSQLnKPvz
         lvDg==
X-Gm-Message-State: ABuFfogEHcpUqrat1U4ScnCePbiCBwbWKZPfsZSOopvNQxmRNinR1uv3
        qsDWh6bpeF9yvN+VivB09JV2Tzxj
X-Google-Smtp-Source: ACcGV62VgKcMClSL5D36YpaO5Fiw8/fZnAcW/Zb1mYkj95FZ2Yx84CqaDW0A/MBgjM+9ihaIJMpp3Q==
X-Received: by 2002:a1c:ae08:: with SMTP id x8-v6mr5002943wme.86.1538668461826;
        Thu, 04 Oct 2018 08:54:21 -0700 (PDT)
Received: from [192.168.0.19] (ip1f12fa7d.dynamic.kabel-deutschland.de. [31.18.250.125])
        by smtp.gmail.com with ESMTPSA id z4-v6sm5219424wrt.13.2018.10.04.08.54.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 08:54:21 -0700 (PDT)
Subject: Re: [PATCH 1/3] staging: rtl8188eu: fix line over 80 characters -
 style
To:     Joe Perches <joe@perches.com>, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20181003204359.30676-1-straube.linux@gmail.com>
 <a32b932c97fcc110c25a4ff5b809174cb29a0b69.camel@perches.com>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <539f9487-e973-87cb-5a97-b5874349f70e@gmail.com>
Date:   Thu, 4 Oct 2018 17:54:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <a32b932c97fcc110c25a4ff5b809174cb29a0b69.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 03.10.18 um 23:26 schrieb Joe Perches:
> On Wed, 2018-10-03 at 22:43 +0200, Michael Straube wrote:
>> Line break array declaration to clear a 'line over 80 characters'
>> checkpatch warning. For consistency replace 0x0 with 0x00.
> []
>> diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
> []
>> @@ -39,7 +39,10 @@ extern unsigned char REALTEK_96B_IE[];
>>   /********************************************************
>>   MCS rate definitions
>>   *********************************************************/
>> -unsigned char	MCS_rate_1R[16] = {0xff, 0x00, 0x0, 0x0, 0x01, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0};
>> +unsigned char MCS_rate_1R[16] = {
>> +	0xff, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00,
>> +	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
>> +};
> 
> Might as well make this const u8.
> 
> Here and as well the extern declarations in
> 	drivers/staging/rtl8188eu/core/rtw_mlme.c
> and
> 	drivers/staging/rtl8188eu/include/rtw_mlme.h
> 
> 

I'll send a patch with your suggestions.
Thanks.

Michael
