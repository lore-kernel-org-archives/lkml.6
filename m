Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4D0C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 04:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4E0820844
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 04:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSD8KVRo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E0820844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbeIHJoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 05:44:02 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38149 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbeIHJoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 05:44:02 -0400
Received: by mail-lf1-f65.google.com with SMTP id i7-v6so13611123lfh.5;
        Fri, 07 Sep 2018 21:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=o9/5Or/DxMgjrvzwORtc3LOCZ3TdOZZPpsZh2INMQRM=;
        b=HSD8KVRo6LJr9ZcCEFrpk85/C4t7WllVsQqC6M1KXukLbIVHDJsWzpN7DjMQJF3Rc4
         DmGrlTDVx1MC1J/Kq19MufiDViXCgBJOxibmzJ/L1lCM4DEW+uFOh9lcnAEWiPnOLq8C
         uvgAOxj3htmhMu5aORvGRJ62N/Q/zisStjFYfbASgdQB1qjepfHk0GSmwDYn88wq/I7N
         5MEjDBnsDUimJEzw+Y4cppSvIlpDBWIKsbj83PPSaB5O4KoYIdPfq3UaVF3vOOj9pRPD
         Cbly39oGFe5GxGq2Q0WJbKs3DAADOLFvL3IfaXZLNQKpEQ+ZiR7NjjjbezPxXh1WTYkz
         nI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=o9/5Or/DxMgjrvzwORtc3LOCZ3TdOZZPpsZh2INMQRM=;
        b=BUgRMYHQOtRLA2FL3sN3vjVoUnFHFinBaItlP0cm+M0XIspiMTr0XOGU1uWPgp/NbM
         Qe8docd4VCwjxn3CfXSdiqWTQ2AOZw86fsV36sstJDKLvV//45FfYPRJ7332+itc+5Ck
         i334mIm+mGf2RbGqoOyROE6aPRLDP4i6X44/znVoK/Kw2bmn+jzIBHYdOOY6TaLBCVgK
         BIQf+G33LyuJuWOWqwv2fHpaWf3pyFoEBEWXzcUNhsjSVpdB075652ugbnB/gbE5mxiL
         2VvW0GXjUFZ/pEC4EDpKoCbxhz001zV/TDfdKeeb4STgeWtiT1IOFDvca4WBu+vBOgCe
         PHdw==
X-Gm-Message-State: APzg51Cdam9w28W6uABZh9293pZWruSFyPm/bPBhlUAca21irTVrFw7t
        YRWtn+d14uClwngQ89D3xuSViNcprAw=
X-Google-Smtp-Source: ANB0VdZG9xklPeh3UQKQnY7BCOkkl3GP3vSNW5It50HIxLVa0xEL9fxMwle5XBCXgHCxAzgt8AXMxw==
X-Received: by 2002:a19:5a17:: with SMTP id o23-v6mr6637172lfb.51.1536382778487;
        Fri, 07 Sep 2018 21:59:38 -0700 (PDT)
Received: from Mort.jumbo.freeair (91-159-62-202.elisa-laajakaista.fi. [91.159.62.202])
        by smtp.gmail.com with ESMTPSA id p17-v6sm1587158ljg.64.2018.09.07.21.59.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 21:59:37 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] asm-generic: bug: unify hints for BUG_ON()
Date:   Sat,  8 Sep 2018 07:59:28 +0300
Message-Id: <20180908045928.26201-1-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If BUG_ON() is used instead of BUG(), it means that probably the
preferred outcome is to not BUG(), therefore the condition tested should
be unlikely().

However, when CONFIG_PROFILE_ANNOTATED_BRANCHES is enabled, the hint is
disabled, to avoid generating false-positive warnings caused by
-Wmaybe-uninitialized.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 include/asm-generic/bug.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 20561a60db9c..b91273c36baf 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -58,8 +58,12 @@ struct bug_entry {
 #endif
 
 #ifndef HAVE_ARCH_BUG_ON
+#ifdef CONFIG_PROFILE_ANNOTATED_BRANCHES
+#define BUG_ON(condition) do { if (condition) BUG(); } while (0)
+#else
 #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
 #endif
+#endif
 
 #ifdef __WARN_FLAGS
 #define __WARN_TAINT(taint)		__WARN_FLAGS(BUGFLAG_TAINT(taint))
@@ -183,7 +187,11 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 #endif
 
 #ifndef HAVE_ARCH_BUG_ON
+#ifdef CONFIG_PROFILE_ANNOTATED_BRANCHES
 #define BUG_ON(condition) do { if (condition) BUG(); } while (0)
+#else
+#define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
+#endif
 #endif
 
 #ifndef HAVE_ARCH_WARN_ON
-- 
2.17.1

