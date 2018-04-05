Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2169189-1522912234-2-9740153776357305254
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES ro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522912233; b=vExhFqcKbvLpBtLFBfssQ+6H14QEqS2AFj9I/5JV6epIh4BReL
    sMSsUNIJCSJKJSq3qk3iJKzvi5c8uWTnFiSlFnLqWIvHW42JeWI0w8fz1Lel9lWR
    PdCehS54VDInnmpo2btwmCUAG1EWjIf1LgupuTR7ILLTOcJc0ix9StpQn8IUY8He
    JVnsZDgIJQ0FntRUeKwf2gXerg7ppntD/nY1NfimZm5hB7uUZ8Tgmz9IADQFFohT
    Sg1IOBLF91okn+CXwP9LAiPhmmwLesJeGufSX0ac39Xhn1wtfGQxB10YmLoOYEK6
    kiESX2AIzMDVUIkK0r/Bl+wXSZq9uP8h1jSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522912233; bh=vIcIL
    dQXQDqEiWR8zbvHzZ++4YXJotnp+l83SeZVgxw=; b=ik1Cfvj5hY+Y85FgH8oKS
    cMmse/Ytxe4BNSautauHUEj2DJCi0s6K9zewxPcK+VDOA5xPp/JY/6UZIFDnkVql
    bATC4ZQfZgHWZtyySo5NzWg1nGa0s2u+bDRTn2C2X622olC3FPg36BY9F8Z9zZz5
    acrujpcDW69chydVwjioJleXUahIxlYZ29x5vomB0+DzHZiRXNaZkYUhGnU3PIYF
    BnpIsznY1+Zreoy/1nOzyY3A92lcUBC43WiqKBwNWYxEB1DCW3snVc5j53UEsf9a
    Mv1UxAjeXXbGkqvb9Z7eVcxX3enhr+tySEmLSymmwxpPId+QFJ0dBvkfh5u0Ea9N
    A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=gwCF1MX0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=gwCF1MX0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIhHsAR9IXqi3rNPLgxu3+5PPhbXgy3FDhP1Ex7YkN1eCseEmzIAkuqNY88D5tP4BmLeniQCKy8gscKubA4ZlMTW2VNN1y8FWw/J5xXXbPRZTaaBL33B
    JpVtGhIdJ5+nNjLLX86LwZSsSUPCoFBREHYb49YM4lvWJdXxtyZvzfTm9rft86xmcWxfux8DgC6GMCiuGhBmoqVc/MX0gQ1Pd2G0oF6A6WpLSxYd7/fI4DHQ
    XiqJ2e0KQSJ/UQw93/w4uA==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=hD80L64hAAAA:8 a=DDOyTI_5AAAA:8
    a=3jEINo51KWwoRJI9-AwA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20180405071019epoutp015a868fff46f37996f420133dbbb81e71~ieJg_sdOC2004920049epoutp019
X-AuditID: b6c32a46-b6dff70000000fe8-63-5ac5cbda9ab6
From: Ji-Hun Kim <ji_hun.kim@samsung.com>
To: dan.carpenter@oracle.com, gregkh@linuxfoundation.org,
 baijiaju1990@gmail.com, forest@alittletooquiet.net
Subject: [PATCH v5 1/2] staging: vt6655: check for memory allocation failures
Date: Thu, 05 Apr 2018 16:09:19 +0900
Message-id: <1522912160-21009-1-git-send-email-ji_hun.kim@samsung.com>
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAKsWRmVeSWpSXmKPExsWy7bCmue6t00ejDHZNNLVYN3Ehk8Xrf9NZ
 LM68P8tksefML3aL+xMesVo0L17PZtF/ejujxbIHpxkttt6Stri8aw6bxclt8hZbun6wOvB4
 NDe+Z/W4t+8wi8fOWXfZPfbPXcPusXdLlsfHp7dYPPq2rGL0+LxJLoAjKtUmIzUxJbVIITUv
 OT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+hWJYWyxJxSoFBAYnGxkr6d
 TVF+aUmqQkZ+cYmtUrShoZGeoYG5npGRkZ6JeayVkSlQSUJqxp0f/5gKVgdW7P6/i7GB8bhT
 FyMnh4SAicS8568Zuxi5OIQEdjBKXP37jQUkISTwnVFizl0zmKKTZ5ewQRRtYJT4Oek7lPOD
 UeLNprNsIFVsApoSG7uvMYLYIgJ5EvtWHWYCKWIWuMQosXjtSuYuRg4OYQF/iROHeEBqWARU
 JT7d3AzWyyvgJrFrxllmiG1yEiePTWYF6ZUQ2MAmcf7tC3aIhAvQsvtMELawxKvjW6Di0hLP
 Vm1khLCrJRZc2cECYddI3Py/FKreWKK35wLYAmYBPomOw3/ZQe6REOCV6GgTgijxkJh9bxHU
 SEeJPXMbWCEhESvxfsl3lgmMkgsYGVYxiqUWFOempxYbFRjpFSfmFpfmpesl5+duYgSnHi23
 HYxLzvkcYhTgYFTi4W34diRKiDWxrLgy9xCjBAezkggva/PRKCHelMTKqtSi/Pii0pzU4kOM
 psDgmMgsJZqcD0yLeSXxhiaWBiZmZobmRqYG5krivK0BLlFCAumJJanZqakFqUUwfUwcnFIN
 jDl3sxrnx6ZKRc7QtFrbyzPjqUlKPvc2mw3ZQsJ6hUWXZ75nX6tlJta7d/LxNxHak4NPWTxQ
 aczm5Wnt+VJ1oqXSqtIj+7RZSl5/zt4DfxOd3A6XfXatLJ/B94Hp9bSgaeIac3IMwxl4Ey4v
 WuTyqvQ5Yx/bBW3PBInishWb6z/P3/pVOZlNiaU4I9FQi7moOBEAzwnInFMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJLMWRmVeSWpSXmKPExsVy+t9jQd1bp49GGVyZLG6xbuJCJovX/6az
 WJx5f5bJYs+ZX+wW9yc8YrVoXryezaL/9HZGi2UPTjNabL0lbXF51xw2i5Pb5C22dP1gdeDx
 aG58z+pxb99hFo+ds+6ye+yfu4bdY++WLI+PT2+xePRtWcXo8XmTXABHFJdNSmpOZllqkb5d
 AlfGnR//mApWB1bs/r+LsYHxuFMXIyeHhICJxMmzS9i6GLk4hATWMUosezmPGcL5wSgxt2UG
 E0gVm4CmxMbua4wgtohAnsT2ndNYQIqYBS4xSmx/PBcowcEhLOAr8fGUBUgNi4CqxKebm9lA
 bF4BN4ldM84yQ2yTkzh5bDLrBEauBYwMqxglUwuKc9Nzi40KjPJSy/WKE3OLS/PS9ZLzczcx
 AgNs22Gt/h2Mj5fEH2IU4GBU4uHt+HskSog1say4MvcQowQHs5IIL2vz0Sgh3pTEyqrUovz4
 otKc1OJDjNIcLErivPz5xyKFBNITS1KzU1MLUotgskwcnFINjLphRWs+W+9q1J7AnKLsseHx
 VLMP7Q0fk18FtH6O/P7rvlf7tjBlwzlFvXeaz6Qe+NnHyC3guehp2hzBF9ddb+jwzjJK3LTj
 lP1/Pm4nmyVfd71boz+R41XL8bq8qTyf9cL2m/02L2sL4NksrlFVeqfi24SJfmu2lO9Zv3Ff
 1v0Ds8WcnG9bP1RiKc5INNRiLipOBACUF3UPLAIAAA==
X-CMS-MailID: 20180405071018epcas2p193288469c86f6afb2c8f7b0151dd400c
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180405071018epcas2p193288469c86f6afb2c8f7b0151dd400c
X-RootMTR: 20180405071018epcas2p193288469c86f6afb2c8f7b0151dd400c
References: <CGME20180405071018epcas2p193288469c86f6afb2c8f7b0151dd400c@epcas2p1.samsung.com>
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
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Changes v5:
- Add error handling case for device_alloc_rx_buf() failures.
- Add device_free_rx_buf() which is corresponding free function of
  device_allocated_rx_buf(). And change duplicated codes by this function.
- Modify error handling code about freeing allocated value in the loops to
  more proper ways.
- Change goto label names following coding-style conventions.

Changes v4:
- Fix potential memory leaks from error handling code from device init
  functions in vnt_start().

Changes v3:
- Modify return type of device_init_rd*, device_init_td*. Then add returns
  error code at those functions and vnt_start as well.

Changes v2:
- Delete WARN_ON which can makes crashes on some machines.
- Instead of return directly, goto freeing function for freeing previously
  allocated memory in the for loop after kzalloc() failed.
- In the freeing function, add if statement for freeing to only allocated
  values.

 drivers/staging/vt6655/device_main.c | 144 ++++++++++++++++++++++++++++-------
 1 file changed, 118 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index fbc4bc6..700c03c 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -19,6 +19,7 @@
  *   device_print_info - print out resource
  *   device_rx_srv - rx service function
  *   device_alloc_rx_buf - rx buffer pre-allocated function
+ *   device_free_rx_buf - free rx buffer function
  *   device_free_tx_buf - free tx buffer function
  *   device_init_rd0_ring- initial rd dma0 ring
  *   device_init_rd1_ring- initial rd dma1 ring
@@ -124,14 +125,15 @@
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
 static bool device_alloc_rx_buf(struct vnt_private *, struct vnt_rx_desc *);
+static void device_free_rx_buf(struct vnt_private *priv, struct vnt_rx_desc *rd);
 static void device_init_registers(struct vnt_private *priv);
 static void device_free_tx_buf(struct vnt_private *, struct vnt_tx_desc *);
 static void device_free_td0_ring(struct vnt_private *priv);
@@ -528,20 +530,28 @@ static void device_free_rings(struct vnt_private *priv)
 				  priv->tx0_bufs, priv->tx_bufs_dma0);
 }
 
-static void device_init_rd0_ring(struct vnt_private *priv)
+static int device_init_rd0_ring(struct vnt_private *priv)
 {
 	int i;
 	dma_addr_t      curr = priv->rd0_pool_dma;
 	struct vnt_rx_desc *desc;
+	int ret;
 
 	/* Init the RD0 ring entries */
 	for (i = 0; i < priv->opts.rx_descs0;
 	     i ++, curr += sizeof(struct vnt_rx_desc)) {
 		desc = &priv->aRD0Ring[i];
 		desc->rd_info = kzalloc(sizeof(*desc->rd_info), GFP_KERNEL);
+		if (!desc->rd_info) {
+			ret = -ENOMEM;
+			goto err_free_desc;
+		}
 
-		if (!device_alloc_rx_buf(priv, desc))
+		if (!device_alloc_rx_buf(priv, desc)) {
 			dev_err(&priv->pcid->dev, "can not alloc rx bufs\n");
+			ret = -ENOMEM;
+			goto err_free_rd;
+		}
 
 		desc->next = &priv->aRD0Ring[(i + 1) % priv->opts.rx_descs0];
 		desc->next_desc = cpu_to_le32(curr + sizeof(struct vnt_rx_desc));
@@ -550,22 +560,44 @@ static void device_init_rd0_ring(struct vnt_private *priv)
 	if (i > 0)
 		priv->aRD0Ring[i-1].next_desc = cpu_to_le32(priv->rd0_pool_dma);
 	priv->pCurrRD[0] = &priv->aRD0Ring[0];
+
+	return 0;
+
+err_free_rd:
+	kfree(desc->rd_info);
+
+err_free_desc:
+	while (--i) {
+		desc = &priv->aRD0Ring[i];
+		device_free_rx_buf(priv, desc);
+		kfree(desc->rd_info);
+	}
+
+	return ret;
 }
 
-static void device_init_rd1_ring(struct vnt_private *priv)
+static int device_init_rd1_ring(struct vnt_private *priv)
 {
 	int i;
 	dma_addr_t      curr = priv->rd1_pool_dma;
 	struct vnt_rx_desc *desc;
+	int ret;
 
 	/* Init the RD1 ring entries */
 	for (i = 0; i < priv->opts.rx_descs1;
 	     i ++, curr += sizeof(struct vnt_rx_desc)) {
 		desc = &priv->aRD1Ring[i];
 		desc->rd_info = kzalloc(sizeof(*desc->rd_info), GFP_KERNEL);
+		if (!desc->rd_info) {
+			ret = -ENOMEM;
+			goto err_free_desc;
+		}
 
-		if (!device_alloc_rx_buf(priv, desc))
+		if (!device_alloc_rx_buf(priv, desc)) {
 			dev_err(&priv->pcid->dev, "can not alloc rx bufs\n");
+			ret = -ENOMEM;
+			goto err_free_rd;
+		}
 
 		desc->next = &priv->aRD1Ring[(i+1) % priv->opts.rx_descs1];
 		desc->next_desc = cpu_to_le32(curr + sizeof(struct vnt_rx_desc));
@@ -574,6 +606,20 @@ static void device_init_rd1_ring(struct vnt_private *priv)
 	if (i > 0)
 		priv->aRD1Ring[i-1].next_desc = cpu_to_le32(priv->rd1_pool_dma);
 	priv->pCurrRD[1] = &priv->aRD1Ring[0];
+
+	return 0;
+
+err_free_rd:
+	kfree(desc->rd_info);
+
+err_free_desc:
+	while (--i) {
+		desc = &priv->aRD1Ring[i];
+		device_free_rx_buf(priv, desc);
+		kfree(desc->rd_info);
+	}
+
+	return ret;
 }
 
 static void device_free_rd0_ring(struct vnt_private *priv)
@@ -582,13 +628,8 @@ static void device_free_rd0_ring(struct vnt_private *priv)
 
 	for (i = 0; i < priv->opts.rx_descs0; i++) {
 		struct vnt_rx_desc *desc = &priv->aRD0Ring[i];
-		struct vnt_rd_info *rd_info = desc->rd_info;
-
-		dma_unmap_single(&priv->pcid->dev, rd_info->skb_dma,
-				 priv->rx_buf_sz, DMA_FROM_DEVICE);
-
-		dev_kfree_skb(rd_info->skb);
 
+		device_free_rx_buf(priv, desc);
 		kfree(desc->rd_info);
 	}
 }
@@ -599,28 +640,28 @@ static void device_free_rd1_ring(struct vnt_private *priv)
 
 	for (i = 0; i < priv->opts.rx_descs1; i++) {
 		struct vnt_rx_desc *desc = &priv->aRD1Ring[i];
-		struct vnt_rd_info *rd_info = desc->rd_info;
-
-		dma_unmap_single(&priv->pcid->dev, rd_info->skb_dma,
-				 priv->rx_buf_sz, DMA_FROM_DEVICE);
-
-		dev_kfree_skb(rd_info->skb);
 
+		device_free_rx_buf(priv, desc);
 		kfree(desc->rd_info);
 	}
 }
 
-static void device_init_td0_ring(struct vnt_private *priv)
+static int device_init_td0_ring(struct vnt_private *priv)
 {
 	int i;
 	dma_addr_t  curr;
 	struct vnt_tx_desc *desc;
+	int ret;
 
 	curr = priv->td0_pool_dma;
 	for (i = 0; i < priv->opts.tx_descs[0];
 	     i++, curr += sizeof(struct vnt_tx_desc)) {
 		desc = &priv->apTD0Rings[i];
 		desc->td_info = kzalloc(sizeof(*desc->td_info), GFP_KERNEL);
+		if (!desc->td_info) {
+			ret = -ENOMEM;
+			goto err_free_desc;
+		}
 
 		desc->td_info->buf = priv->tx0_bufs + i * PKT_BUF_SZ;
 		desc->td_info->buf_dma = priv->tx_bufs_dma0 + i * PKT_BUF_SZ;
@@ -632,13 +673,24 @@ static void device_init_td0_ring(struct vnt_private *priv)
 	if (i > 0)
 		priv->apTD0Rings[i-1].next_desc = cpu_to_le32(priv->td0_pool_dma);
 	priv->apTailTD[0] = priv->apCurrTD[0] = &priv->apTD0Rings[0];
+
+	return 0;
+
+err_free_desc:
+	while (--i) {
+		desc = &priv->apTD0Rings[i];
+		kfree(desc->td_info);
+	}
+
+	return ret;
 }
 
-static void device_init_td1_ring(struct vnt_private *priv)
+static int device_init_td1_ring(struct vnt_private *priv)
 {
 	int i;
 	dma_addr_t  curr;
 	struct vnt_tx_desc *desc;
+	int ret;
 
 	/* Init the TD ring entries */
 	curr = priv->td1_pool_dma;
@@ -646,6 +698,10 @@ static void device_init_td1_ring(struct vnt_private *priv)
 	     i++, curr += sizeof(struct vnt_tx_desc)) {
 		desc = &priv->apTD1Rings[i];
 		desc->td_info = kzalloc(sizeof(*desc->td_info), GFP_KERNEL);
+		if (!desc->td_info) {
+			ret = -ENOMEM;
+			goto err_free_desc;
+		}
 
 		desc->td_info->buf = priv->tx1_bufs + i * PKT_BUF_SZ;
 		desc->td_info->buf_dma = priv->tx_bufs_dma1 + i * PKT_BUF_SZ;
@@ -657,6 +713,16 @@ static void device_init_td1_ring(struct vnt_private *priv)
 	if (i > 0)
 		priv->apTD1Rings[i-1].next_desc = cpu_to_le32(priv->td1_pool_dma);
 	priv->apTailTD[1] = priv->apCurrTD[1] = &priv->apTD1Rings[0];
+
+	return 0;
+
+err_free_desc:
+	while (--i) {
+		desc = &priv->apTD1Rings[i];
+		kfree(desc->td_info);
+	}
+
+	return ret;
 }
 
 static void device_free_td0_ring(struct vnt_private *priv)
@@ -745,6 +811,16 @@ static bool device_alloc_rx_buf(struct vnt_private *priv,
 	return true;
 }
 
+static void device_free_rx_buf(struct vnt_private *priv,
+				struct vnt_rx_desc *rd)
+{
+	struct vnt_rd_info *rd_info = rd->rd_info;
+
+	dma_unmap_single(&priv->pcid->dev, rd_info->skb_dma,
+			priv->rx_buf_sz, DMA_FROM_DEVICE);
+	dev_kfree_skb(rd_info->skb);
+}
+
 static const u8 fallback_rate0[5][5] = {
 	{RATE_18M, RATE_18M, RATE_12M, RATE_12M, RATE_12M},
 	{RATE_24M, RATE_24M, RATE_18M, RATE_12M, RATE_12M},
@@ -1165,10 +1241,18 @@ static int vnt_start(struct ieee80211_hw *hw)
 	}
 
 	dev_dbg(&priv->pcid->dev, "call device init rd0 ring\n");
-	device_init_rd0_ring(priv);
-	device_init_rd1_ring(priv);
-	device_init_td0_ring(priv);
-	device_init_td1_ring(priv);
+	ret = device_init_rd0_ring(priv);
+	if (ret)
+		return ret;
+	ret = device_init_rd1_ring(priv);
+	if (ret)
+		goto err_free_rd0_ring;
+	ret = device_init_td0_ring(priv);
+	if (ret)
+		goto err_free_rd1_ring;
+	ret = device_init_td1_ring(priv);
+	if (ret)
+		goto err_free_td0_ring;
 
 	device_init_registers(priv);
 
@@ -1178,6 +1262,14 @@ static int vnt_start(struct ieee80211_hw *hw)
 	ieee80211_wake_queues(hw);
 
 	return 0;
+
+err_free_td0_ring:
+	device_free_td0_ring(priv);
+err_free_rd1_ring:
+	device_free_rd1_ring(priv);
+err_free_rd0_ring:
+	device_free_rd0_ring(priv);
+	return ret;
 }
 
 static void vnt_stop(struct ieee80211_hw *hw)
-- 
1.9.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
