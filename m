Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F35C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC78920838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="kMWyiNzO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC78920838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbeLFLF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 06:05:27 -0500
Received: from mail.micronovasrl.com ([212.103.203.10]:58412 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbeLFLF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 06:05:27 -0500
X-Greylist: delayed 308 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Dec 2018 06:05:26 EST
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id 9608AB015F2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Dec 2018 12:00:17 +0100 (CET)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
         h=content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:user-agent:date:date
        :message-id:references:to:subject:subject:from:from; s=dkim; t=
        1544094013; x=1544958014; bh=6UmA2urPp/XhmsO8K4zUHxGAh9AUsE1+RDP
        890zGn78=; b=kMWyiNzOw85aP371Rj7Umj8RoeW9TNQmP65dUX9gZhLJbSpzTpE
        etMvH+qIugEvJV8H2nyws0aL2TdVY1yafNv82PNzHMkkj26dOM+40h6rdB/UyyMX
        OJhA+/am24Hqd5rj/AkMPj1+ayep2ARp6jXgqzuo2cGqii0xWJ4nFaTM=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QGchWfwSf7HX for <linux-kernel@vger.kernel.org>;
        Thu,  6 Dec 2018 12:00:13 +0100 (CET)
Received: from [192.168.178.33] (host128-8-dynamic.21-79-r.retail.telecomitalia.it [79.21.8.128])
        by mail.micronovasrl.com (Postfix) with ESMTPSA id 0BF78B00117;
        Thu,  6 Dec 2018 12:00:12 +0100 (CET)
From:   Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: Re: [PATCH] drm/sun4i: fix HSYNC and VSYNC polarity
To:     Jonathan Liu <net147@gmail.com>
Cc:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1518717288-123578-1-git-send-email-giulio.benetti@micronovasrl.com>
 <CANwerB3Zr9axz+1rwCnNpLsX-xcOhOKEY4MT53v1+vzd99KRMg@mail.gmail.com>
Message-ID: <57d929cf-4458-dae4-36d4-4e89170eba4a@micronovasrl.com>
Date:   Thu, 6 Dec 2018 12:00:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <CANwerB3Zr9axz+1rwCnNpLsX-xcOhOKEY4MT53v1+vzd99KRMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: it
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

Il 06/12/2018 08:29, Jonathan Liu ha scritto:
> Hi Giulio,
> 
> On Thu, 15 Feb 2018 at 17:54, Giulio Benetti
> <giulio.benetti@micronovasrl.com> wrote:
>>
>> Differently from other Lcd signals, HSYNC and VSYNC signals
>> result inverted if their bits are cleared to 0.
>>
>> Invert their settings of IO_POL register.
>>
>> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
>> ---
>>   drivers/gpu/drm/sun4i/sun4i_tcon.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> index 3c15cf2..aaf911a 100644
>> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> @@ -389,10 +389,10 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
>>                       SUN4I_TCON0_BASIC3_H_SYNC(hsync));
>>
>>          /* Setup the polarity of the various signals */
>> -       if (!(mode->flags & DRM_MODE_FLAG_PHSYNC))
>> +       if (mode->flags & DRM_MODE_FLAG_PHSYNC)
>>                  val |= SUN4I_TCON0_IO_POL_HSYNC_POSITIVE;
>>
>> -       if (!(mode->flags & DRM_MODE_FLAG_PVSYNC))
>> +       if (mode->flags & DRM_MODE_FLAG_PVSYNC)
>>                  val |= SUN4I_TCON0_IO_POL_VSYNC_POSITIVE;
>>
>>          regmap_update_bits(tcon->regs, SUN4I_TCON0_IO_POL_REG,
> 
> I am running Linux 4.19.6 and noticed with Olimex LCD-OLinuXino-7TS 7"
> LCD touchscreen (Innolux AT070TN92) connected to Olimex
> A20-OLinuXino-MICRO that the image does not display correctly after
> this change.
> The image is shifted to the right.
> 
> Reverting the change results in the image being displayed correctly on
> the screen.
> 
> I have in the device tree a "panel" node with compatible =
> "innolux,at070tn92" which uses the timings in
> drivers/gpu/drm/panel/panel-simple.c.
> 
> Any ideas?

Checking Display Datasheet:
https://www.olimex.com/Products/Retired/A13-LCD7-TS/resources/S700-AT070TN92.pdf

Page 13 section 3.3.2 you can see it needs active low VS and HS.

You can refer to this Thread and check scope captures about VS and HS 
versus TCON0_IOPOL register:
https://lists.freedesktop.org/archives/dri-devel/2018-January/163874.html

There should be something that wrongly sets one of these or both:
mode->flags |= DRM_MODE_FLAG_PHSYNC;
and/or
mode->flags |= DRM_MODE_FLAG_PVSYNC;

Checked in panel-simple.c but it's not there.

At the moment I don't have a board to check it with me, I'll try to do 
it soon, but I'm full with other work at the moment.

If you have the chance to debug you could try to find in which point 
mode->flags gets changed with those 2 flags.

When the problem came out I've noticed the same thing for u-boot too but 
it's been decided to not patch it because in that case every single 
sunxi defconfig had to be changed from:
CONFIG_VIDEO_LCD_MODE="...,sync:3,..."
to:
CONFIG_VIDEO_LCD_MODE="...,sync:0,..."
and it would have been a great mess, probably not worth it:
https://lists.denx.de/pipermail/u-boot/2018-February/321405.html

So keep in mind that TCON driver works differently for HS and 
VS(inverted) polarity in u-boot and linux.

Hope to work this out soon.
Best regards
-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale € 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642
