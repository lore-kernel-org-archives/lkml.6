Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2AAC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C332218A4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/ipU0D+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbeLRSgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 13:36:38 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37246 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbeLRSfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 13:35:13 -0500
Received: by mail-wm1-f65.google.com with SMTP id g67so3831574wmd.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 10:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lXKvYqDiCTnbhASDoHeDxA51xrNsPmZznJSXszxhCF8=;
        b=S/ipU0D+bcexkwK6neHYZI8e7qEx+CK49gI7rcnMBuGvjvyNPqxUj7pr7QtBneGAm/
         FQ5biXkM8b1/4owhmG/bW+UE4MtWVOeJgdfF+IeU+Y3Uo6rsATQvQ448G5n7lw0//uGi
         xLi27X0guodzq0oWMyz/p6QC/oUQqwt2yPa4qEJe1Ku5mhXNiLV2Z6o8gmMpSquYmMX5
         XiIWY51r7RPL6r2f/hxcfLrzPH3YdcjC1oeszIohNW7iHnB+XVk7M7+20l9+QPQysNww
         gDdEX7FGSraRH7uW7pBcAcSBIawJzmFzClRmbS3+JpZ67KoD7Bsb4v3aMOKTr0yxMbiK
         kU1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lXKvYqDiCTnbhASDoHeDxA51xrNsPmZznJSXszxhCF8=;
        b=cOTkI/LTQIqdap12d0vCrsUZwN9oT5wuoN34o6iCUW1znwIiffwt221DozHZYMN5hF
         J3HHXo+PZVPGFXRPvLv+5/JAtjoRjo5IdB3GR+b8t/XM7G1V3EzwYPudtWSW1j/rxyE1
         Lf6rwOBMMo5dbujR7TkxBt+Ms2cVQaqcFmwGxS8UK3Fd+lFpf7RFE9LYU99H7oGcpqH+
         JmO7bc9eK8REHffGKj2R/lyVZQk1zPhoYYKLg5SbmPidv4fOxfGQX7dD6EtVLJK4Nmv+
         nTtrA0pgwxbgFQFMpuPBobK12zuyl6/3KCzfkVPUwEcKYzFJCwQk+JWngedRXVRt62EN
         Efuw==
X-Gm-Message-State: AA+aEWZoQqLjecgVQZV6MpEaPaL4PqMkuVspGjSRvSpP8W0vHi6C8LW6
        qPqdZdModPxkpXAJzKQUQqM=
X-Google-Smtp-Source: AFSGD/UvDYmsTON/xpdp98JepWNuVKiBrsYDIOVLR9atXKA1jbTWl8+LQaYjUrR10Zyms9/bnF+BeQ==
X-Received: by 2002:a1c:68d7:: with SMTP id d206mr4077291wmc.43.1545158111368;
        Tue, 18 Dec 2018 10:35:11 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id 202sm3614535wmt.8.2018.12.18.10.35.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 10:35:10 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 04/17] staging: rtl8188eu: remove blank lines between declarations
Date:   Tue, 18 Dec 2018 19:34:38 +0100
Message-Id: <20181218183451.18692-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218183451.18692-1-straube.linux@gmail.com>
References: <20181218183451.18692-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove blank lines between declarations in rtw_mlme_ext.c.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index f2eb63634972..813f5d9e550d 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -1868,7 +1868,6 @@ unsigned int send_beacon(struct adapter *padapter)
 	u8 bxmitok = false;
 	int issue = 0;
 	int poll = 0;
-
 	unsigned long start = jiffies;
 
 	rtw_hal_set_hwreg(padapter, HW_VAR_BCN_VALID, NULL);
@@ -5303,7 +5302,6 @@ u8 add_ba_hdl(struct adapter *padapter, unsigned char *pbuf)
 	struct addBaReq_parm *pparm = (struct addBaReq_parm *)pbuf;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
-
 	struct sta_info *psta = rtw_get_stainfo(&padapter->stapriv, pparm->addr);
 
 	if (!psta)
-- 
2.20.1

