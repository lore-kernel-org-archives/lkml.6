Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACA2137663B
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13702208A4
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uH+rP/yx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13702208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731904AbeG2Whm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 18:37:42 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45029 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731466AbeG2Whl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 18:37:41 -0400
Received: by mail-wr1-f66.google.com with SMTP id r16-v6so10588214wrt.11
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 14:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1FdxKaBA9biXmuwgATGI2n1vN+fQJCeFueRVKSiXXyU=;
        b=uH+rP/yx/fDm7M1LmuUhgMwIkmXRq05mgUywRDeu0Pt3WsDaRpmDqxazzZFFuZ+vlm
         7FbTiXojDs345xE4qDBExCJ4dGreBWLjnHFqDHYhCaPEZuPhqLImOwKVLG0A+TYSnJ1t
         Yh1/MMbrklgrvtf+xaGfX2hKIyPjKH/Oqwp7GtIgQW806V6vsYPtbwULVHXqDqoKbZWj
         Vzvtc7YmNbJPXaqlWWNC+Zd+VF8bH+Bd9YBuY2/8kiDWsOub593nabR7gT2/S+sNcG42
         DGqGXJqhH6gEAo9qtGNIkV7tYhhTqPW8Tr2BjoaQ/tKE929C6Oy3/DVcOBP47280dbch
         ijrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1FdxKaBA9biXmuwgATGI2n1vN+fQJCeFueRVKSiXXyU=;
        b=n3UurEB4T8i2n2zm4VUs0pBMeZBI4Hd+tjONwdtueMBb3EWbIcIGO9CAy1Y8lbJQgF
         arsfHVbltGloEazROmsciwc+kef0MdNUdfBZzGZZ/hL8HSWZFcecEIUQgwaKXiTaPOXC
         o/4fKBoAkthVHGHT9a6qD+J6KJGlcPD7lugQiUAZeu7Ek9gf4meA2q4y6Ev7AqHlb9Dz
         Ynf6Kr1cLsOQzXNwn5Vdd7568MJfzFIYXs3Nf7wKbXnUBrIBnFgZzSQYwvmpqCfaAsI1
         Vz4ooJHt6JZSeaEafX7+INx8RLvAhs1suDjhwLy1IvqXU3w8odA3Z6toOf/GV2VkhRlU
         kRDg==
X-Gm-Message-State: AOUpUlHnyGZOGmOMR2cd+PT3V33H6bwHMRiZwZH+v+zDLWDoW4VyXxJL
        gD4FtqmyNaF04ps2IfH2Cxn0qFs+YV8=
X-Google-Smtp-Source: AAOMgpcRxSIYLjRumQQ96YkIz9IpHDUG1EN0LCMZXdgDo7oashV1LYArlUrTp1D0z1Xe6uf9vO37Hw==
X-Received: by 2002:adf:c5d3:: with SMTP id v19-v6mr14875795wrg.169.1532898350748;
        Sun, 29 Jul 2018 14:05:50 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id l19-v6sm10476876wmc.3.2018.07.29.14.05.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 14:05:50 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 03/08] staging:rtl8192u: Rename member variables - Style
Date:   Sun, 29 Jul 2018 22:05:17 +0100
Message-Id: <20180729210534.10617-7-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180729210534.10617-1-johnfwhitmore@gmail.com>
References: <20180729210534.10617-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the member variables of union aci_aifsn, which should be named
in lowercase. The only member variable, of this union, which is
actually used is 'acm'.

This are coding style changes which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h | 10 +++++-----
 drivers/staging/rtl8192u/r8192U_dm.c             |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
index 5856bf87c5dc..901b85139d3b 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
@@ -14,13 +14,13 @@
 // Ref: WMM spec 2.2.2: WME Parameter Element, p.12.
 //
 union aci_aifsn {
-	u8	charData;
+	u8	char_data;
 
 	struct {
-		u8	AIFSN:4;
-		u8	ACM:1;
-		u8	ACI:2;
-		u8	Reserved:1;
+		u8	aifsn:4;
+		u8	acm:1;
+		u8	aci:2;
+		u8	reserved:1;
 	} f;	// Field
 };
 
diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl8192u/r8192U_dm.c
index 04c08ca8a0bb..7dc912dd53af 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.c
+++ b/drivers/staging/rtl8192u/r8192U_dm.c
@@ -2338,7 +2338,7 @@ static void dm_check_edca_turbo(
 
 				read_nic_byte(dev, AcmHwCtrl, &AcmCtrl);
 
-				if (pAciAifsn->f.ACM) { /*  ACM bit is 1. */
+				if (pAciAifsn->f.acm) { /*  acm bit is 1. */
 					AcmCtrl |= AcmHw_BeqEn;
 				} else {	/* ACM bit is 0. */
 					AcmCtrl &= (~AcmHw_BeqEn);
-- 
2.18.0

