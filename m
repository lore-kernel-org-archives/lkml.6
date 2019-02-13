Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFE7C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D8220811
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083982;
	bh=atG40WD2iWjqtAExOF4SHjeF5GswulswxH3jol1TzWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WELiNjwISnFwIx2bl1HW9fAgF9kf9FjWVWvzsB56UBh/kvha0uzJvjOFF7QPaLR3w
	 NPDQSsPyAUghHISJyCYVf3/Hl67Ighqfh0JpV4CTFXaGaqt1KR2O0qt6rsnq5FA56p
	 UzE/u8lzfc4TS298Lx0u1uH2idoXdfSYPcbLw3Pg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405782AbfBMSnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:43:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:41516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405750AbfBMSm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:42:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57343222D5;
        Wed, 13 Feb 2019 18:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083377;
        bh=atG40WD2iWjqtAExOF4SHjeF5GswulswxH3jol1TzWU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cngyJn6i34PAIUy0iyMg5FI13Q/mYGp/ry+fVurxIeW7eoGWPoGigdQvMN90k3NYE
         waThvDazbb/BL6Q2NqHRIgbdwO5I5FdKoV9JLQ35mSpaABavuMQ+LiSqbMBHeDxLDu
         SGaxAG03RfVSIULrsQ0K28oa3Krc//V2v5BM9D30=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andreas Ziegler <andreas.ziegler@fau.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.19 18/44] tracing: uprobes: Fix typo in pr_fmt string
Date:   Wed, 13 Feb 2019 19:38:19 +0100
Message-Id: <20190213183653.252533829@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183651.648060257@linuxfoundation.org>
References: <20190213183651.648060257@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andreas Ziegler <andreas.ziegler@fau.de>

commit ea6eb5e7d15e1838de335609994b4546e2abcaaf upstream.

The subsystem-specific message prefix for uprobes was also
"trace_kprobe: " instead of "trace_uprobe: " as described in
the original commit message.

Link: http://lkml.kernel.org/r/20190117133023.19292-1-andreas.ziegler@fau.de

Cc: Ingo Molnar <mingo@redhat.com>
Cc: stable@vger.kernel.org
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Fixes: 7257634135c24 ("tracing/probe: Show subsystem name in messages")
Signed-off-by: Andreas Ziegler <andreas.ziegler@fau.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace_uprobe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -5,7 +5,7 @@
  * Copyright (C) IBM Corporation, 2010-2012
  * Author:	Srikar Dronamraju <srikar@linux.vnet.ibm.com>
  */
-#define pr_fmt(fmt)	"trace_kprobe: " fmt
+#define pr_fmt(fmt)	"trace_uprobe: " fmt
 
 #include <linux/module.h>
 #include <linux/uaccess.h>


