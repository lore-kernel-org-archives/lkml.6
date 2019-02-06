Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F921C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3845218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549478965;
	bh=/q7x/vk96FIgQWXaWpdhuJ13mpWWbRBU9Fo3EMkk6/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wIBeAkdRRiWz/WwJSc7Z4c7+7QIpKJLa6Dj/QdXA6aRApJ4/UQTnaog7EM6WRIXmE
	 SyN2soJHT6EAnhyZaS3kOkzDtqQ55Ana/kIC2mCXLO8GipNzBHmaqm3wqKnnrry6uO
	 N1Kw5VYPns2Ea7QhznKI2ZFqkiQ6fzOgqfYZqNFw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfBFStY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:49:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:43618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbfBFStV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:49:21 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9810218B0;
        Wed,  6 Feb 2019 18:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549478960;
        bh=/q7x/vk96FIgQWXaWpdhuJ13mpWWbRBU9Fo3EMkk6/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZJ0suMNj+YcO/nzogoRjGOEwsS0LjtHxcMSUomjQEWREFixcXP5VJ4jkrqgi8D/KI
         P6DhfgE75Fc1nRASWPaN4QaIXAUd0KelE/6CG0uc1NjHYClLmCSNburec/uFx1/s9d
         ghQ+ztUVtIXQSn9KggULdnKm2Na2iUhtUDdP/Brw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Maynard Johnson <maynard@us.ibm.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: [PATCH 01/53] perf powerpc: Add missing headers to skip-callchain-idx.c
Date:   Wed,  6 Feb 2019 15:48:11 -0300
Message-Id: <20190206184903.24054-2-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

It uses several structs but don't explicitely includes the headers where
they are defined, getting them by sheer luck from one of the headers it
includes, since those are being streamlined to avoid unnecessary
rebuilds when changes are made to a random header, they will break, fix
them now so that they continue to build.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Maynard Johnson <maynard@us.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Sandipan Das <sandipan@linux.ibm.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Link: https://lkml.kernel.org/n/tip-j1nyksegpnz36wi3qx2p46i1@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/util/skip-callchain-idx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/arch/powerpc/util/skip-callchain-idx.c b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
index 7c6eeb4633fe..2918bb16c892 100644
--- a/tools/perf/arch/powerpc/util/skip-callchain-idx.c
+++ b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
@@ -16,6 +16,9 @@
 #include "util/thread.h"
 #include "util/callchain.h"
 #include "util/debug.h"
+#include "util/dso.h"
+#include "util/map.h"
+#include "util/symbol.h"
 
 /*
  * When saving the callchain on Power, the kernel conservatively saves
-- 
2.20.1

