Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96AAC282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB83C2146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsZ+Lg+r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbfBHMyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:54:04 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:38794 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbfBHMyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:54:01 -0500
Received: by mail-yw1-f67.google.com with SMTP id o184so1319011ywo.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 04:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aPyAJ42XovMqyJiD3Qs1WFDlPUw3sVZVO41p3xDNbv0=;
        b=PsZ+Lg+rQ+955wuHFzwn/wE050Jw4bsjQ+DY2ikI7CSBF5l2Hl50EGjBEbaG26o0Qi
         wQ1WxSq3alEZkLJXseEtXGSVPYY6v9Ev/4AbHG7x+3r6KM5pUj/kAB12RnsHGQaxQeRS
         yRRsgkb3Nq8rMh1/8ysuI1h7pjcnYKyYCA33y1FndpiNEA5+YWng0VfsLankqxMOeT+/
         Qb61KGvTB9SmmpAK4Fro8+Ck11M4NMEdyihvmjyG+LiymIpKMmnOrU+uytD5ygbZGJ/3
         QAjiIa4QuQ5JVSgtpiV/wtxhO3jhiptnkSU269NYYA1PBKNz65mFJgrzPKaZzr1pGYzs
         swwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aPyAJ42XovMqyJiD3Qs1WFDlPUw3sVZVO41p3xDNbv0=;
        b=AbQg7LTl5cOxSpeytBTQ/xukWIncQekqZpBg3ol5PwaEz4Fs9Ov+abwXbVDKOfyu2T
         0D1SfVvDcLyyt6BNFLLirbxLpCFQExUXRSzk6VWF9kmFVSDm6rW6OZLRfZ7QMmdlStCO
         3Wb8CxdorrQwuqjLx78FRVrUXNiO/bvQVXq1ybGEvmvVlAeeFwGfTz4JMs9nWFc135JF
         R8+f9ummylfkM9K8rrKxQMTADDcK+2VNyFCoVJw3WzdQL8fjVzhKedPx+iKBGVaKeUz8
         CHFkqGkD9cSPb03Vgh9RLcCGqpEInAWlAhoEeAbeCT13QipMDhgiIurrhJEsMJqJNfOw
         d6kg==
X-Gm-Message-State: AHQUAuY40vQnexGFUAkhrXjcwMCIDELcEOzWVSQALgJOu2FFpWPTpRIM
        SqnzzvwOHMscLVL/R9k1uXg=
X-Google-Smtp-Source: AHgI3IaOQkggc8i3A6f9jziAfOdfFpSyI+b4BzDtNKdX5bVAEKd+jfkdDMsFm4VT5B86r5n/YHwGIg==
X-Received: by 2002:a81:301:: with SMTP id 1mr17511589ywd.185.1549630440753;
        Fri, 08 Feb 2019 04:54:00 -0800 (PST)
Received: from localhost.localdomain ([191.101.9.198])
        by smtp.gmail.com with ESMTPSA id w2sm762330ywc.63.2019.02.08.04.53.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 04:54:00 -0800 (PST)
From:   Bo YU <tsu.yubo@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        linux-kernel@vger.kernel.org
Cc:     Bo Yu <tsu.yubo@gmail.com>, hpa@zytor.com, x86@kernel.org,
        puwen@hygon.cn
Subject: [PATCH] x86: drop warning from mtrr: -Wunused-but-set-variable
Date:   Fri,  8 Feb 2019 07:53:43 -0500
Message-Id: <20190208125343.11451-1-tsu.yubo@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bo Yu <tsu.yubo@gmail.com>

There is a warning if enable W=1 when compile kernel:

arch/x86/kernel/cpu/mtrr/cleanup.c:299:16: warning: variable ‘second_basek’ set but not used [-Wunused-but-set-variable]
  unsigned long second_basek, second_sizek;

Signed-off-by: Bo Yu <tsu.yubo@gmail.com>
---
 arch/x86/kernel/cpu/mtrr/cleanup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/cleanup.c b/arch/x86/kernel/cpu/mtrr/cleanup.c
index 3668c5df90c6..5bd011737272 100644
--- a/arch/x86/kernel/cpu/mtrr/cleanup.c
+++ b/arch/x86/kernel/cpu/mtrr/cleanup.c
@@ -296,7 +296,7 @@ range_to_mtrr_with_hole(struct var_mtrr_state *state, unsigned long basek,
 			unsigned long sizek)
 {
 	unsigned long hole_basek, hole_sizek;
-	unsigned long second_basek, second_sizek;
+	unsigned long second_sizek;
 	unsigned long range0_basek, range0_sizek;
 	unsigned long range_basek, range_sizek;
 	unsigned long chunk_sizek;
@@ -304,7 +304,6 @@ range_to_mtrr_with_hole(struct var_mtrr_state *state, unsigned long basek,
 
 	hole_basek = 0;
 	hole_sizek = 0;
-	second_basek = 0;
 	second_sizek = 0;
 	chunk_sizek = state->chunk_sizek;
 	gran_sizek = state->gran_sizek;
-- 
2.11.0

