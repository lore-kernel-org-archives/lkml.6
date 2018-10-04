Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12242C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A8D2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:48:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7A8D2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schupikov.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbeJDUlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:41:39 -0400
Received: from gravityforest ([185.233.107.85]:47902 "EHLO
        gravity.schupikov.de" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbeJDUlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:41:39 -0400
X-Greylist: delayed 336 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Oct 2018 16:41:38 EDT
Received: from zlid.rus.uni-stuttgart.de (s-8d3a2fc9.on.site.uni-stuttgart.de [141.58.47.201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by gravity.schupikov.de (Postfix) with ESMTPSA id B66E25D096;
        Thu,  4 Oct 2018 15:42:39 +0200 (CEST)
From:   Michael Schupikov <michael@schupikov.de>
To:     "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc:     Michael Schupikov <michael@schupikov.de>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] kernel/sysctl.c: remove duplicated include
Date:   Thu,  4 Oct 2018 15:42:23 +0200
Message-Id: <20181004134223.17735-1-michael@schupikov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove one include of <linux/pipe_fs_i.h>.
No functional changes.

Signed-off-by: Michael Schupikov <michael@schupikov.de>
---
 kernel/sysctl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index cc02050fd0c4..523cb36b72eb 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -66,7 +66,6 @@
 #include <linux/kexec.h>
 #include <linux/bpf.h>
 #include <linux/mount.h>
-#include <linux/pipe_fs_i.h>
 
 #include <linux/uaccess.h>
 #include <asm/processor.h>
-- 
2.19.0

