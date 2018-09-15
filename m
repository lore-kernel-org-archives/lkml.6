Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC55ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 06:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC9E208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 06:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ufyoy9fO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EC9E208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbeIOLeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 07:34:10 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53178 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeIOLeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 07:34:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id y139-v6so4020429wmc.2;
        Fri, 14 Sep 2018 23:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eMkoXq8QQfYmvUAadLG6OXr08ZagmHQHSlHiAbSDjFE=;
        b=Ufyoy9fOif/6zVzb0ps3omj55Vpl0reSrCN8GTBTgMuYbiMGAt5eti2FgWR+tnKE3U
         iUmzsiXcoz8C8wflNAUCFQk8brzcsVIVDgNke/poyYx4MhfUEJZrhQJR5//ebsjgiQ60
         2keg5XmN63pqpef/6fghmdnM/vW+LIrAW1HHHSIHUSp0nXf7KE8qzKu/3Rzf/9ciaf9O
         p6+0P0khLvyy927mojDLUu/6blCeEQhQDfxPyRbIk2da0EIgulGYkdp6txhR3cJuUKsC
         6QM2s9zDp18g4RofX/64bBEoGL+gmys/ZgvwNfCgmfZ5fP5e7y9/QpXVGiVy7RPcyIf3
         8DZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eMkoXq8QQfYmvUAadLG6OXr08ZagmHQHSlHiAbSDjFE=;
        b=IUcnVQTATZMH7mfipeJ9ktqdSuiAvCNs/0hGVQ8Yfz589NWkT+vpkzxODgh63ll7cH
         d+x5tCWm21yZyhwYBKa3FwgG4CkEFM/4Wvt2iTseN4JvMhL9t+8MPppcHSlJLPqmQ2EG
         C8sIPesMrdLzeBvE+BOeJGSerNd14FCYxRCabLAFMG+KgMaHpRtf5RfOLrQLcyDguF1f
         9donke1XZ6vartQ6ge3Ol01MkOVs3rYpGPuZqhxR6yas7Ytn3cQA++iIoTNxC5esBOO7
         knxv0+q7+NyYejZgKXhU2R9tne4WmZ9IRj8C+MWbMezerkG9jTpwgblsYjIud16HNS9Z
         UEtw==
X-Gm-Message-State: APzg51Ai0aue3KWdUrm/HleWVV1ZVLetPPIj7/NqN7rH3dXZqeUEf5/3
        hCiTiHx/9NiVK813ZlRB640=
X-Google-Smtp-Source: ANB0VdZpEJFn2hMn6FZaVC/Ng90Ny7iRRBCdKmNoS66uK/LQIdQGjXHAXHElkjLrn0Gf6ZE2dtGiJA==
X-Received: by 2002:a1c:1188:: with SMTP id 130-v6mr4649658wmr.138.1536992179675;
        Fri, 14 Sep 2018 23:16:19 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id t9-v6sm17635426wra.91.2018.09.14.23.16.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 23:16:18 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] media: davinci: Fix implicit enum conversion warning
Date:   Fri, 14 Sep 2018 23:16:15 -0700
Message-Id: <20180915061615.25308-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when one enumerated type is implicitly converted to another.

drivers/media/platform/davinci/vpbe_display.c:524:24: warning: implicit
conversion from enumeration type 'enum osd_v_exp_ratio' to different
enumeration type 'enum osd_h_exp_ratio' [-Wenum-conversion]
                        layer_info->h_exp = V_EXP_6_OVER_5;
                                          ~ ^~~~~~~~~~~~~~
1 warning generated.

This appears to be a copy and paste error judging from the couple of
lines directly above this statement and the way that height is handled
in the if block above this one.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/media/platform/davinci/vpbe_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/davinci/vpbe_display.c b/drivers/media/platform/davinci/vpbe_display.c
index d6bf96ad474c..5c235898af7b 100644
--- a/drivers/media/platform/davinci/vpbe_display.c
+++ b/drivers/media/platform/davinci/vpbe_display.c
@@ -521,7 +521,7 @@ vpbe_disp_calculate_scale_factor(struct vpbe_display *disp_dev,
 		else if (v_scale == 4)
 			layer_info->v_zoom = ZOOM_X4;
 		if (v_exp)
-			layer_info->h_exp = V_EXP_6_OVER_5;
+			layer_info->v_exp = V_EXP_6_OVER_5;
 	} else {
 		/* no scaling, only cropping. Set display area to crop area */
 		cfg->ysize = expected_ysize;
-- 
2.18.0

