Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0912FECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3D8F21523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2O8OMUJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3D8F21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbeJQVN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:13:26 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45404 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbeJQVNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:13:24 -0400
Received: by mail-pl1-f195.google.com with SMTP id y15-v6so12686456plr.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 06:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dzdia8kmFSoj0oVRVXr6qoItUBuOHOKpTtwWkuViUoA=;
        b=a2O8OMUJLRydUdnM7jfPopqjwAFlsRH1W+rjIDjDSytJ2lJ7tGwXKleqBpAPBmPkPq
         Kfm7osu7PlFyTMbGqNtVzDMvvKE+ZVGNeQ/hbHQKzuSh+8/D5+P2y9Z0c0j5r2WN97Kk
         S0fLtbVAtmU8EVVXhQt6rXpQ6Unfom9CAFe+xpSfeyB/kuREb9auuKkPUeYoi36sFZwn
         RsnH7qisnRbTtSDpKrvp0uLGnTbt0CUifckmyC6Z36gvJbQJI0O7akaO0CHQIiVBZpdD
         rfZHzRRUq9rBWmKGGzicPJQzxgxbFp82PA2oXy+8iTorHO4HAFCt8qxt96znViE+A1i1
         rgug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dzdia8kmFSoj0oVRVXr6qoItUBuOHOKpTtwWkuViUoA=;
        b=r7Qfodq1KpHoJY8ylFLrhxAqFUQzvWCN8TJy/7nIgZTolCK+1Yc6YMdd9JyFaCievq
         V75naXN4kG09TL9P8ePC+ntsDPwIz67Yy7BviFD2COlNAgUTuNh/qrV/tr094G2NGUqe
         pPk4rD2SK6LaUxIyaCRUtB/t2fgGRWw4UGTP/CZb9TfNIyx3SRmA4a71hUmvZp/PeQ5C
         LN3wG2zd/LGR00tsB3QVS2Hpn9hlaxxCsiPhLERscGRdv61sIVsZ4RkMRqjYjgYOkVlu
         on/LAH8Sg1UmRlJqgb7GcQG/Ub8V/wMDt3PsiBN91RtAwxAw2Kfy07PMJPQF2RdB6uW5
         TOnA==
X-Gm-Message-State: ABuFfogiTePXOy3IRZY2hq8CiCsqykr3XFwTMqhlSXa5cy8Y7X7yjAVs
        VSvPUni2E27HvZXz7wkSYKEqO7wk
X-Google-Smtp-Source: ACcGV614Fx4uDxVxlT9M5r1rIYhVrB3yECO6WxymXLSFa727uK2vi2XHD0WzKzOAVTnvC7u6yjS/mw==
X-Received: by 2002:a17:902:54d:: with SMTP id 71-v6mr18275506plf.80.1539782265118;
        Wed, 17 Oct 2018 06:17:45 -0700 (PDT)
Received: from app09.andestech.com (59-120-53-16.HINET-IP.hinet.net. [59.120.53.16])
        by smtp.gmail.com with ESMTPSA id l16-v6sm34943010pfj.179.2018.10.17.06.17.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 06:17:44 -0700 (PDT)
From:   Zong Li <zongbox@gmail.com>
To:     green.hu@gmail.com, deanbo422@gmail.com,
        linux-kernel@vger.kernel.org
Cc:     greentime@andestech.com, Zong Li <zongbox@gmail.com>,
        Zong Li <zong@andestech.com>
Subject: [PATCH 1/2] nds32: Remove the redundant assignment
Date:   Wed, 17 Oct 2018 21:15:51 +0800
Message-Id: <eccb279777573bea97149e7810b7827a53747095.1539781832.git.zongbox@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1539781832.git.zongbox@gmail.com>
References: <cover.1539781832.git.zongbox@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For early version, the value of r2 register was used to display
a character on UART when error occurred. Remove these r2 assignments
because we no longer show the character.

Signed-off-by: Zong Li <zong@andestech.com>
---
 arch/nds32/kernel/head.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/nds32/kernel/head.S b/arch/nds32/kernel/head.S
index c5fdae1..1ce653d 100644
--- a/arch/nds32/kernel/head.S
+++ b/arch/nds32/kernel/head.S
@@ -130,14 +130,12 @@ _image_size_check:
          *
          * direct mapping is not supported now.
          */
-        li      $r2, 't'
         beqz    $r6, __error                 ! MMU_CFG.TBW = 0 is direct mappin
         addi    $r0, $r0, #0x2               ! MMU_CFG.TBS value -> meaning
         sll     $r0, $r6, $r0                ! entries = k-way * n-set
         mul     $r6, $r0, $r5                ! max size = entries * page size
         /* check kernel image size */
         la      $r3, (_end - PAGE_OFFSET)
-        li      $r2, 's'
         bgt     $r3, $r6, __error
 
 	li      $r2, #(PHYS_OFFSET + TLB_DATA_kernel_text_attr)
-- 
2.7.4

