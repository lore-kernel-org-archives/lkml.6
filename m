Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A537BC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B009208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:20:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B009208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965869AbeFONUo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 09:20:44 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40926 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965798AbeFONUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 09:20:41 -0400
Received: by mail-lf0-f65.google.com with SMTP id q11-v6so14615359lfc.7;
        Fri, 15 Jun 2018 06:20:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V/AgDgQrHhlEmVMkoEpocS+os054B9n9JJ2RAiVOSp0=;
        b=Ai7AKnwzCf4Cu8gaaPGp6BVZvA/mFqG9ZkgTBai0eQvmCZDxEQ+0eftsJ7iYAtTXAB
         8MQl5AikQjxkXAZWs01+yfwGDeoVK+dmLPQw2xVA5zbFKF2Ad/CGt4L3wSAxnB8yNlVV
         wtX0VKdKC6SN6Hlm4vwrxjdKx7weGVYgf51e62ihxEB2o8Lxtw+Rkn2xvcV6jTDoZHrq
         olFobwOC3Z96mN7E7u+6VNhWUKgqvxylsxqRMZ5SavhAQelklu165XqTkXJNKd1SoFJ/
         PPhK/0bC9x/HqITBbjofUvmKd+KyUyIYnyxQAvE1BO0kYtn1uo1ngMT6/XPRB+ErO3HS
         xeEg==
X-Gm-Message-State: APt69E1Jokew05mpebaIX3KS5OK3KKCOmRSrIGLKffW8KK3ixy2X0F4x
        5H/7pahhMrpkHCzv0vcQ3v0=
X-Google-Smtp-Source: ADUXVKLlWTI0/471vVtwWp7XT3Fh6OyAeDOwv10llZCuF3Md0P89xIBTSUPKpGIOxleteEH0xTcOPg==
X-Received: by 2002:a19:d046:: with SMTP id h67-v6mr1194510lfg.52.1529068839876;
        Fri, 15 Jun 2018 06:20:39 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.34])
        by smtp.gmail.com with ESMTPSA id g18-v6sm1438140ljf.43.2018.06.15.06.20.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 06:20:38 -0700 (PDT)
Date:   Fri, 15 Jun 2018 16:20:10 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v4 2/6] mfd: bd71837: Devicetree bindings for ROHM
 BD71837 PMIC
Message-ID: <20180615132010.GA28784@localhost.localdomain>
References: <20180531071717.GG13528@localhost.localdomain>
 <20180531102315.GA5150@localhost.localdomain>
 <CAL_Jsq+33G7zMEDOUXHQijxqqbvqykxZENLe1-52ECkXwo2o4g@mail.gmail.com>
 <20180601062540.GB5150@localhost.localdomain>
 <CAL_JsqJNMxR=zdwR41iLfWU=u3J_=_VkxVL+g3a12_4vvNwBtw@mail.gmail.com>
 <20180604113225.GE5150@localhost.localdomain>
 <CAL_JsqL3Z_o2CFeYDvb3PqgiskTSHuOVqwdUP+gFymLDTKhn2g@mail.gmail.com>
 <20180606073449.GD20078@localhost.localdomain>
 <CAL_JsqKjwtq+7CSDKiaWGa011oqdsrc-XjOyfuBPOQ9UB=EtWQ@mail.gmail.com>
 <20180607111218.GF20078@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607111218.GF20078@localhost.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 02:12:18PM +0300, Matti Vaittinen wrote:
> On Wed, Jun 06, 2018 at 10:16:37AM -0500, Rob Herring wrote:
> > On Wed, Jun 6, 2018 at 2:34 AM, Matti Vaittinen
> > <mazziesaccount@gmail.com> wrote:
> > > On Tue, Jun 05, 2018 at 10:46:14AM -0500, Rob Herring wrote:
> > >> On Mon, Jun 4, 2018 at 6:32 AM, Matti Vaittinen
> > >> <mazziesaccount@gmail.com> wrote:
> > >> > On Fri, Jun 01, 2018 at 12:32:16PM -0500, Rob Herring wrote:
> > >> >> On Fri, Jun 1, 2018 at 1:25 AM, Matti Vaittinen
> > >> >> <mazziesaccount@gmail.com> wrote:
> > >> >> > On Thu, May 31, 2018 at 09:07:24AM -0500, Rob Herring wrote:
> > >> >> >> On Thu, May 31, 2018 at 5:23 AM, Matti Vaittinen
> > >> >> >> <mazziesaccount@gmail.com> wrote:
> > >> >> >> > On Thu, May 31, 2018 at 10:17:17AM +0300, Matti Vaittinen wrote:
> > >> >> >> >> On Wed, May 30, 2018 at 10:01:29PM -0500, Rob Herring wrote:
> > >> >> >> >> > On Wed, May 30, 2018 at 11:42:03AM +0300, Matti Vaittinen wrote:

> > So it looks like this is just regulators with a few other signals to handle.
> 
> Yes. Regulators and the HW state machine which is currently mostly
> bypassed by drivers. And while we are at it - is there some standard
> device-tree properties for describing the voltages for different PMIC states
> (idle, run, standby) so that the driver could configure voltages the
> bucks should use when PMIC state is changed. Or do you think I should
> use custom ones like:
> 
> bd71837,pmic-buck1-dvs-voltage = <900000>, <850000>, <800000>; /* VDD_SOC: Run-Idle-Suspend */
> bd71837,pmic-buck2-dvs-voltage = <1000000>, <900000>, <0>; /* VDD_ARM: Run-Idle */
> bd71837,pmic-buck3-dvs-voltage = <1000000>, <0>, <0>; /* VDD_GPU: Run */
> bd71837,pmic-buck4-dvs-voltage = <1000000>, <0>, <0>; /* VDD_VPU: Run */
> 
> I think this is not the only PMIC with configurable voltages for
> different states so someone has probably already invented a way to
> provide this information - is the DT correct place to search for this?

I will leave this out for now. Guess this can be added later.

> 
> > 
> > > So HW mapping for interrup(s) from PMIC would be:
> > >
> > > (HW) event => BD71837 domain IRQ
> > >
> > > PMIC_STBY_REQ line level change         => 0
> > > PMIC_ON_REQ line level change           => 1
> > 
> > I'm not really clear how these would have s/w handling. They look like
> > handshake signals for the processor to enter and exit standby/suspend.
> > H/w designers don't always know what to do with things and may have
> > just said lets have an interrupt for every input signal.
> 

Well, I will only handle the power button irq as you suggested for now.

> > > PMIC_PWRON_B line level change          => 3
> > > PMIC_PWRON_B line/long push detected    => 4
> > > PMIC_PWRON_B line/short push detected   => 5
> > 
> > So you need a power button driver (or maybe not even a separate
> > driver) for this, but I don't think that warrants a child node. I
> > think some PMIC drivers just generate a power key press (which just
> > gets punted to userspace), but some will do an actual power down. Or
> > maybe a combination of those based on short/long press.

I add power button driver (and input subsystem people) tp next patch
set. I think I will later also add power/reset driver because PMIC can
do reset for the system. Unfortunately the PMIC can't provide power-off.
But I leave this out from this series.

> > I think there's already some DT properties defined to control the
> > behavior as well.
> > 
> > > SWRESET register on PMIC written        => 6
> > 
> > Probably this can be handled within the core driver. Seems like you'd
> > only use this if you have separate entities that write and read this.
> > If you don't know, then just ignore it for now.

I planned to use SWRESET for power/reset driver - but irq handling is
not needed there.

> > > Hence I liked the idea of hiding the irq register
> > > details in MFD driver by declaring it as interrupt controller - and
> > > leaving the interrupts to be used by what ever drivers need the change
> > > information is system the PMIC is used.
> > 
> > This can still be done but doesn't have to be in DT.
> 
> I think this is my weak spot. I don't know how to do this easily without
> DT.

I think I found the correct way - I'll send the patch v6 soon. I hope it
addresses this issue correctly.

Best Regards
	Matti Vaittinen
