Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2400DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED715213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED715213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbeK3GnP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:43:15 -0500
Received: from mga07.intel.com ([134.134.136.100]:21521 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbeK3GnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 01:43:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2018 11:36:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,295,1539673200"; 
   d="scan'208";a="95903904"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by orsmga006.jf.intel.com with ESMTP; 29 Nov 2018 11:36:42 -0800
Received: from orsmsx156.amr.corp.intel.com (10.22.240.22) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 29 Nov 2018 11:36:41 -0800
Received: from orsmsx122.amr.corp.intel.com ([169.254.11.147]) by
 ORSMSX156.amr.corp.intel.com ([169.254.8.146]) with mapi id 14.03.0415.000;
 Thu, 29 Nov 2018 11:36:41 -0800
From:   "Schmauss, Erik" <erik.schmauss@intel.com>
To:     Jean Delvare <jdelvare@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jean-Marc Lenoir <archlinux@jihemel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Subject: RE: [PATCH 4.14 044/100] ACPICA: AML interpreter: add region
 addresses in global list during initialization
Thread-Topic: [PATCH 4.14 044/100] ACPICA: AML interpreter: add region
 addresses in global list during initialization
Thread-Index: AQHUh+9yZ89du/4JL0qQiMsR1dgxa6VnWpEAgAAEbID//7sFAIAAjbmAgAADlID//3pzkA==
Date:   Thu, 29 Nov 2018 19:36:40 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53C551B2B@ORSMSX122.amr.corp.intel.com>
References: <20181129140058.768942700@linuxfoundation.org>
        <20181129140102.870510957@linuxfoundation.org>
        <1543502726.10991.13.camel@suse.de>     <20181129150115.GA22451@kroah.com>
        <CF6A88132359CE47947DB4C6E1709ED53C551AF7@ORSMSX122.amr.corp.intel.com>
        <20181129192136.GA13749@kroah.com> <20181129203425.63544638@endymion>
In-Reply-To: <20181129203425.63544638@endymion>
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
> From: Jean Delvare [mailto:jdelvare@suse.de]
> Sent: Thursday, November 29, 2018 11:34 AM
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Schmauss, Erik <erik.schmauss@intel.com>; linux-
> kernel@vger.kernel.org; stable@vger.kernel.org; Jean-Marc Lenoir
> <archlinux@jihemel.com>; Wysocki, Rafael J <rafael.j.wysocki@intel.com>
> Subject: Re: [PATCH 4.14 044/100] ACPICA: AML interpreter: add region
> addresses in global list during initialization
> 
> On Thu, 29 Nov 2018 20:21:37 +0100, Greg Kroah-Hartman wrote:
> > On Thu, Nov 29, 2018 at 06:56:40PM +0000, Schmauss, Erik wrote:
> > > This should only apply to 4.17 or later. I unintentionally put all
> > > applicable so please drop this for all 4.16 or earlier. I've learned
> > > my lesson and I'll put the correct tags from now on :-)
> >
> > Ok, now dropped from 4.14, thanks.
> 
> Should be dropped from 4.9 and 4.4 too... if it was not clear.

Yes, it should,

Thanks,
Erik
> 
> Thanks,
> --
> Jean Delvare
> SUSE L3 Support
