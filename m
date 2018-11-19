Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BD0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA0D2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvbdkEbU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA0D2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731549AbeKTI6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 03:58:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:41494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730290AbeKTI6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 03:58:35 -0500
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 433022086A;
        Mon, 19 Nov 2018 22:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542666764;
        bh=RJR+YZSqWLRfLUrpZwsi9Q/0+s5g+btPgsuw47zhiCs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QvbdkEbUQ4HEUgbwwU4ckaSq96cawEMRrbl42fnBHt48uJD5uIS4JDFMcqZ0VUo8c
         tD2C8m2hrcR47epnBYm706U9b2Pt1nXH228YrhDnLUOQymxyk4BDPlBzj64KxDeybp
         oUIintLmH7NRoVAwEVk7ZyCX1CUV68bLDUzLnFw0=
Received: by mail-qk1-f173.google.com with SMTP id q1so51431181qkf.13;
        Mon, 19 Nov 2018 14:32:44 -0800 (PST)
X-Gm-Message-State: AGRZ1gJ67wFsl+ICnLStMdA39s7Z/r2kjSXfeOA6zC2RgHLLxnrVzGsM
        4gwUY/2OjBk2jfYqsqbInjKFIox5aqw4H0fkag==
X-Google-Smtp-Source: AJdET5d0ohHyB5+TwBS63sd3Zoa4KcV5VYydAS17P1LajdBUhTv0ZEJKH4dLfzKDvHXmRUfPjr5ZMO5iv588fkL8R0I=
X-Received: by 2002:aed:3ecf:: with SMTP id o15mr23264321qtf.26.1542666763489;
 Mon, 19 Nov 2018 14:32:43 -0800 (PST)
MIME-Version: 1.0
References: <1541170556-75032-1-git-send-email-michal.vokac@ysoft.com>
 <1541170556-75032-2-git-send-email-michal.vokac@ysoft.com>
 <5bea0e9c.1c69fb81.1f3c8.be5a@mx.google.com> <db9537dc-2ba5-b8fc-ae3c-7d85841b0797@ysoft.com>
In-Reply-To: <db9537dc-2ba5-b8fc-ae3c-7d85841b0797@ysoft.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 19 Nov 2018 16:32:32 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+KOqWVdudDGZNJSJ1SZSX1FK2GOSu-4VfmRV-KZrYJZA@mail.gmail.com>
Message-ID: <CAL_Jsq+KOqWVdudDGZNJSJ1SZSX1FK2GOSu-4VfmRV-KZrYJZA@mail.gmail.com>
Subject: Re: [PATCH fbdev-for-next 2/2] video: ssd1307fb: Add support for the
 reset-active-low property
To:     =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <Michal.Vokac@ysoft.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Jyri Sarha <jsarha@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 9:12 AM Vok=C3=A1=C4=8D Michal <Michal.Vokac@ysoft.=
com> wrote:
>
> On 12.11.2018 17:55, Rob Herring wrote:
> > On Fri, Nov 02, 2018 at 02:56:35PM +0000, Vok=C3=A1=C4=8D Michal wrote:
> >> The SSD130x OLED display reset signal is active low. Now the reset
> >> sequence is implemented in such a way that DTS authors are forced to
> >> define the reset-gpios property with GPIO_ACTIVE_HIGH to make the rese=
t
> >> work.
> >>
> >> Add the reset-active-low property so the signal is inverted once again
> >> and the GPIO_ACTIVE_LOW work as expected.
> >>
> >> Signed-off-by: Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft.com>
> >> ---
> >>   drivers/video/fbdev/ssd1307fb.c | 6 ++++--
> >>   1 file changed, 4 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd=
1307fb.c
> >> index e7ae135..790f1c4 100644
> >> --- a/drivers/video/fbdev/ssd1307fb.c
> >> +++ b/drivers/video/fbdev/ssd1307fb.c
> >> @@ -608,6 +608,7 @@ static int ssd1307fb_probe(struct i2c_client *clie=
nt,
> >>      struct fb_deferred_io *ssd1307fb_defio;
> >>      u32 vmem_size;
> >>      struct ssd1307fb_par *par;
> >> +    bool reset_active_low;
> >>      u8 *vmem;
> >>      int ret;
> >>
> >> @@ -671,6 +672,7 @@ static int ssd1307fb_probe(struct i2c_client *clie=
nt,
> >>      par->com_seq =3D of_property_read_bool(node, "solomon,com-seq");
> >>      par->com_lrremap =3D of_property_read_bool(node, "solomon,com-lrr=
emap");
> >>      par->com_invdir =3D of_property_read_bool(node, "solomon,com-invd=
ir");
> >> +    reset_active_low =3D of_property_read_bool(node, "reset-active-lo=
w");
> >>
> >>      par->contrast =3D 127;
> >>      par->vcomh =3D par->device_info->default_vcomh;
> >> @@ -728,9 +730,9 @@ static int ssd1307fb_probe(struct i2c_client *clie=
nt,
> >>
> >>      if (par->reset) {
> >>              /* Reset the screen */
> >> -            gpiod_set_value_cansleep(par->reset, 0);
> >> +            gpiod_set_value_cansleep(par->reset, reset_active_low);
> >>              udelay(4);
> >> -            gpiod_set_value_cansleep(par->reset, 1);
> >> +            gpiod_set_value_cansleep(par->reset, !reset_active_low);
> >
> > I think you and whomever wrote the original code are misinterpretting
> > how the gpiod API works. 1 means make the signal active and this case
> > active is low.
>
> I totally agree and I think I understand that correctly.
>
> > It is strange, but does mean a reset sequence should always be set to a
> > 1 and then a 0 and it will work with either polarity in the DT.
>
> I agree the reset should be done as a 0 -> 1 -> 0 sequence and that shoul=
d
> just work. The problem is it is implemented vice versa and so it works on=
ly
> if you have GPIO_ACTIVE_HIGH in DT for a signal that is actually active l=
ow.
>
> And what it actually does is that it holds the controller in reset since
> the GPIO is successfully acquired (because of GPIOD_OUT_LOW here [1]) and
> later on it only releases the reset.
>
> As a DT author I would like to somehow clearly state that the OLED displa=
y
> uses active low reset in my DT.
>
> My first attempt to fix this was to change the reset sequence [2].
> It was applied and then reverted as it is not backward compatible with
> deployed DTB files [3].
>
> [1] https://elixir.bootlin.com/linux/v4.20-rc3/source/drivers/video/fbdev=
/ssd1307fb.c#L570
> [2] https://patchwork.kernel.org/patch/10617729/
> [3] https://patchwork.kernel.org/patch/10617731/

Okay, now I understand the background. We've hit this somewhere else too.

Rather than have a binding demonstrating what not to do, I'd like to
fix this in another way. I also don't want to live with this forever
when there's only 1 board affected (in tree at least) and there's only
an ABI if someone notices (I'm happy though that the maintainers
caught this). There's 2 other options. The 1st is add a fixup to the
DT for this platform to ensure that the GPIO is configured active low
(the Versatile platform code has an example fixup). With that, apply
what was originally applied (or revert the revert). The fixup could be
applied only after someone complains their display broke. The 2nd
option is just add an of_machine_is_compatible check within this
driver. In that case, you wouldn't fix dts file for the platform
(unless you also want to manually check reset-gpios).

Rob
