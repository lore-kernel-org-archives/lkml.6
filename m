Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D247C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 380FC214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ET9sJys4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 380FC214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbeLFVFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:05:16 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38662 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbeLFVFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:05:13 -0500
Received: by mail-lj1-f195.google.com with SMTP id c19-v6so1698502lja.5;
        Thu, 06 Dec 2018 13:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T2Ji2djfHNUmJOAJ461Tn7RtP+2S8C+27OyISZH3aHg=;
        b=ET9sJys4bdGwosCfM9tfocVhp8di7eKGPHjbecQ68F1vCC7Y35rAhdHLfDK4KQa2Ud
         BgzGog4Pfnj4+9TBaF2mb0bvl6fXyDFvnrPukpOGYfow4UJpOMXxuVIJtZCN729O7Cfj
         KMJja3sYuFu1em/t/tCpx3xWahJMgpDpvr4Cm6hxLQNJtYET7fqPAmh/l423P8Unx5ny
         ieuqE+F+slK5zP1k7Q4KGPDFh+tBxZjbngz1Nop5fbSD7sZVkJAhcJ3z4DgIQldAgw4Z
         8bBkFmtQwhdVMVHH9z70AVSrN9anlb7tADeE5rUwAj8GiGm1Qg6vDA9BgGCMBepczph8
         oGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T2Ji2djfHNUmJOAJ461Tn7RtP+2S8C+27OyISZH3aHg=;
        b=r7iEIvGQyIADnTguYYEteBHCAQ7Jq/Kc1cuyluY9nxs4nhfkVf1wMIyDsLBOC8DLoU
         6JEzilaxhXORif+6sel9S/0W0bfbH9fYmtA9gtImUh7iYjPeUBvB1xDOLZci5Zty80L8
         DozgiE/N1+p/lIACUUAZxMrWfLmtclcsGRqbAYPI95n4yghEl+Vq8Odz6E8vM3OIBXID
         BwBCLAajlyUT5Q+8QDvh3OKkkxdDYkbZGoVY+TNi4lnPEAwJQbnAKTJfuZjm4Cf40WLu
         /t0xDEnCoolc+BcXGljty/Eg6HPRd4iukzIHy/n1GCrO88BEU/USdDzMuogFxMGtqW+O
         xiLg==
X-Gm-Message-State: AA+aEWbAGF1OLAWqD8maw0FIMVNbAtGuUF0DxLe3gqXQwmlXHKHjDvxY
        QktsQ+5u929FAkVgydm9Y2PG9Vs1E40=
X-Google-Smtp-Source: AFSGD/UJpAjfucGpXvuUl7Fo3b/PoYz7BkE4t/8FssC92vKR+S9+BwNuDln/uVj5Uh4fclZvtATuJw==
X-Received: by 2002:a2e:302:: with SMTP id 2-v6mr14144033ljd.137.1544130310499;
        Thu, 06 Dec 2018 13:05:10 -0800 (PST)
Received: from arch.domain.name (89-70-226-70.dynamic.chello.pl. [89.70.226.70])
        by smtp.gmail.com with ESMTPSA id e94sm267366lfi.23.2018.12.06.13.05.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 13:05:09 -0800 (PST)
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, jic23@jic23.retrosnub.co.uk,
        a.brauchli@elementarea.net, Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH v2 1/3] iio: add IIO_MASSCONCENTRATION channel type
Date:   Thu,  6 Dec 2018 22:04:41 +0100
Message-Id: <20181206210443.21052-2-tduszyns@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206210443.21052-1-tduszyns@gmail.com>
References: <20181206210443.21052-1-tduszyns@gmail.com>
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
index 8127a08e366d..ad9579a9385f 100644
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
+KernelVersion:	4.21
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Mass concentration reading of particulate matter in ug / m3.
+		pmX consists of particles with aerodynamic diameter less or
+		equal to X micrometers.
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index a062cfddc5af..cbc2c5c8bf36 100644
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
2.19.2

