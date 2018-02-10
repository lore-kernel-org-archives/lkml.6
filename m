Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3162764-1518243674-2-1345457470063192879
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: cc='ISO-8859-15', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518243674; b=D0BFxDCBOFrRjCD8oytIakc1TwNXEZb09ip7QDbkErNVw6l
    pv4nTPHWMeUdMA72rZPT783T2fg/zDTzMFG5bUKKyCGtUR1A9grXuOeCRvpwTxrQ
    A0C9gHPCHNnep12pLAS0yUnWaUzaLXTdOr4vIZa+/2SjP+vLfB6hy1sTw25lk046
    g5iVBdVJRAIEpmfEHJILcXCkH7t6ubcXS23xex45o1Sf3ty0OpnIvoNWVhSk2ozl
    8QVR25yHDI4BXeT9lk5NElCiesrnCIstc6w8dPI5PGBHxVyTEZkNvDZTNmx8AUV/
    xZwtOP6ltdjISFJIkDSEFdkc5VKHzAYMCyxU5Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518243674; bh=n
    w9UVy3jDrcZeDlWkvAwzTREU02KiXeLmXK8qeMsftc=; b=S6jPpIrvJ55xJ+c3y
    taiJ2ru8WKrIjNOGV8JutgxI/67n79j6Cz4SgQlCo6OrtiU4JJU+qp1fs4I6ZEiK
    QO2X9VYyvditl62/mHd2+HzDWD74jid2H2BYT2Blm2KP0J3z4TiCaqgJtUkS9qHU
    XRmQ7vEkoJc7Zdel0eH69pR241X1CootoPKw7/IvhXTV4u6MPTT7l/gy5wNHIFuk
    4TxIn3Pe8gVFCOUyo4U5SG4PRThu8wOkYTqGscD8XhsOTL/yOzTHPLMum/UZlIoS
    SpG+y560SBhtSDpbANzBvkvcLg7HqL+w5sup8dheNrf6IGhlRpa9ljKVNht7E8zZ
    v1Z6Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=J4wuDx/0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=J4wuDx/0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=J4wuDx/0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=J4wuDx/0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E8B5060558
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=lmark@codeaurora.org
Date: Fri, 9 Feb 2018 22:21:05 -0800 (PST)
From: Liam Mark <lmark@codeaurora.org>
X-X-Sender: lmark@lmark-linux.qualcomm.com
To: Laura Abbott <labbott@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH] staging: android: ion: Restrict cache maintenance to dma
 mapped memory
Message-ID: <alpine.DEB.2.02.1802092217010.2846@lmark-linux.qualcomm.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
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
Cc: devel@driverdev.osuosl.org, Todd Kjos <tkjos@android.com>,
 linux-kernel@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 =?ISO-8859-15?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>,
 Martijn Coenen <maco@android.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The ION begin_cpu_access and end_cpu_access functions use the
dma_sync_sg_for_cpu and dma_sync_sg_for_device APIs to perform cache
maintenance.

Currently it is possible to apply cache maintenance, via the
begin_cpu_access and end_cpu_access APIs, to ION buffers which are not
dma mapped.

The dma sync sg APIs should not be called on sg lists which have not been
dma mapped as this can result in cache maintenance being applied to the
wrong address. If an sg list has not been dma mapped then its dma_address
field has not been populated, some dma ops such as the swiotlb_dma_ops ops
use the dma_address field to calculate the address onto which to apply
cache maintenance.

Fix the ION begin_cpu_access and end_cpu_access functions to only apply
cache maintenance to buffers which have been dma mapped.

Fixes: 2a55e7b5e544 ("staging: android: ion: Call dma_map_sg for syncing and mapping")
Signed-off-by: Liam Mark <lmark@codeaurora.org>
---
 drivers/staging/android/ion/ion.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index f480885e346b..e5df5272823d 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -214,6 +214,7 @@ struct ion_dma_buf_attachment {
 	struct device *dev;
 	struct sg_table *table;
 	struct list_head list;
+	bool dma_mapped;
 };
 
 static int ion_dma_buf_attach(struct dma_buf *dmabuf, struct device *dev,
@@ -235,6 +236,7 @@ static int ion_dma_buf_attach(struct dma_buf *dmabuf, struct device *dev,
 
 	a->table = table;
 	a->dev = dev;
+	a->dma_mapped = false;
 	INIT_LIST_HEAD(&a->list);
 
 	attachment->priv = a;
@@ -272,6 +274,7 @@ static struct sg_table *ion_map_dma_buf(struct dma_buf_attachment *attachment,
 			direction))
 		return ERR_PTR(-ENOMEM);
 
+	a->dma_mapped = true;
 	return table;
 }
 
@@ -279,7 +282,10 @@ static void ion_unmap_dma_buf(struct dma_buf_attachment *attachment,
 			      struct sg_table *table,
 			      enum dma_data_direction direction)
 {
+	struct ion_dma_buf_attachment *a = attachment->priv;
+
 	dma_unmap_sg(attachment->dev, table->sgl, table->nents, direction);
+	a->dma_mapped = false;
 }
 
 static int ion_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
@@ -345,8 +351,9 @@ static int ion_dma_buf_begin_cpu_access(struct dma_buf *dmabuf,
 
 	mutex_lock(&buffer->lock);
 	list_for_each_entry(a, &buffer->attachments, list) {
-		dma_sync_sg_for_cpu(a->dev, a->table->sgl, a->table->nents,
-				    direction);
+		if (a->dma_mapped)
+			dma_sync_sg_for_cpu(a->dev, a->table->sgl,
+					    a->table->nents, direction);
 	}
 	mutex_unlock(&buffer->lock);
 
@@ -367,8 +374,9 @@ static int ion_dma_buf_end_cpu_access(struct dma_buf *dmabuf,
 
 	mutex_lock(&buffer->lock);
 	list_for_each_entry(a, &buffer->attachments, list) {
-		dma_sync_sg_for_device(a->dev, a->table->sgl, a->table->nents,
-				       direction);
+		if (a->dma_mapped)
+			dma_sync_sg_for_device(a->dev, a->table->sgl,
+					       a->table->nents, direction);
 	}
 	mutex_unlock(&buffer->lock);
 
-- 
1.8.5.2


Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
