Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D589FC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C9AF21A5C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LdZY/R6M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C9AF21A5C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934687AbeGFSpe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 14:45:34 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40335 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934372AbeGFSox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 14:44:53 -0400
Received: by mail-lj1-f195.google.com with SMTP id a6-v6so9838583ljj.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 11:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iNJp3bA1HPrmxKSHRfEc7Kw5FQhP8REbtrVID/LEq/Y=;
        b=LdZY/R6M4rhE+IKqQQUFuqQJmpbcPPuaz1+YxRWbd8lMFrhCyIZ/LyKg4FNFjdf/MA
         IzDmx7EgDblTUdYWZF/92tY/qZEzUSQoI/5+F3lJZcyFnw9bzaPFalanhnjaD7bfGaXk
         lfbTknJxUBf7oNu4+DnGolEo81nJRytAxUan4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iNJp3bA1HPrmxKSHRfEc7Kw5FQhP8REbtrVID/LEq/Y=;
        b=QYwK9yPZDFC8/T1BdDRHJGQqwnsZN1Hnh916A35ujKUd4Pv/jX+ztiWFgsGSD7AQ0j
         /SJM9rcdQXnjgwh6196wFfnChbJ7pP7EG2bYpUL/NqaivqguV1QAtozNMFifw9922h5M
         wThawOy8AidGY5Ob/NhjQnL7/xkIYkZ+IoZJPv14W7m9GIxggtJU9Ga1LKsrtl7E3rJg
         CkV/xu5QrsXzVC2MbBHvvkfe1I/xo3zta1WgTTH9H3sWK4jKXDSj8A1aHJJKN7rNNMY4
         Sx/FupOR5oDh4bkU39PyRnNkpjBXZFQGyoPrICG0U/z/N97NNAAPKvGN24XZR6AZVJ1m
         qgxA==
X-Gm-Message-State: APt69E2wAroq56UzGZzpnIAXspMl8REJPObdl/vIzFr8l07l3tzZsE4F
        5JyWHTUlWerAoS7YG8D6YhSxO8LkByc=
X-Google-Smtp-Source: AAOMgperxhwA3qCaq76ZB1CY5MiJQ3RVhR/1iF6KMKHq9d7eSnQaAMn1v6gH8uJbk9BfIOplRUzNeQ==
X-Received: by 2002:a2e:954e:: with SMTP id t14-v6mr3408437ljh.68.1530902691774;
        Fri, 06 Jul 2018 11:44:51 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id h65-v6sm2312063lfb.22.2018.07.06.11.44.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 11:44:51 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, davem@davemloft.net
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH 1/2] net: ethernet: ti: cpsw: use BIT macro
Date:   Fri,  6 Jul 2018 21:44:44 +0300
Message-Id: <20180706184445.29111-2-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180706184445.29111-1-ivan.khoronzhuk@linaro.org>
References: <20180706184445.29111-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's needed to avoid checkpatch warnings for farther changes.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/cpsw.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 093998124149..f355e65323f3 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -253,23 +253,23 @@ struct cpsw_ss_regs {
 #define RX_DSCP_PRI_MAP7    0x4c /* Rx DSCP Priority to Rx Packet Mapping */
 
 /* Bit definitions for the CPSW2_CONTROL register */
-#define PASS_PRI_TAGGED     (1<<24) /* Pass Priority Tagged */
-#define VLAN_LTYPE2_EN      (1<<21) /* VLAN LTYPE 2 enable */
-#define VLAN_LTYPE1_EN      (1<<20) /* VLAN LTYPE 1 enable */
-#define DSCP_PRI_EN         (1<<16) /* DSCP Priority Enable */
-#define TS_320              (1<<14) /* Time Sync Dest Port 320 enable */
-#define TS_319              (1<<13) /* Time Sync Dest Port 319 enable */
-#define TS_132              (1<<12) /* Time Sync Dest IP Addr 132 enable */
-#define TS_131              (1<<11) /* Time Sync Dest IP Addr 131 enable */
-#define TS_130              (1<<10) /* Time Sync Dest IP Addr 130 enable */
-#define TS_129              (1<<9)  /* Time Sync Dest IP Addr 129 enable */
-#define TS_TTL_NONZERO      (1<<8)  /* Time Sync Time To Live Non-zero enable */
-#define TS_ANNEX_F_EN       (1<<6)  /* Time Sync Annex F enable */
-#define TS_ANNEX_D_EN       (1<<4)  /* Time Sync Annex D enable */
-#define TS_LTYPE2_EN        (1<<3)  /* Time Sync LTYPE 2 enable */
-#define TS_LTYPE1_EN        (1<<2)  /* Time Sync LTYPE 1 enable */
-#define TS_TX_EN            (1<<1)  /* Time Sync Transmit Enable */
-#define TS_RX_EN            (1<<0)  /* Time Sync Receive Enable */
+#define PASS_PRI_TAGGED     BIT(24) /* Pass Priority Tagged */
+#define VLAN_LTYPE2_EN      BIT(21) /* VLAN LTYPE 2 enable */
+#define VLAN_LTYPE1_EN      BIT(20) /* VLAN LTYPE 1 enable */
+#define DSCP_PRI_EN         BIT(16) /* DSCP Priority Enable */
+#define TS_320              BIT(14) /* Time Sync Dest Port 320 enable */
+#define TS_319              BIT(13) /* Time Sync Dest Port 319 enable */
+#define TS_132              BIT(12) /* Time Sync Dest IP Addr 132 enable */
+#define TS_131              BIT(11) /* Time Sync Dest IP Addr 131 enable */
+#define TS_130              BIT(10) /* Time Sync Dest IP Addr 130 enable */
+#define TS_129              BIT(9)  /* Time Sync Dest IP Addr 129 enable */
+#define TS_TTL_NONZERO      BIT(8)  /* Time Sync Time To Live Non-zero enable */
+#define TS_ANNEX_F_EN       BIT(6)  /* Time Sync Annex F enable */
+#define TS_ANNEX_D_EN       BIT(4)  /* Time Sync Annex D enable */
+#define TS_LTYPE2_EN        BIT(3)  /* Time Sync LTYPE 2 enable */
+#define TS_LTYPE1_EN        BIT(2)  /* Time Sync LTYPE 1 enable */
+#define TS_TX_EN            BIT(1)  /* Time Sync Transmit Enable */
+#define TS_RX_EN            BIT(0)  /* Time Sync Receive Enable */
 
 #define CTRL_V2_TS_BITS \
 	(TS_320 | TS_319 | TS_132 | TS_131 | TS_130 | TS_129 |\
-- 
2.17.1

