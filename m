Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965902AbeEJSOu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 14:14:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48957 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935403AbeEJSOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 14:14:49 -0400
Date: Thu, 10 May 2018 11:14:34 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-8o5auh1lqglsgl1q97x00tlv@git.kernel.org>
Cc: dsahern@gmail.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, namhyung@kernel.org, rkrcmar@redhat.com,
        acme@redhat.com, wangnan0@huawei.com, hpa@zytor.com,
        karahmed@amazon.de, jolsa@kernel.org, tglx@linutronix.de
Reply-To: karahmed@amazon.de, tglx@linutronix.de, jolsa@kernel.org,
        wangnan0@huawei.com, hpa@zytor.com, rkrcmar@redhat.com,
        acme@redhat.com, linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        namhyung@kernel.org, mingo@kernel.org, dsahern@gmail.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools headers kvm: Sync uapi/linux/kvm.h with the
 kernel sources
Git-Commit-ID: d0e9f4c1a4e777c4d1122758137fc47238f4f015
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  d0e9f4c1a4e777c4d1122758137fc47238f4f015
Gitweb:     https://git.kernel.org/tip/d0e9f4c1a4e777c4d1122758137fc47238f4f015
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 7 May 2018 12:26:23 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 7 May 2018 15:23:45 -0300

tools headers kvm: Sync uapi/linux/kvm.h with the kernel sources

The changes in 5e62493f1a70 ("x86/headers/UAPI: Move DISABLE_EXITS KVM
capability bits to the UAPI") do not requires changes in the tooling nor
will trigger the automatic update of used ioctl string tables, copy it
to silence this build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/kvm.h' differs from latest version at 'include/uapi/linux/kvm.h'

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: KarimAllah Ahmed <karahmed@amazon.de>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-8o5auh1lqglsgl1q97x00tlv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/kvm.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 1065006c9bf5..b02c41e53d56 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -676,6 +676,13 @@ struct kvm_ioeventfd {
 	__u8  pad[36];
 };
 
+#define KVM_X86_DISABLE_EXITS_MWAIT          (1 << 0)
+#define KVM_X86_DISABLE_EXITS_HTL            (1 << 1)
+#define KVM_X86_DISABLE_EXITS_PAUSE          (1 << 2)
+#define KVM_X86_DISABLE_VALID_EXITS          (KVM_X86_DISABLE_EXITS_MWAIT | \
+                                              KVM_X86_DISABLE_EXITS_HTL | \
+                                              KVM_X86_DISABLE_EXITS_PAUSE)
+
 /* for KVM_ENABLE_CAP */
 struct kvm_enable_cap {
 	/* in */
