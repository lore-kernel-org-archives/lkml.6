Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB4CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C80DA20855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ZMMVlo6g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbfAQQyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:54:51 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54913 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728810AbfAQQyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:54:45 -0500
Received: by mail-wm1-f68.google.com with SMTP id a62so1800732wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 08:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9j/4jxpYoQpPS/+1F1W02eb69wy8a+vueBOw79dZhl0=;
        b=ZMMVlo6gORfpCiJzCTh35BEQkxOT58yOVe7R5axxirvuNI7pvedOR7BDZIct9vWjLH
         xHFV0uD762SYEPELWy4SofB0e6QtGlu1ob1ua8RM8TeB8wbwRVposUIq87sy7IaoQn4u
         73tRkOcyhtSpHqQ0gFzkYRaCC/4ktaZ1QjvMFQ8tfT05X14fL99Z6kMFrPJ8kIkGwmBS
         wA7cpklVkVKdRsxjfAaDoI+My9hdnV7DlJTPEc6bMhFY6A/WkZwKsKXOb2/pJF4B0fZ8
         WWuAEJg8YGYgiJu+N9hyMjQA3uHnjko42yKcCo7o7E/UHMMHU7estb/PGK65ii1164Hd
         Lhug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9j/4jxpYoQpPS/+1F1W02eb69wy8a+vueBOw79dZhl0=;
        b=Eqyevk7p7Efgl5jjr1hculqQCtzwqGjbPNToRsjvLpzFjafPULaJOfQ8ScHl2Jl1uS
         qzfwVqFXszekr/IYuKF8KmrxanWbBhzzhx4+7lXGJ3m075TkQFgdEapsjuKqRGgTub20
         yaPTkrMN7jRiyzFBv7GzIa7+jBcUnLCI4RR+DglRjgmLgwrIc5Rv/JCb3m2vrSQE2ppE
         8phJXRCxvsDgU9EPy26T6kaHOy34DrGPWuK/K0vFRTN+GNJRreQUwkYKqnYC+47j6VrJ
         qpv4AdWaaGLUrRj3nlwL4VBOYhNFuEK73PyL30Og3B/AND8HY2t2w9QztFI8xIM8Pnhm
         QywQ==
X-Gm-Message-State: AJcUukd0Sm15x3em33wZefqOufQV8WXPDcrHLdil0F6wl3LAzlJeKxyJ
        EwCN5V3rzBSBdsfOdxJot5Nblg==
X-Google-Smtp-Source: ALg8bN4JFH5Al+JSn0k9EAkO6wjhzOlxBRiDe8ShCU05xJYXuEkqlX6BaZPLbL8Ttdb1wmQQMZyM6g==
X-Received: by 2002:a1c:c60e:: with SMTP id w14mr13223913wmf.18.1547744083821;
        Thu, 17 Jan 2019 08:54:43 -0800 (PST)
Received: from loys-ubuntu-BY1835A49200471.thefacebook.com (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id b12sm65309630wrt.17.2019.01.17.08.54.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Jan 2019 08:54:43 -0800 (PST)
From:   Loys Ollivier <lollivier@baylibre.com>
To:     devicetree@vger.kernel.org, Johan Hovold <johan@kernel.org>
Cc:     Loys Ollivier <lollivier@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 3/4] gnss: add mtk receiver type support
Date:   Thu, 17 Jan 2019 17:54:33 +0100
Message-Id: <1547744074-28308-4-git-send-email-lollivier@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547744074-28308-1-git-send-email-lollivier@baylibre.com>
References: <1547744074-28308-1-git-send-email-lollivier@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an MTK (Mediatek) type to the "GNSS_TYPE" attribute.

Note that MTK receivers support a subset of NMEA 0183 with vendor
extensions (e.g. to allow switching to the vendor protocol).

Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
---

v2: renamed from GTOP to MTK.

 include/linux/gnss.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/gnss.h b/include/linux/gnss.h
index 43546977098c..36968a0f33e8 100644
--- a/include/linux/gnss.h
+++ b/include/linux/gnss.h
@@ -22,6 +22,7 @@ enum gnss_type {
 	GNSS_TYPE_NMEA = 0,
 	GNSS_TYPE_SIRF,
 	GNSS_TYPE_UBX,
+	GNSS_TYPE_MTK,
 
 	GNSS_TYPE_COUNT
 };
-- 
2.7.4

