Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A928C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 16:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B4A920828
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 16:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbeL3QaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 11:30:05 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:52556
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726376AbeL3QaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 11:30:01 -0500
X-IronPort-AV: E=Sophos;i="5.56,417,1539640800"; 
   d="scan'208";a="290435977"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-SHA256; 30 Dec 2018 17:29:57 +0100
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     freedreno@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, devel@driverdev.osuosl.org,
        intel-wired-lan@lists.osuosl.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Saeed Bishara <saeedb@amazon.com>,
        Zorik Machulsky <zorik@amazon.com>, netdev@vger.kernel.org,
        linux-scsi@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [PATCH 0/8] reduce indentation
Date:   Sun, 30 Dec 2018 16:53:07 +0100
Message-Id: <1546185195-25676-1-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches fix cases where a subsequent statement is aligned
with the right hand side of an assignment rather than the left
hand side.  This was done using the following semantic match
(http://coccinelle.lip6.fr/).  It has a lot of false positives,
because Coccinelle doesn't record the difference between a space
and a tab, but these issues are easy to skip over.

// <smpl>
@r@
expression x,e;
statement S;
position p0,p1,p2;
@@
x@p0 = e@p1;
S@p2

@script:ocaml@
p0 << r.p0;
p1 << r.p1;
p2 << r.p2;
@@
if ((List.hd p0).col < (List.hd p1).col &&
    (List.hd p1).col = (List.hd p2).col)
then Coccilib.print_main "" p1
// </smpl>

---

 drivers/firmware/stratix10-svc.c              |   12 ++++++------
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c         |    2 +-
 drivers/iommu/msm_iommu.c                     |    8 ++++----
 drivers/net/ethernet/amazon/ena/ena_eth_com.c |    4 ++--
 drivers/net/ethernet/intel/i40e/i40e_main.c   |    2 +-
 drivers/scsi/pm8001/pm8001_sas.c              |    2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c    |    6 +++---
 drivers/usb/gadget/udc/snps_udc_core.c        |   17 ++++++++---------
 8 files changed, 26 insertions(+), 27 deletions(-)
