Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B45C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F5F32183E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="ormvI/gt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbfBTBx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 20:53:59 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35619 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfBTBx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 20:53:58 -0500
Received: by mail-pg1-f194.google.com with SMTP id s198so11034738pgs.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 17:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=2MFUyXaNVwUpbVgfsPObSuC5Zgm16FtPxEvkQ9zzhF4=;
        b=ormvI/gt2LG8HwC3Lmg3uGqicksm5s+2kmaQawDpQz0oybh9wN6+lV10MVGq0LyzVv
         ZPidlAI+rf7ybQv7L0XzetvvugOM9D3ckEHKpcFJU1bObMuFD24Gcj+NbLiHnQIzJH+n
         CORqc+Hi9KCgtDoXQTCJ1fPVZuvccWn8PkVLAnfGOgEVFUcXbN8oALstcVv4pQpGVUo4
         NttRRtag9JgQf94Xq1fLwphDcKnFphTe+JKNH+tmKZf2VesFFbrHX3YvxYKnnhacut98
         L1JtHFl0r5ev6CGNueoC4k7kTwGUL2UeRDRrkB3YOk9LenaCdki8RaNGkFNRCbLKYers
         8m+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2MFUyXaNVwUpbVgfsPObSuC5Zgm16FtPxEvkQ9zzhF4=;
        b=XH6a+wZ09kBN5pfpULtFsm3LFwNYZTwLxEJ+zrUfrDoYTLEqCKVPMG5KZZECgnuieL
         v77ACkZiH8boOfZEmcLS/rEE1ZqHOimYO/A2jMvM0hXqisqdlT/N/TkYHXNj6id3Z+T6
         9//k3EP24tBNOsSBlQmtFfKdpAWdRRHpw11Y2W01JDZqvJTq4f5Y9SjGfZyJZV/fI79e
         zQRom6bh1dD51GWTsFM6PG+xnw8fLUpscxOk5BGEcQJ2r7NC/rTAJpqQkfCcv01xsxTr
         7SwnSaGSKZxPK5QJzFOfncJ9XsmrTqPNgSvyxKY3PFqwCazBNcBmCszVqKBpIVnrZVdS
         wt2w==
X-Gm-Message-State: AHQUAuZtuxUcZttAlBta9j84X07XmomkC7CMmGqTJc00a4P4KaeHZumi
        5PdN6q9SlHDYT4liIeRZZKIPkA==
X-Google-Smtp-Source: AHgI3IZYrxQktEckwWbBESYqRrSPMb2l9Q21f65SPubFEw1fys+9gaAjsaOfdJ2TiEwKGlSe7Lr/yA==
X-Received: by 2002:a63:2013:: with SMTP id g19mr26761862pgg.451.1550627637893;
        Tue, 19 Feb 2019 17:53:57 -0800 (PST)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id k7sm5605296pgr.28.2019.02.19.17.53.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 17:53:56 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Zhang <markz@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [RESEND][PATCH 1/2] regulator: max77620: Add missing .owner field in regulator_desc
Date:   Wed, 20 Feb 2019 09:53:27 +0800
Message-Id: <20190220015328.30158-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing .owner field in regulator_desc, which is used for refcounting.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
This patch was sent on https://lkml.org/lkml/2019/1/30/466

 drivers/regulator/max77620-regulator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/max77620-regulator.c b/drivers/regulator/max77620-regulator.c
index cd93cf53e23c..1607ac673e44 100644
--- a/drivers/regulator/max77620-regulator.c
+++ b/drivers/regulator/max77620-regulator.c
@@ -690,6 +690,7 @@ static const struct regulator_ops max77620_regulator_ops = {
 			.active_discharge_mask = MAX77620_SD_CFG1_ADE_MASK, \
 			.active_discharge_reg = MAX77620_REG_##_id##_CFG, \
 			.type = REGULATOR_VOLTAGE,			\
+			.owner = THIS_MODULE,				\
 		},							\
 	}
 
@@ -721,6 +722,7 @@ static const struct regulator_ops max77620_regulator_ops = {
 			.active_discharge_mask = MAX77620_LDO_CFG2_ADE_MASK, \
 			.active_discharge_reg = MAX77620_REG_##_id##_CFG2, \
 			.type = REGULATOR_VOLTAGE,			\
+			.owner = THIS_MODULE,				\
 		},							\
 	}
 
-- 
2.17.1

