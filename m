Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD2DC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3491626AE7
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3491626AE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935732AbeFZNgd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 09:36:33 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39876 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934583AbeFZNgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 09:36:32 -0400
Received: by mail-ed1-f66.google.com with SMTP id w14-v6so1014377eds.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 06:36:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zv2Gnj5MM3N4KJAlXi63QYIHZ1k+lWfFKCBz6HuB8KY=;
        b=oaAJnFfMf49HKhQ7F0aG7fiAWm3wGa7RFlkgDcZ9f/UWd3jJS6tT7CoDzhM2SZbCbo
         gZRVxZXAwOQHtvSMb1d5R4s7/DXKQsD5LuqYWIdSmT3Hs+o5RCFcG+mEVzcsPp2NZgXE
         EF/XUhpcOEXeR7bB269lBUcDIttd/RBRyGAttyE/mOZy/hEvq5b+w95+xWbXVfK4lTTz
         zybjpxNfJyfeomAva4thv7jo6/aSxPQWiWM64TL4KA+ehy+pTcw2YxoliQEvDz1OhXuC
         +o3DWyi26Bh/XASTFhVX7e+S59Yee4N1xfu4O+r77OEhdbXAkSEOnrKk8ElpQg3+v4IY
         23jw==
X-Gm-Message-State: APt69E07retm5y9Og3BtCVsvePhKSmE9JiJW3CMvUd6KzE8TGPQ0jTUh
        F5KZxRaQOUb7iLxwSZAyaQDSi5x5eRM=
X-Google-Smtp-Source: AAOMgpcK7h7J0WB9qSO7IyhItqZs2pFWx4alMmaX5etD2o3GLfFfA+lCvJsqHjs/tDH7dk35ssuMNQ==
X-Received: by 2002:a50:9eac:: with SMTP id a41-v6mr1892191edf.92.1530020190583;
        Tue, 26 Jun 2018 06:36:30 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id a32-v6sm867389edd.54.2018.06.26.06.36.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 06:36:29 -0700 (PDT)
Subject: Re: simple-framebuffer enquire
To:     Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc:     artlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <CAOf5uwmSeugMHBBFc8ZQKY=wEsVD-YwD=YSWi=XbysU58Gp=Ww@mail.gmail.com>
 <9fb661e6-482b-76e0-2af0-a62a70e5606d@redhat.com>
 <CAOf5uwk2cf_+27nk9i9MQmbfJ8LCfPYopkcX__9M64jMYmhu1A@mail.gmail.com>
 <CAOf5uwkEuDgAJ7e8rNFyiKpUZPA3NhQGREtOGsm1EVSofW3rzQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <233d6808-4d44-9e47-7e3f-4f35cf731706@redhat.com>
Date:   Tue, 26 Jun 2018 15:36:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAOf5uwkEuDgAJ7e8rNFyiKpUZPA3NhQGREtOGsm1EVSofW3rzQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26-06-18 15:29, Michael Nazzareno Trimarchi wrote:
> Hi
> 
> to be more specific
> 
> On Tue, Jun 26, 2018 at 3:06 PM, Michael Nazzareno Trimarchi
> <michael@amarulasolutions.com> wrote:
>> Hi
>>
>> On Tue., 26 Jun. 2018, 12:01 pm Hans de Goede, <hdegoede@redhat.com> wrote:
>>>
>>> Hi,
>>>
>>> On 25-06-18 15:29, Michael Nazzareno Trimarchi wrote:
>>>> Hi Hans
>>>>
>>>> In order to let it even registered the simplefb I have added this
>>>> change. According on what I understand
>>>> from the code seems that this is the way to acquire memory with the
>>>> correct attribute
>>>>
>>>> diff --git a/drivers/video/fbdev/simplefb.c
>>>> b/drivers/video/fbdev/simplefb.c
>>>> index a3c44ec..7e61ce3 100644
>>>> --- a/drivers/video/fbdev/simplefb.c
>>>> +++ b/drivers/video/fbdev/simplefb.c
>>>> @@ -466,8 +466,8 @@ static int simplefb_probe(struct platform_device
>>>> *pdev)
>>>>
>>>>           info->fbops = &simplefb_ops;
>>>>           info->flags = FBINFO_DEFAULT | FBINFO_MISC_FIRMWARE;
>>>> -       info->screen_base = ioremap_wc(info->fix.smem_start,
>>>> -                                      info->fix.smem_len);
>>>> +       info->screen_base = arch_memremap_wb(info->fix.smem_start,
>>>> +                                            info->fix.smem_len);
>>>
>>> I'm not sure why you need this?  wb certainly is not optimal
>>> for a framebuffer, the existing wc mapping is really what you
>>> want.
>>>
>>
>> Well in this way raise a WARN and get a nice NULL on memory remap on imx6ull
>> SoC
>>
> 
> [    0.397484] WARNING: CPU: 0 PID: 1 at arch/arm/mm/ioremap.c:303
> __arm_ioremap_pfn_caller+0x80/0x1cc


This is causes by a mismatch in memory attributes, which means the
memory is already mapped by the kernel as regular RAM and may
already be used for other purposes by the kernel!

Memory used by a simplefb framebuffer must be reserved by the
bootloader, so that it does not get used by the kernel as regular
RAM. See e.g.:

http://git.denx.de/?p=u-boot.git;a=blob;f=drivers/video/sunxi/sunxi_display.c

Near the end of the file where the framebuffer RAM gets excluded from
the memory-range reported to the kernel as usable RAM. Note this relies
on the u-boot sunxi video code putting the framebuffer at the end of the
RAM.

Regards,

Hans
