Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043C6C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B623F20873
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwV98YB6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B623F20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbeICWYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 18:24:44 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:37523 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbeICWYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 18:24:44 -0400
Received: by mail-oi0-f65.google.com with SMTP id p84-v6so2270045oic.4;
        Mon, 03 Sep 2018 11:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6ffzopQXccTuXo2gTw9Fy1V9dviCucvVy+ObNtSf4IU=;
        b=ZwV98YB63d9YbkVBKdu3sPV7CxQ0FNWcTForlLN0/gRKhsopWeEyOsJnPY72OJuI8Y
         zw6h621CJzhqAIycGVu9pFf/TxsQ9OrPUcD10muYksWYdA5RYpFca0zxikpl4Lmcm5jb
         kNPkt7RyDlpZPKTdd9gBMth31DhJ1pCQ5/oYmMrjOw/k9N54AD+YVd4PV87joPnXUXg2
         9ML/tommEcrJIh4u3qRVw9u50BHEY7IojqFhhU59RKwq3GQy9nwYVqROHXarkmz887JX
         Zfr32yFVb62WqPlr4m9ayUxlAVBxVaRAd+rQRAOgaMWdxT+PHrRdjvM3NvZNy51w05Yo
         zHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6ffzopQXccTuXo2gTw9Fy1V9dviCucvVy+ObNtSf4IU=;
        b=Vm7rK1BWjzGqDwrs07rJLfzEeMln0bkWHOmV5Crh3EWASpHNtAo0KU+9vCxKfm57Kf
         uL4Mx0blc1mEXcOJRP/zMlRNp3QxyKeu9IqBofiprcBIt8gnd8pZy8VifrK5DOThwQcT
         kYY87IFJ5ayj+Z8Sw8CC8LIQXF2YtB1HBi7nLcDedhHoiuy7p3SbqajS+24K7ax5QpQP
         Y7YAfoV4WUpQcgZdTaqb7BVIQVukc2PMf3YSYhChdDwoH2pIrMJ2ODVzq2+VI8af6A88
         YP+XDadHrOIZevVn5klLQnSBUdC3H/jC7Shk78iDRwnsC/LppvfnKpYQ2WvYa8YixBAe
         zqiw==
X-Gm-Message-State: APzg51DoPDkxpC8q3lufDj4H0ebJnC1PRx0oND8kHKjpHctyIRAemkOf
        41y99kLArbffURMRYmeeuhwf/31fJCY=
X-Google-Smtp-Source: ANB0VdZQU6fMtSfGvwkaZeV39sMOYopHUPadaDGBG40SZ9w2C6eupe8W1StYB6Um9SUhT9wA9TVTsA==
X-Received: by 2002:aca:3254:: with SMTP id y81-v6mr19459024oiy.317.1535997805841;
        Mon, 03 Sep 2018 11:03:25 -0700 (PDT)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id q124-v6sm15785737oif.8.2018.09.03.11.03.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 11:03:25 -0700 (PDT)
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
Subject: [PATCH 5/9] fm10k: Do not call pcie_print_link_status()
Date:   Mon,  3 Sep 2018 13:02:32 -0500
Message-Id: <20180903180242.14504-6-mr.nuke.me@gmail.com>
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

