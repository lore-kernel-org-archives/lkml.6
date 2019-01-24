Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB08C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7203F217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548360762;
	bh=CdkDazuggohC/WHM+ckmIrBfnR/L7Ompt+Dc5JshkHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kuZIwPrOGKnfVhbLSgFDqtX2AJnFfiyGfY3liEQJNirMCCT7k5SUhvWKTiF6zoFzX
	 QIqTO1bdWp9vgo9q1SB1AJtUd1oMz0ZhIq/hv/u7wJZuVQSRZcJsb0dUF6b6Y5gEvc
	 BYrD+IYD9EeSBx3A3e2CcjOJa99/rM/OLiN5AjZk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbfAXUMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:12:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:51612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730462AbfAXTZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:25:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2A7D218EA;
        Thu, 24 Jan 2019 19:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548357950;
        bh=CdkDazuggohC/WHM+ckmIrBfnR/L7Ompt+Dc5JshkHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wVd5vv71ED0iFkgm2eTFgr/kNaPRiv0n+5DuawMXZfMsuoqRmeQwXj8dpv0abk3IN
         Aq70z7G26e+jkuPJCgYMqiEgs6tvi7Knl77uRGzz8uIZtno9PnZ7yciw1uz729Bm+P
         +OIfPVpd1X8/5/093mr06++ZXVrLdUoLiRCONlcU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 4.4 039/104] proc: Remove empty line in /proc/self/status
Date:   Thu, 24 Jan 2019 20:19:28 +0100
Message-Id: <20190124190159.577092464@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190154.968308875@linuxfoundation.org>
References: <20190124190154.968308875@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gwendal Grignou <gwendal@chromium.org>

Prevent an empty line in /proc/self/status, allow iotop to work.

iotop does not like empty lines, fails with:
  File "/usr/local/lib64/python2.7/site-packages/iotop/data.py", line
196, in parse_proc_pid_status
    key, value = line.split(':\t', 1)
ValueError: need more than 1 value to unpack

[reading /proc/self/status]

Fixes: 84964fa3e5a0 ("proc: Provide details on speculation flaw mitigations")
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 v2: Format commit message properly with proper subject and fixes
     keyword.

 fs/proc/array.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -333,7 +333,7 @@ static inline void task_seccomp(struct s
 #ifdef CONFIG_SECCOMP
 	seq_printf(m, "Seccomp:\t%d\n", p->seccomp.mode);
 #endif
-	seq_printf(m, "\nSpeculation_Store_Bypass:\t");
+	seq_printf(m, "Speculation_Store_Bypass:\t");
 	switch (arch_prctl_spec_ctrl_get(p, PR_SPEC_STORE_BYPASS)) {
 	case -EINVAL:
 		seq_printf(m, "unknown");


