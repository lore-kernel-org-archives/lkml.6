Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BD3C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 947B820819
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="opsn9ier"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 947B820819
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbeKEXwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 18:52:40 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36852 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbeKEXwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 18:52:40 -0500
Received: by mail-pf1-f194.google.com with SMTP id j22-v6so4530644pfh.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 06:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=q/UyctZ3IuOzEhZ86GEcGxYn7ODPlY/62qqfKTvY61k=;
        b=opsn9ier58llwehvmmYUz9+EtjqL1ghQC38nQElNa/1IvqKJgrk7QD5aChbZzGzJd4
         h63xcAmwoq01Y0Q9uTBCN+LemZbafGqDJGCTZxRIyCQPQEdZcgwwpLkmB+QDuiYIuDAI
         E7EUmyK9SICu4q4nZSTrG0h4BF4tH5NKwXSILea1yJv8DXYUbJzfadmfD0iSD1KJhkfW
         pDbDp77w1wYQGrnQboFG0f0ZyWbn67o3ySVZsli/XXj4qVhvxSXyVKzHGvwPIExwMRY6
         1/UHy6fBWc8vNZVsikstwdDeDhDLt6zDYZADU7xwCjqXabolqa4C86rRQ+FMbH37kiSq
         Q1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=q/UyctZ3IuOzEhZ86GEcGxYn7ODPlY/62qqfKTvY61k=;
        b=aHOosW2cpUBtzsNaZMXlGUG72aerhw+GjT5uRJLhwZo6DvyUx8+QKbbkZVF8Td7PC1
         cddL3Agf8hW0T+LDKyBPE9EPMg0+4AfHHedolBVfbaq8rbpOPLab2mVOjpm6dCaqKOA4
         ajwylG53cKr9yBhrLGCI5HO9pIa4FkjvdZ6361rD15JA4Ik9J5I5uU6s3XCkav8Yb+kc
         7axn3/EfazwWlAQRzCT0sm2vxIin2q41MDxcq+N2noQcXWWO/M84c8eHbCcTLqqDUuOW
         vH5/butr+mTHyDKWK69Ihm9m96JZ8qf5/ot8K6FnvBp1Jb+J0DnT6lU5zGtFufnXdETh
         OBCA==
X-Gm-Message-State: AGRZ1gIH8VPCZpcKpVXCd6B9JGVQJQZNk39gb3uTWJRl5GL9Hq7y86FY
        7vF9yTd+emWqNPm/+UuMoQk=
X-Google-Smtp-Source: AJdET5d8G8PLTnWalv5b0tQEX3qYxZIbaOGoJv3OLEYsqn9P09vQ/ZbVGn5ndbFaB+Oc2mlLwbdX7A==
X-Received: by 2002:a63:7b06:: with SMTP id w6mr20322224pgc.288.1541428360243;
        Mon, 05 Nov 2018 06:32:40 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id d5-v6sm29007092pfo.131.2018.11.05.06.32.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 06:32:39 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     linux@armlinux.org.uk, jinb.park7@gmail.com, labbott@redhat.com,
        keescook@chromium.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] ARM: mm: dump: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date:   Mon,  5 Nov 2018 09:32:34 -0500
Message-Id: <20181105143234.6015-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/arm/mm/ptdump_debugfs.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/arm/mm/ptdump_debugfs.c b/arch/arm/mm/ptdump_debugfs.c
index be8d87be4b93..201cd467a739 100644
--- a/arch/arm/mm/ptdump_debugfs.c
+++ b/arch/arm/mm/ptdump_debugfs.c
@@ -12,17 +12,7 @@ static int ptdump_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int ptdump_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ptdump_show, inode->i_private);
-}
-
-static const struct file_operations ptdump_fops = {
-	.open		= ptdump_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(ptdump);
 
 int ptdump_debugfs_register(struct ptdump_info *info, const char *name)
 {
-- 
2.17.0

