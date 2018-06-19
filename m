Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E6AC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6072083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlX/pQso"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E6072083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965934AbeFSIiV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:38:21 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52995 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965592AbeFSIhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:37:17 -0400
Received: by mail-wm0-f66.google.com with SMTP id p126-v6so18485086wmb.2;
        Tue, 19 Jun 2018 01:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=BwaQOu8cPHxX81unOjnd63/Fo8r1BgT/qz2ZYdNqcNs=;
        b=hlX/pQsoAj07rKn0bDN4UmKqpjQBfNFAXG1VltJJkP0/u+nx/L+22lhDvVnA2tGlIr
         osyf9/VdPI4DJ/zG4U/RGAGx/7L0vNBnxMnbLN5WGSrTYF/aDkIBYbqwEuu4Ul8/pdJU
         1x37jjvLMsSOMx0W/DXsMOmofxGZGHfipFA10rp+KsM164ZtUaG70rgX+c7BRBPqelgq
         pw6WhzG8sE6h7ynV5qDqWvpK+dHhwQVGQn0UipgKIq6vVMds/X6QAIv8vKy74T2azCHo
         I3tCTRJ3xGmJ2umBSQ0Bvxj7x18ghkiuBjdp9MvUQRsnOa7RGG+MUggSpuNceeGnc7Z6
         Rtjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BwaQOu8cPHxX81unOjnd63/Fo8r1BgT/qz2ZYdNqcNs=;
        b=WiS/0QjBnMkJ8/0bMu2qPdgNN3j5vbUUP/CSnVPTq+cWUifz482xbIRHZxUnI73iqM
         JZed5v0iuIVBzG9BfoAEDkRsDHor2CR+8Yp2nJgSm6ozoezRHc+7GeywLSzOriNC1yr1
         v3VpdWN31kmNUTWhPrZoHS/qITOpZESfUKMqdTsKxVfYXitiP1h3jWwOvfceK+xJj/zU
         IvG7TRyjRPntUbz6TeCL4qYPjUZFoEw/WDI4m+zhcp3M5zPl4OeqhPbBQEOIVVgtJtvV
         MdawUwEleI8gAXb1hfBTkOO+qOiuSquyrF46zd38cAuthaaJcYsNl0Nita3/hEQRlzuT
         mqng==
X-Gm-Message-State: APt69E1TtWW51pOgYHwCqkxhIg51exf7GPjPT8gHfgg9N0mszThpnduy
        RS8h3yyGxPbyTFOMC1Ad/w2d/g==
X-Google-Smtp-Source: ADUXVKJDNASEPPOyPEJZR7sNJReI+tODBJRwVAT8f9T6t3EmMH+PKk2UHmY67x16eyaha60JhVwtXg==
X-Received: by 2002:a1c:6584:: with SMTP id z126-v6mr9561867wmb.112.1529397435721;
        Tue, 19 Jun 2018 01:37:15 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id w3-v6sm15933449wrr.88.2018.06.19.01.37.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 01:37:13 -0700 (PDT)
Date:   Tue, 19 Jun 2018 10:37:12 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ThinkPad T480s & LED_MUTE, LED_MICMUTE
Message-ID: <20180619083712.dwb4d357sfxcgrre@pali>
References: <20180608111057.4wxpg7m7nm7suf6n@pali>
 <s5hk1r01acc.wl-tiwai@suse.de>
 <20180615190959.pqipwnm6a3tf3lxc@pali>
 <s5hmuvvtdmi.wl-tiwai@suse.de>
 <20180616154309.ualrx2py6ndr5xgz@pali>
 <s5hh8m2u3cp.wl-tiwai@suse.de>
 <20180618102806.vwm4rhvxhn6hi43z@pali>
 <s5ha7rsz8i8.wl-tiwai@suse.de>
 <20180618112121.cl76a3oozsbbbqnb@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180618112121.cl76a3oozsbbbqnb@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 June 2018 13:21:21 Pali Rohár wrote:
> On Monday 18 June 2018 12:36:31 Takashi Iwai wrote:
> > On Mon, 18 Jun 2018 12:28:06 +0200,
> > Pali Rohár wrote:
> > > 
> > > On Saturday 16 June 2018 18:02:14 Takashi Iwai wrote:
> > > > On Sat, 16 Jun 2018 17:43:09 +0200,
> > > > Pali Rohár wrote:
> > > > > 
> > > > > On Saturday 16 June 2018 09:05:41 Takashi Iwai wrote:
> > > > > > On Fri, 15 Jun 2018 21:09:59 +0200,
> > > > > > Pali Rohár wrote:
> > > > > > > 
> > > > > > > On Friday 15 June 2018 14:51:47 Takashi Iwai wrote:
> > > > > > > > On Fri, 08 Jun 2018 13:10:57 +0200,
> > > > > > > > Pali Rohár wrote:
> > > > > > > > > 
> > > > > > > > > Hi! With up-to-date thinkpad_acpi.ko driver on ThinkPad T480s I'm seeing
> > > > > > > > > a strange behavior of LEDs which are integrated into mic mute (Fn+F4)
> > > > > > > > > and mute (Fn+F1) keys.
> > > > > > > > > 
> > > > > > > > > When thinkpad_acpi.ko is not loaded, then mute key is working fine. When
> > > > > > > > > pressed, it correctly generates KEY_MUTE on AT Translated Set 2 keyboard
> > > > > > > > > input device and also turn on/of mute led. But when micmute key is
> > > > > > > > > pressed then, nothing happen. No key event is reported and also led is
> > > > > > > > > not turned on/off.
> > > > > > > > > 
> > > > > > > > > On the other hand, when thinkpad_acpi.ko is loaded, then both buttons
> > > > > > > > > mute and micmute correctly generates input events; mute via AT keyboard
> > > > > > > > > and micmute via ThinkPad Extra Buttons. But led is not changed. When
> > > > > > > > > thinkpad_acpi.ko is loaded it turn off both leds (mute and micmute) and
> > > > > > > > > leds after pressing any of those buttons, leds are not turned on again.
> > > > > > > > > 
> > > > > > > > > When thinkpad_acpi.ko is unloaded, then pressing mute button again start
> > > > > > > > > switching led on/off.
> > > > > > > > > 
> > > > > > > > > So it seems that some init sequence of thinkpad_acpi.ko breaks mute led.
> > > > > > > > > And fini sequence of thinkpad_acpi.ko makes mute led working again.
> > > > > > > > 
> > > > > > > > Usually the mute LED on Thinkpad is triggered from HD-audio driver
> > > > > > > > (sound/pci/hda/thinkpad_helper.c), and it's a soft-bound via
> > > > > > > > symbol_request(tpacpi_led_set).  I thought thinkpad_acpi is
> > > > > > > > auto-loaded when the module gets bound.
> > > > > > > > 
> > > > > > > > A possible explanation would be that TPT480s has neither IBM0068,
> > > > > > > > LEN0068 nor LEN0268 ACPI HIDs, hence the driver is not auto-loaded.
> > > > > > > 
> > > > > > > I have Debian Stretch kernel (4.9) which does not have LEN0268 alias for
> > > > > > > thinkpad_acpi.ko. So thinkpad_acpi.ko is not loaded automatically. But I
> > > > > > > have put thinkpad_acpi into /etc/modules and it is now automatically
> > > > > > > loaded at boot.
> > > > > > 
> > > > > > That's odd.  It's exposed via
> > > > > >   MODULE_DEVICE_TABLE(acpi, ibm_htk_device_ids);
> > > > > > 
> > > > > > It's been already in 4.9.  At this point, something is fishy.
> > > > > 
> > > > > $ /sbin/modinfo thinkpad_acpi | grep alias
> > > > > alias:          dmi:bvnIBM:bvrI[MU]ET??WW*
> > > > > alias:          tpacpi
> > > > > alias:          acpi*:LEN0068:*
> > > > > alias:          acpi*:IBM0068:*
> > > > > 
> > > > > No there is no LEN0268 on 4.9.
> > > > 
> > > > OK, that's the cause.  It's really old.
> > > > 
> > > > The commit a3c42a467a25 ("platform/x86: thinkpad_acpi: Adding new
> > > > hotkey ID for Lenovo thinkpad") has to be backported.
> > > 
> > > This commit just autoloads thinkpad_acpi driver, right? So manual
> > > modprobe (for now) is OK too?
> > 
> > Well, the manual modprobe is superfluous if it's properly bound with
> > HD-audio driver.  The HD-audio driver calls symbol_request(), so it
> > should do modprobe by itself.
> > 
> > > > Also, in the HD-audio side, the commit 2ecb704a1290 ("ALSA: hda - add
> > > > a new condition to check if it is thinkpad") is needed, too.
> > > 
> > > This commit was introduced in 4.9 and Debian kernel has it. I looked
> > > into Debian source code and there is check for LEN0268 in file
> > > sound/pci/hda/thinkpad_helper.c
> > 
> > Then check whether the function gets really called.
> 
> Checked, no it is not called.
> 
> Now I see that snd_hda_codec_generic is visible in lsmod and thinkpad
> helper is compiled only into snd-hda-codec-realtek and
> snd-hda-codec-conexant... Therefore nobody is even trying to use that
> function.

Interesting is this part:

$ head /proc/asound/card0/codec#0
Codec: Realtek ALC257
Address: 0
AFG Function Id: 0x1 (unsol 1)
Vendor Id: 0x10ec0257
Subsystem Id: 0x17aa2258
Revision Id: 0x100001
No Modem Function Group found
Default PCM:
    rates [0x560]: 44100 48000 96000 192000
        bits [0xe]: 16 20 24

It uses vendor id 0x10ec0257 and support for it was added into
snd-hda-codec-realtek in commit f429e7e494 which was introduced in
version v4.15.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f429e7e494afaded76e62c6f98211a635aa03098

I applied this patch to Debian's 4.9 kernel and mute & mic mute leds
started working. This one patch was enough.

Takashi, it is possible to backport this patch into -stable trees?

-- 
Pali Rohár
pali.rohar@gmail.com
