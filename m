Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2529736-1521057920-2-9723060236424640840
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521057919; b=mu3lGoRL/kqCL2EyWw3vHtbnrlUNyO8Jxhx3VpOmPFB4dq0
    9GFqEo9ZEAdXZq8jqD3O8/WGuCZh+DGiaGtwCUxrMwTeUaL5W4ZB8MyoRyrzxyCw
    YvMGFUGzvTXH+vLkW/f5npkhoIvNeIbLyIsB02hsRhtWnjhXJ9yszp9Y8qvClzoO
    P3JIN2ZxbTVLyjY9acIdtWpMZoYbYexHf1eYJp/6ovcSTZLQlkAOMtHA+dFiirEs
    Yx4YsQO81if5dfA7ctvoMYfUTlI3c823RVu9CV5IhmD3Sd+3mayBu5gPSIGZF5HN
    uJYL3t84vj8UFl+OqmnvcPygE9NtU83xuOeRpNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521057919; bh=L
    6r793aTiu9yWQdys73t/Q8QVjVOx5kjqxQv2inSfd8=; b=PCVD+SbwiPI44jQTo
    +31yT+FH/i6CEOazZmSg55coMGuikdzOcGZWxnA4CY6x+H5BKPbfTE7meRNrnR2W
    y0DlW282pXSkgidqvZN8CwunwJOOL2uJyQ8zMIgrwLl3BpD1fScgQG74vJ1FGUKh
    17QCqMfub5PI57voHGdPHqGpxp1BnPRZf/bSbmdbf/FjRreSnvaoeGLLKxRhhGCE
    FS8ufYIdLWLFU4jEbpJedUjdEdyJPEOuDRlndPargxWs5FpQvSnWzpYoWj013mSw
    46luS06538C6yhQQmWSd6xKIk8FWDZ/c71v0Pc7mFU0KGNfdde6g0tzi2TKge6w4
    wfzMQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=LU1FUKpH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=LU1FUKpH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com;
From: Ioana Radulescu <ruxandra.radulescu@nxp.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH] staging: fsl-dpaa2/eth: Fix incorrect kfree
Date: Wed, 14 Mar 2018 15:04:51 -0500
Message-Id: <20180314200451.27738-1-ruxandra.radulescu@nxp.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: BN6PR11CA0039.namprd11.prod.outlook.com
 (2603:10b6:404:4b::25) To VI1PR0402MB2703.eurprd04.prod.outlook.com
 (2603:10a6:800:b4::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 681732c3-5ae9-48f1-75df-08d589e6e19a
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB2703;
X-Microsoft-Exchange-Diagnostics: 1; VI1PR0402MB2703;
 3:k+c7xVFAtO8/Wx52Y+hnft7Ib+a1yYvtbItjeUhySoP13qDJgyLLmbPfkNNqml25wETO/gHMVnnGwUJHJDhKAzHmRllc1F9cXILvfwtJYLrxDj9YhN5HhUUiwUA+HVyMuXOsAsoq+uJYzfe8UmG4NfjKXwWgIn1K07pfLyzNZs+KGtYEl3Ez8IM/ElXe2HbDyKkW7RvofpCtKgBkvFEgrVHjfgez8ONuZ3B6y99AMhx8aXOTJAmRLjVH8vLjIR+r;
 25:SDJEzGSnQ0FrgLEhocqD1t1Bd8a8vMjQ/8xJZaS3TLABXtT4g79dmJC31LWFVpBHFgKJfFKQUuQ8RHZdKXOgckpdkUWEobwErU5Twl7U2HDA6BgNa9CYQHi7w4sQ32Q4IZfuHllv9dauY/Qa6pSopXJCPyDKKpP7uwWUIbwIt6iYYi++6QHbNDA1vmg0yxmK25IFST22+vPnKPs2Kl01iWv8zg9AbPcaHn1MXne1I2LMQYh/np5ky9j2j7DSV5PwgK5sh6qQ1/E32R/Oo6Ee2wnL3TMKSX/xKyi9ovc/bi1nP8Oyt38lM6ORpBItp+5k0+HgAudCTxI3X3Hcfjslfg==;
 31:clU1F8z2QSCX6m68FnupufJR/GqDvg3l/F3AzSC4PfwlN1oFjv98gKQQNUq2TA9+j3/EKXOHSpBYc5u2r8icCMB/ukTcbDQv8IionlsxSUZA9jowydSdIjmemXiZbDl3SZ8yh8zZvytidp6DnbPD+H9Kazm2le/6jBDk8YUgl3bFJvCYER4CyhHsQmSHu3c6WKzFCww2m4BIdRWSfXJX0a++0+yKpHYRcykxq2yA6Ck=
X-MS-TrafficTypeDiagnostic: VI1PR0402MB2703:
X-Microsoft-Exchange-Diagnostics: 1; VI1PR0402MB2703;
 20:niPnpdu4vdn5p+PZ9u+aGEbaTLr7hYq69UiH6sbGvgEIlmDAXY4vP0jp9wh7m8Az9VWvvqrg8Syhe1nUFQA5PHsDmeclh1q19QZgfV45Az5KWANOPbVPmYJTnTRnPq/A14Lq/cWuS/eCI0ylnKgq4fIRcerLP5ZxKe5Hmz+zPMrlEjpi43I50cyWKePvFlNqHAbsNQvFUYFplrgtqNSvq1YGShJOUGFLq4Ur4XVAIhZEk3KSMvzChc/TR/EiaD04A3gEH7WwrmcbkXTnO93idMPSTO/Ok+LqoQFEkCAToqrAyEyraCh+0qh+o1ShT7Q7tmPaYpMrGJB6/Ot5EqsxWMmAz4Xh0Q7rOI93wY44zfJq09VhzUa8hXS9phR7/KNnV3dZJVbRRh1nb64QWYhIrWrZ/mtyHUyAVvWgDhhHtpYSZwVkslcCtcOtn/tmJjoTz6gQr3gPW41tXBllosbLaHHNt+FN8F0qD2SwiOtoO9AyVEBKr4HcxF2w6qRuILSB;
 4:vTI6ue05JjCBq/ccb0+oXbDbumd/ykEynx0hUsDO3ibL1WOacz0QAUCWyHLxD/aF4PXcnTps7hR4grqxUkI0Y38PWBPJh8IKfh9sDGznOfLNQcTaes4QJ5w1KENJ3kMwZfyxpCidFxlyaw9inFzlx9v0lXWxO1uzUBgEtWIsZ770XU9Y1tfovwHxtf76sQhrd1svSl9/IfeHRJZWCyhYRzSpeX24doeMrSZ5E9lSUFvGwKnQ+wKS34wB0xKvbJkGK0XrJ/1Wzir+Bu6+TEzwiyoQYl/jDUw9TAyedauGBsI9i+CdlGmDVBioagPuVYvT4FcDFHf7xgZC5llZMF7OwPG/P91p38oLS9zBVsPSVJ8=
X-Microsoft-Antispam-PRVS: <VI1PR0402MB270381BFA37A76D67D116A4694D10@VI1PR0402MB2703.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(146099531331640);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231221)(944501244)(52105095)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011);
 SRVR:VI1PR0402MB2703; BCL:0; PCL:0; RULEID:; SRVR:VI1PR0402MB2703;
X-Forefront-PRVS: 0611A21987
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(366004)(376002)(396003)(39380400002)(39860400002)(346002)(199004)(189003)(16526019)(2361001)(26005)(66066001)(6666003)(47776003)(7736002)(305945005)(51416003)(50466002)(48376002)(52116002)(105586002)(3846002)(386003)(1076002)(186003)(2906002)(25786009)(6916009)(1857600001)(2351001)(6506007)(6116002)(86362001)(6512007)(316002)(4326008)(8936002)(81166006)(53936002)(36756003)(106356001)(8676002)(81156014)(68736007)(50226002)(6486002)(97736004)(5660300001)(478600001)(16586007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB2703; H:rhuath.am.freescale.net;
 FPR:; SPF:None; PTR:InfoNoRecords; A:1; MX:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; VI1PR0402MB2703;
 23:XAc6g4Je3Ca/oIRRbmjmxE4nm5Y1zfU6C70VS8U?=
 =?us-ascii?Q?u5RYHgwAsNTDFJ5cfXsu90cXh8pVwQ0CxyYHNhR6Rt/8qq9bKTvwon/6EZEV?=
 =?us-ascii?Q?G5QtzJ++K2WDrc14Qx7jzfjyeJRWA7cDo7Hhe/Age3OTwlVrBX+gPV79SHc6?=
 =?us-ascii?Q?Xb/S0wAo8eD5wtoA2lLfVw8xb20iYiM8mYRevv7ZMr8Dz6SdBgraDaGz3P7d?=
 =?us-ascii?Q?UMvF6aG51ErRa6+1jh5lpGWE0pv4hBZSYYdQLS3C0FYFEF7/dhywWZxo6mdZ?=
 =?us-ascii?Q?5ZC8N4E564OSCFLDb8tvVJUO6Y9CiMsgaigh8NzbkDKGG1oowWSvb1VTIlv+?=
 =?us-ascii?Q?G0Er32YMGSQIwo06twMvO4XH82bUuYrrIRz/zlgxZSpxFwqgsttlBTQuUFC4?=
 =?us-ascii?Q?6we1egcbgcP+/3L2w8GsT6SfFoBHBSJDPwOgwaRv0uc9drdZCdxYTcxuhi8C?=
 =?us-ascii?Q?TQXRiyt69TObp6q45j5qtpb/vvG01yzRDWcrYoAKc7YPP9t7pShYA14I7jpp?=
 =?us-ascii?Q?JUmPysMd0n2VvHXrwx7slyKOEVwuGMgnZzYuqKWTr1AKgw8X4HbiO3DhGnJ2?=
 =?us-ascii?Q?LJwphLYj2DR2pBBVWRShmSdhd4b3JRvqZPydMKGtKuBkzs6BoatWGHeUznmz?=
 =?us-ascii?Q?jZE1kjXJOwRTEHgVN7Fps4l1kjJxhXBK2IjCmrvjXJcdGjqDouvyb6EZ3hhC?=
 =?us-ascii?Q?zPGOAZ1raa/PmdleKGZGfYCnVjMBcYi11TNqSJmyQm6viEoMFFdNEKjEkHG5?=
 =?us-ascii?Q?SwFNYZTavXhabdpxIOSEXyaWsN6azAYGsc6nbPhFCheA47eY2MuZcAveQjPt?=
 =?us-ascii?Q?udnWXQ4VIIs6Jd9WIa9r2JYvzsSPtEB9TNDC1YjyzorL5OoD98AXibnrRFN0?=
 =?us-ascii?Q?KL89RiR4g8Crd8iieY6cUH8RYcGkkNWE0rfzpY9IhrMs4xAif4kv6dLT4Bus?=
 =?us-ascii?Q?RhggNEdy5+89eoj2rmFDeKSxgGhEIyn3ge4RvhdSQPFMzL/RvoAiluNnmi+f?=
 =?us-ascii?Q?s61nU5ttCjDY8aQ6QB9iTV2jUn3Bz7MmfJ026ujershzNkrLQ2mVgYcKeuqv?=
 =?us-ascii?Q?jHtxshLsN5FYX1JyR8NTe4BTGICxuHNpFllYXaeZh9uZ5DWYaXisOwyvbwzU?=
 =?us-ascii?Q?W9n4IQEQ1dxv012G0jc23yspRrm9IFJWw?=
X-Microsoft-Antispam-Message-Info: etS7aDAkKcBeChLCylpA7kgMdUoxvSpAejyW3Z+jBoSxrt81moZ1s/D79PCqAfU2YxpyXscsN4u2JO3MTx29CXm7QkBXMcJ36xS/jbxKS+NXmA/2SCGeXnNqvreULeDqOPuNio2yw88kFIqSMa5aETT34YqI+l0Yc0d9aTdMZHMieNzWqy4IrW8XK0+138r+
X-Microsoft-Exchange-Diagnostics: 1; VI1PR0402MB2703;
 6:6gf3Ylg/ptlXAWPHHUAGoFc+NYAliGCOOfKG/fY1MI9hZwHHD4mEjtF/WOYMO3jyMw2P5UJ4866EkRFaRol1lAP8i7vuKAmningUjhMq/2HX31/sdNHyTpSH6VcTOEr2TrezvaIeC9wWiFdwSCgTh5vK9P5/ZjL4uFyyhg8EmJ8JvGgjf8XE4k+Zkqg17P+SC4Rmr4cSur22/CheEuzlzIItJaVvTredZJ0BS58cPG3WmlWfV1F9pRQumEfoGCpistHPTzGZnMqWb/euiSDC1NLk2uwMwiJP4g+BKYnIflmIdAy5RNcjesL3bVjhxNQbsCXwqcFVZeXz1gOORME84AFAWp17UaIbHp2f8eBoUsE=;
 5:r5zCZS7fxCEE2OrjPa0baTQzwEdUO6E2m/4Gs37zu9IgoOpVUBtGvqxu0WtUNlqHZJEct5VVgxOpQKKn+Ct2qBSbQmE2aH2JmateBWzo1AKkCMoLLX9E4/9/IFI7QsVshTuKwpWxwCpNF5W0QeFaJj4LYmrINR3lYitnb0tQQQU=;
 24:TMOtTXwK1MY6frrShNM5tCANIGNfajIR0CfPz58/wXiQcKVrGXywHLFttp963fFd6U+I0jjdd+vlZ2h28857+QBqSp0sSnDgb13JjSfQBHY=;
 7:hJa5c1TmiADX0bSDzRHpRv7LRlBXnBTM07ikeSjQQgaM4AgueYa7V7kVNSpUH91ZgIsXcmvnJY3+x0ctxRbZlovozqkN/vHAoMhbQGRxq1EaJjuRZa6aGnV6sztfncviv3HWV0Qz1hj7umpL5os13TnPFzADDy6D78dI/sO9Xxr5H5M/c7+QxuLCDegP4nwjbi1vY4XOuSvII1UEcg0DT7GoHtzhGVlPfm0RV2B5hZAFceqSTm/cBnWtr21SkTOU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2018 20:05:05.2179 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 681732c3-5ae9-48f1-75df-08d589e6e19a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2703
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
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
 dan.carpenter@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use netdev_alloc_frag() instead of kmalloc to allocate space for
the S/G table of egress multi-buffer frames.

This fixes a bug where an unaligned pointer received from the
allocator would be overwritten with the 64B aligned value,
leading to a wrong address being later passed to kfree.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
index c81a01f..f013af6 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
@@ -374,12 +374,14 @@ static int build_sg_fd(struct dpaa2_eth_priv *priv,
 	/* Prepare the HW SGT structure */
 	sgt_buf_size = priv->tx_data_offset +
 		       sizeof(struct dpaa2_sg_entry) * (1 + num_dma_bufs);
-	sgt_buf = kzalloc(sgt_buf_size + DPAA2_ETH_TX_BUF_ALIGN, GFP_ATOMIC);
+	sgt_buf = netdev_alloc_frag(sgt_buf_size + DPAA2_ETH_TX_BUF_ALIGN);
 	if (unlikely(!sgt_buf)) {
 		err = -ENOMEM;
 		goto sgt_buf_alloc_failed;
 	}
 	sgt_buf = PTR_ALIGN(sgt_buf, DPAA2_ETH_TX_BUF_ALIGN);
+	memset(sgt_buf, 0, sgt_buf_size);
+
 	sgt = (struct dpaa2_sg_entry *)(sgt_buf + priv->tx_data_offset);
 
 	/* Fill in the HW SGT structure.
@@ -421,7 +423,7 @@ static int build_sg_fd(struct dpaa2_eth_priv *priv,
 	return 0;
 
 dma_map_single_failed:
-	kfree(sgt_buf);
+	skb_free_frag(sgt_buf);
 sgt_buf_alloc_failed:
 	dma_unmap_sg(dev, scl, num_sg, DMA_BIDIRECTIONAL);
 dma_map_sg_failed:
@@ -525,9 +527,9 @@ static void free_tx_fd(const struct dpaa2_eth_priv *priv,
 		return;
 	}
 
-	/* Free SGT buffer kmalloc'ed on tx */
+	/* Free SGT buffer allocated on tx */
 	if (fd_format != dpaa2_fd_single)
-		kfree(skbh);
+		skb_free_frag(skbh);
 
 	/* Move on with skb release */
 	dev_kfree_skb(skb);
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
