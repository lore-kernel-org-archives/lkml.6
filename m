Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C3BC43142
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F08920878
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfP9Adbf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F08920878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731652AbeG2AnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 20:43:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:47042 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731561AbeG2AnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 20:43:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id h14-v6so8708251wrw.13
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 16:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1FdxKaBA9biXmuwgATGI2n1vN+fQJCeFueRVKSiXXyU=;
        b=QfP9Adbf+O97GOeD1H/hUBqAvL+NvwZVWVH/erzZXhLwOmfTS3l0DZwidAKRlNFC00
         ns0l64VTORjtI04n6MHQ4WKiZONJF60B9Vuj7Up6XnoGigQz4S+6+E3aHdZUsXyr8gkr
         iLWwlHh7lAWCGlu3OOrJGR79pd9uYccGZUeYqF/cCC7Mmc6hjAm9aEsrdB51yovFgeiY
         r0NgXJt3yB6ICT07rOkyvNvUIneRCctJgtSYfxxMBQKpd2spC/dQshqHBafE1Op/e0kV
         T4wyjODecMPoSu7syJe4rrmrnt3slUb61zJ5z7MNLCvywYy2E7tOT7dY3s3SJV7OhCFY
         57jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1FdxKaBA9biXmuwgATGI2n1vN+fQJCeFueRVKSiXXyU=;
        b=oix05mwk+K7cT865Z9bxh4It3/6qxKf2muGhjib9ZLjxZEMpIEe+AyVM9ImNkYXxcd
         A2ALxyK6rltzKg2Kk0V9UoNaet9tUEWeuzTvUEK8EHxUe0Wq0RPceUxIAvH1xpZsi8wq
         ZTqVrZh3YKdvw3nMICeIxggTrbSczJnqOVIl6nT2y66KauBedQOkM8vzt+svImtMukOk
         /qe8Si+1srRxrGhar0DbxJyYNfFDKmWlxwOvZAZfTVCK5AbNa8QUw22vXCFKZwmWfdQH
         uYB1mKGrxUg5ATJjgXKQQK3xgYSV7uN+p2xJbZADgVAkm5WJHJ7Woi+c6+ZNfwpD+du9
         h4dA==
X-Gm-Message-State: AOUpUlEqgfEw2RsF/4o12CVosyOZIcCWcEenIh/twvtS8nh6kJhGIZdZ
        IxLWpkg5Wo9213oS5WbgItGEvMZk
X-Google-Smtp-Source: AAOMgpeGwnmYxzisGwJLudsrbOAQV2UoYnBy5f07E5rwKcpUY9wO82V3FX7/SZkrEIrRZhzyudZmOg==
X-Received: by 2002:adf:fec8:: with SMTP id q8-v6mr11040189wrs.164.1532819703568;
        Sat, 28 Jul 2018 16:15:03 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id j131-v6sm8909745wmb.25.2018.07.28.16.15.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 16:15:02 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 03/08] staging:rtl8192u: Rename member variables - Style
Date:   Sun, 29 Jul 2018 00:14:47 +0100
Message-Id: <20180728231452.20107-4-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180728231452.20107-1-johnfwhitmore@gmail.com>
References: <20180728231452.20107-1-johnfwhitmore@gmail.com>
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

