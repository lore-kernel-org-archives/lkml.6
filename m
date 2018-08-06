Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E802C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C2521A12
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmHGRLdi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C2521A12
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387812AbeHGBiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 21:38:07 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36451 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387557AbeHGBiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 21:38:06 -0400
Received: by mail-oi0-f66.google.com with SMTP id n21-v6so25323219oig.3;
        Mon, 06 Aug 2018 16:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4xvs0w0N34TXyC9C+D5prP5itXqvnv+RfR86wouk0kk=;
        b=jmHGRLdipkwGcIVNGZSA/5abo4KZz9QoJ2CujiDhYmjx7S5vhKy1m7EbttvWkFOSbI
         bQy7spZ0zFAnY1ajUUglsSasOpC5E8C3aLfZEoDIWQyK0xfJfgQxCUdldjL8RFzn3PJr
         O9oFhh4nqv7ZFEveR6ITOnOrHPHqyyJSg5QC9w6X6YJGDriaEzKO7KZtLSvAjb1hM8VK
         Bf4TS4Y/R3Kl5qHm836cnvbx6RNZcCouI47P3Q7/WC/MBXA5lsX2zaCrQMe4pkFmSAb/
         0deO0tGjHjOfPQd8elnfEbH+CShDPXrSUSobuEBjos8qwELw6Z/I0AzmhOScP/2aWEZg
         FbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4xvs0w0N34TXyC9C+D5prP5itXqvnv+RfR86wouk0kk=;
        b=rbTSzrZf8c2dQlnDdUwoM7/vE57ccDEpxDFvnBaILHlJfVRRZKM5RyCWm8e+8FX/T+
         QRPAlkLSXTTq40NaXQ7hQBYaZG91ErIprn7ywRjVrdAHzM5Bk46TcEABTNMREfLKLn0S
         4+cdSf8ce9HGmH41xrtf/DI9TjybadMoyItLqGbFfsMhwTGWxh+xrF8zKYmTZgcgdIVP
         kWHT20B4FT54omqkHpsgg+TMKlQiKIdf0qnajOmU1YSDWSati0mP2QZkR+Oq6b2D4eYe
         GvG6gynl079LrRob2xcB7CB5IpYZcpeOyJ87c9o+1rnwbwcwJLaRbWtql0YHcMi7ED2h
         U5fg==
X-Gm-Message-State: AOUpUlHFb17K96OpSgIRjzOnO4VTOqnPQtFDf2Oo21hu0a1OIZvh88zF
        fpSEK4eqhRJ843DXyZbE7m48HEH7DWs=
X-Google-Smtp-Source: AA+uWPybWOBtCGsptH4SXYTvRhwz1Sf4nFnZmWUZ0PHWrU1XYI/lhZX1mdk+y8qbZ4ZWQgK8CEeCYw==
X-Received: by 2002:aca:d0cc:: with SMTP id j73-v6mr15607295oiy.255.1533598002124;
        Mon, 06 Aug 2018 16:26:42 -0700 (PDT)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id w13-v6sm10613328oiw.51.2018.08.06.16.26.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 16:26:41 -0700 (PDT)
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
Subject: [PATCH v6 4/9] cxgb4: Do not call pcie_print_link_status()
Date:   Mon,  6 Aug 2018 18:25:38 -0500
Message-Id: <20180806232600.25694-4-mr.nuke.me@gmail.com>
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
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index a8926e97935e..049958898c17 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -5726,9 +5726,6 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 			free_msix_info(adapter);
 	}
 
-	/* check for PCI Express bandwidth capabiltites */
-	pcie_print_link_status(pdev);
-
 	err = init_rss(adapter);
 	if (err)
 		goto out_free_dev;
-- 
2.17.1

