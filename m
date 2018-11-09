Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9342C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 13:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A055C20825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 13:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A055C20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbeKIXDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 18:03:54 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55972 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbeKIXDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 18:03:54 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gL6kj-0001wf-BG; Fri, 09 Nov 2018 13:23:13 +0000
From:   Colin King <colin.king@canonical.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tracing: clean an indentation issue, remove extraneous spaces
Date:   Fri,  9 Nov 2018 13:23:12 +0000
Message-Id: <20181109132312.20994-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to clean up an indentation issue, a whole chunk of code
has an extra space in the indentation.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 kernel/trace/trace_events_filter.c | 48 +++++++++++++++---------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 84a65173b1e9..86b237215952 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1205,30 +1205,30 @@ static int parse_pred(const char *str, void *data,
 		 * (perf doesn't use it) and grab everything.
 		 */
 		if (strcmp(field->name, "ip") != 0) {
-			 parse_error(pe, FILT_ERR_IP_FIELD_ONLY, pos + i);
-			 goto err_free;
-		 }
-		 pred->fn = filter_pred_none;
-
-		 /*
-		  * Quotes are not required, but if they exist then we need
-		  * to read them till we hit a matching one.
-		  */
-		 if (str[i] == '\'' || str[i] == '"')
-			 q = str[i];
-		 else
-			 q = 0;
-
-		 for (i++; str[i]; i++) {
-			 if (q && str[i] == q)
-				 break;
-			 if (!q && (str[i] == ')' || str[i] == '&' ||
-				    str[i] == '|'))
-				 break;
-		 }
-		 /* Skip quotes */
-		 if (q)
-			 s++;
+			parse_error(pe, FILT_ERR_IP_FIELD_ONLY, pos + i);
+			goto err_free;
+		}
+		pred->fn = filter_pred_none;
+
+		/*
+		 * Quotes are not required, but if they exist then we need
+		 * to read them till we hit a matching one.
+		 */
+		if (str[i] == '\'' || str[i] == '"')
+			q = str[i];
+		else
+			q = 0;
+
+		for (i++; str[i]; i++) {
+			if (q && str[i] == q)
+				break;
+			if (!q && (str[i] == ')' || str[i] == '&' ||
+				   str[i] == '|'))
+				break;
+		}
+		/* Skip quotes */
+		if (q)
+			s++;
 		len = i - s;
 		if (len >= MAX_FILTER_STR_VAL) {
 			parse_error(pe, FILT_ERR_OPERAND_TOO_LONG, pos + i);
-- 
2.19.1

