Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A36C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C06CB208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E7BZ05Rs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C06CB208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbeH0WLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:11:05 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:51043 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbeH0WLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:11:05 -0400
Received: by mail-pf1-f202.google.com with SMTP id n17-v6so12174904pff.17
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 11:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=teF4PxWjYZ+kqcLwxVqn2dXcutnjaGEx1uGQsbBE+0o=;
        b=E7BZ05Rsth9nqHKKN72b+12vDEnrZKU4cVwLeVSeFDHlzZE/9RlgaZAsmqJFirOjI8
         6Y7kg58vx1NYnEJAo3XxEgPO7iZ8Spd/qFoQy9vIdjxEuVLuG3O2prp9416k776E6U9T
         bvb6Dr8fqkYvV+EsrlMfw14rDX/UObjhQ4Hf6aILkckek2U7q43qirXcXQjxr7a/5SzP
         J2AggYHFAgyS/8GBawTCLthgJbXUmwzI9yor1qlyERLJdH/+7rFL6k4ic1M/ciPOzKRA
         1cnxUg7qAYA5VfCssstmjW8vMsCsC9AoqSXIoIUrVS1XeQTqnf/BTNl9g8Eag1JtTX+C
         avSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=teF4PxWjYZ+kqcLwxVqn2dXcutnjaGEx1uGQsbBE+0o=;
        b=TAhFFAMZbQLctWIf5lRmDEV4FmCpi5MQ+ZjX22o40UFftm1G3SRKyZNrSX38LgXNkR
         cNmXwL67VPTMk7VSJ5GnS79NOUIoUdLJVd9qNWaUkuPLVLCnNBOk52FhncFnRovQKxTe
         TsTU0VCdeVJUpWzzznKkqSPQbfnDslJyLEi78DNuM3R0FRbsUB6y/0Q8gxunn0BxSDwO
         4qwkd4TeomuFScID8DYsSmLpQQQ4HT0Uy7jhLQKlbDqb9dG6xnhkGAsgEmDEZ8ZDGBQt
         12CuD65v3aze6mNIURBV+z15efIY8F7Px+LtwjqiEV8b7aDXHDFZOR4ntt9/rOG3bV/Q
         yAvQ==
X-Gm-Message-State: APzg51BcXcxU4McDSAGaTb6Yd1BxttmfoHhDLlCk4rgMbr/klsIYrZdd
        T6NMTNkwEuumPilqG+IJ8G3ZrMCm
X-Google-Smtp-Source: ANB0VdZppW6AveES64JScUGVKVzb2neccc3kUUQUeIUI560bOJS/5FGSLGw0BfsgNUwnwhc1sYEbX+tT
X-Received: by 2002:a63:715b:: with SMTP id b27-v6mr3351961pgn.48.1535394203739;
 Mon, 27 Aug 2018 11:23:23 -0700 (PDT)
Date:   Mon, 27 Aug 2018 11:22:56 -0700
Message-Id: <20180827182315.126345-1-rkir@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
Subject: [PATCH 01/20] platform: goldfish: pipe: Fix comments to fit 80 columns
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
index 2da567540c2d..6094ca414d9a 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -85,7 +85,10 @@ enum PipePollFlags {
 	PIPE_POLL_HUP	= 1 << 2
 };
 
-/* Possible status values used to signal errors - see goldfish_pipe_error_convert */
+/*
+ * Possible status values used to signal errors
+ * see: goldfish_pipe_error_convert
+ */
 enum PipeErrors {
 	PIPE_ERROR_INVAL  = -1,
 	PIPE_ERROR_AGAIN  = -2,
@@ -150,9 +153,9 @@ struct goldfish_pipe_command;
 
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
2.19.0.rc0.228.g281dcd1b4d0-goog

