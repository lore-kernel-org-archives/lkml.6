Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7D6C46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F23620857
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWIB+rK7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F23620857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732010AbeG2Wkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 18:40:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40589 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731767AbeG2Wkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 18:40:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id h15-v6so10590266wrs.7
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 14:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ADnneXo/ePiCVNyaeHQUsmH2zIrbvs13SbJUcQDsabE=;
        b=ZWIB+rK7r0OBQdLhHfalkz/pjTQavM4L6qsYAngmttpTvCGQZcbJMjZk0dHM7ADgRu
         /jSXntxl/wlczJxeMHQ//UWQoM9HYgdN+E1A3BO3sIG9G1E4tvNWWNHy7tmOCJ9ObtQi
         BTjdnK1KMri8eLIXaAWTLmFAue8NcVPtfXrgo4+ger/D30Uilp4cc8n03BUkJm3UVzX7
         XgTN0P3M6u3nL5csXHIg7zwuLTmo/zSaq5S3BQj3fFo9FmEo8PN3PPWPgQtrGM5nJFsP
         kwpEqNxs39B3HtMlorLSzRFo/izs8NG57nVuHOJ4p+KWH443bgiVpLPa5n8/ttkmWPWq
         nmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ADnneXo/ePiCVNyaeHQUsmH2zIrbvs13SbJUcQDsabE=;
        b=I5LFEwUOIIaWHmdUN0ZhXzocCYCg414xxxSKp6paeAi8V+3oeEeO9ZGYKEyeY0fS8K
         07kwn/w9PA0gXgOXOShRXzxsTFexPsnEGmZqbtMW7KSaZrkZOPAhlk+UIFndzYvcM5Iv
         XRyNA//Cag/HNi/evcyWyzDUX6IFBec6YIeyMNI71JR6iCC0qwsM0uUFCDrGqxJon+xu
         v0BjhEuBscfhomW6jMpsl5eaN1Ys7U136h3M6cNPQBqrB0jDgGIYUets60jl9PDg9e3L
         qWkL1TxJDo1KbZmUH/tQ8ypSdh9PoX8jVJUpmDeWc34Q9GbY0eTOF+sjCmsB+3O+l59/
         GH7Q==
X-Gm-Message-State: AOUpUlEmhNyotVKsaqBIzDYw34Jfnbb12U9UmS9/t3M6Ea7vT9Xgp1JD
        T2YNvfM18I0PhspBRCNYh3hXfemx8+0=
X-Google-Smtp-Source: AAOMgpdi4xzkCJ1oUx6PK6Tqk3bA2qmbSryyscDyzq4r9QK9SFlrH2Gg4HUk8IpmlpUdfVHd/Hu72g==
X-Received: by 2002:adf:eb4c:: with SMTP id u12-v6mr15396502wrn.174.1532898520221;
        Sun, 29 Jul 2018 14:08:40 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id d26-v6sm9264532wmb.15.2018.07.29.14.08.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 14:08:39 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 13/15] staging:rtl8192u: Refactor enum dm_dig_pd_th_e - Style
Date:   Sun, 29 Jul 2018 22:07:45 +0100
Message-Id: <20180729210747.10803-14-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180729210747.10803-1-johnfwhitmore@gmail.com>
References: <20180729210747.10803-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enumerated type dm_dig_pd_th_e is never actually used as
the type for the two variables which use the constants, which the
enumeration defines. This omission removes the possibility of taking
advantage of compiler type checking.

To correct this the two member variables, (curpd_thstate & prepd_thstate)
have been changed to use the type enum dig_pkt_detection_threshold rather
then u8.

Additionally the enum's declaration has been moved above the dig
structure, where the type is used, the 'typedef' has been removed to
clear the checkpatch issue with defining new types, and the value
'DIG_PD_MAX' has been removed from the enumeration, since it is never
used in code.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_dm.h | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_dm.h b/drivers/staging/rtl8192u/r8192U_dm.h
index 8de6d15fb659..f9d75ad9eaee 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.h
+++ b/drivers/staging/rtl8192u/r8192U_dm.h
@@ -81,6 +81,12 @@ enum dig_connect {
 	DIG_CONNECT = 1,
 };
 
+enum dig_pkt_detection_threshold {
+	DIG_PD_AT_LOW_POWER = 0,
+	DIG_PD_AT_NORMAL_POWER = 1,
+	DIG_PD_AT_HIGH_POWER = 2,
+};
+
 /* 2007/10/04 MH Define upper and lower threshold of DIG enable or disable. */
 struct dig {
 	u8		dig_enable_flag;
@@ -99,8 +105,8 @@ struct dig {
 	enum dig_connect		cur_connect_state;
 	enum dig_connect		pre_connect_state;
 
-	u8		curpd_thstate;
-	u8		prepd_thstate;
+	enum dig_pkt_detection_threshold		curpd_thstate;
+	enum dig_pkt_detection_threshold		prepd_thstate;
 	u8		curcs_ratio_state;
 	u8		precs_ratio_state;
 
@@ -115,13 +121,6 @@ struct dig {
 	long		rssi_val;
 };
 
-typedef enum tag_dig_packetdetection_threshold_definition {
-	DIG_PD_AT_LOW_POWER = 0,
-	DIG_PD_AT_NORMAL_POWER = 1,
-	DIG_PD_AT_HIGH_POWER = 2,
-	DIG_PD_MAX
-} dm_dig_pd_th_e;
-
 typedef enum tag_dig_cck_cs_ratio_state_definition {
 	DIG_CS_RATIO_LOWER = 0,
 	DIG_CS_RATIO_HIGHER = 1,
-- 
2.18.0

