Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE68C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C842214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C842214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730430AbeKUXKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 18:10:53 -0500
Received: from mga04.intel.com ([192.55.52.120]:41291 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728428AbeKUXKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 18:10:53 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2018 04:36:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,261,1539673200"; 
   d="scan'208";a="109992326"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 21 Nov 2018 04:36:38 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 21 Nov 2018 14:36:37 +0200
Date:   Wed, 21 Nov 2018 14:36:37 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/4] device property: Add fwnode_get_name() helper
Message-ID: <20181121123637.GB26377@kuha.fi.intel.com>
References: <20181108165156.60073-1-heikki.krogerus@linux.intel.com>
 <4687553.lNXoFSueqb@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4687553.lNXoFSueqb@aspire.rjw.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 11:03:45PM +0100, Rafael J. Wysocki wrote:
> On Thursday, November 8, 2018 5:51:52 PM CET Heikki Krogerus wrote:
> > Hi,
> > 
> > This is the second version of my proposal for this helper. The
> > first version can be checked here:
> > https://lkml.org/lkml/2018/11/5/326
> > 
> > In order to support also ACPI properly, I decided to change the API.
> > The function fwnode_name() is now fwnode_get_name(), and instead of
> > returning pointer to the name, the function copies it to a buffer. I
> > did that because acpica does not offer a way to get a pointer to the
> > node name, and the name is clearly expected to be accessed only with
> > the namespace lock held.
> > 
> > I think this is better approach in any case. It will also solve the
> > problem of getting rid of the unit-address part from DT node names.
> > 
> > Let me know what you guys think.
> > 
> > --
> > heikki
> > 
> > 
> > Heikki Krogerus (4):
> >   device property: Introduce fwnode_get_name()
> >   ACPI: property: Add acpi_fwnode_name()
> >   of/property: Add of_fwnode_name()
> >   device property: Drop get_named_child_node callback
> > 
> >  drivers/acpi/property.c  | 43 ++++++++++++++++++++++------------------
> >  drivers/base/property.c  | 34 ++++++++++++++++++++++++++++++-
> >  drivers/of/property.c    | 26 ++++++++++--------------
> >  include/linux/fwnode.h   |  6 +++---
> >  include/linux/property.h |  2 ++
> >  5 files changed, 73 insertions(+), 38 deletions(-)
> > 
> > 
> 
> I will be expecting at least one more iteration of this series to address the
> Rob's comments.

Yes, I'll send a new version soon.

thanks,

-- 
heikki
