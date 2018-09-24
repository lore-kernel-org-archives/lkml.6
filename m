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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4FDECE568
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0E720685
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZM/aExat"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF0E720685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbeIYDJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 23:09:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37696 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbeIYDJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 23:09:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id u12-v6so21078076wrr.4;
        Mon, 24 Sep 2018 14:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tWP7YNW1h2XecsB2LbVl5rKo0sfwbS52wMoaz/8kqoU=;
        b=ZM/aExatjNHKbI5wPyBfuPuhOzq9WX4Vlxk+tq6gv22ZSGRBSRd8Grx8PyyhCFaCvk
         yZlpOXBulPf9jBYHwENR9zlydoIK3jm1pRQQONgf0llAVamwZ9a4yKfCaPkFQHVNscWB
         zeC9gv6y/v/BCk86BSjniq7Uyr3cNCsn7yOScbJYtGl27pFttbTp8wDiWdV3j/KgOAhC
         0varbTH8n+ctNgb2HBL3WRR6PSUpxuX7FNUO+rTjwfyBb1WAjMTBSs6Nf3+fVNdGk0QC
         5LlVKR6R+zCS+DqXFP0iNmN7Wl+G0/55H+Ey05bS1qN8z9BXribG0h7CuVMF7glC8sVt
         Cl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tWP7YNW1h2XecsB2LbVl5rKo0sfwbS52wMoaz/8kqoU=;
        b=pFT/Xt8DWFN7X+Ukgubx16Ba9nN8KtpB8f9NQJ8cfMpsg75MkgmnrwHNCgAX8Lt6cV
         qxSUC+Nu8k/x9LJKDRMJqDZhByCw9Oo65BUIfyVXJDM4yRMHnr+QQjQ6pJ+j2QQuQWNa
         f6jj+ZrAPBTGUavKUbCLK5ZhJVIvz6E7S2ty6wWnEG9rEV8g60/fRafPX5UVqYQHVqyO
         lGbiVnlidfqW9WS5WMDUYsXDPBjqJkRLiZ+IJZRsgwq0dQMRFBh8AmxokaGIb2PXj6hi
         jv+e2BBOprvCcZWPf1lWce9IGLmdVs1iVGVqqfiY2Xp5kAHkk9T3XToI15ghNFtMGmso
         BBUw==
X-Gm-Message-State: ABuFfohMbXgueQb650jf415XYzZQPFF56YLYaoUq/HDnHeJCXHDfkb+o
        DSewXFfCykj4PoU6oZMfbewJ/NRd0CUHwQ==
X-Google-Smtp-Source: ACcGV60JaPB9W1wz3yDkthISTlokutWJVcGLTwrAec5eXGeR7psbWiDtqXDs/7g+mNjrBNt4Hbl56w==
X-Received: by 2002:adf:e603:: with SMTP id p3-v6mr445243wrm.254.1537823133825;
        Mon, 24 Sep 2018 14:05:33 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id r13-v6sm81229wmf.35.2018.09.24.14.05.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 14:05:32 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Ariel Elior <Ariel.Elior@cavium.com>, everest-linux-l2@cavium.com,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] qed: Fix mask parameter in qed_vf_prep_tunn_req_tlv
Date:   Mon, 24 Sep 2018 14:05:27 -0700
Message-Id: <20180924210527.11996-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang complains when one enumerated type is implicitly converted to
another.

drivers/net/ethernet/qlogic/qed/qed_vf.c:686:6: warning: implicit
conversion from enumeration type 'enum qed_tunn_mode' to different
enumeration type 'enum qed_tunn_clss' [-Wenum-conversion]
                                 QED_MODE_L2GENEVE_TUNN,
                                 ^~~~~~~~~~~~~~~~~~~~~~

Update mask's parameter to expect qed_tunn_mode, which is what was
intended.

Link: https://github.com/ClangBuiltLinux/linux/issues/125
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/net/ethernet/qlogic/qed/qed_vf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_vf.c b/drivers/net/ethernet/qlogic/qed/qed_vf.c
index 3d4269659820..fcd8da08274f 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_vf.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_vf.c
@@ -572,7 +572,7 @@ int qed_vf_hw_prepare(struct qed_hwfn *p_hwfn)
 static void
 __qed_vf_prep_tunn_req_tlv(struct vfpf_update_tunn_param_tlv *p_req,
 			   struct qed_tunn_update_type *p_src,
-			   enum qed_tunn_clss mask, u8 *p_cls)
+			   enum qed_tunn_mode mask, u8 *p_cls)
 {
 	if (p_src->b_update_mode) {
 		p_req->tun_mode_update_mask |= BIT(mask);
@@ -587,7 +587,7 @@ __qed_vf_prep_tunn_req_tlv(struct vfpf_update_tunn_param_tlv *p_req,
 static void
 qed_vf_prep_tunn_req_tlv(struct vfpf_update_tunn_param_tlv *p_req,
 			 struct qed_tunn_update_type *p_src,
-			 enum qed_tunn_clss mask,
+			 enum qed_tunn_mode mask,
 			 u8 *p_cls, struct qed_tunn_update_udp_port *p_port,
 			 u8 *p_update_port, u16 *p_udp_port)
 {
-- 
2.19.0

