Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACC6C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 14:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17830217FE
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 14:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZURRPZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17830217FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730724AbeHDQgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 12:36:49 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44479 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729746AbeHDQgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 12:36:48 -0400
Received: by mail-wr1-f68.google.com with SMTP id r16-v6so8050623wrt.11
        for <linux-kernel@vger.kernel.org>; Sat, 04 Aug 2018 07:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7Ai83h0FYIEYPyHU7GBzsJLN7AcYxnqujgYSUZh20UA=;
        b=XZURRPZNA64sGAww49dkTvmeJdmqpYlMb4ukqa2x4opnda1xbYoiSNjQwWODTgFl6N
         Jy+CBF6TH2e8PjYwJmPZolb4tmrlc9Gg6tE0qnv3bvdpyAuktpVH6H6Z99PooX6iAjAw
         jsvo/1+I7jKubmRGA4r9vO/Om29Cq03XytmZJy8YkyGa3dayOl6c741dzvj0NI1WKY/z
         uOVoZKX2kt5kzDhRXWIxGJWzqN3dxV5xn5JKs71IsfC2wMgZR/uNLevA8uir7KUrNuVD
         iTvQlKqaF0fGskf0yK8dZV47HFeN89OJ08Q5oyNbQf2FNmkOg5/NifYSp0FC8yJS5ICT
         Nesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7Ai83h0FYIEYPyHU7GBzsJLN7AcYxnqujgYSUZh20UA=;
        b=ZuATurSudb3l6Pxnh+08TdZYTU3UafpqlCZ8qocriVfleA9HBuEqz+zqBuAyG/mUVu
         434Y0v1ZyhUlnJ+e5C3mPsXmBbjyAgVmjt9ENhmjBEnUzoanDN3jvPgufPwE8TDQmsyR
         I+TSViym5/bFjXGPWTjzir+znUf3X3OaTM1qGOYYDc7Zew2PVaVT3RGxnCr8rN4cfd1x
         3XP69b5CyCGDBhV5JekrRC98ctbQUsEATJiQ0/GYj7GMYuGrpueWU2bVmNnzFawWW21u
         5EMDHk/tnxbOMN4XCMdflI9kxI58uSVqxpjT7JFHFwCXzSltRbBEC9rLYldEeCWinjZX
         bziw==
X-Gm-Message-State: AOUpUlHzSiNqmwLxvagr7beT8W8awoEhy8+mZAQTauCn/ptxqZc0eV5n
        XwNadjl9cdN+KHl4n3DtgUs=
X-Google-Smtp-Source: AAOMgpfmW4b+bIwaPeq2F9TlhbEFzWNPsBoLT6IXgfdpKehziIQWm/VKu1Cc70gu8dBendG8t/CKyA==
X-Received: by 2002:a5d:52c4:: with SMTP id r4-v6mr4953147wrv.98.1533393353110;
        Sat, 04 Aug 2018 07:35:53 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:8569:71c8:6dba:bb41])
        by smtp.gmail.com with ESMTPSA id x14-v6sm5409149wrv.21.2018.08.04.07.35.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 07:35:52 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/4] staging: rtl8188eu: rename rtw_IOL_applied
Date:   Sat,  4 Aug 2018 16:35:40 +0200
Message-Id: <20180804143543.1500-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename rtw_IOL_applied to be all lowercase.
rtw_IOL_applied -> rtw_iol_applied

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_efuse.c        | 2 +-
 drivers/staging/rtl8188eu/core/rtw_iol.c          | 2 +-
 drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c | 4 ++--
 drivers/staging/rtl8188eu/include/rtw_iol.h       | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_efuse.c b/drivers/staging/rtl8188eu/core/rtw_efuse.c
index b19aa26d1705..0fd306a808c4 100644
--- a/drivers/staging/rtl8188eu/core/rtw_efuse.c
+++ b/drivers/staging/rtl8188eu/core/rtw_efuse.c
@@ -298,7 +298,7 @@ static s32 iol_read_efuse(struct adapter *padapter, u8 txpktbuf_bndy, u16 offset
 
 void efuse_ReadEFuse(struct adapter *Adapter, u8 efuseType, u16 _offset, u16 _size_byte, u8 *pbuf)
 {
-	if (rtw_IOL_applied(Adapter)) {
+	if (rtw_iol_applied(Adapter)) {
 		rtw_hal_power_on(Adapter);
 		iol_mode_enable(Adapter, 1);
 		iol_read_efuse(Adapter, 0, _offset, _size_byte, pbuf);
diff --git a/drivers/staging/rtl8188eu/core/rtw_iol.c b/drivers/staging/rtl8188eu/core/rtw_iol.c
index 6b97e9f2a77b..f7a86eac738e 100644
--- a/drivers/staging/rtl8188eu/core/rtw_iol.c
+++ b/drivers/staging/rtl8188eu/core/rtw_iol.c
@@ -7,7 +7,7 @@
 
 #include <rtw_iol.h>
 
-bool rtw_IOL_applied(struct adapter *adapter)
+bool rtw_iol_applied(struct adapter *adapter)
 {
 	if (adapter->registrypriv.fw_iol == 1)
 		return true;
diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
index 8e7190b98692..607170775fa5 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
@@ -75,7 +75,7 @@ s32 rtl8188e_iol_efuse_patch(struct adapter *padapter)
 	s32	result = _SUCCESS;
 
 	DBG_88E("==> %s\n", __func__);
-	if (rtw_IOL_applied(padapter)) {
+	if (rtw_iol_applied(padapter)) {
 		iol_mode_enable(padapter, 1);
 		result = iol_execute(padapter, CMD_READ_EFUSE_MAP);
 		if (result == _SUCCESS)
@@ -207,7 +207,7 @@ s32 InitLLTTable(struct adapter *padapter, u8 txpktbuf_bndy)
 	u32	i;
 	u32	Last_Entry_Of_TxPktBuf = LAST_ENTRY_OF_TX_PKT_BUFFER;/*  176, 22k */
 
-	if (rtw_IOL_applied(padapter)) {
+	if (rtw_iol_applied(padapter)) {
 		status = iol_InitLLTTable(padapter, txpktbuf_bndy);
 	} else {
 		for (i = 0; i < (txpktbuf_bndy - 1); i++) {
diff --git a/drivers/staging/rtl8188eu/include/rtw_iol.h b/drivers/staging/rtl8188eu/include/rtw_iol.h
index 53f5fe210e7b..f20b35e8d0a2 100644
--- a/drivers/staging/rtl8188eu/include/rtw_iol.h
+++ b/drivers/staging/rtl8188eu/include/rtw_iol.h
@@ -10,6 +10,6 @@
 #include <osdep_service.h>
 #include <drv_types.h>
 
-bool rtw_IOL_applied(struct adapter  *adapter);
+bool rtw_iol_applied(struct adapter *adapter);
 
 #endif /* __RTW_IOL_H_ */
-- 
2.18.0

