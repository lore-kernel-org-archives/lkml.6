Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D32C46463
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD08A20841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZIPVQXt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD08A20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732687AbeGaWnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:43:01 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44947 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732646AbeGaWnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:43:01 -0400
Received: by mail-ed1-f67.google.com with SMTP id f23-v6so5843650edr.11
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 14:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0vX/3ahUovxusaFgDhxwhgMX359c94ST73awLAMlhQs=;
        b=CZIPVQXtCqPl6YV8i4d8fhU1mSHIhAN0oFd+BSQB8EfVqf3Iq81FgAyMZeALGE9XtD
         MQBf77myn9MNaWt6XJsu+dlP9+OzDAEfFtW0BZ3eH+mtQgE3GB8KpW1NiUbwujV05c5M
         fB1KldOwuq57X2XCmSR93Fv+e4zkfgY56Er3/KMHE6WCCkH9WoaR8nazDrdNzrcVSdlg
         cHDahvCl39uEbLctr4H7gOiWrJRSWtqesL7PK3c8VbMaj2X0ucvVfLl0PnZprfm8i1ow
         wPsP+teTpfOW6HNr+cvEP2IAkxAQtY2OAy3ENWfMMVNuN2nnr0GXRpYkt6hKOYoKqZ4p
         4m5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0vX/3ahUovxusaFgDhxwhgMX359c94ST73awLAMlhQs=;
        b=lvHB6v0th9pv7Q/r6W1fDNWce4aYJr7CBQ1V+O24nX3/ZLd+S/3GkK52UYA9mTY0pB
         Sxj5ZHJNdG+7EpKuYprIpJsi+02YOkYJD3XAQl8LmpMw8gz+ELSYhnBiT+M/y1HW/xdt
         DGCyCJuCcwW8fyVRmAFIUC8qJCYXrDAN2/Q7vYdjwH5HxhzsxLsh9ALOvb5iMPcWtpF1
         gZOQlM+gNEJi4gdsftrr+lNNsCNXnKP+0xHE6gC4+g3IHEyGVMZK3oVH+/AT/wWAhSI6
         HnlIbVr8xTIpcYTd7DOlk+WgpS4lB6vHZ5GT+J8IfkZJILalMdBqkE45UbTcoYE64O1F
         4aGA==
X-Gm-Message-State: AOUpUlHCAkKfBrdCm0ZFBpBzQyw9jb2WchZiyKMZXlOo9FgXw8pqehQQ
        UqZcJ08XdW+aHUtIpSVnFEpd1WJu
X-Google-Smtp-Source: AAOMgpftOi3FJr3njv2x8P8G8hnQolRwHOR0952J2SRV5keXmUOVwIFgGRxhX9v1Y2mMs1fi+Oq+/w==
X-Received: by 2002:a50:ac65:: with SMTP id w34-v6mr1088412edc.211.1533070849042;
        Tue, 31 Jul 2018 14:00:49 -0700 (PDT)
Received: from localhost.localdomain ([109.77.253.253])
        by smtp.gmail.com with ESMTPSA id j42-v6sm4143373eda.2.2018.07.31.14.00.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 14:00:48 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 14/14] staging:rtl8192u: Change clock comment - Style
Date:   Tue, 31 Jul 2018 22:00:05 +0100
Message-Id: <20180731210005.17452-15-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731210005.17452-1-johnfwhitmore@gmail.com>
References: <20180731210005.17452-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A number of block comments have been changed to comply with the coding
standard. These are coding style changes which should have no impact
on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
index 77f0e26f5d2d..3052f53d2e7e 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
@@ -14,10 +14,10 @@ struct aci_aifsn {
 	u8:1;
 };
 
-//
-// Direction Field Values.
-// Ref: WMM spec 2.2.11: WME TSPEC Element, p.18.
-//
+/*
+ * Direction Field Values.
+ * Ref: WMM spec 2.2.11: WME TSPEC Element, p.18.
+ */
 enum direction_value {
 	DIR_UP			= 0,		// 0x00	// UpLink
 	DIR_DOWN		= 1,		// 0x01	// DownLink
@@ -69,9 +69,9 @@ struct tspec_body {
 	u16	medium_time;
 };
 
-//----------------------------------------------------------------------------
-//      802.11 Management frame Status Code field
-//----------------------------------------------------------------------------
+/*
+ *      802.11 Management frame Status Code field
+ */
 struct octet_string {
 	u8		*octet;
 	u16             length;
-- 
2.18.0

