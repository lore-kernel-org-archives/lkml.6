Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8716DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55DC2208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55DC2208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbeK0Kag convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:30:36 -0500
Received: from mga07.intel.com ([134.134.136.100]:9573 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727445AbeK0Kag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:30:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2018 15:34:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,284,1539673200"; 
   d="scan'208";a="284141372"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by fmsmga005.fm.intel.com with ESMTP; 26 Nov 2018 15:34:48 -0800
Received: from orsmsx104.amr.corp.intel.com ([169.254.4.124]) by
 ORSMSX103.amr.corp.intel.com ([169.254.5.166]) with mapi id 14.03.0415.000;
 Mon, 26 Nov 2018 15:34:48 -0800
From:   "Bowers, AndrewX" <andrewx.bowers@intel.com>
To:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH 1/1] drivers/net/i40e: define proper
 net_device::neigh_priv_len
Thread-Topic: [Intel-wired-lan] [PATCH 1/1] drivers/net/i40e: define proper
 net_device::neigh_priv_len
Thread-Index: AQHUha6/mJkCiRgH2kSu2U0hKcpWnaVitZUQ
Date:   Mon, 26 Nov 2018 23:34:47 +0000
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D32ACE0@ORSMSX104.amr.corp.intel.com>
References: <20181123161028.22633-1-khorenko@virtuozzo.com>
 <20181123161028.22633-2-khorenko@virtuozzo.com>
In-Reply-To: <20181123161028.22633-2-khorenko@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOWFhNmFiYWYtOTZkNS00OGZiLTg4MmUtMjEwODQ0YTQ1ZTk2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZ2RMYUVvNFdicmp1TkkrMENRSmR1eHlPRzlIaVJCcVJYcWJuVUJINTc1dU43OTNTMGhwT0JYQmRkSEs5UG45SyJ9
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
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces@osuosl.org] On
> Behalf Of Konstantin Khorenko
> Sent: Friday, November 23, 2018 8:10 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: netdev@vger.kernel.org; intel-wired-lan@lists.osuosl.org; linux-
> kernel@vger.kernel.org; Konstantin Khorenko <khorenko@virtuozzo.com>;
> David S . Miller <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH 1/1] drivers/net/i40e: define proper
> net_device::neigh_priv_len
> 
> Out of bound read reported by KASan.
> 
> i40iw_net_event() reads unconditionally 16 bytes from
> neigh->primary_key while the memory allocated for
> "neighbour" struct is evaluated in neigh_alloc() as
> 
>   tbl->entry_size + dev->neigh_priv_len
> 
> where "dev" is a net_device.
> 
> But the driver does not setup dev->neigh_priv_len and we read beyond the
> neigh entry allocated memory, so the patch in the next mail fixes this.
> 
> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 3 +++
>  1 file changed, 3 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


