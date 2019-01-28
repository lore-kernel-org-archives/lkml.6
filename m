Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D1BC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E9B2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690834;
	bh=f2bfUr/EtzNT43pnnLIalrWvmm4G99uDBUZcdRjpS2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KUaGU0uUjBkHRJX+0+Hwf8gSidqo1wgKz8Nm7l+ivMqmGlg5xakPfwhzn3Vgkq807
	 5mjiqPwANknDkpFrK42jRhkWAkxhtRLFnSMMAUgwMDolg0xVuj1u/lGSlvBpCiwzId
	 O7+Y7nKLTPC74IFeTorxQM5mLY+PfrpvVLB9S57s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbfA1Pxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:53:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:40102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729532AbfA1Pxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:53:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 183D320880;
        Mon, 28 Jan 2019 15:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690828;
        bh=f2bfUr/EtzNT43pnnLIalrWvmm4G99uDBUZcdRjpS2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NgkbhgaNBz0dYbf29EUlnafUHiCd3QOPZS6oKBmmwauziNrBNMPLg0fqupXVP7F7m
         FrNBYMF6BX00r2Ees7tJUJXFN6afeXT3Il5cnRRAVyv29PiG3s/3dSZSOWJMlrQaHs
         4mSfANOlCo/6y8pBGsB2yZuo0+kGg9vQAM1kZv0A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Doug Smythies <doug.smythies@gmail.com>,
        Doug Smythies <dsmythies@telus.net>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 205/304] tools/power/x86/intel_pstate_tracer: Fix non root execution for post processing a trace file
Date:   Mon, 28 Jan 2019 10:42:02 -0500
Message-Id: <20190128154341.47195-205-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Doug Smythies <doug.smythies@gmail.com>

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

