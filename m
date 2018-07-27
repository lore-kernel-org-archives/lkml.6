Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F752C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 23:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A9020857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 23:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="serOR6G0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33A9020857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389415AbeG1Aw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 20:52:57 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50183 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389334AbeG1Aw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 20:52:57 -0400
Received: by mail-wm0-f68.google.com with SMTP id s12-v6so6866928wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 16:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oEt/y9gqciYodrqMCHbDn0tWVDXYV921GuE9yOAzCFE=;
        b=serOR6G0kiy/Z0iLY8jZlEhi+pjEUnleegInsQNIA74iRsSPcPXJciQTatGC7ntERd
         UorNBw8NIwjtMyPRpUV9nOKjKhAlSJX67OpxYGX9FL/MXF/awZPMuwK5ZM5pCDf26pZ4
         eQGgTXsX+VD6dMSkTqMrihsla7gS/Zldeh8RidMwpzJ5dDSeJJggN6icwlDOGNk4OUcN
         WK8XF7ricGEXh9671VijdgZhbRVc/YUJThi7/swm09DRMOVlykWH+bUPxgv9ZZsJUPcK
         B5THEwJDnY6zfmn9+8YaWeaVSYCEbUatXGb1kE+xzpzvLSxPNp4ZhvHgh9BfS308Bdaw
         6nlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oEt/y9gqciYodrqMCHbDn0tWVDXYV921GuE9yOAzCFE=;
        b=DnJh1em6US64LPAJL9roM/gw1nnL1ErjBevkMpLwjgJWUO2d44nQ6+lMTf19Zl9p59
         NSlDmGKQOS+nV2v+0qo2omPf+e5VbKMQerm5RHcVY9g5JRRguN05TfdOWnM4NMcFna5k
         90ZVfryUm4XBak1P1WWrj2ex8POmDCeBgxYEm1f3o9vEaeo0+tRRQMVR6MAwqPhRicai
         lzCWZjQRzMaqKzrj0vVoLaPQVxHQ0PLBBFrAGEByiMQ5YQtlU/niVgdB1fUPlGVKPmwH
         CTLONOo7XkdOo3fW5WlMBEo3sMSg4/xvyjTqxn3V1PMFKzTPPcPxBkYDlOwxyl2d7j2v
         Dy3A==
X-Gm-Message-State: AOUpUlHAV8EHxRIAp0kNtmXBwQz4vuukcIzGzDF0l6rXhnKCefN1bpZ5
        zEQ112Xdwyx9dV7efe6GwB4OMzkubkU=
X-Google-Smtp-Source: AAOMgpdAG5m6djdV3BhjBfkvPvPVIZMGmL+U3Rp58KS2RpuGH2woDS/iPIfeq/IrJkw7HjveZNdzvg==
X-Received: by 2002:a1c:1004:: with SMTP id 4-v6mr5992207wmq.68.1532734127583;
        Fri, 27 Jul 2018 16:28:47 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id m13-v6sm7313217wru.93.2018.07.27.16.28.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 16:28:46 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 10/10] staging:rtl8192u: Refactor enum DM_CCK_Rx_Path_Method - Style
Date:   Sat, 28 Jul 2018 00:28:26 +0100
Message-Id: <20180727232826.28014-11-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727232826.28014-1-johnfwhitmore@gmail.com>
References: <20180727232826.28014-1-johnfwhitmore@gmail.com>
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
The name of the type has been changed to dm_cck_rx_path_method to clear
the checkpatch issue with CamelCase naming. And the enumerated constant
CCK_Rx_Version_MAX has been removed, since it is never used in code.

The changes are all coding style in nature and so should have no
impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_dm.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_dm.h b/drivers/staging/rtl8192u/r8192U_dm.h
index 2aef330379cb..42effcec5277 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.h
+++ b/drivers/staging/rtl8192u/r8192U_dm.h
@@ -126,10 +126,15 @@ struct dig {
 	long		rssi_val;
 };
 
+enum dm_cck_rx_path_method {
+	CCK_Rx_Version_1 = 0,
+	CCK_Rx_Version_2 = 1,
+};
+
 struct dynamic_rx_path_sel {
 	u8		Enable;
 	u8		DbgMode;
-	u8		cck_method;
+	enum dm_cck_rx_path_method		cck_method;
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

