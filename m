Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206EAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D933321848
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550712391;
	bh=+Rm0SeVSVb94j9taK2hCbKk/TUFtdqxjgVkjKC096ME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v8EisuNZ6eSsenyxTlIP+E1ui0JF091wf1WRLjHi1C8r0H5qkCy+rKqjhNi/GYROH
	 oJFqvzd/LyxhQ4a6rjVUFDeDmeeCJoqqr6gToOzVbk/REThE1c4cGCdkMq8J+7V+2c
	 z1WeaAqgBfc5KVjEiS200l3TzkEUN16lvpuVE45k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbfBUB0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 20:26:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:59294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727249AbfBUB03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 20:26:29 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.102.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BFDB21841;
        Thu, 21 Feb 2019 01:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550712388;
        bh=+Rm0SeVSVb94j9taK2hCbKk/TUFtdqxjgVkjKC096ME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PNE2mNJFG9rog5rv9g+9k/hRX5uCFD0egUmEDL/d44pcYjHZxzWCuN7yxYedF9hkF
         gwIib6yoQGTmK5WQBMnpg9OmATd1wMN6p1JziFj5yGJHux1BdbpzbmwJ9wkG1V1n01
         Orj/gQlGOPBXFMOkuiW6bA3zMIUNT3ALp77nIOLs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 08/17] perf doc: Fix documentation of the Flags section in perf.data
Date:   Wed, 20 Feb 2019 22:25:40 -0300
Message-Id: <20190221012549.4069-9-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190221012549.4069-1-acme@kernel.org>
References: <20190221012549.4069-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>

According to the current documentation the flags section is placed after
the file header itself but the code assumes to find the flags section
after the data section. This change updates the documentation to that
assumption.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Link: http://lkml.kernel.org/r/20190219154515.3954-2-jonas.rabenstein@studium.uni-erlangen.de
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf.data-file-format.txt | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index 5f9a3924830b..593ef49b273c 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -43,11 +43,10 @@ struct perf_file_section {
 
 Flags section:
 
-The header is followed by different optional headers, described by the bits set
-in flags. Only headers for which the bit is set are included. Each header
-consists of a perf_file_section located after the initial header.
-The respective perf_file_section points to the data of the additional
-header and defines its size.
+For each of the optional features a perf_file_section it placed after the data
+section if the feature bit is set in the perf_header flags bitset. The
+respective perf_file_section points to the data of the additional header and
+defines its size.
 
 Some headers consist of strings, which are defined like this:
 
-- 
2.19.1

