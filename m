Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754612AbeE2Gby (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 02:31:54 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44558 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754466AbeE2Gbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 02:31:52 -0400
X-Google-Smtp-Source: AB8JxZq8nI0c8IoFEKP8B6/lX/nrW+brJQ0NNzxgYc4O0+WuwLwr6Df3+i/Kn5njwlw0T08T7ZPdtw==
From: Nick Desaulniers <nick.desaulniers@gmail.com>
To: rostedt@goodmis.org, mingo@redhat.com
Cc: Nick Desaulniers <nick.desaulniers@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] blk-wbt: tracing: prefer strlcpy to strncpy
Date: Mon, 28 May 2018 23:31:27 -0700
Message-Id: <1527575488-31305-1-git-send-email-nick.desaulniers@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes a stringop-truncation warning from gcc-8.

Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
---
 include/trace/events/wbt.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/wbt.h b/include/trace/events/wbt.h
index b048694..305252d 100644
--- a/include/trace/events/wbt.h
+++ b/include/trace/events/wbt.h
@@ -33,7 +33,7 @@ TRACE_EVENT(wbt_stat,
 	),
 
 	TP_fast_assign(
-		strncpy(__entry->name, dev_name(bdi->dev), 32);
+		strlcpy(__entry->name, dev_name(bdi->dev), 32);
 		__entry->rmean		= stat[0].mean;
 		__entry->rmin		= stat[0].min;
 		__entry->rmax		= stat[0].max;
@@ -67,7 +67,7 @@ TRACE_EVENT(wbt_lat,
 	),
 
 	TP_fast_assign(
-		strncpy(__entry->name, dev_name(bdi->dev), 32);
+		strlcpy(__entry->name, dev_name(bdi->dev), 32);
 		__entry->lat = div_u64(lat, 1000);
 	),
 
@@ -103,7 +103,7 @@ TRACE_EVENT(wbt_step,
 	),
 
 	TP_fast_assign(
-		strncpy(__entry->name, dev_name(bdi->dev), 32);
+		strlcpy(__entry->name, dev_name(bdi->dev), 32);
 		__entry->msg	= msg;
 		__entry->step	= step;
 		__entry->window	= div_u64(window, 1000);
@@ -138,7 +138,7 @@ TRACE_EVENT(wbt_timer,
 	),
 
 	TP_fast_assign(
-		strncpy(__entry->name, dev_name(bdi->dev), 32);
+		strlcpy(__entry->name, dev_name(bdi->dev), 32);
 		__entry->status		= status;
 		__entry->step		= step;
 		__entry->inflight	= inflight;
-- 
2.7.4
