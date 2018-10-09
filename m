Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92362C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 507A8214DC
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="i9/eKhQo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 507A8214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbeJIShL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:37:11 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40872 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbeJIShJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:37:09 -0400
Received: by mail-ed1-f67.google.com with SMTP id r1-v6so1319776edd.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UdZwhg92o98VyykN9WqpOMXRdtuwuD7WJ12aZC+0PWw=;
        b=i9/eKhQo7umrj3a+dUGYotEh0womJlwhPeaxI3ONF0lL0TvVWWkB6LOk641QI/m7Wg
         zj5HZMcNSTyiZpArNQKgMa0MA5F9ceoKtrHsWT4OYwSJMBsSKm6HkhIU9/RHb2PogIZa
         XAJTCVOwCraLiHYMI7mEU2J3zB1JvshBJB5fU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UdZwhg92o98VyykN9WqpOMXRdtuwuD7WJ12aZC+0PWw=;
        b=sp5MGhzGK4+pN2FPCCWgLfLIOqMB/r9Yk58Ui+/3v60Utwfx2RzCelaASkpk0XkuT5
         JFCx0smYyCp6tKAgjd+ajPYEflHICxppm7OBdHCP3bsgegERsLoD2P6WBrz8k5FtOQuh
         pEHpZljMYNDiVu0ggdGqXQjHvV2repKEuWnvZVZpEMFhUf9H9rsKce3F2dgojhKsYu2H
         6ds9EqdRDtOnHFrUdKkgyP8BmJl4aQU0gUQ61QvgBsprbd8fBM4IDo/GdL2y/Hdddbay
         +LPeyo5LrmoJUB/fn4sPZGbuBSe6xuOQWBlaUeXRfPSSfRHhTFRneXOBtbdDn5xVaIc+
         G8LQ==
X-Gm-Message-State: ABuFfojY1EQPSmD2/bvkpX10y90as1phlWwxQ+J+IMGXNKXEJtrziPMM
        E7fbo10RFKZulLmHV0VeTOmJGmGShEQ=
X-Google-Smtp-Source: ACcGV63HBOy4H3kHaOfPjWV8azGd20hUA6np5hzX3InWKr4h5NKb6gBJ87L6q4O6/48C6EGzHQI1VA==
X-Received: by 2002:a05:6402:2c9:: with SMTP id b9mr35248933edx.149.1539084038864;
        Tue, 09 Oct 2018 04:20:38 -0700 (PDT)
Received: from prevas-ravi.vestasvisitor.net ([193.47.71.171])
        by smtp.gmail.com with ESMTPSA id n23-v6sm3595821eja.41.2018.10.09.04.20.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 04:20:38 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 18/23] dynamic_debug: introduce accessors for string members of struct _ddebug
Date:   Tue,  9 Oct 2018 13:20:08 +0200
Message-Id: <20181009112013.14238-19-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.4.g721af0fda3
In-Reply-To: <20181009112013.14238-1-linux@rasmusvillemoes.dk>
References: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
 <20181009112013.14238-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we introduce compact versions of these pointers (a la
CONFIG_GENERIC_BUG_RELATIVE_POINTERS), all access to these members must
go via appropriate accessors. This just mass-converts dynamic_debug.c to
use the new accessors.

Acked-by: Jason Baron <jbaron@akamai.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 lib/dynamic_debug.c | 51 ++++++++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index e90459dca34b..dbd837f486f9 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -37,6 +37,23 @@
 #include <linux/device.h>
 #include <linux/netdevice.h>
 
+static inline const char *dd_modname(const struct _ddebug *dd)
+{
+	return dd->modname;
+}
+static inline const char *dd_function(const struct _ddebug *dd)
+{
+	return dd->function;
+}
+static inline const char *dd_filename(const struct _ddebug *dd)
+{
+	return dd->filename;
+}
+static inline const char *dd_format(const struct _ddebug *dd)
+{
+	return dd->format;
+}
+
 extern struct _ddebug __start___verbose[];
 extern struct _ddebug __stop___verbose[];
 
@@ -158,21 +175,21 @@ static int ddebug_change(const struct ddebug_query *query,
 
 			/* match against the source filename */
 			if (query->filename &&
-			    !match_wildcard(query->filename, dp->filename) &&
+			    !match_wildcard(query->filename, dd_filename(dp)) &&
 			    !match_wildcard(query->filename,
-					   kbasename(dp->filename)) &&
+					   kbasename(dd_filename(dp))) &&
 			    !match_wildcard(query->filename,
-					   trim_prefix(dp->filename)))
+					   trim_prefix(dd_filename(dp))))
 				continue;
 
 			/* match against the function */
 			if (query->function &&
-			    !match_wildcard(query->function, dp->function))
+			    !match_wildcard(query->function, dd_function(dp)))
 				continue;
 
 			/* match against the format */
 			if (query->format &&
-			    !strstr(dp->format, query->format))
+			    !strstr(dd_format(dp), query->format))
 				continue;
 
 			/* match against the line number range */
@@ -197,8 +214,8 @@ static int ddebug_change(const struct ddebug_query *query,
 #endif
 			dp->flags = newflags;
 			vpr_info("changed %s:%d [%s]%s =%s\n",
-				 trim_prefix(dp->filename), dp->lineno,
-				 dt->mod_name, dp->function,
+				 trim_prefix(dd_filename(dp)), dp->lineno,
+				 dt->mod_name, dd_function(dp),
 				 ddebug_describe_flags(dp, flagbuf,
 						       sizeof(flagbuf)));
 		}
@@ -533,10 +550,10 @@ static char *dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
 	pos_after_tid = pos;
 	if (desc->flags & _DPRINTK_FLAGS_INCL_MODNAME)
 		pos += snprintf(buf + pos, remaining(pos), "%s:",
-				desc->modname);
+				dd_modname(desc));
 	if (desc->flags & _DPRINTK_FLAGS_INCL_FUNCNAME)
 		pos += snprintf(buf + pos, remaining(pos), "%s:",
-				desc->function);
+				dd_function(desc));
 	if (desc->flags & _DPRINTK_FLAGS_INCL_LINENO)
 		pos += snprintf(buf + pos, remaining(pos), "%d:",
 				desc->lineno);
@@ -790,10 +807,10 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 	}
 
 	seq_printf(m, "%s:%u [%s]%s =%s \"",
-		   trim_prefix(dp->filename), dp->lineno,
-		   iter->table->mod_name, dp->function,
+		   trim_prefix(dd_filename(dp)), dp->lineno,
+		   iter->table->mod_name, dd_function(dp),
 		   ddebug_describe_flags(dp, flagsbuf, sizeof(flagsbuf)));
-	seq_escape(m, dp->format, "\t\r\n\"");
+	seq_escape(m, dd_format(dp), "\t\r\n\"");
 	seq_puts(m, "\"\n");
 
 	return 0;
@@ -987,20 +1004,20 @@ static int __init dynamic_debug_init(void)
 		return 1;
 	}
 	iter = __start___verbose;
-	modname = iter->modname;
+	modname = dd_modname(iter);
 	iter_start = iter;
 	for (; iter < __stop___verbose; iter++) {
 		entries++;
-		verbose_bytes += strlen(iter->modname) + strlen(iter->function)
-			+ strlen(iter->filename) + strlen(iter->format);
+		verbose_bytes += strlen(dd_modname(iter)) + strlen(dd_function(iter))
+			+ strlen(dd_filename(iter)) + strlen(dd_format(iter));
 
-		if (strcmp(modname, iter->modname)) {
+		if (strcmp(modname, dd_modname(iter))) {
 			modct++;
 			ret = ddebug_add_module(iter_start, n, modname);
 			if (ret)
 				goto out_err;
 			n = 0;
-			modname = iter->modname;
+			modname = dd_modname(iter);
 			iter_start = iter;
 		}
 		n++;
-- 
2.19.1.3.g1d92a00e68

