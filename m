Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-179577-1522308182-2-8282897272584985408
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522308181; b=KTIqUGOQNbgkcxf7fWK70sP7HAQBbTop79rPk6GRdqVrQ2/
    /nEeuOEjgQzmGg0zHQ8zh4sFANhtsR1mRy1uEbj0tBLmNEwVvEpiDzwF72MRLc1r
    EVNc7ue0Pjb7jsXC++dY11h9tSil1vcyhJLEVNJF5gFA7samd3H9tMhr4GnEtvc8
    r6EeJxzLNz5gDAdRPSf1PloxGK9IMlkiNI049ntJtbnl0ljyGOYtAkxBBg7ia7DP
    NUyAxkVC2TJ7wapxvXLDpf5jmuuojyCfG1OenOQJs8nqv8kBAnavu5CW3Hczdvs6
    QM2c4DMlIeMCPkDArv6NiQ06sc5G75xX0OSA7MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1522308181; bh=F
    awq+vyIyY5b3RvTVix8ioMhQoBVmcaGNtbx70YMqpo=; b=GKidg7v+dNKOX8o5Z
    pdkvvY4GiloUD/OAA++IL1Twc69tH4a7NHPQeyWvtYxjgWeLflxIgNP7MB8Zgdlb
    57wh+pi3XHEZnN+PF/UxYXXSooZlFUlxXCVbIMwlQFGGCqJg4XrHz4+H+S/XKHWZ
    BTy1QVTY+m1b+jaWG2oMs9w9GWdOTFeU49w9DWBGoV4pV3knlpnMoAtBnacv3yAv
    YjGV22YTySA6mIXaTjLR3tIOah9izKOZQuWN5pIxk7YDUH0/MV6yTAVECWioZ/t6
    YPL+9rAzOg+08xBldR7kEKe38/J9ddr+zEcr3GLR4A6FTkWDa7u2MvBwXRMv14r/
    WI52A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=MXk2od8n x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=MXk2od8n x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB/2yIh+Tq0RG7pKszzTwVLkMClNS7xJSsr0QRiGFuYb/F7kCiC5V5WwEMLKGlrvKy2noK5nPzee1d337h+e6J2feUejmSvGhP9/giLFGbRyuAveAPzG
    2lYRv8FU6CiajfadL4jgERrV3J/tJFUNiRAk1u0XP+oW/SFqKmbKskC53Xsh/X62SHyt+v8YP0XTUf925OtavFOHE0TBm2G0/msoVdL1Arbqr/byZ3LYAeRU
    MYf+/Ox2FkxuVo23geCGRQ==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=hD80L64hAAAA:8 a=DDOyTI_5AAAA:8
    a=IJ1WN0xP2lsIICnF1zEA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20180329072249epoutp036adf6b457a791b61a876600d8a33dbef~gUzb8i3RM2228122281epoutp03V
X-AuditID: b6c32a46-b6dff70000000fe8-fe-5abc94492f95
From: Ji-Hun Kim <ji_hun.kim@samsung.com>
To: gregkh@linuxfoundation.org, baijiaju1990@gmail.com,
 forest@alittletooquiet.net
Subject: [PATCH v2] staging: vt6655: check for memory allocation failures
Date: Thu, 29 Mar 2018 16:22:37 +0900
Message-id: <1522308157-26463-1-git-send-email-ji_hun.kim@samsung.com>
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsWy7bCmua7nlD1RBh9mcVism7iQyeLM+7NM
 FnvO/GK3uD/hEatF8+L1bBb9p7czWix7cJrRYustaYvLu+awWZzcJm+xpesHqwO3R3Pje1aP
 e/sOs3jsnHWX3WP/3DXsHnu3ZHn0bVnF6PF5k1wAe1SqTUZqYkpqkUJqXnJ+SmZeuq2Sd3C8
 c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QhUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OIS
 W6VoQ0MjPUMDcz0jIyM9E/NYKyNToJKE1IxJG5eyF7zVrthyyqmBsUWli5GDQ0LAROLzPvUu
 Ri4OIYEdjBLrzzxhgXC+M0o83PGZtYuRE6xozb0edojEBkaJySvnMEE4PxglHm88wgJSxSag
 KbGx+xojiC0iECKxYsc2sFHMApcYJRavXckMkhAW8JRon7OODcRmEVCVWPz+DDuIzSvgJtE+
 7SQLxDo5iZPHJrOCNEsITGGTeHzyASNEwkXi+4+37BC2sMSr41ugbGmJZ6s2QtVUSyy4sgNq
 UI3Ezf9LmSBsY4nengtgRzAL8El0HP7LDgkAXomONiGIEg+JY18nQb3sKPFkwiawO4UEYiWa
 zixknsAouYCRYRWjWGpBcW56arFRgZFecWJucWleul5yfu4mRnCa0XLbwbjknM8hRgEORiUe
 XotFu6OEWBPLiitzDzFKcDArifC+1wAK8aYkVlalFuXHF5XmpBYfYjQFBsdEZinR5HxgCswr
 iTc0sTQwMTMzNDcyNTBXEudtDXCJEhJITyxJzU5NLUgtgulj4uCUamCU3LeGa5XP4rLcXbP9
 Zr69uXVK1uavYT3zd5dN+FfU+nfnT4WdazyVMj7teRMoPddo7oLA0uP37defX6Tpt89+/gfO
 0PsOS5mZF5wO7XtsfrdYPWP5zuIYr98dhvMOXxHufNTV9ev2eUfFh+y76nZZBwTOVLrNuv68
 gu76i/wv7rt/4TYXeJZXrMRSnJFoqMVcVJwIAGIuL2VJAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnluLIzCtJLcpLzFFi42I5/e+xoK7HlD1RBrOWaFqsm7iQyeLM+7NM
 FnvO/GK3uD/hEatF8+L1bBb9p7czWix7cJrRYustaYvLu+awWZzcJm+xpesHqwO3R3Pje1aP
 e/sOs3jsnHWX3WP/3DXsHnu3ZHn0bVnF6PF5k1wAexSXTUpqTmZZapG+XQJXxqSNS9kL3mpX
 bDnl1MDYotLFyMkhIWAiseZeD3sXIxeHkMA6Ront718yQzg/GCVO3VjMDlLFJqApsbH7GiOI
 LSIQIvG/+SojSBGzwCWgjsdzwRLCAp4S7XPWsYHYLAKqEovfnwFr5hVwk2ifdpIFYp2cxMlj
 k1knMHItYGRYxSiZWlCcm55bbFRglJdarlecmFtcmpeul5yfu4kRGEzbDmv172B8vCT+EKMA
 B6MSD6/Fot1RQqyJZcWVuYcYJTiYlUR432sAhXhTEiurUovy44tKc1KLDzFKc7AoifPy5x+L
 FBJITyxJzU5NLUgtgskycXBKNTDGx7wRcjF+qpVzKCKzwmNG51HHE/9O8i1+vCLqoHuWWahe
 Vt3cIA1Vq5dCi7U75CeYS8eUJfseZVNmSzg2+4a7rSAjZ4LLwbml/D6mvufzsq1/LF+sxPL4
 Jp9Aw8dtFS2NAuxnk9WnXOIuS97p8PhiTEfI73g3mUlKoQ9usWQtuNC+9YPqbyWW4oxEQy3m
 ouJEAKaIoY8iAgAA
X-CMS-MailID: 20180329072248epcas2p3d12617d41e964252998dd1d34f740a97
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180329072248epcas2p3d12617d41e964252998dd1d34f740a97
X-RootMTR: 20180329072248epcas2p3d12617d41e964252998dd1d34f740a97
References: <CGME20180329072248epcas2p3d12617d41e964252998dd1d34f740a97@epcas2p3.samsung.com>
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
issues. Add return when allocation is failed.

Signed-off-by: Ji-Hun Kim <ji_hun.kim@samsung.com>
---

Change: since v1:

- Delete WARN_ON which can makes crashes on some machines.
- Instead of return directly, goto freeing function for freeing previously
  allocated memory in the for loop after kzalloc() failed.
- In the freeing function, if td_info and rd_info are not allocated, no
  needs to free.

 drivers/staging/vt6655/device_main.c | 64 +++++++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index fbc4bc6..ecbba43 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -539,7 +539,8 @@ static void device_init_rd0_ring(struct vnt_private *priv)
 	     i ++, curr += sizeof(struct vnt_rx_desc)) {
 		desc = &priv->aRD0Ring[i];
 		desc->rd_info = kzalloc(sizeof(*desc->rd_info), GFP_KERNEL);
-
+		if (!desc->rd_info)
+			goto error;
 		if (!device_alloc_rx_buf(priv, desc))
 			dev_err(&priv->pcid->dev, "can not alloc rx bufs\n");
 
@@ -550,6 +551,10 @@ static void device_init_rd0_ring(struct vnt_private *priv)
 	if (i > 0)
 		priv->aRD0Ring[i-1].next_desc = cpu_to_le32(priv->rd0_pool_dma);
 	priv->pCurrRD[0] = &priv->aRD0Ring[0];
+
+	return;
+error:
+	device_free_rd0_ring(priv);
 }
 
 static void device_init_rd1_ring(struct vnt_private *priv)
@@ -563,7 +568,8 @@ static void device_init_rd1_ring(struct vnt_private *priv)
 	     i ++, curr += sizeof(struct vnt_rx_desc)) {
 		desc = &priv->aRD1Ring[i];
 		desc->rd_info = kzalloc(sizeof(*desc->rd_info), GFP_KERNEL);
-
+		if (!desc->rd_info)
+			goto error;
 		if (!device_alloc_rx_buf(priv, desc))
 			dev_err(&priv->pcid->dev, "can not alloc rx bufs\n");
 
@@ -574,6 +580,10 @@ static void device_init_rd1_ring(struct vnt_private *priv)
 	if (i > 0)
 		priv->aRD1Ring[i-1].next_desc = cpu_to_le32(priv->rd1_pool_dma);
 	priv->pCurrRD[1] = &priv->aRD1Ring[0];
+
+	return;
+error:
+	device_free_rd1_ring(priv);
 }
 
 static void device_free_rd0_ring(struct vnt_private *priv)
@@ -584,12 +594,12 @@ static void device_free_rd0_ring(struct vnt_private *priv)
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
 
@@ -601,12 +611,12 @@ static void device_free_rd1_ring(struct vnt_private *priv)
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
 
@@ -621,7 +631,8 @@ static void device_init_td0_ring(struct vnt_private *priv)
 	     i++, curr += sizeof(struct vnt_tx_desc)) {
 		desc = &priv->apTD0Rings[i];
 		desc->td_info = kzalloc(sizeof(*desc->td_info), GFP_KERNEL);
-
+		if (!desc->td_info)
+			goto error;
 		desc->td_info->buf = priv->tx0_bufs + i * PKT_BUF_SZ;
 		desc->td_info->buf_dma = priv->tx_bufs_dma0 + i * PKT_BUF_SZ;
 
@@ -632,6 +643,10 @@ static void device_init_td0_ring(struct vnt_private *priv)
 	if (i > 0)
 		priv->apTD0Rings[i-1].next_desc = cpu_to_le32(priv->td0_pool_dma);
 	priv->apTailTD[0] = priv->apCurrTD[0] = &priv->apTD0Rings[0];
+
+	return;
+error:
+	device_free_td0_ring(priv);
 }
 
 static void device_init_td1_ring(struct vnt_private *priv)
@@ -646,7 +661,8 @@ static void device_init_td1_ring(struct vnt_private *priv)
 	     i++, curr += sizeof(struct vnt_tx_desc)) {
 		desc = &priv->apTD1Rings[i];
 		desc->td_info = kzalloc(sizeof(*desc->td_info), GFP_KERNEL);
-
+		if (!desc->td_info)
+			goto error;
 		desc->td_info->buf = priv->tx1_bufs + i * PKT_BUF_SZ;
 		desc->td_info->buf_dma = priv->tx_bufs_dma1 + i * PKT_BUF_SZ;
 
@@ -657,6 +673,10 @@ static void device_init_td1_ring(struct vnt_private *priv)
 	if (i > 0)
 		priv->apTD1Rings[i-1].next_desc = cpu_to_le32(priv->td1_pool_dma);
 	priv->apTailTD[1] = priv->apCurrTD[1] = &priv->apTD1Rings[0];
+
+	return;
+error:
+	device_free_td1_ring(priv);
 }
 
 static void device_free_td0_ring(struct vnt_private *priv)
@@ -667,8 +687,10 @@ static void device_free_td0_ring(struct vnt_private *priv)
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
 
@@ -680,8 +702,10 @@ static void device_free_td1_ring(struct vnt_private *priv)
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
 
-- 
1.9.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
