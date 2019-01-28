Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B339C282CB
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18B2C21736
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6bNLHKB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfA1Jw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 04:52:28 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36215 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbfA1JwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 04:52:01 -0500
Received: by mail-wm1-f66.google.com with SMTP id p6so13114921wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 01:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ofID1CY/xaOAmY7nXMvuLJinp7l1m/0BDJWGvuIVBd4=;
        b=d6bNLHKBR3CgP9bpO3PfBHPfMgHsnyJa28z/tqUigu1MT/pGRifjGkq7GTu9GJQSiv
         zKtsIUAnal2Ss30qSEW1uf7K9dSl0s+pbg/bp1mwu2VX65W018y/IZvrGxchZ2wUqgM7
         eAxehWTV/gvb+rTkh8NcZ5whP47zgoxIz8dj+vKpXm3FDvkm4XRxbqzZAyz3mfMIDdy8
         5uSEcHVlOMMpLKHuyFyIZVqDq0SYEXXUwa/AxLNrmfwEiwqMoVFEMUWP+X/RD07DPjJq
         aVsVtdNwi0lurHjdAjgPWcrjHfuw3uz/qx153m/ycGwsOMzJEXn2usW7EGrZxgVyB4N5
         RY2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ofID1CY/xaOAmY7nXMvuLJinp7l1m/0BDJWGvuIVBd4=;
        b=n7n6uXnQRDzwQTULzBNZ4cRB0qyPmI69GsMZbfQvH6j2fUOHLwK1Qxfs2Mt8KZeoWR
         +jkNGW6KumDEolHEs76eDVVw7ftlriHpjeO5sgv0lPnifNjILzaH+H2wVm5kMxebWHfg
         J0LxMNGfYnmlxWSG3vJDLtg5Im6j0ZCUbbXRjoEpZwtOPSNc104LWuMltcUI6YiFK+TL
         tNtif2/2TgzddvrTcm7i9BIeuZdIYKOlTz0PDUL5G1Z9c5OKgzv530SrinkvZ8cOqSo/
         YA6hAfVYZaCYywukbyIiN/r2W2VAxQTpeIPW0yaNyfPCJ+yVzyjoFtvw3AWReg1SHOFk
         2aZA==
X-Gm-Message-State: AJcUukd/B/H6qWdg8tGAFXrqhJr4NPoODgtB43VQGBomU5gr6886hr25
        tAe6Xc6mrM6v6Rynpyqy6rg=
X-Google-Smtp-Source: ALg8bN5yF4Gusgnei8eV+OPatSl35VaTHUIa+g7KEQwbaUvdWEOLHvl3lgg2AkKCNrT6Vcx19BNwyA==
X-Received: by 2002:a1c:5f8a:: with SMTP id t132mr16791832wmb.40.1548669120104;
        Mon, 28 Jan 2019 01:52:00 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id a18sm139023711wrp.13.2019.01.28.01.51.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 01:51:59 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/6] staging: rtl8188eu: remove unnecessary initializations
Date:   Mon, 28 Jan 2019 10:51:33 +0100
Message-Id: <20190128095137.26815-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128095137.26815-1-straube.linux@gmail.com>
References: <20190128095137.26815-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The local variables backup_index, backup_counter and backup_time
in rtw_reset_securitypriv() are all asigned before their uses, so
initialization to zero is not necessary.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/os_dep/mlme_linux.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/mlme_linux.c b/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
index 0321f1d45809..cd6298e4920d 100644
--- a/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
@@ -36,9 +36,9 @@ static struct rt_pmkid_list backup_pmkid[NUM_PMKID_CACHE];
 
 void rtw_reset_securitypriv(struct adapter *adapter)
 {
-	u8	backup_index = 0;
-	u8	backup_counter = 0x00;
-	u32	backup_time = 0;
+	u8 backup_index;
+	u8 backup_counter;
+	u32 backup_time;
 
 	if (adapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X) {
 		/* 802.1x
-- 
2.20.1

