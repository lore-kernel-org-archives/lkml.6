Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E1FC00449
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 00:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBC40213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 00:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1UiJINU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBC40213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbeJDHAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 03:00:05 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33582 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbeJDHAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 03:00:05 -0400
Received: by mail-wm1-f68.google.com with SMTP id y140-v6so355774wmd.0;
        Wed, 03 Oct 2018 17:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tb3R41wl20clZlH+Lc9pp7bzGmfrXUQ2YG61xEliRdA=;
        b=X1UiJINUtJkEy9KU2UOOnwBtFVnBFj+IT5a4lAHafEfclmQQQDSKsbEY8f47ArNVV8
         kMfA0Nw7kej4IMs1EJhs0T+s9uukXfVzJ+hK6TkycTLKhaFuoQ1sLTLb7ibg460gMc1t
         qm5WqxdcfSrQbY6tpS9gTxzAAGOuNXybu22Xo40p+pLCfgvm2YtB7TXc+Jv0JDkOF0YH
         4juoo/Wf3bL50mIVIGvzFLYv6bKZR9bJWS5JRx5/tm7BP1LyfkW2rnNyZNKVQlPAq8RQ
         zG26I1aoKdWD5CP7smtzh0wv4OHy1K7lS0vN1onRhn/zgzkHvXqNOk0549SK32QAUl4K
         k+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tb3R41wl20clZlH+Lc9pp7bzGmfrXUQ2YG61xEliRdA=;
        b=uNwb4xGaUzTb1e02L47K7/OpSUOuHC2XteBoSHVhMV9qLu//1R2VBUDw63ED7V3K+c
         8bQIj5RfC7nyhlgdVyXR/iKz76oQJSNCN4RmqsbwprFieOGGUAoGhDzHxc0wd0SVsKVT
         5cz03h6clHLk3VVb5rUrYnh5gMqUyUlPd3OTmC7HODJY9hiyrxaNQ9VsriLFWD2FeEAi
         +YFl1LbGJtrYw398JF+XMqkPJlyIJZkYW/0pr2yZsNfq6pZ656YBrxkTXxOfE1JPSB9I
         E4gJluF3tun2TyiWj79mImrY5xd13Cv8aEJrjgpbLt8ULQhJcblJiN7y46APyuEETu7p
         dcAQ==
X-Gm-Message-State: ABuFfogGIxuklJefIVXjMayuwOpKQWA/ZRXF/0vqrnAIKDvj4CzBVD7P
        MViVi4pvkJUkHnfqwEZnX18=
X-Google-Smtp-Source: ACcGV63xu8TTBjXV2BaRIblQHCkDECUUO8cncnlHZ2Fo5Ub74NLtuoG+acEpG2cMIG9zOxmmd1wo9g==
X-Received: by 2002:a1c:58f:: with SMTP id 137-v6mr2936557wmf.37.1538611764159;
        Wed, 03 Oct 2018 17:09:24 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id y7-v6sm2064524wmy.27.2018.10.03.17.09.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 17:09:23 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Ariel Elior <Ariel.Elior@cavium.com>, everest-linux-l2@cavium.com,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] qed: Remove unneeded enumerated type core_tx_dest
Date:   Wed,  3 Oct 2018 17:09:12 -0700
Message-Id: <20181004000912.22242-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when one enumerated type is implicitly converted to another.

drivers/net/ethernet/qlogic/qed/qed_ll2.c:799:32: warning: implicit
conversion from enumeration type 'enum core_tx_dest' to different
enumeration type 'enum qed_ll2_tx_dest' [-Wenum-conversion]
                tx_pkt.tx_dest = p_ll2_conn->tx_dest;
                               ~ ~~~~~~~~~~~~^~~~~~~
1 warning generated.

These enumerated types are not 1 to 1:

/* Light L2 TX Destination */
enum core_tx_dest {
    CORE_TX_DEST_NW,
    CORE_TX_DEST_LB,
    CORE_TX_DEST_RESERVED,
    CORE_TX_DEST_DROP,
    MAX_CORE_TX_DEST
};

enum qed_ll2_tx_dest {
    QED_LL2_TX_DEST_NW, /* Light L2 TX Destination to the Network */
    QED_LL2_TX_DEST_LB, /* Light L2 TX Destination to the Loopback */
    QED_LL2_TX_DEST_DROP, /* Light L2 Drop the TX packet */
    QED_LL2_TX_DEST_MAX
};

Fix this conversion warning by adding CORE_TX_DEST_DROP to
qed_ll2_tx_dest and converting all values of core_tx_dest to
the equivalent value in qed_ll2_tx_dest so that there is no
conversion warning or functional change.

Link: https://github.com/ClangBuiltLinux/linux/issues/125
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

I'm by no means married to the name of the new enum value, it could even
be CORE_TX_DEST_DROP (didn't know if that was going to set anyone off or
not) but this is the cleanest solution to the warning in my opinion but
I'm open to other opinions.

 drivers/net/ethernet/qlogic/qed/qed_hsi.h |  9 ---------
 drivers/net/ethernet/qlogic/qed/qed_ll2.c | 16 ++++++++--------
 drivers/net/ethernet/qlogic/qed/qed_ll2.h |  2 +-
 include/linux/qed/qed_ll2_if.h            |  1 +
 4 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_hsi.h b/drivers/net/ethernet/qlogic/qed/qed_hsi.h
index 15b4cd317f14..c2ce8428c413 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_hsi.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_hsi.h
@@ -331,15 +331,6 @@ struct core_tx_bd {
 #define CORE_TX_BD_TX_DST_SHIFT			14
 };
 
-/* Light L2 TX Destination */
-enum core_tx_dest {
-	CORE_TX_DEST_NW,
-	CORE_TX_DEST_LB,
-	CORE_TX_DEST_RESERVED,
-	CORE_TX_DEST_DROP,
-	MAX_CORE_TX_DEST
-};
-
 /* Ramrod data for tx queue start ramrod */
 struct core_tx_start_ramrod_data {
 	struct regpair pbl_base_addr;
diff --git a/drivers/net/ethernet/qlogic/qed/qed_ll2.c b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
index da13117a604a..741185a62e84 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_ll2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
@@ -1345,13 +1345,13 @@ int qed_ll2_acquire_connection(void *cxt, struct qed_ll2_acquire_data *data)
 
 	switch (data->input.tx_dest) {
 	case QED_LL2_TX_DEST_NW:
-		p_ll2_info->tx_dest = CORE_TX_DEST_NW;
+		p_ll2_info->tx_dest = QED_LL2_TX_DEST_NW;
 		break;
 	case QED_LL2_TX_DEST_LB:
-		p_ll2_info->tx_dest = CORE_TX_DEST_LB;
+		p_ll2_info->tx_dest = QED_LL2_TX_DEST_LB;
 		break;
 	case QED_LL2_TX_DEST_DROP:
-		p_ll2_info->tx_dest = CORE_TX_DEST_DROP;
+		p_ll2_info->tx_dest = QED_LL2_TX_DEST_DROP_CORE;
 		break;
 	default:
 		return -EINVAL;
@@ -1684,7 +1684,7 @@ qed_ll2_prepare_tx_packet_set_bd(struct qed_hwfn *p_hwfn,
 	u16 prod_idx = qed_chain_get_prod_idx(p_tx_chain);
 	struct core_tx_bd *start_bd = NULL;
 	enum core_roce_flavor_type roce_flavor;
-	enum core_tx_dest tx_dest;
+	enum qed_ll2_tx_dest tx_dest;
 	u16 bd_data = 0, frag_idx;
 
 	roce_flavor = (pkt->qed_roce_flavor == QED_LL2_ROCE) ? CORE_ROCE
@@ -1692,16 +1692,16 @@ qed_ll2_prepare_tx_packet_set_bd(struct qed_hwfn *p_hwfn,
 
 	switch (pkt->tx_dest) {
 	case QED_LL2_TX_DEST_NW:
-		tx_dest = CORE_TX_DEST_NW;
+		tx_dest = QED_LL2_TX_DEST_NW;
 		break;
 	case QED_LL2_TX_DEST_LB:
-		tx_dest = CORE_TX_DEST_LB;
+		tx_dest = QED_LL2_TX_DEST_LB;
 		break;
 	case QED_LL2_TX_DEST_DROP:
-		tx_dest = CORE_TX_DEST_DROP;
+		tx_dest = QED_LL2_TX_DEST_DROP_CORE;
 		break;
 	default:
-		tx_dest = CORE_TX_DEST_LB;
+		tx_dest = QED_LL2_TX_DEST_LB;
 		break;
 	}
 
diff --git a/drivers/net/ethernet/qlogic/qed/qed_ll2.h b/drivers/net/ethernet/qlogic/qed/qed_ll2.h
index 1a5c1ae01474..e676bbaf55c9 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_ll2.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_ll2.h
@@ -119,7 +119,7 @@ struct qed_ll2_info {
 	u8 queue_id;
 	u8 tx_stats_id;
 	bool b_active;
-	enum core_tx_dest tx_dest;
+	enum qed_ll2_tx_dest tx_dest;
 	u8 tx_stats_en;
 	bool main_func_queue;
 	struct qed_ll2_rx_queue rx_queue;
diff --git a/include/linux/qed/qed_ll2_if.h b/include/linux/qed/qed_ll2_if.h
index 5eb022953aca..1b260e73943c 100644
--- a/include/linux/qed/qed_ll2_if.h
+++ b/include/linux/qed/qed_ll2_if.h
@@ -65,6 +65,7 @@ enum qed_ll2_tx_dest {
 	QED_LL2_TX_DEST_NW, /* Light L2 TX Destination to the Network */
 	QED_LL2_TX_DEST_LB, /* Light L2 TX Destination to the Loopback */
 	QED_LL2_TX_DEST_DROP, /* Light L2 Drop the TX packet */
+	QED_LL2_TX_DEST_DROP_CORE, /* CORE_TX_DEST_DROP value */
 	QED_LL2_TX_DEST_MAX
 };
 
-- 
2.19.0

