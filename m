Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0536C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7A56217CE
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/g9dooG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7A56217CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733252AbeHDLTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:19:12 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35903 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732384AbeHDLTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:19:12 -0400
Received: by mail-wm0-f66.google.com with SMTP id w24-v6so8898376wmc.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Aug 2018 02:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pHVEgguGruGv7QJrnxO/j4XltB11UVY/Sp8SEonIu5A=;
        b=M/g9dooG/9gnDL7BmdkjxtLCuCCOuk6P3njVuA2PkmcVdTb3PeiPpz8c1Zw9OpHDcx
         hHYHvE5pH0n01/Nsl/VqaUjITGJxf2HtUmORi3T1717qilPrtCZt297otzgMVrxxQ1Ex
         iG8lv/MqkSl5C+ZzxKPkcqbPNliuQAoZFmC4jHcX5irCmTm8uGmEOJ3zYQ72q3F2P4UJ
         b0aXiii2my/5DYFB6MevlTGLIIuFrm05VxnBNpHpoVgbfPJ4c8mg8zkVCRTLAOlI/0RC
         DgqWfcmg6X65aew9uWgquFBMi2HnFAXauNlEaERHUdxdV6XVIwn6L576pIPQXjyysbvw
         JrNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pHVEgguGruGv7QJrnxO/j4XltB11UVY/Sp8SEonIu5A=;
        b=AW5rcZZh6H0m6lLL3g5HiicyoiYwAFKor2xwMr7bsfioa89D6hhkximOxqUR0rYeCD
         k3PYLeLZs6ZVzDbRRiJp1GtqV3+qE7aTslfbXckI7yFO3rMveY+SZNAk1d6trZzrYt/K
         K26GwpckQQo7/Yt1ze4tZ1sPparBXSn1aVlcklGR14MKQZsuoTzm2V0RXblh8kMeG1kP
         mcJi6IJP7CzDbL3mkt+oIJYUGCXblcQkj/rjGjgkSIuO3jyzxRlQ8mz4TTt9Cq95NvKl
         HnusSiOSc2xt9SIQfHzwFBJ5dhwKHD//xWF4fyKSvHpTh6abh2oN0l2ytZGm/vzgC8g3
         dPHQ==
X-Gm-Message-State: AOUpUlFkhpwaEVxhOrIof2jD4L6UUHsvCpRg7he8ZCLrPUFCVrNKIwyg
        /WZOGCtsJ6G9K8I3aYOW0HcP+XPGIiA=
X-Google-Smtp-Source: AAOMgpd8iivZD+11fa107ySQII3RyiwwNwkIpzXR1FYnYDu8J2QellObOUGEi3wN8wfIkpf/dGuH3w==
X-Received: by 2002:a1c:9290:: with SMTP id u138-v6mr7390899wmd.52.1533374349470;
        Sat, 04 Aug 2018 02:19:09 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id q188-v6sm2710040wmd.36.2018.08.04.02.19.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 02:19:08 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 3/7] staging:rtl8192u: Rename multiple variables - Style
Date:   Sat,  4 Aug 2018 10:18:55 +0100
Message-Id: <20180804091859.6729-4-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804091859.6729-1-johnfwhitmore@gmail.com>
References: <20180804091859.6729-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All of the variables used within the structures of the union qos_tclas
cause checkpatch issue due to CamelCase naming. As none the member
variables are used in code all have been changed on one patch.

These changes are coding style in nature and should not impact runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../staging/rtl8192u/ieee80211/rtl819x_TS.h   | 66 +++++++++----------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
index c352ba0bcd8f..508ed639cda5 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
@@ -17,51 +17,51 @@ enum tr_select {
 union qos_tclas {
 
 	struct type_general {
-		u8		Priority;
-		u8		ClassifierType;
-		u8		Mask;
+		u8		priority;
+		u8		classifier_type;
+		u8		mask;
 	} type_general;
 
 	struct type0_eth {
-		u8		Priority;
-		u8		ClassifierType;
-		u8		Mask;
-		u8		SrcAddr[6];
-		u8		DstAddr[6];
-		u16		Type;
+		u8		priority;
+		u8		classifier_type;
+		u8		mask;
+		u8		src_addr[6];
+		u8		dst_addr[6];
+		u16		type;
 	} type0_eth;
 
 	struct type1_ipv4 {
-		u8		Priority;
-		u8		ClassifierType;
-		u8		Mask;
-		u8		Version;
-		u8		SrcIP[4];
-		u8		DstIP[4];
-		u16		SrcPort;
-		u16		DstPort;
-		u8		DSCP;
-		u8		Protocol;
-		u8		Reserved;
+		u8		priority;
+		u8		classifier_type;
+		u8		mask;
+		u8		version;
+		u8		src_ip[4];
+		u8		dst_ip[4];
+		u16		src_port;
+		u16		dst_port;
+		u8		dscp;
+		u8		protocol;
+		u8		reserved;
 	} type1_ipv4;
 
 	struct type1_ipv6 {
-		u8		Priority;
-		u8		ClassifierType;
-		u8		Mask;
-		u8		Version;
-		u8		SrcIP[16];
-		u8		DstIP[16];
-		u16		SrcPort;
-		u16		DstPort;
-		u8		FlowLabel[3];
+		u8		priority;
+		u8		classifier_type;
+		u8		mask;
+		u8		version;
+		u8		src_ip[16];
+		u8		dst_ip[16];
+		u16		src_port;
+		u16		dst_port;
+		u8		flow_label[3];
 	} type1_ipv6;
 
 	struct type2_8021q {
-		u8		Priority;
-		u8		ClassifierType;
-		u8		Mask;
-		u16		TagType;
+		u8		priority;
+		u8		classifier_type;
+		u8		mask;
+		u16		tag_type;
 	} type2_8021q;
 };
 
-- 
2.18.0

