Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC957ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C76820664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:09:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C76820664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbeKAHJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 03:09:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37597 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbeKAHJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 03:09:33 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9VM9PhT2561263
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 31 Oct 2018 15:09:25 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9VM9PqL2561260;
        Wed, 31 Oct 2018 15:09:25 -0700
Date:   Wed, 31 Oct 2018 15:09:25 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-3rvc39lon93kgt5pl31d8g4x@git.kernel.org>
Cc:     namhyung@kernel.org, hpa@zytor.com, anshuman.khandual@arm.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        acme@redhat.com, jolsa@kernel.org, gregkh@linuxfoundation.org
Reply-To: gregkh@linuxfoundation.org, jolsa@kernel.org, acme@redhat.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          mingo@kernel.org, anshuman.khandual@arm.com, hpa@zytor.com,
          namhyung@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools include uapi: Update linux/mmap.h copy
Git-Commit-ID: 685626dc26bd9cead850d06520708acbd16bcfda
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

Commit-ID:  685626dc26bd9cead850d06520708acbd16bcfda
Gitweb:     https://git.kernel.org/tip/685626dc26bd9cead850d06520708acbd16bcfda
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 30 Oct 2018 16:50:08 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 31 Oct 2018 09:57:53 -0300

tools include uapi: Update linux/mmap.h copy

To pick up the changes from:

  20916d4636a9 ("mm/hugetlb: add mmap() encodings for 32MB and 512MB page sizes")

That do not entail changes in in tools, this just shows that we have to
consider bits [26:31] of flags to beautify that in tools like 'perf
trace'

This silences this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/mman.h' differs from latest version at 'include/uapi/linux/mman.h'
  diff -u tools/include/uapi/linux/mman.h include/uapi/linux/mman.h

Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-3rvc39lon93kgt5pl31d8g4x@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/mman.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/uapi/linux/mman.h b/tools/include/uapi/linux/mman.h
index bfd5938fede6..d0f515d53299 100644
--- a/tools/include/uapi/linux/mman.h
+++ b/tools/include/uapi/linux/mman.h
@@ -28,7 +28,9 @@
 #define MAP_HUGE_2MB	HUGETLB_FLAG_ENCODE_2MB
 #define MAP_HUGE_8MB	HUGETLB_FLAG_ENCODE_8MB
 #define MAP_HUGE_16MB	HUGETLB_FLAG_ENCODE_16MB
+#define MAP_HUGE_32MB	HUGETLB_FLAG_ENCODE_32MB
 #define MAP_HUGE_256MB	HUGETLB_FLAG_ENCODE_256MB
+#define MAP_HUGE_512MB	HUGETLB_FLAG_ENCODE_512MB
 #define MAP_HUGE_1GB	HUGETLB_FLAG_ENCODE_1GB
 #define MAP_HUGE_2GB	HUGETLB_FLAG_ENCODE_2GB
 #define MAP_HUGE_16GB	HUGETLB_FLAG_ENCODE_16GB
