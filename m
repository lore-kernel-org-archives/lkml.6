Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57488C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 11:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1106E222DD
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 11:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xl4T60GM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfBPL0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 06:26:18 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33297 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfBPL0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 06:26:17 -0500
Received: by mail-wm1-f68.google.com with SMTP id h22so8480092wmb.0;
        Sat, 16 Feb 2019 03:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Mws+xaLF9V9qnzi9/nLwSnVpo535FW6n67Lb6f1fLds=;
        b=Xl4T60GMBrzoIl6n2jy+/wAGdOONoVZ/aacF2rs1DG8yFHCs3RIfv1AxlHsIZgZvFj
         dL4vwwTPlB0+lJktCKsMORZxnRhPZHhH64T8oskuz0GdhM+JBQDu8XTNUN7N6M6W4O5G
         1ngCmixyvRwNX76Ftk0euqAdmq4NfAFRPo31lynZDVrAcnFDKK4MyhiUsPKUXrnf1wrI
         Xf+F9UfiQdP1zFw7CzpiHJrjLhrNVKjd8SdgAdDZhAkuTkQKu8v6iozaYRpnfD5DobxH
         Z8dey8anO3agmuBnZPXlP6N/VtVBuFfLVlHdwBWyJZBa7djBxOgDF5UlVkiJEWa9IgWr
         QS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Mws+xaLF9V9qnzi9/nLwSnVpo535FW6n67Lb6f1fLds=;
        b=rCj3miks8rZ4xZnR/z/S0pd3rZ0X1fPJ6+Ah5fw5MQNgqffj9UL3oyZ6ODuXpmB02J
         gUqFpXvql/Pq51rvgmqgumi6FtTvBYwKEEp73/uJh5XrZ7+6soBWgsf2GNd/K6eC9B3c
         gXRiTzZXpDBfrz3l5RiP7t6dliIFDB6yD4ulTuZlT45xSQndjweKVlUiPLke5NGv0+j8
         uXJlNztkU6Mgr+2VeQqK5XRGdKG9S0PgohjKFry2vh5VVdqj0FYKWTutvJCvRtXBXfjY
         V9/Ou7l2acVhbsA6KPBH4CmixSPx8YyXAds6W4bV3J9bkE8tMfr/Q5BdagSooEHihNnp
         z3Ew==
X-Gm-Message-State: AHQUAuYoBTa4AzBc3AsVSK/bd1UhgJSIUW8kCdrLq1Z/tQzb36MxmYLk
        KfKu+Yyi4+5+8GsHJgzfQDQ=
X-Google-Smtp-Source: AHgI3IY+Vy9gjvgcf0gwZJbcdqlrGtTUziAHDTyCh9OKJyYdPejk0GT4Y2gml13/hG2QOAtNVWYNtA==
X-Received: by 2002:a7b:c0c5:: with SMTP id s5mr9955821wmh.40.1550316375281;
        Sat, 16 Feb 2019 03:26:15 -0800 (PST)
Received: from localhost.localdomain ([46.216.153.34])
        by smtp.gmail.com with ESMTPSA id f134sm11042510wme.31.2019.02.16.03.26.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Feb 2019 03:26:13 -0800 (PST)
Received: from [127.0.0.1] (helo=jeknote.loshitsa1.net)
        by localhost.localdomain with esmtp (Exim 4.92-RC4)
        (envelope-from <jekhor@gmail.com>)
        id 1guy6l-0005LK-V0; Sat, 16 Feb 2019 14:26:12 +0300
Date:   Sat, 16 Feb 2019 14:26:11 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v2 1/2] leds: Add Intel Cherry Trail Whiskey Cove PMIC
 LEDs
Message-ID: <20190216112611.GA11750@jeknote.loshitsa1.net>
References: <20190213230731.GA8557@amd>
 <42078a81-e32e-81b7-528f-d1adb60d31c3@redhat.com>
 <20190213233806.GA11867@amd>
 <562e2acd-a60a-2aea-4050-6d9414d23a4e@redhat.com>
 <20190214111423.GE6132@amd>
 <92cf09b8-726d-4f1b-94ba-368a66af2246@redhat.com>
 <2b6faaa5-b21e-a512-de7d-ca21be5045fc@gmail.com>
 <20190214230307.GA17358@amd>
 <20190215072709.GD30250@jeknote.loshitsa1.net>
 <a79807bb-7826-6f2c-0738-7bddcc66cc5e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a79807bb-7826-6f2c-0738-7bddcc66cc5e@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 10:43:17PM +0100, Jacek Anaszewski wrote:
> Hi Yauhen,
> 
> On 2/15/19 8:27 AM, Yauhen Kharuzhy wrote:
> > On Fri, Feb 15, 2019 at 12:03:07AM +0100, Pavel Machek wrote:
> > > Hi!
> > > 
> > > > > > > I suggest that we deal with this special case by adding 3 custom
> > > > > > > sysfs attributes:
> > > > > > > 
> > > > > > > 1) "mode" which when read, prints, e.g. :
> > > > > > > manual [on-when-charging]
> > > > > > 
> > > > > > While this allows _user on console_ to control everything using echo,
> > > > > > it is not suitable for applications trying to control LEDs.
> > > > > > 
> > > > > > As there's nothing special about the case here, I believe we should
> > > > > > have generic solution here.
> > > > > > 
> > > > > > My preffered solution would be "hardware" trigger that leaves the LED
> > > > > > in hardware control.
> > > > > 
> > > > > As you explained in the parts which I snipped, there are many
> > > > > devices which have a similar choice for a LED being under hw or
> > > > > user control. I can see how this looks like a trigger and how we
> > > > > could use the trigger API for this.
> > > > > 
> > > > > I believe though, that if we implement a "virtual" (for lack of
> > > > > a better word) trigger for this, that this should be done in the
> > > > > LED core. I can envision this working like this:
> > > > > 
> > > > > 1) Add a:
> > > > > 
> > > > > hw_control_set(struct led_classdev *led_cdev, bool enable_hw_control);
> > > > 
> > > > Please note that we have support for hw patterns in the pattern trigger.
> > > > (see how drivers/leds/leds-sc27xx-bltc.c makes use of it for its
> > > > breathing pattern).
> > > > We have also support for hw blinking in timer trigger via blink_set op.
> > > > 
> > > > In addition to that there is brightness_hw_changed sysfs attribute
> > > > with led_classdev_notify_brightness_hw_changed() LED API.
> > > > 
> > > > Couldn't they be used in concert to support the specific features
> > > > of the device in question?
> > > 
> > > I believe main issue here is this:
> > > 
> > > Hardware can automatically control the LED according to the charging
> > > status, or it can be used as normal software-controlled LED.
> > > 
> > > I believe we should use trigger to select if hardware controls it or
> > > not (and then add driver-specific files to describe the
> > > details). Other proposal is in the mail thread, too.
> > 
> > But there are two kinds of 'hardware control' here in discussion:
> > 1:
> > 	a) PMIC switching LED off/on/breathing/blinking reflected the charging
> > 	state (charger is controlled by PMIC entirely without of
> > 	software intervention) – 'hw controlled' mode
> 
> Can we detect when charging is activated?

Depends on PMIC and charger configuration. Seems there are no common
way working for all configurations exists.

> 
> > 	b) Software controls when LED is on/off/breathing/blinking but
> > 	patterns are generated by PMIC – 'sw controlled' mode.
> > 
> > 2:
> > 	a) parameters of lighting (continuous/blinking/breathing) are
> > 	set in the PMIC and the PMIC generates patterns
> > 	b) blinking/breathing patterns are generated by the software
> > 	entirely.
> > 
> > It seems that we sometimes confuse this two kinds of hw control definitions
> > in the discussion.
> > 
> > 
> > The simple use case question: with this hardware and existing LED class
> > API, what user/app should to do to make LED breathing with hw-generated
> > pattern?
> > 
> > As I see, user should activate 'pattern' trigger and write to its hw_pattern attribute...
> > hm... big pattern which describes every step of breathing? Some
> > simplified pattern which should be interpreted as 'enable the breathing
> > an set its frequency' by driver? Which level of simplification will be
> > suitable? Which criteria of pattern rejection should be?
> 
> Please see my reply to Hans. We need some simplified device specific
> syntax of hw_pattern for this device, similarly like in:
> Documentation/ABI/testing/sysfs-class-led-driver-sc27xx

Thanks, this approach seems easy to implement.

> 
> -- 
> Best regards,
> Jacek Anaszewski

-- 
Yauhen Kharuzhy
