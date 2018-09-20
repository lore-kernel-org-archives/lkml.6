Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66FEECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B2D720877
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZvkkoiz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B2D720877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388408AbeIUCHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 22:07:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40744 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbeIUCHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 22:07:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id y8-v6so7025172wrh.7;
        Thu, 20 Sep 2018 13:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SqzKHEqvA36uyo/iuQtSZeARJdZnP1O1M9MSbuboYRo=;
        b=TZvkkoizf2OuWGCHVdAnPXyansbvQdLJEuc+NSFZ4NslfCCdAY1kuO4OaFUVnWkD6P
         bWxi92OR6TDNb3w/a4Xsj4vMNKjxq2af9iEtzzWMNK1w5ZWZv5Ln/4fuYaUB7bkZEYVl
         jLL6iVzKrt12yodNwTAKTluveAhpTC0nmY2Pf199DxvtxMHoYZzvCtzsDSfmWFq738xy
         /tDChwa941Pwebv4JHb131FEiZJjNDABsO6FXa1zoOiUXt8XzGgk/8yIDT2vRGYvunrE
         XaFRRaKZeVVzrf+h7O8yh0QSUXvhRK2nVEErgY1WKqKOcejgsIW1ZqAQkhWUpd8rBYyT
         +5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SqzKHEqvA36uyo/iuQtSZeARJdZnP1O1M9MSbuboYRo=;
        b=MuqGEDW3O6xF0t0tDMMI2k9aZswfF5i8FNnI/yhk334dMIn6ib95trDWysPoUmllUa
         G9CdyJy3cXextuvrZWU+l+I1O57a3lebemroIZurAzlt67vrpaTZUFOy4QbxQOIYlBsw
         n9v+7ole/6Bi/kuczVLkd1blNkyGD7lNVobbLhcOR6Moac/VDpyMc7lV9Nd3vCiI+SK/
         D0p0fWOahcY3V0p5HN/9q07kYYiI8u9AjIs9u53R4IaYIaOMHW8HuexOyiYktQZdawI9
         xuxZiTZA2Dkz55lkfRLRDk0Fa3msJFiaKxQER7ct7lI+7SUQxS9EKNgJyeEQskWUOVxY
         1+rQ==
X-Gm-Message-State: APzg51D8+k7OaUfhL72z0SLR8A+t5+kDfLKuhwiPZsWAwNYm0k1HBVZQ
        iMqDMMArrcPZJQVFchAoLOQ=
X-Google-Smtp-Source: ANB0VdYaINmWhhQu2Uq6KOCRz0eh++07cvRevqZ2+bG3Kn0JXFTz8qOA0uR8P0J5drmT6BKuRSNRSw==
X-Received: by 2002:a5d:51cf:: with SMTP id n15-v6mr36755077wrv.107.1537474947308;
        Thu, 20 Sep 2018 13:22:27 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id a10-v6sm3337597wrs.24.2018.09.20.13.22.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 13:22:26 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Thomas Winischhofer <thomas@winischhofer.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] video: fbdev: sis: Remove unnecessary parentheses and commented code
Date:   Thu, 20 Sep 2018 13:22:17 -0700
Message-Id: <20180920202217.27304-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when multiple pairs of parentheses are used for a single
conditional statement.

drivers/video/fbdev/sis/init301.c:851:42: warning: equality comparison
with extraneous parentheses [-Wparentheses-equality]
      } else if((SiS_Pr->SiS_IF_DEF_LVDS == 1) /* ||
                 ~~~~~~~~~~~~~~~~~~~~~~~~^~~~
drivers/video/fbdev/sis/init301.c:851:42: note: remove extraneous
parentheses around the comparison to silence this warning
      } else if((SiS_Pr->SiS_IF_DEF_LVDS == 1) /* ||
                ~                        ^   ~
drivers/video/fbdev/sis/init301.c:851:42: note: use '=' to turn this
equality comparison into an assignment
      } else if((SiS_Pr->SiS_IF_DEF_LVDS == 1) /* ||
                                         ^~
                                         =
1 warning generated.

Remove the parentheses and while we're at it, clean up the commented
code, which has been here since the beginning of git history.

Link: https://github.com/ClangBuiltLinux/linux/issues/118
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/video/fbdev/sis/init301.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/sis/init301.c b/drivers/video/fbdev/sis/init301.c
index 27a2b72e50e8..a8fb41f1a258 100644
--- a/drivers/video/fbdev/sis/init301.c
+++ b/drivers/video/fbdev/sis/init301.c
@@ -848,9 +848,7 @@ SiS_PanelDelay(struct SiS_Private *SiS_Pr, unsigned short DelayTime)
 	    SiS_DDC2Delay(SiS_Pr, 0x4000);
 	 }
 
-      } else if((SiS_Pr->SiS_IF_DEF_LVDS == 1) /* ||
-	 (SiS_Pr->SiS_CustomT == CUT_COMPAQ1280) ||
-	 (SiS_Pr->SiS_CustomT == CUT_CLEVO1400) */ ) {			/* 315 series, LVDS; Special */
+      } else if (SiS_Pr->SiS_IF_DEF_LVDS == 1) {			/* 315 series, LVDS; Special */
 
 	 if(SiS_Pr->SiS_IF_DEF_CH70xx == 0) {
 	    PanelID = SiS_GetReg(SiS_Pr->SiS_P3d4,0x36);
-- 
2.19.0

