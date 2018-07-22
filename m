Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E2CC6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E3620854
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sAkRb+9E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78E3620854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731204AbeGVXua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 19:50:30 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:43876 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730429AbeGVXua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 19:50:30 -0400
Received: by mail-yb0-f195.google.com with SMTP id x10-v6so6590254ybl.10;
        Sun, 22 Jul 2018 15:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WtrM/1yZXUWUBPgjSl3uinm2kdNBYGgjwhfgxOazJGs=;
        b=sAkRb+9E0iTBEfqm7nrl+mZVPDQvipKknZPxwLPEvrdf/kBO9zMIT30l/lARsQvfdf
         WgTMn7tdnIqr0s8TqcT3lQ1aHkYIM0FYTLiSxIErgNVm5HONQv4GP5XltxDWBKcgxPrp
         q3N89jA0bqghQevcKMasdYGdO2TRIRGFMcIyPhH/NWQS4Yi2YQLh4iQAcJt67oJ4ss0u
         d6lXWpI0UfGMhSYDP7OmXHaFUxZL6kD6thtxJIeoulh6BIf6onfWzJJ+9ek/G5W0KZjf
         QoiTLyG9FDwRJRSNvDYTyY4Dkf6YaVaUmmTqf89zBV8ixf9tMiWOwXf5dwCxGjsDHJqK
         zpdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WtrM/1yZXUWUBPgjSl3uinm2kdNBYGgjwhfgxOazJGs=;
        b=YG/TYvTiACXD2HRy9kli7/cnhbjxDKKp5j80j1m3iZci00KVWY2ykEx/n4mU+1pgkE
         h2bOOeC3Mr7vmdrXXieXFGKZHLBEGrXwtfuMQ8cl61NuRsBYEJBggNRZXeIUMVP9aJUl
         RYNIeA/2VGwRER6Cl0KI4avWNdKzEus1vyGb1qGxbn7bcgtp4fSS0sBUGiCGEFhWAdAn
         U1RWXRDsVGabcMSP5yu0kVdTZgqOG5wf+W0xkwW31hch7sM+mD4LKAs9kAz/imYun86Y
         tb+wiQqUtOwZ7Jq5mRO6l9n/aSZJkMzMKGj+wm2InJlzz4XIb9aL75hPDy0/AYZmhEkw
         d9zQ==
X-Gm-Message-State: AOUpUlF41EdBhk9qOZ/9VH/mdlEW4fQfcnJE7Q44CeOctZKdFHNv9vuf
        4w/BbI2dYN9ybamD57heGw4=
X-Google-Smtp-Source: AAOMgpeGQw8fXRcreUfKn6DqAY57SBZfmjGCNWfoYJEvFbkEpaterh1jjy+iFOdYRioj7Lyvioj2Kg==
X-Received: by 2002:a5b:607:: with SMTP id d7-v6mr5765670ybq.281.1532299930957;
        Sun, 22 Jul 2018 15:52:10 -0700 (PDT)
Received: from localhost ([72.188.97.40])
        by smtp.gmail.com with ESMTPSA id j8-v6sm582710ywj.6.2018.07.22.15.52.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 15:52:10 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     jic23@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, fabrice.gasnier@st.com,
        benjamin.gaignard@st.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, akpm@linux-foundation.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v9 11/11] iio: counter: Add deprecation markings for IIO Counter attributes
Date:   Sun, 22 Jul 2018 18:52:05 -0400
Message-Id: <2450136fe1f5e7f582af69b61e6e1efe0d582c41.1532298882.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1532298882.git.vilhelm.gray@gmail.com>
References: <cover.1532298882.git.vilhelm.gray@gmail.com>
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
index a5b4f223641d..06218a5ae10c 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1652,6 +1652,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_countY_raw
 KernelVersion:	4.10
 Contact:	linux-iio@vger.kernel.org
 Description:
+		This interface is deprecated; please use the Counter subsystem.
+
 		Raw counter device counts from channel Y. For quadrature
 		counters, multiplication by an available [Y]_scale results in
 		the counts of a single quadrature signal phase from channel Y.
@@ -1660,6 +1662,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_indexY_raw
 KernelVersion:	4.10
 Contact:	linux-iio@vger.kernel.org
 Description:
+		This interface is deprecated; please use the Counter subsystem.
+
 		Raw counter device index value from channel Y. This attribute
 		provides an absolute positional reference (e.g. a pulse once per
 		revolution) which may be used to home positional systems as
@@ -1669,6 +1673,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_count_count_direction_available
 KernelVersion:	4.12
 Contact:	linux-iio@vger.kernel.org
 Description:
+		This interface is deprecated; please use the Counter subsystem.
+
 		A list of possible counting directions which are:
 		- "up"	: counter device is increasing.
 		- "down": counter device is decreasing.
@@ -1677,6 +1683,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_countY_count_direction
 KernelVersion:	4.12
 Contact:	linux-iio@vger.kernel.org
 Description:
+		This interface is deprecated; please use the Counter subsystem.
+
 		Raw counter device counters direction for channel Y.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_phaseY_raw
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
2.18.0

