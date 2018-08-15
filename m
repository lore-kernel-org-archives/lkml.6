Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FBAC43615
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 23:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB4D2087E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 23:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CB4D2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731293AbeHPCsv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 22:48:51 -0400
Received: from mga11.intel.com ([192.55.52.93]:6875 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729147AbeHPCsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 22:48:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2018 16:54:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,245,1531810800"; 
   d="scan'208";a="224965644"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by orsmga004.jf.intel.com with ESMTP; 15 Aug 2018 16:54:13 -0700
Received: from orsmsx102.amr.corp.intel.com ([169.254.3.148]) by
 ORSMSX105.amr.corp.intel.com ([169.254.2.117]) with mapi id 14.03.0319.002;
 Wed, 15 Aug 2018 16:54:13 -0700
From:   "Wyborny, Carolyn" <carolyn.wyborny@intel.com>
To:     Maik Broemme <mbroemme@libmpq.org>
CC:     netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Subject: RE: [BUG] Kernel Oops and crash using i40e VF devices
Thread-Topic: [BUG] Kernel Oops and crash using i40e VF devices
Thread-Index: AQHUNKSMop7YvxzFokecKdGtfjy7faTBFmHggADLVID//5DuYA==
Date:   Wed, 15 Aug 2018 23:54:13 +0000
Message-ID: <9BBC4E0CF881AA4299206E2E1412B6267C5EAB0D@ORSMSX102.amr.corp.intel.com>
References: <20180815142346.GC2354@libmpq.org>
 <9BBC4E0CF881AA4299206E2E1412B6267C5EA4D6@ORSMSX102.amr.corp.intel.com>
 <20180815225346.GE2354@libmpq.org>
In-Reply-To: <20180815225346.GE2354@libmpq.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZWVkNWY4ZjItODhhNS00ODdhLWJhNzUtODAwNDQ5OWQ0N2I3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiUkZcL3dSWFBIandrdldoeFZIMGZBdktaN0x1UThJV2RJclZ3Q2VuSGpja1VhU1BGQ0ZCY01iVGtSUCtIeFREZGMifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Maik Broemme [mailto:mbroemme@libmpq.org]
> Sent: Wednesday, August 15, 2018 3:54 PM
> To: Wyborny, Carolyn <carolyn.wyborny@intel.com>
> Cc: netdev <netdev@vger.kernel.org>; linux-kernel <linux-
> kernel@vger.kernel.org>
> Subject: Re: [BUG] Kernel Oops and crash using i40e VF devices
> 
Thanks for this info.  I have some questions below.

> Hi Carolyn,
[..]
> > > Hi,
> > >
> > > I have a SuperMicro X11SPM-F mainboard with two Intel X722 devices
> > > which
> > > support up to 32 VF devices per PF device. They are running with i40e
> > > driver. Whenever I try to use the VF devices in Xen VMs, the host kernel
> > > got an Oops or crash. In all cases the PF running on the host
> > > immediately loses network connection. I can reproduce this always
> > > running the following:
> > >
> > We have some known issues around this problem.  I'll need some more
> info to debug it.
[..]
> After boot I have a script which runs a set of commands to create all
> the VFs, assign MACs to VFs, enable trust on VFs and add them to pciback
> driver for Xen. This runs all fine. After that I start VMs via xl create
> command.
> 
> > What drivers are loaded on all ports?
> 
> The X11SPM-F has only 2x 1 GbE ports and they are both using 'i40e.ko'
> module as driver. Also I've blacklisted the 'i40evf.ko' module on Xen
> host (Dom0) to not load it when VF devices are created as they will be
> assigned to 'xen-pciback.ko' with pciback driver.
[..]
> > Do you have any virtualization configured in your setup?
> 
> Yes, I'm using Xen 4.11.0 from Arch Linux. I'm maintainer of the
> package.
> 
> > If so, what exactly and how are the ethernet devices configured in that?
> 
> Inside VMs I use either 4.17.x (+PREEMPT) or 4.14.x LTS (-PREEMPT)
> version. Both are using stock kernel version of 'i40evf.ko' module.

[CMW]Above you said you blacklist the i40evf driver and use the xen-pciback driver.  Do you load the i40evf driver again then at a later time?
This isn't a configuration I'm familiar with.  Can I get the full dmesg log from a system showing the problem?  You can post it in a bug at SourceForge, pastebin or something like that to save space on this thread.

[CMW]To find out exactly what kind of MDD error is occurring involves some complicated debug operations because of a register issue in the part.  If  you want to do that, we should go offlist for the details due to the length, not because its anything private or hidden.  However, the most common reason is because of some traffic patterns and a configuration detail in our drivers that was not complete at release.  I will investigate the combination of driver and patches to see if there may be some driver patches you'll need to apply.
> 
> >
> > Thanks,
> >
> > Carolyn
> >
> > Carolyn Wyborny
> > Linux Development
> > Networking Division
> > Intel Corporation
> >
> >
> 
> --Maik
