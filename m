Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B9BC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 23:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2F1D2150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 23:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2F1D2150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732499AbeITEod convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 00:44:33 -0400
Received: from mga14.intel.com ([192.55.52.115]:40832 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbeITEod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 00:44:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2018 16:04:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,395,1531810800"; 
   d="scan'208";a="91595756"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga001.fm.intel.com with ESMTP; 19 Sep 2018 16:03:05 -0700
Received: from fmsmsx152.amr.corp.intel.com (10.18.125.5) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 19 Sep 2018 16:03:05 -0700
Received: from fmsmsx103.amr.corp.intel.com ([169.254.2.126]) by
 FMSMSX152.amr.corp.intel.com ([169.254.6.159]) with mapi id 14.03.0319.002;
 Wed, 19 Sep 2018 16:03:04 -0700
From:   "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        "Walker, Benjamin" <benjamin.walker@intel.com>
CC:     "Howell, Seth" <seth.howell@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "monis@mellanox.com" <monis@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>
Subject: RE: [PATCH] rdma: move the ib_wr_opcode enum to include/uapi
Thread-Topic: [PATCH] rdma: move the ib_wr_opcode enum to include/uapi
Thread-Index: AQHUNB7dduKd6+3bL0SrpYoBIoJutKTB4cuAgAAKaQCAATczAIAGhGQAgCvyCACAAAhrAIAAFpsAgAAFJYCAArEDwA==
Date:   Wed, 19 Sep 2018 23:03:04 +0000
Message-ID: <13AA599688F47243B14FCFCCC2C803BB4BDC4DE4@FMSMSX103.amr.corp.intel.com>
References: <20180814223303.83556-1-seth.howell@intel.com>
 <20180815225021.GB31799@ziepe.ca>
 <EA913ED399BBA34AA4EAC2EDC24CDD008611724E@FMSMSX105.amr.corp.intel.com>
 <20180816180126.GB10507@ziepe.ca>
 <EA913ED399BBA34AA4EAC2EDC24CDD0086118B12@FMSMSX105.amr.corp.intel.com>
 <11f85f780435a5ded567bc8559d7c770d3bc4464.camel@intel.com>
 <20180917210824.GF11367@ziepe.ca>
 <0df4e4958250fd6cdb978005ace970c877269535.camel@intel.com>
 <20180917224743.GG11367@ziepe.ca>
In-Reply-To: <20180917224743.GG11367@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMTM4N2ExYTktMmE3ZS00MmJiLWFjODctMGFjZWRkNDk2ZGFmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiWjRhYzZOWGdDRjRmTktuMVlYN3drVGxEcHNhRVY4SjZ3QTlpMURJZmhxRlBEazFTbWIwSVFCUnBpSGhmK2lcL1MifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.1.200.108]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

> > What is the correct way for a user space application to check whether
> > a NIC supports SEND_WITH_INVAL? We are currently examining the
> > device_cap_flags in the structure returned by ibv_query_device.
> > Specifically, we're looking at IBV_DEVICE_MEM_MGT_EXTENSIONS.
> However,
> > for i40iw, that flag is set. I'm concerned that the feature support
> > flags are common between user space and the kernel, but the actual
> support differs in this case.
> 
> That is the correct thing to do. Sadly the i40iw driver is broken, it should be
> fixed to either mask those flags or implement the functionality.
> 

A fix to add SEND_WITH_INVAL support to the user space i40iw is coming.
It is currently in regression testing.

Thank you,
Tatyana 

> Jason
