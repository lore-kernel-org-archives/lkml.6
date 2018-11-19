Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3683AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D7520870
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05D7520870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbeKTBwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 20:52:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:45656 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729722AbeKTBwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 20:52:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 75051AD91;
        Mon, 19 Nov 2018 15:28:12 +0000 (UTC)
Date:   Mon, 19 Nov 2018 16:28:11 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: multitouch: Add pointstick support for Cirque
 Touchpad
In-Reply-To: <20181114053520.7229-1-kai.heng.feng@canonical.com>
Message-ID: <nycvar.YFH.7.76.1811191628050.21108@cbobk.fhfr.pm>
References: <20181114053520.7229-1-kai.heng.feng@canonical.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Nov 2018, Kai-Heng Feng wrote:

> Cirque Touchpad/Pointstick combo is similar to Alps devices, it requires
> MT_CLS_WIN_8_DUAL to expose its pointstick as a mouse.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/hid/hid-ids.h        | 3 +++
>  drivers/hid/hid-multitouch.c | 6 ++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index c0d668944dbe..9f59a0a1500b 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -275,6 +275,9 @@
>  
>  #define USB_VENDOR_ID_CIDC		0x1677
>  
> +#define I2C_VENDOR_ID_CIRQUE		0x0488
> +#define I2C_PRODUCT_ID_CIRQUE_121F	0x121F
> +
>  #define USB_VENDOR_ID_CJTOUCH		0x24b8
>  #define USB_DEVICE_ID_CJTOUCH_MULTI_TOUCH_0020	0x0020
>  #define USB_DEVICE_ID_CJTOUCH_MULTI_TOUCH_0040	0x0040
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index f7c6de2b6730..dca0a3a90fb8 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -1814,6 +1814,12 @@ static const struct hid_device_id mt_devices[] = {
>  		MT_USB_DEVICE(USB_VENDOR_ID_CHUNGHWAT,
>  			USB_DEVICE_ID_CHUNGHWAT_MULTITOUCH) },
>  
> +	/* Cirque devices */
> +	{ .driver_data = MT_CLS_WIN_8_DUAL,
> +		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
> +			I2C_VENDOR_ID_CIRQUE,
> +			I2C_PRODUCT_ID_CIRQUE_121F) },
> +
>  	/* CJTouch panels */
>  	{ .driver_data = MT_CLS_NSMU,
>  		MT_USB_DEVICE(USB_VENDOR_ID_CJTOUCH,

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

