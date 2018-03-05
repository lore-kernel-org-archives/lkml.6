Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-703119-1520227136-2-5720829580363028578
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520227135; b=Hqr7VP1fsnhWgmO6ZIGZwXKGJv1Mrok+jir1TxOOjSgYHrf
    rohI0lsgvPQbSSfINHVx5janqL44pSxR73HUzxO7c+8m1D5lRcbNHWpAeRY6xDTu
    QfvpTCW0bo78R1lcIjG2F+uKdlvgvGxTTZwZFEVvOgW1uPrkLYYnIRC6NdPVM5pt
    Vx+HbdRpzDXhzkvtV0+guyLl35NLGN8Jv41OU5Q7uuqnQsEgNK8xOugkrbBP3Woc
    uFwRIcKOGOxhHDfa753L3mywguSzM2W0JqREG8dM2GxEw4lQc/w3fmxJOdOGJ0cz
    7XYYO5mXiXaqLkTh/YkwSdsLcPvxH+duefWiOwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:reply-to:mime-version
    :content-type:content-transfer-encoding:sender; s=arctest; t=
    1520227135; bh=BkLNNDkojLP+vQWtbR/jnuvQZfaUiNFfxSWm5Mmhobo=; b=X
    OYig5bZjcAKr+siq8YCcwYHLAnfgu346PCG8k6hezTw6rpEtU8OFiHgG2woUgDq7
    FftMSCAkaVoiQAaJAZd/TRb/6urNWfu3d/eDCXdaNQWB76tpo7e4UmeLQS7RJ9pZ
    iVGbIJBxNlSo8r/Qwm+dt2aOs/NMyYCZ7dSDs+oCxevJlNVxi7k2k4e0Il7YUNTv
    k8Rne81gQheqkcDW3Jz3Xg9V9sliOfAdRVVVA0+BjmRoPFX3mLKEmXvGpwg3aTvx
    ST00ZPEX8Jf5BnolpOAiR3IOtrvQwSaOKJ2V2FUG6pWMcIndsjt5fsFpq36Q6Ob9
    LGLz4N35st/oJcwxG1ZbA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=exchange.microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=exchange.microsoft.com header.result=pass header_org.domain=microsoft.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=exchange.microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=exchange.microsoft.com header.result=pass header_org.domain=microsoft.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
x-originating-ip: 107.180.71.197
From: kys@exchange.microsoft.com
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
 vkuznets@redhat.com, jasowang@redhat.com, leann.ogasawara@canonical.com,
 marcelo.cerri@canonical.com, sthemmin@microsoft.com
Subject: [PATCH V2 12/12] hv_balloon: trace post_status
Date: Sun,  4 Mar 2018 22:17:22 -0700
Message-Id: <20180305051722.19157-12-kys@exchange.microsoft.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180305051722.19157-1-kys@exchange.microsoft.com>
References: <20180305051539.19079-1-kys@exchange.microsoft.com>
 <20180305051722.19157-1-kys@exchange.microsoft.com>
X-CMAE-Envelope: MS4wfIlrs04KbsvJwBOada1kGsbtPgPRQJ9ul0P3tzLaVZW0c/mQWcoGq6l2eqkmi3yyh3PMiRTZvIQgE1y8KbT3tcbFtaLqcGw/M5HFBjHywGCsiUibZjvV
 K32h7Mi6ywTc0g7HHxjUR+lQE2Jq8lheV+QG7pT9NTd4fq1qgHr9seUiojyimL5JEodd6lzxpP1/FkmUhVSXCyzw95JUSLgNujx2KOXrS0PfhgZU/TfFb9iS
 P32Yo3u9m3O0lHmnNtZmuC6KisvAHuagY3hHIZLOvIoJzUmwmP9jB3+jCCrRQhUjgBx3dkVgKVqw45p7HrXxQ1isU+4/mLfrxHj3KVfuw4le9+vvDPt9GNSf
 WuU+ry8WiX9iBguCLAbaYic6UOT/WfvZpJjvIvp89WrQZxBL2ymNdS4or4U78ZT9ikGkbR/2f5DeM9pNtFJLF1WViLsTFsoYeHbyHsFR7AU0i+a/hJ+m4yCs
 oi5YEHa0NIxHfsk2Vi/5LdFNBnj2+I1OIpyrqsm9wlaKFe0+3jqTbJBkrMrMRva05WMafM4liSI9V2D7vR/hfMzMeaNB8FbGGgx93A==
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
Reply-To: kys@microsoft.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Vitaly Kuznetsov <vkuznets@redhat.com>

Hyper-V balloon driver makes non-trivial calculations to convert Linux's
representation of free/used memory to what Hyper-V host expects to see. Add
a tracepoint to see what's being sent and where the data comes from.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
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
2.15.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
