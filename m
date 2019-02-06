Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC78C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C2ED218E0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549479006;
	bh=NAHuqjPwCMph1IT37vd+XyMpekbf1hTQrjVcEX5vZbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f/hjNRTaHE7zW4MXWLb06utkI2tz1W+3pInwfijofHLH5E7k6xpYecKYw7xBn0cXX
	 bUC/EPDNGbDvMZk5vDbXqyBVSsO3HgHmU0BeBS1xVihnbANmTBZuDR/lmXZ2QNsL5w
	 ry8zNuR9gPjbx0AFA7vqhtH0fam6ZkHw2i7x6CKM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfBFSuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:50:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:44324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbfBFSuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:50:02 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A2642083B;
        Wed,  6 Feb 2019 18:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549479002;
        bh=NAHuqjPwCMph1IT37vd+XyMpekbf1hTQrjVcEX5vZbI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KTWCRTXuXKJQYsS0lMYK5js4aX9wio8FCA0KU+PM/6hWJMgknQzxkC0wvQaD3ziIL
         i0KGqyYbSngKKjiLaZdO292mzp6AStd7/C71P+MNeLUIi36gujVD9upaYnLercf83i
         1+zT7bX+fMzzKWUIovHMroUj99jxxGJIVlDN1X88=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Hemant Kumar <hemant@linux.vnet.ibm.com>
Subject: [PATCH 18/53] perf powerpc kvm-stat: Add missing evlist.h header
Date:   Wed,  6 Feb 2019 15:48:28 -0300
Message-Id: <20190206184903.24054-19-acme@kernel.org>
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

This header was being obtained indirectly, by sheer luck, add it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Hemant Kumar <hemant@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-c3h8oyav16iu5ivput8n4wt6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/util/kvm-stat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/arch/powerpc/util/kvm-stat.c b/tools/perf/arch/powerpc/util/kvm-stat.c
index 86e64c47d8ea..f9db341c47b6 100644
--- a/tools/perf/arch/powerpc/util/kvm-stat.c
+++ b/tools/perf/arch/powerpc/util/kvm-stat.c
@@ -4,6 +4,7 @@
 #include "util/parse-events.h"
 #include "util/debug.h"
 #include "util/evsel.h"
+#include "util/evlist.h"
 
 #include "book3s_hv_exits.h"
 #include "book3s_hcalls.h"
-- 
2.20.1

