Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D346DC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 19:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC73208B3
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 19:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tCa4z0Q0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DC73208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbeJAC17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 22:27:59 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51786 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728538AbeJAC16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 22:27:58 -0400
Received: by mail-wm1-f67.google.com with SMTP id y25-v6so6625989wmi.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 12:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VIYMZGp+qbPwmQ7BP2V/Lu/n6rwo07APGk8OiEHB7Lc=;
        b=tCa4z0Q0+lok3jB5UkMjmu+xLrgn45zJHnXwTcegGPdHnB4TtfFgAjtozQSNFkbI1e
         SMURLeD/uKGTNBkF9CpDgT/yrsHheLOVnkTllwfyMOSg5IupUFKMEkKU6b+GOVoV42LA
         mh7ndHSKki5HhdhOi8y57Irfxwcwe3qgNo+jKMWWP2S/siyEKrJZ0ZrufVWP1KTYPa0U
         GQfzJXCX5n7Dn4LJMFMm1InZcxQXZIjrZCPIFOxmloHOZsA89Xhod+ffdTM6r1RTyLEl
         aRpzDNexij8AuYtsP651/x4A+LH8kfczvvuoBIIG1QiAfJSJ0awOsSPWWdw+eepFBA47
         fArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VIYMZGp+qbPwmQ7BP2V/Lu/n6rwo07APGk8OiEHB7Lc=;
        b=qAU/xhmdWj7KuplbwKWJcRdwOKDycAqqZ5eRi5kCo1wBdlv/vb/x2skry19QmvUsuG
         ztvZZN5m6+lGx0h//cupOJEjM3LxMQ4U2nTkutdnYTr+Y0Kv1r3vWrrICImnrsbCKDfx
         tO+iAC8umKa/vkJuSeEGSD4rqXswxfyeJn8+ac3+scBbG8IDlMUQ4lP6AIOy3DtEnq/5
         6+FkzrLy7MFdZ+Z/PxLoxDiquZmx9LQww/9DWx+dxCgXiqIfzhcz/IFAhP18CiHJZ4y1
         dmJ7UBzEPNlbxFYB5nhQB+U+Z74leM6fo+xE3lyMNiPLkDnD1ki3IG1lT2uHz2rgNXs6
         58lg==
X-Gm-Message-State: ABuFfojxLIJ5S5L67yMTuF2d0LqBYJBVTZU8yUN3lNGij3RLWW7cOtjq
        d1OuYd/xs8CO1Zj7jJCB6xE6GNLt
X-Google-Smtp-Source: ACcGV60fwdmH4RlIi8DpmV/Zk5PT5aZEylHpuC+2hkv2xeppQUMysIz60fFL9lT41Qo2D8wyUW4oHg==
X-Received: by 2002:a1c:a386:: with SMTP id m128-v6mr6697181wme.139.1538337217832;
        Sun, 30 Sep 2018 12:53:37 -0700 (PDT)
Received: from localhost.localdomain (ip1f12fd19.dynamic.kabel-deutschland.de. [31.18.253.25])
        by smtp.gmail.com with ESMTPSA id w26-v6sm6500775wmi.27.2018.09.30.12.53.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 12:53:37 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 19/19] staging: rtl8188eu: fix spelling mistake in comment
Date:   Sun, 30 Sep 2018 21:53:10 +0200
Message-Id: <20180930195310.1531-19-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930195310.1531-1-straube.linux@gmail.com>
References: <20180930195310.1531-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a spelling mistake reported by checkpatch.
Caculate -> Calculate

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/odm_rtl8188e.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/hal/odm_rtl8188e.c b/drivers/staging/rtl8188eu/hal/odm_rtl8188e.c
index 9f674bac3b96..3fb0ed604e3e 100644
--- a/drivers/staging/rtl8188eu/hal/odm_rtl8188e.c
+++ b/drivers/staging/rtl8188eu/hal/odm_rtl8188e.c
@@ -272,7 +272,7 @@ static void rtl88eu_dm_hw_ant_div(struct odm_dm_struct *dm_odm)
 	for (i = 0; i < ODM_ASSOCIATE_ENTRY_NUM; i++) {
 		entry = dm_odm->pODM_StaInfo[i];
 		if (IS_STA_VALID(entry)) {
-			/* 2 Caculate RSSI per Antenna */
+			/* 2 Calculate RSSI per Antenna */
 			main_rssi = (dm_fat_tbl->MainAnt_Cnt[i] != 0) ?
 				     (dm_fat_tbl->MainAnt_Sum[i]/dm_fat_tbl->MainAnt_Cnt[i]) : 0;
 			aux_rssi = (dm_fat_tbl->AuxAnt_Cnt[i] != 0) ?
-- 
2.19.0

