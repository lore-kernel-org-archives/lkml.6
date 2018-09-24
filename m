Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91852C43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45CEF204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYBoVGOs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45CEF204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbeIYEVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 00:21:35 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37740 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbeIYEVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 00:21:35 -0400
Received: by mail-wm1-f65.google.com with SMTP id n11-v6so11548362wmc.2;
        Mon, 24 Sep 2018 15:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pZClakj9wE9OIq8QtcJn1pxtv+5BPs0+ahFjrse7UwI=;
        b=YYBoVGOsFTolcuUOVXsD9Cpfjv4qFegUKVe7Hh1Pw0EHJlfdt5ygiIxw4XE7GPJUBB
         v0rtwjGhnGOLMwib0p3xHEeeSl7kx3jq9OZhNwXiCUPckYvz4KnvMTIZhZCTF1nJAwQw
         73gBqRJ0vEoMWD5ivGGxbErpbLmnM3oAp/Q3vhFjnELVODZjwuJ8WUMVFzKZI3ZdE278
         NUyFFqdEl5gJG8MVtioZTQ78Vx62Croqg7Y93kMluOkomtz/cDVuIyKMt+K2SKAluET/
         0+W5aHjS9cmE4TspyxtFJOi10EZ2WT+rf/HmhN3gyVB2NLEmz2q6r0WPvidWUK3O9+HM
         ewCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pZClakj9wE9OIq8QtcJn1pxtv+5BPs0+ahFjrse7UwI=;
        b=KGKKiebz8MU4Ezud7tgWrTFg3cWuBGT++gtLh+/Z80ZZ1cx1psvP9xCQOHgWxz04Pf
         V8JJ7ee6dj6p2q0s5XphckkhF4Q9a2HrhyFWb10PuiK9pcYztVyl6gO11JviLYk5DMMx
         qdOIcFkX9cV0lhuFvuCrIYqfau40VQKtWWGRnuJLlMQC/odCMb0FQSlkSYjZL7yWjBEU
         BdQJ080cbfk4ssnnFjrGVuQUxc7aKEbxXi5CC1xSMoLlSk4M/uMdW08jIR8TV3j2sobZ
         fhXwhaxzVfYIJOPU5ox+xaL+Vsl3+ejHVfIi726VVwFSGTzuHcYhfSoX84wGsOZ3J/Sq
         EK/w==
X-Gm-Message-State: ABuFfogCk6CSQHiPSpSR6lOvKs7M2qMVzfI0pvnCpzn58ZIn/iJEpPLS
        x3hAtFS01n8a8173frlO0Z3+fTA+J3S7bA==
X-Google-Smtp-Source: ACcGV61Ty1Hq+oyGoXqSwgG6/073zovbOwz0Sj9lk0aMZKi6Uz/zmTcM/RXiMROcNJxd0L0dURBWWA==
X-Received: by 2002:a1c:f210:: with SMTP id s16-v6mr266956wmc.36.1537827431247;
        Mon, 24 Sep 2018 15:17:11 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id g2-v6sm209533wmh.16.2018.09.24.15.17.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 15:17:10 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Ariel Elior <Ariel.Elior@cavium.com>, everest-linux-l2@cavium.com,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] qed: Avoid constant logical operation warning in qed_vf_pf_acquire
Date:   Mon, 24 Sep 2018 15:17:03 -0700
Message-Id: <20180924221703.26454-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when a constant is used in a boolean context as it thinks a
bitwise operation may have been intended.

drivers/net/ethernet/qlogic/qed/qed_vf.c:415:27: warning: use of logical
'&&' with constant operand [-Wconstant-logical-operand]
        if (!p_iov->b_pre_fp_hsi &&
                                 ^
drivers/net/ethernet/qlogic/qed/qed_vf.c:415:27: note: use '&' for a
bitwise operation
        if (!p_iov->b_pre_fp_hsi &&
                                 ^~
                                 &
drivers/net/ethernet/qlogic/qed/qed_vf.c:415:27: note: remove constant
to silence this warning
        if (!p_iov->b_pre_fp_hsi &&
                                ~^~
1 warning generated.

This has been here since commit 1fe614d10f45 ("qed: Relax VF firmware
requirements") and I am not entirely sure why since 0 isn't a special
case. Just remove the statement causing Clang to warn since it isn't
required.

Link: https://github.com/ClangBuiltLinux/linux/issues/126
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/net/ethernet/qlogic/qed/qed_vf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_vf.c b/drivers/net/ethernet/qlogic/qed/qed_vf.c
index fcd8da08274f..be118d057b92 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_vf.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_vf.c
@@ -413,7 +413,6 @@ static int qed_vf_pf_acquire(struct qed_hwfn *p_hwfn)
 	}
 
 	if (!p_iov->b_pre_fp_hsi &&
-	    ETH_HSI_VER_MINOR &&
 	    (resp->pfdev_info.minor_fp_hsi < ETH_HSI_VER_MINOR)) {
 		DP_INFO(p_hwfn,
 			"PF is using older fastpath HSI; %02x.%02x is configured\n",
-- 
2.19.0

