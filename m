Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54D7C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D59326B89
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="p8N9fUZc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D59326B89
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965652AbeFZNiy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 09:38:54 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:46504 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965108AbeFZNiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 09:38:52 -0400
Received: by mail-wr0-f170.google.com with SMTP id l14-v6so12242480wrq.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 06:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7dRVgX+D+YzRT8Eu6vm/4OkT6lsQA+ky7Rza9h5k484=;
        b=p8N9fUZc392h6QYU3rWhdF4OnmIuTg4CdXUbZSTSoVSOTa39sMP4ImeG5OZbjFi2Zs
         1XLHXOrVa67JhhMB7xAuZItx4xel76K4PyANx9cA/w7a2WqeKAS5E0TKtHrYtmjMQxzu
         bXg7P36ulIWNRdan1sXlqPY0p8l+GW5u+oAQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7dRVgX+D+YzRT8Eu6vm/4OkT6lsQA+ky7Rza9h5k484=;
        b=DcUO45p1CNm4mXx08dIKzlML+k6pkSJsetpDH5SCHQc5K4elZLNZoSWbmEsZt0JSll
         fksER3N9MVAjcNjgJEvjnZ9ZXMf8G8c+6fEfftCvbbIOSQ+PJRiqnyehf9qbuT90wfoU
         7TwtBJVqj/fGqVXKOBsXKP7GXFqTun0WUNpAcMS2QcFL+fi5iq1DqPT1vU8oMyh+ChR3
         TIKzCcqtcNhckil1PMVNS7LX7+M0S9N4xrubJguGg4OcA4hIoDb45flnaknArffnXfxb
         J1bOznvspri39F2NcfSpv9ksOFR80VKcOZCPtYhXV0s24YsVhtvWmIEVTz+HYU7hKeYn
         AZGA==
X-Gm-Message-State: APt69E1xW1v7Utp3qY50DMhlZSzfc0mfNFWlwoVcruTPF0pmFABctTik
        IRMpCqns0HZE9tAzXKgGhV0OX6wuGuc7m7QPyIbn0Q==
X-Google-Smtp-Source: AAOMgpfmHt+PP1dwp8CjpQNgmif+tA55B13Wot+D1oXSxPG44lFwSDSftt2JA1kkCQtvVwEUVvbfR5IrehmpgQ1JbVM=
X-Received: by 2002:adf:f181:: with SMTP id h1-v6mr1653873wro.214.1530020331562;
 Tue, 26 Jun 2018 06:38:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:8684:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 06:38:50
 -0700 (PDT)
In-Reply-To: <233d6808-4d44-9e47-7e3f-4f35cf731706@redhat.com>
References: <CAOf5uwmSeugMHBBFc8ZQKY=wEsVD-YwD=YSWi=XbysU58Gp=Ww@mail.gmail.com>
 <9fb661e6-482b-76e0-2af0-a62a70e5606d@redhat.com> <CAOf5uwk2cf_+27nk9i9MQmbfJ8LCfPYopkcX__9M64jMYmhu1A@mail.gmail.com>
 <CAOf5uwkEuDgAJ7e8rNFyiKpUZPA3NhQGREtOGsm1EVSofW3rzQ@mail.gmail.com> <233d6808-4d44-9e47-7e3f-4f35cf731706@redhat.com>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Tue, 26 Jun 2018 15:38:50 +0200
Message-ID: <CAOf5uwkJimhGJd_BtUuDyxaD5-ZYGe3JZtgC4pDKc_jnvaV21g@mail.gmail.com>
Subject: Re: simple-framebuffer enquire
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     artlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Tue, Jun 26, 2018 at 3:36 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
>
> On 26-06-18 15:29, Michael Nazzareno Trimarchi wrote:
>>
>> Hi
>>
>> to be more specific
>>
>> On Tue, Jun 26, 2018 at 3:06 PM, Michael Nazzareno Trimarchi
>> <michael@amarulasolutions.com> wrote:
>>>
>>> Hi
>>>
>>> On Tue., 26 Jun. 2018, 12:01 pm Hans de Goede, <hdegoede@redhat.com>
>>> wrote:
>>>>
>>>>
>>>> Hi,
>>>>
>>>> On 25-06-18 15:29, Michael Nazzareno Trimarchi wrote:
>>>>>
>>>>> Hi Hans
>>>>>
>>>>> In order to let it even registered the simplefb I have added this
>>>>> change. According on what I understand
>>>>> from the code seems that this is the way to acquire memory with the
>>>>> correct attribute
>>>>>
>>>>> diff --git a/drivers/video/fbdev/simplefb.c
>>>>> b/drivers/video/fbdev/simplefb.c
>>>>> index a3c44ec..7e61ce3 100644
>>>>> --- a/drivers/video/fbdev/simplefb.c
>>>>> +++ b/drivers/video/fbdev/simplefb.c
>>>>> @@ -466,8 +466,8 @@ static int simplefb_probe(struct platform_device
>>>>> *pdev)
>>>>>
>>>>>           info->fbops = &simplefb_ops;
>>>>>           info->flags = FBINFO_DEFAULT | FBINFO_MISC_FIRMWARE;
>>>>> -       info->screen_base = ioremap_wc(info->fix.smem_start,
>>>>> -                                      info->fix.smem_len);
>>>>> +       info->screen_base = arch_memremap_wb(info->fix.smem_start,
>>>>> +                                            info->fix.smem_len);
>>>>
>>>>
>>>> I'm not sure why you need this?  wb certainly is not optimal
>>>> for a framebuffer, the existing wc mapping is really what you
>>>> want.
>>>>
>>>
>>> Well in this way raise a WARN and get a nice NULL on memory remap on
>>> imx6ull
>>> SoC
>>>
>>
>> [    0.397484] WARNING: CPU: 0 PID: 1 at arch/arm/mm/ioremap.c:303
>> __arm_ioremap_pfn_caller+0x80/0x1cc
>
>
>
> This is causes by a mismatch in memory attributes, which means the
> memory is already mapped by the kernel as regular RAM and may
> already be used for other purposes by the kernel!
>
> Memory used by a simplefb framebuffer must be reserved by the
> bootloader, so that it does not get used by the kernel as regular
> RAM. See e.g.:
>
> http://git.denx.de/?p=u-boot.git;a=blob;f=drivers/video/sunxi/sunxi_display.c
>
> Near the end of the file where the framebuffer RAM gets excluded from
> the memory-range reported to the kernel as usable RAM. Note this relies
> on the u-boot sunxi video code putting the framebuffer at the end of the
> RAM.
>

Thank you very much for this lesson ;). I will try to document better
after my tour ;)

Michael

> Regards,
>
> Hans



-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
