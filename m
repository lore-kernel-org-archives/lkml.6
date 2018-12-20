Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A666C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC7E21901
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="OotiyHbB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389520AbeLTTqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 14:46:07 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:35182 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728613AbeLTTqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 14:46:06 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 85955A3E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 19:46:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6K2e3viLMnc6 for <linux-kernel@vger.kernel.org>;
        Thu, 20 Dec 2018 13:46:04 -0600 (CST)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 5CCBB24B
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 13:46:04 -0600 (CST)
Received: by mail-io1-f71.google.com with SMTP id a20so2145231iok.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 11:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=0xvn3fRPbtUPvmorvR9QfwFmHuS6C9WN1pNKuPpIdJ0=;
        b=OotiyHbBHjWsyF05SbZC69YHEy7Eu4bBLwGnYwUJiTmZBtEzTYxapUZcQaex/he82n
         zb379mNyKrjK3DVcS/B97S0X6zGpJWCL8xsnNNzycJMP/E4R7H3g7SRt/eoADrj/aCq+
         +XjruOkmhvcHRlaGEFikh+xecge3SGeKjNqAd1FekanxGyA8cuyUf5clZRUz9tPw8vaA
         VgJD2DfvkYk91i9JygeyMrZ7Km7bB4Gfbo30L/InDyeI0hh+qlV+XVcifFtLUmldoeFN
         AGHilcaLHoJImqO9LmoviEzgitYYAGjtMQqVHYxikkwHoqUN6hvruLtD3UfrTpOHukSK
         A2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0xvn3fRPbtUPvmorvR9QfwFmHuS6C9WN1pNKuPpIdJ0=;
        b=fRBXPQc2M0tSnxfaNnrHUX13I/N57rKbNdOXyqSNdp8ELVYdyue2J+nMEtEU9CKrRt
         qR1+Cf7E4pEMFBpnFB8C09v5pSKl944WjJL+BoGV25ksVpsMa9YUAoKGYMqW1eo6HATk
         aBsEJe0tCAMk8xvBteytjc7auBi5sK1fPklGViycUfjXb0yIGuws4PfyukslG7J7JW3q
         DlazPyIgI5euiEI4xGbHMhDr8L4QjMAhRvQ895+XgJz8W0psEio4ioO+2+XVkx6COK+7
         vLBz5P/6VFU5Rh7bAuUeZUnPQfMxrNl3IeEmTxvKDbpqlsjxw/AG9Gd5/yQRMJOHWWln
         uoQg==
X-Gm-Message-State: AA+aEWb0ozcY+2YgGd8VdVVH278Go3U4Ucs2gh/zY5jdbIoUUgCJN0T0
        ti8xs/Vv+1STnhPJlumJAFsNq7FFtlHpl6M0gnnYSxfxbqjiebb4uKNaKbWX0ZUhE/T5NKHrcTC
        Yuuj8IfIws9Ed9PBiH33BSV4pLdIn
X-Received: by 2002:a6b:8bd1:: with SMTP id n200mr19305316iod.96.1545335163961;
        Thu, 20 Dec 2018 11:46:03 -0800 (PST)
X-Google-Smtp-Source: AFSGD/WopmDiYZafMsdTLxYL40IGMjug53IfKL1GtW0jn9J3KFs8XWXiZ/gYEanGdamytscXfxTLbA==
X-Received: by 2002:a6b:8bd1:: with SMTP id n200mr19305304iod.96.1545335163682;
        Thu, 20 Dec 2018 11:46:03 -0800 (PST)
Received: from bee.cs.umn.edu (cs-bee0u.cs.umn.edu. [134.84.121.28])
        by smtp.gmail.com with ESMTPSA id u13sm477680iop.78.2018.12.20.11.46.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 11:46:02 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: fix a missing check of return value
Date:   Thu, 20 Dec 2018 13:45:56 -0600
Message-Id: <20181220194557.29196-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

check_reg_arg() may fail and not mark correct data in "env".  This
fix inserts a check that ensures check_reg_arg() is successful, and
if it is not, the fix stops further operations and returns an error
upstream.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 kernel/bpf/verifier.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 51ba84d4d34a..ced8cc6470b1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2619,7 +2619,9 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	/* after the call registers r0 - r5 were scratched */
 	for (i = 0; i < CALLER_SAVED_REGS; i++) {
 		mark_reg_not_init(env, caller->regs, caller_saved[i]);
-		check_reg_arg(env, caller_saved[i], DST_OP_NO_MARK);
+		err = check_reg_arg(env, caller_saved[i], DST_OP_NO_MARK);
+		if (err)
+			return err;
 	}
 
 	/* only increment it after check_reg_arg() finished */
-- 
2.17.1

