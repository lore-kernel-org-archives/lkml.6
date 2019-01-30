Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291A4C282CD
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 03:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F35F320989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 03:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730029AbfA3DvD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 22:51:03 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:37885 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbfA3DvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 22:51:02 -0500
Received: from mail-pg1-f197.google.com ([209.85.215.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gogtw-0006pS-PK
        for linux-kernel@vger.kernel.org; Wed, 30 Jan 2019 03:51:00 +0000
Received: by mail-pg1-f197.google.com with SMTP id t26so15372720pgu.18
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 19:51:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OmX4Q8kQnp/4hlpg1XSzN/PgwQxVbLHiicVLPXC/DCs=;
        b=W+QZx96f/HBSzS7w8PtZGgu0wA4HjsYJhdeJauM/S3lbpcryFm3NO7UB52bL7D1zkN
         g9lPMgpPiXKUB1yM/4rq58dC0SD0+SNPnKt2zDjgcr6fHfbVpahzHFYYqaejhvZfIcWB
         /++W555ppE6fFNnfmu0O+ffwv6itN6tt+CnelayVXC8rJQBomzFuYELXoSV/2+Tjn4Wh
         J2NipWy6hN8AUkbmzCdABOsk38IecVU5cj/zqAU0AGSsPSQoABNQczY+0mrbCuWJYQ27
         RkPramGivu4sorG9VoCikvuO246KS59bAisP7RbIHNq+my0wv4LCqbqrA7rL8i/jm6S7
         d4FQ==
X-Gm-Message-State: AJcUukeWV2gLiYLZObIunrT987aJmsqZCFufRfn5lic2hcoO7r9cFWTW
        +9nNtEKfSpAzCiYto58dgzkqBMmhq1kmAwxAR6sq2l2IaQt/8blyCMOHsmtfNeHtPRWSEpCCLZh
        LceyMpNbHCExOJr3ETUMxbUJjVPnd/fYHTtLBDE86Hg==
X-Received: by 2002:a17:902:4324:: with SMTP id i33mr28112442pld.227.1548820259371;
        Tue, 29 Jan 2019 19:50:59 -0800 (PST)
X-Google-Smtp-Source: ALg8bN7oOghCSA85mGzLNb8kzZqhHGc6TTG1k7EZPfgGwLiXO09uHQdbfdx4fDTfHltzG+HN5ROQUA==
X-Received: by 2002:a17:902:4324:: with SMTP id i33mr28112424pld.227.1548820258979;
        Tue, 29 Jan 2019 19:50:58 -0800 (PST)
Received: from 2001-b400-e205-c972-6472-e768-5e5c-66cb.emome-ip6.hinet.net (2001-b400-e205-c972-6472-e768-5e5c-66cb.emome-ip6.hinet.net. [2001:b400:e205:c972:6472:e768:5e5c:66cb])
        by smtp.gmail.com with ESMTPSA id a4sm271510pgv.70.2019.01.29.19.50.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 19:50:58 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v3] HID: i2c-hid: Ignore input report if there's no data
 present on Elan touchpanels
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <CAO-hwJ+CF-obuUK9T=x0ggJRLBNmM3H6-FfKjv2y0LT96C=TUg@mail.gmail.com>
Date:   Wed, 30 Jan 2019 11:50:54 +0800
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <D83049E7-8AE2-4C80-B160-5F35BB8170EE@canonical.com>
References: <20190107072429.23828-1-kai.heng.feng@canonical.com>
 <CAO-hwJKo=EaPoXJLGUvjq3QRng1V1NkO7A5zYGojbPyxxyJYHA@mail.gmail.com>
 <D7C6B90F-641A-495B-9E05-78BF4F56B552@canonical.com>
 <CAO-hwJ+CF-obuUK9T=x0ggJRLBNmM3H6-FfKjv2y0LT96C=TUg@mail.gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 29, 2019, at 18:05, Benjamin Tissoires <benjamin.tissoires@redhat.com> wrote:
> 
> On Mon, Jan 21, 2019 at 4:30 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
>> 
>> 
>> 
>>> On Jan 18, 2019, at 23:50, Benjamin Tissoires <benjamin.tissoires@redhat.com> wrote:
>>> 
>>> Hi Kai-Heng,
>>> 
>>> On Mon, Jan 7, 2019 at 8:24 AM Kai-Heng Feng
>>> <kai.heng.feng@canonical.com> wrote:
>>>> 
>>>> While using Elan touchpads, the message floods:
>>>> [  136.138487] i2c_hid i2c-DELL08D6:00: i2c_hid_get_input: incomplete report (14/65535)
>>>> 
>>>> Though the message flood is annoying, the device it self works without
>>>> any issue. I suspect that the device in question takes too much time to
>>>> pull the IRQ back to high after I2C host has done reading its data.
>>>> 
>>>> Since the host receives all useful data, let's ignore the input report
>>>> when there's no data.
>>>> 
>>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>> 
>>> Thanks for the v3.
>>> 
>>> This patch has just been brought to my attention, and I have one
>>> question before applying it:
>>> are those messages (without your patch) occurring all the time, or
>>> just after resume?
>> 
>> All the time.
>> 
>> The touchpad works fine though. The entire report is 0xff, so it can be
>> safely ignored.
> 
> Couple of things:
> - I have forgotten to tell you that I have applied this patch in
> for-5.1/i2c-hid, it will be pushed to linux-next today.

Thanks!

> - Dell told me that a BIOS fix was solving the issue. We can still
> quarry the patch, but there should not be a strong need for it when
> users upgrade their BIOS.

Multiple platforms are affected by this issue [1], so the patch can still be really helpful.

[1] https://bugs.launchpad.net/bugs/1784152

Kai-Heng

> 
> Cheers,
> Benjamin
> 
>> 
>>> 
>>> I wonder if the pm_suspend delay we talked about in the other thread
>>> would fix that issue in a cleaner way.
>> 
>> I’ve replied in another thread, unfortunately it can’t.
>> 
>> We can introduce msleep() between each commands though, but I don’t
>> think it’s good either.
>> 
>> Kai-Heng
>> 
>>> 
>>> Cheers,
>>> Benjamin
>>> 
>>>> ---
>>>> v3:
>>>> Fix compiler error/warnings.
>>>> 
>>>> v2:
>>>> Use dev_warn_once() to warn the user about the situation.
>>>> 
>>>> drivers/hid/i2c-hid/i2c-hid-core.c | 9 +++++++++
>>>> 1 file changed, 9 insertions(+)
>>>> 
>>>> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
>>>> index 8555ce7e737b..2f940c1de616 100644
>>>> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
>>>> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
>>>> @@ -50,6 +50,7 @@
>>>> #define I2C_HID_QUIRK_NO_IRQ_AFTER_RESET       BIT(1)
>>>> #define I2C_HID_QUIRK_NO_RUNTIME_PM            BIT(2)
>>>> #define I2C_HID_QUIRK_DELAY_AFTER_SLEEP                BIT(3)
>>>> +#define I2C_HID_QUIRK_BOGUS_IRQ                        BIT(4)
>>>> 
>>>> /* flags */
>>>> #define I2C_HID_STARTED                0
>>>> @@ -179,6 +180,8 @@ static const struct i2c_hid_quirks {
>>>>               I2C_HID_QUIRK_DELAY_AFTER_SLEEP },
>>>>       { USB_VENDOR_ID_LG, I2C_DEVICE_ID_LG_8001,
>>>>               I2C_HID_QUIRK_NO_RUNTIME_PM },
>>>> +       { USB_VENDOR_ID_ELAN, HID_ANY_ID,
>>>> +                I2C_HID_QUIRK_BOGUS_IRQ },
>>>>       { 0, 0 }
>>>> };
>>>> 
>>>> @@ -503,6 +506,12 @@ static void i2c_hid_get_input(struct i2c_hid *ihid)
>>>>               return;
>>>>       }
>>>> 
>>>> +       if (ihid->quirks & I2C_HID_QUIRK_BOGUS_IRQ && ret_size == 0xffff) {
>>>> +               dev_warn_once(&ihid->client->dev, "%s: IRQ triggered but "
>>>> +                             "there's no data\n", __func__);
>>>> +               return;
>>>> +       }
>>>> +
>>>>       if ((ret_size > size) || (ret_size < 2)) {
>>>>               dev_err(&ihid->client->dev, "%s: incomplete report (%d/%d)\n",
>>>>                       __func__, size, ret_size);
>>>> --
>>>> 2.17.1

