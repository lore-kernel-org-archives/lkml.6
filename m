Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE00C46475
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 23:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05FA5208E7
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 23:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8Qxp0ca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05FA5208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbeJGGjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 02:39:40 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34813 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbeJGGjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 02:39:39 -0400
Received: by mail-wm1-f65.google.com with SMTP id z25-v6so6150941wmf.1;
        Sat, 06 Oct 2018 16:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/SLne0mnrsDWXdIjAUi1bGxH4OeDwTEqfbJU9GdKjI0=;
        b=F8Qxp0caR8mYktlLEdwayLhkzJCfGZcCFbU2wV5IMJVw3MBxH/zXQykCL9N1sOs8UD
         nM8v26YX/u47qln6iZ4mix2p3PTgbHlpvRuuUxdML09A/7zc18963yvdtUVuwv8NMKhn
         SVwwtbo1CPnpGdxR9WclDriUWYPd+hRysTY0t6d6EJjVF+CiVGSk0/pKFv1EulVxrkdu
         SppkZPH2pYTO1QybAQyU0JnxqQ25FUHc/z7xqTRIJnS0cO3DdH29y5H4F8vaw2G/gN+r
         fTCH3WmFV5pKNgVudsnU+dloKlGdPlFJtzGhKNwdZ3t767oyFwdHAaTSjfvhN7G73DLV
         Yhfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/SLne0mnrsDWXdIjAUi1bGxH4OeDwTEqfbJU9GdKjI0=;
        b=aVptqqJTvYbWDaIReYo100suPCA0gPHifS8r39R6aE0pKWWmHjnCpWYXuKxKrkZIK+
         g/zCp38zkam28FEyN9nyNASEy4lWA8qeSg5BhS19ZBEpQ5orNArIF30CnuxDip2D0LtH
         PGrsEyZ2uvdWR5qn7xeLAYG5nXqbphrGg08w2zCH5Mp4mEgfE48JBZ7rMzIh7rRPWMAb
         Zh4/0UIddcsXwjlqZ4J9kZIuS4zIaZkiAV7Qq5OR5soyjRDQBaE7u8UyOGTgT2r3rSt2
         o0pqp+nCmXsqHTiIOFNhRUz0sGgqYgDsZ+fFbS2cl5icCTyd+4i0tO7sLwhczdpewAXI
         b3cw==
X-Gm-Message-State: ABuFfoi4yeQfcIV9WRBspAxEYA9sbeYMI5uMlEns9TrCxIGnz8FLWjq8
        4SV0uyqvkm6/cZRNofLosVk=
X-Google-Smtp-Source: ACcGV61ctOL/qWcB9mmIq/BupQd2Lv41sSxxUIdjHeqKUN6Ww4VJshZfw7k6W9MDF64+5boPo7kroA==
X-Received: by 2002:a1c:6c09:: with SMTP id h9-v6mr10880506wmc.95.1538868868897;
        Sat, 06 Oct 2018 16:34:28 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id a18sm9158672wrx.55.2018.10.06.16.34.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Oct 2018 16:34:28 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] netfilter: xt_quota: Don't use aligned attribute in sizeof
Date:   Sat,  6 Oct 2018 16:33:31 -0700
Message-Id: <20181006233331.13150-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

net/netfilter/xt_quota.c:47:44: warning: 'aligned' attribute ignored
when parsing type [-Wignored-attributes]
        BUILD_BUG_ON(sizeof(atomic64_t) != sizeof(__aligned_u64));
                                                  ^~~~~~~~~~~~~

Use 'sizeof(__u64)' instead, as the alignment doesn't affect the size
of the type.

Fixes: e9837e55b020 ("netfilter: xt_quota: fix the behavior of xt_quota module")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 net/netfilter/xt_quota.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/xt_quota.c b/net/netfilter/xt_quota.c
index 6afa7f468a73..fceae245eb03 100644
--- a/net/netfilter/xt_quota.c
+++ b/net/netfilter/xt_quota.c
@@ -44,7 +44,7 @@ static int quota_mt_check(const struct xt_mtchk_param *par)
 {
 	struct xt_quota_info *q = par->matchinfo;
 
-	BUILD_BUG_ON(sizeof(atomic64_t) != sizeof(__aligned_u64));
+	BUILD_BUG_ON(sizeof(atomic64_t) != sizeof(__u64));
 
 	if (q->flags & ~XT_QUOTA_MASK)
 		return -EINVAL;
-- 
2.19.0

