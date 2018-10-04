Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BC0C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66ED92084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:57:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66ED92084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbeJEBwF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 21:52:05 -0400
Received: from mga02.intel.com ([134.134.136.20]:15659 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727444AbeJEBwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 21:52:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2018 11:57:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,341,1534834800"; 
   d="scan'208";a="94691424"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga004.fm.intel.com with ESMTP; 04 Oct 2018 11:56:54 -0700
Received: from orsmsx111.amr.corp.intel.com (10.22.240.12) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 4 Oct 2018 11:56:47 -0700
Received: from orsmsx106.amr.corp.intel.com ([169.254.1.57]) by
 ORSMSX111.amr.corp.intel.com ([169.254.12.89]) with mapi id 14.03.0319.002;
 Thu, 4 Oct 2018 11:56:47 -0700
From:   "Bowers, AndrewX" <andrewx.bowers@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH 04/16] i40e: Replace spin_is_locked()
 with lockdep
Thread-Topic: [Intel-wired-lan] [PATCH 04/16] i40e: Replace spin_is_locked()
 with lockdep
Thread-Index: AQHUWybRK4YZJIaD/UKkphMOV8V7dqUPcZkQ
Date:   Thu, 4 Oct 2018 18:56:46 +0000
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2FD13D@ORSMSX106.amr.corp.intel.com>
References: <20181003053902.6910-1-ldr709@gmail.com>
 <20181003053902.6910-5-ldr709@gmail.com>
In-Reply-To: <20181003053902.6910-5-ldr709@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOTQ2N2MyYTYtNTM1Zi00OTE4LTk0YTEtMDBiZGU3N2Q5OTFkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoidE1mTkp0SEYyQ0dNMyt2N2E2NzJDMWVuazBHVlwvXC9Cc3RiM0VRbmphNzdlOCtJNjFpSmNEMXk1WnVHak9wZTFlIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces@osuosl.org] On
> Behalf Of Lance Roy
> Sent: Tuesday, October 2, 2018 10:39 PM
> To: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org; Lance Roy <ldr709@gmail.com>; intel-wired-
> lan@lists.osuosl.org; Paul E. McKenney <paulmck@linux.ibm.com>; David S.
> Miller <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH 04/16] i40e: Replace spin_is_locked() with
> lockdep
> 
> lockdep_assert_held() is better suited to checking locking requirements,
> since it won't get confused when someone else holds the lock. This is also a
> step towards possibly removing spin_is_locked().
> 
> Signed-off-by: Lance Roy <ldr709@gmail.com>
> Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: intel-wired-lan@lists.osuosl.org
> Cc: <netdev@vger.kernel.org>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


