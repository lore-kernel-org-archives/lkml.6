Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D058C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43F38218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbfAYRou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 12:44:50 -0500
Received: from mga07.intel.com ([134.134.136.100]:37562 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbfAYRot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 12:44:49 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jan 2019 09:44:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,522,1539673200"; 
   d="scan'208";a="133109563"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga001.jf.intel.com with ESMTP; 25 Jan 2019 09:44:44 -0800
Received: from andy by smile with local (Exim 4.92-RC4)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gn5X0-0003Yx-TN; Fri, 25 Jan 2019 19:44:42 +0200
Date:   Fri, 25 Jan 2019 19:44:42 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFT][PATCH v2] gpiolib: acpi: Introduce
 ACPI_GPIO_QUIRK_ONLY_GPIOIO
Message-ID: <20190125174442.GR9224@smile.fi.intel.com>
References: <20190109105245.25954-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdZAOaqPQkKzyNate3A67Ce0T+V7ig+Y3BV4ycx==U5jkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZAOaqPQkKzyNate3A67Ce0T+V7ig+Y3BV4ycx==U5jkQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 02:03:09PM +0100, Linus Walleij wrote:
> On Wed, Jan 9, 2019 at 11:52 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > New quirk enforces search for GPIO based on its type,
> > i.e. iterate over GpioIo resources only.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >
> > - it was sent few weeks ago to Hans for testing, but better to re-test
> > - it's supposed to go via ASoC subsystem due to recent changes made for
> >   sound driver
> >
> > v2:
> > - Expand explanation why this quirk might be needed (Mika)
> 
> I tried to apply this but it doesn't apply on the GPIO devel
> branch.
> 
> I suppose because of Hans de Goede's
> commit 72893f0c6bd399ce84e3c1c9fc69d234fe37d098
> Author: Hans de Goede <hdegoede@redhat.com>
> Date:   Mon Dec 31 21:55:21 2018 +0100
> 
>     gpiolib-acpi: Preserve non direction flags when updating gpiod_flags
> 
> Could you rebase and resend?

Linus, as I mentioned in comments above this should go via ASoC tree, there is
no conflicts with gpio/devel for GPIO matters.

So, please, give your Ack and hopefully Mark will apply this soon.

> 
> (Also pick up Mika's ACK.)
> 
> PS I'm a bit split about pure ACPI patches, part of me see it as an
> "intel thing" so that you could very well collect it in the Intel
> GPIO tree and send me pull requests, on the other hand it is
> ACPI and sometimes applied in Rafael's tree. Maybe just as good
> that I keep picking them separately like this?
> 
> Yours,
> Linus Walleij

-- 
With Best Regards,
Andy Shevchenko


