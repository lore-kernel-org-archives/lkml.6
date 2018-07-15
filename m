Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD6CECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 20:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DE37208FE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 20:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WguS9dny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DE37208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbeGOVKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 17:10:31 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:46293 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbeGOVKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 17:10:30 -0400
Received: by mail-yw0-f196.google.com with SMTP id e23-v6so13022890ywe.13;
        Sun, 15 Jul 2018 13:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5dt/vipaXkszqYOu7qP+nOjtwsDRD6GRQlzoFnZzmXk=;
        b=WguS9dnyjz1DQe8V/735S2m7nlaSVi5qpK2JxC0hxLA5eb257qB4W+u+ebfdVgd+JM
         C7nzYQyAmJxvtWUFqbqvEQtQfWXZMfSrM7Ksw4+C8LK57C9kFjuI8/xLdSFdnJwnTiFU
         +TOqyUR8dN3fxaKBDUPzj9Csu+AdKPmnga4eZI7rlOPxdnFvQ6iDz47I0nTxZhpFhsJd
         OCql5f3MUA5epDKO0fJmDEjeHC49Q527xW7zBXCSmnvczFkdZUgl8YaHWbpWNI2xZmQ2
         /nPd1qSAZ21hx/Fyl55swkelw6jw95SJnBxSFoz9MMLjSwfiSA0HFKW6BmbJi2wi3BkG
         zqYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5dt/vipaXkszqYOu7qP+nOjtwsDRD6GRQlzoFnZzmXk=;
        b=OfviQ/qeTnVY1DFUrHa3JT2QGGCj91oHwY53UkUJT4AtDlgJjsyOJEdyCWindZKwI9
         OazMA2IE2H3jJ2EXjoc3+biDIAmCTaiEPZqM2DOHZNWCJlVa0c45mAXRiXrwgjZNvsfM
         gOCn3XsjeoNbau68FIOW5lpgIYhzlw1dbccKKE54B7WTvh5x1hIt1e0Aau3PUTscwUhj
         bVPaJ9lHkxacUBVL1qeLTAC9iqACt8W3wNhGxaFH1IGySOy9IwnBtBQ63S56UtXxoPM+
         jpBQCys0lsWNw7nr2pHOdSf7tYyLI9n9AC/Uxc11t19vzHQ/YVNtxWiwjLSc/8/bP6Lg
         d9bQ==
X-Gm-Message-State: AOUpUlELXMLEPwqGWKWgZOxxnPMdTCHFT9isj1+KZZA7KRIMjRWbzISO
        dRGWKEge8/d4IqpshKdOWbs=
X-Google-Smtp-Source: AAOMgpc/0IUE+dL6COsYOtQtJ2sfykNg4z7s5l8kh6pKyxwDi2jNCtjftrvI33LMTKsyuUkxdemcUA==
X-Received: by 2002:a81:af5b:: with SMTP id x27-v6mr7296334ywj.68.1531687580385;
        Sun, 15 Jul 2018 13:46:20 -0700 (PDT)
Received: from localhost ([72.188.97.40])
        by smtp.gmail.com with ESMTPSA id r12-v6sm1580720ywg.67.2018.07.15.13.46.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jul 2018 13:46:19 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     gregkh@linuxfoundation.org, jic23@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        fabrice.gasnier@st.com, benjamin.gaignard@st.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v8 06/11] counter: 104-quad-8: Documentation: Add Generic Counter sysfs documentation
Date:   Sun, 15 Jul 2018 16:46:14 -0400
Message-Id: <0fe263bc6bb36208eaa2fbcd83fa04fd22fb597e.1531685025.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1531685024.git.vilhelm.gray@gmail.com>
References: <cover.1531685024.git.vilhelm.gray@gmail.com>
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

