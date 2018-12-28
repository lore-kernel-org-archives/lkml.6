Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E67C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 10:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F7D20855
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 10:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Gk6CQ2pi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732114AbeL1Kva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 05:51:30 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45212 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732099AbeL1Kv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 05:51:26 -0500
Received: by mail-ed1-f68.google.com with SMTP id d39so17213594edb.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 02:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=839efX+7U5vYxejZ5MhRw75xUHfEI8ipzY9hkahVUzw=;
        b=Gk6CQ2pikAs8wt4C2vOgxBoJjANTeMK10dypoh/+0xvczPRvNgI8210CGWoa7CtBxk
         aDKfnLxBrSUz8CMJiACIrzpuphTqUvZbdvTdqcIvhltdDzZHFypMd/CsYM9Xph7o626x
         IZPw6mIbAdQygk0G40kdPghnyzGeQx1+pb8dJ7mzhQmZzSmcE4EokxMAc3F7QRY3s+dl
         h0Yjl6alIOttGNkZuJ4+pbeasVc+RLahYnXPgerhnTHKSBZYT6q+pEa9gsz7hGGdbhHf
         cWwBvkT57qKYSWLbvC3PCuF/Z4D7GvHoz6Nc2HVdkNH6FitCXlXXqf7IotkLlxCRXCTt
         oSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=839efX+7U5vYxejZ5MhRw75xUHfEI8ipzY9hkahVUzw=;
        b=qLZfVwt+cxsl97/5HuH62qEiYfh8YdoZy3/Iu2s8tF5hL8zwIVC07SN4aPDIG7kAtl
         BQdEGH3bwUqCVTOkLq4knoJA0QAIBliuKNI03+/TH7y2QWtPw8Zylzt/VNQW470ZOV0S
         cKWB9hGZa2tDNH7HhMO9fCGhshju8HYIpJ2IEHsS7RhQh0lpw/nD6kQxd7IQCp0zUEPi
         5zii2jX8pFYZesKJs+sPNov4R9m8cS5trFVY2YZCMdTEtWccWTcGHf+6nCNoR0zfPEYy
         8WwOu9u/OalmA9kw8iz1aSX5XJFJjnZz74rLJ8zvf2uOlBH+UbKX4pVS2IQBY42OOtei
         ZUGQ==
X-Gm-Message-State: AA+aEWYBEjXrFNHQOH3hbRoStB2QECmXGWz2j4e5rEvWErIHGIJ+nR2b
        QbRmJk4mjmYDCR0AbUtFWReCTZMjCNYdbRdLSNY=
X-Google-Smtp-Source: AFSGD/XcTh+i9kOd+GaV+Vgnk6kzn//dXHYSavPhihgQprRSECGw/x17G2eYjMlUkQflEAQ88DGMww==
X-Received: by 2002:a17:906:5795:: with SMTP id k21-v6mr18149045ejq.238.1545994284272;
        Fri, 28 Dec 2018 02:51:24 -0800 (PST)
Received: from loys-ubuntu-BY1835A49200471.home (anice-157-1-157-17.w83-201.abo.wanadoo.fr. [83.201.132.17])
        by smtp.googlemail.com with ESMTPSA id b45sm12919494eda.34.2018.12.28.02.51.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Dec 2018 02:51:23 -0800 (PST)
From:   Loys Ollivier <lollivier@baylibre.com>
To:     devicetree@vger.kernel.org, Johan Hovold <johan@kernel.org>
Cc:     Loys Ollivier <lollivier@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 3/4] gnss: add gtop receiver type support
Date:   Fri, 28 Dec 2018 11:50:34 +0100
Message-Id: <1545994235-8309-4-git-send-email-lollivier@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545994235-8309-1-git-send-email-lollivier@baylibre.com>
References: <1545994235-8309-1-git-send-email-lollivier@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a gtop type to the "GNSS_TYPE" attribute.

Note that GTOP receveirs support a subset of NMEA 0183 with vendor
extensions (e.g. to allow switching to the vendor protocol).

Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
---
 include/linux/gnss.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/gnss.h b/include/linux/gnss.h
index 43546977098c..adbbacc00278 100644
--- a/include/linux/gnss.h
+++ b/include/linux/gnss.h
@@ -22,6 +22,7 @@ enum gnss_type {
 	GNSS_TYPE_NMEA = 0,
 	GNSS_TYPE_SIRF,
 	GNSS_TYPE_UBX,
+	GNSS_TYPE_GTOP,
 
 	GNSS_TYPE_COUNT
 };
-- 
2.7.4

