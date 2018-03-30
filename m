Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2302655-1522377871-2-7678181010885637866
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES rosk.us-asciien, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522377869; b=Z3SlnLkhPoJ0lvXpBaFfeKSr6N5V1sBZyE41fWnbXYDsZEE7ai
    jaXERvVhZelC/j87iDyHCG6I/TpADP7/WWBrIoAYTnTbl6UKtSkp4GaVVdHfrU0g
    hqsOfpLUomlWAT+cJB+pX+WfegNzz5BynTo5IqN7H9UU/DWqYEZZRDIDEAqupG7n
    quPoPxuE7nZBmemk4atDepHb3KJWuvhpSiyHevWpM5QGHkmTmd+rHFR9Tpw3T4li
    j8/RdoduPhRdCKvej8WhS9qNh4rfO/Nt0W8aWJClUOiIhnO03cYEuT4WgSAA8cpP
    eO7ex4EJUV2cqaSv7qJLHsYc8bJcIrOrlvkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522377869; bh=Cy4Cg
    IWvXwZJSYQLucEBj/rVnbsa9LqEYhQJe82qN+o=; b=V+0qsZlrYSsi9sctHHtLI
    IMia0TOmbiy5BckL61dRsbmNT5gCK82pSRzPdK/mNeh213LpXkoDKCn9ff9S6RQ/
    GTa3yEKMToIcjTBk1JPPFn2DgvzxKbnVKLPJJvmQh5bI7Z0zNhlBzyJCYmvhoPbG
    tBN8gTzykFMfXmQFyXu/x3DRVNAu2LumprygUC3KgiYuI35xSH+gV6lsrg2pxWq4
    ed9ZW42iDNKn4x1AKJHEuEieI1CD4iha5AXlbMlvMeFCkt+hAGE4mxhPeV16Ub2N
    y7V7da2i/f6rmEF5+iOBYcTf0muM4Sa55RFK6bkcIkZmHKwi26WjvmYFJWOpFv35
    Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=JYIeTXD/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=JYIeTXD/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEn9j2O8YvXXokmVlwLt0sSpNE0vrnZZbPr0DdhpTtjUxQ+oVY3F8PM7Qv7trwtBirZvRQenH10GDZZkfO+fFsOMwsn106GPGL1Pi3SMRGBboE1BKbTx
    ddbVEaQIBfWkcuP3fYs8TNWdD8Jkqzgu6iPQiCnri+19AB/0qN7ACEcDXj2hHfY62QI41cNXcCnSi0VXbdZQXTpfTZjoB5yuaCZpR4v0keuHJaY8iFgR/PDp
    AnLp4n7N3oiUX0JeRzXELw==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=hD80L64hAAAA:8 a=DDOyTI_5AAAA:8
    a=zodaybIXVULBRSIJ4SQA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20180330024417epoutp02aa64c27e3176a86a89f6d2636c1fcd7c~gkphbae2n1640416404epoutp02O
X-AuditID: b6c32a48-8d9ff70000000ff2-3c-5abda48026d6
From: Ji-Hun Kim <ji_hun.kim@samsung.com>
To: gregkh@linuxfoundation.org, baijiaju1990@gmail.com,
 forest@alittletooquiet.net
Subject: [PATCH v3] staging: vt6655: check for memory allocation failures
Date: Fri, 30 Mar 2018 11:44:04 +0900
Message-id: <1522377844-23591-1-git-send-email-ji_hun.kim@samsung.com>
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOKsWRmVeSWpSXmKPExsWy7bCmmW7Dkr1RBps36Fusm7iQyeLM+7NM
 FnvO/GK3uD/hEatF8+L1bBb9p7czWix7cJrRYustaYvLu+awWZzcJm+xpesHqwO3R3Pje1aP
 e/sOs3jsnHWX3WP/3DXsHnu3ZHn0bVnF6PF5k1wAe1SqTUZqYkpqkUJqXnJ+SmZeuq2Sd3C8
 c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QhUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OIS
 W6VoQ0MjPUMDcz0jIyM9E/NYKyNToJKE1Iy+P1cYC6Y4VfT/mcbawPjBtIuRk0NCwETi4PU5
 LF2MXBxCAjsYJSZNPMUG4XxnlPhw6yAbTNWlFeeZIBK7GSW23XnACOH8YJT4N/seE0gVm4Cm
 xMbua4wgtohAiMSKHdvA5jILXGKUWLx2JTNIQljAU+Lay5lgDSwCqhIfTt1iB7F5Bdwk5n58
 xwKxTk7i5LHJrBD2HDaJrVNkIWwXiX9TzzJC2MISr45vYYewpSWerdoIFa+WWHBlB9ScGomb
 /5cyQdjGEr09F8BuYBbgk+g4/BeolwMozivR0SYEUeIhcfvaJ6iRjhKzPj0FKxcSiJXo3PGP
 ZQKj5AJGhlWMYqkFxbnpqcVGBSZ6xYm5xaV56XrJ+bmbGMGJRstjB+OBcz6HGAU4GJV4eBVY
 9kYJsSaWFVfmHmKU4GBWEuEtnwoU4k1JrKxKLcqPLyrNSS0+xGgKDI2JzFKiyfnAJJhXEm9o
 YmlgYmZmaG5kamCuJM7bFuASJSSQnliSmp2aWpBaBNPHxMEp1cC4X9KZoTCP3X7tGUcfJr9l
 +yom/S0SL2VcKXx0zXX7C1VHlsUf32vH8XP1/rkLDjTV9/0Iqv/67MiHtIWxe4Xim4O+dt30
 5xZwqzF4VHMv7zL3kivVz5JSFkqGBAlrTvLys5E4vLPgBZdSS3RWwLPXKvNP1PTV3rqZm/Nu
 4vt991fey8opub1IiaU4I9FQi7moOBEA+yjzjEoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprALMWRmVeSWpSXmKPExsVy+t9jAd2GJXujDJp6pC3WTVzIZHHm/Vkm
 iz1nfrFb3J/wiNWiefF6Nov+09sZLZY9OM1osfWWtMXlXXPYLE5uk7fY0vWD1YHbo7nxPavH
 vX2HWTx2zrrL7rF/7hp2j71bsjz6tqxi9Pi8SS6APYrLJiU1J7MstUjfLoEro+/PFcaCKU4V
 /X+msTYwfjDtYuTkkBAwkbi04jxTFyMXh5DATkaJOd+vsUM4Pxgl9r3byAZSxSagKbGx+xoj
 iC0iECLxv/kqI0gRs8AlRontj+eCJYQFPCWuvZzJBGKzCKhKfDh1ix3E5hVwk5j78R0LxDo5
 iZPHJrNOYORawMiwilEytaA4Nz232KjAKC+1XK84Mbe4NC9dLzk/dxMjMJy2Hdbq38H4eEn8
 IUYBDkYlHt4Ktr1RQqyJZcWVuYcYJTiYlUR4y6cChXhTEiurUovy44tKc1KLDzFKc7AoifPy
 5x+LFBJITyxJzU5NLUgtgskycXBKNTDOfPj5X3YLm3Xeye5frp/VhVJTEt4t2f1u6/2J19yL
 dHdVqKw6scp5gc15ha8O0wLNfrZvje/XfKL5OKrptb2cya6udy9vz7xb9+uIdVpayY0bE5XN
 LRvlopp1Z7TYWbusDS0JkIpUba3V01Rw7Al4UM078/AentzH7/8927Vwrd7FG8tebnqrxFKc
 kWioxVxUnAgAKiBi3CMCAAA=
X-CMS-MailID: 20180330024416epcas2p2f566f43a8f5af8b4ebc17659e3cf0ecf
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180330024416epcas2p2f566f43a8f5af8b4ebc17659e3cf0ecf
X-RootMTR: 20180330024416epcas2p2f566f43a8f5af8b4ebc17659e3cf0ecf
References: <CGME20180330024416epcas2p2f566f43a8f5af8b4ebc17659e3cf0ecf@epcas2p2.samsung.com>
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
Cc: devel@driverdev.osuosl.org, y.k.oh@samsung.com,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 julia.lawall@lip6.fr, ji_hun.kim@samsung.com, santhameena13@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There are no null pointer checking on rd_info and td_info values which
are allocated by kzalloc. It has potential null pointer dereferencing
issues. Implement error handling code on device_init_rd*, device_init_td*
and vnt_start for the allocation failures.

Signed-off-by: Ji-Hun Kim <ji_hun.kim@samsung.com>
---
Changes v2:

- Delete WARN_ON which can makes crashes on some machines.
- Instead of return directly, goto freeing function for freeing previously
  allocated memory in the for loop after kzalloc() failed.
- In the freeing function, add if statement for freeing to only allocated
  values.

Changes v3:

- Modify return type of device_init_rd*, device_init_td*. Then add returns
  error code at those functions and vnt_start as well.

 drivers/staging/vt6655/device_main.c | 114 +++++++++++++++++++++++++----------
 1 file changed, 82 insertions(+), 32 deletions(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index fbc4bc6..0d55f34 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -124,10 +124,10 @@
 static void device_free_info(struct vnt_private *priv);
 static void device_print_info(struct vnt_private *priv);
 
-static void device_init_rd0_ring(struct vnt_private *priv);
-static void device_init_rd1_ring(struct vnt_private *priv);
-static void device_init_td0_ring(struct vnt_private *priv);
-static void device_init_td1_ring(struct vnt_private *priv);
+static int device_init_rd0_ring(struct vnt_private *priv);
+static int device_init_rd1_ring(struct vnt_private *priv);
+static int device_init_td0_ring(struct vnt_private *priv);
+static int device_init_td1_ring(struct vnt_private *priv);
 
 static int  device_rx_srv(struct vnt_private *priv, unsigned int idx);
 static int  device_tx_srv(struct vnt_private *priv, unsigned int idx);
@@ -528,18 +528,22 @@ static void device_free_rings(struct vnt_private *priv)
 				  priv->tx0_bufs, priv->tx_bufs_dma0);
 }
 
-static void device_init_rd0_ring(struct vnt_private *priv)
+static int device_init_rd0_ring(struct vnt_private *priv)
 {
 	int i;
 	dma_addr_t      curr = priv->rd0_pool_dma;
 	struct vnt_rx_desc *desc;
+	int ret = 0;
 
 	/* Init the RD0 ring entries */
 	for (i = 0; i < priv->opts.rx_descs0;
 	     i ++, curr += sizeof(struct vnt_rx_desc)) {
 		desc = &priv->aRD0Ring[i];
 		desc->rd_info = kzalloc(sizeof(*desc->rd_info), GFP_KERNEL);
-
+		if (!desc->rd_info) {
+			ret = -ENOMEM;
+			goto error;
+		}
 		if (!device_alloc_rx_buf(priv, desc))
 			dev_err(&priv->pcid->dev, "can not alloc rx bufs\n");
 
@@ -550,20 +554,29 @@ static void device_init_rd0_ring(struct vnt_private *priv)
 	if (i > 0)
 		priv->aRD0Ring[i-1].next_desc = cpu_to_le32(priv->rd0_pool_dma);
 	priv->pCurrRD[0] = &priv->aRD0Ring[0];
+
+	return 0;
+error:
+	device_free_rd0_ring(priv);
+	return ret;
 }
 
-static void device_init_rd1_ring(struct vnt_private *priv)
+static int device_init_rd1_ring(struct vnt_private *priv)
 {
 	int i;
 	dma_addr_t      curr = priv->rd1_pool_dma;
 	struct vnt_rx_desc *desc;
+	int ret = 0;
 
 	/* Init the RD1 ring entries */
 	for (i = 0; i < priv->opts.rx_descs1;
 	     i ++, curr += sizeof(struct vnt_rx_desc)) {
 		desc = &priv->aRD1Ring[i];
 		desc->rd_info = kzalloc(sizeof(*desc->rd_info), GFP_KERNEL);
-
+		if (!desc->rd_info) {
+			ret = -ENOMEM;
+			goto error;
+		}
 		if (!device_alloc_rx_buf(priv, desc))
 			dev_err(&priv->pcid->dev, "can not alloc rx bufs\n");
 
@@ -574,6 +587,11 @@ static void device_init_rd1_ring(struct vnt_private *priv)
 	if (i > 0)
 		priv->aRD1Ring[i-1].next_desc = cpu_to_le32(priv->rd1_pool_dma);
 	priv->pCurrRD[1] = &priv->aRD1Ring[0];
+
+	return 0;
+error:
+	device_free_rd1_ring(priv);
+	return ret;
 }
 
 static void device_free_rd0_ring(struct vnt_private *priv)
@@ -584,12 +602,12 @@ static void device_free_rd0_ring(struct vnt_private *priv)
 		struct vnt_rx_desc *desc = &priv->aRD0Ring[i];
 		struct vnt_rd_info *rd_info = desc->rd_info;
 
-		dma_unmap_single(&priv->pcid->dev, rd_info->skb_dma,
-				 priv->rx_buf_sz, DMA_FROM_DEVICE);
-
-		dev_kfree_skb(rd_info->skb);
-
-		kfree(desc->rd_info);
+		if (rd_info) {
+			dma_unmap_single(&priv->pcid->dev, rd_info->skb_dma,
+					priv->rx_buf_sz, DMA_FROM_DEVICE);
+			dev_kfree_skb(rd_info->skb);
+			kfree(desc->rd_info);
+		}
 	}
 }
 
@@ -601,27 +619,31 @@ static void device_free_rd1_ring(struct vnt_private *priv)
 		struct vnt_rx_desc *desc = &priv->aRD1Ring[i];
 		struct vnt_rd_info *rd_info = desc->rd_info;
 
-		dma_unmap_single(&priv->pcid->dev, rd_info->skb_dma,
-				 priv->rx_buf_sz, DMA_FROM_DEVICE);
-
-		dev_kfree_skb(rd_info->skb);
-
-		kfree(desc->rd_info);
+		if (rd_info) {
+			dma_unmap_single(&priv->pcid->dev, rd_info->skb_dma,
+					priv->rx_buf_sz, DMA_FROM_DEVICE);
+			dev_kfree_skb(rd_info->skb);
+			kfree(desc->rd_info);
+		}
 	}
 }
 
-static void device_init_td0_ring(struct vnt_private *priv)
+static int device_init_td0_ring(struct vnt_private *priv)
 {
 	int i;
 	dma_addr_t  curr;
 	struct vnt_tx_desc *desc;
+	int ret = 0;
 
 	curr = priv->td0_pool_dma;
 	for (i = 0; i < priv->opts.tx_descs[0];
 	     i++, curr += sizeof(struct vnt_tx_desc)) {
 		desc = &priv->apTD0Rings[i];
 		desc->td_info = kzalloc(sizeof(*desc->td_info), GFP_KERNEL);
-
+		if (!desc->td_info) {
+			ret = -ENOMEM;
+			goto error;
+		}
 		desc->td_info->buf = priv->tx0_bufs + i * PKT_BUF_SZ;
 		desc->td_info->buf_dma = priv->tx_bufs_dma0 + i * PKT_BUF_SZ;
 
@@ -632,13 +654,19 @@ static void device_init_td0_ring(struct vnt_private *priv)
 	if (i > 0)
 		priv->apTD0Rings[i-1].next_desc = cpu_to_le32(priv->td0_pool_dma);
 	priv->apTailTD[0] = priv->apCurrTD[0] = &priv->apTD0Rings[0];
+
+	return 0;
+error:
+	device_free_td0_ring(priv);
+	return ret;
 }
 
-static void device_init_td1_ring(struct vnt_private *priv)
+static int device_init_td1_ring(struct vnt_private *priv)
 {
 	int i;
 	dma_addr_t  curr;
 	struct vnt_tx_desc *desc;
+	int ret = 0;
 
 	/* Init the TD ring entries */
 	curr = priv->td1_pool_dma;
@@ -646,7 +674,10 @@ static void device_init_td1_ring(struct vnt_private *priv)
 	     i++, curr += sizeof(struct vnt_tx_desc)) {
 		desc = &priv->apTD1Rings[i];
 		desc->td_info = kzalloc(sizeof(*desc->td_info), GFP_KERNEL);
-
+		if (!desc->td_info) {
+			ret = -ENOMEM;
+			goto error;
+		}
 		desc->td_info->buf = priv->tx1_bufs + i * PKT_BUF_SZ;
 		desc->td_info->buf_dma = priv->tx_bufs_dma1 + i * PKT_BUF_SZ;
 
@@ -657,6 +688,11 @@ static void device_init_td1_ring(struct vnt_private *priv)
 	if (i > 0)
 		priv->apTD1Rings[i-1].next_desc = cpu_to_le32(priv->td1_pool_dma);
 	priv->apTailTD[1] = priv->apCurrTD[1] = &priv->apTD1Rings[0];
+
+	return 0;
+error:
+	device_free_td1_ring(priv);
+	return ret;
 }
 
 static void device_free_td0_ring(struct vnt_private *priv)
@@ -667,8 +703,10 @@ static void device_free_td0_ring(struct vnt_private *priv)
 		struct vnt_tx_desc *desc = &priv->apTD0Rings[i];
 		struct vnt_td_info *td_info = desc->td_info;
 
-		dev_kfree_skb(td_info->skb);
-		kfree(desc->td_info);
+		if (td_info) {
+			dev_kfree_skb(td_info->skb);
+			kfree(desc->td_info);
+		}
 	}
 }
 
@@ -680,8 +718,10 @@ static void device_free_td1_ring(struct vnt_private *priv)
 		struct vnt_tx_desc *desc = &priv->apTD1Rings[i];
 		struct vnt_td_info *td_info = desc->td_info;
 
-		dev_kfree_skb(td_info->skb);
-		kfree(desc->td_info);
+		if (td_info) {
+			dev_kfree_skb(td_info->skb);
+			kfree(desc->td_info);
+		}
 	}
 }
 
@@ -1165,10 +1205,18 @@ static int vnt_start(struct ieee80211_hw *hw)
 	}
 
 	dev_dbg(&priv->pcid->dev, "call device init rd0 ring\n");
-	device_init_rd0_ring(priv);
-	device_init_rd1_ring(priv);
-	device_init_td0_ring(priv);
-	device_init_td1_ring(priv);
+	ret = device_init_rd0_ring(priv);
+	if (ret)
+		goto error;
+	ret = device_init_rd1_ring(priv);
+	if (ret)
+		goto error;
+	ret = device_init_td0_ring(priv);
+	if (ret)
+		goto error;
+	ret = device_init_td1_ring(priv);
+	if (ret)
+		goto error;
 
 	device_init_registers(priv);
 
@@ -1178,6 +1226,8 @@ static int vnt_start(struct ieee80211_hw *hw)
 	ieee80211_wake_queues(hw);
 
 	return 0;
+error:
+	return ret;
 }
 
 static void vnt_stop(struct ieee80211_hw *hw)
-- 
1.9.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
