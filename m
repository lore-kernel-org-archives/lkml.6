Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172B1C070C3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 03:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2AD420652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 03:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2AD420652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbeJOLRE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 07:17:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55067 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbeJOLRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 07:17:04 -0400
Received: from mail-pf1-f199.google.com ([209.85.210.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gBtdX-00078R-5J
        for linux-kernel@vger.kernel.org; Mon, 15 Oct 2018 03:33:43 +0000
Received: by mail-pf1-f199.google.com with SMTP id a72-v6so3139086pfj.14
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 20:33:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tykkVwyBPXnw9eYIR4U3Y/EbWhlsj/ageVNoTNcje9s=;
        b=mlAaormUWmWaymvFjav9gPxNR7KGUhLQ3tfqQZv93/xja+lsji7trrt5p73IEDSsO0
         zHxqf82GZglrqWKNKMVkBvjgWxEcff2FJ5GOqaBNpqZhDQLtbv3OQc8g8zl9kZOSqK9O
         XKjaQOl7lsaQ0Q2Hpq86wK3BT49Q/hbXxxFmf8BaoFTgD9DN2y7i1CNt0jfeiHqlBXxM
         QFdMhWa4JT/T+Mf5doCuOHP+7EgfCdRUEukq/Ua3Xpx4eSpb33wPOvwcTQBEXXYHCQ7M
         +IPDu5izUA9FayDV7NRX/0Mc0NIaUHGVIq8ZVFRjHJS3+NUiEXTCLGQOHQ7Yj2hx6c5t
         wSew==
X-Gm-Message-State: ABuFfojQ2xg8G6v5/Oqn6LTlw25og7XrucA0MPu/Dj8676V2n8lLdSW6
        7M9WrQVtU5Bum05+pdnu0TOtkPswbiChIUHN3gR61bUTUmluugDMFHOACnDpA8Or5a9H9KAsWFf
        ldrnN+DaVV6zDiFMToI/4I+Xw199bzMqDUV72Sw1WXA==
X-Received: by 2002:a17:902:d694:: with SMTP id v20-v6mr15268187ply.261.1539574421808;
        Sun, 14 Oct 2018 20:33:41 -0700 (PDT)
X-Google-Smtp-Source: ACcGV60FqX4l+MhzSPG00HiIgoSJw5OhzcepWSPQ/w/ejXrk/julTePuA7meYiXxK2+pqZhYMjiRsQ==
X-Received: by 2002:a17:902:d694:: with SMTP id v20-v6mr15268172ply.261.1539574421480;
        Sun, 14 Oct 2018 20:33:41 -0700 (PDT)
Received: from 2001-b011-380f-17e9-a902-1d49-f790-578f.dynamic-ip6.hinet.net (2001-b011-380f-17e9-a902-1d49-f790-578f.dynamic-ip6.hinet.net. [2001:b011:380f:17e9:a902:1d49:f790:578f])
        by smtp.gmail.com with ESMTPSA id j187-v6sm14167256pfc.39.2018.10.14.20.33.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 20:33:40 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH v2] HID: i2c-hid: Add a small delay after sleep command
 for Raydium touchpanel
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20181005044629.26286-1-kai.heng.feng@canonical.com>
Date:   Mon, 15 Oct 2018 11:33:38 +0800
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <E080F790-05ED-461F-90A0-947FA359E697@canonical.com>
References: <20181005044629.26286-1-kai.heng.feng@canonical.com>
To:     Jiri Kosina <jikos@kernel.org>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri and Benjamin,

> On Oct 5, 2018, at 12:46, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> Raydium touchpanel (2386:4B33) sometimes does not work in desktop session
> although it works in display manager.
> 
> During user logging, the display manager exits, close the HID device,
> then the device gets runtime suspended and powered off. The desktop
> session begins shortly after, opens the HID device, then the device gets
> runtime resumed and powered on.
> 
> If the trasition from display manager to desktop sesesion is fast, the
> touchpanel cannot switch from powered off to powered on in short
> timeframe. So add a small delay to workaround the issue.

Please review my patch and let me know if the approach is okay, thanks!

Kai-Heng

> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2:
> - Use quirk to only match affected touchpanel
> - Only delay the next power on if the time hasn't elapsed
> 
> drivers/hid/hid-ids.h              |  3 +++
> drivers/hid/i2c-hid/i2c-hid-core.c | 19 +++++++++++++++++++
> 2 files changed, 22 insertions(+)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 16342188df19..c1b5f03eb630 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -926,6 +926,9 @@
> #define USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3003		0x3003
> #define USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3008		0x3008
> 
> +#define I2C_VENDOR_ID_RAYDIUM		0x2386
> +#define I2C_PRODUCT_ID_RAYDIUM_4B33	0x4b33
> +
> #define USB_VENDOR_ID_RAZER            0x1532
> #define USB_DEVICE_ID_RAZER_BLADE_14   0x011D
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
> index 4aab96cf0818..3cde7c1b9c33 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> @@ -49,6 +49,7 @@
> #define I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV	BIT(0)
> #define I2C_HID_QUIRK_NO_IRQ_AFTER_RESET	BIT(1)
> #define I2C_HID_QUIRK_NO_RUNTIME_PM		BIT(2)
> +#define I2C_HID_QUIRK_DELAY_AFTER_SLEEP		BIT(3)
> 
> /* flags */
> #define I2C_HID_STARTED		0
> @@ -158,6 +159,8 @@ struct i2c_hid {
> 
> 	bool			irq_wake_enabled;
> 	struct mutex		reset_lock;
> +
> +	unsigned long		sleep_delay;
> };
> 
> static const struct i2c_hid_quirks {
> @@ -172,6 +175,8 @@ static const struct i2c_hid_quirks {
> 	{ I2C_VENDOR_ID_HANTICK, I2C_PRODUCT_ID_HANTICK_5288,
> 		I2C_HID_QUIRK_NO_IRQ_AFTER_RESET |
> 		I2C_HID_QUIRK_NO_RUNTIME_PM },
> +	{ I2C_VENDOR_ID_RAYDIUM, I2C_PRODUCT_ID_RAYDIUM_4B33,
> +		I2C_HID_QUIRK_DELAY_AFTER_SLEEP },
> 	{ 0, 0 }
> };
> 
> @@ -387,6 +392,7 @@ static int i2c_hid_set_power(struct i2c_client *client, int power_state)
> {
> 	struct i2c_hid *ihid = i2c_get_clientdata(client);
> 	int ret;
> +	unsigned long now, delay;
> 
> 	i2c_hid_dbg(ihid, "%s\n", __func__);
> 
> @@ -404,9 +410,22 @@ static int i2c_hid_set_power(struct i2c_client *client, int power_state)
> 			goto set_pwr_exit;
> 	}
> 
> +	if (ihid->quirks & I2C_HID_QUIRK_DELAY_AFTER_SLEEP &&
> +	    power_state == I2C_HID_PWR_ON) {
> +		now = jiffies;
> +		if (time_after(ihid->sleep_delay, now)) {
> +			delay = jiffies_to_usecs(ihid->sleep_delay - now);
> +			usleep_range(delay, delay + 1);
> +		}
> +	}
> +
> 	ret = __i2c_hid_command(client, &hid_set_power_cmd, power_state,
> 		0, NULL, 0, NULL, 0);
> 
> +	if (ihid->quirks & I2C_HID_QUIRK_DELAY_AFTER_SLEEP &&
> +	    power_state == I2C_HID_PWR_SLEEP)
> +		ihid->sleep_delay = jiffies + msecs_to_jiffies(20);
> +
> 	if (ret)
> 		dev_err(&client->dev, "failed to change power setting.\n");
> 
> -- 
> 2.17.1
> 

