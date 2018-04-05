Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2169189-1522912249-2-11476071925633204621
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES endasv, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522912248; b=tNwL/EBtx57PiXRYeG5sMdjLcWrMa9g+CoQ/YD8LW7FHYcWr7g
    RNWf3q8BS7lJbkkSem4sdDgk1qAEAhactt1/7PNjHPW/3zLPWLobbjn2+r2fnT8U
    rq8yB4whyeT8OhD8ijQek5e1AmW5Dcf2DdKEBIzGfMjHPFN5o5Yi1VJrGjwTJ5WZ
    SHYnP5UopI7mFrXYwMbfAXBZT9DPlJsni9DM66ftnrbPQ6cNOMRVQl4gwnz1rT97
    3PQGs2uOiRXYc7LVt6yy9MVXpP832t/joEYEMR/KGWkR7sB3ir+6MLawPzpWwZ3J
    XEyCA5AvhIz4ZVO7vjYNSnqRC5Ktv92Tcehw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522912248; bh=lOkcn
    osDE9ok600791wNW+zrrnXzFPElQnOJ1/yTFOE=; b=dZXvwLdKD8sPDuDTta7Rb
    mhXXQdd9mzYJEvqS5UAPL2gi0gpgMC1PbKyqyRKl14VdqyxwcdUHVUix4OrtOL/P
    jJHp3Ti4waimUhFeEAA3H+xtNHoKHkLMyrogMxlsXj6IMiK/G7rbfMLKagU4USSZ
    HIKoX9XsRIR6k8HPUL5iD4r/+4GwLZgbGXSTZ70SxFDvkEt/EkjH/k9XJCKghb6D
    s87bsWNXzEnIEIa/HbpvCsWhtrGfL15yrNhhjI3rJygYE5kwWJ5H3Fz561sYkNKT
    tiAcr0bQe6dIu3HZ9cmSHO+VLmgkhAmAmzGAYJ0jJJfhjWG5XXSJkzu2UYGCTtZV
    w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=stiFn+Qx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=stiFn+Qx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBze7+AObTxgnpFttU+zEq5bwpwg8Oo3MayTSimTXGA7n7QohGFIl6wuVxxEIg8zSXlMMoD4Qfl5d4om1nIPCudQ7UDojXwc3BMrgEoP6j3lpy1miJ6H
    +tfs2vqnKo0XSqpSdyscYg9j6bDRUEAnzukOT1LT0g4dUw/YKZ9/4ODy6xc2fb/K6ldXTSAbNuPgOVsZjB3aNoRXTY3eKH20jdtoY5VpcpCIvjeKbClSMAZB
    BzTLn4boM0EZ0yfsTvBsMQ==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=hD80L64hAAAA:8 a=DDOyTI_5AAAA:8
    a=PX1WZr1yR-KmFugjP-4A:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20180405071037epoutp02d51d3639ebb8243468636f330e72f891~ieJx4j2fa2181821818epoutp02A
X-AuditID: b6c32a47-0fbff70000000fe8-7a-5ac5cbed79d5
From: Ji-Hun Kim <ji_hun.kim@samsung.com>
To: dan.carpenter@oracle.com, gregkh@linuxfoundation.org,
 baijiaju1990@gmail.com, forest@alittletooquiet.net
Subject: [PATCH v5 2/2] staging: vt6655: add handling memory leak on
 vnt_start()
Date: Thu, 05 Apr 2018 16:09:20 +0900
Message-id: <1522912160-21009-2-git-send-email-ji_hun.kim@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1522912160-21009-1-git-send-email-ji_hun.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPKsWRmVeSWpSXmKPExsWy7bCmue7b00ejDOb9Y7ZYN3Ehk8Xrf9NZ
 LM68P8tksefML3aL+xMesVo0L17PZtF/ejujxbIHpxkttt6Stri8aw6bxclt8hZbun6wOvB4
 NDe+Z/W4t+8wi8fOWXfZPfbPXcPusXdLlsfHp7dYPPq2rGL0+LxJLoAjKtUmIzUxJbVIITUv
 OT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+hWJYWyxJxSoFBAYnGxkr6d
 TVF+aUmqQkZ+cYmtUrShoZGeoYG5npGRkZ6JeayVkSlQSUJqxssjl5gLbvBUnJh8m62B8TBX
 FyMnh4SAicTs5ifMXYxcHEICOxglrnR/Z4NwvjNK7L88gRWmalHTLnaIxAZGiXd/v0G1/GCU
 mDR7MxtIFZuApsTG7muMILaIQJ7EvlWHmUCKmAUuMUosXruSGSQhLBAkcejcBrAiFgFVicaL
 e8DivAJuEv2/2xkh1slJnDw2GWw1p4C7xL4/G1lBBkkIHGGT2HbuE9RNLhLXJkxghrCFJV4d
 38IOYUtLPFu1EWpQtcSCKztYIOwaiZv/lzJB2MYSvT0XwHqZBfgkOg7/BerlAIrzSnS0CUGU
 eEh0LnkEtcpR4sLGudBwmcUosfnUCcYJjFILGBlWMYqlFhTnpqcWGxUY6xUn5haX5qXrJefn
 bmIEJyYt9x2M2875HGIU4GBU4uFt+HYkSog1say4MvcQowQHs5IIL2vz0Sgh3pTEyqrUovz4
 otKc1OJDjKbAsJnILCWanA9Mmnkl8YYmlgYmZmaG5kamBuZK4rytAS5RQgLpiSWp2ampBalF
 MH1MHJxSDYzrVGqmcR9hOHni223ryVPe/Zpa+OB2CrPTlije5rnRaw0/R1Vd8p2YWVMh9WHe
 yfvP1XdKcuw6WlR/4g3rygdXl+7TP6SoeydaLWiK0a9Uy2WntWvDEmM+yPBEVHxZtuLdpzhh
 PeHw7iNn1GfG3F2X/EBoQ9PSmXmaRbbhm0J+JV/Q1uBPVt+pxFKckWioxVxUnAgAEFNST2ID
 AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrILMWRmVeSWpSXmKPExsVy+t9jQd03p49GGazcqmOxbuJCJovX/6az
 WJx5f5bJYs+ZX+wW9yc8YrVoXryezaL/9HZGi2UPTjNabL0lbXF51xw2i5Pb5C22dP1gdeDx
 aG58z+pxb99hFo+ds+6ye+yfu4bdY++WLI+PT2+xePRtWcXo8XmTXABHFJdNSmpOZllqkb5d
 AlfGyyOXmAtu8FScmHybrYHxMFcXIyeHhICJxKKmXexdjFwcQgLrGCVOTGpihXB+MEpM6Ghi
 B6liE9CU2Nh9jRHEFhHIk9i+cxoLSBGzwCVGie2P5wIlODiEBQIkpr61BqlhEVCVaLy4hxnE
 5hVwk+j/3c4IsU1O4uSxyawgNqeAu8S+PxvBbCGgmhfzNrFNYORZwMiwilEytaA4Nz232KjA
 KC+1XK84Mbe4NC9dLzk/dxMjMCC3Hdbq38H4eEn8IUYBDkYlHt6Ov0eihFgTy4orcw8xSnAw
 K4nwsjYfjRLiTUmsrEotyo8vKs1JLT7EKM3BoiTOy59/LFJIID2xJDU7NbUgtQgmy8TBKdXA
 OGPFNd/uRs4Tlqpnct8+evDO7IWzaNGdzRMCrrlM/xl2ZHG6rMD5/5NkqgvD48Jmv92zZf3U
 rB5e/nT3CWIbiiTvTJafmbijbcOtDfuM0vOSjpj/FNY8eL76kcyNoI+pgq3/ym6xnFTaUyHS
 05zWE73vReonLm3RGw95VqrHvdr/ZJVSOYfhWSWW4oxEQy3mouJEAHkwqG1EAgAA
X-CMS-MailID: 20180405071036epcas2p1d676b4a75f9644aac86c5d4a7792ffdf
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180405071036epcas2p1d676b4a75f9644aac86c5d4a7792ffdf
X-RootMTR: 20180405071036epcas2p1d676b4a75f9644aac86c5d4a7792ffdf
References: <1522912160-21009-1-git-send-email-ji_hun.kim@samsung.com>
 <CGME20180405071036epcas2p1d676b4a75f9644aac86c5d4a7792ffdf@epcas2p1.samsung.com>
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
, when request_irq() would be failed. Add freeing sequences of irq and
device init rings.

Signed-off-by: Ji-Hun Kim <ji_hun.kim@samsung.com>
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
---
It's additional memory leak handling patch from the
[PATCH v5 1/2] staging: vt6655: check for memory allocation failures

Changes v2:
- Change label names following coding-style conventions.
- Remove uneccessary goto, just return error number like original code.

 drivers/staging/vt6655/device_main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 700c03c..1ab0e85 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -1237,13 +1237,13 @@ static int vnt_start(struct ieee80211_hw *hw)
 			  IRQF_SHARED, "vt6655", priv);
 	if (ret) {
 		dev_dbg(&priv->pcid->dev, "failed to start irq\n");
-		return ret;
+		goto err_free_rings;
 	}
 
 	dev_dbg(&priv->pcid->dev, "call device init rd0 ring\n");
 	ret = device_init_rd0_ring(priv);
 	if (ret)
-		return ret;
+		goto err_free_irq;
 	ret = device_init_rd1_ring(priv);
 	if (ret)
 		goto err_free_rd0_ring;
@@ -1269,6 +1269,10 @@ static int vnt_start(struct ieee80211_hw *hw)
 	device_free_rd1_ring(priv);
 err_free_rd0_ring:
 	device_free_rd0_ring(priv);
+err_free_irq:
+	free_irq(priv->pcid->irq, priv);
+err_free_rings:
+	device_free_rings(priv);
 	return ret;
 }
 
-- 
1.9.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
