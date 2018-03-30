Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2671055-1522389147-2-6029213040875154784
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES daensv, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522389146; b=o7ifpLFSso8ZegrqGkBhcjndTFTa3UAGscMygaUog8SOTh91ps
    6z0imgxBfZIbp1t2SC3jDqon+5oI0GI6uDWExa0r6SUgYSgh29EWa5bUYYZ2VIst
    fWzlw4/nBZ+xrZhQVHIPQM6R3ZcDJbreZ8SsuZzsF1RBIhoTz8vwoBpsnZO7Dldz
    F4jDqRu2/yBD4HjHgqe0Wkh2lTvHrgnj6BiiReY3P32sV26umcma+n1/H2R+qH2e
    zOgiMvZZHo/CpCzMdOdFS6OwIOzwsCf2ogsqOpG+XsmU9KBXbtPVMwL0mJm5OzPK
    WE0mMYPLCYD0tK3KBl8vevyE7qweBxUyouAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522389146; bh=9oSJq
    rfYqEy/YAQ4SSkDKlIXaFYpHIIvp2LzF/fm1X0=; b=S5v130sh2PGoyjdNb3M1j
    +vkCJd+lTLM9YhTSLtkg7XcYhWI5j/fgaxhWL+mOwUD4saPa1sg3KN9xTV4SmjVe
    2n4gcZYySEQIY11gj7sF/sHzORMCrgQyp5gMvXa2pJjndNH5YRDQZMP/sxm0ZoVC
    iOIv2GsTgnSJ1Ux7ArU7xwvGPuM4IDgdKZXc+zfBjo7Z+E/LSVxI1m9OeYCkwCeM
    vLxbHylj/3JuZ77y5+4rXB10hqKSm4JZ00RIPwlliixWKJfP2U0EhMf3IhjIo8n9
    6ytvpn+vwhqDyH8RNm7AzWHgaUEdPhEbjt18H7LXZ3yqpKWPsqXOPr7VDfiHWdxr
    A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=cZiQbwkQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
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
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=cZiQbwkQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
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
X-CM-Envelope: MS4wfDNGXeejrD0uDzA0C/6ZyUJyra+bsgaSQ2t/GtxSYDnTjb/q539yOFenqcJGwrCOY2nVOH33fNzPXll+VLtRs9RtrHD3twGCgWDc6GUrybv4ykNDRSbe
    XBDCmMuRL4vOeXEiUoyCOIOXeoV6bFrwPCWjIQXkfsPQitpUaZWGtq3AN86f/oTp7/S1ZFDLv7i9+jlw+a9cEtPelljHq2RuAgS9AwIPHTq31pTuZDFY2OfJ
    RbWhmfic2zHb7JV1UiLDRg==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=hD80L64hAAAA:8 a=DDOyTI_5AAAA:8
    a=53f9oD-R1Ju_qLx-G8UA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20180330055212epoutp03394d54b41c733b8f1c5bffcb778ae272~gnNmQLDeF2026120261epoutp03n
X-AuditID: b6c32a46-b85ff70000000fe8-da-5abdd08b2f58
From: Ji-Hun Kim <ji_hun.kim@samsung.com>
To: gregkh@linuxfoundation.org, baijiaju1990@gmail.com,
 forest@alittletooquiet.net
Subject: [PATCH v4 2/2] staging: vt6655: add handling memory leak on
 vnt_start()
Date: Fri, 30 Mar 2018 14:51:55 +0900
Message-id: <1522389115-1124-2-git-send-email-ji_hun.kim@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1522389115-1124-1-git-send-email-ji_hun.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKKsWRmVeSWpSXmKPExsWy7bCmqW73hb1RBvuvWlusm7iQyeLM+7NM
 FnvO/GK3uD/hEatF8+L1bBb9p7czWix7cJrRYustaYvLu+awWZzcJm+xpesHqwO3R3Pje1aP
 e/sOs3jsnHWX3WP/3DXsHnu3ZHn0bVnF6PF5k1wAe1SqTUZqYkpqkUJqXnJ+SmZeuq2Sd3C8
 c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QhUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OIS
 W6VoQ0MjPUMDcz0jIyM9E/NYKyNToJKE1IxXXS9YC3p4KnZM+c3awNjA1cXIySEhYCLxbH4P
 axcjF4eQwA5Gibc/+5ghnO+MEjvanzDCVB29chmqagOjxPcnq9kgnB+MEut//WIHqWIT0JTY
 2H0NrENEIERixY5tLCBFzAKXGCUWr13JDJIQFgiS2P3uExOIzSKgKrHx2TSwBl4BV4mZ61+z
 QayTkzh5bDIriM0p4Cax8uwfsNUSAhvYJHqXfGaCKHKReL7/PNR9whKvjm9hh7ClJZ6t2ggV
 r5ZYcGUHC4RdI3Hz/1KoXmOJ3p4LYAcxC/BJdBz+C9TLARTnlehoE4Io8ZC4N78daoyjxN7t
 M1ggPp7JKDHjdA/TBEapBYwMqxjFUguKc9NTi40KjPSKE3OLS/PS9ZLzczcxgpOQltsOxiXn
 fA4xCnAwKvHwKrDsjRJiTSwrrsw9xCjBwawkwmt1EijEm5JYWZValB9fVJqTWnyI0RQYNhOZ
 pUST84EJMq8k3tDE0sDEzMzQ3MjUwFxJnLc1wCVKSCA9sSQ1OzW1ILUIpo+Jg1OqgXHf3Tc+
 P95+3/Nvp1ZVekF6KtPX9xanS/x8p9is+PdGSVxm747PBwPXHZM8zuum+bKn0XIRf59Mpdu1
 0lZj9n0f9/Tc8qyPFLi3RlP6fDz3r7erH0lNiDuXKZA96a/J4dVqRY+vcG862MRmmLpOW2PO
 nPQth988WuIccTn6e/yx5byeoq/i5vgrsRRnJBpqMRcVJwIAXaKJ4lgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBLMWRmVeSWpSXmKPExsVy+t9jQd3uC3ujDNY1y1ism7iQyeLM+7NM
 FnvO/GK3uD/hEatF8+L1bBb9p7czWix7cJrRYustaYvLu+awWZzcJm+xpesHqwO3R3Pje1aP
 e/sOs3jsnHWX3WP/3DXsHnu3ZHn0bVnF6PF5k1wAexSXTUpqTmZZapG+XQJXxquuF6wFPTwV
 O6b8Zm1gbODqYuTkkBAwkTh65TJrFyMXh5DAOkaJiQtvskA4Pxglfn3/xgxSxSagKbGx+xoj
 iC0iECLxv/kqI0gRs8AlRontj+eCJYQFAiR2bG4Ea2ARUJXY+GwaWJxXwFVi5vrXbBDr5CRO
 HpvMCmJzCrhJrDz7B8wWAqpZNOsr2wRGngWMDKsYJVMLinPTc4uNCozyUsv1ihNzi0vz0vWS
 83M3MQLDb9thrf4djI+XxB9iFOBgVOLhrWDbGyXEmlhWXJl7iFGCg1lJhNfqJFCINyWxsiq1
 KD++qDQntfgQozQHi5I4L3/+sUghgfTEktTs1NSC1CKYLBMHp1QD4xS3F8Grb0q2/8i9ML1c
 cOJLr4iZjEEKc48v/sw7sTZXJ2G1lkCq/NcpMTklUVNkv3jtfpVZ5Bx2MbXWpezvrtioKz/n
 Mvwz02RzP3eZP477kUGtzuk3/v1151YXJ51oCJTpn/lvirnrOdvSm+H3ZXZdL7h4O/F07Yvv
 B08waek/bYpPWXgpWYmlOCPRUIu5qDgRACsOlvA7AgAA
X-CMS-MailID: 20180330055211epcas2p1a75c707cdf600cfd5027e253ef440861
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180330055211epcas2p1a75c707cdf600cfd5027e253ef440861
X-RootMTR: 20180330055211epcas2p1a75c707cdf600cfd5027e253ef440861
References: <1522389115-1124-1-git-send-email-ji_hun.kim@samsung.com>
 <CGME20180330055211epcas2p1a75c707cdf600cfd5027e253ef440861@epcas2p1.samsung.com>
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

There was no code for handling memory leaks of device_init_rings() and
request_irq(). It needs to free allocated memory in the device_init_rings()
, when request_irq() is failed. Add freeing sequences of irq and device
init rings.

Signed-off-by: Ji-Hun Kim <ji_hun.kim@samsung.com>
---
It's additional memory leak handling patch from
[PATCH v4 1/2] staging: vt6655: check for memory allocation failures

 drivers/staging/vt6655/device_main.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index c9752df..3604f2d 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -1194,14 +1194,17 @@ static int vnt_start(struct ieee80211_hw *hw)
 	int ret;
 
 	priv->rx_buf_sz = PKT_BUF_SZ;
-	if (!device_init_rings(priv))
-		return -ENOMEM;
+	ret = (int)device_init_rings(priv);
+	if (!ret) {
+		ret = -ENOMEM;
+		goto err_init_rings;
+	}
 
 	ret = request_irq(priv->pcid->irq, vnt_interrupt,
 			  IRQF_SHARED, "vt6655", priv);
 	if (ret) {
 		dev_dbg(&priv->pcid->dev, "failed to start irq\n");
-		return ret;
+		goto err_irq;
 	}
 
 	dev_dbg(&priv->pcid->dev, "call device init rd0 ring\n");
@@ -1234,6 +1237,10 @@ static int vnt_start(struct ieee80211_hw *hw)
 err_init_rd1_ring:
 	device_free_rd0_ring(priv);
 err_init_rd0_ring:
+	free_irq(priv->pcid->irq, priv);
+err_irq:
+	device_free_rings(priv);
+err_init_rings:
 	return ret;
 }
 
-- 
1.9.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
