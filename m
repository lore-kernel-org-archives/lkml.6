Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B2BECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C62E420880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvFQT51i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C62E420880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbeGWVx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 17:53:58 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35413 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388161AbeGWVx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 17:53:56 -0400
Received: by mail-wm0-f66.google.com with SMTP id o18-v6so436815wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 13:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PZIfFgDkHkCovuBTAtam+Qf2+5WOoodnBzVYG9OUnEw=;
        b=NvFQT51iRfkF4Gzy3FusWH23XUg/DjQg7i9Q9rdUHmUnxiCq51nWJTTk8XdHXhlcYP
         MZFrdgaRNKhDiy0+rNUDK8lYjBvs57a+u9w6Cxr/bJwUitYv0Jb3d3vE6h2vFci87+ox
         enok3v5MXNTYO/rV21VDIG/n1/lff83531Dl7/lPYi4s4DxYN+zJs18NILKsO3NHyI47
         /v/O5YnRQa6SwCBUgMyBOxcu/trAYUnzaR1OFurMaHBuOLPES3SD3NlnbKM/e/NAFjjq
         D9RhaMdIQR8EvC9rwrTPrmXMFlK0erfGLZjSfAOCT4di+CChD6ixouI9CGKHjzCSz3g8
         ow4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PZIfFgDkHkCovuBTAtam+Qf2+5WOoodnBzVYG9OUnEw=;
        b=jnzTviaQuwwSk1r/00THV4dJFHDSb/W7APgd4qzdDCvTt03/tBwPdc3GmIBGpWdXnQ
         KDCDrEK9WMxCFLmAtKZb5KfgkFMxE287BbBtitNPE32zriLwYFj9K5emZbPrLX1WDXqn
         6S5mudJjTk1CaeDZ1vIhHHCjceJA2/68xHCXeorDK91Tg2NCcB2OeslTrLzpS54xVAtS
         nySKxVmpj7WffXxwR9gZg6PkVGePj8m1qkZJyteB1jg8xvX8E70fke7ua830FhAjMIgR
         KewoRKpFnYof/7AUUcX4l9Zwifeb5AQbvACmZR2WhNCAdDLvwVUIHmS9QGYLk/JVckX4
         MOiQ==
X-Gm-Message-State: AOUpUlEEEamzbIwVnx/IQ0pbwzx1qIhnlvME+brq6C6yeTlz67B9Cd9T
        LnlYkAaXTEn2lymfkORBewlsPfs1
X-Google-Smtp-Source: AAOMgpd9EgKs84Hq0mZhkSrDJ2a1Ja6IgToKtEPK8LkfwbxeeU2XqtiHRg0ifUP5n5MORruYjq7V1Q==
X-Received: by 2002:a1c:2b43:: with SMTP id r64-v6mr276443wmr.96.1532379057645;
        Mon, 23 Jul 2018 13:50:57 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id b123-v6sm14921874wma.24.2018.07.23.13.50.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 13:50:56 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 09/15] staging:rtl8192u: Remove unused enumerated type QOS_ELE_SUBTYPE - Style
Date:   Mon, 23 Jul 2018 21:50:25 +0100
Message-Id: <20180723205031.19816-10-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723205031.19816-1-johnfwhitmore@gmail.com>
References: <20180723205031.19816-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enumerated type QOS_ELE_SUBTYPE is unused in code so has been removed
from code. This is a coding style change which should have not impact on
runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
index 455b87edc7fb..6cfae00919c1 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
@@ -51,17 +51,6 @@ typedef	union _AC_PARAM {
 	} f;	// Field
 } AC_PARAM, *PAC_PARAM;
 
-
-
-//
-// QoS element subtype
-//
-typedef	enum _QOS_ELE_SUBTYPE {
-	QOSELE_TYPE_INFO	= 0x00,		// 0x00: Information element
-	QOSELE_TYPE_PARAM	= 0x01,		// 0x01: parameter element
-} QOS_ELE_SUBTYPE, *PQOS_ELE_SUBTYPE;
-
-
 //
 // Direction Field Values.
 // Ref: WMM spec 2.2.11: WME TSPEC Element, p.18.
-- 
2.18.0

