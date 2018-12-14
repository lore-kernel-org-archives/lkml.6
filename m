Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F0AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D677206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vz4yql6E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730537AbeLNS2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 13:28:35 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39838 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729707AbeLNS2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 13:28:34 -0500
Received: by mail-lf1-f66.google.com with SMTP id n18so4965328lfh.6;
        Fri, 14 Dec 2018 10:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KUPCm5xTXfCYM0UbyACDawn4aPf4L7rSawy9uOKsI1w=;
        b=Vz4yql6Emw3JPTeRhqLacyLfjGoeV/FdXqkKjFOcmBFUGO1Ex0m8llywuoUyBDT7Nh
         wqCuz6Blz+hS/kRUVhqtHb5tAvS9xErGVCxtUitlQjmRhjyLomrQNsnzGcCbJiKS9qvh
         a+wfnAGphOLhVJBgim7PSDh0XX/f2tFKpRmIvDNpp9qZe3CQP49TN5KNYtKH+LsLtwfi
         pSRYOKxTpYdpkimDkob0NldPbQZ0sPtlQEjtw1nxbXbP47kUmZWZoO4SrGJuoT4t6XOG
         CLP7LurBGPrcChwug5YIWu7RhTiLF1+NFTJ8/Q4tkm7IQJhKLxST6UKXHwwkeWBLuJmJ
         FvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KUPCm5xTXfCYM0UbyACDawn4aPf4L7rSawy9uOKsI1w=;
        b=kYFE17VTBu9gpEzMasW3U1Bmfdv3FcXo/NgTv6MLBjleFBSTp9u7e9umOirBzGuTsu
         VXUVp8q7HsNsBwXAYD+Y3CcOfjsfTqY5Mx8Dm9FVrhw8Z8wQj6S4XqgecffQDT6olxw0
         xrIW2/EaDZaGU74CZ9q4Hu75UxDvlbdP2xb9WfUKxnalAfeHxkZRjkWoV1voUKPIyxLf
         l/PKAPlsFgTybpT5kAPu43jpKBJOrO+HJu+5ifbrp1XPYyN8Ian1cC6MvUW7JJ5lUtMW
         TFI4i3/JqjDdYT2aqrJ30T7jCebxCuh3T1mTAAq1NBfwdm0iAA/pzXI4rD52KO4BIfXo
         Ml5Q==
X-Gm-Message-State: AA+aEWaS34gShp/0W6jp5NVP93+fdRZvN6WUu4ACk1eO4UAa59j2wkwH
        mJOALPA8gdZAEtb8/37li/V5oUMLXH8=
X-Google-Smtp-Source: AFSGD/XEeH98yKTCd07jn5HOPnHpVwM5BUWZSQIwvb1zsTVRmBbLz2lkVzCk2MrZ6DPwn7QLxJ+fgw==
X-Received: by 2002:a19:2584:: with SMTP id l126mr2364185lfl.69.1544812110608;
        Fri, 14 Dec 2018 10:28:30 -0800 (PST)
Received: from arch.domain.name (89-70-220-87.dynamic.chello.pl. [89.70.220.87])
        by smtp.gmail.com with ESMTPSA id e14-v6sm947961ljb.31.2018.12.14.10.28.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 10:28:29 -0800 (PST)
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, jic23@jic23.retrosnub.co.uk,
        a.brauchli@elementarea.net, Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH v4 1/3] iio: add IIO_MASSCONCENTRATION channel type
Date:   Fri, 14 Dec 2018 19:28:01 +0100
Message-Id: <20181214182803.9006-2-tduszyns@gmail.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214182803.9006-1-tduszyns@gmail.com>
References: <20181214182803.9006-1-tduszyns@gmail.com>
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

In addition, extra modifiers are introduced used for distinguishing
between fine pm1, pm2p5 and coarse pm4, pm10 particle measurements, i.e
IIO_MOD_PM1, IIO_MOD_PM25 and IIO_MOD_PM4, IIO_MOD_PM10.

pmX consists of particles with aerodynamic diameter less or equal to
X micrometers.

Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 17 ++++++++++++++++-
 drivers/iio/industrialio-core.c         |  5 +++++
 include/uapi/linux/iio/types.h          |  5 +++++
 tools/iio/iio_event_monitor.c           | 10 ++++++++++
 4 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 8127a08e366d..67fd88bf7910 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1684,4 +1684,19 @@ KernelVersion:	4.18
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Raw (unscaled) phase difference reading from channel Y
-		that can be processed to radians.
\ No newline at end of file
+		that can be processed to radians.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_massconcentration_pm1_input
+What:		/sys/bus/iio/devices/iio:deviceX/in_massconcentrationY_pm1_input
+What:		/sys/bus/iio/devices/iio:deviceX/in_massconcentration_pm2p5_input
+What:		/sys/bus/iio/devices/iio:deviceX/in_massconcentrationY_pm2p5_input
+What:		/sys/bus/iio/devices/iio:deviceX/in_massconcentration_pm4_input
+What:		/sys/bus/iio/devices/iio:deviceX/in_massconcentrationY_pm4_input
+What:		/sys/bus/iio/devices/iio:deviceX/in_massconcentration_pm10_input
+What:		/sys/bus/iio/devices/iio:deviceX/in_massconcentrationY_pm10_input
+KernelVersion:	4.22
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Mass concentration reading of particulate matter in ug / m3.
+		pmX consists of particles with aerodynamic diameter less or
+		equal to X micrometers.
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 4f5cd9f60870..4700fd5d8c90 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -87,6 +87,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_GRAVITY]  = "gravity",
 	[IIO_POSITIONRELATIVE]  = "positionrelative",
 	[IIO_PHASE] = "phase",
+	[IIO_MASSCONCENTRATION] = "massconcentration",
 };
 
 static const char * const iio_modifier_names[] = {
@@ -127,6 +128,10 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_Q] = "q",
 	[IIO_MOD_CO2] = "co2",
 	[IIO_MOD_VOC] = "voc",
+	[IIO_MOD_PM1] = "pm1",
+	[IIO_MOD_PM2P5] = "pm2p5",
+	[IIO_MOD_PM4] = "pm4",
+	[IIO_MOD_PM10] = "pm10",
 };
 
 /* relies on pairs of these shared then separate */
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 92baabc103ac..c59adac24b1c 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -46,6 +46,7 @@ enum iio_chan_type {
 	IIO_GRAVITY,
 	IIO_POSITIONRELATIVE,
 	IIO_PHASE,
+	IIO_MASSCONCENTRATION,
 };
 
 enum iio_modifier {
@@ -87,6 +88,10 @@ enum iio_modifier {
 	IIO_MOD_VOC,
 	IIO_MOD_LIGHT_UV,
 	IIO_MOD_LIGHT_DUV,
+	IIO_MOD_PM1,
+	IIO_MOD_PM2P5,
+	IIO_MOD_PM4,
+	IIO_MOD_PM10,
 };
 
 enum iio_event_type {
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index ac2de6b7e89f..f6b8003fbe3c 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -60,6 +60,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_GRAVITY] = "gravity",
 	[IIO_POSITIONRELATIVE] = "positionrelative",
 	[IIO_PHASE] = "phase",
+	[IIO_MASSCONCENTRATION] = "massconcentration",
 };
 
 static const char * const iio_ev_type_text[] = {
@@ -115,6 +116,10 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_Q] = "q",
 	[IIO_MOD_CO2] = "co2",
 	[IIO_MOD_VOC] = "voc",
+	[IIO_MOD_PM1] = "pm1",
+	[IIO_MOD_PM2P5] = "pm2p5",
+	[IIO_MOD_PM4] = "pm4",
+	[IIO_MOD_PM10] = "pm10",
 };
 
 static bool event_is_known(struct iio_event_data *event)
@@ -156,6 +161,7 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_GRAVITY:
 	case IIO_POSITIONRELATIVE:
 	case IIO_PHASE:
+	case IIO_MASSCONCENTRATION:
 		break;
 	default:
 		return false;
@@ -200,6 +206,10 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_MOD_Q:
 	case IIO_MOD_CO2:
 	case IIO_MOD_VOC:
+	case IIO_MOD_PM1:
+	case IIO_MOD_PM2P5:
+	case IIO_MOD_PM4:
+	case IIO_MOD_PM10:
 		break;
 	default:
 		return false;
-- 
2.20.0

