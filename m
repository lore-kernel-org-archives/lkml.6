Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC23EC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 20:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23C020862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 20:38:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B23C020862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732348AbeHAW0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 18:26:04 -0400
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:51356 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729188AbeHAW0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 18:26:03 -0400
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g9t1613g.houston.hpe.com (Postfix) with ESMTPS id D1D6E61F3F;
        Wed,  1 Aug 2018 20:38:29 +0000 (UTC)
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id 1E2E259;
        Wed,  1 Aug 2018 20:38:29 +0000 (UTC)
Received: from hpe.com (ben.americas.hpqcorp.net [10.33.153.7])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 3E1254B;
        Wed,  1 Aug 2018 20:38:28 +0000 (UTC)
Date:   Wed, 1 Aug 2018 15:38:27 -0500
From:   Russ Anderson <rja@hpe.com>
To:     "Moore, Robert" <robert.moore@intel.com>
Cc:     Mike Travis <mike.travis@hpe.com>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Russ Anderson <russ.anderson@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] x86, pmem, acpi: Remove excessive ACPI Large
 Reference Count warnings
Message-ID: <20180801203827.ozkvldizkpsatmg5@hpe.com>
Reply-To: Russ Anderson <rja@hpe.com>
References: <20180730195545.795802877@stormcage.americas.sgi.com>
 <20180730195548.580717146@stormcage.americas.sgi.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B94DED8F@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E3B94DED8F@ORSMSX108.amr.corp.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 07:49:14PM +0000, Moore, Robert wrote:
> Are there any actual memory leaks, or this a consequence of the number of sockets?

It is a consequence of the number of sockets.
It is not an actual memory leak.

Thanks.

> > -----Original Message-----
> > From: Mike Travis [mailto:mike.travis@hpe.com]
> > Sent: Monday, July 30, 2018 12:56 PM
> > To: Moore, Robert <robert.moore@intel.com>; Schmauss, Erik
> > <erik.schmauss@intel.com>; Wysocki, Rafael J
> > <rafael.j.wysocki@intel.com>; Len Brown <lenb@kernel.org>
> > Cc: Russ Anderson <russ.anderson@hpe.com>; Dimitri Sivanich
> > <dimitri.sivanich@hpe.com>; Ross Zwisler <ross.zwisler@linux.intel.com>;
> > Williams, Dan J <dan.j.williams@intel.com>; Verma, Vishal L
> > <vishal.l.verma@intel.com>; Jiang, Dave <dave.jiang@intel.com>; linux-
> > acpi@vger.kernel.org; devel@acpica.org; linux-nvdimm@lists.01.org;
> > linux-kernel@vger.kernel.org
> > Subject: [PATCH 1/1] x86, pmem, acpi: Remove excessive ACPI Large
> > Reference Count warnings
> > 
> > With the Intel BIOS support for 8 processor sockets with a full
> > complement of NVDIMMS potentially installable, and there are empty
> > sockets without NVDIMMS, there is an extremely large amount of the
> > following warnings:
> > 
> > ACPI Warning: Large Reference Count (0x1001) in object ffff99453fc71750,
> > 	Type=0x0A
> > 
> > On a 4 socket system with 4 NVDIMMs there were over 6000 of these
> > warning messages and it has been seem on systems from 4 to 32 sockets.
> > 
> > Through some guidance from the BIOS developers and testing, it appears
> > that simply bumping up the threshold for warnings from 0x1000 to 0x2000
> > eliminates these messages.  Changing them to be ACPI DEBUG messages, or
> > even removing them are other options, but it would then defeat the
> > purpose of the warnings as the problem would effectively be hidden.
> > 
> > Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
> > Tested-by: Russ Anderson <russ.anderson@hpe.com>
> > Signed-off-by: Mike Travis <mike.travis@hpe.com>
> > ---
> >  include/acpi/acconfig.h |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > --- linux-4.12.orig/include/acpi/acconfig.h
> > +++ linux-4.12/include/acpi/acconfig.h
> > @@ -123,7 +123,7 @@
> > 
> >  /* Maximum object reference count (detects object deletion issues) */
> > 
> > -#define ACPI_MAX_REFERENCE_COUNT        0x1000
> > +#define ACPI_MAX_REFERENCE_COUNT        0x2000
> > 
> >  /* Default page size for use in mapping memory for operation regions */
> > 
> > 
> > --
> 

-- 
Russ Anderson,  SuperDome Flex Linux Kernel Group Manager
HPE - Hewlett Packard Enterprise (formerly SGI)  rja@hpe.com
