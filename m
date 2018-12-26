Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79FCC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C30C2171F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCx2F6qe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbeLZN4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 08:56:35 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43905 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbeLZN4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 08:56:35 -0500
Received: by mail-pl1-f196.google.com with SMTP id gn14so7574393plb.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 05:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Qhjg8LblQ0WGbiz7CbwsvK0KdMnAAmu57szDmISm94I=;
        b=bCx2F6qe1vdyqKXcQ44k0wdGD+PDCcombv9NkQ61kvMnmzijR03FyDX8WqXR6Mo5wC
         sqBBI30o/byeoNudrk+znOWOXyG95jIynL2IyumGxr9hTmgx/wSNOb0SKZW8RN8KL9IN
         BAmOV76XQkYN8IdGYHVYsucUx3Q9t/IaQ+bd6xOgox9He4dt2uWpvPPHUFQU56llp9iQ
         rS1b1DRvPg6LZXK80AeA/8IIJzmIO8Ub19LYFgwmNsRFycQr7SzBwA+ey6QFGoPC45o4
         HfiZ9lllmHCVIbS7u+iZhXWUEetE9nTWKJnCb91gEuMCsG8JojtsC4udJnFplAy4C3g6
         uMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Qhjg8LblQ0WGbiz7CbwsvK0KdMnAAmu57szDmISm94I=;
        b=j5J0+aRPiGsvLTqLzDz3YvH9Uxi1wd204z56j80eZc/PBu7lmgBEczVhMFWksN15Mv
         GF7xtrlUQzcxh5omC2UuM31f8Z/wlmjDKNOM3gGDnhOMt989O/Y/z8tbN9M8NnHXTCCm
         wum9B9XoYzSwovMDrnRiTfDcAqyd+pSv79FtTVhlqD6Fw2pHoQ0A1KxwjthK+ljWUZ3u
         LOSsyB9xp98eSPUM5TrL8MSqZoejW2w/RCmP1lhb/FJF9yvBWGj96f31kzH285ALsibz
         ax0M8U3i7b8himoeOdvqGtcmktF4M+P4CLlT0dbMNoY29f9Wq1GtSr75BwF6r/nBONbL
         azOA==
X-Gm-Message-State: AJcUukeFFbuuOl/ZPZFCoQrOmKDlkfCiNC04bocXu+qEPqmFdY3HwAIg
        DIYQwy67tUklp+cL98J6soI=
X-Google-Smtp-Source: ALg8bN4GAg3K44VwIh21ORxyuSm34kZy0Mm/K6oTp2lhnX5wBw9Yq46zB7Ko0ESBBzSMfcDSr+ohnw==
X-Received: by 2002:a17:902:70c6:: with SMTP id l6mr20360552plt.30.1545832594695;
        Wed, 26 Dec 2018 05:56:34 -0800 (PST)
Received: from localhost.localdomain ([2402:f000:1:4414:a8df:74f3:1213:8d3d])
        by smtp.gmail.com with ESMTPSA id u137sm63256258pfc.140.2018.12.26.05.56.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Dec 2018 05:56:33 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     benh@kernel.crashing.org, dhowells@redhat.com, joel@jms.id.au,
        eajames@linux.vnet.ibm.com, andrew@aj.id.au
Cc:     linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] fsi:fsi-sbefifo: Fix possible concurrency use-after-free bugs in sbefifo_user_release
Date:   Wed, 26 Dec 2018 21:56:18 +0800
Message-Id: <20181226135618.12784-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In drivers/fsi/fsi-sbefifo.c, the functions sbefifo_user_release(), 
sbefifo_user_read() and sbefifo_user_write() may be concurrently executed.

sbefifo_user_release()
  sbefifo_release_command()
    vfree(user->pending_cmd);

sbefifo_user_read()
  mutex_lock();
  rc = __sbefifo_submit(sbefifo, user->pending_cmd, ...);

sbefifo_user_write()
  mutex_lock();
  user->pending_cmd = user->cmd_page;
  user->pending_cmd = vmalloc(len);

Thus, possible concurrency use-after-free bugs may occur in
sbefifo_user_release().

To fix these bugs, the calls to mutex_lock() and mutex_unlock() are
added in sbefifo_user_release().


Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/fsi/fsi-sbefifo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
index d92f5b87c251..e278a9014b8f 100644
--- a/drivers/fsi/fsi-sbefifo.c
+++ b/drivers/fsi/fsi-sbefifo.c
@@ -900,8 +900,10 @@ static int sbefifo_user_release(struct inode *inode, struct file *file)
 	if (!user)
 		return -EINVAL;
 
+	mutex_lock(&user->file_lock);
 	sbefifo_release_command(user);
 	free_page((unsigned long)user->cmd_page);
+	mutex_unlock(&user->file_lock);
 	kfree(user);
 
 	return 0;
-- 
2.17.0

