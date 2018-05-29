Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754503AbeE2GDs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 02:03:48 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:41340 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750871AbeE2GDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 02:03:47 -0400
X-Google-Smtp-Source: AB8JxZptE3+uWCNUqimL7weUQakScZXpMICnhBWkqA9cUQaDeW9rQ/rLEfwWk1AczrbBvoWQ2RTw1Q==
From: Nick Desaulniers <nick.desaulniers@gmail.com>
To: rostedt@goodmis.org, mingo@redhat.com
Cc: Nick Desaulniers <nick.desaulniers@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tracing: prefer strlcpy to strncpy
Date: Mon, 28 May 2018 23:03:38 -0700
Message-Id: <1527573818-29712-1-git-send-email-nick.desaulniers@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes a stringop-truncation warning from gcc-8.

Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
---
 kernel/trace/trace_events_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index b9061ed..b53a6c0 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -393,7 +393,7 @@ static void hist_err_event(char *str, char *system, char *event, char *var)
 	else if (system)
 		snprintf(err, MAX_FILTER_STR_VAL, "%s.%s", system, event);
 	else
-		strncpy(err, var, MAX_FILTER_STR_VAL);
+		strlcpy(err, var, MAX_FILTER_STR_VAL);
 
 	hist_err(str, err);
 }
-- 
2.7.4
