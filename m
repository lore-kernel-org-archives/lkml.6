Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-918035-1522198205-2-8656346074367668558
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522198205; b=Accec+x1i4C45f6Vji0HQJUb2xNzPjO8IFoyV8GRp419tOW
    g3uchS8Z2Z/GquvFk2RnxqxzkKNiQp8GuQLRyoPnA3wP2WSiy3mD3Fmz1J/dILBe
    WDEUtwg+bBa1fiWffmuQ221v62BtBwowuStX/WsGhwV1ulUE+/qNR+MAy8YqWmd3
    qkfFTyvjcUXRtBk/atPK90FIDCwxmBxXtDpolu8SJdORrjaWjVWjn5q7/8wFSvDi
    FtNomzwWQPCLuLSuSDwAoMiXpjwsG0yCjCGW8ySnqgFQ9Wh8Zmk5Gvfw4Vo9hGva
    LvWXl7yEYvzTjfMyOvR6q8B0bqrROkhKzts04mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:reply-to:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1522198205; bh=B
    GzIiaVMbZn+akW6hY6GAIKuofHuavPpsNVkGgOV2II=; b=J8e09YRmVFqxQkDmX
    hs3y2yLb48QSn5lDZicqtPzTY+xzezXT9j+4/BSOUpbnrwkyULZ9K99sE7EYC4Mb
    kw+oSxNU3+H+ljhpD7msKA+uZcSs8OxfdVzHfp5/uqyiu8s5pepzSThNN0ybKK7Q
    qLeHDBLlN5Od9X0WTUDnK0aBv3G09FkcRA/MEj9Z+vgu2xtiRlOO0BLTO46i2WX6
    hZf/yYC07pfM9ZB1LY3bN3CYryttMKbO0jN3qfEeOw1fidgsWg7FETd4HU5TPpr3
    cORvzOTXPT/Q1Lg+8CvBqvFDe5xCA8I0m7fH09KxrcB9gq3Ottrfmno1FS0+u+9S
    KH7OA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxonhyperv.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxonhyperv.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBQu4Pgx7fZecDNHQE+F0L+tRivywdCs1BeQPDuIscFIn3ciKyd/OotahbGDdeEMJEyQ7nVWSx/I2IEiIldo/eujFer0LgbxWq+Qact00XUaCnJLm/37
    cYGSP9UMPrilvqrxSeCWgFu6Frfu9ovhuEOIxHJPkJGuyoxUAGJkAwJ2E+x/uP/H2YQTglaUVDcgjzAO6IJ/QhLLfwq76UdmMYQQDOulnefp7q/jVj/tYMdm
    FYCbS1OZnUrw9Hu5x8bZUA==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=wmH2h71lHiwA:10 a=kj9zAlcOel0A:10
    a=v2DPQv5-lfwA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8
    a=DDOyTI_5AAAA:8 a=5HpQNoHjLGEvby53UEYA:9 a=V7fV_jzFQkq4eOXZ:21
    a=U1Gqbv1UlfU3QOwE:21 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
x-originating-ip: 107.180.71.197
From: Long Li <longli@linuxonhyperv.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "James E . J . Bottomley" <JBottomley@odin.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 devel@linuxdriverproject.org, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [Resend Patch 1/3] Vmbus: Add function to report available ring
 buffer to write in total ring size percentage
Date: Tue, 27 Mar 2018 17:48:38 -0700
Message-Id: <20180328004840.22787-1-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.15.1
X-CMAE-Envelope: MS4wfNJ6pGtR6gGAFdPhrWcC9kiZ9fcY+GIdI4EPrRfQwpWOSV6mwKrIzdEA1/pU9cZrm5I3e/VbeROWV/AX4TdVkymFXUoVRpBc/yteVC8Bu/u9GKjRN9lT
 +0VCyMBM1NY3BlN1/oRsTF2cLcCEYIojwXzdP7cDY/BT/XpDkmwz3L//7gAyOvcc/4moHPY3fZgPtPDqMYxmbgE341inpye7Pe9CfLWauDnrR7Qj/v4bA9vs
 Md3SvZh6owgEYGdVLiI7i6p7CprmjSO79t2vBHIHYM77rMpGLJJGHB34u+V0SrGcgRTHhoBarG0wstORu7BJb4DSLJoO4SWbBoqNUlhH6q6pwW1m8U1I6XGQ
 a84a4MlWL8dfN0zgaDT9VxBsM2IWiaikbduErwhT0++EyLL3a21yIeTwsEwm+PULbAB/ybMoakb7SPkRLC9VuKIXEjyEk48PSPLmm7EJLuYz3zTpGQ2D9vy+
 8M4459AccNe0D6moXR2HPXLYWhcmTnxRetFLjru6fBiuQOOVFDUlu8A2WbtWpABm9omA08OF6wU4i4GG
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
Reply-To: longli@microsoft.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Long Li <longli@microsoft.com>

Netvsc has a function to calculate how much ring buffer in percentage is
available to write. This function is also useful for storvsc and other
vmbus devices.

Define a similar function in vmbus to be used by other vmbus devices.

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
