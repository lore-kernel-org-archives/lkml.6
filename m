Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4D0C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 20:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A56BA2083F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 20:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3kVK8wk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A56BA2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbeJEDEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 23:04:55 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50823 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbeJEDEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 23:04:55 -0400
Received: by mail-wm1-f65.google.com with SMTP id s12-v6so10179651wmc.0;
        Thu, 04 Oct 2018 13:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=plKZcTA1l7bnOvI3XXQN4ShOETcX2TSCfStU+Qp5/5M=;
        b=N3kVK8wkuktYWwu905GstVMoeUQ3BMVztUMNqj5efxykT3t2xnlq4VjGJqUrreksXK
         Z2mn0snDluUvijRarVwXKBYFky0vj0WTXbVBDQHIVxBt6WFY53ETWhRR3MNDRkaP/pag
         Gneog8/a/2caRRTGGnJc/l8KjhL//Rf6aocEqtGTrQrAd3OfXkmHDNHRJb4hYvw3BEbj
         PlnHk/65iSMv4D2DkelzC782kTE0xGmtWm0hG+9GMy28cdo1s/9MldWhQHuBR+bGwDOb
         TUTKTGmnps8aOfsSLqkryQEedfiU6wJI1YhPM8BFppmvrT8gauLvnFFjOenQKXFwd6OI
         BHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=plKZcTA1l7bnOvI3XXQN4ShOETcX2TSCfStU+Qp5/5M=;
        b=YOhkKnFegry8uyTGOAYHkxnyJJpvz/B9BXHn5xb8GfBCbFJPjQULvoQKMLaCMD0xmQ
         ZSwKm+jTXbdEeYUhdhSWi4AWMRAdaZdVrEB2qrpUM5wWCyzoGCCrORhdlVRtGDCwkUD3
         C4fw29cRubqPs/9Ob/p5pPV9NJQ2EbRYNjhuVuxS9q0CsyrS20OEra9zn4Tz5dORIVta
         3qztIHXnRCyE147Rcri+uLTUow8FQXE+ObXTH4d8D8arexxB7AUhQ2/fes8B+ojTJts3
         PapMzflgcXAeifCbkqcvq9Wq8UdZKbPnR8tCMqNDznVda1QrAi+nM6VDuyBbOY5I2x06
         ufuw==
X-Gm-Message-State: ABuFfogEk1mfnaZbF4oB5zxi/XpISMPmpDL/jNFywC4izS5oEBoqciSH
        3Mgy0PNoteicBL8k25WAKxAomPUMnvTgBQ==
X-Google-Smtp-Source: ACcGV60lDVwsNrriC1Sfb+Dj9ZYB6aQbMPwRY2UqG/woQVkg/Ge+AJ1jYxuYumAl7sNmwpN002KMrQ==
X-Received: by 2002:a1c:5801:: with SMTP id m1-v6mr5635429wmb.118.1538683802923;
        Thu, 04 Oct 2018 13:10:02 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id z2-v6sm4220871wrh.8.2018.10.04.13.10.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 13:10:01 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v2] drbd: Avoid Clang warning about pointless switch statment
Date:   Thu,  4 Oct 2018 13:09:13 -0700
Message-Id: <20181004200912.32348-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002171447.10765-1-natechancellor@gmail.com>
References: <20181002171447.10765-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several warnings from Clang about no case statement matching
the constant 0:

In file included from drivers/block/drbd/drbd_receiver.c:48:
In file included from drivers/block/drbd/drbd_int.h:48:
In file included from ./include/linux/drbd_genl_api.h:54:
In file included from ./include/linux/genl_magic_struct.h:236:
./include/linux/drbd_genl.h:321:1: warning: no case matching constant
switch condition '0'
GENL_struct(DRBD_NLA_HELPER, 24, drbd_helper_info,
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/genl_magic_struct.h:220:10: note: expanded from macro
'GENL_struct'
        switch (0) {
                ^

Silence this warning by adding a 'case 0:' statement. Additionally,
adjust the alignment of the statements in the ct_assert_unique macro to
avoid a checkpatch warning.

This solution was originally sent by Arnd Bergmann with a default case
statement: https://lore.kernel.org/patchwork/patch/756723/

Link: https://github.com/ClangBuiltLinux/linux/issues/43
Suggested-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

Since this is not the same as Arnd's patch, I took authorship for it
while leaving a link to the original patch in the commit message. If
this is not how it should have been done, please let me know.

 include/linux/genl_magic_struct.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/genl_magic_struct.h b/include/linux/genl_magic_struct.h
index 5972e4969197..eeae59d3ceb7 100644
--- a/include/linux/genl_magic_struct.h
+++ b/include/linux/genl_magic_struct.h
@@ -191,6 +191,7 @@ static inline void ct_assert_unique_operations(void)
 {
 	switch (0) {
 #include GENL_MAGIC_INCLUDE_FILE
+	case 0:
 		;
 	}
 }
@@ -209,6 +210,7 @@ static inline void ct_assert_unique_top_level_attributes(void)
 {
 	switch (0) {
 #include GENL_MAGIC_INCLUDE_FILE
+	case 0:
 		;
 	}
 }
@@ -218,7 +220,8 @@ static inline void ct_assert_unique_top_level_attributes(void)
 static inline void ct_assert_unique_ ## s_name ## _attributes(void)	\
 {									\
 	switch (0) {							\
-		s_fields						\
+	s_fields							\
+	case 0:								\
 			;						\
 	}								\
 }
-- 
2.19.0

