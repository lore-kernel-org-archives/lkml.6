Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE809C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7A0920869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:41:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7A0920869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbeJPQbD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 12:31:03 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57959 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbeJPQbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 12:31:03 -0400
Received: from mail-pf1-f199.google.com ([209.85.210.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gCKv7-0004DN-JS
        for linux-kernel@vger.kernel.org; Tue, 16 Oct 2018 08:41:41 +0000
Received: by mail-pf1-f199.google.com with SMTP id 87-v6so22572540pfq.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 01:41:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=G9JSyH4qZVAFDWWUTzZGZRoFp+fvZMsvXK6KwRxR/kk=;
        b=G9kg7r0QdrcSKBPPmduUKB3TtUbgVZUbyNGJyNeyllro6JRlJ2B8TV1z/kDqUdo2Xk
         M4mpf9Fs8+umnkCFnyjF5Y8QxrKFtfkAdCTNNhp1NIbAzTMJiUbYUu6fzotgl7VWyqSF
         ISHkYwEUl0hFUQPXs80uUBuqlnxXfQ13XIMg9HMJvdLnAgzLN2LaxL3M2QpJTHqeg8Qj
         subyzkb5ykj5gPZ5vAgHm/ZEgt7XkbM4H7cSPHsXVh5IRc7O34Hl71aCeqjo9maFh2U9
         YnE8oj0+LXl8rAEhwceeqYz1g56eGk2NtpR+b7CuGpChTF8RXTVtleCcjt0S1b9sVQKN
         qbMw==
X-Gm-Message-State: ABuFfojeW42Qz8FN+IQs+zf7cD/BInyDSPLauGOu309a46zz7DBWed6Z
        5czojILGaFVVS59/57i7CDoKSUkZAg3phGkxoeHagwxrzbZwJmEnHgBePYpeu1hein6LDeaJJoX
        eC1ShNgEO1n+qxDgDay8wrTC/gN7hFPOZwNXYAtc8MA==
X-Received: by 2002:a62:fc13:: with SMTP id e19-v6mr21374591pfh.101.1539679300187;
        Tue, 16 Oct 2018 01:41:40 -0700 (PDT)
X-Google-Smtp-Source: ACcGV60joAWDKcb7kGnMX1uoq1pVP8/F1aC3TlfomVbGhCzIdg9LB8BUVygnHSrRKMNFffR6bYCrLg==
X-Received: by 2002:a62:fc13:: with SMTP id e19-v6mr21374571pfh.101.1539679299831;
        Tue, 16 Oct 2018 01:41:39 -0700 (PDT)
Received: from 2001-b011-380f-17e9-687d-9aa5-a32c-0681.dynamic-ip6.hinet.net (2001-b011-380f-17e9-687d-9aa5-a32c-0681.dynamic-ip6.hinet.net. [2001:b011:380f:17e9:687d:9aa5:a32c:681])
        by smtp.gmail.com with ESMTPSA id 84-v6sm21577350pfs.108.2018.10.16.01.41.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 01:41:39 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH v2] HID: i2c-hid: Add a small delay after sleep command
 for Raydium touchpanel
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <CAO-hwJJACzB4MmPxeyT1ERLyifeC06tg_DU+1PZwOruBf-42TQ@mail.gmail.com>
Date:   Tue, 16 Oct 2018 16:41:36 +0800
Cc:     Jiri Kosina <jikos@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <742ABBBD-BA86-47CB-B8D2-36CB2979F5F3@canonical.com>
References: <20181005044629.26286-1-kai.heng.feng@canonical.com>
 <CAO-hwJJACzB4MmPxeyT1ERLyifeC06tg_DU+1PZwOruBf-42TQ@mail.gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 15, 2018, at 16:04, Benjamin Tissoires <benjamin.tissoires@redhat.com> wrote:
> 
> On Fri, Oct 5, 2018 at 6:46 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
>> 
>> Raydium touchpanel (2386:4B33) sometimes does not work in desktop session
>> although it works in display manager.
>> 
>> During user logging, the display manager exits, close the HID device,
>> then the device gets runtime suspended and powered off. The desktop
>> session begins shortly after, opens the HID device, then the device gets
>> runtime resumed and powered on.
>> 
>> If the trasition from display manager to desktop sesesion is fast, the
>> touchpanel cannot switch from powered off to powered on in short
>> timeframe. So add a small delay to workaround the issue.
>> 
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> v2:
>> - Use quirk to only match affected touchpanel
>> - Only delay the next power on if the time hasn't elapsed
> 
> Hi,
> 
> I like the patch much better. And I even would be tempted to have this
> unconditionally enabled now that the general path doesn't have the
> msleep in the middle.
> 
> So how about we merge this patch now, and if in the long run we see
> more devices that require this quirk, then we can probably remove the
> specific quirk and make it mandatory?

Of course, that’s totally makes sense.

Thanks for the review.

Kai-Heng

> 
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> Cheers,
> Benjamin
> 
>> 
>> drivers/hid/hid-ids.h              |  3 +++
>> drivers/hid/i2c-hid/i2c-hid-core.c | 19 +++++++++++++++++++
>> 2 files changed, 22 insertions(+)
>> 
>> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>> index 16342188df19..c1b5f03eb630 100644
>> --- a/drivers/hid/hid-ids.h
>> +++ b/drivers/hid/hid-ids.h
>> @@ -926,6 +926,9 @@
>> #define USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3003                0x3003
>> #define USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3008                0x3008
>> 
>> +#define I2C_VENDOR_ID_RAYDIUM          0x2386
>> +#define I2C_PRODUCT_ID_RAYDIUM_4B33    0x4b33
>> +
>> #define USB_VENDOR_ID_RAZER            0x1532
>> #define USB_DEVICE_ID_RAZER_BLADE_14   0x011D
>> 
>> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
>> index 4aab96cf0818..3cde7c1b9c33 100644
>> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
>> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
>> @@ -49,6 +49,7 @@
>> #define I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV       BIT(0)
>> #define I2C_HID_QUIRK_NO_IRQ_AFTER_RESET       BIT(1)
>> #define I2C_HID_QUIRK_NO_RUNTIME_PM            BIT(2)
>> +#define I2C_HID_QUIRK_DELAY_AFTER_SLEEP                BIT(3)
>> 
>> /* flags */
>> #define I2C_HID_STARTED                0
>> @@ -158,6 +159,8 @@ struct i2c_hid {
>> 
>>        bool                    irq_wake_enabled;
>>        struct mutex            reset_lock;
>> +
>> +       unsigned long           sleep_delay;
>> };
>> 
>> static const struct i2c_hid_quirks {
>> @@ -172,6 +175,8 @@ static const struct i2c_hid_quirks {
>>        { I2C_VENDOR_ID_HANTICK, I2C_PRODUCT_ID_HANTICK_5288,
>>                I2C_HID_QUIRK_NO_IRQ_AFTER_RESET |
>>                I2C_HID_QUIRK_NO_RUNTIME_PM },
>> +       { I2C_VENDOR_ID_RAYDIUM, I2C_PRODUCT_ID_RAYDIUM_4B33,
>> +               I2C_HID_QUIRK_DELAY_AFTER_SLEEP },
>>        { 0, 0 }
>> };
>> 
>> @@ -387,6 +392,7 @@ static int i2c_hid_set_power(struct i2c_client *client, int power_state)
>> {
>>        struct i2c_hid *ihid = i2c_get_clientdata(client);
>>        int ret;
>> +       unsigned long now, delay;
>> 
>>        i2c_hid_dbg(ihid, "%s\n", __func__);
>> 
>> @@ -404,9 +410,22 @@ static int i2c_hid_set_power(struct i2c_client *client, int power_state)
>>                        goto set_pwr_exit;
>>        }
>> 
>> +       if (ihid->quirks & I2C_HID_QUIRK_DELAY_AFTER_SLEEP &&
>> +           power_state == I2C_HID_PWR_ON) {
>> +               now = jiffies;
>> +               if (time_after(ihid->sleep_delay, now)) {
>> +                       delay = jiffies_to_usecs(ihid->sleep_delay - now);
>> +                       usleep_range(delay, delay + 1);
>> +               }
>> +       }
>> +
>>        ret = __i2c_hid_command(client, &hid_set_power_cmd, power_state,
>>                0, NULL, 0, NULL, 0);
>> 
>> +       if (ihid->quirks & I2C_HID_QUIRK_DELAY_AFTER_SLEEP &&
>> +           power_state == I2C_HID_PWR_SLEEP)
>> +               ihid->sleep_delay = jiffies + msecs_to_jiffies(20);
>> +
>>        if (ret)
>>                dev_err(&client->dev, "failed to change power setting.\n");
>> 
>> --
>> 2.17.1

