Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-422771-1518026232-2-1803952698647309106
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518026232; b=Z0f9FUjoegYjaE2tQckBzHRCVQN21PDlYs9NfyUa/K1ve8Z
    sx03hH+PIBzIcnVLO7s6bcCtMLyTwvp3acYFFB5osF619pss6oJYmDyHwjJX7kxg
    f6qRnAcAFbrF0dRxe6lus/4YS7YpY7G4aev8LDma5bZbkULUECF86RLjn8qhaG6c
    zV906M0cSa7UjSnp1PzIZMZCWdSSo2EExT7e9qA1nT1Ui7ac0fklIy4mVUvSgYaO
    C7A42UhVGkGjCZwnicEaGxocT9NYnHkdBwYctfT2KFHXEAcziM2pyhrez9k/DhuU
    x/iVKZOMrO4rXXPVkUPCT2Hd7PCP5bPbe+xSX4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518026232; bh=0
    LETxCKjQATvTPyLthUS72aAQHLLmFuCFQglSHe4838=; b=A2nofBd0T25IijpjB
    b4dBbOl4iaeqG/LtioVit3yAKFJ+agTmfk8F+szxdsXxFXS6iCZEhJ3D61D2ubBU
    83LQ54LwLK5T4Cm9EmjBgLr/TQvT/KogaA0s0h/nDKIOkIAhYHeh5f7NXe2PNLxV
    assjeiGnREhXGUJErclGfn+qxxFdzbB6mSIjy2huigltEMint9PML7MBHtAgQ5Qb
    3UUsm4N8DL6D2KBFKo2+ZAeaN3DSWkpuMIgqF7daJ+GWmH47SIGehBYs4aVMsIOb
    tmZfOUO9vdK3GFl8xPlsNrBgW/iM87bFpCVGBAQsKRUVTRiGNsp1NVq1Pf1ZQwn5
    9+7IQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: devel@linuxdriverproject.org
Subject: [PATCH RESEND 4/4] hv_balloon: trace post_status
Date: Wed,  7 Feb 2018 18:50:03 +0100
Message-Id: <20180207175003.28859-5-vkuznets@redhat.com>
In-Reply-To: <20180207175003.28859-1-vkuznets@redhat.com>
References: <20180207175003.28859-1-vkuznets@redhat.com>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: Eduardo Otubo <otubo@redhat.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Alex Ng <alexng@microsoft.com>,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hyper-V balloon driver makes non-trivial calculations to convert Linux's
representation of free/used memory to what Hyper-V host expects to see. Add
a tracepoint to see what's being sent and where the data comes from.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 drivers/hv/Makefile           |  1 +
 drivers/hv/hv_balloon.c       |  6 ++++++
 drivers/hv/hv_trace_balloon.h | 48 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+)
 create mode 100644 drivers/hv/hv_trace_balloon.h

diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
index 14c22786b519..a1eec7177c2d 100644
--- a/drivers/hv/Makefile
+++ b/drivers/hv/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_HYPERV_UTILS)	+= hv_utils.o
 obj-$(CONFIG_HYPERV_BALLOON)	+= hv_balloon.o
 
 CFLAGS_hv_trace.o = -I$(src)
+CFLAGS_hv_balloon.o = -I$(src)
 
 hv_vmbus-y := vmbus_drv.o \
 		 hv.o connection.o channel.o \
diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 7514a32d0de4..b3e9f13f8bc3 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -34,6 +34,9 @@
 
 #include <linux/hyperv.h>
 
+#define CREATE_TRACE_POINTS
+#include "hv_trace_balloon.h"
+
 /*
  * We begin with definitions supporting the Dynamic Memory protocol
  * with the host.
@@ -1159,6 +1162,9 @@ static void post_status(struct hv_dynmem_device *dm)
 		 dm->num_pages_added - dm->num_pages_onlined : 0) +
 		compute_balloon_floor();
 
+	trace_balloon_status(status.num_avail, status.num_committed,
+			     vm_memory_committed(), dm->num_pages_ballooned,
+			     dm->num_pages_added, dm->num_pages_onlined);
 	/*
 	 * If our transaction ID is no longer current, just don't
 	 * send the status. This can happen if we were interrupted
diff --git a/drivers/hv/hv_trace_balloon.h b/drivers/hv/hv_trace_balloon.h
new file mode 100644
index 000000000000..93082888aec3
--- /dev/null
+++ b/drivers/hv/hv_trace_balloon.h
@@ -0,0 +1,48 @@
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM hyperv
+
+#if !defined(_HV_TRACE_BALLOON_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _HV_TRACE_BALLOON_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(balloon_status,
+	    TP_PROTO(u64 available, u64 committed,
+		     unsigned long vm_memory_committed,
+		     unsigned long pages_ballooned,
+		     unsigned long pages_added,
+		     unsigned long pages_onlined),
+	    TP_ARGS(available, committed, vm_memory_committed,
+		    pages_ballooned, pages_added, pages_onlined),
+	    TP_STRUCT__entry(
+		    __field(u64, available)
+		    __field(u64, committed)
+		    __field(unsigned long, vm_memory_committed)
+		    __field(unsigned long, pages_ballooned)
+		    __field(unsigned long, pages_added)
+		    __field(unsigned long, pages_onlined)
+		    ),
+	    TP_fast_assign(
+		    __entry->available = available;
+		    __entry->committed = committed;
+		    __entry->vm_memory_committed = vm_memory_committed;
+		    __entry->pages_ballooned = pages_ballooned;
+		    __entry->pages_added = pages_added;
+		    __entry->pages_onlined = pages_onlined;
+		    ),
+	    TP_printk("available %lld, committed %lld; vm_memory_committed %ld;"
+		      " pages_ballooned %ld, pages_added %ld, pages_onlined %ld",
+		      __entry->available, __entry->committed,
+		      __entry->vm_memory_committed, __entry->pages_ballooned,
+		      __entry->pages_added, __entry->pages_onlined
+		    )
+	);
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE hv_trace_balloon
+#endif /* _HV_TRACE_BALLOON_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
