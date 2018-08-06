Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442D7C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F261E21A13
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKmZIRGf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F261E21A13
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388282AbeHGBiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 21:38:12 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:43531 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387557AbeHGBiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 21:38:12 -0400
Received: by mail-oi0-f66.google.com with SMTP id b15-v6so25246120oib.10;
        Mon, 06 Aug 2018 16:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6ffzopQXccTuXo2gTw9Fy1V9dviCucvVy+ObNtSf4IU=;
        b=iKmZIRGfXgDKB9oSLC7FEPEbdY/XzOBNWfksKcwspfJ5G7Rj0ZPEA24fwh7F08JdTw
         by4uoy2qnaqKaFsREEH4xw1aTdL4NRfNmjo3iA7nFqPjJoW441mfZu6d8ULQYeBNuOAl
         gt6dox8ESElqOEVmJGiw99dBhML/EdXhDoDKNVfXfxcV2TgCdqtmnhIpsT91jFKWJMeF
         m2ENA73PjomI14CCBJOULlPqd/BksSSbZ/1xLVua9M+VIrDFkJ5JTW0WCK6KIKIeDfXT
         QlUk8GbpW0SkEZLL+CqdC45lN5lTFMZKuVfNN697pbE8aSPYhvs0b5wNSvYQfVv3Y0p0
         yzpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6ffzopQXccTuXo2gTw9Fy1V9dviCucvVy+ObNtSf4IU=;
        b=OI6oFEQNKIoukT4EHQU5f9OKsZxEqLHCxzvQ2NtCJs3TYh/Tujkbvc3V90Lu5gc9+E
         3a/3VAXLzqYXcfIBAiHsheSsFGS0aRDh/Dfa0DIU6vro2s5fNzLtOxA5MlfZUAB7yufG
         w2QmA+N2PncL1OrP2EO77TGMZJ/Eg492k7d5rtLQwx1+O+JlXxvwBreEUsWPgBREHF53
         0bKjjlu1jyQakxWmK+BkSUJsTKytcSDZXkiC+Jc0+dVqvjFUqMmNkFl0s1BeOfr2Gz7H
         oSOFbqlfaSV0Qx1eCVS/K+qIdrkOmDnyjWmGUAMxwOJzGUqJ8cvo9MtbiXWzRdph/2zK
         QBsg==
X-Gm-Message-State: AOUpUlG2UJXfRxKuwzHKG45RoJpkDBqIl9YkbSEyyZwlNmYZ4m9lRmjE
        7PF1vISzwiEhMEtyINcpfkTroxPsfAk=
X-Google-Smtp-Source: AA+uWPyoIcpOy7uJom0I5L4MC7SyIt5AiuJTfORTCTbNw+SVMpFR6Ewwb3eRMyGLDbNmJ1wbBOxeJQ==
X-Received: by 2002:aca:cf87:: with SMTP id f129-v6mr17472388oig.258.1533598007425;
        Mon, 06 Aug 2018 16:26:47 -0700 (PDT)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id w13-v6sm10613328oiw.51.2018.08.06.16.26.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 16:26:47 -0700 (PDT)
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
Subject: [PATCH v6 5/9] fm10k: Do not call pcie_print_link_status()
Date:   Mon,  6 Aug 2018 18:25:39 -0500
Message-Id: <20180806232600.25694-5-mr.nuke.me@gmail.com>
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
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 15071e4adb98..079fd3c884ea 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -2224,9 +2224,6 @@ static int fm10k_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* kick off service timer now, even when interface is down */
 	mod_timer(&interface->service_timer, (HZ * 2) + jiffies);
 
-	/* print warning for non-optimal configurations */
-	pcie_print_link_status(interface->pdev);
-
 	/* report MAC address for logging */
 	dev_info(&pdev->dev, "%pM\n", netdev->dev_addr);
 
-- 
2.17.1

