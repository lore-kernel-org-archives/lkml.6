Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25165C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B09222BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1p64dTsv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388447AbfBMPJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:09:49 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40609 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392420AbfBMPJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 10:09:47 -0500
Received: by mail-ed1-f68.google.com with SMTP id 10so2212426eds.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 07:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Nl2exdiih+VjHG/ozKpTxSpUwLVI9022jYFyfu0Qz18=;
        b=1p64dTsvl5SVUsGHL3FLt1+nD8NmQocR3FhCscUxik7dkqyvYZe9zLqoAObZrNGuXM
         /vdO1YZnjzEwQPUtC8hKELtdhfce4nKivab6kodqWOrgaDLv8Rgj32i7rvz05mCS4+8v
         fcD0GaTXet39ium9YtMFesNYNBkTcBYr5ZsvReQTVJ3T2S1xB5q+lDXh5pPumzz/ApR2
         7hSB3HTEOK9Xld8MWQIDZrMNmphOkRUDvD1VZuvE7gTTDmVn/DwgKjKBZzhVCYUB3auI
         lHejL2e6gA0siuSse9ZExSf8k/E00GjSz4Hef/Rv2qttqxuL5XPkIaGSX4enPRBfmvqU
         v9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Nl2exdiih+VjHG/ozKpTxSpUwLVI9022jYFyfu0Qz18=;
        b=g19B/6yLqHLzUjMGpqbna0Se7Aen3tEuJRO8RRim7Q4avFp9OWTYCtxcjGQLUbtK3e
         HftXawmaM0SPMLJRKnNQpnldLTYHRYhK6+e7L1Us4MXDmqPo6XqIcGRdTWRJJGB3bZua
         4sgUIuWsPjs6jekE1tn5BaHOpz9mt+vzrYYxVzv5cMYPfKeiflbHb6DyRmXN9jHIksM3
         MnG7RLdfFqCsT9dOhLkE7Bb6s1myWil62/Rf0wjLM8B7ckUtgDuA2rIXXcUh3gpdfc7/
         P6Ip/S7nelXRvCDRatzUveX8TXQoDWaCFXhfvARrw6Ja4EPVap4A4o5HyvAVgGUI/T1u
         WQ/g==
X-Gm-Message-State: AHQUAuane3f4uAb+Q7uZAfVIaA1vIrDese9unNixCKJcM8lmarQ+rXgZ
        wLqdVpi3rO32k5CVS3xy1Q+5yw==
X-Google-Smtp-Source: AHgI3IamSPBWkpmVDICq57ehjEwNPLY2zEI4b9JBPG8jq5i5XYnNhIuRNGkhmx8cKd1Whz5KZ3ufZQ==
X-Received: by 2002:a50:ad57:: with SMTP id z23mr727379edc.223.1550070585131;
        Wed, 13 Feb 2019 07:09:45 -0800 (PST)
Received: from loys-ubuntu-BY1835A49200471.thefacebook.com ([2620:10d:c092:180::1:4505])
        by smtp.googlemail.com with ESMTPSA id k26sm1903941ejv.63.2019.02.13.07.09.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Feb 2019 07:09:44 -0800 (PST)
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
Subject: [PATCH v4 3/4] gnss: add mtk receiver type support
Date:   Wed, 13 Feb 2019 16:09:28 +0100
Message-Id: <1550070569-18588-4-git-send-email-lollivier@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550070569-18588-1-git-send-email-lollivier@baylibre.com>
References: <1550070569-18588-1-git-send-email-lollivier@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an MTK (Mediatek) type to the "GNSS_TYPE" attribute.

Note that MTK receivers support a subset of NMEA 0183 with vendor
extensions.

Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
---
v4:
No changes

v3:
Moved the gnss_type_names string addition to this patch.
Edited the commit message to remove the reference to a vendor protocol.

v2:
Renamed from GTOP to MTK.

 drivers/gnss/core.c  | 1 +
 include/linux/gnss.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gnss/core.c b/drivers/gnss/core.c
index 4291a0dd22aa..320cfca80d5f 100644
--- a/drivers/gnss/core.c
+++ b/drivers/gnss/core.c
@@ -334,6 +334,7 @@ static const char * const gnss_type_names[GNSS_TYPE_COUNT] = {
 	[GNSS_TYPE_NMEA]	= "NMEA",
 	[GNSS_TYPE_SIRF]	= "SiRF",
 	[GNSS_TYPE_UBX]		= "UBX",
+	[GNSS_TYPE_MTK]		= "MTK",
 };
 
 static const char *gnss_type_name(struct gnss_device *gdev)
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

