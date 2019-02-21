Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D13C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 05:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E6C12148D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 05:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wn4N3cgD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfBUFZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 00:25:46 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45700 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfBUFZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 00:25:46 -0500
Received: by mail-lj1-f196.google.com with SMTP id s5-v6so22803001ljd.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 21:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QMZQwXqpdYwAziUSNtrgcd8px4teYjl7UKRkodqz0zg=;
        b=Wn4N3cgDGCfKy7PgU6u7mtLD4IRV4PpvdUaoHgAo6G13aKnay7uDssunRWYS6Ip6mC
         cK3eHwjJ0YCVIOu51hrG+ypJyE+ZZjtW3S4I8TN6EGh54C8wK/AriP9xj9Ji3TuKpTVs
         zy2BWfsf1zBW14pTmdnRYqw8GitlY0v3A8+ZXxO5cQZ8CAsVENU1zSTpYl65/n844q9U
         t0vhhYqTxCvkV1ofM5qjAXOsMQqCZt2TwfgcSYdU4ceVbmZLH+rvJHQUIwIjLYJgaSi0
         fN+qVP9gAoAyQ6Jy85o7cHbCSQtFZC3Z5tVC1uZoivIW085qsZqSa0oIpEbAu/Y2Yyu7
         HWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QMZQwXqpdYwAziUSNtrgcd8px4teYjl7UKRkodqz0zg=;
        b=mxceNwY4+riMUqTbjAwXf1gU6afd1Dg48hRM2HfKMYMuBDBhrZiK3zoviWPEVT7inB
         kIYPJHMyZXLpSTVeXSZ7udZESMpVlko4zp79nQS8h9aGW0GExNVHVk6KLDXoTqsGXFBT
         wSONjaCaT8dT3ZB4T4M7+DOqRBZm3Lm3gRRTaGV4E7EVruzfdcRnnYO6YjmZBt+lPUVe
         beiSKnYymEhSRESqj1qFZX0eO26nB7x0edx1q3EW6Osbv2ZhtteIA0iFGHlWqWc5gZQB
         +vPghPn9pmmJ2CjvSK+QudSV3x07EhEu+ewI8Cw6HOI8SaXZkhRpMgrEuM3rk08Cktf5
         TMmA==
X-Gm-Message-State: AHQUAubGCd7FZk1YwAX2Pp241qsozhQe6gZuKP1Vi06HO4OYIvBrh6qL
        9qUejKnIEnUZ3xYKn5OWJns=
X-Google-Smtp-Source: AHgI3IY/P/hXdXre809PmhE43M8fQpu8R8sect0WxSto00s76kGFnIEilvHB9ifu2NPRTV/Wnw0GaQ==
X-Received: by 2002:a2e:208a:: with SMTP id g10mr18414940lji.135.1550726743761;
        Wed, 20 Feb 2019 21:25:43 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id z8sm5877940lfg.77.2019.02.20.21.25.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 21:25:42 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] staging: rtlwifi: Use proper enum for return in halmac_parse_psd_data_88xx
Date:   Wed, 20 Feb 2019 22:25:24 -0700
Message-Id: <20190221052524.16064-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/staging/rtlwifi/halmac/halmac_88xx/halmac_func_88xx.c:2472:11:
warning: implicit conversion from enumeration type 'enum
halmac_cmd_process_status' to different enumeration type 'enum
halmac_ret_status' [-Wenum-conversion]
                        return HALMAC_CMD_PROCESS_ERROR;
                        ~~~~~~ ^~~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.

Fix this by using the proper enum for allocation failures,
HALMAC_RET_MALLOC_FAIL, which is used in the rest of this file.

Fixes: e4b08e16b7d9 ("staging: r8822be: check kzalloc return or bail")
Link: https://github.com/ClangBuiltLinux/linux/issues/375
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/staging/rtlwifi/halmac/halmac_88xx/halmac_func_88xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtlwifi/halmac/halmac_88xx/halmac_func_88xx.c b/drivers/staging/rtlwifi/halmac/halmac_88xx/halmac_func_88xx.c
index ec742da030db..ddbeff8224ab 100644
--- a/drivers/staging/rtlwifi/halmac/halmac_88xx/halmac_func_88xx.c
+++ b/drivers/staging/rtlwifi/halmac/halmac_88xx/halmac_func_88xx.c
@@ -2469,7 +2469,7 @@ halmac_parse_psd_data_88xx(struct halmac_adapter *halmac_adapter, u8 *c2h_buf,
 	if (!psd_set->data) {
 		psd_set->data = kzalloc(psd_set->data_size, GFP_KERNEL);
 		if (!psd_set->data)
-			return HALMAC_CMD_PROCESS_ERROR;
+			return HALMAC_RET_MALLOC_FAIL;
 	}
 
 	if (segment_id == 0)
-- 
2.21.0.rc1

