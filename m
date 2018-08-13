Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3ACC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 23:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C34D821755
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 23:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o8iaZewz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C34D821755
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732458AbeHNCXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 22:23:39 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:52987 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729947AbeHNCXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 22:23:38 -0400
Received: by mail-ua1-f73.google.com with SMTP id t22-v6so8579039uap.19
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 16:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=9C0LkuWdihc/c5C978LeZrQYCbjtYrnHiojBHWV+qHY=;
        b=o8iaZewz5dgChA6yk+HIhsogouqYxR6LSHlQD3841Yw9IA+4eFjhb2TmMZpOYsGIdw
         E9OO2YGq/uzn3Bwe7dAJczCosHMLiEBaFN8s4KDykgYbGyVAM24xOIBEx4dO3XrwP/HK
         3dRunnlCoIsCIkdGJcxN9AjgBGFV6mxpcqxnRhDm2iRtL6zlkm6PCa+hNb0a5bhd+hdo
         5I7gjdwgIlWfNfwrG8yK3i4pfGPoiCBdVZsLEolbV6xMFwf6pviwqNkhE5MhoScRney/
         8dLGsrtTYc/n1B/eipqeozSllP3idbrrJpfEjVQ0pJNmVGlEEAtJaKVBIpNQXp69ec+D
         I6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=9C0LkuWdihc/c5C978LeZrQYCbjtYrnHiojBHWV+qHY=;
        b=Sr4csYw5i+L96rFnE2WHcp6A7yEst7Hzg9narinjFJZ6Svb2RLlTWKgTVk0GUZlg+g
         CN2qta+ieWr1lDHq5bj2ojoS9EN/ybzSgUP91TbttbjmtcLwj3+9EzxNSM9UD8BcFAWI
         nT+0KaijfdDzbJ6OO/tBAp+iKXiRNHVblm43y1jdiZ57x7IhhG8YN/dmUnaC7UlLvitv
         VftLgTSx6b97c2XETrD+LjJ32PAu5RaFyAki7ZaJYa/irzML5ko8ob9jTGFp0JnNorty
         xxV+0At/ACV7JmTozJVLouCaWlX/yRS4YESJFgSwcY0hZtVuLlHdj+YYcON2pJQPRAjk
         kyag==
X-Gm-Message-State: AOUpUlGLRhpsz0cvqmIFiiKB8dQBRISLERmTz7FTZPdf2mVv95dKzk/a
        3qVECCV3046FWK4ZJX3nPuHAqUsL
X-Google-Smtp-Source: AA+uWPwDc8ebmVOA1LDO9G2NWlzt18Zm7vEwnx86gdNTdTrItDtRUJY0D1JfAqDAcF/OPxtR4VGkIn6Z
X-Received: by 2002:ab0:4b81:: with SMTP id v1-v6mr8826944uaf.114.1534203549955;
 Mon, 13 Aug 2018 16:39:09 -0700 (PDT)
Date:   Mon, 13 Aug 2018 16:38:32 -0700
Message-Id: <20180813233839.190855-1-rkir@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH 1/9] platform: goldfish: pipe: Fix comments to fit 80 columns
From:   rkir@google.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, tkjos@google.com,
        Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

Some comment lines are longer than 80 symbols.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/goldfish_pipe.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index 3e32a4c14d5f..567005fe11f8 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -84,7 +84,10 @@ enum PipePollFlags {
 	PIPE_POLL_HUP	= 1 << 2
 };
 
-/* Possible status values used to signal errors - see goldfish_pipe_error_convert */
+/*
+ * Possible status values used to signal errors - see
+ * goldfish_pipe_error_convert
+ */
 enum PipeErrors {
 	PIPE_ERROR_INVAL  = -1,
 	PIPE_ERROR_AGAIN  = -2,
@@ -149,9 +152,9 @@ struct goldfish_pipe_command;
 
 /* A per-pipe command structure, shared with the host */
 struct goldfish_pipe_command {
-	s32 cmd;		/* PipeCmdCode, guest -> host */
-	s32 id;			/* pipe id, guest -> host */
-	s32 status;		/* command execution status, host -> guest */
+	s32 cmd;	/* PipeCmdCode, guest -> host */
+	s32 id;		/* pipe id, guest -> host */
+	s32 status;	/* command execution status, host -> guest */
 	s32 reserved;	/* to pad to 64-bit boundary */
 	union {
 		/* Parameters for PIPE_CMD_{READ,WRITE} */
-- 
2.18.0.865.gffc8e1a3cd6-goog

