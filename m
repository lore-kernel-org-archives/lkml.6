Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7516FC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FECE20857
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FECE20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731535AbeGaMLf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 08:11:35 -0400
Received: from mga11.intel.com ([192.55.52.93]:40418 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727409AbeGaMLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 08:11:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jul 2018 03:31:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,427,1526367600"; 
   d="scan'208";a="249839735"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga005.fm.intel.com with ESMTP; 31 Jul 2018 03:31:55 -0700
Received: from fmsmsx118.amr.corp.intel.com (10.18.116.18) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 31 Jul 2018 03:31:55 -0700
Received: from hasmsx107.ger.corp.intel.com (10.184.198.27) by
 fmsmsx118.amr.corp.intel.com (10.18.116.18) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 31 Jul 2018 03:31:55 -0700
Received: from hasmsx106.ger.corp.intel.com ([169.254.10.9]) by
 hasmsx107.ger.corp.intel.com ([169.254.2.132]) with mapi id 14.03.0319.002;
 Tue, 31 Jul 2018 13:31:52 +0300
From:   "Basierski, SebastianX" <sebastianx.basierski@intel.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH] net: intel: ixgbe: Replace GFP_ATOMIC
 with GFP_KERNEL
Thread-Topic: [Intel-wired-lan] [PATCH] net: intel: ixgbe: Replace
 GFP_ATOMIC with GFP_KERNEL
Thread-Index: AQHUJYMCq8jgYK/qI0K524Y7tR5SwaSpJWvg
Date:   Tue, 31 Jul 2018 10:31:52 +0000
Message-ID: <3A7E81AC661B4646A4CE6F2E09B7B74E05C6434C@HASMSX106.ger.corp.intel.com>
References: <20180727082231.3798-1-baijiaju1990@gmail.com>
In-Reply-To: <20180727082231.3798-1-baijiaju1990@gmail.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.103.102.154]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Sebastian Basierski <sebastianx.basierski@intel.com>

Pozdrawiam
Sebastian Basierski
SII Engineer
Delivering outsourced services to Intel
e-mail: sebastianx.basierski@intel.com




-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces@osuosl.org] On Behalf Of Jia-Ju Bai
Sent: Friday, July 27, 2018 10:23 AM
To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
Cc: netdev@vger.kernel.org; Jia-Ju Bai <baijiaju1990@gmail.com>; intel-wired-lan@lists.osuosl.org; linux-kernel@vger.kernel.org
Subject: [Intel-wired-lan] [PATCH] net: intel: ixgbe: Replace GFP_ATOMIC with GFP_KERNEL

ixgbe_fcoe_ddp_setup(), ixgbe_setup_fcoe_ddp_resources() and
ixgbe_sw_init() are never called in atomic context.
They call kmalloc(), dma_pool_alloc() and kzalloc() with GFP_ATOMIC, which is not necessary.
GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c | 4 ++--  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
index 7a09a40e4472..ff7ed77ce224 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
@@ -217,7 +217,7 @@ static int ixgbe_fcoe_ddp_setup(struct net_device *netdev, u16 xid,
 	}
 
 	/* alloc the udl from per cpu ddp pool */
-	ddp->udl = dma_pool_alloc(ddp_pool->pool, GFP_ATOMIC, &ddp->udp);
+	ddp->udl = dma_pool_alloc(ddp_pool->pool, GFP_KERNEL, &ddp->udp);
 	if (!ddp->udl) {
 		e_err(drv, "failed allocated ddp context\n");
 		goto out_noddp_unmap;
@@ -785,7 +785,7 @@ int ixgbe_setup_fcoe_ddp_resources(struct ixgbe_adapter *adapter)
 		return 0;
 
 	/* Extra buffer to be shared by all DDPs for HW work around */
-	buffer = kmalloc(IXGBE_FCBUFF_MIN, GFP_ATOMIC);
+	buffer = kmalloc(IXGBE_FCBUFF_MIN, GFP_KERNEL);
 	if (!buffer)
 		return -ENOMEM;
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index afadba99f7b8..fe4a6125576d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -6138,7 +6138,7 @@ static int ixgbe_sw_init(struct ixgbe_adapter *adapter,
 
 	adapter->mac_table = kzalloc(sizeof(struct ixgbe_mac_addr) *
 				     hw->mac.num_rar_entries,
-				     GFP_ATOMIC);
+				     GFP_KERNEL);
 	if (!adapter->mac_table)
 		return -ENOMEM;
 
--
2.17.0

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
