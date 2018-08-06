Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF34BC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 799C521A13
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKwLYIWQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 799C521A13
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387545AbeHGBh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 21:37:56 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:38022 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731308AbeHGBhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 21:37:55 -0400
Received: by mail-oi0-f67.google.com with SMTP id v8-v6so25265994oie.5;
        Mon, 06 Aug 2018 16:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mCBhyT7m82JCvv9Qmq19HGSyTY8I4ZV8neCBY0l2Uko=;
        b=iKwLYIWQXSuIciJDCA4EF5lho2Mo06rNV3Ln80Pj5ty6C8RTztYhy82u8itZUC7rpe
         Fr5HDzk2OBNwW1WwDZGVemoma9tapURt+rPrJW/K4ZSeDNCmHUWUxR3dPke3mLFCyd7v
         ckJZUB7NhFoH+2BA68IfDmIrQ1F1WvaBm8pULofjoJdYfGoCJZ9Fm74ag5MLyeNNP+eg
         qAy4bV1f9LCZx4/JUQhB+3VUtRMX/biFIKXkPrL+8avdGahINUb6Ri+tLwpl6oS1/EsP
         GE9DIXZD6bZDq4BFSTdvRg0BHCK6uYKUySxhgW2Ndl96g2ZyerSbDgn1PtGp0S+P0Ilz
         ZSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mCBhyT7m82JCvv9Qmq19HGSyTY8I4ZV8neCBY0l2Uko=;
        b=OAedSC5GiHSQlWRKUcSRhqkncaqYSNHB65f+BnSxnWJNs/kgZZlTSnRP3tNNBPWPgH
         5cFrHygIU9/3JUA/mJr6tyEjTDIsJMz+XjWsCUh++ec+nnrf5uXI54xm2ef17vMAihXP
         diV8OEs1B2WKyDr3wxdfKbbwEwosnOqqcedSoIwdA5KR8L+hq11w+kPZUXGDrxcTZpbO
         XogSCEu1iddyKpaANUxPuzJT7nkQFeJ3xGjnLN2ZHaON/aRkVJKtBZqdBuFOEEehEu3/
         zF4UcBVpUi0Q+GbMBSVsZqUSBHekARHvdjnQfyRELd/QkyGX+9I6DyFDeJPqpd96QInl
         tkHQ==
X-Gm-Message-State: AOUpUlEOcip1IDPWYLpVACEsiaLn3s13ux9vbey3vJaxgujV1Y4JFVyJ
        QwZsqZ6fUGICp8qjEGy89e+CfQACLQM=
X-Google-Smtp-Source: AA+uWPyuPmBsvoqrTYHPT3nFTU2RL9puB9Bl5t/8AqCHT0iTvF/rFT8lnWVS4552IRzt15LXYv9Ebg==
X-Received: by 2002:aca:cd84:: with SMTP id d126-v6mr17849769oig.325.1533597991176;
        Mon, 06 Aug 2018 16:26:31 -0700 (PDT)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id w13-v6sm10613328oiw.51.2018.08.06.16.26.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 16:26:30 -0700 (PDT)
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
Subject: [PATCH v6 2/9] bnx2x: Do not call pcie_print_link_status()
Date:   Mon,  6 Aug 2018 18:25:36 -0500
Message-Id: <20180806232600.25694-2-mr.nuke.me@gmail.com>
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
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 57348f2b49a3..3eadd6201dff 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -14100,7 +14100,6 @@ static int bnx2x_init_one(struct pci_dev *pdev,
 	       board_info[ent->driver_data].name,
 	       (CHIP_REV(bp) >> 12) + 'A', (CHIP_METAL(bp) >> 4),
 	       dev->base_addr, bp->pdev->irq, dev->dev_addr);
-	pcie_print_link_status(bp->pdev);
 
 	bnx2x_register_phc(bp);
 
-- 
2.17.1

