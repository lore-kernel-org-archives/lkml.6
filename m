Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58230ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 19:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E42F32075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 19:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pdx-edu.20150623.gappssmtp.com header.i=@pdx-edu.20150623.gappssmtp.com header.b="K/TT4VQQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E42F32075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pdx.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbeGRT7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 15:59:04 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42356 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbeGRT7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 15:59:04 -0400
Received: by mail-pl0-f66.google.com with SMTP id z7-v6so693844plo.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 12:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdx-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=S/qkDujuQp4HxmRf7iI81InKhT7w3nQvxnb1/+By4vU=;
        b=K/TT4VQQALbqMJ3zdC9WYqeB9NaOYQzsp/XNGosPS9Dz/oNkWsbPYhJQKDXjqOC0bG
         T6GteEskVkU0jG2dxvklxHkG+DsAirRWCDP5BErrUJ9IvA73gdeHxwplXaIdTHLbK28y
         CWHnQ+D+Qso3skkyH6MmvW1qXEEBKIJXQrScIswPJ90V8BB2XPHWNNduDY8pneC0bkux
         /vC+4jTUX0dnPGZq0Y+BmIk37ImZ0LhzjhVB0ubL8VXqQQTEtKThJUmqG4X2ncvPg3Pg
         pYyz/KtT9uGbz1LkMxyPhmtP2k0/5w+fMs/+MNMYdFv6aOF+hTObjwW4JVliw7oiVmMP
         3w3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=S/qkDujuQp4HxmRf7iI81InKhT7w3nQvxnb1/+By4vU=;
        b=PD4I5/VXu7xY2wC8IRTuPZSM0y8lww2mRaxAgOsh8xCKmeYVPvU2pCa9kqX5h7H7HL
         cRQ8tmS8S9bQu9I1MoW+x2kCQ2p98rbAbK75cwXb+6FSz+C5TlyBGVkBimrH9t7qBU7N
         xUMckW3EAetRMjYxcunCaqftNCCsyI0TwGlIkkUCWB+S7USYfojJTxuuvrot+tO9O2ko
         cQXU/5oiP+UVwT0CELNGEkwAtyC9NNWztcfJEtmJm2wfZTVIPt5OGYRFzJifBw1XdLt6
         cEl0PsbzEz6M7eDKNYjRQWIdudEDfXKAYcR30kw0uzujgs7D3hJPAbBPCm/8wr6v7Y8F
         l9bQ==
X-Gm-Message-State: AOUpUlHH7a29YuJl8aLs+9LQY68igVCoVdzBgRw6Mz9N9tlWZRmjKqrH
        xu+ofAmCESUz3tqgC5+p6Bl+KA==
X-Google-Smtp-Source: AAOMgpc00rRtsgeT6Fa+DRj3WlsoDWj0CZVTH5u/hJox3qOU0tGPCzMQvgaSZbz8Wiomds5puY71/A==
X-Received: by 2002:a17:902:64c2:: with SMTP id y2-v6mr7097160pli.53.1531941586315;
        Wed, 18 Jul 2018 12:19:46 -0700 (PDT)
Received: from svl13.cs.pdx.edu (svl13.cs.pdx.edu. [131.252.209.5])
        by smtp.gmail.com with ESMTPSA id x25-v6sm5910595pgv.63.2018.07.18.12.19.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Jul 2018 12:19:45 -0700 (PDT)
From:   Bo Chen <chenbo@pdx.edu>
To:     jeffrey.t.kirsher@intel.com
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, phenix1108@gmail.com,
        Bo Chen <chenbo@pdx.edu>
Subject: [PATCH] e1000: ethtool: check on netif_running() before calling e1000_up()
Date:   Wed, 18 Jul 2018 12:18:51 -0700
Message-Id: <20180718191851.31984-1-chenbo@pdx.edu>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the device is not up, the call to 'e1000_up()' from the error handling path
of 'e1000_set_ringparam()' causes a kernel oops with a null-pointer
dereference. The null-pointer dereference is triggered in function
'e1000_alloc_rx_buffers()' at line 'buffer_info = &rx_ring->buffer_info[i]'.

This bug was reported by COD, a tool for testing kernel module binaries I am
building. This bug was also detected by KFI from Dr. Kai Cong.

This patch fixes the bug by checking on 'netif_running()' before calling
'e1000_up()' in 'e1000_set_ringparam()'.

Signed-off-by: Bo Chen <chenbo@pdx.edu>
---
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
index bdb3f8e65ed4..c1e4e94f100f 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
@@ -644,7 +644,8 @@ static int e1000_set_ringparam(struct net_device *netdev,
 err_alloc_rx:
 	kfree(txdr);
 err_alloc_tx:
-	e1000_up(adapter);
+	if (netif_running(adapter->netdev))
+		e1000_up(adapter);
 err_setup:
 	clear_bit(__E1000_RESETTING, &adapter->flags);
 	return err;
-- 
2.17.0

