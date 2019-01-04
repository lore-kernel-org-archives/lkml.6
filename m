Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2BEC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 301E121907
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546626871;
	bh=4TcnD4TokadrIlgR9tJuIhikVId9ShHfoDDmzV1eiok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qM0N2dZYTY4DsH46VBe6jn7VQktPctD43Vf8AlZWIsVcX/TKso6mkB3/cVpf/s6Mw
	 zdLI5AASfupYAQGmsMZH+X8kj8zFC6BGx+OHsrsxNQuN+PXbbz93gCSYw7jX8CKiN+
	 CQv+SX+FgnPDNYwi63yCGTJkPMHzugyg8PbGYqpo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbfADSea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 13:34:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:53118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728604AbfADSeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 13:34:24 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26060218D8;
        Fri,  4 Jan 2019 18:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546626864;
        bh=4TcnD4TokadrIlgR9tJuIhikVId9ShHfoDDmzV1eiok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=azWm4d6pQ3HenJ9Ng+OaRX7+CXDXCAiFxb8osPyZ9Iw22yEN1oEWMYvq4axv/0Kyq
         O1IaPYgDCq9mchhl+Kginrt4wbs6VKae9OL/Hh0r1fgJ2sEyr0ljPFYd6rk5QwE8Xv
         NnpTJ+6EcvaoSD7s/T+ISmVm2w6IVqYxKJjFADkE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Dave Taht <dave.taht@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 08/16] tools headers uapi: Sync linux/in.h copy from the kernel sources
Date:   Fri,  4 Jan 2019 15:33:29 -0300
Message-Id: <20190104183337.12771-9-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104183337.12771-1-acme@kernel.org>
References: <20190104183337.12771-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get the changes in this cset:

  65cab850f0ee ("net: Allow class-e address assignment via ifconfig ioctl")

The macros changed in this cset are not used in tools/, so this is just
to silence this perf tools build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/in.h' differs from latest version at 'include/uapi/linux/in.h'
  diff -u tools/include/uapi/linux/in.h include/uapi/linux/in.h

Cc: Dave Taht <dave.taht@gmail.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-smghvyxb3budqd1e70i0ylw1@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/in.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/include/uapi/linux/in.h b/tools/include/uapi/linux/in.h
index 48e8a225b985..f6052e70bf40 100644
--- a/tools/include/uapi/linux/in.h
+++ b/tools/include/uapi/linux/in.h
@@ -266,10 +266,14 @@ struct sockaddr_in {
 
 #define	IN_CLASSD(a)		((((long int) (a)) & 0xf0000000) == 0xe0000000)
 #define	IN_MULTICAST(a)		IN_CLASSD(a)
-#define IN_MULTICAST_NET	0xF0000000
+#define	IN_MULTICAST_NET	0xe0000000
 
-#define	IN_EXPERIMENTAL(a)	((((long int) (a)) & 0xf0000000) == 0xf0000000)
-#define	IN_BADCLASS(a)		IN_EXPERIMENTAL((a))
+#define	IN_BADCLASS(a)		((((long int) (a) ) == 0xffffffff)
+#define	IN_EXPERIMENTAL(a)	IN_BADCLASS((a))
+
+#define	IN_CLASSE(a)		((((long int) (a)) & 0xf0000000) == 0xf0000000)
+#define	IN_CLASSE_NET		0xffffffff
+#define	IN_CLASSE_NSHIFT	0
 
 /* Address to accept any incoming messages. */
 #define	INADDR_ANY		((unsigned long int) 0x00000000)
-- 
2.20.1

