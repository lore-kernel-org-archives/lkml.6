Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9C7C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDAE621B35
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4OehykX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDAE621B35
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933809AbeFUVJT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:09:19 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:39113 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933304AbeFUVJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:09:15 -0400
Received: by mail-yb0-f193.google.com with SMTP id i2-v6so1761472ybg.6;
        Thu, 21 Jun 2018 14:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4zP3g6YtZ7zJLe7eZLat2TAxtKPNPvZLc7PSTZXPCP8=;
        b=K4OehykXsAfcP0AmEkiq6ehVSso8wI/qeILkJdOWJeVn8LUt3GVVenyCa39wW8uC4l
         J7NPsyOI/P1y6+aurK7IizsrQiwo3Fspkm3WKEqgTl1DpXma6UcBoMSB5qXKYfaeXYUn
         AYJGYFaLEakQb4dcrPyr1IakMZ34+eqHH3tg7NSWs1fjNMPWFDBs62WGiwR12CLwltlD
         dS5hHkWkFNmYkM8Swt+Lj6+BERPqM7L7HayEcrYYTeeXXi4PvVeUJGe7sWAw2QkoMt+j
         ii0UWQbwRCKQnJy0BgyMrSYGeaiimqFL571ggo7i6c9de4rSM2gls2kiGT+dbV20tzgy
         U17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4zP3g6YtZ7zJLe7eZLat2TAxtKPNPvZLc7PSTZXPCP8=;
        b=ezKM3FSu6X2q+mh2JtXYgC355Bk0otSXOSZ78r6I+LOwTJo0UA0DRwwzTNAzKIFhQL
         EG8wtbed9XxZ0h+IJTeTmMfV3KN2tICFYUqgsOEoz/+j3u0FFmX0rAo3BnFdLaHRrwRK
         ZGiEQBnYoWxnQ6KtQUSw2uYOS7bANNmPFrXgdnELDJue+byZP//6fXC65cNuOkKxt9rz
         P3usWKHfXTjE78KusltfrPvlT5GJNXXbn0QovoN5X+GG1q63HaudjvAd2RTyj50bb3iq
         5gY3e5ekgd6T0sKrUTGRRtwUIdIviU+aSzHtfKTnedc8oeDG2gmL11pmw4Jkv7rn3DJS
         HphA==
X-Gm-Message-State: APt69E11DjtTHo5xNjnOiSA9/6fzwD917mrKYMQO7dJyGq29hEITqjw7
        pinOKUmc2D//kIa5GJAZMww=
X-Google-Smtp-Source: ADUXVKJ5B6IQhgZAt2UwhZlE8gRDFGZNBwMCyI0IpExgmX5nJwWnrMMQVqAWE/W1+Mx+L8pVhoJTMA==
X-Received: by 2002:a25:dd86:: with SMTP id u128-v6mr13971117ybg.271.1529615354805;
        Thu, 21 Jun 2018 14:09:14 -0700 (PDT)
Received: from localhost ([72.188.97.40])
        by smtp.gmail.com with ESMTPSA id q7-v6sm1932750ywa.57.2018.06.21.14.09.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 14:09:14 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     jic23@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, fabrice.gasnier@st.com,
        benjamin.gaignard@st.com, robh+dt@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mark.rutland@arm.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v7 10/10] iio: counter: Add deprecation markings for IIO Counter attributes
Date:   Thu, 21 Jun 2018 17:09:08 -0400
Message-Id: <df9656ab1b8a35cf7a7038ed5cdcb12c34a3048f.1529607879.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1529607879.git.vilhelm.gray@gmail.com>
References: <cover.1529607879.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IIO counter subdirectory is now superceded by the Counter subsystem.
This patch adds deprecation warnings to the documentation of the
relevant IIO Counter sysfs attributes.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio          |  8 ++++++++
 .../ABI/testing/sysfs-bus-iio-counter-104-quad-8 | 16 ++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index c7353030670a..fc50adf08e47 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1649,6 +1649,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_countY_raw
 KernelVersion:	4.10
 Contact:	linux-iio@vger.kernel.org
 Description:
+		This interface is deprecated; please use the Counter subsystem.
+
 		Raw counter device counts from channel Y. For quadrature
 		counters, multiplication by an available [Y]_scale results in
 		the counts of a single quadrature signal phase from channel Y.
@@ -1657,6 +1659,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_indexY_raw
 KernelVersion:	4.10
 Contact:	linux-iio@vger.kernel.org
 Description:
+		This interface is deprecated; please use the Counter subsystem.
+
 		Raw counter device index value from channel Y. This attribute
 		provides an absolute positional reference (e.g. a pulse once per
 		revolution) which may be used to home positional systems as
@@ -1666,6 +1670,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_count_count_direction_available
 KernelVersion:	4.12
 Contact:	linux-iio@vger.kernel.org
 Description:
+		This interface is deprecated; please use the Counter subsystem.
+
 		A list of possible counting directions which are:
 		- "up"	: counter device is increasing.
 		- "down": counter device is decreasing.
@@ -1674,4 +1680,6 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_countY_count_direction
 KernelVersion:	4.12
 Contact:	linux-iio@vger.kernel.org
 Description:
+		This interface is deprecated; please use the Counter subsystem.
+
 		Raw counter device counters direction for channel Y.
diff --git a/Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8 b/Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
index 7fac2c268d9a..bac3d0d48b7b 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
+++ b/Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
@@ -6,6 +6,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_index_synchronous_mode_available
 KernelVersion:	4.10
 Contact:	linux-iio@vger.kernel.org
 Description:
+		This interface is deprecated; please use the Counter subsystem.
+
 		Discrete set of available values for the respective counter
 		configuration are listed in this file.
 
@@ -13,6 +15,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_countY_count_mode
 KernelVersion:	4.10
 Contact:	linux-iio@vger.kernel.org
 Description:
+		This interface is deprecated; please use the Counter subsystem.
+
 		Count mode for channel Y. Four count modes are available:
 		normal, range limit, non-recycle, and modulo-n. The preset value
 		for channel Y is used by the count mode where required.
@@ -47,6 +51,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_countY_noise_error
 KernelVersion:	4.10
 Contact:	linux-iio@vger.kernel.org
 Description:
+		This interface is deprecated; please use the Counter subsystem.
+
 		Read-only attribute that indicates whether excessive noise is
 		present at the channel Y count inputs in quadrature clock mode;
 		irrelevant in non-quadrature clock mode.
@@ -55,6 +61,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_countY_preset
 KernelVersion:	4.10
 Contact:	linux-iio@vger.kernel.org
 Description:
+		This interface is deprecated; please use the Counter subsystem.
+
 		If the counter device supports preset registers, the preset
 		count for channel Y is provided by this attribute.
 
@@ -62,6 +70,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_countY_quadrature_mode
 KernelVersion:	4.10
 Contact:	linux-iio@vger.kernel.org
 Description:
+		This interface is deprecated; please use the Counter subsystem.
+
 		Configure channel Y counter for non-quadrature or quadrature
 		clock mode. Selecting non-quadrature clock mode will disable
 		synchronous load mode. In quadrature clock mode, the channel Y
@@ -83,6 +93,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_countY_set_to_preset_on_index
 KernelVersion:	4.10
 Contact:	linux-iio@vger.kernel.org
 Description:
+		This interface is deprecated; please use the Counter subsystem.
+
 		Whether to set channel Y counter with channel Y preset value
 		when channel Y index input is active, or continuously count.
 		Valid attribute values are boolean.
@@ -91,6 +103,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_indexY_index_polarity
 KernelVersion:	4.10
 Contact:	linux-iio@vger.kernel.org
 Description:
+		This interface is deprecated; please use the Counter subsystem.
+
 		Active level of channel Y index input; irrelevant in
 		non-synchronous load mode.
 
@@ -98,6 +112,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_indexY_synchronous_mode
 KernelVersion:	4.10
 Contact:	linux-iio@vger.kernel.org
 Description:
+		This interface is deprecated; please use the Counter subsystem.
+
 		Configure channel Y counter for non-synchronous or synchronous
 		load mode. Synchronous load mode cannot be selected in
 		non-quadrature clock mode.
-- 
2.17.1

