Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3156C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B355D2659B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B355D2659B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751127AbeFZG6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 02:58:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44907 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751869AbeFZG56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 02:57:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5Q6vpI01591816
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 25 Jun 2018 23:57:51 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5Q6voun1591811;
        Mon, 25 Jun 2018 23:57:50 -0700
Date:   Mon, 25 Jun 2018 23:57:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Richter <tipbot@zytor.com>
Message-ID: <tip-ea23ac73085743a4f1682d6605fe019577c82e1e@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tmricht@linux.ibm.com,
        jolsa@redhat.com, hpa@zytor.com, acme@redhat.com,
        heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com,
        tglx@linutronix.de, brueckner@linux.ibm.com, mingo@kernel.org
Reply-To: tglx@linutronix.de, brueckner@linux.ibm.com, mingo@kernel.org,
          hpa@zytor.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
          acme@redhat.com, tmricht@linux.ibm.com,
          linux-kernel@vger.kernel.org, jolsa@redhat.com
In-Reply-To: <20180615101105.47047-1-tmricht@linux.ibm.com>
References: <20180615101105.47047-1-tmricht@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf alias: Remove trailing newline when reading
 sysfs files
Git-Commit-ID: ea23ac73085743a4f1682d6605fe019577c82e1e
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

Commit-ID:  ea23ac73085743a4f1682d6605fe019577c82e1e
Gitweb:     https://git.kernel.org/tip/ea23ac73085743a4f1682d6605fe019577c82e1e
Author:     Thomas Richter <tmricht@linux.ibm.com>
AuthorDate: Fri, 15 Jun 2018 12:11:03 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 25 Jun 2018 11:59:37 -0300

perf alias: Remove trailing newline when reading sysfs files

Remove a trailing newline when reading sysfs file contents such as
/sys/devices/cpum_cf/events/TX_NC_TEND.  This shows when verbose option
-v is used.

Output before:

  tx_nc_tend -> 'cpum_cf'/'event=0x008d
  '/

Output after:

  tx_nc_tend -> 'cpum_cf'/'event=0x8d'/

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180615101105.47047-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/pmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index d2fb597c9a8c..2738fc8d200d 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -303,6 +303,9 @@ static int perf_pmu__new_alias(struct list_head *list, char *dir, char *name, FI
 
 	buf[ret] = 0;
 
+	/* Remove trailing newline from sysfs file */
+	rtrim(buf);
+
 	return __perf_pmu__new_alias(list, dir, name, NULL, buf, NULL, NULL, NULL,
 				     NULL, NULL, NULL);
 }
