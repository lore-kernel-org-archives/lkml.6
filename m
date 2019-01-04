Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707A1C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 428C5218E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546626945;
	bh=Qhr7gBAFshlt0N08h0Wr4CVEzYA7jPc+4XrY+RnYt3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bGHyXyPHXa9QjTl1+ybieRDGviTLhYi2WxPZKpHe7BiWKHboytASne4S9hO5J9SNy
	 gHl3hKjhW/yBVA9JE7KqGlrqycUz0bwxdtywO3w1kG2te9cAz0K47DpBU9flUaOG7g
	 7Ymk94BvZIlABdrmJinFsGqEbUm6lIANB2VTlqz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbfADSfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 13:35:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:52724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfADSeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 13:34:08 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADF4B218F0;
        Fri,  4 Jan 2019 18:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546626847;
        bh=Qhr7gBAFshlt0N08h0Wr4CVEzYA7jPc+4XrY+RnYt3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oH4mpQOJReQ+te6HIf1vezBfUOIW0zzp8vyXdNiIdMZUpD2cUXRx8FyFsAU1ukNUd
         SCvQccBORHuXT7rb82AB6UR1Mextdw8wX2D/CdaVjcUPNLM7DFS0RdMtQDEk1PL08f
         pGFLfz9DsZWzNpByjH8id/Aghtsor6wn88B5EWLk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 03/16] tools headers uapi: Sync prctl.h with the kernel sources
Date:   Fri,  4 Jan 2019 15:33:24 -0300
Message-Id: <20190104183337.12771-4-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104183337.12771-1-acme@kernel.org>
References: <20190104183337.12771-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get the changes in ba8308856564 ("arm64: add prctl control for
resetting ptrauth keys"), that introduce a prctl with a name that needs
to be catch by the prctl cmd table generator, which will be done in the
next cset.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kristina Martsenko <kristina.martsenko@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Link: https://lkml.kernel.org/n/tip-a1pahzc8lci0ey1fjvv1chdm@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/prctl.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prctl.h
index b17201edfa09..b4875a93363a 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -220,4 +220,12 @@ struct prctl_mm_map {
 # define PR_SPEC_DISABLE		(1UL << 2)
 # define PR_SPEC_FORCE_DISABLE		(1UL << 3)
 
+/* Reset arm64 pointer authentication keys */
+#define PR_PAC_RESET_KEYS		54
+# define PR_PAC_APIAKEY			(1UL << 0)
+# define PR_PAC_APIBKEY			(1UL << 1)
+# define PR_PAC_APDAKEY			(1UL << 2)
+# define PR_PAC_APDBKEY			(1UL << 3)
+# define PR_PAC_APGAKEY			(1UL << 4)
+
 #endif /* _LINUX_PRCTL_H */
-- 
2.20.1

