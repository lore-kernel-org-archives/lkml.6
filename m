Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7469FC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 464D52082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:45:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 464D52082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbeK3Wys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 17:54:48 -0500
Received: from mga02.intel.com ([134.134.136.20]:6404 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbeK3Wys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 17:54:48 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2018 03:45:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,298,1539673200"; 
   d="scan'208";a="96252451"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga006.jf.intel.com with ESMTP; 30 Nov 2018 03:45:45 -0800
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gShEt-0002iQ-Vz; Fri, 30 Nov 2018 13:45:43 +0200
Date:   Fri, 30 Nov 2018 13:45:43 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 09/15] i2c: acpi: Introduce
 i2c_acpi_get_i2c_resource() helper
Message-ID: <20181130114543.GM10650@smile.fi.intel.com>
References: <20181128114535.80223-1-andriy.shevchenko@linux.intel.com>
 <20181128114535.80223-10-andriy.shevchenko@linux.intel.com>
 <20181130095533.GC1079@kunai>
 <20181130105759.GK10650@smile.fi.intel.com>
 <20181130110652.ckj75wrxxaez2sq2@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130110652.ckj75wrxxaez2sq2@ninjato>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 12:06:52PM +0100, Wolfram Sang wrote:
> > > >  drivers/i2c/i2c-core-acpi.c | 41 ++++++++++++++++++++++++++-----------
> > > >  include/linux/acpi.h        | 11 ++++++++++
> > > 
> > > Any reason this is not in i2c.h?
> > 
> > Yes. As I explained earlier to some people there are facts affecting this:
> > - the function is operate on top of solely ACPI structures
> 
> And moving the function itself to the ACPI realm then?

Unfortunately I don't see the place where it fits good. See below.

> I don't say this is a show-stopper for this series, but I just wonder...
> 
> > - there is already similar function for GPIO and it stays like that
> > 
> > On top of this recently I've discovered, that i2c.h has separate #ifdef for I2C
> > and ACPI which theoretically might produce a linker error in some cases.
> 
> Is this something we have to live with or which can be cleaned up
> somewhen?

My opinion that we might need something like
drivers/acpi/acpi_i2c_lib.c
drivers/acpi/acpi_gpio_lib.c
etc.

But better to ask Rafael and Mika what they think about this.

-- 
With Best Regards,
Andy Shevchenko


