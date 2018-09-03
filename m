Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08187C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B717F20869
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPqhKZfJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B717F20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbeICWYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 18:24:38 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:42868 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbeICWYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 18:24:38 -0400
Received: by mail-oi0-f65.google.com with SMTP id k81-v6so2219897oib.9;
        Mon, 03 Sep 2018 11:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0pKk19a77AZmp6dTLVE6bJItbn+Qw+XrfFzeKgl/8eY=;
        b=UPqhKZfJFxiwmF6qssCOQd+/MEEXz8Dde+ndyDS0qDAXg+B4rQcbmEePg4PeZWNk90
         SS5/o+zc6/g9AjI76perBmw+xXYWuEQUJ6gj0ls/irYsxqsAj3+M4vwev0U+La7d5iy4
         O7SEsO/5C+dM9ZkRiiOYkbpK4to4x63GydT34M3syY2xkquDlro1mzZ9xjtJkC/Bdb5N
         cx736mkCK3l1oXrRrvb3laJTHZwybhvCPZh0cgLWNVbvCVfRypdzzcSVjtIoj8kLEr0U
         xo7lLB5lsaCXVl3yOO005SvlI3omWRi9BzYlPeyRjMPRtSYsOHqZiObHdk8OIFjksZy8
         6i9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0pKk19a77AZmp6dTLVE6bJItbn+Qw+XrfFzeKgl/8eY=;
        b=V4sIyASbSgXoQrHNRLpBnPv6WhALix70nCxSj7Dx/aeXc6p3jERoKd/kVYc9y8Qgmq
         0KNvTBFp5GNFtKd2fidcLSXf1MwnXykNNxfTEyCkHi0BIqGU8SfewaryK3csilRW+TL+
         9xzrnBZpc2qI26eROldwOIlBcPTj6jPfbIJp/90Vx64IZvjTvpzNiQRti7bsuiuBv6cX
         hlODRz2s+I2Qnjgynm2CbiqHb/WegXZxHGJRDi3xHujox76kgfUys7GzpOwelodOCAnE
         vAGUphEZYdLANCUtHQXmwp07YrHaeF3xYnemB70Ehx1Pu1fZMtPy1QMTDAQLPaK5ujKJ
         zw1Q==
X-Gm-Message-State: APzg51A4FeMRoAFVTuvJN9ZkzUOat68ZZge/ISaAG4bPQgVOjS7tUdxX
        VtgWz88nJnSAmo3vt+H3aa1+ChK4yp4=
X-Google-Smtp-Source: ANB0VdZDOBlNihU6ejxtxglTSj88MYSxfpMzfewsdovFY+5epjfVqrIuCunZtZl//z/0Cx/2HblfmQ==
X-Received: by 2002:aca:2808:: with SMTP id 8-v6mr4193351oix.7.1535997800250;
        Mon, 03 Sep 2018 11:03:20 -0700 (PDT)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id q124-v6sm15785737oif.8.2018.09.03.11.03.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 11:03:19 -0700 (PDT)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     linux-pci@vger.kernel.org, bhelgaas@google.com
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
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
        oss-drivers@netronome.com
Subject: [PATCH 4/9] cxgb4: Do not call pcie_print_link_status()
Date:   Mon,  3 Sep 2018 13:02:31 -0500
Message-Id: <20180903180242.14504-5-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180903180242.14504-1-mr.nuke.me@gmail.com>
References: <20180903180242.14504-1-mr.nuke.me@gmail.com>
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
index 961e3087d1d3..1deb68c99a63 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -5782,9 +5782,6 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
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

