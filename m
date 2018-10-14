Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC89C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 10:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21BED20835
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 10:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+gzdbDF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21BED20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbeJNR6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 13:58:33 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44161 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbeJNR6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 13:58:33 -0400
Received: by mail-ed1-f67.google.com with SMTP id z21-v6so15148737edb.11
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 03:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0z79ZW5oynPD2wqMDk12MsY4RYXeEiTZW4iP/CQUXBk=;
        b=Q+gzdbDFBM72c1NmfE5BCL1vyHC2co3GldsuN4MkRo8Vya5oZfklEUVY44Q4AJEU82
         hyHVLsf/VXvEmkosZdAnBXlku6hKuMLVGjXTTH4+X1HmVeAENp6207k40QLTB4s5qFAx
         n3q+A083vaGuum9pha1AV7anBPGlB/aMD6wBgreGaFqid+cBlCKrdz/XHXftWK4cp3V9
         UgsSG1aa56RajhKmdW/gohw7dEI7b2K3xuNWJM2/IL1VRnbRwILtrd81YSc9hXNkvsOv
         uHU0KRE9/+RBBt0wrp6K7KiLTUmNlROIBdOT8GUjkNi4mVs2OIzH2u5Wwy6YGfy2yjbT
         v7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0z79ZW5oynPD2wqMDk12MsY4RYXeEiTZW4iP/CQUXBk=;
        b=Z0hp0+kbElrQkYAlRqSRIAYwA8cqzqtd7Xzdz9+3EgZ2U3gsgWP7hXENavyJLfG1J3
         AndIwXAoD0H4Gn0zs4fXhFGLhVyCt6j8oj78QJ1K4Q035AMte8rGBBhl/RL8wzwfq0YQ
         Ib+3cXGiqxGhDBRSOgV+V1VJm0ecdGGB2T5QFhpDXpNlcelBoG1XtLlpXfzYznH99kum
         AngnkKdT2R11q9BNOOyZWdNpBltx1GVA6eHEEwHyErKKCrq3FeGPRklFFntqqdLc6AJ0
         l34Qk9E8pB3N4RT157QfrwOrOfWsuegq//99RMibj5zQhu9LounPNvj9GRKuthII6ojf
         oTqw==
X-Gm-Message-State: ABuFfogGmQfJed0QYZ69qCmSYKFIfl0v5a82uWWxwscIEj0BDNpssW7c
        i73nEI6pKZsc7Hz54xWz1V0nBao8
X-Google-Smtp-Source: ACcGV61T50fJt4founZWNDBaqGeV73Wuqi/NogBw3dBMwbe4aj1XfDH93yJSg/dRHZsOd3SgIkCgXQ==
X-Received: by 2002:a17:906:5e4c:: with SMTP id b12-v6mr14833725eju.52.1539512280829;
        Sun, 14 Oct 2018 03:18:00 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:bc68:3d44:305d:951f])
        by smtp.gmail.com with ESMTPSA id o13-v6sm1475630ejb.34.2018.10.14.03.18.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 03:18:00 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/8] staging: rtl8188eu: rename parameters of HalSetBrateCfg() - style
Date:   Sun, 14 Oct 2018 12:17:36 +0200
Message-Id: <20181014101742.10952-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181014101742.10952-1-straube.linux@gmail.com>
References: <20181014101742.10952-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename parameters of HalSetBrateCfg() in header to avoid CamelCase
and match the names used in the function definition in hal_com.c.
mBratesOS -> brates
BrateCfg -> rate_cfg

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/include/hal_com.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/include/hal_com.h b/drivers/staging/rtl8188eu/include/hal_com.h
index 2e194f7a1352..c966f43aed6e 100644
--- a/drivers/staging/rtl8188eu/include/hal_com.h
+++ b/drivers/staging/rtl8188eu/include/hal_com.h
@@ -148,7 +148,7 @@ u8 hal_com_get_channel_plan(struct adapter *padapter,
 
 u8 MRateToHwRate(u8 rate);
 
-void HalSetBrateCfg(u8 *mBratesOS, u16 *pBrateCfg);
+void HalSetBrateCfg(u8 *brates, u16 *rate_cfg);
 
 bool Hal_MappingOutPipe(struct adapter *pAdapter, u8 NumOutPipe);
 
-- 
2.19.1

