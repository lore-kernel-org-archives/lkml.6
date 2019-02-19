Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50D5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99DFC2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zz8pbu+y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfBSUUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:20:11 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:38483 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfBSUUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 15:20:10 -0500
Received: by mail-wm1-f44.google.com with SMTP id v26so4118385wmh.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 12:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uOnH1MWNRj4KWHIToZUIdU6Ad2tv4oLRG9w9N2RKNkM=;
        b=Zz8pbu+ykI3yIPdrZt0EdGf3oFIH7/RROOj0MBCth8DB3k9pGX9V8uC7aWCeKX72/E
         9mKeFzIUJ74nxUb61Bs6TS43tsVJUvG//3PtHyyXwa3X6j7h5GFUfMmFMRyBL+uknUVE
         g6RfutpLny2q15XkeKLX9d4XyblIO9qFYDgy7bP+7fHL+R3LNsHXTyH/QZ0GO0wJUTgr
         kc2gCUAbxWfsg+ftiRLecnSn6GIXwsajdwf2RbKJ89YUeH7BkP1GGKLcXddm5lKafp17
         keA1Q83VJghB8hzYmiRPQCYBvsXDOi2bNaclpd08z+RF71WHCWb+9myQOnms94liw6bb
         nNGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uOnH1MWNRj4KWHIToZUIdU6Ad2tv4oLRG9w9N2RKNkM=;
        b=TqWOcl/THQfKc9P3rZcuE2pOleILyBrw+wBTXDlj7lAxlhE7hvenTwfcobbhj8jqYc
         FDFi4JEltryQ9Vz92VgtZgIQDPAbkPS904doH8iDK8aTuw7RacLt4/hNMWbxvjqNF+q9
         brlmLzlj/3v+aeEp9vRic8GSArtSc0tILGnx0xz7YDPyckCKQCq14OqQbOJNln3EGRWU
         LmrIdzVh9OppHHXHr/MoB55lKzuBKJhOX5jc6+G3T/F6BPItyuk9dgDTwrJulZofQvkd
         53b+UWbgnhVcHdG5D6J+1miCZtsMtphhipJCAwBoYVqXL/zPwRL1C3tgVVz452yCZvwp
         GVag==
X-Gm-Message-State: AHQUAuYGA/5dcxzi+UYG8dPNdc7vcFr2MAYqr6Fa4NzLfeqMnCDMma09
        ZwtW0dfOpN/EEEuXFMFZYPI=
X-Google-Smtp-Source: AHgI3IZyb94bK73ou6dhGP4YMltUkGwBHPaX48//3kG0zqXlhQwmqN3fdR2QxQKmpgTtNvObpst65Q==
X-Received: by 2002:a7b:cb49:: with SMTP id v9mr4026008wmj.138.1550607608065;
        Tue, 19 Feb 2019 12:20:08 -0800 (PST)
Received: from localhost.localdomain ([46.216.153.243])
        by smtp.gmail.com with ESMTPSA id s8sm34443620wrn.44.2019.02.19.12.20.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 12:20:07 -0800 (PST)
Received: from [127.0.0.1] (helo=jeknote.loshitsa1.net)
        by localhost.localdomain with esmtp (Exim 4.92-RC4)
        (envelope-from <jekhor@gmail.com>)
        id 1gwBs5-0001R6-2K; Tue, 19 Feb 2019 23:20:05 +0300
Date:   Tue, 19 Feb 2019 23:20:05 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/2] extcon intel-cht-wc: Enable external charger
Message-ID: <20190219202005.GA3699@jeknote.loshitsa1.net>
References: <20190210203649.21691-1-jekhor@gmail.com>
 <20190210203649.21691-3-jekhor@gmail.com>
 <1b2f04fc-05a0-4f09-c84e-dc7adc63ec63@redhat.com>
 <20190215063250.GB30250@jeknote.loshitsa1.net>
 <20190217215242.GA12656@jeknote.loshitsa1.net>
 <416a0e12-aa0e-e781-2ef2-f11b97ba77a0@redhat.com>
 <CAKWEGV7r_026NhT96AiXJUT_9WOTy_=DC3Kx9qVNRfjWmMkEBA@mail.gmail.com>
 <8e3d9949-4bd3-f229-ace4-196a5f08fad3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e3d9949-4bd3-f229-ace4-196a5f08fad3@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 02:39:55PM +0100, Hans de Goede wrote:
> > > I also wonder if you've considered just disabling the extcon driver
> > > for the PMIC leaving it in automatic mode. Unlike the GPD win / pocket
> > > with their Type-C connector, your device seems to actually be using
> > > the PMIC as it was designed, so the automatic mode might just work
> > > and not touching the PMIC at all might be best.
> > 
> > Hm. We need to detect charger type (which can be kind of ACA) and set charging
> > limit properly, control OTG boost converter of the charger, request
> > hi-voltage charging etc.
> > I am not sure that this is possible without of software intervention.
> > Mixing of software
> > events handling with hardware charging control will be a source of
> > errors and instability.
> > So, no, I didn't think about HW-controlled charging when Linux is
> > running. But this may
> > be subject of future investigation.
> 
> Ok, I was hoping that the CCSM hardware would automatically do charger-type
> detection and set the input-current-limit accordingly.

I have checked this. UEFI firmware configures PMIC to SW-controlled
mode if no OTG cable connected at start. If change PMIC mode to
HW-controlled, charging works but no IINLIM control by PMIC is observed
(ILIM pin is disabled and 0x00 register value is not changed). When OTG
cable is connected, bq25892 registers are not changed also (OTG boost
converter is disabled).

So, I consider that this machine is designed for software charging and
OTG mode control.


> > > > Q: In theory, enabling of 'charge enable' output without of properly
> > > > configuration of external charger can cause some problems (USB overload,
> > > > battery overcurrent etc.). I think that there are no such stupidly
> > > > designed devices exist but we cannot be sure. What should we do with this?
> > > 
> > > This should not be a problem, the input-current-limit of the charger
> > > will already be setup by the firmware at boot and if a charger gets
> > > plugged in later then the input-current-limit will reset to 500mA.
> > > 
> > > Likewise the max charging current for the battery should already
> > > be configured properly by the firmware (this must be the case since
> > > the device will also charge while off) and we don't even know what
> > > the max charging current for the battery is, so we just have to rely
> > > on the firmware/BIOS here.
> > 
> > In the Lenovo Yoga Book the firmware seems to set safe input current limit
> > only (500 mA). Fast charging can be enabled by software and exactly value
> > of limits for this are known from Lenovo's sources only...
> 
> The input-current-limit only specifies how much current the charger may
> draw from the micro-usb for both supplying the laptop as well as for
> charging the battery combined. You can safely set this as high as
> the charger can handle (2A for a dedicated charger).
> 
> The BQ25892 should have a *separate* setting for the max current to
> use while charging the battery (assuming that the input current allows
> drawing enough current in the first place). I would hope that those bits
> have some sane value set from the firmware...

Yes, the charger has separate battery current limit but firmware doesn't
change its default value (2048 mA) while Lenovo's software driver does.
It set battery charging limit to 4 A and input limit to 2 A (it makes
sense because Lenovo adapter and BQ25892 both support voltage increasing
upto 12V).


-- 
Yauhen Kharuzhy
