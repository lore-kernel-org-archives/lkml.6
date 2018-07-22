Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE84C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012BE2086A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3kp7ueo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 012BE2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387765AbeGVXti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 19:49:38 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:42141 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387732AbeGVXti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 19:49:38 -0400
Received: by mail-yb0-f195.google.com with SMTP id c10-v6so6594919ybf.9;
        Sun, 22 Jul 2018 15:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5dt/vipaXkszqYOu7qP+nOjtwsDRD6GRQlzoFnZzmXk=;
        b=h3kp7ueo7GNaS1p8QXoXmbFhaCKXh+MZL3jSI+VKbZ5kg02BuSOpEuvYsbNAOo7ap3
         svBS88qFGbNJsRXGQy5Ojlv5nrrv6wG6ibYo1SRtTQLv/1v2A3M3uyyEDiQ/lSC0kV3/
         jDB3DxiHqCPoU15sklGp7GK2pXyfETv7w/qBu7HMh7rYuRLIp0Rq6zG1dt+QIceLjXeP
         PkCkrFxadq5G4ErNOkdsv4Wwb4mkuel/YHyStGo2d1NP0ku6GC+eWSiXQ05tQSnurD9B
         TYXmOpUOsMdRDpvy7nZjDLWYnNQayt47cL26N4U/LDgbj/TciPjPMJdO2ZLFlF4NMCUU
         w3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5dt/vipaXkszqYOu7qP+nOjtwsDRD6GRQlzoFnZzmXk=;
        b=G+4I2v0VrqJG7SSks06Fn6Vu010YRvtIzWBwNxcPiywEaNYyVTq3yjoX3UGUxiI6L/
         9srD7vPM/nmoiVUDo2QaKipSjXuIYvw1fMNIXAfScCfKkdkXQL9DL+C89zAq/LGzwfZZ
         Olanret5FR2LNDB1b9VlarXcEJmgrTqMFG/TkFtpucyoSV40udGraMMJCsMQp9Eahtxs
         rgOqVTAnF/Dli3C1lTJO7sjWOmVtMZyl3ggAb+xMjnNjFYysvpuNdSRpmTFOZF6uEPzC
         mhuyHx34RInxbXrOK34Gh+mhmZwagk0VAhVC1TrTLtqINHe9DFa6vCqsVNzzmJDKq7V6
         izSw==
X-Gm-Message-State: AOUpUlEDLVYxvO47PgbDhLumC8E5xO4tG5zqQeGu3fwoV/6RQaIiPucq
        2Z+kRWOBFXzwSscGKC1VP+8=
X-Google-Smtp-Source: AAOMgpf4N2HetptsgzygpEfmS0JJNzOL/UUwFP0qc2qDfnpiO1cXFWZjdra9jqAireJHhy+kiOBxxA==
X-Received: by 2002:a25:dbce:: with SMTP id g197-v6mr4328470ybf.333.1532299879608;
        Sun, 22 Jul 2018 15:51:19 -0700 (PDT)
Received: from localhost ([72.188.97.40])
        by smtp.gmail.com with ESMTPSA id q184-v6sm3767091ywd.78.2018.07.22.15.51.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 15:51:19 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     jic23@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, fabrice.gasnier@st.com,
        benjamin.gaignard@st.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, akpm@linux-foundation.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v9 06/11] counter: 104-quad-8: Documentation: Add Generic Counter sysfs documentation
Date:   Sun, 22 Jul 2018 18:51:13 -0400
Message-Id: <3f51391e2bb036b332a518503d60f15fe1dfddd9.1532298882.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1532298882.git.vilhelm.gray@gmail.com>
References: <cover.1532298882.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds standard documentation for the Generic Counter interface
userspace sysfs attributes of the 104-QUAD-8 driver.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 .../ABI/testing/sysfs-bus-counter-104-quad-8  | 36 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 37 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-104-quad-8

diff --git a/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8 b/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
new file mode 100644
index 000000000000..2d9fa57af101
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
+		non-synchronous:
+			A logic low level is the active level at this index
+			input. The index function (as enabled via preset_enable)
+			is performed directly on the active level of the index
+			input.
+
+		synchronous:
+			Intended for interfacing with encoder Index output in
+			quadrature clock mode. The active level is configured
+			via index_polarity. The index function (as enabled via
+			preset_enable) is performed synchronously with the
+			quadrature clock on the active level of the index input.
diff --git a/MAINTAINERS b/MAINTAINERS
index f41c45246e2b..865c47a3feae 100644
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
2.18.0

