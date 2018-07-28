Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3140CC43142
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D65AB20842
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUDrtJDv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D65AB20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731542AbeG2AbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 20:31:17 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34195 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731513AbeG2AbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 20:31:16 -0400
Received: by mail-wm0-f65.google.com with SMTP id l2-v6so5077155wme.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 16:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wlXd15PhfUS8yG4U5TS9F83C/I+YrgCvbVzrdjilPeY=;
        b=fUDrtJDvkt6qFo9w5CeAQ8bKMbwg026Ja3KqKGSHFmtowsW9FhjtOU1BOE+2LdhBLL
         eH6hbLW226v4MgrKk9TcgOGUbIP5Ibi1ORO6/vySHu4lvEOpK80r8hFPHJWDJecZpVvt
         IwwOncQ/2J45o1EC0xVQmRK7UZD3BtROIy6SeaHWmengxU6YnApm1rjjcBSJFdsrJd5F
         gNI3oB520EYGILj9+OwStx9kvADTpGqC2kIMK6vaPy8rRBwheZRq9H0Qpxvi/sqIYHrD
         uNwlyK84GTtQFTlExqpBRQyC24jbfi8mAA8iR8xkq0aJDXJrw9CxJz2rlI0/Ls7/fVhX
         swBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wlXd15PhfUS8yG4U5TS9F83C/I+YrgCvbVzrdjilPeY=;
        b=QnWLLc09FTzI+iaV1IO4531AsvVLdpLy5LhfNaMyXRe4YmIFO8ItvlcAss8kl1G8HR
         dISBII4APTC6XqPa9snItvCMHhN0avy7edhNLEAgE6Qzk/Qqu+NnVU1KAmRuogCdpa0T
         Wt+7biJRlQr7TE92ajK75GwYN6cyRjvlnCI/WQu2HcZBxXKWYCm08yNr8aGbRabW+yYH
         dbcqD1VRzA3M9zvNVk0qTPNKdGL4gtP+4xBhqwEimUxC6gtyDAznoQqTvacpLfqlV5Xr
         nhNgQ1FXjXf0ilSfABWKSCxp99bsksqFIrSIoYuDV86EcecdHW+CUQ6/08XxvJHKkh2e
         mR2g==
X-Gm-Message-State: AOUpUlF8UYND997a5mi6Wb2wv7XKHuT1jxDFoAu3/ZsDmbp45TY4Ug1p
        USKYFCM3zjssviFdpu7+7y11hj1x
X-Google-Smtp-Source: AAOMgpcOQyQXhkIqriuJ+brcDl8TbL2MSppxaI7rupuJDye4fJkTfpqgGD2gcGGWo01/BkKvP6NzGg==
X-Received: by 2002:a1c:9809:: with SMTP id a9-v6mr9036351wme.15.1532818987278;
        Sat, 28 Jul 2018 16:03:07 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id m207-v6sm11490569wma.31.2018.07.28.16.03.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 16:03:06 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 01/12] staging:rtl8192u: Add spaces around operators - Style
Date:   Sun, 29 Jul 2018 00:02:53 +0100
Message-Id: <20180728230300.19732-2-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180728230300.19732-1-johnfwhitmore@gmail.com>
References: <20180728230300.19732-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the required spaces around '+' and '*' operators. This is a
coding style change to clear the checkpatch issue. There should be
no impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
index 8ee9370520f3..92afa9dc9663 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
@@ -7,7 +7,7 @@
 #define AC_PARAM_SIZE	4
 #define WMM_PARAM_ELE_BODY_LEN	18
 
-#define WMM_PARAM_ELEMENT_SIZE	(8+(4*AC_PARAM_SIZE))
+#define WMM_PARAM_ELEMENT_SIZE	(8 + (4 * AC_PARAM_SIZE))
 
 //
 // ACI/AIFSN Field.
-- 
2.18.0

