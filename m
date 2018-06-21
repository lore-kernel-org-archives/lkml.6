Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56321C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A75A2239C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pT8JpJO4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A75A2239C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933712AbeFUVIT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:08:19 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:39069 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933364AbeFUVIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:08:15 -0400
Received: by mail-yb0-f193.google.com with SMTP id i2-v6so1760503ybg.6;
        Thu, 21 Jun 2018 14:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eA2MhywHD/qn4Zj11fSlYsUI3I8yvVi/AeZkHCDB+bY=;
        b=pT8JpJO487fUcd75WuNTbpzGNykY0KpS/zfEdfW7BCvyYzQRJP2o7anxPfmNuGlMUU
         HY/1Gy9Zu+R21v8pfz4J6NxsvjAmgxIB3fVTy+Fz42zP8fb00PvFj+VkgbfV+ER7eF2F
         wC3w8I3gSEAuzJAyMciJdIu2Ohd2bZofEzwh4zzkR9AA3wkJd3P9YTyZZbAl+4Au95d/
         5/dvuq+HiDI1nBL4kYLELXN4kVcwuLUUiden1PmQepLQGC5MTrvqpSc214r7GeFdaQ8c
         8qvjPHh4wdv79ZA64RBpHKLQHluT5afZmC2vCZKt009GB3bp8xKn9mH99aaV6ETw8NjU
         ztng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eA2MhywHD/qn4Zj11fSlYsUI3I8yvVi/AeZkHCDB+bY=;
        b=HMWI4TH+P9arrouzr/5fFtOMSW/d8rnR2I4pbZp4QAvsDm/OXs5z56UCSwUgrTKzzf
         A3c2CRDAAOxfMZaYgnoPv3xmKMRijmlcKWRcua0XvYpsyktuexZDyla/YO8wn/cuSURN
         szvHkkQOu9rmCkeYWUyPfNsZy/jynZBu1QDyr3q3KSaB/rsUnZJxDQFOa7/M1ouBbL14
         l4OWlnd/1QfNyXfT5bFfkrVy5gTmP1OckUS87Y0FC6oLRqidNatSQ+JpisaIZmSxMP5c
         QXU2ctimCwEAF+EypiPNsNvxZfadSRoRUJJxpfDHtnkh5dgieDge46NfLUuLPPa/emQr
         KOrQ==
X-Gm-Message-State: APt69E0gvuPT5UO4OwkAiF0Clj+z/EEEbcATDeg387ExBMNZWpLnke6f
        j85JBDM0x/Ox00Pki8e2Zd0=
X-Google-Smtp-Source: ADUXVKIr1W6Vy/YFcLw7gpWyLftG7xJiAHNJGUBK5ViUiYquQ08mXPk7NWkyzsUYxgmcOeeIh1iOUQ==
X-Received: by 2002:a25:5307:: with SMTP id h7-v6mr13718301ybb.11.1529615294493;
        Thu, 21 Jun 2018 14:08:14 -0700 (PDT)
Received: from localhost ([72.188.97.40])
        by smtp.gmail.com with ESMTPSA id f66-v6sm342718ywf.46.2018.06.21.14.08.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 14:08:14 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     jic23@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, fabrice.gasnier@st.com,
        benjamin.gaignard@st.com, robh+dt@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mark.rutland@arm.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v7 05/10] counter: 104-quad-8: Documentation: Add Generic Counter sysfs documentation
Date:   Thu, 21 Jun 2018 17:08:08 -0400
Message-Id: <891d9716ce95bd8568296ef53d5b8d266f7efe3e.1529607879.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1529607879.git.vilhelm.gray@gmail.com>
References: <cover.1529607879.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds standard documentation for the Generic Counter interface
userspace sysfs attributes of the 104-QUAD-8 driver.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 .../ABI/testing/sysfs-bus-counter-104-quad-8  | 36 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 37 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-104-quad-8

diff --git a/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8 b/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
new file mode 100644
index 000000000000..062637df3c78
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
@@ -0,0 +1,36 @@
+What:		/sys/bus/counter/devices/counterX/signalY/index_polarity
+KernelVersion:	4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Active level of index input Signal Y; irrelevant in
+		non-synchronous load mode.
+
+What:		/sys/bus/counter/devices/counterX/signalY/index_polarity_available
+What:		/sys/bus/counter/devices/counterX/signalY/synchronous_mode_available
+KernelVersion:	4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Discrete set of available values for the respective Signal Y
+		configuration are listed in this file.
+
+What:		/sys/bus/counter/devices/counterX/signalY/synchronous_mode
+KernelVersion:	4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Configure the counter associated with Signal Y for
+		non-synchronous or synchronous load mode. Synchronous load mode
+		cannot be selected in non-quadrature (Pulse-Direction) clock
+		mode.
+
+		Non-synchronous:
+			A logic low level is the active level at this index
+			input. The index function (as enabled via preset_enable)
+			is performed directly on the active level of the index
+			input.
+
+		Synchronous:
+			Intended for interfacing with encoder Index output in
+			quadrature clock mode. The active level is configured
+			via index_polarity. The index function (as enabled via
+			preset_enable) is performed synchronously with the
+			quadrature clock on the active level of the index input.
diff --git a/MAINTAINERS b/MAINTAINERS
index 4083523699f3..a06fd762f5d9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -270,6 +270,7 @@ ACCES 104-QUAD-8 DRIVER
 M:	William Breathitt Gray <vilhelm.gray@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
 F:	Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
 F:	drivers/counter/104-quad-8.c
 
-- 
2.17.1

