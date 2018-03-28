Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1661265-1522219293-2-15749537519724242214
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522219292; b=k22qIWmouI/hQovpHSwzaIPv7J2VGtI4EDeKLZzXSIY9Bzc
    5vz019uVJqsncyoRxKbrZSyqSVSuFEURBDzKlqWbIggRB0jm7LCLAMbGUf4ARkZw
    v5eO9U91eSlTEq+n7jU8S+aCEeb28aNf7qpv93DQZZu21Z6TQjNJ3f+V66hPMN3Z
    kk8LL1lN7BsAlq+mMZ69Cr/rHkLRoriZdAwqmTwxTVkFFgD1o761dFQAlm03424L
    JijBD0SyfX2n23qQxGQRX4AOLaxiRmc99Iib2EApyOjFRhlITZUuZKEf3p7oUewK
    wLbDyARiAhOh5cPH/ndt1YOUSyNv6IGo7Qe5yfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1522219292; bh=J
    olDn6vKXWVKUS/dl5qA3ak4fI64GxGkrUzgXDQWw7g=; b=nXV1wWUU7kxHZ493N
    UVNWMwmBwUV57bMOAWAzcyhzzXKzZ6a0IUjpZpn21e+uQn0EbZwhqSNADjL8SKI4
    qKdWpkiwC3ApDqDRc1g8ox/WgeYWc8dL5NMyKVzGwPZncTuiXsKaVhq1ZdC8Sq8H
    eRzG5YOS0eTecvrdmdwzcLo0+TgGZoAheX3cW9cAe1dSzKU3yY42SmHc0hgVUmOC
    hKGW0TcFCOL9GEHUGjVAgLZm5M+HhORw6Rxcu22pOLQ4K08EV8XxWC7vHwwJHjY5
    vCgwncTqaVopg7ILlTS706kAep38OCu7A+LPVoxTUueX4joLH9y8t3d+aOIiOT+2
    uclcg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=WXjhgLZO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
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
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=WXjhgLZO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
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
X-CM-Envelope: MS4wfOgpXzMJVQ7c45YQbqSKXRBuvzv7QcViRaEgIDNf8DIld4UigF26PCDP4AUzJ1z8+d+5DSt3/eakyiBA5Wn9SPBFuttI4ENCDq0s1TMoOe6MScRrPswB
    V+KC/F+cQANurxCfE311Hc6R82eOVLZoAw3eB+yAyh0O3MoW+JNTz0CIrNQRO+mrS5y/ZHWrqkcyz5J2tBfM8EfApIJ3AaP27eeitePAHzeDDakNivsJ9j9f
    nEQFKugPdpGbA+XbfPOiSA==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=hD80L64hAAAA:8 a=DDOyTI_5AAAA:8
    a=42hYBvJM2PcR6VP4b98A:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20180328064120epoutp04c2889609a9fd1d5340e6f0b5181a35ec~gAl7uVneX1771517715epoutp04i
X-AuditID: b6c32a38-d73ff70000001082-89-5abb36d18c6e
From: Ji-Hun Kim <ji_hun.kim@samsung.com>
To: gregkh@linuxfoundation.org, forest@alittletooquiet.net
Subject: [PATCH] staging: vt6655: check for memory allocation failures
Date: Wed, 28 Mar 2018 15:31:31 +0900
Message-id: <1522218691-7917-1-git-send-email-ji_hun.kim@samsung.com>
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCKsWRmVeSWpSXmKPExsWy7bCmvu5Fs91RBndeiVusm7iQyeLM+7NM
 FnvO/GK3uD/hEatF8+L1bBb9p7czWix7cJrRYustaYvLu+awWZzcJm+xpesHqwO3R3Pje1aP
 e/sOs3jsnHWX3WP/3DXsHnu3ZHn0bVnF6PF5k1wAe1SqTUZqYkpqkUJqXnJ+SmZeuq2Sd3C8
 c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QhUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OIS
 W6VoQ0MjPUMDcz0jIyM9E/NYKyNToJKE1IzN316zFLwUqLj16A5LA+N73i5GTg4JAROJ/ot/
 mbsYuTiEBHYwSkyZ/BPK+c4ocfXpBnaYqkPPt0IldjNKnPv+Acr5wShxauMNRpAqNgFNiY3d
 14BsDg4RASuJSft0QcLMAm8YJX6u0gOxhQXcJB4tPQA2lEVAVWLTkb1gNq+Aq8Tr4zuZIJbJ
 SZw8NpkVZL6EwBw2iTcX5rKBzJQQcJGYfaAWokZY4tXxLewQYWmJS0dtIcLVEguu7GCBsGsk
 bv5fCjXSWKK35wIzxDl8Eu++9rBCtPJKdLQJQZR4SNzv2A/1rqPEkk//wGwhgViJrrU3mSYw
 Si5gZFjFKJZaUJybnlpsWGCiV5yYW1yal66XnJ+7iRGcYrQsdjDuOedziFGAg1GJh7cgZleU
 EGtiWXFl7iFGCQ5mJRHe9xq7o4R4UxIrq1KL8uOLSnNSiw8xmgIDYyKzlGhyPjD95ZXEG5pY
 GpiYGZmaGhpYmCiJ8wYEuEQJCaQnlqRmp6YWpBbB9DFxcEo1MCpFSt5+f/Uw27ZNk8TvuKxa
 uOfi7pDMt6+Cik7P/NqZOWHTEZGd25Y31a6abHe4Jldkl93cj0FmXeZ3q5R3f9u72rW3MN/w
 uCW/3v2d+97cfeqpfqlJ+8h01ejqlaELN/OxRE2K3VG6u9TpovhGgZjkj5oTd/vUr2tJa/5h
 YD+3eeaszVortFmVWIozEg21mIuKEwGDh5m0RwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnluLIzCtJLcpLzFFi42I5/e+xgO4Fs91RBg++mFmsm7iQyeLM+7NM
 FnvO/GK3uD/hEatF8+L1bBb9p7czWix7cJrRYustaYvLu+awWZzcJm+xpesHqwO3R3Pje1aP
 e/sOs3jsnHWX3WP/3DXsHnu3ZHn0bVnF6PF5k1wAexSXTUpqTmZZapG+XQJXxuZvr1kKXgpU
 3Hp0h6WB8T1vFyMnh4SAicSh51uZuxi5OIQEdjJKfHnTyAjh/GCUWHAeJMPJwSagKbGx+xpQ
 goNDRMBKYtI+XZAaZoE3jBLXVx0CqxEWcJN4tPQAO4jNIqAqsenIXjCbV8BV4vXxnUwQ2+Qk
 Th6bzDqBkWsBI8MqRsnUguLc9NxiowLDvNRyveLE3OLSvHS95PzcTYzAYNp2WKtvB+P9JfGH
 GAU4GJV4eAtidkUJsSaWFVfmHmKU4GBWEuF9r7E7Sog3JbGyKrUoP76oNCe1+BCjNAeLkjjv
 7bxjkUIC6YklqdmpqQWpRTBZJg5OqQZGlZdVJmEvCi5vf5PY0bkyV1HA1mH9Lu6JGu6MP1Ii
 +TcxSQtqL+lhLDWLWvPsrXH0k11Lr83Y4dDw+uM8BZbnq2Zoh8f4vJmWfJ3fp3zF5oj3uklJ
 2xfcKzql9UPSM2jxodUGq5cdfjJ9v0PkK3E3Sf4FLCpfBdes6d1+VWFN3vfdS5+cWt5so8RS
 nJFoqMVcVJwIANBTvRgiAgAA
X-CMS-MailID: 20180328063144epcas1p305216b582520b884b09c93a7ad591660
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180328063144epcas1p305216b582520b884b09c93a7ad591660
X-RootMTR: 20180328063144epcas1p305216b582520b884b09c93a7ad591660
References: <CGME20180328063144epcas1p305216b582520b884b09c93a7ad591660@epcas1p3.samsung.com>
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
 kernel-janitors@vger.kernel.org, ji_hun.kim@samsung.com,
 linux-kernel@vger.kernel.org, julia.lawall@lip6.fr, baijiaju1990@gmail.com,
 santhameena13@gmail.com
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
 drivers/staging/vt6655/device_main.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index fbc4bc6..5d0ba94 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -539,7 +539,8 @@ static void device_init_rd0_ring(struct vnt_private *priv)
 	     i ++, curr += sizeof(struct vnt_rx_desc)) {
 		desc = &priv->aRD0Ring[i];
 		desc->rd_info = kzalloc(sizeof(*desc->rd_info), GFP_KERNEL);
-
+		if (WARN_ON(!desc->rd_info))
+			return;
 		if (!device_alloc_rx_buf(priv, desc))
 			dev_err(&priv->pcid->dev, "can not alloc rx bufs\n");
 
@@ -563,7 +564,8 @@ static void device_init_rd1_ring(struct vnt_private *priv)
 	     i ++, curr += sizeof(struct vnt_rx_desc)) {
 		desc = &priv->aRD1Ring[i];
 		desc->rd_info = kzalloc(sizeof(*desc->rd_info), GFP_KERNEL);
-
+		if (WARN_ON(!desc->rd_info))
+			return;
 		if (!device_alloc_rx_buf(priv, desc))
 			dev_err(&priv->pcid->dev, "can not alloc rx bufs\n");
 
@@ -621,7 +623,8 @@ static void device_init_td0_ring(struct vnt_private *priv)
 	     i++, curr += sizeof(struct vnt_tx_desc)) {
 		desc = &priv->apTD0Rings[i];
 		desc->td_info = kzalloc(sizeof(*desc->td_info), GFP_KERNEL);
-
+		if (WARN_ON(!desc->td_info))
+			return;
 		desc->td_info->buf = priv->tx0_bufs + i * PKT_BUF_SZ;
 		desc->td_info->buf_dma = priv->tx_bufs_dma0 + i * PKT_BUF_SZ;
 
@@ -646,7 +649,8 @@ static void device_init_td1_ring(struct vnt_private *priv)
 	     i++, curr += sizeof(struct vnt_tx_desc)) {
 		desc = &priv->apTD1Rings[i];
 		desc->td_info = kzalloc(sizeof(*desc->td_info), GFP_KERNEL);
-
+		if (WARN_ON(!desc->td_info))
+			return;
 		desc->td_info->buf = priv->tx1_bufs + i * PKT_BUF_SZ;
 		desc->td_info->buf_dma = priv->tx_bufs_dma1 + i * PKT_BUF_SZ;
 
-- 
1.9.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
