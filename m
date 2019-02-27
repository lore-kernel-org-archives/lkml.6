Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD38C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A3DD218CD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n+3czmKt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbfB0GJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 01:09:56 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35620 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfB0GJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 01:09:55 -0500
Received: by mail-pl1-f193.google.com with SMTP id p19so7473037plo.2;
        Tue, 26 Feb 2019 22:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r3a2hf4POYiTeKcmsyeGQC+488vzRS8ccxKo/w+H1ck=;
        b=n+3czmKtUTpMp4LbnEdh1ap8N3heUwfcM/KQc3TQhM1r7IhldV8p3Uc7qx6cPw4GE3
         FrWm+8JE2/V2NHBVshoDZesG2oFqBzonJlva1ub05HPU7fAzZW4XtbdsONQHoGReAnPT
         1GpnAbRXnnif8IbVz6reNS+LPbLz82v3D1XdyoBSF9bfdqUSc1DuZvgbPkAImo2PrKhJ
         qjMF2Kyd23BIsGK5GMcvBhEFe1u0xtXbnfcuzijJexUykoo3bBNuYhbImNrH2yCL4A7E
         Q9ZwZx8vBu1cUADhmICWAlc5NdxEdfLGsUGWWnQhFmqXcKzR0dqycWGFMfrnz/8nLJz5
         zXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r3a2hf4POYiTeKcmsyeGQC+488vzRS8ccxKo/w+H1ck=;
        b=pZBPxneaxR1adU5qnFkuJFxEhiVaUAWLoZn4Hst7KsvVN7bVhPFDNl3Nhr0JFb64IY
         VsilipOIvqeckqMTAH8Fsnt/JY0JTO473XSIZwYG187iGqEHdIpr8ntV/98CimTHqC3d
         uNCn9pDz8Ig9moMqX/vgt++5GDUmpVYnqOhLBoAZ1CJttxQmLHkaOXfbEvKAhqXWesTp
         XGQbNYbENX6/h+B53WCEfbVNvac+wiV5giPMd2iSgZe2DMe7JsijFNiisFjIKtwHs6qU
         lrWCkAunLgucosDU6ajLDPpQXYKVzbywZluOypfQClGw0dWd5emOqpjtZgkqeR0brQ5I
         86xA==
X-Gm-Message-State: AHQUAuYO0bGv1Gsx/MS0V0BLY7S6HBALVIAWKpY8rpqejw+D0aq2ublb
        gJBbE+WXHMSP5uer2NzUZhM=
X-Google-Smtp-Source: AHgI3IZw/t0yrCMIPq3eDjR2Op3yqkDkn2hexMwyp5jUAiedrcRtnqgdfyNPcbdmcKWnHV8JUConqQ==
X-Received: by 2002:a17:902:2a6b:: with SMTP id i98mr431161plb.153.1551247794490;
        Tue, 26 Feb 2019 22:09:54 -0800 (PST)
Received: from bobby.hsd1.or.comcast.net ([2601:1c0:5501:37e2::87c4])
        by smtp.googlemail.com with ESMTPSA id d5sm20733473pfo.83.2019.02.26.22.09.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 22:09:54 -0800 (PST)
From:   Robert Eshleman <bobbyeshleman@gmail.com>
To:     bobbyeshleman@gmail.com
Cc:     Jay Cliburn <jcliburn@gmail.com>,
        Chris Snook <chris.snook@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Tariq Toukan <tariqt@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: [PATCH 5/8] at12: use pci_zalloc instead of pci_alloc
Date:   Tue, 26 Feb 2019 22:09:52 -0800
Message-Id: <485f61fd135d56e6e0c66ec41770ce7e5b8b219e.1551246708.git.bobbyeshleman@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1551246708.git.bobbyeshleman@gmail.com>
References: <cover.1551246708.git.bobbyeshleman@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces a pci_alloc and memset(,0) call
with a single call to pci_zalloc.

Signed-off-by: Robert Eshleman <bobbyeshleman@gmail.com>
---
 drivers/net/ethernet/atheros/atlx/atl2.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/atheros/atlx/atl2.c b/drivers/net/ethernet/atheros/atlx/atl2.c
index bb41becb6609..a145c2d1b1d2 100644
--- a/drivers/net/ethernet/atheros/atlx/atl2.c
+++ b/drivers/net/ethernet/atheros/atlx/atl2.c
@@ -300,11 +300,10 @@ static s32 atl2_setup_ring_resources(struct atl2_adapter *adapter)
 		adapter->txs_ring_size * 4 + 7 +	/* dword align */
 		adapter->rxd_ring_size * 1536 + 127;	/* 128bytes align */
 
-	adapter->ring_vir_addr = pci_alloc_consistent(pdev, size,
-		&adapter->ring_dma);
+	adapter->ring_vir_addr = pci_zalloc_consistent(pdev, size,
+						       &adapter->ring_dma);
 	if (!adapter->ring_vir_addr)
 		return -ENOMEM;
-	memset(adapter->ring_vir_addr, 0, adapter->ring_size);
 
 	/* Init TXD Ring */
 	adapter->txd_dma = adapter->ring_dma ;
-- 
2.20.1

