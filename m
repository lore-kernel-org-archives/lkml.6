Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7710FC64E79
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 21:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E392184A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 21:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbeLXVdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 16:33:00 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34398 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbeLXVdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 16:33:00 -0500
Received: by mail-wr1-f65.google.com with SMTP id j2so12537470wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 13:32:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=wEGryfaejhg6mjVm2qvFTPe18tWQUbjlHrwN1JnARk4=;
        b=d2OHd56uw5NhBOB+TlKlPhbTNP1KustzpgCRbCndYY9nkwjgkazMZLcUuYRXv9mQY3
         68u+SxDdz+L9MSUSAd5goMhuMWlcQMJ7hZ7MChiGoA4+tZpZsIRguTX1YUGyt/WqvgEL
         hoJwVP7NV70573XEX/S5zb2jXA1CZYrvG6V9H+LkEBn90xMsO9Dz+nZ6Jdogs0nGoSMr
         vuqBt3o9LboAQfP7fTuGcvV5RYbSVwlEmfkVLbG1JHGH3KhzJUF591yRoadNATKYtMv6
         gkAAct1RjgK6RltYauurQn8fsYZa5iJSF9ratd8BaJqz0/QB3jIl773k5nLaMobWKVFG
         DhJg==
X-Gm-Message-State: AJcUukcZYd/7EMZAmakIFf9srE6XA9ElYPKuaceeETb00i0/8/GqOZYx
        2JrdWTQ30LSboga5JTwWYV8JnQ==
X-Google-Smtp-Source: ALg8bN5872VPPSdN/haOgF28eDWn/R1eFPkCj0/A7LR6ojPm6L5if03uBGN3X7vlYQM+q2T/x9WM7g==
X-Received: by 2002:adf:f691:: with SMTP id v17mr12543563wrp.114.1545687177522;
        Mon, 24 Dec 2018 13:32:57 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id 143sm22825914wml.14.2018.12.24.13.32.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Dec 2018 13:32:56 -0800 (PST)
Subject: Re: [PATCH v2 2/9] i2c: reject new transfers when adapters are
 suspended
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>
References: <20181222202623.4521-1-wsa+renesas@sang-engineering.com>
 <20181222202623.4521-3-wsa+renesas@sang-engineering.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <5e560c2e-4da9-05ef-9bfa-3391fdd8ad23@redhat.com>
Date:   Mon, 24 Dec 2018 22:32:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181222202623.4521-3-wsa+renesas@sang-engineering.com>
Content-Type: multipart/mixed;
 boundary="------------34983B75F30C509E4209A341"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------34983B75F30C509E4209A341
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Thank you for this new version.

On 22-12-18 21:26, Wolfram Sang wrote:
> Using the 'is_suspended' flag from the PM core, we now reject new
> transfers if the parent of the adapter is already marked suspended.

I've been running some tests and I'm afraid that those have
exposed multiple issues:

1) It seems that adap->dev.parent can be NULL in some cases, specifically
this patch causes the i915 driver to crash during probe on an Apollo Lake
laptop with an eDP panel. I've attached a fixup patch which fixes this.

2) There are multiple suspend stages: prepare suspend, suspend_late,
suspend_no_irq and several devices which need access to i2c-transfers
suspend from the suspend_late or even the suspend_no_irq handler.

The way this works is that first all devices are moved to the prepared
state, then a second run is done moving all devices over to suspended,
then a third run moving all devices over to suspend_late, etc.

To make this work, e.g. the i2c-designware driver has a nop suspend
callback and does the actual suspend from its suspend_late or
suspend_no_irq callback. But the is_suspended flag we are testing for
now gets set during the suspend phase. So when we are then asked to
do an i2c-transfer during the suspend_late phase we get a false-positive
triggering of the:

	if (WARN(device_is_suspended(adap->dev.parent),
		 "Accessing already suspended I2C/SMBus adapter"))
		return -ESHUTDOWN;

WARN and a return of -ESHUTDOWN, because the adapter is in the
suspended state, but it has not actually been suspended / moved
to the D3 low-power state as that happens later when we reach
e.g. the suspend_no_irq phase of the suspend.

This is not only a problem with the somewhat complex PMIC
situation on some Cherry Trail devices, but it also breaks the
i915 driver since as a PCI device the i915 device also only
really gets turned off from the suspend_no_irq phase of the suspend.

Sorry, this is something which I should have realized before, but
well I didn't.

TL;DR: really only the adapter driver knows when the device is
put in such a state that it can no longer do transfers, as it
actually turns of clks / moves it D3 / etc. Which may happen at
any of the 3 suspend phases so any "core" based solution is going
to get this wrong.

I share your desire to have the check for this shared in core code,
but I'm afraid that just is not going to work.

Regards,

Hans










> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>   Documentation/i2c/fault-codes | 4 ++++
>   drivers/i2c/i2c-core-base.c   | 3 +++
>   drivers/i2c/i2c-core-smbus.c  | 4 ++++
>   3 files changed, 11 insertions(+)
> 
> diff --git a/Documentation/i2c/fault-codes b/Documentation/i2c/fault-codes
> index 47c25abb7d52..0cee0fc545b4 100644
> --- a/Documentation/i2c/fault-codes
> +++ b/Documentation/i2c/fault-codes
> @@ -112,6 +112,10 @@ EPROTO
>   	case is when the length of an SMBus block data response
>   	(from the SMBus slave) is outside the range 1-32 bytes.
>   
> +ESHUTDOWN
> +	Returned when a transfer was requested using an adapter
> +	which is already suspended.
> +
>   ETIMEDOUT
>   	This is returned by drivers when an operation took too much
>   	time, and was aborted before it completed.
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index 28460f6a60cc..3ce238b782f3 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -1865,6 +1865,9 @@ int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
>   
>   	if (WARN_ON(!msgs || num < 1))
>   		return -EINVAL;
> +	if (WARN(device_is_suspended(adap->dev.parent),
> +		 "Accessing already suspended I2C/SMBus adapter"))
> +		return -ESHUTDOWN;
>   
>   	if (adap->quirks && i2c_check_for_quirks(adap, msgs, num))
>   		return -EOPNOTSUPP;
> diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
> index 9cd66cabb84f..e0f7f22feabd 100644
> --- a/drivers/i2c/i2c-core-smbus.c
> +++ b/drivers/i2c/i2c-core-smbus.c
> @@ -547,6 +547,10 @@ s32 __i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
>   	int try;
>   	s32 res;
>   
> +	if (WARN(device_is_suspended(adapter->dev.parent),
> +		 "Accessing already suspended I2C/SMBus adapter"))
> +		return -ESHUTDOWN;
> +
>   	/* If enabled, the following two tracepoints are conditional on
>   	 * read_write and protocol.
>   	 */
> 

--------------34983B75F30C509E4209A341
Content-Type: text/x-patch;
 name="0001-FIXUP-i2c-reject-new-transfers-when-adapters-are-sus.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-FIXUP-i2c-reject-new-transfers-when-adapters-are-sus.pa";
 filename*1="tch"

From 0ff431b48f7f2d08bbf299265c67589a598ec5d4 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 24 Dec 2018 22:00:31 +0100
Subject: [PATCH] FIXUP: i2c: reject new transfers when adapters are suspended

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/i2c/i2c-core-base.c  | 2 +-
 drivers/i2c/i2c-core-smbus.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 3ce238b782f3..e2fae7ec6c95 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1865,7 +1865,7 @@ int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 
 	if (WARN_ON(!msgs || num < 1))
 		return -EINVAL;
-	if (WARN(device_is_suspended(adap->dev.parent),
+	if (WARN(adap->dev.parent && device_is_suspended(adap->dev.parent),
 		 "Accessing already suspended I2C/SMBus adapter"))
 		return -ESHUTDOWN;
 
diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
index e0f7f22feabd..1376620ae204 100644
--- a/drivers/i2c/i2c-core-smbus.c
+++ b/drivers/i2c/i2c-core-smbus.c
@@ -547,7 +547,8 @@ s32 __i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
 	int try;
 	s32 res;
 
-	if (WARN(device_is_suspended(adapter->dev.parent),
+	if (WARN(adapter->dev.parent &&
+			device_is_suspended(adapter->dev.parent),
 		 "Accessing already suspended I2C/SMBus adapter"))
 		return -ESHUTDOWN;
 
-- 
2.20.1


--------------34983B75F30C509E4209A341--
