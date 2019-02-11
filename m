Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63835C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B35020700
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896383;
	bh=hI8SFfTGP1xfV5hVeKkjTyonaUhsLxOhpp/CuRRV7ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LT2MjTeIXnr1eUYrpw+QjOatf0yPizvUFI0z7cxAepQO1gyaAwer4X5ERZTY/gHks
	 WAqkNbqqDeaYxUZl+0fglxZBaemYgSi6/1XSgdw3EE6hJrwusQ8smzkdbA7T8VO4Cn
	 rfyfGRzY93+Bykma+hQwkmCptAZK4vZmgoh5CgWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733227AbfBKOqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:46:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:59452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733205AbfBKOqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:46:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1217520700;
        Mon, 11 Feb 2019 14:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896378;
        bh=hI8SFfTGP1xfV5hVeKkjTyonaUhsLxOhpp/CuRRV7ns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CfsBkz2ebuLF9YThdDjcpXeqqeoEEkmFHyXrP/4wxk767ryyoP2fypvvwPsaFyhVt
         MpSCg83y+wm8TF7ZELRXGRzs7J8/A59xRDc1ozM2zii6B8Xi6PWPLCNCohRNAYRP1t
         Q5FFzxLA0juGNOxPW2RsYS5A6ZwGiQ/ksL5UYwoI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Doug Smythies <dsmythies@telus.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 165/313] tools/power/x86/intel_pstate_tracer: Fix non root execution for post processing a trace file
Date:   Mon, 11 Feb 2019 15:17:25 +0100
Message-Id: <20190211141904.465797342@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 663546903c835fe46308b1b1e53d32d1f2b33da9 ]

This script is supposed to be allowed to run with regular user
privileges if a previously captured trace is being post processed.

Commit fbe313884d7d (tools/power/x86/intel_pstate_tracer: Free the
trace buffer memory) introduced a bug that breaks that option.

Commit 35459105deb2 (tools/power/x86/intel_pstate_tracer: Add
optional setting of trace buffer memory allocation) moved the code
but kept the bug.

This patch fixes the issue.

Fixes: 35459105deb2 (tools/power/x86/intel_pstate_tracer: Add optional ...)
Signed-off-by: Doug Smythies <dsmythies@telus.net>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
index 84e2b648e622..2fa3c5757bcb 100755
--- a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
+++ b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
@@ -585,9 +585,9 @@ current_max_cpu = 0
 
 read_trace_data(filename)
 
-clear_trace_file()
-# Free the memory
 if interval:
+    clear_trace_file()
+    # Free the memory
     free_trace_buffer()
 
 if graph_data_present == False:
-- 
2.19.1



