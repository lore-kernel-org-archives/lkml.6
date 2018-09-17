Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A9BECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629AF2146D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:15:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 629AF2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733295AbeIREpJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:45:09 -0400
Received: from mga03.intel.com ([134.134.136.65]:7785 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732623AbeIREpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:45:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Sep 2018 16:15:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,387,1531810800"; 
   d="scan'208";a="74025700"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga008.jf.intel.com with ESMTP; 17 Sep 2018 16:14:41 -0700
Received: from fmsmsx151.amr.corp.intel.com (10.18.125.4) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 17 Sep 2018 16:14:40 -0700
Received: from fmsmsx101.amr.corp.intel.com ([169.254.1.66]) by
 FMSMSX151.amr.corp.intel.com ([169.254.7.228]) with mapi id 14.03.0319.002;
 Mon, 17 Sep 2018 16:14:33 -0700
From:   "Howell, Seth" <seth.howell@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "Walker, Benjamin" <benjamin.walker@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Moni Shoua <monis@mellanox.com>
Subject: RE: [PATCH] rdma: move the ib_wr_opcode enum to include/uapi
Thread-Topic: [PATCH] rdma: move the ib_wr_opcode enum to include/uapi
Thread-Index: AQHUNB7XmXOwV8047EKXXIqMnpdlHaTB4cuA//+UiKCANE1qgP//jDAw
Date:   Mon, 17 Sep 2018 23:14:33 +0000
Message-ID: <EA913ED399BBA34AA4EAC2EDC24CDD009C1DDDA7@fmsmsx101.amr.corp.intel.com>
References: <20180814223303.83556-1-seth.howell@intel.com>
 <20180815225021.GB31799@ziepe.ca>
 <EA913ED399BBA34AA4EAC2EDC24CDD008611724E@FMSMSX105.amr.corp.intel.com>
 <20180917230817.GA10882@ziepe.ca>
In-Reply-To: <20180917230817.GA10882@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiY2QxMGFmZjYtMWFlNC00YjU0LWIxNGYtMWI0OTI3NmI1ZDBlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVTJaMFRZNEFJenc4VnRYa0M3SndsMHlLZmJGYWxPQ0R1elJOTUZOMDhcL3piaE9iWUdMMDhqeEFuZUJKVnlkSkYifQ==
x-originating-ip: [10.1.200.107]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Jason!

-----Original Message-----
From: Jason Gunthorpe [mailto:jgg@ziepe.ca] 
Sent: Monday, September 17, 2018 4:08 PM
To: Howell, Seth <seth.howell@intel.com>
Cc: Walker, Benjamin <benjamin.walker@intel.com>; Doug Ledford <dledford@redhat.com>; linux-rdma@vger.kernel.org; linux-kernel@vger.kernel.org; Moni Shoua <monis@mellanox.com>
Subject: Re: [PATCH] rdma: move the ib_wr_opcode enum to include/uapi

> >From e3c1b1b81373601fa6cbad2ba5fadd2c8cfdfaed Mon Sep 17 00:00:00 
> >2001
> From: Seth Howell <seth.howell@intel.com>
> Date: Tue, 14 Aug 2018 15:33:02 -0700
> Subject: [PATCH] IB/rxe: Revise the ib_wr_opcode enum
> 
> This enum has become part of the uABI, as both RXE and the
> ib_uverbs_post_send() command expect userspace to supply values from 
> this enum. So it should be properly placed in include/uapi/rdma.
> 
> In userspace this enum is called 'enum ibv_wr_opcode' as part of 
> libibverbs.h. That enum defines different values for IB_WR_LOCAL_INV, 
> IB_WR_SEND_WITH_INV, and IB_WR_LSO. These were introduced 
> (incorrectly, it turns out) into libiberbs in 2015.
> 
> The kernel has changed its mind on the numbering for several of the 
> IB_WC values over the years, but has remained stable on 
> IB_WR_LOCAL_INV and below.
> 
> Based on this we can conclude that there is no real user space user of 
> the values beyond IB_WR_ATOMIC_FETCH_AND_ADD, as they have never 
> worked via rdma-core. This is confirmed by inspection, only rxe uses 
> the kernel enum and implements the latter operations. rxe has clearly 
> never worked with these attributes from userspace. Other drivers that 
> support these opcodes implement the functionality without calling out 
> to the kernel.
> 
> To make IB_WR_SEND_WITH_INV and related work for RXE in userspace we 
> choose to renumber the IB_WR enum in the kernel to match the uABI that 
> userspace has bee using since before Soft RoCE was merged. This is an 
> overall simpler configuration for the whole software stack, and 
> obviously can't break anything existing.
> 
> Reported-by: Seth Howell <seth.howell@intel.com>
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
>  include/rdma/ib_verbs.h           | 34 ++++++++++++++++++-------------
>  include/uapi/rdma/ib_user_verbs.h | 20 +++++++++++++++++-
>  2 files changed, 39 insertions(+), 15 deletions(-)

Applied to for-next

Thanks,
Jason
