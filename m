Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36927C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 04:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05FFD207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 04:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIgWz7sq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfBVEJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 23:09:57 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43850 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfBVEJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 23:09:50 -0500
Received: by mail-oi1-f193.google.com with SMTP id i8so716381oib.10;
        Thu, 21 Feb 2019 20:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xtikp9Tj1v5uFbNmv3/WninwYjKrdcmWQFe4PZoP6es=;
        b=bIgWz7sqcuy+hTXU/S1fsyRkWdm01MnqihM9Xl6G9HfGD5lHpG2yC/h0xoenby9l19
         J0IQSaqYIinhXtkED13O7+PSpu+h43/00ly/apLb5B3OL3C8MNBf/hX8zyVj3cWPmm/a
         UZaudnolPF6swZW88bKP5EvQlVExesiGdOCQLDqImwqRTiIYiq5RKxjnW7jrjvT1oAUx
         Xjg3hm1Hlwc1ZOE1AjG6k3dS1TYJxmffsSCXW5A7z4oMJnWkhzSXpEm26nUVR8p8Nu3d
         K7O1vTlnpUzLJKeLRBZ+DygS83mFrh2D34inT8LIgg/C4Oi1rPCY/zIgE0sxKUvh/OEd
         +b2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xtikp9Tj1v5uFbNmv3/WninwYjKrdcmWQFe4PZoP6es=;
        b=W/M71p3hHFbsOSq4TdW6iTuWM1ZVJykGqDoJg4/6bRJrk1jZZ7cS8YBSdE7YYBq1NL
         YOBa0JcMGqnxiyFNwNFCUyhhb2DCrpNl6YgZtXQTIbO02Cxs2QTueLgRsd1+cX9C7HfB
         TyUkcnrd3BpUcZJsDCq59L6zzLr35sxnWwRaI4A3SadOKQXRA8SoXtHpTR0giffx7Cnb
         viCey9vz36b13eGHjaW3EkhvfcSDEG/uEBjO+OUQyi5ByKGtwQo4I9fkl+x3vQBzCHiz
         RF+yl9po2TRNBjxjZG24B5tESqYmAIesaXJYR7pxgcPtJCXItuBjQ3KwGhc+wtH0Upt9
         ljpw==
X-Gm-Message-State: AHQUAuZjIrPnLjIDSeeDpuQ/VNMzNiPljOR83jyg+tdL/WaAmLx2X0QU
        0JQfK9jtuFvVgCCs+gVXoM7cCkmQ
X-Google-Smtp-Source: AHgI3Ibz8v0ulm9RH2rNe7Iimq/EabrA9iANbNQEDaIBiN6vb1OzWS4F6o3rxs5PjlCaB4zL+PYO5g==
X-Received: by 2002:aca:7503:: with SMTP id q3mr1262494oic.76.1550808589396;
        Thu, 21 Feb 2019 20:09:49 -0800 (PST)
Received: from localhost.localdomain (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id r1sm167836otk.48.2019.02.21.20.09.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 20:09:48 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, Florian Fainelli <f.fainelli@gmail.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 3/4] e1000e: Fix -Wformat-truncation warnings
Date:   Thu, 21 Feb 2019 20:09:28 -0800
Message-Id: <20190222040929.16657-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190222040929.16657-1-f.fainelli@gmail.com>
References: <20190222040929.16657-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide precision hints to snprintf() since we know the destination
buffer size of the RX/TX ring names are IFNAMSIZ + 5 - 1. This fixes the
following warnings:

drivers/net/ethernet/intel/e1000e/netdev.c: In function
'e1000_request_msix':
drivers/net/ethernet/intel/e1000e/netdev.c:2109:13: warning: 'snprintf'
output may be truncated before the last format character
[-Wformat-truncation=]
     "%s-rx-0", netdev->name);
             ^
drivers/net/ethernet/intel/e1000e/netdev.c:2107:3: note: 'snprintf'
output between 6 and 21 bytes into a destination of size 20
   snprintf(adapter->rx_ring->name,
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     sizeof(adapter->rx_ring->name) - 1,
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     "%s-rx-0", netdev->name);
     ~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/e1000e/netdev.c:2125:13: warning: 'snprintf'
output may be truncated before the last format character
[-Wformat-truncation=]
     "%s-tx-0", netdev->name);
             ^
drivers/net/ethernet/intel/e1000e/netdev.c:2123:3: note: 'snprintf'
output between 6 and 21 bytes into a destination of size 20
   snprintf(adapter->tx_ring->name,
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     sizeof(adapter->tx_ring->name) - 1,
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     "%s-tx-0", netdev->name);
     ~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 736fa51878f8..7acc61e4f645 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -2106,7 +2106,7 @@ static int e1000_request_msix(struct e1000_adapter *adapter)
 	if (strlen(netdev->name) < (IFNAMSIZ - 5))
 		snprintf(adapter->rx_ring->name,
 			 sizeof(adapter->rx_ring->name) - 1,
-			 "%s-rx-0", netdev->name);
+			 "%.14s-rx-0", netdev->name);
 	else
 		memcpy(adapter->rx_ring->name, netdev->name, IFNAMSIZ);
 	err = request_irq(adapter->msix_entries[vector].vector,
@@ -2122,7 +2122,7 @@ static int e1000_request_msix(struct e1000_adapter *adapter)
 	if (strlen(netdev->name) < (IFNAMSIZ - 5))
 		snprintf(adapter->tx_ring->name,
 			 sizeof(adapter->tx_ring->name) - 1,
-			 "%s-tx-0", netdev->name);
+			 "%.14s-tx-0", netdev->name);
 	else
 		memcpy(adapter->tx_ring->name, netdev->name, IFNAMSIZ);
 	err = request_irq(adapter->msix_entries[vector].vector,
-- 
2.19.1

