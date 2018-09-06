Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C55C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3558E2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:15:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3558E2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730388AbeIFWwB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 18:52:01 -0400
Received: from mga07.intel.com ([134.134.136.100]:43006 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727652AbeIFWwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 18:52:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2018 11:15:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,339,1531810800"; 
   d="scan'208";a="260450379"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by fmsmga005.fm.intel.com with ESMTP; 06 Sep 2018 11:15:20 -0700
Received: from orsmsx154.amr.corp.intel.com (10.22.226.12) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 6 Sep 2018 11:15:19 -0700
Received: from orsmsx102.amr.corp.intel.com ([169.254.3.148]) by
 ORSMSX154.amr.corp.intel.com ([169.254.11.155]) with mapi id 14.03.0319.002;
 Thu, 6 Sep 2018 11:15:19 -0700
From:   "Wyborny, Carolyn" <carolyn.wyborny@intel.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        "Keller, Jacob E" <jacob.e.keller@intel.com>
CC:     "Wang, Dongsheng" <dongsheng.wang@hxt-semitech.com>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
        "sergei.shtylyov@cogentembedded.com" 
        <sergei.shtylyov@cogentembedded.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] net: ethernet: i40e: fix build error
Thread-Topic: [PATCH v2 1/2] net: ethernet: i40e: fix build error
Thread-Index: AQHURMAZjzcIXA2YA0Cj18W2riP1BKTjf3nwgACEJAD//42yIA==
Date:   Thu, 6 Sep 2018 18:15:18 +0000
Message-ID: <9BBC4E0CF881AA4299206E2E1412B6267C602D24@ORSMSX102.amr.corp.intel.com>
References: <1536114430-21356-1-git-send-email-dongsheng.wang@hxt-semitech.com>
 <02874ECE860811409154E81DA85FBB5884C78D88@ORSMSX115.amr.corp.intel.com>
 <eab442369533452a9fc138e310aa57b9@HXTBJIDCEMVIW02.hxtcorp.net>
 <02874ECE860811409154E81DA85FBB5884C7AC01@ORSMSX115.amr.corp.intel.com>
 <20180906180316.GB26997@lunn.ch>
In-Reply-To: <20180906180316.GB26997@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNDY2M2ZlMWMtZTlkZi00OWM4LWI2ZWEtMjk1ODhmODJkYTg0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoicVBTR0RLNmlcL0ptbzRlVUIrS2lxZ2ZJUFwvTzZFRHcrQTZ2QjZocEluRHNBMHFlOTRVbGs5d3ZHcVwvUkRFeExWYiJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: netdev-owner@vger.kernel.org [mailto:netdev-
> owner@vger.kernel.org] On Behalf Of Andrew Lunn
> Sent: Thursday, September 06, 2018 11:03 AM
> To: Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: Wang, Dongsheng <dongsheng.wang@hxt-semitech.com>; Kirsher,
> Jeffrey T <jeffrey.t.kirsher@intel.com>;
> sergei.shtylyov@cogentembedded.com; davem@davemloft.net; intel-
> wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v2 1/2] net: ethernet: i40e: fix build error
> 
[..]
> You have a few options here.
> 
> 1) A library module, containing shared code. Use EXPORT_SYMBOL_GPL()
> in the library module, and the kernel runtime linker will link the
> calls into the library. Also, modprobe will ensure the library module
> is loaded first, before the driver module.
> 
> 2) Build time sharing of code. Place the shared code into a .o file,
> and link it to both modules.
> 
> There is nothing particularly difficult here, this all done lots of
> times within the kernel. Just look around and see how others do it.

Thanks Andrew,

Yes, I agree and we do have a team working on doing this.

Carolyn

Carolyn Wyborny 
Linux Development 
Networking Division 
Intel Corporation 


