Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F65BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1BD320880
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o1+FqzpM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbfBULvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 06:51:42 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43447 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbfBULvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 06:51:39 -0500
Received: by mail-wr1-f68.google.com with SMTP id d17so15258561wre.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 03:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wx2i/jfDJO+MsqeeRGq/80Ty52GwQUpqafbdUgj9Pfs=;
        b=o1+FqzpMJ8Rv7zRFHvU1EVrqyVhUu5yBVk50V2xrv9/ZwI6HXvLMKqBprTAJKcjq2w
         gbvmt38vnKFxtb80ZATzJB/WPn6ycly8dRteRTbE82/INQY0N8ReUOKKwuEf8OY30iVw
         NkMPQgk57OmGSW6yfl5iKHZ1bVUTQoguEnUMUy+to1bcFdcskgGlFCVY9+Bw9I6+ZSJ5
         mOLv2exjWAhecWXveY+9+/OvUFsLekd02UbT6lp0gFj/zPZVFXaZpZCtXykq7e0Xg5RH
         3XBRe+1wxiqwwWEJgw027H7ZkNUPixowSO9oPjDQeTh7TdALcv7MjcdmLcxiaIHVY/b+
         m8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wx2i/jfDJO+MsqeeRGq/80Ty52GwQUpqafbdUgj9Pfs=;
        b=ulp98y8yVvu9TbpP2qMwAXHbeb1LH9wGIOgyFB64J8KYdDDksSPX0lItMdWdnRQvio
         OpRksLnXKq9ri4XPnV8L8m6jyPxFZS8t1ihQKqL3HFqscyQihgtqzqXXvjmdjIdzBzo3
         PbpqayPYw0NmWQA6gq7GfudMOeaH6RqGEgJe7h/S4QpiV8/u17IOBTfOmG1IsjcEF9iE
         j72Js8zdtzxmV2dMjgUXk9RTx6Pd0UhCeHG9UM1Qx7YMpO3cOYdF0kIJ5A6jXRX9hQf5
         3DyaurPf9epNYHeHjyRHpnuDM3BDeVFjThvX097KlyJ0JO6Xx721hhXGGye7fMiTuWVS
         HH8A==
X-Gm-Message-State: AHQUAuZ325Hrmrzm6utFHowNaRNQeoohTw5b1d8aA/lmvYyZDCCOgvLH
        /FkRuLjyBBpVvkwp66p6UYk=
X-Google-Smtp-Source: AHgI3IYLwuOssV6G0SZc6KOJPqje3kofhuGAJq/XOE0JAutD0LvGdQIZjA8gyFgeUGteV0gi1I2ZXw==
X-Received: by 2002:a5d:654d:: with SMTP id z13mr27322470wrv.270.1550749898106;
        Thu, 21 Feb 2019 03:51:38 -0800 (PST)
Received: from localhost.localdomain (ip5f5abba0.dynamic.kabel-deutschland.de. [95.90.187.160])
        by smtp.gmail.com with ESMTPSA id j5sm15092849wrw.59.2019.02.21.03.51.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 03:51:37 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/6] staging: rtl8188eu: remove blank line between declarations
Date:   Thu, 21 Feb 2019 12:50:54 +0100
Message-Id: <20190221115057.31207-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221115057.31207-1-straube.linux@gmail.com>
References: <20190221115057.31207-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary blank line between declarations.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c b/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c
index 8d96227b85f6..dcc2445a8988 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c
@@ -118,7 +118,6 @@ static s32 FillH2CCmd_88E(struct adapter *adapt, u8 ElementID, u32 CmdLen, u8 *p
 void rtw_hal_add_ra_tid(struct adapter *pAdapter, u32 bitmap, u8 arg, u8 rssi_level)
 {
 	struct odm_dm_struct *odmpriv = &pAdapter->HalData->odmpriv;
-
 	u8 macid, init_rate, raid, shortGIrate = false;
 
 	macid = arg&0x1f;
-- 
2.20.1

