Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8228AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC4820652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbfAQQOx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:14:53 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:43775 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbfAQQOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:14:53 -0500
Received: from mail-pf1-f198.google.com ([209.85.210.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gkAJf-0004d9-A9
        for linux-kernel@vger.kernel.org; Thu, 17 Jan 2019 16:14:51 +0000
Received: by mail-pf1-f198.google.com with SMTP id d18so7729650pfe.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 08:14:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=oHQAHivtz+yEt62uqUOkyMqycTlzyMFNKyCXzcdRxYc=;
        b=ngVwJ56y1FX4KErsmmmD01f4DyxsHfExa4bAK/9i/TYcaBR8KDuiZZHgWMNvR41HcL
         7YPkGd/aA5VvCKDkpmU8ztWQ/cB0MN5wiIgAN7CR3B14LinZ0Axpclkgp+QU2mfIlbNr
         aNUh0LjNRtScpPqeRAHykpPRdLJQeaq9AxQ0NuM5wq/Y5c9ZBie2gAL+if7KRrPWtvdr
         pwKbMZ+r26LyFrc9lEEAGnDXqi4mExPwjpdDmtKddeXpjwNLx4ayAIDNaNUUXDiCs3ek
         1rPnI/Ilw8IXPnsGKdZp/OVR04POimZ2KPDcBnk+s9tf090cLIqNENSxqfe/8TadOd7b
         HD0A==
X-Gm-Message-State: AJcUukdniw2v1RfN+O6jG1waV7CYdn8u6+9azNdQ+mzfnDQIBCEJ3b3Y
        UM1Jge4RcvUirDtAlqhGOYhnd5iITip3RDyf0qLxHw9Rar75c4JZU7J8zJxWYwV7Sm7N2KXhfb7
        +Bm9GaPZx3qBjZziAPrtk0/NNKDaFSCkKAx8cx2U/7Q==
X-Received: by 2002:a62:2a4b:: with SMTP id q72mr15301676pfq.61.1547741689825;
        Thu, 17 Jan 2019 08:14:49 -0800 (PST)
X-Google-Smtp-Source: ALg8bN6KiUo3guoJFcIqp64sopYzqcjsLUQcvuZc0yu2jljeYGpjj5l0lPM1OMQGxCVpvlC2aIZelw==
X-Received: by 2002:a62:2a4b:: with SMTP id q72mr15301647pfq.61.1547741689416;
        Thu, 17 Jan 2019 08:14:49 -0800 (PST)
Received: from [192.168.1.215] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id f32sm2662993pgf.80.2019.01.17.08.14.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 08:14:48 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 1/1] Input: elantech: Use SMBus based on bus info
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <CAO-hwJKyBHM1Yy8=pQrbDoArTOX4=8G6f0jECv4x1mth+LZZDw@mail.gmail.com>
Date:   Fri, 18 Jan 2019 00:14:45 +0800
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        =?utf-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <0BD3A587-B7B6-4C99-8F87-187394FF6EFC@canonical.com>
References: <20190117092948.32079-1-kai.heng.feng@canonical.com>
 <CAO-hwJKyBHM1Yy8=pQrbDoArTOX4=8G6f0jECv4x1mth+LZZDw@mail.gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 17, 2019, at 10:42 PM, Benjamin Tissoires <benjamin.tissoires@redhat.com> wrote:
> 
> Hi Kai-Heng,
> 
> On Thu, Jan 17, 2019 at 10:30 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
>> 
>> There are some new HP laptops with Elantech touchpad don't support
>> multitouch.
>> 
>> Both ETP_BUS_SMB_HST_NTFY_ONLY and ETP_BUS_PS2_SMB_HST_NTFY devices can
>> use SMBus to support 5 fingers touch, so we need to chech them too.
>> 
>> So use elantech_use_host_notify() to do a more thouroughly check.
>> 
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> drivers/input/mouse/elantech.c | 58 +++++++++++++++++-----------------
>> 1 file changed, 29 insertions(+), 29 deletions(-)
>> 
>> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
>> index 9fe075c137dc..5bcf1c147eb1 100644
>> --- a/drivers/input/mouse/elantech.c
>> +++ b/drivers/input/mouse/elantech.c
>> @@ -1799,6 +1799,34 @@ static int elantech_create_smbus(struct psmouse *psmouse,
>>                                  leave_breadcrumbs);
>> }
>> 
>> +static bool elantech_use_host_notify(struct psmouse *psmouse,
>> +                                    struct elantech_device_info *info)
>> +{
>> +       if (ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version))
>> +               return true;
>> +
>> +       switch (info->bus) {
>> +       case ETP_BUS_PS2_ONLY:
>> +               /* expected case */
>> +               break;
>> +       case ETP_BUS_SMB_ALERT_ONLY:
>> +               /* fall-through  */
>> +       case ETP_BUS_PS2_SMB_ALERT:
>> +               psmouse_dbg(psmouse, "Ignoring SMBus provider through alert protocol.\n");
>> +               break;
>> +       case ETP_BUS_SMB_HST_NTFY_ONLY:
>> +               /* fall-through  */
>> +       case ETP_BUS_PS2_SMB_HST_NTFY:
>> +               return true;
>> +       default:
>> +               psmouse_dbg(psmouse,
>> +                           "Ignoring SMBus bus provider %d.\n",
>> +                           info->bus);
>> +       }
>> +
>> +       return false;
>> +}
>> +
>> /**
>>  * elantech_setup_smbus - called once the PS/2 devices are enumerated
>>  * and decides to instantiate a SMBus InterTouch device.
>> @@ -1818,7 +1846,7 @@ static int elantech_setup_smbus(struct psmouse *psmouse,
>>                 * i2c_blacklist_pnp_ids.
>>                 * Old ICs are up to the user to decide.
>>                 */
>> -               if (!ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version) ||
>> +               if (!elantech_use_host_notify(psmouse, info) ||
> 
> That was my initial approach of the series, but I ended up being more
> conservative as this would flip all of the existing elantech SMBUS
> capable touchpads to use elan_i2c.
> And I didn't want to deal with 4/5 year old laptops that suddenly broke.
> 
> So I wonder if you can restrict this default change to the recent
> laptops (let's say 2018+). Maybe by looking at their FW version or
> something else in the DMI?

It was KT who told me that I should use ETP_BUS_PS2_SMB_HST_NTFY.

As for date, KT still knows better than me.

KT, 
Can you name a year which is safe enough to enable SMBus?

Kai-Heng

> 
> Cheers,
> Benjamin
> 
>>                    psmouse_matches_pnp_id(psmouse, i2c_blacklist_pnp_ids))
>>                        return -ENXIO;
>>        }
>> @@ -1838,34 +1866,6 @@ static int elantech_setup_smbus(struct psmouse *psmouse,
>>        return 0;
>> }
>> 
>> -static bool elantech_use_host_notify(struct psmouse *psmouse,
>> -                                    struct elantech_device_info *info)
>> -{
>> -       if (ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version))
>> -               return true;
>> -
>> -       switch (info->bus) {
>> -       case ETP_BUS_PS2_ONLY:
>> -               /* expected case */
>> -               break;
>> -       case ETP_BUS_SMB_ALERT_ONLY:
>> -               /* fall-through  */
>> -       case ETP_BUS_PS2_SMB_ALERT:
>> -               psmouse_dbg(psmouse, "Ignoring SMBus provider through alert protocol.\n");
>> -               break;
>> -       case ETP_BUS_SMB_HST_NTFY_ONLY:
>> -               /* fall-through  */
>> -       case ETP_BUS_PS2_SMB_HST_NTFY:
>> -               return true;
>> -       default:
>> -               psmouse_dbg(psmouse,
>> -                           "Ignoring SMBus bus provider %d.\n",
>> -                           info->bus);
>> -       }
>> -
>> -       return false;
>> -}
>> -
>> int elantech_init_smbus(struct psmouse *psmouse)
>> {
>>        struct elantech_device_info info;
>> --
>> 2.17.1

