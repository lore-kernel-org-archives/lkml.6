Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899E9C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 22:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A7B720868
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 22:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uaX2cJ8j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A7B720868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbeKYJEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 04:04:05 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37965 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbeKYJEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 04:04:04 -0500
Received: by mail-lj1-f193.google.com with SMTP id c19-v6so13357405lja.5;
        Sat, 24 Nov 2018 14:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yCtBduGV4B1E1QfmnGTbr9pPcIEi4Z8uiLxVSHUATEY=;
        b=uaX2cJ8jR89J/vIbthqKpO/SCmxkg17OzwEn6bIgahoPqUfE8pGRhdoZFjfBaZQdem
         g6dawmC5mXH3KoTmNj7KbIGSkJDlZvtFx+rWii4JmlZpwtProoIFydmsJO4y3UsQvxWt
         IxBAuSp5IXqHuMUh7a/1GhtvHugykSFDFBlPxKwUBn+cLdiGRqPE/AVl49X2pMVuJPL6
         V2ycLS7/4XAAuPSxIEdT6USGnD9mQEF5plct6mraxF/iqhsY5AP6mTjE2Hu5xBAi4L4G
         q3K01o5WnT3x6o49fH0dw68ooHrK6WmIdoFMNkYlfNd8rgHYDVP7vHM2Pv6+OHyTlWL1
         JCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yCtBduGV4B1E1QfmnGTbr9pPcIEi4Z8uiLxVSHUATEY=;
        b=j1kZiO11Ypbg+Eat8LnFVNEF1CaMtdaPbzmVvXXUzobkCUgXmjaiidms2Vn+r2TLr+
         PoQcGsX1YPPZoZFu6PlQiSNhjMSrJKQOliTwQIfJWDQTeEMbu9IncUJlS4dl+tzvD34H
         8JLG+qmLTRZFPGgu91aVChTe0IWQNUP8Btx5q+gUwwb0RwT9nazE3DeeWy1rjgOA0Hgn
         Md8wQx+ORWgU0Ic6gYThXfuGNgzndwx84vns6/K+DrsCnd29SA5fOtr/UMJ55Eayd9OV
         v8uIDhftItAs8kWPnJFUn7hRIqFegx91DtHVeW6gcnuqVl+uXZ2mTYVVXo+tvfN81kps
         oILw==
X-Gm-Message-State: AA+aEWaOO+6JWgF2h7GmCC3ZN3uMnmrAC/g1pO44q2Fmpy0HF2Bn9A6l
        OBOwUTRcAxMkFu9SZkdkmmhMgyX61HI=
X-Google-Smtp-Source: AFSGD/VEFaUyMM9OcAkI6LFl3NP/CMa+QQk1y73CjWU8ycaM0imC6KQXtpI1wz5bb1ATvXLoLaSZPA==
X-Received: by 2002:a2e:6503:: with SMTP id z3-v6mr12939024ljb.153.1543097675219;
        Sat, 24 Nov 2018 14:14:35 -0800 (PST)
Received: from arch.domain.name (89-70-226-70.dynamic.chello.pl. [89.70.226.70])
        by smtp.gmail.com with ESMTPSA id x16sm8369281lff.26.2018.11.24.14.14.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Nov 2018 14:14:34 -0800 (PST)
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH 1/3] iio: add IIO_MASSCONCENTRATION channel type
Date:   Sat, 24 Nov 2018 23:14:13 +0100
Message-Id: <20181124221415.10081-2-tduszyns@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181124221415.10081-1-tduszyns@gmail.com>
References: <20181124221415.10081-1-tduszyns@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Measuring particulate matter in ug / m3 (micro-grams per cubic meter)
is de facto standard. Existing air quality sensors usually follow
this convention and are capable of returning measurements using
this unit.

IIO currently does not offer suitable channel type for this
type of measurements hence this patch adds this.

In addition, two modifiers are introduced used for distinguishing
between coarse (PM10) and fine particles (PM2p5) measurements, i.e
IIO_MOD_PM10 and IIO_MOD_PM2p5.

Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 11 ++++++++++-
 drivers/iio/industrialio-core.c         |  3 +++
 include/uapi/linux/iio/types.h          |  3 +++
 tools/iio/iio_event_monitor.c           |  6 ++++++
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 8127a08e366d..ce0ed140660d 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1684,4 +1684,13 @@ KernelVersion:	4.18
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Raw (unscaled) phase difference reading from channel Y
-		that can be processed to radians.
\ No newline at end of file
+		that can be processed to radians.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_massconcentration_pm2p5_input
+What:		/sys/bus/iio/devices/iio:deviceX/in_massconcentrationY_pm2p5_input
+What:		/sys/bus/iio/devices/iio:deviceX/in_massconcentration_pm10_input
+What:		/sys/bus/iio/devices/iio:deviceX/in_massconcentrationY_pm10_input
+KernelVersion:	4.21
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Mass concentration reading of particulate matter in ug / m3.
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index a062cfddc5af..2a9ef600c1fb 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -87,6 +87,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_GRAVITY]  = "gravity",
 	[IIO_POSITIONRELATIVE]  = "positionrelative",
 	[IIO_PHASE] = "phase",
+	[IIO_MASSCONCENTRATION] = "massconcentration",
 };
 
 static const char * const iio_modifier_names[] = {
@@ -127,6 +128,8 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_Q] = "q",
 	[IIO_MOD_CO2] = "co2",
 	[IIO_MOD_VOC] = "voc",
+	[IIO_MOD_PM2p5] = "pm2p5",
+	[IIO_MOD_PM10] = "pm10",
 };
 
 /* relies on pairs of these shared then separate */
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 92baabc103ac..465044b42af5 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -46,6 +46,7 @@ enum iio_chan_type {
 	IIO_GRAVITY,
 	IIO_POSITIONRELATIVE,
 	IIO_PHASE,
+	IIO_MASSCONCENTRATION,
 };
 
 enum iio_modifier {
@@ -87,6 +88,8 @@ enum iio_modifier {
 	IIO_MOD_VOC,
 	IIO_MOD_LIGHT_UV,
 	IIO_MOD_LIGHT_DUV,
+	IIO_MOD_PM2p5,
+	IIO_MOD_PM10,
 };
 
 enum iio_event_type {
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index ac2de6b7e89f..f0fcfeddba2b 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -60,6 +60,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_GRAVITY] = "gravity",
 	[IIO_POSITIONRELATIVE] = "positionrelative",
 	[IIO_PHASE] = "phase",
+	[IIO_MASSCONCENTRATION] = "massconcentration",
 };
 
 static const char * const iio_ev_type_text[] = {
@@ -115,6 +116,8 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_Q] = "q",
 	[IIO_MOD_CO2] = "co2",
 	[IIO_MOD_VOC] = "voc",
+	[IIO_MOD_PM2p5] = "pm2p5",
+	[IIO_MOD_PM10] = "pm10",
 };
 
 static bool event_is_known(struct iio_event_data *event)
@@ -156,6 +159,7 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_GRAVITY:
 	case IIO_POSITIONRELATIVE:
 	case IIO_PHASE:
+	case IIO_MASSCONCENTRATION:
 		break;
 	default:
 		return false;
@@ -200,6 +204,8 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_MOD_Q:
 	case IIO_MOD_CO2:
 	case IIO_MOD_VOC:
+	case IIO_MOD_PM2p5:
+	case IIO_MOD_PM10:
 		break;
 	default:
 		return false;
-- 
2.19.2

