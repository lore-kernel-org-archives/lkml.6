Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD3FC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3D1A2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DEGQx61v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3D1A2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbeIFTFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 15:05:36 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:50384 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729401AbeIFTFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 15:05:36 -0400
Received: by mail-vk0-f73.google.com with SMTP id n135-v6so3772868vke.17
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 07:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=HGp0kMaMTlvqs08pLn4mkIkxA0/YTHUf7uHJuW9/Rc4=;
        b=DEGQx61vVlvXh+p4JQPgROXPHEUUq0LMPlBYintVPzZvTmSzy1xW7qrgMLAF2ZqG1Q
         Pxft8Ihn5pfeAgU02fymYRzRByKTQ3KnMvhUZsruLJNWT/MevXbp1V17h7zQHqKKc9se
         H6YjcJDYcSNmnQLsFKap7OcU8zAY6uYwZ/drLRAOtDdoUFjMR5YH0XVHG3Xm59MNBCKV
         NBVaREj3JotndA5co4WLeQAo3D/Y0lTSNwrmw4/h88J7j8dhfXwivVtV1VkexQcfh1BG
         xLcYc9/FFVSBsiPR+Ike7n4Ctf0xnMUb7Ob+E/OCGbbR7naqiKICTaAqOf9uoUqiBP0r
         eUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=HGp0kMaMTlvqs08pLn4mkIkxA0/YTHUf7uHJuW9/Rc4=;
        b=MolaG0Yf5ESMkqyxhe5jwUFaOKg0CapAzY5gLfQ2y1UnbaaAMCdZN5hLXEKGmf6Vms
         1t0rNhQ9tmMv6SghIbbDLsD/siVdIQiWi40yV3a/n6s4sEWrpMEyxADVgu0MbudEVSLz
         1dIVCJTPo6P/T/2BPW7th6LymNShyNAAWwVPo2k76GgNDDAHP83mTFBYw/c43it5hiNr
         jb29SaOfti8ZDmA3LbzwFYWNsfuV9pVHJ8EwjHmZJjXMspmPVlMRvrXkxK/J32APuKQa
         GK7O6ASErF/zXOriQ42WogdWem/IVkzhwfRs04xqVpcGDnAv/9tBa6XjsjocEgczEMu3
         5Qkw==
X-Gm-Message-State: APzg51DJPmvPVYDBPnLFvZyy8s1XTflUopLQhGD5lgjVvK6yJKo6oHp1
        GhifKB1lgjEfahs/WVbac9vym7Tc0Q==
X-Google-Smtp-Source: ANB0Vdau57VrzvPf++Ee/9Fnqhs96uPWj13PUp4VLtiX7ev0BZ6uu3qlyaKPCXm/c8ToCPwv70vqy0CWsA==
X-Received: by 2002:a1f:fe07:: with SMTP id l7-v6mr564096vki.59.1536244187306;
 Thu, 06 Sep 2018 07:29:47 -0700 (PDT)
Date:   Thu,  6 Sep 2018 16:29:35 +0200
Message-Id: <20180906142935.230597-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1-goog
Subject: [PATCH] Yama: use READ_ONCE() when reading ptrace_scope
From:   Jann Horn <jannh@google.com>
To:     Kees Cook <keescook@chromium.org>, jannh@google.com
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ptrace_scope can be modified concurrently. To ensure that the compiler only
reads ptrace_scope once, use READ_ONCE() here. (In practice, at least the
version of gcc on my machine only generates a single read anyway, and it
seems unlikely that a compiler would do something different.)

This also serves as documentation for the reader.

Signed-off-by: Jann Horn <jannh@google.com>
---
 security/yama/yama_lsm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index ffda91a4a1aa..3b18e4455f53 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -362,7 +362,7 @@ static int yama_ptrace_access_check(struct task_struct *child,
 
 	/* require ptrace target be a child of ptracer on attach */
 	if (mode & PTRACE_MODE_ATTACH) {
-		switch (ptrace_scope) {
+		switch (READ_ONCE(ptrace_scope)) {
 		case YAMA_SCOPE_DISABLED:
 			/* No additional restrictions. */
 			break;
@@ -404,7 +404,7 @@ int yama_ptrace_traceme(struct task_struct *parent)
 	int rc = 0;
 
 	/* Only disallow PTRACE_TRACEME on more aggressive settings. */
-	switch (ptrace_scope) {
+	switch (READ_ONCE(ptrace_scope)) {
 	case YAMA_SCOPE_CAPABILITY:
 		if (!has_ns_capability(parent, current_user_ns(), CAP_SYS_PTRACE))
 			rc = -EPERM;
-- 
2.19.0.rc1.350.ge57e33dbd1-goog

