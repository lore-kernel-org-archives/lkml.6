Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B04BC46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A5F820857
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsOXABDm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A5F820857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732041AbeG2Wkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 18:40:39 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35690 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731767AbeG2Wkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 18:40:35 -0400
Received: by mail-wm0-f68.google.com with SMTP id o18-v6so11485904wmc.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 14:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UR0N1HWiWWwjHZ8nhIrp5asAe0+E6+xg4umX+qxGJbo=;
        b=KsOXABDmYAlvyZWHHoSRvlo7GmjQcM+rOwPgZjJkWO1n/wcELEsbhrW1V1h4vjvMEZ
         l4Cc7TiQro7z70PdrIEsAKZI3C8iJ2koJbOroneddlNwZAYH80vSNSK4sT7qtXRbzZ/g
         RBdnTLCB2dgpJ6FSRA4XESf5FZFeEDHkcVmxfbTNlSqCnyu+4eGzFMc2AsucVYV1hWLh
         y96Yw5VY6E9QL7tCcv4mLdHxuIPCw9mU/Pm2wld0xEUEaCLccDxOSJn78g/Uj0bWIbt/
         3kX3451jonpoBX3oUcqlBriJlWjnPPszgBSQ3JlM5OrDElbZMp458ZwFv4aJb9MDbvGi
         lj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UR0N1HWiWWwjHZ8nhIrp5asAe0+E6+xg4umX+qxGJbo=;
        b=kx19NYLPW+BhMbiwhtj79VjSzQIQ8MwXIDZzOZjC1GHemMqmQby59j3DWbT2UzmgqK
         K2xkQDx6jrYlcE/sbSRKQGhL3a+BNgeYndmRHEvwM0Vj1AJf6OLY1mU3XlIIyNqRTtMK
         Vg0mMVnxBrjYeNvnqRWov22JqeEdNrNNBA5CF36xlbODHh3HFH1KlDU4YZxq6D8irDOC
         kyoDIwjMi82Cm7DwyFqTt+oQdt7B68iS3cMACkknvHb1gdhUkI/dUi7Lel5SR1xhnOvX
         8/qajD276vXdGMloy4hcMFLFsTv+by0VGZ4BDlzvcb/Ea/sTjA2+s+H5Ie7EELhO36mF
         kHMw==
X-Gm-Message-State: AOUpUlFB4YLSWFrF2XCyoVOfkQnA4If4wW5n/zD+tuZxu9NDSM++6QUr
        nCESnjdiz/b2+6SieCDLL+A+eLjOLF8=
X-Google-Smtp-Source: AAOMgpfGNm6NZIg26wegXQMSbNjicfbcT4rpcIhuGxIl/zcW5ZDnqJzlkpbiIxJnA0bWqsdW04T6Mg==
X-Received: by 2002:a1c:1ad0:: with SMTP id a199-v6mr12679578wma.131.1532898522944;
        Sun, 29 Jul 2018 14:08:42 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id d26-v6sm9264532wmb.15.2018.07.29.14.08.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 14:08:42 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 15/15] staging:rtl8192u: Refactor enum DM_CCK_Rx_Path_Method - Style
Date:   Sun, 29 Jul 2018 22:07:47 +0100
Message-Id: <20180729210747.10803-16-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180729210747.10803-1-johnfwhitmore@gmail.com>
References: <20180729210747.10803-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enumerated type DM_CCK_Rx_Path_Method is used as a container for
constant definitions, rather then an enumerated type enabling compiler
type checking. To correct this, the variable which uses the constants,
defined by the enumeration, has had its type changed from a u8 to the
enumeration.

Additionally the type has been moved above the structure where the type
is used, to avoid compiler error. The typedef has been removed from the
enumerated type to clear the checkpatch issue with defining new types.
The name of the type has been changed to cck_rx_path_method to clear
the checkpatch issue with CamelCase naming. And the enumerated constant
CCK_Rx_Version_MAX has been removed, since it is never used in code.

The changes are all coding style in nature and so should have no
impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_dm.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_dm.h b/drivers/staging/rtl8192u/r8192U_dm.h
index f0e259ddea5d..2ba6a4208870 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.h
+++ b/drivers/staging/rtl8192u/r8192U_dm.h
@@ -126,10 +126,15 @@ struct dig {
 	long		rssi_val;
 };
 
+enum cck_rx_path_method {
+	CCK_Rx_Version_1 = 0,
+	CCK_Rx_Version_2 = 1,
+};
+
 struct dynamic_rx_path_sel {
 	u8		Enable;
 	u8		DbgMode;
-	u8		cck_method;
+	enum cck_rx_path_method		cck_method;
 	u8		cck_Rx_path;
 
 	u8		SS_TH_low;
@@ -142,12 +147,6 @@ struct dynamic_rx_path_sel {
 	long		cck_pwdb_sta[4];
 };
 
-typedef enum tag_CCK_Rx_Path_Method_Definition {
-	CCK_Rx_Version_1 = 0,
-	CCK_Rx_Version_2 = 1,
-	CCK_Rx_Version_MAX
-} DM_CCK_Rx_Path_Method;
-
 typedef enum tag_DM_DbgMode_Definition {
 	DM_DBG_OFF = 0,
 	DM_DBG_ON = 1,
-- 
2.18.0

