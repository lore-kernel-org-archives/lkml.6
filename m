Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0758DC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D232147D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uYs0sVZ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2D232147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730434AbeJEXR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:17:58 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:46232 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729530AbeJEXR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:17:58 -0400
Received: by mail-qk1-f202.google.com with SMTP id p128-v6so12813053qke.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 09:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=cQ9JSSsF2O+YiukHbjWxYbVnwmc9rU5fCIU4mPWxpJI=;
        b=uYs0sVZ69R9D36DrZ452Zp7wC9xXDCQoIJnzTvqQ8SbsniUC/XqmpyNT0l/m+nQWKC
         rqi0Ol+kot/wyv/qE6jgxDEVXYSnatnP+X4aArvqiU+mnG1KqEcSbiHw7O/Po0tI3BST
         WQYpr3BAFG9+FdJlETUbtMMEoqsY+kll5fNL5bw1cB+gI4lWiYHuRFqlMHa6Cv/1gz6c
         BD76B0I5Fwi2tLmfP6dzYyVo8ohwmCjRRx44NJic6ZeEZExGz0KWAWEn2rMb3unPr++j
         4Whh8pa1+ybAAQL9JdzRG7e9V3LvWxZfuZb6OKLopxCJYZb7vCo9yrdvLBLq1ouExcyf
         bXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=cQ9JSSsF2O+YiukHbjWxYbVnwmc9rU5fCIU4mPWxpJI=;
        b=q9O2gkV86+TXK9AncfYnXVIWiFiKBeKOMOQn5qdQGOmAPEgSfSOnA6KE1raIeMSikl
         iMIo3gH5n4Lx6evT5esZu67dUsM0uApARH9AXaKNCDVKAbH873gA4Bsqo6icL81k9siI
         06qQz3y9RMF+XhnMlVspkBRIVT8rqjkm6EFq+9CoKy+jqBVV76VvnuqaT1XCbvX7Ogbg
         5tDC1Dtjb74wbxkeTgig07Xl6rwPSb0GEyOnPScwPweb5IhGH6rg0fBvDb9fN8XFFPme
         VtNJRynakd8wERL3pCC5hf/Lsn/c+w2Gopnvt2Y6wzGpC5EJspTMdTNurI1Fw1Zy/tTg
         wYiQ==
X-Gm-Message-State: ABuFfohLcEWPRVEjr+Brb91Gvjvdt2wFYSIHpEZAIhOQperOA3s1fbQ4
        FfqBL2AWzy9AClsJ4c375LYIAstm1A==
X-Google-Smtp-Source: ACcGV62q5xA+TqpstgQh+c9L2NoGHvYLPQZVXo4Wb+VVjARN65KyqgBk92+OKsahAFN0S6s2UdwS8pYFRA==
X-Received: by 2002:a0c:be06:: with SMTP id k6-v6mr8970698qvg.4.1538756313719;
 Fri, 05 Oct 2018 09:18:33 -0700 (PDT)
Date:   Fri,  5 Oct 2018 18:17:59 +0200
Message-Id: <20181005161759.177992-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH] bpf: 32-bit RSH verification must truncate input before the
 ALU op
From:   Jann Horn <jannh@google.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
        jannh@google.com
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I wrote commit 468f6eafa6c4 ("bpf: fix 32-bit ALU op verification"), I
assumed that, in order to emulate 64-bit arithmetic with 32-bit logic, it
is sufficient to just truncate the output to 32 bits; and so I just moved
the register size coercion that used to be at the start of the function to
the end of the function.

That assumption is true for almost every op, but not for 32-bit right
shifts, because those can propagate information towards the least
significant bit. Fix it by always truncating inputs for 32-bit ops to 32
bits.

Also get rid of the coerce_reg_to_size() after the ALU op, since that has
no effect.

Fixes: 468f6eafa6c4 ("bpf: fix 32-bit ALU op verification")
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Jann Horn <jannh@google.com>
---
 kernel/bpf/verifier.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bb07e74b34a2..465952a8e465 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2896,6 +2896,15 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 	u64 umin_val, umax_val;
 	u64 insn_bitness = (BPF_CLASS(insn->code) == BPF_ALU64) ? 64 : 32;
 
+	if (insn_bitness == 32) {
+		/* Relevant for 32-bit RSH: Information can propagate towards
+		 * LSB, so it isn't sufficient to only truncate the output to
+		 * 32 bits.
+		 */
+		coerce_reg_to_size(dst_reg, 4);
+		coerce_reg_to_size(&src_reg, 4);
+	}
+
 	smin_val = src_reg.smin_value;
 	smax_val = src_reg.smax_value;
 	umin_val = src_reg.umin_value;
@@ -3131,7 +3140,6 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 	if (BPF_CLASS(insn->code) != BPF_ALU64) {
 		/* 32-bit ALU ops are (32,32)->32 */
 		coerce_reg_to_size(dst_reg, 4);
-		coerce_reg_to_size(&src_reg, 4);
 	}
 
 	__reg_deduce_bounds(dst_reg);
-- 
2.19.0.605.g01d371f741-goog

