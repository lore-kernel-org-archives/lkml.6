Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351AAC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0485F217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545171238;
	bh=Adye3ECg/LV9TtM/3laQyB3HpbAjmyMznZisLnmwhQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zYCyDU1W/4iqkThpwkC9QUU7328FXiJrlFe4txRrh5/uAMgyhzjOfpNDsWmHEW+Nl
	 y0A8bJIKH3RjojoMELk18BIoxp26j23m2M9Or7ZRuOsRsRrFmnIl2o9LldeP6iMrK+
	 rhLNXD8Y2jj9VXM9lNVwg3jwI64dyIRIi0qVob6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbeLRWN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:13:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:43054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726629AbeLRWNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:13:55 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE34F217D9;
        Tue, 18 Dec 2018 22:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545171234;
        bh=Adye3ECg/LV9TtM/3laQyB3HpbAjmyMznZisLnmwhQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ES5RlyvK4JvDuZRahTtePQF+FGGulUZ/5D2iIPA5s4sqGhSjSRc48Jd17CE2TKC0d
         ht/EdQFx+Kvxy+Ie6n/SBJz9sep/crfOgy2Vj1yGVQYS3LqwIJksD8c8U1l7Stf9kG
         bZRx6oXKsEA7iHoedVvjER5SQ5vdY7llatIbp4iQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 43/63] perf trace: Enclose strings with double quotes
Date:   Tue, 18 Dec 2018 19:07:13 -0300
Message-Id: <20181218220733.15839-44-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To match 'strace' output, helping with upcoming regression tests
comparing both outputs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-jab52t1dcuh6vlztqle9g7u9@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 2d8fd48a4727..dc8cadeb3fa5 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1149,7 +1149,7 @@ static size_t syscall_arg__scnprintf_augmented_string(struct syscall_arg *arg, c
 {
 	struct augmented_arg *augmented_arg = arg->augmented.args;
 
-	return scnprintf(bf, size, "%.*s", augmented_arg->size, augmented_arg->value);
+	return scnprintf(bf, size, "\"%.*s\"", augmented_arg->size, augmented_arg->value);
 }
 
 static size_t syscall_arg__scnprintf_filename(char *bf, size_t size,
-- 
2.19.2

