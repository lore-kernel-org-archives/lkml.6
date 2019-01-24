Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23111C282C0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 00:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EFBF218A1
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 00:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfAXAwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 19:52:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:37624 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727146AbfAXAv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 19:51:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9F3F9AFCB;
        Thu, 24 Jan 2019 00:51:58 +0000 (UTC)
From:   Tony Jones <tonyj@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-perf-users@vger.kernel.org, Tony Jones <tonyj@suse.de>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH 4/6] perf script python: remove explicit shebang from tests/attr.c
Date:   Wed, 23 Jan 2019 16:52:27 -0800
Message-Id: <20190124005229.16146-5-tonyj@suse.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124005229.16146-1-tonyj@suse.de>
References: <20190124005229.16146-1-tonyj@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tests/attr.c invokes attr.py via an explicit invocation of Python ($PYTHON)
so there is therefore no need for an explicit shebang.

Also most distros follow pep-0394 which recommends that /usr/bin/python
refer only to v2 and so may not exist on the system (if PYTHON=python3).

Signed-off-By: Tony Jones <tonyj@suse.de>
Cc:  Jiri Olsa <jolsa@redhat.com>
---
 tools/perf/tests/attr.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/tests/attr.py b/tools/perf/tests/attr.py
index 44090a9a19f3..3e07eee33b10 100644
--- a/tools/perf/tests/attr.py
+++ b/tools/perf/tests/attr.py
@@ -1,4 +1,3 @@
-#! /usr/bin/python
 # SPDX-License-Identifier: GPL-2.0
 
 import os
-- 
2.20.1

