Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E98C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 14:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39DFE21780
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 14:58:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39DFE21780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733081AbeKOBCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:02:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:40326 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727846AbeKOBCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 20:02:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BCD34ACB8;
        Wed, 14 Nov 2018 14:58:39 +0000 (UTC)
Received: from shadow.suse.cz (shadow.suse.cz [10.100.13.111])
        by dark.suse.cz (Postfix) with ESMTP id 89F4212CC0C;
        Wed, 14 Nov 2018 15:58:39 +0100 (CET)
Received: by shadow.suse.cz (Postfix, from userid 10002)
        id 882CB447FF; Wed, 14 Nov 2018 15:58:39 +0100 (CET)
Date:   Wed, 14 Nov 2018 15:58:39 +0100
From:   Vojtech Pavlik <vojtech@suse.cz>
To:     Tim Schumacher <timschumi@gmx.de>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmitry.torokhov@gmail.com
Subject: Re: [PATCH] Input: iforce - Add the Saitek R440 Force Wheel
Message-ID: <20181114145839.GB9749@suse.cz>
References: <20181114095240.25967-1-timschumi@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114095240.25967-1-timschumi@gmx.de>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 10:52:40AM +0100, Tim Schumacher wrote:
> Signed-off-by: Tim Schumacher <timschumi@gmx.de>
> ---
> Please note that I do NOT own this device.
> 
> I'm adding this based on the fact that this is an iforce-based
> device and that the Windows driver for the R440 works for the
> Logitech WingMan Formula Force after replacing the device/vendor
> IDs (I got the vendor/device IDs from there as well).
> 
> Please don't add this patch if adding devices based on that is
> not ok.
> 
> Also (not related to this patch specifically), does anyone know
> what the question marks at the end of some device definitions
> are supposed to mean?

I believe those are unconfirmed devices based on similar reasoning to yours.

> ---
>  drivers/input/joystick/iforce/iforce-main.c | 1 +
>  drivers/input/joystick/iforce/iforce-usb.c  | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/input/joystick/iforce/iforce-main.c b/drivers/input/joystick/iforce/iforce-main.c
> index 58d5cfe46526..432deecaeff9 100644
> --- a/drivers/input/joystick/iforce/iforce-main.c
> +++ b/drivers/input/joystick/iforce/iforce-main.c
> @@ -67,6 +67,7 @@ static struct iforce_device iforce_device[] = {
>  	{ 0x05ef, 0x8888, "AVB Top Shot Force Feedback Racing Wheel",	btn_wheel, abs_wheel, ff_iforce }, //?
>  	{ 0x061c, 0xc0a4, "ACT LABS Force RS",                          btn_wheel, abs_wheel, ff_iforce }, //?
>  	{ 0x061c, 0xc084, "ACT LABS Force RS",				btn_wheel, abs_wheel, ff_iforce },
> +	{ 0x06a3, 0xff04, "Saitek R440 Force Wheel",			btn_wheel, abs_wheel, ff_iforce }, //?
>  	{ 0x06f8, 0x0001, "Guillemot Race Leader Force Feedback",	btn_wheel, abs_wheel, ff_iforce }, //?
>  	{ 0x06f8, 0x0001, "Guillemot Jet Leader Force Feedback",	btn_joystick, abs_joystick_rudder, ff_iforce },
>  	{ 0x06f8, 0x0004, "Guillemot Force Feedback Racing Wheel",	btn_wheel, abs_wheel, ff_iforce }, //?
> diff --git a/drivers/input/joystick/iforce/iforce-usb.c b/drivers/input/joystick/iforce/iforce-usb.c
> index 78073259c9a1..cdea61ae838d 100644
> --- a/drivers/input/joystick/iforce/iforce-usb.c
> +++ b/drivers/input/joystick/iforce/iforce-usb.c
> @@ -214,6 +214,7 @@ static const struct usb_device_id iforce_usb_ids[] = {
>  	{ USB_DEVICE(0x05ef, 0x8888) },		/* AVB Top Shot FFB Racing Wheel */
>  	{ USB_DEVICE(0x061c, 0xc0a4) },         /* ACT LABS Force RS */
>  	{ USB_DEVICE(0x061c, 0xc084) },         /* ACT LABS Force RS */
> +	{ USB_DEVICE(0x06a3, 0xff04) },		/* Saitek R440 Force Wheel */
>  	{ USB_DEVICE(0x06f8, 0x0001) },		/* Guillemot Race Leader Force Feedback */
>  	{ USB_DEVICE(0x06f8, 0x0003) },		/* Guillemot Jet Leader Force Feedback */
>  	{ USB_DEVICE(0x06f8, 0x0004) },		/* Guillemot Force Feedback Racing Wheel */
> -- 
> 2.19.1.450.ga4b8ab536
> 

-- 
Vojtech Pavlik
Director SUSE Labs
