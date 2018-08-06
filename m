Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18201C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C673021A12
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpOzeXpz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C673021A12
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388483AbeHGBiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 21:38:19 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:40007 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387557AbeHGBiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 21:38:18 -0400
Received: by mail-oi0-f66.google.com with SMTP id w126-v6so25262262oie.7;
        Mon, 06 Aug 2018 16:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UCl4Lu6W1ZfIHNMUiiyuRZb9LsAG6du1KMvhVVIhXLw=;
        b=LpOzeXpzqzwoDKrcKx07OhhdknYQUOCebniUOF5i8Iie9C1feMfGSE4gz2/l4Wautc
         V7wYz4A8AaNvSFxSUBwkiZZU4wC8PLBQ2bAHAb6ZvCWQTidvVLEYNso0vLxWPGJa5Uy4
         tN2zGsfRJXKzvTQ7F5IzLo3QAcyMMY2bBRYhymx0/KVtnbDwM+goY0UInUz34iqaHBP2
         rqdExl8EW9h0/CHNMDLIfAC5gu0PlKK2qsDDScKxPiUjKABLxko2+sq642Rwnx590LRE
         XHkKRvMcgosvUaAQfCEhOaMuTiIq52QzpMetsj6tNz0Pp/8geIVDitNSzbscPMi8b1Ms
         tO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UCl4Lu6W1ZfIHNMUiiyuRZb9LsAG6du1KMvhVVIhXLw=;
        b=hr43Q9zt/rm4akWvwx7uSppxOdL+EBvjO/l/l1jGX8YYR32WA3/XEO9DiESy9Bjf7a
         Z2yZ2JyB4r4rc2OeC/nAB8cKB3b0GAQiKk3Ix3P/fVzf4sXuT4EG1J6FWTRmQt+6OO1a
         jdVoFQmrK7Ri7gx13k3GXm/irie1LiVPHup+l/U5RsLanndKbngN0lIUdznAdrBtuivs
         5aeLCuJitiotNOi3ghO67A1HbSUDgJno/WwkRpjinXrqR2htu+70NpWCOBCea1CVF6zU
         vk9M/3+CtRET11zsrOUkjMLHQjnv8qQyeZxlPVtO5ahEAxYYvvGjq4wn06PnKTtQ4esW
         Otgg==
X-Gm-Message-State: AOUpUlHuUGpZDSbZ1L+e0bsrcteT4AIH9f3Vl/ugfAdEIjCyjfH25N9T
        0fUCaPiP+CQm2FOkbLohBCoPvxgU/U8=
X-Google-Smtp-Source: AA+uWPyWBaHlOBuson6UpSvREg5kVhqrpQFG4HoivVCwQ0d/9xUL04GO5wOkJI4318I5BZFofZn3Sg==
X-Received: by 2002:aca:cd84:: with SMTP id d126-v6mr17850955oig.325.1533598014177;
        Mon, 06 Aug 2018 16:26:54 -0700 (PDT)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id w13-v6sm10613328oiw.51.2018.08.06.16.26.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 16:26:53 -0700 (PDT)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        jakub.kicinski@netronome.com
Cc:     keith.busch@intel.com, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        everest-linux-l2@cavium.com,
        "David S. Miller" <davem@davemloft.net>,
        Michael Chan <michael.chan@broadcom.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
        oss-drivers@netronome.com
Subject: [PATCH v6 6/9] ixgbe: Do not call pcie_print_link_status()
Date:   Mon,  6 Aug 2018 18:25:40 -0500
Message-Id: <20180806232600.25694-6-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180806232600.25694-1-mr.nuke.me@gmail.com>
References: <CAErSpo4PK+SQLNfdkLNt9eLc7bpbxbkZCsa8T-tQpid601n0SQ@mail.gmail.com>
 <20180806232600.25694-1-mr.nuke.me@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is now done by the PCI core to warn of sub-optimal bandwidth.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 26 -------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 62e57b05a0ae..7ecdc6c03a66 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -241,28 +241,6 @@ static inline bool ixgbe_pcie_from_parent(struct ixgbe_hw *hw)
 	}
 }
 
-static void ixgbe_check_minimum_link(struct ixgbe_adapter *adapter,
-				     int expected_gts)
-{
-	struct ixgbe_hw *hw = &adapter->hw;
-	struct pci_dev *pdev;
-
-	/* Some devices are not connected over PCIe and thus do not negotiate
-	 * speed. These devices do not have valid bus info, and thus any report
-	 * we generate may not be correct.
-	 */
-	if (hw->bus.type == ixgbe_bus_type_internal)
-		return;
-
-	/* determine whether to use the parent device */
-	if (ixgbe_pcie_from_parent(&adapter->hw))
-		pdev = adapter->pdev->bus->parent->self;
-	else
-		pdev = adapter->pdev;
-
-	pcie_print_link_status(pdev);
-}
-
 static void ixgbe_service_event_schedule(struct ixgbe_adapter *adapter)
 {
 	if (!test_bit(__IXGBE_DOWN, &adapter->state) &&
@@ -10585,10 +10563,6 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		break;
 	}
 
-	/* don't check link if we failed to enumerate functions */
-	if (expected_gts > 0)
-		ixgbe_check_minimum_link(adapter, expected_gts);
-
 	err = ixgbe_read_pba_string_generic(hw, part_str, sizeof(part_str));
 	if (err)
 		strlcpy(part_str, "Unknown", sizeof(part_str));
-- 
2.17.1

