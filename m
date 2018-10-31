Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830E1ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ACD92081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jc0vasR1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ACD92081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730208AbeKABpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 21:45:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729775AbeKABpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 21:45:22 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0A5720821;
        Wed, 31 Oct 2018 16:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541004395;
        bh=uygDk3tBUv9QkaW0L64ab+qDlgeu/RAd/PkWkDCCNrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jc0vasR1qqjiNcMkSji4BPSXWcuamuXO9W4iKyAxVX3KRfV0IumwNualHbnS8w8S4
         cAQxGjp9tMFfDSx3MFtEAUwEeB3j56tl8Z3q2QL1j+Iwn8HFfVRAiV2M/ZpMO11pUk
         +k2W74Z2sY44joHwv3QLvVaALQX+9U8Vc41W6J/o=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 21/28] tools include uapi: Update linux/mmap.h copy
Date:   Wed, 31 Oct 2018 13:45:01 -0300
Message-Id: <20181031164508.4784-22-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181031164508.4784-1-acme@kernel.org>
References: <20181031164508.4784-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.14.4

