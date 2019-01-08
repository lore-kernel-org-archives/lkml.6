Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D01C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F61320883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbfAHPlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 10:41:21 -0500
Received: from terminus.zytor.com ([198.137.202.136]:34715 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbfAHPlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 10:41:20 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x08FfBnB3566702
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 8 Jan 2019 07:41:11 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x08FfBNZ3566697;
        Tue, 8 Jan 2019 07:41:11 -0800
Date:   Tue, 8 Jan 2019 07:41:11 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-smghvyxb3budqd1e70i0ylw1@git.kernel.org>
Cc:     adrian.hunter@intel.com, tglx@linutronix.de, jolsa@kernel.org,
        acme@redhat.com, davem@davemloft.net, linux-kernel@vger.kernel.org,
        mingo@kernel.org, dave.taht@gmail.com, hpa@zytor.com,
        namhyung@kernel.org
Reply-To: dave.taht@gmail.com, davem@davemloft.net, mingo@kernel.org,
          linux-kernel@vger.kernel.org, acme@redhat.com, jolsa@kernel.org,
          hpa@zytor.com, namhyung@kernel.org, adrian.hunter@intel.com,
          tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools headers uapi: Sync linux/in.h copy from the
 kernel sources
Git-Commit-ID: 4001b6a080aaca9a13ea07ae8972b82fdbd9ea6b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  4001b6a080aaca9a13ea07ae8972b82fdbd9ea6b
Gitweb:     https://git.kernel.org/tip/4001b6a080aaca9a13ea07ae8972b82fdbd9ea6b
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 4 Jan 2019 11:41:42 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 4 Jan 2019 12:54:49 -0300

tools headers uapi: Sync linux/in.h copy from the kernel sources

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
