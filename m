Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF36EC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF3C20848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ucNCg8uX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF3C20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbeLCTMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 14:12:23 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41301 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbeLCTMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 14:12:23 -0500
Received: by mail-pf1-f193.google.com with SMTP id b7so6854812pfi.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 11:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Rmoz+GnvijfG+sZ6cBZEt/K/3T1daExHhZntMRQPEuo=;
        b=ucNCg8uXQCT+LG4nYQM5w6dv8e8l8NOuQFs8Cg1jEP6yCzYQAQaWN0S+/4pUqJKsRJ
         yRk1Shmy0A8TGxlubTe2TvJxmNE1onQawN3UzfjJJ7JIkVlspUr35l4yLZW4lRZWXlFf
         rnLFRXRYC/l9rqB9B0Mh4MsltKn0p8H0dJOkQl1pakWKf+LFRca2TLxGZDxLKXTpZiOz
         fK2cHZHtsfdioIVdQIg6DcwSuZcqxAWc37BKq6/mwEnswFIA+/Lhcr1VSFNe4id4R1g2
         xrsR6t3w87bxbhNdzA/yFNWoSGLiR32meFFHw5Bo6LGr1yPQsYcb0DcLRkiMDp8AznpH
         FplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Rmoz+GnvijfG+sZ6cBZEt/K/3T1daExHhZntMRQPEuo=;
        b=eBIbpx1IC6tjF3TySH8hz5SBcVQ32jXlTTIcO+O5gOYOFL2J6rOcABW2ny33EtQ2rB
         4tnJraBkg135HrOOW9fOarvED9ifky6+/LcVWFRRerxrSTVaC64wj6HzNI9Ejl2Bhp0M
         2jNeOuCNagR4rYxc7XdXxXzg6VEu7l+uMOMn5I8IXgm2if7X5/JavYNneUBw/Z8r/LxP
         XoVr3Bd3z3djTVk46qU781RlehzP/Qfi55uXE9Bowk28Qc8ifQp1cmvKXzjQEC/7czjP
         ZNgtkRh6WkCVJEM9nr4KnI60yBiJy2BoAL88kq35m7pUj3C1SpFST8q4Uj/sUY2fMPRl
         i+iQ==
X-Gm-Message-State: AA+aEWaJHqW1UQhwM/yW086misC5k2KuukBGM2eSoCOgkNmDihfrvE6g
        DLTLuHvGMyq9SRqT6ZhhzkVkWM/Z
X-Google-Smtp-Source: AFSGD/WL+IDhPgeA/WRaGmC2Igkv2nMlic7N4HwEkNgIjcZyLDJnotAIN3zIyBNYoVfmGEFtabSQtw==
X-Received: by 2002:a63:5153:: with SMTP id r19mr14127656pgl.281.1543864339536;
        Mon, 03 Dec 2018 11:12:19 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net (igp-prod-emp-gw.vpn.broadcom.com. [192.19.223.250])
        by smtp.gmail.com with ESMTPSA id g15sm67752713pfj.131.2018.12.03.11.12.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 11:12:18 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     will.deacon@arm.com, Florian Fainelli <f.fainelli@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v3] perf: tests: Disable breakpoint tests on ARM (32-bit)
Date:   Mon,  3 Dec 2018 11:11:36 -0800
Message-Id: <20181203191138.2419-1-f.fainelli@gmail.com>
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
ARM 32-bit platforms and update the comment above to explain these
limitations.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v3:

- directly incorporate Will's comment, Will can you add your
  Signed-off-by?

Changes in v2:

- incorporate Will's feedback about comment

 tools/perf/tests/bp_signal.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
index a467615c5a0e..910e25e64188 100644
--- a/tools/perf/tests/bp_signal.c
+++ b/tools/perf/tests/bp_signal.c
@@ -291,12 +291,20 @@ int test__bp_signal(struct test *test __maybe_unused, int subtest __maybe_unused
 
 bool test__bp_signal_is_supported(void)
 {
-/*
- * The powerpc so far does not have support to even create
- * instruction breakpoint using the perf event interface.
- * Once it's there we can release this.
- */
-#if defined(__powerpc__) || defined(__s390x__)
+	/*
+	 * PowerPC and S390 do not support creation of instruction
+	 * breakpoints using the perf_event interface.
+	 *
+	 * ARM requires explicit rounding down of the instruction
+	 * pointer in Thumb mode, and then requires the single-step
+	 * to be handled explicitly in the overflow handler to avoid
+	 * stepping into the SIGIO handler and getting stuck on the
+	 * breakpointed instruction.
+	 *
+	 * Just disable the test for these architectures until these
+	 * issues are resolved.
+	 */
+#if defined(__powerpc__) || defined(__s390x__) || defined(__arm__)
 	return false;
 #else
 	return true;
-- 
2.17.1

