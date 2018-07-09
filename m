Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCC3C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 990E820896
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 990E820896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754527AbeGILg1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:36:27 -0400
Received: from mga06.intel.com ([134.134.136.31]:13948 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754432AbeGILgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:36:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2018 04:36:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,330,1526367600"; 
   d="scan'208";a="70754935"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga001.fm.intel.com with ESMTP; 09 Jul 2018 04:36:24 -0700
Received: from HASMSX110.ger.corp.intel.com (10.184.198.28) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 9 Jul 2018 04:36:24 -0700
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.54]) by
 HASMSX110.ger.corp.intel.com ([169.254.6.45]) with mapi id 14.03.0319.002;
 Mon, 9 Jul 2018 14:36:21 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
CC:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] mei: bus: type promotion bug in mei_nfc_if_version()
Thread-Topic: [PATCH] mei: bus: type promotion bug in mei_nfc_if_version()
Thread-Index: AQHUE3png2dbGFvDeUeKteEow93QvaSDtk2AgAMUYbA=
Date:   Mon, 9 Jul 2018 11:36:21 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9D968DBA@hasmsx108.ger.corp.intel.com>
References: <20180704093449.vryluk7khaudstgp@kili.mountain>
 <20180707153255.GA29925@kroah.com>
In-Reply-To: <20180707153255.GA29925@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMDE3YWRmYzMtN2JiZS00ZTEwLTliMjgtM2NiNDgyNDU2NDg2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiXC9wNWpiY2pwbVQzUm1xdUVTUGN2QmVMaVN2THFrUkF2ancyQVkwZjB3M2xUc0xXZzRPTlwvMFpWY0pxV09yU3BnIn0=
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.12.116.147]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Wed, Jul 04, 2018 at 12:34:49PM +0300, Dan Carpenter wrote:
> > We accidentally removed the check for negative returns without
> > considering the issue of type promotion.  The "if_version_length"
> > variable is type size_t so if __mei_cl_recv() returns a negative then
> > "bytes_recv" is type promoted to a high positive value and treated as
> > success.
> >
> > Fixes: 582ab27a063a ("mei: bus: fix received data size check in NFC
> > fixup")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Didn't apply to my tree at all :(

I will rework this, anyhow I would prefer if you can wait for my signoff before applying, 
I believe we are reasonably responsive. 
Thanks
Tomas
