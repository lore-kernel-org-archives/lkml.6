Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2671055-1522389142-5-15183399948958719298
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522389141; b=THdcm7J9H8Sf8TX3oTrO0pLLkpB39jBWVxOD+HngDlhpGzn3+k
    1wexH//t3N88UBdfPlABoztNvRvr6YUZA7Hv3+LO8uZRnkwbBzAbq3pBPm5bVW67
    fSuyZdrouoeV2uFTweMtgwsf9Wtavc7X/oH8Ip0bBPQLAFJDqTohLSVD66lVAThK
    wv511YxEyIucyP5LBGXuUdqFVjKWvkcbLKwv29wPtqkC7ulADHthW1eut3XNMyCN
    N6rGLxtbmDyDqkIIdOwM+Y+0VegJ8Xqc/JipjjAaa1dGx7IEZ1Y6R1leHg7Yu4dg
    l23EuLB3RwJjnJAxBNSOHI/IKHZOlCTtPuHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522389141; bh=kwfEZ
    9P9NGIyXFKPsDSHRHtGbXgF5xoBJO49GNXEy+I=; b=fjE/eghZs7bzlfqHSdnth
    WBXfEBUUDDFzHYKsqiYHHQsaSI8v4ojCWRf8pyKDq5/rJPvs9XA8KhknZCLBIpPW
    zfX63e2mzj+fIdM4eJxOolEwmam+M0hspzeFp09TpOagJvXv7xBaMWkexXrgwuDr
    f4aHurai0Sq8fU8CW2gC7xYItfNt7hI769sSZ8x5RkdCGPrjldStGj/XkOlPDNam
    N6POlTFYlJ2j30uDM253VAKBtamWZ/exaRbMEHqqJZ1Lfwmd7bKCjmnV5fkaxl/d
    NLRsrwWjJg+SuBTXGyc8ifFN4Kxtb3RUg3tBQHCXP44ykV2pybGz3LQk/pItXWRy
    g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=vIcrmMGo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=vIcrmMGo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
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
X-CM-Envelope: MS4wfEtX/fLcgFkM8Kz2Dk686sdGmC+DrnFrwd8z1hmQsRvK1T5elCEcMQyd33/t4DeA4JqD+CmkQGD6ZqfgEgmuJyjOwvOaTmLAGP7GdY2nUQNz45n3ubIS
    U/nLHGklYd7tzbVAmaZXyucbMUHONnL4o5ixdkgzGla8rmM/VnscZunELP4F4xVVZQPvC6CFQ7CkzL533LrXMXJa+DwvwSeIAb4lJJh5z9qr6g7a8JgJ2enH
    42HzEiPbL3/FNsXhGEUh/Q==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=hD80L64hAAAA:8 a=DDOyTI_5AAAA:8
    a=zodaybIXVULBRSIJ4SQA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20180330055210epoutp040c3db843a36f6bc38ec16ecdf1bec9a6~gnNk2OH0S1769517695epoutp04a
X-AuditID: b6c32a36-f6fff70000000fc2-02-5abdd088dd44
From: Ji-Hun Kim <ji_hun.kim@samsung.com>
To: gregkh@linuxfoundation.org, baijiaju1990@gmail.com,
 forest@alittletooquiet.net
Subject: [PATCH v4 1/2] staging: vt6655: check for memory allocation failures
Date: Fri, 30 Mar 2018 14:51:54 +0900
Message-id: <1522389115-1124-1-git-send-email-ji_hun.kim@samsung.com>
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsWy7bCmrm7Hhb1RBkuv8Fmsm7iQyeLM+7NM
 FnvO/GK3uD/hEatF8+L1bBb9p7czWix7cJrRYustaYvLu+awWZzcJm+xpesHqwO3R3Pje1aP
 e/sOs3jsnHWX3WP/3DXsHnu3ZHn0bVnF6PF5k1wAe1SqTUZqYkpqkUJqXnJ+SmZeuq2Sd3C8
 c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QhUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OIS
 W6VoQ0MjPUMDcz0jIyM9E/NYKyNToJKE1Iz7P1pYCu65VBw4+Yu1gXGqRRcjJ4eEgInE90+3
 GLsYuTiEBHYwSnyae50JwvnOKNEx8wg7TNXi2z1QVRsYJZ7NaWOHcH4wSvxbfpcRpIpNQFNi
 Y/c1MFtEIERixY5tLCBFzAKXGCUWr13JDJIQFvCX6OyaygpiswioSny7MZUFxOYVcJU4/mgt
 G8Q6OYmTxyazgjRLCMxhk+i90wOVcJH4u/wRC4QtLPHq+BagMziAbGmJS0dtIcLVEguu7IAq
 qZG4+X8pE4RtLNHbcwHsBmYBPol3X3tYIVp5JTrahCBKPCT2vnvJCmE7SkybNA2sREggVuLW
 W8cJjJILGBlWMYqlFhTnpqcWGxYY6RUn5haX5qXrJefnbmIEpxktsx2Mi875HGIU4GBU4uFV
 YNkbJcSaWFZcmXuIUYKDWUmE1+okUIg3JbGyKrUoP76oNCe1+BCjKTAwJjJLiSbnA1NgXkm8
 oYmlgYmZkampoYGFiZI4b0CAS5SQQHpiSWp2ampBahFMHxMHp1QDY9CCeBt3x1WJzE76CtGr
 Nk+++d3s9UazLeG2axUW5netdWQ3a1RO8Zizaa1kZIDNH9me/S83z7r7cLr46vW9+3pZamRv
 VUrPaT18dQLXF/4wsZcPK9Xal3zvz3PaurdH53/pO9sJ1zaXiiWUMPApx3l869Hq35h85rH9
 TYGJEc7v3be7ymUIKrEUZyQaajEXFScCAPFjuZ9JAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnluLIzCtJLcpLzFFi42I5/e+xoG77hb1RBpOWmFmsm7iQyeLM+7NM
 FnvO/GK3uD/hEatF8+L1bBb9p7czWix7cJrRYustaYvLu+awWZzcJm+xpesHqwO3R3Pje1aP
 e/sOs3jsnHWX3WP/3DXsHnu3ZHn0bVnF6PF5k1wAexSXTUpqTmZZapG+XQJXxv0fLSwF91wq
 Dpz8xdrAONWii5GTQ0LARGLx7R7GLkYuDiGBdYwSZ/YuZwVJCAn8YJS4Mk0HxGYT0JTY2H2N
 EcQWEQiR+N98FayBWeASo8T2x3PBEsICvhIHnk9nBrFZBFQlvt2YygJi8wq4Shx/tJYNYpuc
 xMljk1knMHItYGRYxSiZWlCcm55bbFRgmJdarlecmFtcmpeul5yfu4kRGEzbDmv17WC8vyT+
 EKMAB6MSD28F294oIdbEsuLK3EOMEhzMSiK8VieBQrwpiZVVqUX58UWlOanFhxilOViUxHlv
 5x2LFBJITyxJzU5NLUgtgskycXBKNTBO8FjvnPp+mvwRo3cGHjJrPPLW9uZzJHt8isw8HB4X
 7B8667eaQMaD9Ym+x82fLX4eYJg8p2Tp673Xpu0q5ClJ3VjLeelqyoqpsxQDZm9m/7RbTiJ0
 55JV3utWeoZ6SPgamDxcEvB4zt6/LVL7HE8l/5o3TzxpwnN7p20s5Sfkbhuvya/5puGjxFKc
 kWioxVxUnAgASaFrjiICAAA=
X-CMS-MailID: 20180330055207epcas1p14d562f44802bac86a8a7cd95fe2d009f
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180330055207epcas1p14d562f44802bac86a8a7cd95fe2d009f
X-RootMTR: 20180330055207epcas1p14d562f44802bac86a8a7cd95fe2d009f
References: <CGME20180330055207epcas1p14d562f44802bac86a8a7cd95fe2d009f@epcas1p1.samsung.com>
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

Changes v4:
- Fix potential memory leaks from error handling code of device init
  functions in vnt_start().

 drivers/staging/vt6655/device_main.c | 121 ++++++++++++++++++++++++++---------
 1 file changed, 89 insertions(+), 32 deletions(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index fbc4bc6..c9752df 100644
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
+		goto err_init_rd0_ring;
+	ret = device_init_rd1_ring(priv);
+	if (ret)
+		goto err_init_rd1_ring;
+	ret = device_init_td0_ring(priv);
+	if (ret)
+		goto err_init_td0_ring;
+	ret = device_init_td1_ring(priv);
+	if (ret)
+		goto err_init_td1_ring;
 
 	device_init_registers(priv);
 
@@ -1178,6 +1226,15 @@ static int vnt_start(struct ieee80211_hw *hw)
 	ieee80211_wake_queues(hw);
 
 	return 0;
+
+err_init_td1_ring:
+	device_free_td0_ring(priv);
+err_init_td0_ring:
+	device_free_rd1_ring(priv);
+err_init_rd1_ring:
+	device_free_rd0_ring(priv);
+err_init_rd0_ring:
+	return ret;
 }
 
 static void vnt_stop(struct ieee80211_hw *hw)
-- 
1.9.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
