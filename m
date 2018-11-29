Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0CDC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 301182082F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 301182082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbeK3GDE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:03:04 -0500
Received: from mga17.intel.com ([192.55.52.151]:57846 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbeK3GDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 01:03:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2018 10:56:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,295,1539673200"; 
   d="scan'208";a="105103646"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by orsmga003.jf.intel.com with ESMTP; 29 Nov 2018 10:56:40 -0800
Received: from orsmsx111.amr.corp.intel.com (10.22.240.12) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 29 Nov 2018 10:56:40 -0800
Received: from orsmsx122.amr.corp.intel.com ([169.254.11.147]) by
 ORSMSX111.amr.corp.intel.com ([169.254.12.187]) with mapi id 14.03.0415.000;
 Thu, 29 Nov 2018 10:56:40 -0800
From:   "Schmauss, Erik" <erik.schmauss@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean Delvare <jdelvare@suse.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jean-Marc Lenoir <archlinux@jihemel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Subject: RE: [PATCH 4.14 044/100] ACPICA: AML interpreter: add region
 addresses in global list during initialization
Thread-Topic: [PATCH 4.14 044/100] ACPICA: AML interpreter: add region
 addresses in global list during initialization
Thread-Index: AQHUh+9yZ89du/4JL0qQiMsR1dgxa6VnWpEAgAAEbID//7sFAA==
Date:   Thu, 29 Nov 2018 18:56:40 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53C551AF7@ORSMSX122.amr.corp.intel.com>
References: <20181129140058.768942700@linuxfoundation.org>
 <20181129140102.870510957@linuxfoundation.org>
 <1543502726.10991.13.camel@suse.de> <20181129150115.GA22451@kroah.com>
In-Reply-To: <20181129150115.GA22451@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg Kroah-Hartman [mailto:gregkh@linuxfoundation.org]
> Sent: Thursday, November 29, 2018 7:01 AM
> To: Jean Delvare <jdelvare@suse.de>
> Cc: linux-kernel@vger.kernel.org; stable@vger.kernel.org; Jean-Marc Lenoir
> <archlinux@jihemel.com>; Schmauss, Erik <erik.schmauss@intel.com>;
> Wysocki, Rafael J <rafael.j.wysocki@intel.com>
> Subject: Re: [PATCH 4.14 044/100] ACPICA: AML interpreter: add region
> addresses in global list during initialization
> 
> On Thu, Nov 29, 2018 at 03:45:26PM +0100, Jean Delvare wrote:
> > Hi Greg,
> >
> > On Thu, 2018-11-29 at 15:12 +0100, Greg Kroah-Hartman wrote:
> > > 4.14-stable review patch.  If anyone has any objections, please let me
> know.
> > >
> > > ------------------
> > >
> > > From: Erik Schmauss <erik.schmauss@intel.com>
> > >
> > > commit 4abb951b73ff0a8a979113ef185651aa3c8da19b upstream.
> > >
> > > The table load process omitted adding the operation region address
> > > range to the global list. This omission is problematic because the
> > > OS queries the global list to check for address range conflicts
> > > before deciding which drivers to load. This commit may result in
> > > warning messages that look like the following:
> > >
> > > [    7.871761] ACPI Warning: system_IO range 0x00000428-0x0000042F
> conflicts with op_region 0x00000400-0x0000047F (\PMIO)
> (20180531/utaddress-213)
> > > [    7.871769] ACPI: If an ACPI driver is available for this device, you should
> use it instead of the native driver
> > >
> > > However, these messages do not signify regressions. It is a result
> > > of properly adding address ranges within the global address list.
> > >
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=200011
> > > Tested-by: Jean-Marc Lenoir <archlinux@jihemel.com>
> > > Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
> > > Cc: All applicable <stable@vger.kernel.org>
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Cc: Jean Delvare <jdelvare@suse.de>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
> > I'm confused. While we were discussing the regression, Erik said that
> > this is fixing commit 5a8361f7ecceaed64b4064000d16cb703462be49, which
> > went upstream in v4.17. So how can the fix be needed in any kernel
> > older than v4.17? Erik, did I understand you incorrectly?
> 
Hi Greg,

> The patch says "All applicable", and I assumed that meant, "as long as it
> applies."
>
> Erik, should I drop this from 4.14.y?

This should only apply to 4.17 or later. I unintentionally put all applicable so
please drop this for all 4.16 or earlier. I've learned my lesson and I'll put the
correct tags from now on :-)

Erik
> 
> thanks,
> 
> greg k-h
