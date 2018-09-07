Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD225C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E85120844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0JTsFfyt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E85120844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbeIHAYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 20:24:48 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40522 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbeIHAYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 20:24:48 -0400
Received: by mail-wm0-f68.google.com with SMTP id 207-v6so15565592wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 12:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2OBVCDONGEzIwTm7QfSFZEKxjwVO4pekD/4rVjP1wLE=;
        b=0JTsFfytjLjlW8adkFTtXKjzuqmxH5bQeUHfO575Wp6BlZusLZmwGH+2UqmV75F6Oa
         c54j7sFdBh3f6iHYH1e4yXsrMZcAVNpegkdv0fuDmSGJ0Ig4cn4XnMhjhfAAjTxflUZV
         HWCxENCPENNdkvi8Rzx0KV6g8JGNNb3/MzQbvoi3UflS6GC3Bs6uLOfMSakge5Cmslv8
         voxm9R+dyIE0A4q/tGMzCGS+7vFyLRL2LY47sJY7ZlyXVQXtprYb2kt3hPxUukU6hZYW
         tK91IAU5fAYkHClcS25SlGPvZ/YalZEmoEy10K24VpuFrVv9RcacI7wDILN38P8qrBoe
         OYhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2OBVCDONGEzIwTm7QfSFZEKxjwVO4pekD/4rVjP1wLE=;
        b=AmiG597LbYw+AAtirSIkM6m2RpdRnYVtIZ9AbRSmxFM3+2YQYVv6Qi0Uu9k92l/MtX
         BVrBZtVyg4UCxIc2Xj9NuqsvrnbXlMonDWz/V79QgUGf7bufFuLfUe9mlmf8a37fx+p5
         9+DL0oCxITkrgx9f6DsdRidjqmVe5T+1wr1sUT6J/RdeUmr+tBhs5HtxtIDR0xknOWNb
         b9JOrkCniRxHYcnLjEnHe2jKOtmseC1fGFHvmF8FxRBO8va7YbjuRMvm5mUJMwZ0JwdG
         rGxomQbRRZiMbfeP5IdDeUyvqGFoTuNcaplNXSa91mtZsp78Qc0++RYojJM1i/d2Srxr
         D9yw==
X-Gm-Message-State: APzg51DORTn+suhPuX7zzgHmVWa2fwmLS/mIunXd3LX1xD1BDi4RGVay
        1z9j8jWnuz3XC1TtqSyWza9J0w==
X-Google-Smtp-Source: ANB0Vda3a1G3h/a0T7QOpgIWFBqrTWDEHU2LI/VoQLK/4NyCFWEZeJPvihMr17URkYAc7FNgfNxKBw==
X-Received: by 2002:a1c:70b:: with SMTP id 11-v6mr6061230wmh.151.1536349341273;
        Fri, 07 Sep 2018 12:42:21 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id y17-v6sm11700133wrh.49.2018.09.07.12.42.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Sep 2018 12:42:20 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     Gilles.Muller@lip6.fr, Julia.Lawall@lip6.fr, agust@denx.de,
        alexandre.torgue@st.com, alistair@popple.id.au,
        benh@kernel.crashing.org, carlo@caione.org, davem@davemloft.net,
        galak@kernel.crashing.org, joabreu@synopsys.com,
        khilman@baylibre.com, maxime.ripard@bootlin.com,
        michal.lkml@markovi.net, mpe@ellerman.id.au,
        mporter@kernel.crashing.org, nicolas.palix@imag.fr,
        oss@buserror.net, paulus@samba.org, peppe.cavallaro@st.com,
        tj@kernel.org, vitb@kernel.crashing.org, wens@csie.org
Cc:     cocci@systeme.lip6.fr, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        netdev@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 2/5] include: add setbits32/clrbits32/clrsetbits32/setbits64/clrbits64/clrsetbits64 in linux/setbits.h
Date:   Fri,  7 Sep 2018 19:41:44 +0000
Message-Id: <1536349307-20714-3-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536349307-20714-1-git-send-email-clabbe@baylibre.com>
References: <1536349307-20714-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds setbits32/clrbits32/clrsetbits32 and
setbits64/clrbits64/clrsetbits64 in linux/setbits.h header.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 include/linux/setbits.h | 55 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 include/linux/setbits.h

diff --git a/include/linux/setbits.h b/include/linux/setbits.h
new file mode 100644
index 000000000000..3e1e273551bb
--- /dev/null
+++ b/include/linux/setbits.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_SETBITS_H
+#define __LINUX_SETBITS_H
+
+#include <linux/io.h>
+
+#define __setbits(readfunction, writefunction, addr, set) \
+	writefunction((readfunction(addr) | (set)), addr)
+#define __clrbits(readfunction, writefunction, addr, mask) \
+	writefunction((readfunction(addr) & ~(mask)), addr)
+#define __clrsetbits(readfunction, writefunction, addr, mask, set) \
+	writefunction(((readfunction(addr) & ~(mask)) | (set)), addr)
+#define __setclrbits(readfunction, writefunction, addr, mask, set) \
+	writefunction(((readfunction(addr) | (seti)) & ~(mask)), addr)
+
+#define setbits32(addr, set) __setbits(readl, writel, addr, set)
+#define setbits32_relaxed(addr, set) __setbits(readl_relaxed, writel_relaxed, \
+					       addr, set)
+
+#define clrbits32(addr, mask) __clrbits(readl, writel, addr, mask)
+#define clrbits32_relaxed(addr, mask) __clrbits(readl_relaxed, writel_relaxed, \
+						addr, mask)
+
+#define clrsetbits32(addr, mask, set) __clrsetbits(readl, writel, addr, mask, set)
+#define clrsetbits32_relaxed(addr, mask, set) __clrsetbits(readl_relaxed, \
+							   writel_relaxed, \
+							   addr, mask, set)
+
+#define setclrbits32(addr, mask, set) __setclrbits(readl, writel, addr, mask, set)
+#define setclrbits32_relaxed(addr, mask, set) __setclrbits(readl_relaxed, \
+							   writel_relaxed, \
+							   addr, mask, set)
+
+/* We cannot use CONFIG_64BIT as some x86 drivers use writeq */
+#if defined(writeq) && defined(readq)
+#define setbits64(addr, set) __setbits(readq, writeq, addr, set)
+#define setbits64_relaxed(addr, set) __setbits(readq_relaxed, writeq_relaxed, \
+					       addr, set)
+
+#define clrbits64(addr, mask) __clrbits(readq, writeq, addr, mask)
+#define clrbits64_relaxed(addr, mask) __clrbits(readq_relaxed, writeq_relaxed, \
+						addr, mask)
+
+#define clrsetbits64(addr, mask, set) __clrsetbits(readq, writeq, addr, mask, set)
+#define clrsetbits64_relaxed(addr, mask, set) __clrsetbits(readq_relaxed, \
+							   writeq_relaxed, \
+							   addr, mask, set)
+
+#define setclrbits64(addr, mask, set) __setclrbits(readq, writeq, addr, mask, set)
+#define setclrbits64_relaxed(addr, mask, set) __setclrbits(readq_relaxed, \
+							   writeq_relaxed, \
+							   addr, mask, set)
+#endif /* writeq/readq */
+
+#endif /* __LINUX_SETBITS_H */
-- 
2.16.4

