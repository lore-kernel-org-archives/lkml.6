Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262A3C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D91C826595
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D91C826595
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752485AbeFZG5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 02:57:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40777 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751188AbeFZG5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 02:57:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5Q6uq4r1591599
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 25 Jun 2018 23:56:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5Q6up9c1591596;
        Mon, 25 Jun 2018 23:56:51 -0700
Date:   Mon, 25 Jun 2018 23:56:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-zd1sgtbybtjrrt7bqdybu0s0@git.kernel.org>
Cc:     ast@kernel.org, hpa@zytor.com, dsahern@gmail.com,
        wangnan0@huawei.com, namhyung@kernel.org, tglx@linutronix.de,
        jolsa@kernel.org, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, mingo@kernel.org, acme@redhat.com
Reply-To: namhyung@kernel.org, tglx@linutronix.de, hpa@zytor.com,
          ast@kernel.org, dsahern@gmail.com, wangnan0@huawei.com,
          mingo@kernel.org, acme@redhat.com, adrian.hunter@intel.com,
          jolsa@kernel.org, linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools include uapi: Synchronize bpf.h with the
 kernel
Git-Commit-ID: f568b472815fd6c34fe4cc30dde4572ee300d6c4
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

Commit-ID:  f568b472815fd6c34fe4cc30dde4572ee300d6c4
Gitweb:     https://git.kernel.org/tip/f568b472815fd6c34fe4cc30dde4572ee300d6c4
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 15 Jun 2018 16:55:32 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 25 Jun 2018 11:59:36 -0300

tools include uapi: Synchronize bpf.h with the kernel

To pick the rename in:

  bd3a08aaa9a3 ("bpf: flowlabel in bpf_fib_lookup should be flowinfo")

Silencing this build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/bpf.h' differs from latest version at 'include/uapi/linux/bpf.h'

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-zd1sgtbybtjrrt7bqdybu0s0@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/bpf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index e0b06784f227..59b19b6a40d7 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2630,7 +2630,7 @@ struct bpf_fib_lookup {
 	union {
 		/* inputs to lookup */
 		__u8	tos;		/* AF_INET  */
-		__be32	flowlabel;	/* AF_INET6 */
+		__be32	flowinfo;	/* AF_INET6, flow_label + priority */
 
 		/* output: metric of fib result (IPv4/IPv6 only) */
 		__u32	rt_metric;
