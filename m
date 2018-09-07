Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D2AC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 22:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C980320652
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 22:03:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C980320652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbeIHCqT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:46:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:8368 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726394AbeIHCqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:46:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2018 15:03:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,343,1531810800"; 
   d="scan'208";a="88614326"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by orsmga001.jf.intel.com with ESMTP; 07 Sep 2018 15:03:15 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.230]) by
 ORSMSX110.amr.corp.intel.com ([169.254.10.41]) with mapi id 14.03.0319.002;
 Fri, 7 Sep 2018 15:03:14 -0700
From:   "Keller, Jacob E" <jacob.e.keller@intel.com>
To:     David Miller <davem@davemloft.net>
CC:     "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
        "Bowers, AndrewX" <andrewx.bowers@intel.com>
Subject: RE: linux-next: build failure after merge of the net-next tree
Thread-Topic: linux-next: build failure after merge of the net-next tree
Thread-Index: AQHUQxdRgVQMKTBaEkyNaCDZFitIB6TkcHKAgACIk2CAAJdJAP//1gmg
Date:   Fri, 7 Sep 2018 22:03:13 +0000
Message-ID: <02874ECE860811409154E81DA85FBB5884C7B9A6@ORSMSX115.amr.corp.intel.com>
References: <20180903094702.3e32d8f5@canb.auug.org.au>
        <20180907102055.001777b8@canb.auug.org.au>
        <02874ECE860811409154E81DA85FBB5884C7B651@ORSMSX115.amr.corp.intel.com>
 <20180907.103112.1943018536705670414.davem@davemloft.net>
In-Reply-To: <20180907.103112.1943018536705670414.davem@davemloft.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYjNhZmM0MmMtYjRhNS00OGY4LWE2M2MtMWViNTgyY2YxNmY3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSHJ6anBMeGFPQU1WWWg2VnQzWWp2b2d5Z0c5eEpsamVGS3h2MGYxVWVVc0J3NXlxbjg1S3FLb1wvVUs2ZmpoTksifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
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
> From: David Miller [mailto:davem@davemloft.net]
> Sent: Friday, September 07, 2018 10:31 AM
> To: Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: sfr@canb.auug.org.au; netdev@vger.kernel.org; linux-next@vger.kernel.org;
> linux-kernel@vger.kernel.org; Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>;
> Bowers, AndrewX <andrewx.bowers@intel.com>
> Subject: Re: linux-next: build failure after merge of the net-next tree
> 
> From: "Keller, Jacob E" <jacob.e.keller@intel.com>
> Date: Fri, 7 Sep 2018 15:30:42 +0000
> 
> > There's some discussion about this going on in the intel-wired-lan
> > mailing list.
> 
> I really want to see a pull request in my inbox fixing this by the end
> of today or I'll apply a fix directly at my discretion.

Jeff is out, so I just opted to email a fix to netdev. I hope this is acceptable.

I opted to essentially revert the patch that moved code to i40e_ethtool_stats.h, rather than anything fancier, since it was fast, and correct.

There was a suggestion to only move the one offending function, but I felt that it was better to move everything back into the .c files.

Thanks,
Jake
