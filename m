Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F54FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 13:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E7A3208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 13:46:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E7A3208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbeK1Ao1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 19:44:27 -0500
Received: from mga05.intel.com ([192.55.52.43]:20267 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbeK1Ao1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 19:44:27 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2018 05:46:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,286,1539673200"; 
   d="scan'208";a="92841171"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga007.jf.intel.com with ESMTP; 27 Nov 2018 05:46:24 -0800
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gRdh1-0001cs-LI; Tue, 27 Nov 2018 15:46:23 +0200
Date:   Tue, 27 Nov 2018 15:46:23 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/13] i2c: acpi: Return error pointers from
 i2c_acpi_new_device()
Message-ID: <20181127134623.GR10650@smile.fi.intel.com>
References: <20181126150858.16901-1-andriy.shevchenko@linux.intel.com>
 <20181126150858.16901-6-andriy.shevchenko@linux.intel.com>
 <20181127090432.GK2296@lahna.fi.intel.com>
 <98674437-9374-32d4-4b25-dedd0cad5bea@redhat.com>
 <20181127114953.GQ2296@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127114953.GQ2296@lahna.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 01:49:53PM +0200, Mika Westerberg wrote:
> On Tue, Nov 27, 2018 at 10:16:25AM +0100, Hans de Goede wrote:
> > One problem is that i2c_new_device() currently simply returns NULL on all
> > errors. Andy, you could take a look how much work it is to make that return
> > an ERR_PTR too, or just check its return value and return ERR_PTR(-ENXIO) if
> > it fails for now...
> 
> I would use -ENODEV here and -EINVAL in case there is no ACPI companion :)

Sounds more traditional than ENXIO.
I would go the way Mika proposed if there is no objection.

-- 
With Best Regards,
Andy Shevchenko


