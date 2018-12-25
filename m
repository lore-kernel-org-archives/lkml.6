Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF914C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 07:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7844E20578
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 07:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="RYWLSkVs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbeLYHRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 02:17:46 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:33436 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbeLYHRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 02:17:45 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 1C61AC98
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 07:17:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gqKTHOb8jEfW for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 01:17:43 -0600 (CST)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id E3EF1C7B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 01:17:43 -0600 (CST)
Received: by mail-it1-f199.google.com with SMTP id x3so15455744itb.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 23:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=MK7cmQY83w2QOkiWNcO3KN9v4uhY1nMeXhXzFD4NdL4=;
        b=RYWLSkVsWV4baAaaMMVV46KhDp/Bj8Z65grYmHxlKqjj3PuaRteRbLdBGfUofvmPlG
         SfeIdtZ5LJEuOQGQE3bVJwM02PoVkR945MyBY4iDNxqo+/5XDoZrFoRi/9h1iC7VjSi7
         Ing3MMkh60n83HMk8pYjn/II4K971fFR4jTaYG1viZaXJ/1FjORynJzUp/k7YzL0bZ4G
         +WAfYK/ZmftCN+BJv21FVdzm1r4aHUkYilCeSsPCvYoURE8mOz6U94JwEABphh3oM+Pb
         h4EV5uES5XYKLH3LPAomnDYIFou6usd5lKczxFN1RGGMmxMEsO2k6ms6CmxGAq204ZSt
         3e/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MK7cmQY83w2QOkiWNcO3KN9v4uhY1nMeXhXzFD4NdL4=;
        b=plYvNP1/lQYy1R+qagvVqwIxydKPGC1jZ1C/TPiVW3nMTJ29fY+lPuBQyjp57o3bL5
         KM0aT1Byt/BesDlQoy2CJgbOzkhoZJ2ctjqdwALtFu/8FfhKrZOmSF1NanBlDFdzuSI3
         fEsoFDakNAcIj9gk13pm3OaxFbBwBrqictX+x58N4zyIhPOAVqlnqc3tir0Vm8a6Ld0c
         awiZrYltyKHbsiHQXy6USgyPZxBVXr00EQR310GpKe0RarnR6t6Q8wZKcqnhF4jajqr8
         7AaRTM4ATSPWvUtmJGEemAmqxFGWLAXaFKkHtx6609HGBgmWTVFhx+D6ZSJbw7868HDO
         tH3g==
X-Gm-Message-State: AJcUukcAO6TWuDla3Kf7rw1wq6pOsUF1XKV1NJnyFL7QAwXwlnzpwXU3
        PAsdpzsbLAXoT1ZNcBzUUyEMuI7EtjygB9ioWLN/3syaJQ4womEcV4ns6ozh3b5KHN2UNnHwL+Z
        xTpqDHcqv+mUyfAecBV9+qji2Z0f2
X-Received: by 2002:a24:5314:: with SMTP id n20mr9479831itb.132.1545722263479;
        Mon, 24 Dec 2018 23:17:43 -0800 (PST)
X-Google-Smtp-Source: AFSGD/X5Hm7srcIhjVkU9hE4v+2pjmmCjAJ2bshlUxPBobBIXFvFLHCHxQPPPvhaSmNfjqO/YSdw7w==
X-Received: by 2002:a24:5314:: with SMTP id n20mr9479826itb.132.1545722263206;
        Mon, 24 Dec 2018 23:17:43 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id p132sm9346110itb.35.2018.12.24.23.17.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Dec 2018 23:17:42 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: fix missing checks of the return value of check_reg_arg
Date:   Tue, 25 Dec 2018 01:17:10 -0600
Message-Id: <20181225071710.67835-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

check_reg_arg() may fail. This fix inserts checks for its return value.
If check_reg_arg() fails, issues an error message.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 kernel/bpf/verifier.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 51ba84d4d34a..fde91a5c0b5a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2619,7 +2619,10 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	/* after the call registers r0 - r5 were scratched */
 	for (i = 0; i < CALLER_SAVED_REGS; i++) {
 		mark_reg_not_init(env, caller->regs, caller_saved[i]);
-		check_reg_arg(env, caller_saved[i], DST_OP_NO_MARK);
+		err = check_reg_arg(env, caller_saved[i], DST_OP_NO_MARK);
+		if (err)
+			verbose(env,
+					"check_reg_arg() fails in setting caller saved regs\n");
 	}
 
 	/* only increment it after check_reg_arg() finished */
@@ -2842,7 +2845,10 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
 	/* reset caller saved regs */
 	for (i = 0; i < CALLER_SAVED_REGS; i++) {
 		mark_reg_not_init(env, regs, caller_saved[i]);
-		check_reg_arg(env, caller_saved[i], DST_OP_NO_MARK);
+		err = check_reg_arg(env, caller_saved[i], DST_OP_NO_MARK);
+		if (err)
+			verbose(env,
+				"check_reg_arg() fails in resetting caller saved regs\n");
 	}
 
 	/* update return register (already marked as written above) */
@@ -4435,7 +4441,10 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	/* reset caller saved regs to unreadable */
 	for (i = 0; i < CALLER_SAVED_REGS; i++) {
 		mark_reg_not_init(env, regs, caller_saved[i]);
-		check_reg_arg(env, caller_saved[i], DST_OP_NO_MARK);
+		err = check_reg_arg(env, caller_saved[i], DST_OP_NO_MARK);
+		if (err)
+			verbose(env,
+				"check_reg_arg() fails in resetting caller saved regs to unreadable\n");
 	}
 
 	/* mark destination R0 register as readable, since it contains
-- 
2.17.2 (Apple Git-113)

