Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE310C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 06:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B1620C09
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 06:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iN+smaYA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="esgcA5Y0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24B1620C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753135AbeGBGH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 02:07:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39452 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752406AbeGBGH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 02:07:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0A797607DC; Mon,  2 Jul 2018 06:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530511676;
        bh=DDeXTLjktyfcKu8AzzShrw2Di8+fZjgS1HxxrGDt2OE=;
        h=From:To:Cc:Subject:Date:From;
        b=iN+smaYAxDdRGrrem78NB1psGdE9WZfTMqGxMt6AFFl32oLYlgBuizujoNtkSZIvv
         mRm6jqesgIdMjfQRVwoGVtN6uQyirwEXqgOrvRrs01rd2YdnuWYD7Ovh3kHhaOZ874
         jK2QSBHTWj6vWMnsDKhvuchwYmDnDuefg0nUToJE=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B038F606FC;
        Mon,  2 Jul 2018 06:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530511675;
        bh=DDeXTLjktyfcKu8AzzShrw2Di8+fZjgS1HxxrGDt2OE=;
        h=From:To:Cc:Subject:Date:From;
        b=esgcA5Y0Md2VgCSXR90ZrY5QTrK+puOYBynW5l5M9eGrizcJGxhEDrUaf5Yf1ZFus
         08io4dP1Hl/nKdj6Z6nERcxoK5NWMNwAsQPSNpdiQ9WiCAOCmiLJkXs4h+LxshMC5M
         LgzyYV4LkujwA0qC16uT5V0btjtgNwP+z110f7eU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B038F606FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org,
        Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH] f2fs: show the fsync_mode=nobarrier mount option
Date:   Mon,  2 Jul 2018 11:37:40 +0530
Message-Id: <1530511660-31323-1-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch shows the fsync_mode=nobarrier mount option in
f2fs_show_options().

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 3995e92..12e3d2d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1343,6 +1343,8 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_printf(seq, ",fsync_mode=%s", "posix");
 	else if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT)
 		seq_printf(seq, ",fsync_mode=%s", "strict");
+	else if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_NOBARRIER)
+		seq_printf(seq, ",fsync_mode=%s", "nobarrier");
 	return 0;
 }
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

