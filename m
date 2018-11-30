Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80C1C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DD752146F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:12:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DD752146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbeK3XVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 18:21:41 -0500
Received: from mga12.intel.com ([192.55.52.136]:1732 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbeK3XVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 18:21:41 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2018 04:12:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,298,1539673200"; 
   d="scan'208";a="97254513"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga008.jf.intel.com with SMTP; 30 Nov 2018 04:12:32 -0800
Received: by lahna (sSMTP sendmail emulation); Fri, 30 Nov 2018 14:12:31 +0200
Date:   Fri, 30 Nov 2018 14:12:31 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 09/15] i2c: acpi: Introduce
 i2c_acpi_get_i2c_resource() helper
Message-ID: <20181130121231.GO3078@lahna.fi.intel.com>
References: <20181128114535.80223-1-andriy.shevchenko@linux.intel.com>
 <20181128114535.80223-10-andriy.shevchenko@linux.intel.com>
 <20181130095533.GC1079@kunai>
 <20181130105759.GK10650@smile.fi.intel.com>
 <20181130110652.ckj75wrxxaez2sq2@ninjato>
 <20181130114543.GM10650@smile.fi.intel.com>
 <20181130114950.av6pnedcqu27jyjc@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130114950.av6pnedcqu27jyjc@ninjato>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 12:49:50PM +0100, Wolfram Sang wrote:
> 
> > > Is this something we have to live with or which can be cleaned up
> > > somewhen?
> > 
> > My opinion that we might need something like
> > drivers/acpi/acpi_i2c_lib.c
> > drivers/acpi/acpi_gpio_lib.c
> > etc.
> >
> 
> Collect all of them in drivers/acpi/acpi_libs.c?
> 
> > But better to ask Rafael and Mika what they think about this.

IMHO all the bus specific ACPI things should go under those buses (so
the opposite what is proposed here) but I also don't think any of this
is show stopper for the patch series under discussion ;-)
