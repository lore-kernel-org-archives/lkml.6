Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B346ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F6120854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSSs1aU6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07F6120854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388142AbeGWWCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 18:02:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:47302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728370AbeGWWCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 18:02:47 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62A1820854;
        Mon, 23 Jul 2018 20:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532379587;
        bh=L/xWlUfvko5IoaJrb9vvwhPVET+6e+vD5antTfRvGUY=;
        h=Subject:From:To:Cc:Date:From;
        b=WSSs1aU6TNBh4Hk2/09qMgzEdlfaDe7brVR4FoP1t9Hivuv5jKefBU0D+eXUL6zY1
         Wm0nahKTv8ensonXvKCJN9DeyLY5tG/eOTomMN3Sw3YAAcd1n2+pgiexRmIQeLP1vv
         rVy1ScPc8e28H+dH55ibv8f19NxtgxBy8StPfQf4=
Subject: [PATCH] vxge: Remove unnecessary include of <linux/pci_hotplug.h>
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jon Mason <jdmason@kudzu.us>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 23 Jul 2018 15:59:46 -0500
Message-ID: <153237958637.172194.6734539971240967379.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

The vxge driver doesn't need anything provided by pci_hotplug.h, so remove
the unnecessary include of it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/net/ethernet/neterion/vxge/vxge-config.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/neterion/vxge/vxge-config.c b/drivers/net/ethernet/neterion/vxge/vxge-config.c
index 358ed6118881..a2c0a93ca8b6 100644
--- a/drivers/net/ethernet/neterion/vxge/vxge-config.c
+++ b/drivers/net/ethernet/neterion/vxge/vxge-config.c
@@ -14,7 +14,6 @@
 #include <linux/vmalloc.h>
 #include <linux/etherdevice.h>
 #include <linux/pci.h>
-#include <linux/pci_hotplug.h>
 #include <linux/slab.h>
 
 #include "vxge-traffic.h"

