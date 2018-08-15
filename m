Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460D7C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D6521509
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:08:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23D6521509
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbeHOXBw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:01:52 -0400
Received: from mga18.intel.com ([134.134.136.126]:7751 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbeHOXBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:01:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2018 13:08:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,244,1531810800"; 
   d="scan'208";a="80569015"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga004.fm.intel.com with ESMTP; 15 Aug 2018 13:08:15 -0700
Received: from orsmsx157.amr.corp.intel.com (10.22.240.23) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 15 Aug 2018 13:08:15 -0700
Received: from orsmsx102.amr.corp.intel.com ([169.254.3.148]) by
 ORSMSX157.amr.corp.intel.com ([169.254.9.29]) with mapi id 14.03.0319.002;
 Wed, 15 Aug 2018 13:08:14 -0700
From:   "Wyborny, Carolyn" <carolyn.wyborny@intel.com>
To:     Maik Broemme <mbroemme@libmpq.org>, netdev <netdev@vger.kernel.org>
CC:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [BUG] Kernel Oops and crash using i40e VF devices
Thread-Topic: [BUG] Kernel Oops and crash using i40e VF devices
Thread-Index: AQHUNKSMop7YvxzFokecKdGtfjy7faTBFmHg
Date:   Wed, 15 Aug 2018 20:08:14 +0000
Message-ID: <9BBC4E0CF881AA4299206E2E1412B6267C5EA4D6@ORSMSX102.amr.corp.intel.com>
References: <20180815142346.GC2354@libmpq.org>
In-Reply-To: <20180815142346.GC2354@libmpq.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZTViZDM0NjQtNTZjMi00YTg1LWE0ZTgtNTU2YjA5YTljZjNmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoibCt4TjBVUVJ1Slh3b1pGdGxnS1wveXVRRWFBbGFud1lnaEJjVW0xdjdaNHZkN3Q5UHpIN0poMFwvVGtITlVqRUJ4In0=
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
> From: netdev-owner@vger.kernel.org [mailto:netdev-
> owner@vger.kernel.org] On Behalf Of Maik Broemme
> Sent: Wednesday, August 15, 2018 7:24 AM
> To: netdev <netdev@vger.kernel.org>
> Cc: linux-kernel <linux-kernel@vger.kernel.org>
> Subject: [BUG] Kernel Oops and crash using i40e VF devices
> 
> Hi,
> 
> I have a SuperMicro X11SPM-F mainboard with two Intel X722 devices
> which
> support up to 32 VF devices per PF device. They are running with i40e
> driver. Whenever I try to use the VF devices in Xen VMs, the host kernel
> got an Oops or crash. In all cases the PF running on the host
> immediately loses network connection. I can reproduce this always
> running the following:
> 
We have some known issues around this problem.  I'll need some more info to debug it.  

How is the device configured?  What drivers are loaded on all ports?  Can you send an ethtool -i <dev> output as well as an ethtool <dev> output?  I also need an lspci -vv for the entire system.  Do you have any virtualization configured in your setup?  If so, what exactly and how are the ethernet devices configured in that?

Thanks,

Carolyn

Carolyn Wyborny 
Linux Development 
Networking Division 
Intel Corporation 


