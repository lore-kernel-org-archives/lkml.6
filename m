Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A185C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B422146F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TG/jutq7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13B422146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbeLAFhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:37:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:54580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbeLAFhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 00:37:17 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8835220673;
        Fri, 30 Nov 2018 18:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543602428;
        bh=/yp6Dp/k7ClnlvFHKXLbvi7ArFjAxYkNR9DZUYbZHp8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TG/jutq7l6VYr8XIut6nP7JBJ6V9elPNdQtI8x4gppLI4vk+yp3ZWgyEBkpcMh8BY
         1eZe0Cz/smtbLHWmMuF9Alt1dZlUBrv8VJjEkG8+1wSOCggv32TxrmS4OkyyOQoiYv
         9uJDuLV1ZwRRjI99bwW0zcUZtDF7MYs0DaD3ETt4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 01/22] perf build: Give better hint about devel package for libssl
Date:   Fri, 30 Nov 2018 15:26:31 -0300
Message-Id: <20181130182652.23620-2-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181130182652.23620-1-acme@kernel.org>
References: <20181130182652.23620-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

In debian/ubuntu its libssl-dev, but for fedora/RHEL/Centos/etc its
openssl-devel, fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: 8ee4646038e4 ("perf build: Add libcrypto feature detection")
Link: https://lkml.kernel.org/n/tip-lnxqszts6aq2c9jy4b7mlnym@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index e110010e7faa..c643d5e0c26b 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -588,7 +588,7 @@ endif
 
 ifndef NO_LIBCRYPTO
   ifneq ($(feature-libcrypto), 1)
-    msg := $(warning No libcrypto.h found, disables jitted code injection, please install libssl-devel or libssl-dev);
+    msg := $(warning No libcrypto.h found, disables jitted code injection, please install openssl-devel or libssl-dev);
     NO_LIBCRYPTO := 1
   else
     CFLAGS += -DHAVE_LIBCRYPTO_SUPPORT
-- 
2.19.1

