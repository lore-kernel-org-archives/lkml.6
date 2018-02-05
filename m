Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752323AbeBEVgu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 16:36:50 -0500
Received: from terminus.zytor.com ([65.50.211.136]:51695 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752291AbeBEVgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 16:36:45 -0500
Date: Mon, 5 Feb 2018 13:34:14 -0800
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-kif2fdkcaewj8iqw6lwyil8s@git.kernel.org>
Cc: rkrcmar@redhat.com, dsahern@gmail.com, borntraeger@de.ibm.com,
        namhyung@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, wangnan0@huawei.com, acme@redhat.com,
        mingo@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com
Reply-To: namhyung@kernel.org, borntraeger@de.ibm.com, dsahern@gmail.com,
        rkrcmar@redhat.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        hpa@zytor.com, wangnan0@huawei.com, acme@redhat.com,
        adrian.hunter@intel.com, jolsa@kernel.org, mingo@kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tooling headers: Synchronize updated s390 kvm
 UAPI headers
Git-Commit-ID: 9a3853587c2bb0a38c2ce80a613ace5e84ae4337
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

Commit-ID:  9a3853587c2bb0a38c2ce80a613ace5e84ae4337
Gitweb:     https://git.kernel.org/tip/9a3853587c2bb0a38c2ce80a613ace5e84ae4337
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 2 Feb 2018 16:43:45 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 2 Feb 2018 16:43:45 -0300

tooling headers: Synchronize updated s390 kvm UAPI headers

The 35b3fde6203b ("KVM: s390: wire up bpb feature") was noticed by the
perf build process:

  Warning: Kernel ABI header at 'tools/arch/s390/include/uapi/asm/kvm.h' differs from latest version at 'arch/s390/include/uapi/asm/kvm.h'

The changes in this cset don't cause or require changes in tools/perf/,
so just update the copy to silence the build warning.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-kif2fdkcaewj8iqw6lwyil8s@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/s390/include/uapi/asm/kvm.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/arch/s390/include/uapi/asm/kvm.h b/tools/arch/s390/include/uapi/asm/kvm.h
index 38535a57..4cdaa55 100644
--- a/tools/arch/s390/include/uapi/asm/kvm.h
+++ b/tools/arch/s390/include/uapi/asm/kvm.h
@@ -224,6 +224,7 @@ struct kvm_guest_debug_arch {
 #define KVM_SYNC_RICCB  (1UL << 7)
 #define KVM_SYNC_FPRS   (1UL << 8)
 #define KVM_SYNC_GSCB   (1UL << 9)
+#define KVM_SYNC_BPBC   (1UL << 10)
 /* length and alignment of the sdnx as a power of two */
 #define SDNXC 8
 #define SDNXL (1UL << SDNXC)
@@ -247,7 +248,9 @@ struct kvm_sync_regs {
 	};
 	__u8  reserved[512];	/* for future vector expansion */
 	__u32 fpc;		/* valid on KVM_SYNC_VRS or KVM_SYNC_FPRS */
-	__u8 padding1[52];	/* riccb needs to be 64byte aligned */
+	__u8 bpbc : 1;		/* bp mode */
+	__u8 reserved2 : 7;
+	__u8 padding1[51];	/* riccb needs to be 64byte aligned */
 	__u8 riccb[64];		/* runtime instrumentation controls block */
 	__u8 padding2[192];	/* sdnx needs to be 256byte aligned */
 	union {
