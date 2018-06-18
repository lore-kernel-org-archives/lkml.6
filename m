Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BE0C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBB2A208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gw4Yxy8E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBB2A208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934537AbeFRLV3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 07:21:29 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50905 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932657AbeFRLV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 07:21:26 -0400
Received: by mail-wm0-f66.google.com with SMTP id e16-v6so13425091wmd.0;
        Mon, 18 Jun 2018 04:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wb6LoUxRpbJzPEA7M5NxI9zn23O46QGX1p0y0REoLo4=;
        b=gw4Yxy8EQAfNgnaYi76NTcbV/BkOktRzEXLrYDxOii9sWeNete4xSbzv42/GVP9OE7
         hGnrPHuCVbBKkYCHvI00cn6Y4hckqPRfFxADEvGXswBdqw/ihnuMeSYgSn8eWOtzQpzh
         v7XEjj0Pvrq61eJSklPZxW7ReGlFCtQqXUvoRRsjNzOZdgjBJ7+2I56Xy867+moulR2j
         QZm8xqEusuWze3krsTFfDhe+oFCUyNtuN75ZhmgjkAAC/+FmVW7vcXKrJ0NMKCIlnl7O
         i46+wmUHmsMODeELBM6ABGgrpGTKmJ0zELUEITfMUC0QWr7/crC6zEzE2f66ScA/mq3D
         jrcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wb6LoUxRpbJzPEA7M5NxI9zn23O46QGX1p0y0REoLo4=;
        b=OWySFU2JdhDQuvMYh2mVruTRwA678qfj5N2xYXQeEYR/Hi7+U1+930au7d2RvMcaew
         Z8L3NBt0LogVoCzNR4gAJlBUcCM0mbXiF+6veML1rDKZ3z8EYqTstv2OMHSFMPar8QMq
         h73p16fAUQu2JBQaWNpQy6nq1cWehyISldRoD3AvhhhEP+tkTbHO2BrMcVIPsz8o9mCp
         u7sKOccE27LlqOhVXGQAoX14y1E6ANphvuzaGMiRBa0CM7vGWYJeyCGvbMs/XyA4jd4R
         H17phQqy2RFEsD5UdI2ea0TddYWQF9eTpQd4ALlSNqB8O+ui5JSHCspLoijeW3jycQAK
         pAlA==
X-Gm-Message-State: APt69E33lHtUsDwk+vE3EdSuAJPRHb3cA0s54bLvYESGtPlIKrTKdGs2
        DhlUb36JA7h17TPcaxJslxSm/g==
X-Google-Smtp-Source: ADUXVKKzfLgc3hr59UmZ2GONsl7uNPd53KQIxiPUkNVLov861xWuGGuZunLdv+QAbaULNJYMbD+EIQ==
X-Received: by 2002:a1c:8012:: with SMTP id b18-v6mr7855660wmd.13.1529320884552;
        Mon, 18 Jun 2018 04:21:24 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id k82-v6sm11013714wmg.10.2018.06.18.04.21.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 04:21:23 -0700 (PDT)
Date:   Mon, 18 Jun 2018 13:21:21 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ThinkPad T480s & LED_MUTE, LED_MICMUTE
Message-ID: <20180618112121.cl76a3oozsbbbqnb@pali>
References: <20180608111057.4wxpg7m7nm7suf6n@pali>
 <s5hk1r01acc.wl-tiwai@suse.de>
 <20180615190959.pqipwnm6a3tf3lxc@pali>
 <s5hmuvvtdmi.wl-tiwai@suse.de>
 <20180616154309.ualrx2py6ndr5xgz@pali>
 <s5hh8m2u3cp.wl-tiwai@suse.de>
 <20180618102806.vwm4rhvxhn6hi43z@pali>
 <s5ha7rsz8i8.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <s5ha7rsz8i8.wl-tiwai@suse.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 June 2018 12:36:31 Takashi Iwai wrote:
> On Mon, 18 Jun 2018 12:28:06 +0200,
> Pali Rohár wrote:
> > 
> > On Saturday 16 June 2018 18:02:14 Takashi Iwai wrote:
> > > On Sat, 16 Jun 2018 17:43:09 +0200,
> > > Pali Rohár wrote:
> > > > 
> > > > On Saturday 16 June 2018 09:05:41 Takashi Iwai wrote:
> > > > > On Fri, 15 Jun 2018 21:09:59 +0200,
> > > > > Pali Rohár wrote:
> > > > > > 
> > > > > > On Friday 15 June 2018 14:51:47 Takashi Iwai wrote:
> > > > > > > On Fri, 08 Jun 2018 13:10:57 +0200,
> > > > > > > Pali Rohár wrote:
> > > > > > > > 
> > > > > > > > Hi! With up-to-date thinkpad_acpi.ko driver on ThinkPad T480s I'm seeing
> > > > > > > > a strange behavior of LEDs which are integrated into mic mute (Fn+F4)
> > > > > > > > and mute (Fn+F1) keys.
> > > > > > > > 
> > > > > > > > When thinkpad_acpi.ko is not loaded, then mute key is working fine. When
> > > > > > > > pressed, it correctly generates KEY_MUTE on AT Translated Set 2 keyboard
> > > > > > > > input device and also turn on/of mute led. But when micmute key is
> > > > > > > > pressed then, nothing happen. No key event is reported and also led is
> > > > > > > > not turned on/off.
> > > > > > > > 
> > > > > > > > On the other hand, when thinkpad_acpi.ko is loaded, then both buttons
> > > > > > > > mute and micmute correctly generates input events; mute via AT keyboard
> > > > > > > > and micmute via ThinkPad Extra Buttons. But led is not changed. When
> > > > > > > > thinkpad_acpi.ko is loaded it turn off both leds (mute and micmute) and
> > > > > > > > leds after pressing any of those buttons, leds are not turned on again.
> > > > > > > > 
> > > > > > > > When thinkpad_acpi.ko is unloaded, then pressing mute button again start
> > > > > > > > switching led on/off.
> > > > > > > > 
> > > > > > > > So it seems that some init sequence of thinkpad_acpi.ko breaks mute led.
> > > > > > > > And fini sequence of thinkpad_acpi.ko makes mute led working again.
> > > > > > > 
> > > > > > > Usually the mute LED on Thinkpad is triggered from HD-audio driver
> > > > > > > (sound/pci/hda/thinkpad_helper.c), and it's a soft-bound via
> > > > > > > symbol_request(tpacpi_led_set).  I thought thinkpad_acpi is
> > > > > > > auto-loaded when the module gets bound.
> > > > > > > 
> > > > > > > A possible explanation would be that TPT480s has neither IBM0068,
> > > > > > > LEN0068 nor LEN0268 ACPI HIDs, hence the driver is not auto-loaded.
> > > > > > 
> > > > > > I have Debian Stretch kernel (4.9) which does not have LEN0268 alias for
> > > > > > thinkpad_acpi.ko. So thinkpad_acpi.ko is not loaded automatically. But I
> > > > > > have put thinkpad_acpi into /etc/modules and it is now automatically
> > > > > > loaded at boot.
> > > > > 
> > > > > That's odd.  It's exposed via
> > > > >   MODULE_DEVICE_TABLE(acpi, ibm_htk_device_ids);
> > > > > 
> > > > > It's been already in 4.9.  At this point, something is fishy.
> > > > 
> > > > $ /sbin/modinfo thinkpad_acpi | grep alias
> > > > alias:          dmi:bvnIBM:bvrI[MU]ET??WW*
> > > > alias:          tpacpi
> > > > alias:          acpi*:LEN0068:*
> > > > alias:          acpi*:IBM0068:*
> > > > 
> > > > No there is no LEN0268 on 4.9.
> > > 
> > > OK, that's the cause.  It's really old.
> > > 
> > > The commit a3c42a467a25 ("platform/x86: thinkpad_acpi: Adding new
> > > hotkey ID for Lenovo thinkpad") has to be backported.
> > 
> > This commit just autoloads thinkpad_acpi driver, right? So manual
> > modprobe (for now) is OK too?
> 
> Well, the manual modprobe is superfluous if it's properly bound with
> HD-audio driver.  The HD-audio driver calls symbol_request(), so it
> should do modprobe by itself.
> 
> > > Also, in the HD-audio side, the commit 2ecb704a1290 ("ALSA: hda - add
> > > a new condition to check if it is thinkpad") is needed, too.
> > 
> > This commit was introduced in 4.9 and Debian kernel has it. I looked
> > into Debian source code and there is check for LEN0268 in file
> > sound/pci/hda/thinkpad_helper.c
> 
> Then check whether the function gets really called.

Checked, no it is not called.

Now I see that snd_hda_codec_generic is visible in lsmod and thinkpad
helper is compiled only into snd-hda-codec-realtek and
snd-hda-codec-conexant... Therefore nobody is even trying to use that
function.

And yes, sound playback and microphone recording is working.

> 
> > > > > > I also compiled upstream version of thinkpad_acpi.ko, loaded it in
> > > > > > Stretch kernel, but it behaves in same way.
> > > > > >
> > > > > > Maybe... there could be a problem that thinkpad_acpi.ko must be already
> > > > > > loaded when sound subsystem is doing initialization? If yes, this could
> > > > > > explain it as /etc/modules is loaded at later stage and manually loading
> > > > > > of new version of thinkpad_acpi.ko at runtime does not help when sound
> > > > > > subsystem is already running.
> > > > > 
> > > > > Not really.  The HD-audio driver tries to bind with tpacpi_led_set()
> > > > > via symbol_request().  i.e. if it's not present, it tries to load a
> > > > > module.
> > > > > 
> > > > > Check whether hda_fixup_thinkpad_acpi() is called and the symbol gets
> > > > > loaded or not.
> > > > > 
> > > > > But, I don't think it's worth to debug such an old kernel primarily.
> > > > 
> > > > It is default one used by the last released Debian stable version.
> > > 
> > > Heh, that explains :)
> > > 
> > > And there was a recent regression in HD-audio that was addressed in
> > > 4.9.104.  If you're using some earlier 4.9.x, you might hit the
> > > problem regarding HD-audio thinkpad_acpi binding.
> > 
> > Debian has currently 4.9.88.
> > 
> > > (But I guess it doesn't work in anyway without the backport of the
> > >  commit above.)
> > 
> > Which change/regression it is? As 2ecb704a1290 is already part of 4.9 I
> > think this is a problem why it is not working...
> 
> It's 71bff398b0d4 that is in 4.9.104.
> 
> But you should really try the latest upstream kernel before spending
> too much time (not only yours but also others).

Now I see that in Debian backports is some 4.16.12 kernel version. I can
try this one (and later compile one from Linus tree).

> 
> Takashi
> 
> 
> > > > > Could you test the latest Linus tree or 4.17.x at least as a test
> > > > > basis?
> > > > 
> > > > Ok, will do that later.
> > > 
> > > If my analysis above is correct, everything should work with the
> > > recent upstream kernel as is.
> > > 
> > > Once after you confirm it, I can cook a patch to add the mixer enum to
> > > change LED behavior as you wanted.
> > > 
> > > 
> > > Takashi
> > 
> > -- 
> > Pali Rohár
> > pali.rohar@gmail.com
> > 

-- 
Pali Rohár
pali.rohar@gmail.com
