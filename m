Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF17C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B5E20873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:40:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B5E20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbeK1Cie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 21:38:34 -0500
Received: from mga09.intel.com ([134.134.136.24]:7257 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726624AbeK1Cie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 21:38:34 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2018 07:40:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,287,1539673200"; 
   d="scan'208";a="94761700"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga006.jf.intel.com with ESMTP; 27 Nov 2018 07:40:13 -0800
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gRfTA-0002HP-FQ; Tue, 27 Nov 2018 17:40:12 +0200
Date:   Tue, 27 Nov 2018 17:40:12 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/13] i2c: acpi: Return error pointers from
 i2c_acpi_new_device()
Message-ID: <20181127154012.GX10650@smile.fi.intel.com>
References: <20181126150858.16901-1-andriy.shevchenko@linux.intel.com>
 <20181126150858.16901-6-andriy.shevchenko@linux.intel.com>
 <20181127090432.GK2296@lahna.fi.intel.com>
 <98674437-9374-32d4-4b25-dedd0cad5bea@redhat.com>
 <20181127114953.GQ2296@lahna.fi.intel.com>
 <20181127134623.GR10650@smile.fi.intel.com>
 <beaa7a4d-4548-7be9-604d-f9b80dee3980@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <beaa7a4d-4548-7be9-604d-f9b80dee3980@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 04:24:41PM +0100, Hans de Goede wrote:
> On 27-11-18 14:46, Andy Shevchenko wrote:
> > On Tue, Nov 27, 2018 at 01:49:53PM +0200, Mika Westerberg wrote:
> > > On Tue, Nov 27, 2018 at 10:16:25AM +0100, Hans de Goede wrote:
> > > > One problem is that i2c_new_device() currently simply returns NULL on all
> > > > errors. Andy, you could take a look how much work it is to make that return
> > > > an ERR_PTR too, or just check its return value and return ERR_PTR(-ENXIO) if
> > > > it fails for now...
> > > 
> > > I would use -ENODEV here and -EINVAL in case there is no ACPI companion :)
> > 
> > Sounds more traditional than ENXIO.
> > I would go the way Mika proposed if there is no objection.
> 
> Works for me, go for it.

Just sent a new version, but dropped your Rb in that very patch. Please, check
if everything is okay.

-- 
With Best Regards,
Andy Shevchenko


