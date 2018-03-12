Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751322AbeCLNDc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 09:03:32 -0400
Received: from mga17.intel.com ([192.55.52.151]:64076 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751104AbeCLNDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 09:03:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,461,1515484800";
   d="scan'208";a="24481055"
Message-ID: <1520859807.10722.591.camel@linux.intel.com>
Subject: Re: [PATCH v9] mmc: Export host capabilities to debugfs.
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Harish Jenny K N <harish_kandiga@mentor.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Vladimir_Zapolskiy@mentor.com" <Vladimir_Zapolskiy@mentor.com>
Date: Mon, 12 Mar 2018 15:03:27 +0200
In-Reply-To: <329d521d-1776-43ee-2f0e-e9690c29a693@mentor.com>
References: <1520829090-3567-1-git-send-email-harish_kandiga@mentor.com>
         <1520849262.10722.582.camel@linux.intel.com>
         <DM5PR04MB10854C79897A80023EF37F76FCD30@DM5PR04MB1085.namprd04.prod.outlook.com>
         <540fef96-aa2f-e6c3-467d-bc1d021dd55b@mentor.com>
         <DM5PR04MB10859F389CA2D1F2370C02CFFCD30@DM5PR04MB1085.namprd04.prod.outlook.com>
         <329d521d-1776-43ee-2f0e-e9690c29a693@mentor.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-03-12 at 18:00 +0530, Harish Jenny K N wrote:


> > > > > > +	for_each_set_bit(bit, (const unsigned long *)&caps,
> > > > > > BITS_PER_LONG)
> > > > > > +	for_each_set_bit(bit, (const unsigned long
> > > > > > *)&caps2,
> > > > > > BITS_PER_LONG)
> > > > > 
> > > > > Explicit casting is not needed anymore in both cases.
> > > > 
> > > > Also maybe use sizeof(mmc_host_capabilities) instead of
> > > > BITS_PER_LONG?
> > > 
> > > You mean sizeof(caps) and not sizeof(mmc_host_capabilities) .
> > > Right ?
> > 
> > meant ARRAY_SIZE(mmc_host_capabilities)

> ARRAY_SIZE(mmc_host_capabilities) will be 32 and this will be my old
> change for which I got a comment from Andy Shevchenko asking me to
> replace u32 with unsigned long.
> 
> This is the old comment:
> 
> > > +    int size = sizeof(u32) * BITS_PER_BYTE;
> > 
> > This is redundant. Use BITS_PER_LONG (why's that, see below) in the

There is nothing about ARRAY_SIZE().
ARRAY_SIZE() will work quite good as well.

> for_each_set_bit().
> 
> > > +    for_each_set_bit(bit, (const unsigned long *)&caps, size)
> > > +    for_each_set_bit(bit, (const unsigned long *)&caps2, size)
> > 
> > These are UB cases.
> > Fix is simple, replace u32 by unsigned long in (1) above.
> 
> Note: Without typecasting &caps to(const unsigned long *) will give
> compilation error in this case.

What kind of?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
