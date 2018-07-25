Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70DCC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C80205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFSTeeUq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99C80205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730471AbeGYUv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 16:51:27 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53205 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729213AbeGYUv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 16:51:26 -0400
Received: by mail-wm0-f67.google.com with SMTP id o11-v6so7140310wmh.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 12:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JTbcJMIiu9zOEKn72f4f6I/MkVpWPVhWtwgZ3SK+t4Y=;
        b=iFSTeeUqmkdkrk1ExhV/q9p0pd9jROnJ91Q9Ym8jU8JyvZ0onIdGPwSCt0n7ccyFjH
         kWu/65Hp37kJE5+subJ6L9Nnkqj8UceVombicdrneQtLJcDEhWcEqw8eb25k06pprc6h
         KME95QZqqFmbMX96McHEVBrAtuTFus5vyJ8y22zZ0Rhx+ltYaSmi3gGE4XslbKsfNtmy
         c5aLeFibnZeyoYTd0wob+0K3jfeovZqb++IWPwqJJ5+uFB6B67A/eooR4ucWE0JN74Zc
         /lvRf46s0HJlC8j/A2q32NJxPhMpXXPniBkAHytgv7HJ2dufsNbBzI8HfKP4e+MAi20f
         XPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JTbcJMIiu9zOEKn72f4f6I/MkVpWPVhWtwgZ3SK+t4Y=;
        b=sObi2H898OEv6Mq/VEpxw9AIc08y086uuHZMQMXKWDzEJDEvLS/WbP+lvwtALgmarL
         xWvszSkB8baRbv1Tfo4KQff/R4ZgGPx2ykAFwrRqTGguZGfwwBvM1MdEK3MIkWCoqKP3
         ZkAt9jfld2zRv9E0Kf/yf0Tw5RzwVGunh50koZr93jGo2JK8265ki33PpMnwdsAvMqNS
         aPqxeByvWelGRmbXi9glDKcKSmk1zWX44gMVM/+PFkh15/46a7hy7dO0NkB1O8KEdK0k
         u6kvXyAd3YaHAlPA+coUa3M+1+UpwmBiMbvMtG3mxKrg1EN3upqxwl0CZVDYsm5Uu2Sv
         Lw5g==
X-Gm-Message-State: AOUpUlEAFY+aGRk2cqku7fPbX0cUOQagf4L5mhQtk/ZIDl3nGQeyb3CV
        UB2F1bV85oYWmbfgFarIhoA=
X-Google-Smtp-Source: AAOMgpesn9jQ1t/ZRK8BhPHMkn/2RQ7MqiX6g9uXFAjHNHGorm6I2+xrTIDFrTtPEWAe+uKlEWYuzg==
X-Received: by 2002:a1c:8f50:: with SMTP id r77-v6mr5687898wmd.44.1532547499104;
        Wed, 25 Jul 2018 12:38:19 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id t186-v6sm3752729wmf.14.2018.07.25.12.38.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 12:38:18 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/4] staging: rtl8188eu: remove unused ODM_RASupport_Init()
Date:   Wed, 25 Jul 2018 21:37:55 +0200
Message-Id: <20180725193758.1219-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function ODM_RASupport_Init() is never used, so remove it.
Discovered by cppcheck.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/hal8188e_rate_adaptive.c | 10 ----------
 .../staging/rtl8188eu/include/hal8188e_rate_adaptive.h |  2 --
 2 files changed, 12 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/hal8188e_rate_adaptive.c b/drivers/staging/rtl8188eu/hal/hal8188e_rate_adaptive.c
index bbb981c6bcec..464c11710398 100644
--- a/drivers/staging/rtl8188eu/hal/hal8188e_rate_adaptive.c
+++ b/drivers/staging/rtl8188eu/hal/hal8188e_rate_adaptive.c
@@ -542,16 +542,6 @@ odm_RATxRPTTimerSetting(
 	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE, (" <===== odm_RATxRPTTimerSetting()\n"));
 }
 
-void
-ODM_RASupport_Init(
-		struct odm_dm_struct *dm_odm
-	)
-{
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD, ("=====>ODM_RASupport_Init()\n"));
-
-	dm_odm->RaSupport88E = true;
-}
-
 int ODM_RAInfo_Init(struct odm_dm_struct *dm_odm, u8 macid)
 {
 	struct odm_ra_info *pRaInfo = &dm_odm->RAInfo[macid];
diff --git a/drivers/staging/rtl8188eu/include/hal8188e_rate_adaptive.h b/drivers/staging/rtl8188eu/include/hal8188e_rate_adaptive.h
index 96ebda93b4ee..5b59c25e4c8a 100644
--- a/drivers/staging/rtl8188eu/include/hal8188e_rate_adaptive.h
+++ b/drivers/staging/rtl8188eu/include/hal8188e_rate_adaptive.h
@@ -49,8 +49,6 @@
 
 /*  End rate adaptive define */
 
-void ODM_RASupport_Init(struct odm_dm_struct *dm_odm);
-
 int ODM_RAInfo_Init_all(struct odm_dm_struct *dm_odm);
 
 int ODM_RAInfo_Init(struct odm_dm_struct *dm_odm, u8 MacID);
-- 
2.18.0

