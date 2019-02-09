Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6245BC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C5B020863
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfBIMVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 07:21:47 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54977 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfBIMVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 07:21:47 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x19CLb382624511
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 04:21:37 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x19CLa2Z2624506;
        Sat, 9 Feb 2019 04:21:36 -0800
Date:   Sat, 9 Feb 2019 04:21:36 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-xbk34kwamn8bw8ywpuxetct9@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, jolsa@kernel.org,
        adrian.hunter@intel.com, namhyung@kernel.org, acme@redhat.com
Reply-To: acme@redhat.com, namhyung@kernel.org, adrian.hunter@intel.com,
          jolsa@kernel.org, gregkh@linuxfoundation.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com, davem@davemloft.net,
          tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools headers uapi: Sync linux/in.h copy from the
 kernel sources
Git-Commit-ID: 27b8e90eaea6a6fe8c1ab457443601dabff500d0
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

Commit-ID:  27b8e90eaea6a6fe8c1ab457443601dabff500d0
Gitweb:     https://git.kernel.org/tip/27b8e90eaea6a6fe8c1ab457443601dabff500d0
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 4 Feb 2019 11:34:20 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 4 Feb 2019 11:34:20 -0300

tools headers uapi: Sync linux/in.h copy from the kernel sources

To get the changes in this cset:

  f275ee0fa3a0 ("IN_BADCLASS: fix macro to actually work")

The macros changed in this cset are not used in tools/, so this is just
to silence this perf tools build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/in.h' differs from latest version at 'include/uapi/linux/in.h'
  diff -u tools/include/uapi/linux/in.h include/uapi/linux/in.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-xbk34kwamn8bw8ywpuxetct9@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/in.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/in.h b/tools/include/uapi/linux/in.h
index f6052e70bf40..a55cb8b10165 100644
--- a/tools/include/uapi/linux/in.h
+++ b/tools/include/uapi/linux/in.h
@@ -268,7 +268,7 @@ struct sockaddr_in {
 #define	IN_MULTICAST(a)		IN_CLASSD(a)
 #define	IN_MULTICAST_NET	0xe0000000
 
-#define	IN_BADCLASS(a)		((((long int) (a) ) == 0xffffffff)
+#define	IN_BADCLASS(a)		(((long int) (a) ) == (long int)0xffffffff)
 #define	IN_EXPERIMENTAL(a)	IN_BADCLASS((a))
 
 #define	IN_CLASSE(a)		((((long int) (a)) & 0xf0000000) == 0xf0000000)
