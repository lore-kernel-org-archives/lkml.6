Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CE6FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75BAD208A1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:16:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75BAD208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730607AbeG3Rvq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:51:46 -0400
Received: from mga11.intel.com ([192.55.52.93]:11955 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728250AbeG3Rvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:51:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2018 09:16:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,422,1526367600"; 
   d="scan'208";a="71140008"
Received: from irsmsx109.ger.corp.intel.com ([163.33.3.23])
  by orsmga003.jf.intel.com with ESMTP; 30 Jul 2018 09:15:55 -0700
Received: from irsmsx107.ger.corp.intel.com ([169.254.10.193]) by
 IRSMSX109.ger.corp.intel.com ([169.254.13.124]) with mapi id 14.03.0319.002;
 Mon, 30 Jul 2018 17:15:54 +0100
From:   "Kielan, Tymoteusz" <tymoteusz.kielan@intel.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH] net: intel: ixgbe: Replace GFP_ATOMIC
 with GFP_KERNEL
Thread-Topic: [Intel-wired-lan] [PATCH] net: intel: ixgbe: Replace
 GFP_ATOMIC with GFP_KERNEL
Thread-Index: AQHUJYMC3plvuNzlDkewl4ksjqrytqSn9fhA
Date:   Mon, 30 Jul 2018 16:15:54 +0000
Message-ID: <37EA2F27FEDED94487ADB266632B54EF73001775@IRSMSX107.ger.corp.intel.com>
References: <20180727082231.3798-1-baijiaju1990@gmail.com>
In-Reply-To: <20180727082231.3798-1-baijiaju1990@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYjk3ZWU5YTQtNGUzMC00MTg2LTkzMTctZDAzN2ZkODVjMjJjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiUnNcL2tpM1dKeExXMXh4ZTE5UkhBWFowZFE1UG5ZcWdoYlBFcW0wUFwvOW9HeWhXTEJSOURDeVNrb1dcL1YwMERcL2cifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [163.33.239.182]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACK

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
--------------------------------------------------------------------

Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek
przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by
others is strictly prohibited.

