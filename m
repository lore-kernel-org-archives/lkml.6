Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38A6C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E5520883
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="DFch6TlW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52E5520883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388037AbeIYBIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 21:08:06 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46460 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731542AbeIYBIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 21:08:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id z3-v6so8957015wrr.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 12:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6E4+VPjtB94gJyVOtzNM+qGka7vvhkBZMLrEEDusNF8=;
        b=DFch6TlWvHU3BjCFhugwRc0uJ9IFby1P4WNiK8cTIU1UdggWNFcKpuznFtq8NjfW0R
         ylax0kvSksRMTx3SSnv/Aaozm1tA5sFgtIfcLSi/W5+FlZ25LIspLehEZMEAVOAbcHou
         WSt96xXlu66XmKc3Em9cQhCzVMEbKpxTOFqB7gAgzPXD3DesLBlat6fmMs6lIFs+FLy2
         kVDkLSiaJ9oTzoLTAVg6CTcAL5Vj9Xqm2wZm/xUz4Q2Xe+aHb+OyF0L6jmJszHXG98vu
         stZGI/cEpUev7dtRXjRuuYu6ox5csQPt+S8yvaZ8+stUnd/LO0SyUdgSjm/NbCxdbcFm
         PHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6E4+VPjtB94gJyVOtzNM+qGka7vvhkBZMLrEEDusNF8=;
        b=iu0+FnEYelZ2OYQbGQBUUBGzflmixM8/uVKsTm9tUXu+qvy9hOdk6uiOkozu2V9YtZ
         VXI2kBpkluUqggoQhFsECzEMf6GGW4MnK0EKt2seyJAUft+fAEBKYIXt8RGPOvyZbFCe
         eaJ5Fbvtt9oX2M2FPYhyg+maFPgpV0/p2bLsOB7uah6BJsmC/PU7ehQQpMLoeqrl4zPi
         fKrRvUycPHmtoKdO3Jnq/qKbi7A9F/kkqW9Fj2DD/3dqpOuBpbwpXwTrwTpi4FDyAEdo
         cxImJkwToib3FahhFTLyCtV6+xGo13wOeuKeRjOXjzwpDklIAvpFPXVra+l0pJqSViAR
         qkKQ==
X-Gm-Message-State: ABuFfoicsSf3kyZUqYThupoXr//2hJ34vaSYi7fnYDCR1Tvh1WCXg19O
        2ttMpag9sM8ne5lwYTB6npvywg==
X-Google-Smtp-Source: ACcGV63LfsE3461zNLXOFeDMzsJgBaNQTjjw/sXPLWbNtKpDZCLuC4pwSEfcO96nQKkwH748H0caLw==
X-Received: by 2002:a5d:61c1:: with SMTP id q1-v6mr150645wrv.33.1537815868736;
        Mon, 24 Sep 2018 12:04:28 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id e141-v6sm27721433wmd.32.2018.09.24.12.04.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Sep 2018 12:04:28 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     Gilles.Muller@lip6.fr, Julia.Lawall@lip6.fr, agust@denx.de,
        airlied@linux.ie, alexandre.torgue@st.com, alistair@popple.id.au,
        benh@kernel.crashing.org, carlo@caione.org, davem@davemloft.net,
        galak@kernel.crashing.org, joabreu@synopsys.com,
        khilman@baylibre.com, maxime.ripard@bootlin.com,
        michal.lkml@markovi.net, mpe@ellerman.id.au,
        mporter@kernel.crashing.org, narmstrong@baylibre.com,
        nicolas.palix@imag.fr, oss@buserror.net, paulus@samba.org,
        peppe.cavallaro@st.com, tj@kernel.org, vitb@kernel.crashing.org,
        wens@csie.org
Cc:     cocci@systeme.lip6.fr, dri-devel@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        netdev@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 2/7] include: add setbits32/clrbits32/clrsetbits32/setbits64/clrbits64/clrsetbits64 in linux/setbits.h
Date:   Mon, 24 Sep 2018 19:04:11 +0000
Message-Id: <1537815856-31728-3-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537815856-31728-1-git-send-email-clabbe@baylibre.com>
References: <1537815856-31728-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds setbits32/clrbits32/clrsetbits32 and
setbits64/clrbits64/clrsetbits64 in linux/setbits.h header.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 include/linux/setbits.h | 88 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 include/linux/setbits.h

diff --git a/include/linux/setbits.h b/include/linux/setbits.h
new file mode 100644
index 000000000000..6e7e257134ae
--- /dev/null
+++ b/include/linux/setbits.h
@@ -0,0 +1,88 @@
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
+	writefunction(((readfunction(addr) | (set)) & ~(mask)), addr)
+
+#ifndef setbits_le32
+#define setbits_le32(addr, set) __setbits(readl, writel, addr, set)
+#endif
+#ifndef setbits_le32_relaxed
+#define setbits_le32_relaxed(addr, set) __setbits(readl_relaxed, writel_relaxed, \
+					       addr, set)
+#endif
+
+#ifndef clrbits_le32
+#define clrbits_le32(addr, mask) __clrbits(readl, writel, addr, mask)
+#endif
+#ifndef clrbits_le32_relaxed
+#define clrbits_le32_relaxed(addr, mask) __clrbits(readl_relaxed, writel_relaxed, \
+						addr, mask)
+#endif
+
+#ifndef clrsetbits_le32
+#define clrsetbits_le32(addr, mask, set) __clrsetbits(readl, writel, addr, mask, set)
+#endif
+#ifndef clrsetbits_le32_relaxed
+#define clrsetbits_le32_relaxed(addr, mask, set) __clrsetbits(readl_relaxed, \
+							   writel_relaxed, \
+							   addr, mask, set)
+#endif
+
+#ifndef setclrbits_le32
+#define setclrbits_le32(addr, mask, set) __setclrbits(readl, writel, addr, mask, set)
+#endif
+#ifndef setclrbits_le32_relaxed
+#define setclrbits_le32_relaxed(addr, mask, set) __setclrbits(readl_relaxed, \
+							   writel_relaxed, \
+							   addr, mask, set)
+#endif
+
+/* We cannot use CONFIG_64BIT as some x86 drivers use non-atomicwriteq() */
+#if defined(writeq) && defined(readq)
+#ifndef setbits_le64
+#define setbits_le64(addr, set) __setbits(readq, writeq, addr, set)
+#endif
+#ifndef setbits_le64_relaxed
+#define setbits_le64_relaxed(addr, set) __setbits(readq_relaxed, writeq_relaxed, \
+					       addr, set)
+#endif
+
+#ifndef clrbits_le64
+#define clrbits_le64(addr, mask) __clrbits(readq, writeq, addr, mask)
+#endif
+#ifndef clrbits_le64_relaxed
+#define clrbits_le64_relaxed(addr, mask) __clrbits(readq_relaxed, writeq_relaxed, \
+						addr, mask)
+#endif
+
+#ifndef clrsetbits_le64
+#define clrsetbits_le64(addr, mask, set) __clrsetbits(readq, writeq, addr, mask, set)
+#endif
+#ifndef clrsetbits_le64_relaxed
+#define clrsetbits_le64_relaxed(addr, mask, set) __clrsetbits(readq_relaxed, \
+							   writeq_relaxed, \
+							   addr, mask, set)
+#endif
+
+#ifndef setclrbits_le64
+#define setclrbits_le64(addr, mask, set) __setclrbits(readq, writeq, addr, mask, set)
+#endif
+#ifndef setclrbits_le64_relaxed
+#define setclrbits_le64_relaxed(addr, mask, set) __setclrbits(readq_relaxed, \
+							   writeq_relaxed, \
+							   addr, mask, set)
+#endif
+
+#endif /* writeq/readq */
+
+#endif /* __LINUX_SETBITS_H */
-- 
2.16.4

