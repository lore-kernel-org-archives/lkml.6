Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3ED1C6786F
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 02:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB7C420847
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 02:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LC+uFlq6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB7C420847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbeKDLtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 06:49:36 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40245 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbeKDLtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 06:49:36 -0500
Received: by mail-pg1-f195.google.com with SMTP id z10so765171pgp.7
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 19:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=x31v5uKr9QRbBGNFxtyZYHHAbZoh0qckSje/ecEoVv0=;
        b=LC+uFlq6pV8CnJHhEfw9V6YnptJ/GhLPjysBduyrBwxSJWa0EQAYHtg7pcBMGEute4
         tApZLebPk+reoh9WUc5UsBr2+2LzwcHjWqC+E8wfDW34lSzmed8KaxS3IdyckLJNgRkA
         LZm++gFPtzuYlakO4BKhSs+XKzAcWGUwE4NvrRGLSMtCo6gqT1fp18QbprEkZB5olE2e
         g1Zf8IFbo1n+7+9OgyAE4nnTkTR1rT+fz5M+DloDF1xYOOKmtdA4uMi9B/l72MyqUh5q
         KCTZkdfwpxRxd818NXo3KVAa9nTbkt3Bd/Ry+35Ftvaw/58xHRp52F0LZeeAJQYgcK1Y
         Jh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x31v5uKr9QRbBGNFxtyZYHHAbZoh0qckSje/ecEoVv0=;
        b=PfE0sP/+f+BeaQx3ZriPuZykSJfYej8jGWqtojvf1mmU3W/+WkX9YI/ccqXs3d0Pzw
         c0gtNm3uzd6s2bOQ2sIBzFxuIcpEXMyM9oI9AeDUUOVy5HTbczhbWJkP8gyLqVg5OHDb
         UB/MAjB/pfoLEwi8YbVbGYYYBt7meRZjEiA4iZObBACHzrLGe+OdQEL84/BbGQa3G/4E
         SJfCz0lcdZJjrr1mKMCrycvpol9GgC4WwNTwawOqgoXvUHQ5RdplFQ0BB/aRIpayhs2r
         1/v/5ouvwhkA0jvW25O4AztdnRdHlF18iwzrFoeuxO81tSY/CISqZ1wtOGPZET20RG2F
         91dQ==
X-Gm-Message-State: AGRZ1gL4ksMySWPqghTbCt/dfD1lixxgJGLKTbV679fLFDLwKWjIN30n
        2zH0bAwa1c496p2x+mlGHMs=
X-Google-Smtp-Source: AJdET5dlAtKOmdQwRhhSjp/yw07ARxBhoJ+l3oKH1zDR7D+cYU0jS6MjPZVAK4fBgBkuUpcUo3j0bQ==
X-Received: by 2002:a65:44c6:: with SMTP id g6-v6mr15413847pgs.350.1541298983336;
        Sat, 03 Nov 2018 19:36:23 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id a4sm8203732pgv.70.2018.11.03.19.36.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 03 Nov 2018 19:36:22 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rostedt@goodmis.org, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] tracing/fgraph: remove unnecessary unlikely()
Date:   Sat,  3 Nov 2018 22:35:37 -0400
Message-Id: <20181104023537.2626-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN_ON() already contains an unlikely(), so it's not necessary to use
unlikely.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 kernel/trace/trace_functions_graph.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 169b3c44ee97..f8c2a08e4985 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -201,9 +201,8 @@ ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
 	if (index < 0)
 		index += FTRACE_NOTRACE_DEPTH;
 
-	if (unlikely(index < 0 || index >= FTRACE_RETFUNC_DEPTH)) {
+	if (WARN_ON(index < 0 || index >= FTRACE_RETFUNC_DEPTH)) {
 		ftrace_graph_stop();
-		WARN_ON(1);
 		/* Might as well panic, otherwise we have no where to go */
 		*ret = (unsigned long)panic;
 		return;
@@ -274,9 +273,8 @@ unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
 	 */
 	ftrace_graph_return(&trace);
 
-	if (unlikely(!ret)) {
+	if (WARN_ON(!ret)) {
 		ftrace_graph_stop();
-		WARN_ON(1);
 		/* Might as well panic. What else to do? */
 		ret = (unsigned long)panic;
 	}
-- 
2.17.0

