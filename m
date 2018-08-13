Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93834C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 23:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C9BB21755
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 23:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vTGzqGEm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C9BB21755
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732329AbeHNCfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 22:35:37 -0400
Received: from mail-oi0-f73.google.com ([209.85.218.73]:50975 "EHLO
        mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730213AbeHNCfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 22:35:36 -0400
Received: by mail-oi0-f73.google.com with SMTP id p11-v6so18419447oih.17
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 16:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=iMH3pTFkPsV80DDnKoroL+dlXFtNLwIkO9zZEQ+uWfQ=;
        b=vTGzqGEmr+R4euds+pogDZKdH+Icc9eIyUcy6BrGeqAl0Suq7pHcS8Y/ZjuiPlvair
         GV1hyBqoG+/1FV+0IbG/Jy0RW/7V6EJPnLSLeCzyReryxD4iSajBXUt4uCpbqzFMZk8D
         Apk5/CxMk3aTAEK7THVQFQ/YtAX8TNAEqvU1+gHME3Du8HVKzOJVxGF1P0YiJFJdcQ9Q
         Ajpjs7BDmX1/FV29hWBS7QPa/CuwvlPVHstb19Nl7K2LaZ31qouXIB9wLurK8VJ+uLOs
         B7qJ3j5MotRo9omBeMWXYnaZp/88PuZSRByVfGMYi87Zbr4Ky/cdnfq3OAlGfwkFwMEd
         GBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=iMH3pTFkPsV80DDnKoroL+dlXFtNLwIkO9zZEQ+uWfQ=;
        b=SyAZgxDrJtOAQv7FgsO2w4tn/tzavyXWa6o3L/LmzAw46jTEZc85icjDfJs1W7SLSb
         Suyy+6jM0ghW88ihyt+bbpiz3NWqzGTTZySRpYqDh6NeGQQ0ApXDvX2DeXQElJkPdxBl
         ycVZzrRWuuKNQMTD23O+dg0XAzAegGTWYT/MwmL3dfrcIbiLhd6gWcsL1fU7Z3Yt0h8a
         4rf9XE8h9ULT/o70be2QfiMunHb2uhXWiXkAQWtDzeQMiDEFjNqVngGU2j0eVSEXQSKq
         9ij2kTeu4juKFAD6d3ZtULCiPeOEirGWG+4pjqr9FkSj9VeKuMkSIwSYOH2fBy8SnbbM
         EcEg==
X-Gm-Message-State: AOUpUlH54uRzf9OR4DGsErFiwWyD4qMAsNdmv27AbvuTEN/ATkZP015u
        lIrq2gB9mEu0qqTsJE7c262FZhDC
X-Google-Smtp-Source: AA+uWPwWjPCZqEUnWCBTEqvLgjtfEkiDoLIVnF10mHo84t1TsibrVnbljIXw66x2882F8TfoOcbnS03N
X-Received: by 2002:aca:6146:: with SMTP id v67-v6mr13339932oib.108.1534204265760;
 Mon, 13 Aug 2018 16:51:05 -0700 (PDT)
Date:   Mon, 13 Aug 2018 16:51:01 -0700
Message-Id: <20180813235101.195680-1-rkir@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH 9/9] platform: goldfish: pipe: Add a blank line to separate
 struct members
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

To improve readability and to be consistent with other
struct members.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/goldfish_pipe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index 3f8e440d62ae..d0621da2c334 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -157,6 +157,7 @@ struct goldfish_pipe {
 
 	/* A wake queue for sleeping until host signals an event */
 	wait_queue_head_t wake_queue;
+
 	/* Pointer to the parent goldfish_pipe_dev instance */
 	struct goldfish_pipe_dev *dev;
 };
-- 
2.18.0.865.gffc8e1a3cd6-goog

