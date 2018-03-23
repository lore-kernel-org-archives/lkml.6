Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3955644-1521764223-2-3645986355748886335
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521764222; b=hVLLl2WOlxLb1Ig1dUima0qWlkvhWt2xdvstWOoOv8Wxo+H
    KalytbgIFQ4yMvh+/ftXKs9yZuOI+ARHweCjQnxt73bK6aNr4zBAlOWn0ALKFMb/
    uyuuyPyl8jlhYUTwZ1gjEaCrh8J670uwPrCFYWaehBhEHdVuqio7GEiDfqcyR3Vp
    oKn49pkRw1xM1dWqHg2cliWmcUxYuFr921PmO7OwQtDtyNL7qZCGknqkJJiRuAKw
    vMUSUJ9Tyo9DAnnfWP31+qIRnVVoLibnH2PWJ2YzdTVvMqtlqjJLpstxQeLraEwW
    CcDk4Ca6+1ALGKxAqVyF7samGohFdZEI4dfssfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521764222; bh=P
    /qQc2fdn84lGW+UqkBs8oViQu7ypw0H5RwhLzRa9e0=; b=qrFg6PyLD6dFptiV9
    56fMqINa9eTvr0tUpRilQKolZ9fjon+P6yjYSFV7PyRUPEVCROHFUGWu+m2QUqla
    riZJun6N/Y2bDV2lHy2WMlSLcy2zncpnWBYjdxJJa3Mq8c8k5vLZRAtiihFxzQQh
    396+y77LowPNWgmEPR0mYpcaUzKBTDDwYeHTcw/iOvLcDNItam9ba+XYx4gx0z6U
    dMyHnlFB1+oCz8nzg6jMzo2PBG3dKZ/BVSwgTcCtystAevs7E7qFIg4k8oK4FpeE
    7y5GYIGG6EEb9gZ0D47h2XyEBGOY8IlbvFp7SWxNennGL2MvzTzdT0WubWxA3DLk
    3VmsA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxonhyperv.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxonhyperv.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
x-originating-ip: 107.180.71.197
From: Long Li <longli@linuxonhyperv.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "James E . J . Bottomley" <JBottomley@odin.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 devel@linuxdriverproject.org, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] Vmbus: Add function to report available ring buffer to
 write in total ring size percentage
Date: Thu, 22 Mar 2018 17:15:36 -0700
Message-Id: <20180323001538.31876-1-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.15.1
X-CMAE-Envelope: MS4wfOMlhT6CUbBhekVNpPBE852wfm96Z32mMVTFv9G2RIOWmdiHTCNC9fUYp20cjpmEhkKoRJ2ZQtgV1tv4Ff3qIwjdmkh37K8IAmVjVBBUj/u6gqEQeAsj
 ngaZ6lrmL0XJE6SrX6KjCzds5wQavQcz03Knn2HNnHqoG4V7DZg+3DSYN/St2Knohyvt+FqkxzLqdtUaCyhSUp0hGM0rkhsRJFomMWEAFqe5j8TsM8Is6VId
 0jfMyrJKM+t3IpBPJRK1jMtKM039cViX23sNu7T/fsPCL299RTSQLhIJNKibp1twhFx29Z8dkr7MqDZzeINLeNarNt+dkGLB7o30/98xiyOFU6y+URGx2I31
 f8l/zxlGsrMecltHEIbG89B+mhooukh9Ir1SBQXcvfceI1Fw07VjHlwotDU7ygWHRTtTbnrH4Lbz69RcwbYRIRVi+bdRr6S5h8kyInqjgADDyxfcRDJMIZq9
 9Ql4vg9ulCHg2/l+VRm6LhEccRDlHdfuuekMSvj8a+i6XRxRvc4I+iq86VY=
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Long Li <longli@microsoft.com>

Netvsc has a similar function to calculate how much ring buffer in
percentage is available to write. This function is useful for storvsc and
other vmbus devices.

Define a similar function in vmbus to be used by storvsc.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/hv/ring_buffer.c |  2 ++
 include/linux/hyperv.h   | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index 8699bb969e7e..3c836c099a8f 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -227,6 +227,8 @@ int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
 	ring_info->ring_buffer->feature_bits.value = 1;
 
 	ring_info->ring_size = page_cnt << PAGE_SHIFT;
+	ring_info->ring_size_div10_reciprocal =
+		reciprocal_value(ring_info->ring_size / 10);
 	ring_info->ring_datasize = ring_info->ring_size -
 		sizeof(struct hv_ring_buffer);
 
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 2048f3c3b68a..eb7204851089 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -36,6 +36,7 @@
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
 #include <linux/interrupt.h>
+#include <linux/reciprocal_div.h>
 
 #define MAX_PAGE_BUFFER_COUNT				32
 #define MAX_MULTIPAGE_BUFFER_COUNT			32 /* 128K */
@@ -121,6 +122,7 @@ struct hv_ring_buffer {
 struct hv_ring_buffer_info {
 	struct hv_ring_buffer *ring_buffer;
 	u32 ring_size;			/* Include the shared header */
+	struct reciprocal_value ring_size_div10_reciprocal;
 	spinlock_t ring_lock;
 
 	u32 ring_datasize;		/* < ring_size */
@@ -155,6 +157,16 @@ static inline u32 hv_get_bytes_to_write(const struct hv_ring_buffer_info *rbi)
 	return write;
 }
 
+static inline u32 hv_get_avail_to_write_percent(
+		const struct hv_ring_buffer_info *rbi)
+{
+	u32 avail_write = hv_get_bytes_to_write(rbi);
+
+	return reciprocal_divide(
+			(avail_write  << 3) + (avail_write << 1),
+			rbi->ring_size_div10_reciprocal);
+}
+
 /*
  * VMBUS version is 32 bit entity broken up into
  * two 16 bit quantities: major_number. minor_number.
-- 
2.14.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
