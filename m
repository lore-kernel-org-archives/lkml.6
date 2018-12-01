Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51209C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06DBA20673
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TW3Cs6je"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06DBA20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbeLBC7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 21:59:19 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36097 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbeLBC7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 21:59:19 -0500
Received: by mail-pl1-f195.google.com with SMTP id g9so4302768plo.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 07:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3MBKnEdc2vCt+hp1v45FpAxJ6rOrkFnLUOM7Xtr3Bas=;
        b=TW3Cs6jeAscQxZY+dwyK1c/QJiKVVOp0ebuYOEXp+dEa0AYqjW4P67wXrV0HTJQ19P
         q/bKLoZf60WGuxIAVITxqGeIky6viEOgjoWtD6AgkksnHLTrXtsC0kPidDZvmwht9NKp
         4wepjR14hoc+p8mpXnWI+pa3IK0V8I0M9qTWnytqS4SQkEn/ceQ9NjVv1mNM9pPgcPZr
         qzW7jSKacNYJuhHTTTYHvwpT8JrzKrA3+Ba3Uc7DmGPPCCKHhD1e6VWmwfkG/SwISl2a
         zurrln0gWQzStgXNbbJt2V3ax+hW7ldA9b8hNrPdPOPe5O787W17pdmmekuE+2lCoh6H
         zN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3MBKnEdc2vCt+hp1v45FpAxJ6rOrkFnLUOM7Xtr3Bas=;
        b=r57X1HWumqRrO6A8tlA1FtvMw/Er248okPDzUjobyxlHYUhDLpA34pc40HzoCOSSi+
         PixRbD593BJcn+JZnBjgmM529kxDE3/cxNsA2Ca9RdWb8goU8SwTAFPau3vVYG+aDh0Q
         WPoMnl3H4l6b91M84xxIHcHyH/acbZNRkV0wBKoLd13iNGlrfGQPp1mykAtKwaNwSAWI
         +vmotbHFhIfsToUh5gqU5bEpY5bCNWIgmmEhTaKgtyUsklydZdfVIoiIvOZzkfX40nK3
         2dmJUOPWRILm9IhRFOFQO8QrinEXXpuCbA/reG31TVPLZjeMiv9OWpr1ei8QA75iPOmo
         IlDw==
X-Gm-Message-State: AA+aEWaq17gzb6/qYT8wI3XuZjagBR95UNCscZxflW3qYARs7jthnNrI
        ZdocIyDxeyPbEtKgkalre81gNf+X
X-Google-Smtp-Source: AFSGD/WVYBMU0lnplRDO5lRT+e8bTR6ce783me3pAaosyqIBQBYBZHa78w0adGNEhgP6NsvUODR+/w==
X-Received: by 2002:a17:902:9f93:: with SMTP id g19mr9500023plq.195.1543679191622;
        Sat, 01 Dec 2018 07:46:31 -0800 (PST)
Received: from localhost.localdomain ([115.143.98.81])
        by smtp.gmail.com with ESMTPSA id k129sm13042156pgk.29.2018.12.01.07.46.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Dec 2018 07:46:31 -0800 (PST)
From:   Sihyeon Jang <uneedsihyeon@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sihyeon Jang <uneedsihyeon@gmail.com>
Subject: [PATCH] perf util config : Modify size factor of snprintf
Date:   Sun,  2 Dec 2018 00:46:03 +0900
Message-Id: <20181201154603.10093-1-uneedsihyeon@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to definition of snprintf, it gets size factor including null('\0') byte.
So '-1' is not neccessary. Also it will be helpful unfied style with other cases. (eg. builtin-script.c)

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sihyeon Jang <uneedsihyeon@gmail.com>
---
 tools/perf/util/config.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 5ac157056cdf..bce980fa9f41 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -811,14 +811,14 @@ int config_error_nonbool(const char *var)
 void set_buildid_dir(const char *dir)
 {
 	if (dir)
-		scnprintf(buildid_dir, MAXPATHLEN-1, "%s", dir);
+		scnprintf(buildid_dir, MAXPATHLEN, "%s", dir);
 
 	/* default to $HOME/.debug */
 	if (buildid_dir[0] == '\0') {
 		char *home = getenv("HOME");
 
 		if (home) {
-			snprintf(buildid_dir, MAXPATHLEN-1, "%s/%s",
+			snprintf(buildid_dir, MAXPATHLEN, "%s/%s",
 				 home, DEBUG_CACHE_DIR);
 		} else {
 			strncpy(buildid_dir, DEBUG_CACHE_DIR, MAXPATHLEN-1);
-- 
2.17.1

