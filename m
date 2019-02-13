Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2ACC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A213E222D2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083635;
	bh=oGMR0OESuuGYm8RFtR+nWC4KMdR6w3dCkYIs3YXkZSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lhK0TEqn4ZuaC/KZixj6xULxjdNeUc9syLmzVHhwNjbx0cHe3gfA0iHWNjhByVMMD
	 sgZgAwD5WXv28nD1sljpqA4urdafMPSnTEjrlySwwk024mu4MTdoWWLjdZ4h7FlstO
	 aR9JlRfDCHhs4G67QmHx5abUITJI/3kjX9aLRu80=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436507AbfBMSrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:47:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:45746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436495AbfBMSrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:47:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94D6D20835;
        Wed, 13 Feb 2019 18:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083632;
        bh=oGMR0OESuuGYm8RFtR+nWC4KMdR6w3dCkYIs3YXkZSE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lKQxLSiecOsLt/ei/Nx6I6ot3hckaVyo4zssDNtmO0OPF7+RFXgm1lBN0JG1qj1zT
         RikqTmL1A6DCdxhTAdHY9njVcrzh1dJ/URV6r/Hyk8ubSTL/wfGrwoUVQPLrRY+rjK
         nxazt3CP5RcB2ObNfs5gCM8ARUDcrl63o8zpBNNg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andreas Ziegler <andreas.ziegler@fau.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.20 22/50] tracing: uprobes: Fix typo in pr_fmt string
Date:   Wed, 13 Feb 2019 19:38:27 +0100
Message-Id: <20190213183657.537139995@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183655.747168774@linuxfoundation.org>
References: <20190213183655.747168774@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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


