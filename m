Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113DCC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 00:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A0B20828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 00:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rjZHGZRq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8A0B20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbeK0L2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 06:28:12 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38235 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbeK0L2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 06:28:12 -0500
Received: by mail-pf1-f193.google.com with SMTP id q1so7434029pfi.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 16:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WH+FMDA0zft7c90qYN56en1aMYFdJgv8/Ecm6Vojgds=;
        b=rjZHGZRqxLXeM1tk3DAKlE8CaJcQDQnO5HzY5E4Fprcsn7MW2GZLBBwzPmkhW6ZOuk
         QUKo/gjJ6VRcPoxZ7feDHo4BV/Ou/ZfQwpeI6KvJc5UzyU4QvLxHNQu1rh9PY6mUZdVL
         AxZteZ0fRJZCGYJYHLYa9OaIPUqA+xbJ8t53+PEFIK5I7BinFeKEuQ9+cDYSLjCqqm13
         wCby+naKkcPH68XNqdqKXtrrMkpb+73Hl7wXlkNBi0lFz+jHhafbwZ+tCRW/rTqS/4ky
         /VEpoLHhVxyLqL1oN5u2nmZVMuxnDTrlVnZ0zlDwox6vkuLv/HTBOcuvjnrcXsOIvjtv
         YidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WH+FMDA0zft7c90qYN56en1aMYFdJgv8/Ecm6Vojgds=;
        b=X6jkuYThTPneE21hLUo35c6HtlcFw3yaM+Dr0kQ6P8MDbRDJE1YX+YGx3CWS/QPB8k
         Mvev5zUxkN/kCQgZ0iFGhIaImEIf7+TIlYPTaHIbwsFN/kjDDA6aXv6ldRr1pk8uj1Lq
         Z5WhI2Cc7YW0DlsaxXoOFgv0U+0nuHpzMkhlQY/FZH1ztazpTLz5x2y6CYhc1vjrsDHC
         ymYHbHMe6IDqz96ymVzWFOMSVkSKeaaWTVCN4goxosYbliupSG62mJMKvJQDj+955a2q
         J7RgssGfmRR2PE7foGS5Epy5VsZ8QdwzX26czc5TypAxZ8sRIoQUYRP29vH+5vlkviv4
         oAbw==
X-Gm-Message-State: AGRZ1gIEmK14QPT4qLuBM6O1Hll3loyCdtHvU/SJx6A/j1LjNUM8WkEv
        P9uX6mCTaPPCPCzgtY99wynMCV2Z
X-Google-Smtp-Source: AJdET5d5tzGEwJs6lNImm+U/i2EaHoDSUUh9h2N5iD0mu7kA1OX8/HLG2pDsn//C5qlfve44uR4RqA==
X-Received: by 2002:a62:3647:: with SMTP id d68-v6mr30786137pfa.66.1543278732942;
        Mon, 26 Nov 2018 16:32:12 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net (igp-prod-emp-gw.vpn.broadcom.com. [192.19.223.250])
        by smtp.gmail.com with ESMTPSA id q195sm1782295pgq.7.2018.11.26.16.32.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 16:32:12 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     will.deacon@arm.com, Florian Fainelli <f.fainelli@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: [PATCH v2] perf: tests: Disable breakpoint tests on ARM (32-bit)
Date:   Mon, 26 Nov 2018 16:31:23 -0800
Message-Id: <20181127003126.25094-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

breakpoint tests on the ARM 32-bit kernel are broken in several ways.

The breakpoint length requested does not necessarily match whether the
function address has the Thumb bit (bit 0) set or not, and this does
matter to the ARM kernel hw_breakpoint infrastructure. See [1] for
background.

[1]: https://lkml.org/lkml/2018/11/15/205

As Will indicated, the overflow handling would require single-stepping
which is not supported at the moment. Just disable those tests for the
ARM 32-bit platforms.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v2:

- Fix comment above test per Will's feedback

 tools/perf/tests/bp_signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
index a467615c5a0e..05bf06f84a3b 100644
--- a/tools/perf/tests/bp_signal.c
+++ b/tools/perf/tests/bp_signal.c
@@ -292,11 +292,11 @@ int test__bp_signal(struct test *test __maybe_unused, int subtest __maybe_unused
 bool test__bp_signal_is_supported(void)
 {
 /*
- * The powerpc so far does not have support to even create
+ * powerpc, s390 and arm so far does not have support to even create
  * instruction breakpoint using the perf event interface.
  * Once it's there we can release this.
  */
-#if defined(__powerpc__) || defined(__s390x__)
+#if defined(__powerpc__) || defined(__s390x__) || defined(__arm__)
 	return false;
 #else
 	return true;
-- 
2.17.1

