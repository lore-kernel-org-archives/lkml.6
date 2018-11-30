Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D3DC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE6F2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2+Xcc6x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE6F2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbeLAFhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:37:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:55724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727140AbeLAFhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 00:37:54 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB55A20673;
        Fri, 30 Nov 2018 18:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543602465;
        bh=M1owlzj428fim2IPs1011KwUpJa3gYb23P17l+E+Dp4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T2+Xcc6xLmYQkkbzkC20ryHX13Gzkojjvxj+Ezh5ZCHQoLmx3kX624sx8NW29EKHc
         IhCkJ4iuWI3TYwF0wHz1wk1mt/Dw3Syf/GqvVquoSo7Ci+tYWFquJjyqK3OakAGPxh
         YxbIrNw1BlpHcZpVzLBtU1bMaaVeiGRT6zUmO47M=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Wang Nan <wangnan0@huawei.com>,
        Wen Yang <yellowriver2010@hotmail.com>,
        zhong.weidong@zte.com.cn
Subject: [PATCH 13/22] tools include: Adopt ERR_CAST() from the kernel err.h header
Date:   Fri, 30 Nov 2018 15:26:43 -0300
Message-Id: <20181130182652.23620-14-acme@kernel.org>
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

Add ERR_CAST(), so that tools can use it, just like the kernel.

This addresses coccinelle checks that are being performed to tools/ in
addition to kernel sources, so lets add this to cover that and to get
tools code closer to kernel coding standards.

This originally was introduced in the kernel headers in this cset:

  d1bc8e954452 ("Add an ERR_CAST() function to complement ERR_PTR and co.")

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Wen Yang <yellowriver2010@hotmail.com>
Cc: zhong.weidong@zte.com.cn
Link: https://lkml.kernel.org/n/tip-tlt97p066zyhzqhl5jt86og7@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/linux/err.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/include/linux/err.h b/tools/include/linux/err.h
index 094649667bae..2f5a12b88a86 100644
--- a/tools/include/linux/err.h
+++ b/tools/include/linux/err.h
@@ -59,4 +59,17 @@ static inline int __must_check PTR_ERR_OR_ZERO(__force const void *ptr)
 	else
 		return 0;
 }
+
+/**
+ * ERR_CAST - Explicitly cast an error-valued pointer to another pointer type
+ * @ptr: The pointer to cast.
+ *
+ * Explicitly cast an error-valued pointer to another pointer type in such a
+ * way as to make it clear that's what's going on.
+ */
+static inline void * __must_check ERR_CAST(__force const void *ptr)
+{
+	/* cast away the const */
+	return (void *) ptr;
+}
 #endif /* _LINUX_ERR_H */
-- 
2.19.1

