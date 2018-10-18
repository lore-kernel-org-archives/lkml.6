Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5D0C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1526021476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:17:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1526021476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbeJROQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 10:16:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39057 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbeJROQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 10:16:23 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9I6GRUd707496
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 17 Oct 2018 23:16:27 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9I6GR60707492;
        Wed, 17 Oct 2018 23:16:27 -0700
Date:   Wed, 17 Oct 2018 23:16:27 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-67h1bio5bihi1q6dy7hgwwx8@git.kernel.org>
Cc:     acme@redhat.com, adrian.hunter@intel.com, namhyung@kernel.org,
        wangnan0@huawei.com, dasch@google.com, jolsa@kernel.org,
        pbonzini@redhat.com, hpa@zytor.com, tglx@linutronix.de,
        dsahern@gmail.com, mingo@kernel.org, linux-kernel@vger.kernel.org
Reply-To: adrian.hunter@intel.com, wangnan0@huawei.com,
          namhyung@kernel.org, acme@redhat.com, dsahern@gmail.com,
          tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, jolsa@kernel.org, dasch@google.com,
          pbonzini@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools headers uapi: Sync kvm.h copy
Git-Commit-ID: 25fe15e54fe5e15b4963fe101f7cd8bad4f11393
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

Commit-ID:  25fe15e54fe5e15b4963fe101f7cd8bad4f11393
Gitweb:     https://git.kernel.org/tip/25fe15e54fe5e15b4963fe101f7cd8bad4f11393
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 8 Oct 2018 12:09:14 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 8 Oct 2018 12:09:14 -0300

tools headers uapi: Sync kvm.h copy

To pick up the changes introduced in:

  6fbbde9a1969 ("KVM: x86: Control guest reads of MSR_PLATFORM_INFO")

That is not yet used in tools such as 'perf trace'.

The type of the change in this file, a simple integer parameter to the
KVM_CHECK_EXTENSION ioctl should be easier to implement tho, adding to
the libbeauty TODO list.

This silences this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/kvm.h' differs from latest version at 'include/uapi/linux/kvm.h'
  diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Drew Schmitt <dasch@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-67h1bio5bihi1q6dy7hgwwx8@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/kvm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 07548de5c988..251be353f950 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -952,6 +952,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_S390_HPAGE_1M 156
 #define KVM_CAP_NESTED_STATE 157
 #define KVM_CAP_ARM_INJECT_SERROR_ESR 158
+#define KVM_CAP_MSR_PLATFORM_INFO 159
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
