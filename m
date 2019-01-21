Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991B1C282DC
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 672D520823
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbfAUHZN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:25:13 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55309 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbfAUHZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:25:11 -0500
Received: from mail-pg1-f199.google.com ([209.85.215.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1glRCM-0002i8-GV
        for linux-kernel@vger.kernel.org; Mon, 21 Jan 2019 04:28:34 +0000
Received: by mail-pg1-f199.google.com with SMTP id o17so13315171pgi.14
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jan 2019 20:28:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=H5lPUvXTlP7hBaaZ2bwL+Hl8MC2tx+ca9yRnlRPJQPc=;
        b=SVCKMvRkFyT7E1xyWOkvQ3quXLxpemie3Lg8DZpgEvOP975d2qw94diwmDMeNmAIkC
         uSKfVmwnUMeB6jH5w0zX/e+lPQo1aRs7/rqw7Ff3EknUbLSk0m/Har/i8yBZRWfel0sP
         UGNsRHpJoH4aH3BuGLCmToGMA+tXiARBkg1qEvCYa1zTjTeQMZR81MhzAHeZp0j2JZ9q
         pK9g9z+xWIRmR+F2VqeCo9ECZTjfRPIV27W9TqZHV6v6Ug6u6p8uU84rpqcKWFp96Hi1
         zCEnO1rKctYu+YlmaWOauI6YqdeZL7btRZDmRBjZDqvwXrmNnPfWF/OcIiso4UXKneU7
         yMnQ==
X-Gm-Message-State: AJcUukelBpiBb79MMVgIeIyrFV3TUG4bnutz9Rwr21Qp7ABNOYKdPkje
        fzFwKgefLPb5gqILnWlWu3lTrY1zl4LE9rrGfoirojNjb8JMZk+AE1Fw9WwCT0qwisvB02j7IhT
        Dqhbxne/siAssUiF8m8tHvqzLB4dwk4cb3Yxtjh8ZSw==
X-Received: by 2002:a63:ec4b:: with SMTP id r11mr26250813pgj.44.1548044912989;
        Sun, 20 Jan 2019 20:28:32 -0800 (PST)
X-Google-Smtp-Source: ALg8bN7w7EV0E49DGg0rGmcylsoyNldI5EbkM7g0V8RouxETl1UI1VenP9gPTtpOsK9519xAvc15zg==
X-Received: by 2002:a63:ec4b:: with SMTP id r11mr26250798pgj.44.1548044912665;
        Sun, 20 Jan 2019 20:28:32 -0800 (PST)
Received: from 2001-b011-380f-13aa-3031-6e36-b157-234b.dynamic-ip6.hinet.net (2001-b011-380f-13aa-3031-6e36-b157-234b.dynamic-ip6.hinet.net. [2001:b011:380f:13aa:3031:6e36:b157:234b])
        by smtp.gmail.com with ESMTPSA id l11sm14761427pff.65.2019.01.20.20.28.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Jan 2019 20:28:32 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 1/1] Input: elantech: Use SMBus based on bus info
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <008c01d4af10$5b157f20$11407d60$@emc.com.tw>
Date:   Mon, 21 Jan 2019 12:28:29 +0800
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <11585D81-F3E5-4924-A010-4B6A11919216@canonical.com>
References: <20190117092948.32079-1-kai.heng.feng@canonical.com>
 <CAO-hwJKyBHM1Yy8=pQrbDoArTOX4=8G6f0jECv4x1mth+LZZDw@mail.gmail.com>
 <0BD3A587-B7B6-4C99-8F87-187394FF6EFC@canonical.com>
 <008c01d4af10$5b157f20$11407d60$@emc.com.tw>
To:     =?utf-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 18, 2019, at 17:29, 廖崇榮 <kt.liao@emc.com.tw> wrote:
> 
> 
> 
> -----Original Message-----
> From: Kai Heng Feng [mailto:kai.heng.feng@canonical.com] 
> Sent: Friday, January 18, 2019 12:15 AM
> To: Benjamin Tissoires
> Cc: Dmitry Torokhov; 廖崇榮; open list:HID CORE LAYER; lkml
> Subject: Re: [PATCH 1/1] Input: elantech: Use SMBus based on bus info
> 
> 
> 
>> On Jan 17, 2019, at 10:42 PM, Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
>> 
>> Hi Kai-Heng,
>> 
>> On Thu, Jan 17, 2019 at 10:30 AM Kai-Heng Feng 
>> <kai.heng.feng@canonical.com> wrote:
>>> 
>>> There are some new HP laptops with Elantech touchpad don't support 
>>> multitouch.
>>> 
>>> Both ETP_BUS_SMB_HST_NTFY_ONLY and ETP_BUS_PS2_SMB_HST_NTFY devices 
>>> can use SMBus to support 5 fingers touch, so we need to chech them too.
>>> 
>>> So use elantech_use_host_notify() to do a more thouroughly check.
>>> 
>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>> ---
>>> drivers/input/mouse/elantech.c | 58 
>>> +++++++++++++++++-----------------
>>> 1 file changed, 29 insertions(+), 29 deletions(-)
>>> 
>>> diff --git a/drivers/input/mouse/elantech.c 
>>> b/drivers/input/mouse/elantech.c index 9fe075c137dc..5bcf1c147eb1 
>>> 100644
>>> --- a/drivers/input/mouse/elantech.c
>>> +++ b/drivers/input/mouse/elantech.c
>>> @@ -1799,6 +1799,34 @@ static int elantech_create_smbus(struct psmouse
> *psmouse,
>>>                                 leave_breadcrumbs); }
>>> 
>>> +static bool elantech_use_host_notify(struct psmouse *psmouse,
>>> +                                    struct elantech_device_info 
>>> +*info) {
>>> +       if (ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version))
>>> +               return true;
>>> +
>>> +       switch (info->bus) {
>>> +       case ETP_BUS_PS2_ONLY:
>>> +               /* expected case */
>>> +               break;
>>> +       case ETP_BUS_SMB_ALERT_ONLY:
>>> +               /* fall-through  */
>>> +       case ETP_BUS_PS2_SMB_ALERT:
>>> +               psmouse_dbg(psmouse, "Ignoring SMBus provider through
> alert protocol.\n");
>>> +               break;
>>> +       case ETP_BUS_SMB_HST_NTFY_ONLY:
>>> +               /* fall-through  */
>>> +       case ETP_BUS_PS2_SMB_HST_NTFY:
>>> +               return true;
>>> +       default:
>>> +               psmouse_dbg(psmouse,
>>> +                           "Ignoring SMBus bus provider %d.\n",
>>> +                           info->bus);
>>> +       }
>>> +
>>> +       return false;
>>> +}
>>> +
>>> /**
>>> * elantech_setup_smbus - called once the PS/2 devices are enumerated
>>> * and decides to instantiate a SMBus InterTouch device.
>>> @@ -1818,7 +1846,7 @@ static int elantech_setup_smbus(struct psmouse
> *psmouse,
>>>                * i2c_blacklist_pnp_ids.
>>>                * Old ICs are up to the user to decide.
>>>                */
>>> -               if (!ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version) ||
>>> +               if (!elantech_use_host_notify(psmouse, info) ||
>> 
>> That was my initial approach of the series, but I ended up being more 
>> conservative as this would flip all of the existing elantech SMBUS 
>> capable touchpads to use elan_i2c.
>> And I didn't want to deal with 4/5 year old laptops that suddenly broke.
>> 
>> So I wonder if you can restrict this default change to the recent 
>> laptops (let's say 2018+). Maybe by looking at their FW version or 
>> something else in the DMI?
> 
> It was KT who told me that I should use ETP_BUS_PS2_SMB_HST_NTFY.
> 
> As for date, KT still knows better than me.
> 
> KT,
> Can you name a year which is safe enough to enable SMBus?
> 
> I have discussed it internally. 
> The internal rule for FW's SMbus implementation is stable after 2018
> If you meet some special case, please let me know.

Thanks for the info. I’ll use this for the V2 patch.

> 
> BTW, The SMbus supporting is requested by HP this time, and there are plenty
> of HP laptop use old IC
> which doesn't meet " ETP_NEW_IC_SMBUS_HOST_NOTIFY”.

One more question, does ETP_BUS_SMB_HST_NTFY_ONLY means
it should stick to SMBus, because it doesn’t support PS/2?

I’d like to merge all checks into elantech_use_host_notify() but
ETP_BUS_SMB_HST_NTFY_ONLY caught my attention.

Kai-Heng

> 
> Elan touchpad works well in PS/2 for HP, because it don't support
> TrackPoint.
> You may let old HP platform work as PS/2 for safety.
> 
> Thanks
> KT
> 
> Kai-Heng
> 
>> 
>> Cheers,
>> Benjamin
>> 
>>>                   psmouse_matches_pnp_id(psmouse,
> i2c_blacklist_pnp_ids))
>>>                       return -ENXIO;
>>>       }
>>> @@ -1838,34 +1866,6 @@ static int elantech_setup_smbus(struct psmouse
> *psmouse,
>>>       return 0;
>>> }
>>> 
>>> -static bool elantech_use_host_notify(struct psmouse *psmouse,
>>> -                                    struct elantech_device_info *info)
>>> -{
>>> -       if (ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version))
>>> -               return true;
>>> -
>>> -       switch (info->bus) {
>>> -       case ETP_BUS_PS2_ONLY:
>>> -               /* expected case */
>>> -               break;
>>> -       case ETP_BUS_SMB_ALERT_ONLY:
>>> -               /* fall-through  */
>>> -       case ETP_BUS_PS2_SMB_ALERT:
>>> -               psmouse_dbg(psmouse, "Ignoring SMBus provider through
> alert protocol.\n");
>>> -               break;
>>> -       case ETP_BUS_SMB_HST_NTFY_ONLY:
>>> -               /* fall-through  */
>>> -       case ETP_BUS_PS2_SMB_HST_NTFY:
>>> -               return true;
>>> -       default:
>>> -               psmouse_dbg(psmouse,
>>> -                           "Ignoring SMBus bus provider %d.\n",
>>> -                           info->bus);
>>> -       }
>>> -
>>> -       return false;
>>> -}
>>> -
>>> int elantech_init_smbus(struct psmouse *psmouse) {
>>>       struct elantech_device_info info;
>>> --
>>> 2.17.1
> 

