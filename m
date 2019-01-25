Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A74C282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04DB620844
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548458467;
	bh=8mes/e3xcLkX9WUMM5C3HqGysBtgYV8ZiAzfwnCvWB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G5dm+1VLJBksF3h3NeOEUtrqJubP4RnO4mCgDhnfWaGHv7RpZ833AnVaq6aja3bGZ
	 zf4t/vsKGq7mFOKOO3Z/vqThTG4IZZhasqwURnmPt1aTGcfhe3Bo37XkKETLp8HU7f
	 hDARQ3fQKElSZIr6pZqfeGkkGbhWI4egVl4P4r5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729904AbfAYXTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:19:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:48060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729872AbfAYXTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 18:19:34 -0500
Received: from quaco.cust.in.nbox.cz (unknown [95.82.135.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A61B218D0;
        Fri, 25 Jan 2019 23:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548458373;
        bh=8mes/e3xcLkX9WUMM5C3HqGysBtgYV8ZiAzfwnCvWB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vzjknoD3djwiBob67tkwTNj82gDSforStoHOZsKMluq+2UaP1bWHh/fzGob6otDZz
         8Nv5lMqB3uMLU76BYVGmwEgbLybTz4QdPfh2eK83MZMN11aJUhWNZJg/c8G3fTd0K6
         NaaJDgF6niqwVhAf59IpfmYl8oCfLypJJ5hWvMzQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Tony Jones <tonyj@suse.de>,
        Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 20/29] perf script python: Remove explicit shebang from setup.py
Date:   Sat, 26 Jan 2019 00:18:34 +0100
Message-Id: <20190125231843.2895-21-acme@kernel.org>
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

Makefile.perf invokes setup.py via an explicit invocation of python
(PYTHON_WORD) so there is therefore no need for an explicit shebang.

Also most distros follow pep-0394 which recommends that /usr/bin/python
refer only to v2 and so may not exist on the system (if PYTHON=python3).

Signed-off-by: Tony Jones <tonyj@suse.de>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20190124005229.16146-4-tonyj@suse.de
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/setup.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 64d1f36dee99..d3ffc18424b5 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -1,5 +1,3 @@
-#!/usr/bin/python
-
 from os import getenv
 from subprocess import Popen, PIPE
 from re import sub
-- 
2.20.1

