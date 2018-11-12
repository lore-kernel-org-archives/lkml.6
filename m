Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D34C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2492C22504
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:50:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2492C22504
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730234AbeKMDoQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 22:44:16 -0500
Received: from mga01.intel.com ([192.55.52.88]:64476 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbeKMDoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 22:44:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Nov 2018 09:50:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,496,1534834800"; 
   d="scan'208";a="107630187"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga001.jf.intel.com with ESMTP; 12 Nov 2018 09:49:59 -0800
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.166]) by
 ORSMSX102.amr.corp.intel.com ([169.254.3.81]) with mapi id 14.03.0415.000;
 Mon, 12 Nov 2018 09:49:59 -0800
From:   "Schmauss, Erik" <erik.schmauss@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jean-Marc Lenoir <archlinux@jihemel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Subject: RE: [PATCH 4.14 009/222] ACPICA: AML interpreter: add region
 addresses in global list during initialization
Thread-Topic: [PATCH 4.14 009/222] ACPICA: AML interpreter: add region
 addresses in global list during initialization
Thread-Index: AQHUeg5iQNe5nx4eb0uQcIEPT1lgyqVMYf6wgACPUQD//3osMA==
Date:   Mon, 12 Nov 2018 17:49:58 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53BB9FAF7@ORSMSX110.amr.corp.intel.com>
References: <20181111221647.665769131@linuxfoundation.org>
 <20181111221648.772697504@linuxfoundation.org>
 <CF6A88132359CE47947DB4C6E1709ED53BB9FAB9@ORSMSX110.amr.corp.intel.com>
 <20181112174636.GA15484@kroah.com>
In-Reply-To: <20181112174636.GA15484@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg Kroah-Hartman [mailto:gregkh@linuxfoundation.org]
> Sent: Monday, November 12, 2018 9:47 AM
> To: Schmauss, Erik <erik.schmauss@intel.com>
> Cc: linux-kernel@vger.kernel.org; stable@vger.kernel.org; Jean-Marc Lenoir
> <archlinux@jihemel.com>; Wysocki, Rafael J <rafael.j.wysocki@intel.com>
> Subject: Re: [PATCH 4.14 009/222] ACPICA: AML interpreter: add region
> addresses in global list during initialization
> 
> On Mon, Nov 12, 2018 at 05:16:19PM +0000, Schmauss, Erik wrote:
> >
> > > -----Original Message-----
> > > From: Greg Kroah-Hartman [mailto:gregkh@linuxfoundation.org]
> > > Sent: Sunday, November 11, 2018 2:22 PM
> > > To: linux-kernel@vger.kernel.org
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>;
> > > stable@vger.kernel.org; Jean-Marc Lenoir <archlinux@jihemel.com>;
> > > Schmauss, Erik <erik.schmauss@intel.com>; Wysocki, Rafael J
> > > <rafael.j.wysocki@intel.com>
> > > Subject: [PATCH 4.14 009/222] ACPICA: AML interpreter: add region
> > > addresses in global list during initialization
> > >
> > Hi Greg,
> >
> > > 4.14-stable review patch.  If anyone has any objections, please let me
> know.
> >
> > This patch is only meant to be added for kernels that are 4.17 or later.
> >
> > Please drop this from kernel 4.16 or older.
>
Hi Greg,
 
> Ok, but next time be a bit more careful when you add a line like this to the
> patch:
> 
> > > Cc: All applicable <stable@vger.kernel.org>
> 
> I take this to mean "everything it can apply cleanly to".

Thanks for the information! I will be more careful in the future

Erik
> 
> I'll go drop it from the 3.18.y, 4.4.y, and 4.9.y stable queues as well.
> 
> thanks,
> 
> greg k-h
