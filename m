Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C066EC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 888882080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:44:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 888882080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbeJ3Cdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:33:37 -0400
Received: from mga14.intel.com ([192.55.52.115]:45276 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727743AbeJ3Cdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 22:33:37 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2018 10:44:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,441,1534834800"; 
   d="scan'208";a="276611549"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga006.fm.intel.com with ESMTP; 29 Oct 2018 10:43:57 -0700
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1gHBa0-0002Pu-AI; Mon, 29 Oct 2018 19:43:56 +0200
Date:   Mon, 29 Oct 2018 19:43:56 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Rajat Jain <rajatja@google.com>
Cc:     Dmitry Torokhov <dtor@google.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] mmc: sdhci-pci: Try "cd" for card-detect lookup before
 using NULL
Message-ID: <20181029174356.GR10650@smile.fi.intel.com>
References: <CACRpkdY7eaYk81CU8gmHKfWB82_qNJur=c=7SCRuW+BNeL=Oiw@mail.gmail.com>
 <20181018215101.169847-1-rajatja@google.com>
 <CAHp75Vd_r4QGR5xw2cJigM2J3WStg_0PdynBXMZOyZh+t1znKg@mail.gmail.com>
 <CACK8Z6HOsUcPFyf-GguxPxh_Zdj6gCXP=FpGw-vQXJfnM=cquw@mail.gmail.com>
 <20181024100230.GQ10650@smile.fi.intel.com>
 <CAE_wzQ-80NCNbzbFx1eEDwEEOEAbv-5u+W171iUagY2pOahbmw@mail.gmail.com>
 <CAHp75VfMHqT+aAGVaXzXGbzF2=VEABOOaGhkjfV-D0NPbBM+Rw@mail.gmail.com>
 <CACK8Z6GMsfVEpefzwvVgS44Eg=PQzcNOaC3GA9F2OzrBxvpchw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACK8Z6GMsfVEpefzwvVgS44Eg=PQzcNOaC3GA9F2OzrBxvpchw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 10:22:02AM -0700, Rajat Jain wrote:
> On Mon, Oct 29, 2018 at 8:23 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Wed, Oct 24, 2018 at 9:03 PM Dmitry Torokhov <dtor@google.com> wrote:
> > > On Wed, Oct 24, 2018 at 3:02 AM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Mon, Oct 22, 2018 at 04:34:55PM -0700, Rajat Jain wrote:
> > > > > On Fri, Oct 19, 2018 at 2:13 AM Andy Shevchenko
> > > > > <andy.shevchenko@gmail.com> wrote:

> > > > > Also, the driver may not
> > > > > really know?
> > > >
> > > > I think in such case the bug in HW design and / or driver.
> > >
> > > Why? You can have a shared or dedicated interrupt and the driver does
> > > not really need to know if it can poll the status.
> >
> > Yes, that's my point either we get 1:1 mapping between slot and GPIOs
> > or have a possibility to read back from some register(s) the actual
> > status of all of them, otherwise it's a bad design.
> 
> No, AFAIU, the driver only should only be able to read the status of
> *the* interrupt that was fired? (as opposite to the ability to read
> *all of them* when an interrupt fires).

I can't be sure in the details of this (sdhci) driver, I'm not a maintainer of
that one. So, my above conclusions are purely generic.

> > > > > 2) I'm not really sure what should I set "active_low" to? Isn't this
> > > > > something that should be specified by platform / ACPI too, and driver
> > > > > should just be able to say say choose whatever the ACPI says?
> > > > >
> > > > > struct acpi_gpio_params {
> > > > >         unsigned int crs_entry_index;
> > > > >         unsigned int line_index;
> > > > >         bool active_low;
> > > > > };


> > > > ACPI specification misses this property, that's why we have it in the
> > > > structure. In your case it should be provided by _DSD and thus be consistent
> > > > with the hardcoded values.
> > >
> > > Again, you think as if the driver was platform specific; it is not. I
> > > have 1000s of systems with different ACPI tables. Let's say half of
> > > them use one polarity, and half another. Which polarity do you propose
> > > to use?
> >
> > Use one table for one half and another for the rest.
> 
> But how does driver determine which table to use for which platform?
> (Currently the driver is platform independent).

Based on vendor and device IDs in any form of it.

-- 
With Best Regards,
Andy Shevchenko


