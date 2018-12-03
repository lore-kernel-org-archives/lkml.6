Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C63C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01BB0206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iub4ZF/L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01BB0206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbeLCOXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 09:23:24 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42399 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbeLCOXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 09:23:23 -0500
Received: by mail-pl1-f196.google.com with SMTP id y1so1740233plp.9;
        Mon, 03 Dec 2018 06:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4YfiQXJj4yKrRnSl7nTTGshx8IYMROHD4JklpRJUxbw=;
        b=iub4ZF/LhjqW8D9jXPm752i4U4u+beZheyvvA8dOo8ug9yWELtwyP4fAsynnk46xOW
         oXG/gBvL97UJsPxWWl6HsbsL0Ac+oKix48fJ3zOThdVnO266ZRFR9zRtdHtvzrvlj4iE
         4T+5fFRAz5Da0oRTY4uzThMD/JG8B+Xn5lsXYgACEWgL29AVC9uk0xtPF9yKKBv2wPn0
         Nl7aTlD6f8FHfNg0gqG/lu+42KmV5oR6feekrU3HjKGZF4tkgSeJ6R/F02RPAIke7GLd
         U5rxjEhlUwCN5kNTjphcDA0Ox5IUt+JSwPbghGpiTCzBGEIep9MWRcqWxDtGH50D4Sj2
         b74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4YfiQXJj4yKrRnSl7nTTGshx8IYMROHD4JklpRJUxbw=;
        b=roTjgph1QWNZiaFgVZp0uHvs5dpj+/gRWqJoMCSLX8I1F10XLcP9Ae8OizwybSUvj8
         z250tHuhFzvXXnetm9eTz4WbOYoGjiAh9/USAvl8qua+YpgDIu3RCTXxD62iZSonXoV1
         A0x+BeHf6VEuXdDNILfbLeK3KSkv9iY5VcDfwJ0A2nDDzKJwbwGf9OYQMPq2sEQ8SDyZ
         NCrhJgSLoQZYTHO3ilEhViRMS4iQXY3orzL0fOWkj1gtrLny/RgMs1IMN5c4tYX30ify
         672IfwedNh9wZ7zqaX82zJuakrZhfcNVHkMZvJBlNlNabf0uZo0W9No4dSWCxlYd4zFk
         rnMw==
X-Gm-Message-State: AA+aEWZ3G6ps0QSGPzGGBB9NafYbRLXslYanrsKYWOzmnt/UKRTT6Ftx
        XMmzb2NxeKVuhcWzHULJid0=
X-Google-Smtp-Source: AFSGD/Xp1J/ADngiBb8D/QBTRYHAKdnXfwAaff9FmSpn2imvcTAVk8/ycPwTMKbjZDY/gukoqOBp2w==
X-Received: by 2002:a17:902:298a:: with SMTP id h10mr16275009plb.312.1543846931773;
        Mon, 03 Dec 2018 06:22:11 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id j70sm19325775pfc.43.2018.12.03.06.22.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 06:22:11 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, davem@davemloft.net,
        mcoquelin.stm32@gmail.com
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] net: stmmac: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Mon,  3 Dec 2018 09:22:09 -0500
Message-Id: <20181203142209.13044-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 34 +++----------------
 1 file changed, 4 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 076a8be18d67..c728ed1375b2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3891,7 +3891,7 @@ static void sysfs_display_ring(void *head, int size, int extend_desc,
 	}
 }
 
-static int stmmac_sysfs_ring_read(struct seq_file *seq, void *v)
+static int stmmac_rings_status_show(struct seq_file *seq, void *v)
 {
 	struct net_device *dev = seq->private;
 	struct stmmac_priv *priv = netdev_priv(dev);
@@ -3933,23 +3933,9 @@ static int stmmac_sysfs_ring_read(struct seq_file *seq, void *v)
 
 	return 0;
 }
+DEFINE_SHOW_ATTRIBUTE(stmmac_rings_status);
 
-static int stmmac_sysfs_ring_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, stmmac_sysfs_ring_read, inode->i_private);
-}
-
-/* Debugfs files, should appear in /sys/kernel/debug/stmmaceth/eth0 */
-
-static const struct file_operations stmmac_rings_status_fops = {
-	.owner = THIS_MODULE,
-	.open = stmmac_sysfs_ring_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
-static int stmmac_sysfs_dma_cap_read(struct seq_file *seq, void *v)
+static int stmmac_dma_cap_show(struct seq_file *seq, void *v)
 {
 	struct net_device *dev = seq->private;
 	struct stmmac_priv *priv = netdev_priv(dev);
@@ -4012,19 +3998,7 @@ static int stmmac_sysfs_dma_cap_read(struct seq_file *seq, void *v)
 
 	return 0;
 }
-
-static int stmmac_sysfs_dma_cap_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, stmmac_sysfs_dma_cap_read, inode->i_private);
-}
-
-static const struct file_operations stmmac_dma_cap_fops = {
-	.owner = THIS_MODULE,
-	.open = stmmac_sysfs_dma_cap_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(stmmac_dma_cap);
 
 static int stmmac_init_fs(struct net_device *dev)
 {
-- 
2.17.0

