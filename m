Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF599C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 20:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B89208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 20:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rN/vbIMY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91B89208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731986AbeG3W1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 18:27:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:43294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728714AbeG3W1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 18:27:33 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB01820894;
        Mon, 30 Jul 2018 20:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532983847;
        bh=IobmKNc5rN8Ok5wo1zlEIMXPRU/G53XYNdRcmXCoQXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rN/vbIMYdBBrySmfo5zdkHbTbB11ngVXOAysttrfDyOShhuiCfXHKR24QUySuYLoC
         RAFAUBEvfszWh1NyfvfQVIcWyUCs1S83oth/Ja+0rjvrtm0WCpfCmlqcoP7ojUPglm
         qbA3MheIUTbwPdaMIy5f+2qMyFMrTaW9Kum4ecak=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 1/5] tools headers uapi: Update tools's copy of linux/perf_event.h
Date:   Mon, 30 Jul 2018 17:50:27 -0300
Message-Id: <20180730205031.12853-2-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180730205031.12853-1-acme@kernel.org>
References: <20180730205031.12853-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get the changes in:

  6cbc304f2f36 ("perf/x86/intel: Fix unwind errors from PEBS entries (mk-II)")

That do not imply any changes in the tooling side, the (ab)use of
sample_type is entirely done in kernel space, nothing for userspace to
witness here.

This cures the following warning during perf's build:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/perf_event.h' differs from latest version at 'include/uapi/linux/perf_event.h'

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-o64mjoy35s9gd1gitunw1zg4@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/perf_event.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index b8e288a1f740..eeb787b1c53c 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -143,6 +143,8 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
 
 	PERF_SAMPLE_MAX = 1U << 20,		/* non-ABI */
+
+	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63,
 };
 
 /*
-- 
2.14.4

