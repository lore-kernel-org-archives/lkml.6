Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E55EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E8AD2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEBAxUrN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbeLRHeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 02:34:23 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44130 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbeLRHeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 02:34:22 -0500
Received: by mail-pl1-f196.google.com with SMTP id e11so6768605plt.11;
        Mon, 17 Dec 2018 23:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=89ioE85xGfwIk5v/eywLc7SJIndono/jZP2nRAyGXpM=;
        b=KEBAxUrNJjbT+12xRTedY0U/Qau0UeHxsH7p65mq44eDgGQ6M73PGg3mT/DBOysADY
         aPkaBtfUSoQSmm4smczvaDnFOj8f0XeNlOIr8iT1oGxudz815QG4V9ogEkG37IPEMug7
         4St7c2XH6kgpv/hBuFP4Fh1XakOdOM3KjcNN/4Pxzha9THb9dRcm+mwTAC6XAyUFdyCl
         0lKGnblFCvQR5TxYrdAxbpJkWdjaNg9+tvcbndQ3iasn+l8o01yMvIx7zqvazQXlkBIA
         M69lc3Nozetjuq29aVcP/yBrZrDzClePcNNzefQWH/7MsHr2dd//X/ANO/cUtg9M7RAT
         bFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=89ioE85xGfwIk5v/eywLc7SJIndono/jZP2nRAyGXpM=;
        b=LdaHkQQfne1f+1IOd9H/iIfWKQ7D73/U4er7uaEs+0Q/UQFiuaA+QEHBK+dHmX/TQ4
         +4CLdbsR/p33nqI/OhK4VWnwaj3gLEoANGDdC40petGAvf9CgHa7GWLHAa0Na5N9bESx
         apalHrz4RrgIo15fIqu4P9YHAY6mHTxSiJCakQVtlh7rAX8QRsD1wOiOvJ/OVnu7rSlC
         +MBJKORULdyfrI8vkZkIrCClu/ZBaKbPsuV1ezm6QGLzCUd4nTvTsSUxzu4lt85GSWpw
         NmW8lplmWEfs2m/X+JGe4RJsEP/bMjONn0sVaiLZP04GlGb6quk3/XvnoGXY91pveaLP
         xbfA==
X-Gm-Message-State: AA+aEWYbB08AZbk/kfMgKoGYlc2x1kTNsoFVI/NaqP/9ju8WYzaSVOHn
        f6AQtLniwvF8XH/gQL0L0eA=
X-Google-Smtp-Source: AFSGD/V2/rQI+F+GIADx/dBNG6WFlkRRD4F2rGVV5AHswU0MPzLidjAR1g71YjcDB8voiR8XlceuNg==
X-Received: by 2002:a17:902:f091:: with SMTP id go17mr15855480plb.235.1545118462320;
        Mon, 17 Dec 2018 23:34:22 -0800 (PST)
Received: from s15.smythies.com (mail.smythies.com. [173.180.45.4])
        by smtp.gmail.com with ESMTPSA id n66sm21659602pfk.19.2018.12.17.23.34.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Dec 2018 23:34:21 -0800 (PST)
From:   Doug Smythies <doug.smythies@gmail.com>
X-Google-Original-From: Doug Smythies <dsmythies@telus.net>
To:     srinivas.pandruvada@linux.intel.com, rjw@rjwysocki.net
Cc:     dsmythies@telus.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH] tools/power/x86/intel_pstate_tracer: Fix non root execution for post processing a trace file.
Date:   Mon, 17 Dec 2018 23:34:04 -0800
Message-Id: <1545118444-5008-1-git-send-email-dsmythies@telus.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This script is supposed to be allowed to run with regular user privileges
if a previously captured trace is being post processed.

Commit fbe313884d7ddd73ce457473cbdf3763f5b1d3da
tools/power/x86/intel_pstate_tracer: Free the trace buffer memory
introduced a bug that breaks that option.

Commit 35459105deb26430653a7299a86bc66fb4dd5773
tools/power/x86/intel_pstate_tracer: Add optional setting of trace buffer memory allocation
moved the code but kept the bug.

This patch fixes the issue.

Signed-off-by: Doug Smythies <dsmythies@telus.net>
---
 tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
index 84e2b64..2fa3c57 100755
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
2.7.4

