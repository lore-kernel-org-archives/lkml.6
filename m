Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE52DC67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8121520870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fz7hubyI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8121520870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbeLLQkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 11:40:14 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46095 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbeLLQkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 11:40:10 -0500
Received: by mail-pl1-f196.google.com with SMTP id t13so8827415ply.13;
        Wed, 12 Dec 2018 08:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=D43uoFqcGJrTjxZC5mtjS6TtrTxlwfMPDUxCa/RGkfw=;
        b=Fz7hubyIV/QYUCPM3YGaFHVmr9+EIEE0omyDxynqGdhXFfCDF8hFpvKrDAyHlyTF0X
         A5JwWtzZ41JDQ+GGp5a+1iFPdKHn8oP8LiCD8F+Qs6oKQeWW2bdIgd1NeliMtC8W8xYl
         yrLCzw5bLvwopIyoDiTMArJ4cKvmdBxyFTUPJXRF+bQIHT9uin4S5W5pJQMdqwMg+gcu
         cMkcHOZbHa/FyO5KEg2MeqaBglqHhnbTNKR17kZjIg3ByPAkL0X4bG00wnqjM/KlXbn4
         tshI054JEZY41jNP+N90YC+WRGpijaVbciqpBDOrOcQGEPUhzHWFvtjRj2TnrVDVog93
         SLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=D43uoFqcGJrTjxZC5mtjS6TtrTxlwfMPDUxCa/RGkfw=;
        b=uK1t18l71Vn6zRGUIE6con9DpuP/y7LyOo6pojoHLjO1BMwepMRwIMPxCvBtdhEYMu
         oDj45GypVI5xHU/BF6NovHK3w34UuMlGn6JW2Vqrc5Kk7jvpftG3qZN8CtV8qMYeU3DW
         JFUS5d91Ve+5rpWJxqG7TVl+WBT9HdEACaxRb948j5cy1LJMqKjgzcvMelKNn0sMuqE0
         XIRLtgqkwa7SsNbvFzpBYNOPPJTJLVR8NSTd8zAe9tx+Dzww3WpHZ+AhVd3r27oY7Lxs
         GZfmjykymA4AJGX4KCyU0SEV1zVTVwDtL2Vvo2NXDf4+ZkoXKDQa6M7qBfmAvlL7XSuH
         uWFA==
X-Gm-Message-State: AA+aEWa6zg5e8CFeXIchfBFGQ3z8W1hqY8pNh0tJ7e9siwGzejF83ACO
        +56mrfAC06SYZoLOhOP+/So=
X-Google-Smtp-Source: AFSGD/UCiCdJQ+1BtNaV/5LbSBW+fgYKpy201HLLse7UREOBrFKaAEbvGUKn06WXEbb+EtRW9xkcgg==
X-Received: by 2002:a17:902:b48b:: with SMTP id y11mr19705214plr.200.1544632809419;
        Wed, 12 Dec 2018 08:40:09 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id o1sm28785465pgn.63.2018.12.12.08.40.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 08:40:08 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     jakub.kicinski@netronome.com, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2] netdevsim: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Wed, 12 Dec 2018 11:40:07 -0500
Message-Id: <20181212164007.23881-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
v2:
-update subject
---
 drivers/net/netdevsim/bpf.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/net/netdevsim/bpf.c b/drivers/net/netdevsim/bpf.c
index cb3518474f0e..14b4d9774708 100644
--- a/drivers/net/netdevsim/bpf.c
+++ b/drivers/net/netdevsim/bpf.c
@@ -48,7 +48,7 @@ struct nsim_bpf_bound_map {
 	struct list_head l;
 };
 
-static int nsim_debugfs_bpf_string_read(struct seq_file *file, void *data)
+static int nsim_bpf_string_show(struct seq_file *file, void *data)
 {
 	const char **str = file->private;
 
@@ -57,19 +57,7 @@ static int nsim_debugfs_bpf_string_read(struct seq_file *file, void *data)
 
 	return 0;
 }
-
-static int nsim_debugfs_bpf_string_open(struct inode *inode, struct file *f)
-{
-	return single_open(f, nsim_debugfs_bpf_string_read, inode->i_private);
-}
-
-static const struct file_operations nsim_bpf_string_fops = {
-	.owner = THIS_MODULE,
-	.open = nsim_debugfs_bpf_string_open,
-	.release = single_release,
-	.read = seq_read,
-	.llseek = seq_lseek
-};
+DEFINE_SHOW_ATTRIBUTE(nsim_bpf_string);
 
 static int
 nsim_bpf_verify_insn(struct bpf_verifier_env *env, int insn_idx, int prev_insn)
-- 
2.17.0

