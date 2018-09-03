Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD58C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 673DD20843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/DJrNib"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 673DD20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbeICWY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 18:24:56 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:37550 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbeICWYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 18:24:55 -0400
Received: by mail-oi0-f65.google.com with SMTP id p84-v6so2270778oic.4;
        Mon, 03 Sep 2018 11:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qKYr8O6ZndeZ8QF5YqTgpTdYV2iOFBHSVMs0kcFJX4Q=;
        b=X/DJrNibMaD21hNKQRI0BjHbRpTp+iqtUQU9KfIwiS8SZnIVR6f47MAGB+++L1zdSa
         hmWdAjuKw1sywjnpwyWxD1EItrG1pHt2HZvlAipM0j6sAyOlR+J8uMr9FG5rr3y7oZf7
         R3wufW9D+MVLj/VG0S5mFqJfBO6C/S+zRgoC8WmoFN3cFmpxY5AsWreTwBvCeRRFgew7
         SHMjZBnSL07ouz8KBj7of92wZGtnvd0qZpAPUELVBmAbpjj6hKd6xu7Ac7+NUhr0N8fV
         gefEnsPWMtvAXZg7AT+QK6SebfNVbEwDPUyt4eu9UOV/+Jzeb13juDMZ2zZXLhHI9uJD
         6QOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qKYr8O6ZndeZ8QF5YqTgpTdYV2iOFBHSVMs0kcFJX4Q=;
        b=Dn24FpTvW2oXM8cRuTLQ2+dKNReW4b+u1UFudEc+ehtQ+UWXKAnTpUhv8m6UnUbKzi
         Xeh9pcn7CNN6A7NU1YXW2wn7Ygr3K5JNiqXx8C8dma2UaI9OYhl2W3GaGDFj/2kCrhLb
         8oa4KM0OH4C5LdNgA7V40zt5SSgG5akWc3APtRrA2djwHRis2IyYAQHUnCmvhGg2TZDJ
         yR6gdmJr+ySQaMzq8/PfuCHBbhv0+s57E9dvDP2SBycfIPoWfF66o2JSlVDTctwQW8Xw
         LG3TCyWkvELx0gljH/ygUGFEqLjW87ITPc+3wV0eI5QgBKFHuErUG9VwhmfM9fXiGK89
         UCcw==
X-Gm-Message-State: APzg51ASEwn0WyM0Im3qfAOFD+GQoxZ4sf2RxeS4CFsNkpQuwWDIDFRy
        Wj+ModiC4eWC6EUE5pEEXonq71t0Z28=
X-Google-Smtp-Source: ANB0VdaJU3MuJ//4MSJDXwrOw6CR6IXZb2o+ISnr3hNlH5J+fRUIQXKGfwvBvzkAsW9GMyPHh/7Ijg==
X-Received: by 2002:aca:5cd4:: with SMTP id q203-v6mr19325196oib.217.1535997817362;
        Mon, 03 Sep 2018 11:03:37 -0700 (PDT)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id q124-v6sm15785737oif.8.2018.09.03.11.03.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 11:03:36 -0700 (PDT)
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
Subject: [PATCH 7/9] net/mlx4: Do not call pcie_print_link_status()
Date:   Mon,  3 Sep 2018 13:02:34 -0500
Message-Id: <20180903180242.14504-8-mr.nuke.me@gmail.com>
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
 drivers/net/ethernet/mellanox/mlx4/main.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/main.c b/drivers/net/ethernet/mellanox/mlx4/main.c
index d2d59444f562..9902fa3a2c13 100644
--- a/drivers/net/ethernet/mellanox/mlx4/main.c
+++ b/drivers/net/ethernet/mellanox/mlx4/main.c
@@ -3525,13 +3525,6 @@ static int mlx4_load_one(struct pci_dev *pdev, int pci_dev_data,
 		}
 	}
 
-	/* check if the device is functioning at its maximum possible speed.
-	 * No return code for this call, just warn the user in case of PCI
-	 * express device capabilities are under-satisfied by the bus.
-	 */
-	if (!mlx4_is_slave(dev))
-		pcie_print_link_status(dev->persist->pdev);
-
 	/* In master functions, the communication channel must be initialized
 	 * after obtaining its address from fw */
 	if (mlx4_is_master(dev)) {
-- 
2.17.1

