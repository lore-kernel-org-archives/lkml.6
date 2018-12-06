Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705B9C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D63C214E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544131931;
	bh=BCNEJuqp7mPepFMuVNWhWxzx536eJovSeQwgFBnFRho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oa+aNYWXb1IGD6usZScAkDDLXj4/kMwyFFBnPeeN4KsvMZuR7cB36yo/KdwSxCZk3
	 zbbPyenCHjjTVx3Y0hNn1GTGizOslllQNMApd6xSRmGNN2zFE2aDb/yOOUoNn0qh9L
	 jiZakuhDSqXI2CZoXzPwipupTaaH2SahmgtP1f00=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D63C214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbeLFVbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:31:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:49536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbeLFVbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:31:02 -0500
Received: from quaco.ghostprotocols.net (179.187.13.223.dynamic.adsl.gvt.net.br [179.187.13.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B0EC21479;
        Thu,  6 Dec 2018 21:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544131861;
        bh=BCNEJuqp7mPepFMuVNWhWxzx536eJovSeQwgFBnFRho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Biz+pHdseaTCf7/uthq6i1b0LCIQQjXc+VrG8jM0iH5qfUruL4OysAktkBo5gKXi+
         Fw89rNlGrDZvf5KmGsrBawfbNMAnV/2waNBaDC+UkQbYkWbbtdbSWNce1fkGBgBHwd
         EWw1vAPi0ModDAnOH9xeiRCpUYXMmGumFkaBr8eI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Sihyeon Jang <uneedsihyeon@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 70/75] perf config: Modify size factor of snprintf
Date:   Thu,  6 Dec 2018 18:25:57 -0300
Message-Id: <20181206212602.20474-71-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sihyeon Jang <uneedsihyeon@gmail.com>

According to definition of snprintf, it gets size factor including
null('\0') byte.  So '-1' is not neccessary. Also it will be helpful
unfied style with other cases. (eg. builtin-script.c)

Signed-off-by: Sihyeon Jang <uneedsihyeon@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20181201154603.10093-1-uneedsihyeon@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/config.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 3beb4cf44c31..1ea8f898f1a1 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -815,14 +815,14 @@ int config_error_nonbool(const char *var)
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
2.19.2

