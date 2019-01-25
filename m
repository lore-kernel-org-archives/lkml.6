Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2A6C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 949A620844
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548458470;
	bh=9rIG1ecuUABgIUA4u7oWQ58te6mTp5e7ZG8WvZJe7A0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hB3Ly4b8deNjGCXba1JQqS0T4+e7/nsRn4QTxKasqEQZbE//nXFck8InLCBtPKhfS
	 wkCHvL3t6XbhhYFx5VpUZWBOIXZEq8DVobnmIbjwTKiUJFBcuzhCrIQ9oEEdevxFZk
	 0FIO5WWESJANipOpyezrVPYxAI2rW66YjhResV/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729560AbfAYXVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:21:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:48098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729896AbfAYXTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 18:19:36 -0500
Received: from quaco.cust.in.nbox.cz (unknown [95.82.135.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49AEF21903;
        Fri, 25 Jan 2019 23:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548458376;
        bh=9rIG1ecuUABgIUA4u7oWQ58te6mTp5e7ZG8WvZJe7A0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SQm5WlDg4It1ZmF5pHNa0DyhgtAFPfybRI2XkoLVxlNHlsVgua11b9euAU9jGQ04Y
         Vg68CsMlN0xulaXMta1m0luANhi1oHfdiXZNNfgyO/UKgPIaUbzG5tBkEeE/2Nnkln
         Zpt4zDVkU65+O0JsEOGZJqmgaeaQnLtuhjHYEDWg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Tony Jones <tonyj@suse.de>,
        Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 21/29] perf script python: Remove explicit shebang from tests/attr.c
Date:   Sat, 26 Jan 2019 00:18:35 +0100
Message-Id: <20190125231843.2895-22-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190125231843.2895-1-acme@kernel.org>
References: <20190125231843.2895-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Jones <tonyj@suse.de>

tests/attr.c invokes attr.py via an explicit invocation of Python
($PYTHON) so there is therefore no need for an explicit shebang.

Also most distros follow pep-0394 which recommends that /usr/bin/python
refer only to v2 and so may not exist on the system (if PYTHON=python3).

Signed-off-by: Tony Jones <tonyj@suse.de>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20190124005229.16146-5-tonyj@suse.de
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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

