Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41299C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 18:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECCB323F82
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 18:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="urLoIto0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECCB323F82
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751906AbeF3SO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 14:14:56 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38103 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbeF3SOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 14:14:55 -0400
Received: by mail-wr0-f195.google.com with SMTP id w16-v6so3958835wrn.5
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 11:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IMThJfh47vuGDFl3xO3xexhFsOG2i4jENAtNY12/O84=;
        b=urLoIto02RgexeD8J+AXBdonev4hQdDKNzUtYxXHTPKG0jCDkPWgHymfYEHnHPHSRa
         M0rPLZ3YH9/hJdIRPiNd3Lqay+PDRlQCqKEWeMRSRUlnuvzMd1fvcm601YnL3/Bmv/U1
         YHRrL4IGpPxzZV6L91ma5H36R9QFLYkkfXxs/SsFK3NbUuwPOxxwY6AkkU/r5rRz8Rtk
         w48q1SB7m1hVKtAa4yQHTyV0OqQYsR0Tw3n1lT5zz+CBL0z8k1lae9NDkuVdeqJ4jmyC
         RB8Rv6ZcRc0OaqhFJ/MpLLuuJGRokFpqdYQFBglMBD8UDguD0K8afDFUnXZeWqbeJ8Vk
         OTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IMThJfh47vuGDFl3xO3xexhFsOG2i4jENAtNY12/O84=;
        b=Fk8pqi6Mf6Lxj4IK3HDUf6NElXEWw2jVPqFUJFRueEeimxObBJfTxbNuaGJQOiy7cd
         5a2gJ9NIKR8b2szAYkp9E9JEipb/vYGVpmdzdHTbscDhiZQ+nMN6sGMj1OmJc3ZcZ0m0
         1XN8g3iVUh0DBUiAGKz3U2LFwgqs28AlKh+2pY19J8mZXn6DbWZVzIn+mYYrJlzM1T8D
         xnu/jB7dhaiFFJX+gYHHr3MDRSREH3rfBpzz02lFV1W5CnifAWAWvJHy4mCOqz/5Ysjw
         u+i1Y8HKTk7jFypCwiynObd61EHBJHqBj0GsJlWfAZn3EC4ocpuIfUnY3UBKnjS8ep6M
         epZw==
X-Gm-Message-State: APt69E2xRxazf3W3cVnXAZM0AdTuV4qq57Yl/NHyTV2+tRbZPyTSpOMW
        qR4oVr38cZLiJzze8BOWY6A=
X-Google-Smtp-Source: AAOMgpfws9HvGJ6wKf/2mm32MnNhZcHXhvaMYPX+Q45xzQrbFiH2oZIVnnUbDdrOEweGQoGw++GLdA==
X-Received: by 2002:adf:a706:: with SMTP id c6-v6mr15929545wrd.61.1530382494177;
        Sat, 30 Jun 2018 11:14:54 -0700 (PDT)
Received: from arch.localdomain (x4db215a8.dyn.telefonica.de. [77.178.21.168])
        by smtp.gmail.com with ESMTPSA id l78-v6sm9769732wmb.39.2018.06.30.11.14.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 11:14:53 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/3] staging: rtl8188eu: reorder switch cases and remove default break
Date:   Sat, 30 Jun 2018 20:14:38 +0200
Message-Id: <20180630181440.3097-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorder the cases of a switch statement to be in ascending order.
Remove unrequired break from default case.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/hal_com.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/hal_com.c b/drivers/staging/rtl8188eu/hal/hal_com.c
index b91902cdb34c..b2ea3d435af0 100644
--- a/drivers/staging/rtl8188eu/hal/hal_com.c
+++ b/drivers/staging/rtl8188eu/hal/hal_com.c
@@ -264,18 +264,17 @@ bool Hal_MappingOutPipe(struct adapter *adapter, u8 numoutpipe)
 	bool result = true;
 
 	switch (numoutpipe) {
+	case 1:
+		one_out_pipe(adapter);
+		break;
 	case 2:
 		two_out_pipe(adapter, wifi_cfg);
 		break;
 	case 3:
 		three_out_pipe(adapter, wifi_cfg);
 		break;
-	case 1:
-		one_out_pipe(adapter);
-		break;
 	default:
 		result = false;
-		break;
 	}
 	return result;
 }
-- 
2.18.0

