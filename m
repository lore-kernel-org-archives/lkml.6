Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1346284-1521812692-2-8290474101058598870
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES daen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521812691; b=IiwDLC06A82SvCeEePD8JZlAyG+934RU1bNCI5A9fkR0Ym8
    K14TcWUh+AME7m3wNPoEc66ZQxHRfhBzavCnP0OWbQmIR3sM0yw1h3tX6yOo/xsT
    JlkqW2yGHSPZyDzKWV2abwy+OIjZ6dpPdEScXywRTofn4XtmFUXBWP2s41v7Az4U
    HhLcWbxwGXsvxYHNHJPcv6nI+yp2HClbe0ujhgXLfnAfDJRJHNesozenozCtEU9r
    qiFXY19EFjO9FjyzjAiKC37kqly+HAdYesmFyACFmFw5WyziHudjFBNJswf7XV/M
    oqSvND3N6WZoMgnoPd/Hi2hAqAIaSKZhoScCXlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521812691; bh=E
    /Tah2z1LGcDsIndgluGNFrWV7280nDwST9BDAjJd/w=; b=GGN4JGKZZPGWG+XlQ
    lOTNbWwHdiIZ25j40BFJUdzycECSKu0r895LgDZohRZySnU/p0sHZRbSofyxWy+3
    8rvRbW6KNvGDfjruBLGIqIQQPGtwCG/hnkjj3gPsrH6jjea44EKuUxHStBKYtsit
    zlowEn0lt0mvkMsozyMrgo0ULOvVnAyosBR2mK7V33lr/Q7bbMObzTjBKQR2V07H
    Ke8+k/F60H+8W4bGW8sW3ZLaPUOZ8DDDEP15DjpjMB0nrRO2mvnsc8V2JDvR+PQe
    8092vrapZhCTBWWbObjTGiPay8idFyo/HvKe6K3pLCnQ8xgAAEKZAIKB7xKLG3h5
    lh1PQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=kAlyELCc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=kAlyELCc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com;
From: Ioana Radulescu <ruxandra.radulescu@nxp.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH 8/9] staging: fsl-dpaa2/eth: Fix SGT allocation
Date: Fri, 23 Mar 2018 08:44:12 -0500
Message-Id: <20180323134413.1532-9-ruxandra.radulescu@nxp.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180323134413.1532-1-ruxandra.radulescu@nxp.com>
References: <20180323134413.1532-1-ruxandra.radulescu@nxp.com>
MIME-Version: 1.0
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: BN6PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:405:39::27) To AM5PR0402MB2690.eurprd04.prod.outlook.com
 (2603:10a6:203:97::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0db61649-4291-4eff-cc97-08d590c43856
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:AM5PR0402MB2690;
X-Microsoft-Exchange-Diagnostics: 1; AM5PR0402MB2690;
 3:yyavywCED6zdjDG5mR4jxBdKZRoXD7rzZl/XL5aYFjnCWxMF/TU2qdN+3Pgtiu9E5QmldeA8VgePDpXIIPPVGDdqUmv8EbdxqT2o0vRCO9x30eEFzuQob6bzH1l33fwSqH8xEBavPH2SAkLPFMFo4kV7FvGTPWvtG4ALaPRH15JUteLmCX18X2MXQW3foIwvc0O1MfBc3Oc8X+Drs+7kFPujbgM2XvUBSfXCdQQd02b+A1yeJ7R8jdcsVyicwi3K;
 25:AJwI1imKwj2hnMrLbNFvwxqmW14DBDStyWcBoM1BoHKXjhGIT8zoEqlbuqeIlFZWbFkjKN+NOxRQdr/qxOeZ02XrBHkrhMlLHq6I48XIhomXOFiT22nFhvO1ADl7teIoAtegFty8jf2FwURdxNmsjK4GFC8RI23F+WfDmZmEXDFyJanFsEOZCAQpLsda4OEsWUGaicZh2sVaQBLnKm4Woo/9Gini2X3v5/xKD2tGVm/WeYotQVSRTemAkNQnkLKZhMBG892fUVN9UPkHeuje6+o+KcDh3/sfRd3fTKyN2ofcfkrBa62O4hL2DGDOXB5AZOrepXmX3qw+MvKGGtWUeQ==;
 31:A5Zw1cGkBi1MRY1me8PcqYT5vcgZ1aP1zr9bGUAE+W5z+8E1BzpQJ3viA2pIG/NYbLBTOsvAnWsWfXqyo1g+naKImmRgZR8m+klIiE3oOTcrucikzubMRkys/l28wRle7uDjjemxP+L/Fk/yvHsnAR2XH/vDQhtSRG69ijYVkE2lxNcvcn6iQ8xf1/ZXCC+8t3jbCcr7IQF+gKsCEKg9nW4MGv4KztMOyIQyNrcG2pc=
X-MS-TrafficTypeDiagnostic: AM5PR0402MB2690:
X-Microsoft-Exchange-Diagnostics: 1; AM5PR0402MB2690;
 20:HXlUsYi1JbuDwptkTXt+c5zcSxc2fLYel//1dOnN26H6cYtCqvBmoF+UvIbJ7wPHNGv751U93QynZa+PTFyDrctQfbRbhk0c6c32AYeMcY0g4NIhUAdqyaNdIufcXoRtPX6Nhx2rYmQ9svVVYIKo5JV/fTOue877Xm6zxi2QIz9y7F9TUGrMzBCh5QjfnO36sUvVJL2BD8BGLHhLCgljH+R3ovIUuZK6seKEbkdci0nWkHvAfl1DtPeQ6D/m9aXPW4p8t0yjT0FLj4F36/kUHEvm9LU+d3zhfAoYR06MeJ/Y3dGPX/xrt9Y09jQ1gpxSaY9DvaV2gt9TXPSDn5I5CcPVikveD8ZmeV5auiHb48Z3g5wWlJwlzxt3udhxTKtLPuvisZiaipXW7g2mkG2xNRRzZmqhnGUl/UCviaGdzwe+ZfySMi52Fnp1BQAkeovMJtTfGXhOr0N1JXafJcjhiD2oG3NY+/f5dqBQBJzenMVOuudnppD/Yhj3OiEcuKhl;
 4:FfSB7BOERFWjpYYEwO/SvF6xdqfoeMZ5YUStGhgkQ7jdgVp8e6GrjTQk+7YMQEOFO7XYul2RrONeiZhLhIWHW8seHu7SF1ryPeTERd3IsmMNKxTxzwUz+yaM0YSS59ovWoPuWE6ByLt9PHPtuFFqmfbXUTDeSCsaSDCWjHW8y34uLBzj3C59tpu/gmJyXpxTWrUHehZJ+EtDQAmQvC3WD48lZgwgB/vc7tICA4z8z0YgrIyJsrr3IL5OZBO8cM/zMpCXSsNPP+UXLTufi009xjRnZ415nz7XXFQwk2eT+d7prVnYfGc8/dKW8liu6eD4
X-Microsoft-Antispam-PRVS: <AM5PR0402MB2690168030A26E23D6B6D59E94A80@AM5PR0402MB2690.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);
 SRVR:AM5PR0402MB2690; BCL:0; PCL:0; RULEID:; SRVR:AM5PR0402MB2690;
X-Forefront-PRVS: 0620CADDF3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(346002)(366004)(39380400002)(39860400002)(199004)(189003)(50466002)(25786009)(6512007)(6916009)(59450400001)(6666003)(7736002)(305945005)(5660300001)(386003)(6506007)(81156014)(6116002)(3846002)(8676002)(16526019)(51416003)(50226002)(1076002)(446003)(2906002)(36756003)(81166006)(76176011)(186003)(66066001)(86362001)(8936002)(52116002)(4326008)(316002)(53936002)(68736007)(47776003)(26005)(48376002)(2361001)(478600001)(6486002)(105586002)(2351001)(106356001)(97736004)(16586007)(11346002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM5PR0402MB2690; H:rhuath.am.freescale.net;
 FPR:; SPF:None; PTR:InfoNoRecords; A:1; MX:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; AM5PR0402MB2690;
 23:JUNoAZHLyPPN751sOiLZC825KhxW8rSyM2JZNoT?=
 =?us-ascii?Q?a0/zzCC9cpQI4QNf+7YPJDr/4yoa4CpWqP8JWT1rHBbLZm6iEmjrpLjYRWA5?=
 =?us-ascii?Q?uRQPmpcQBxioLj5cwnPrZi/1vMHLYpejD1/yX3RQNbx/53BV03ynA1c5c64P?=
 =?us-ascii?Q?6EWaJiy9jdMVXvaEuS15SWlnbgRDfDjZ//7z/i8D1fp6tAWAs2jh7AC3+1p9?=
 =?us-ascii?Q?E/YNw4DlhB15BGYcRmHWfOwhs5vq8b0EZYvd+aW3dW9T/Zvxwj0JwFBx9mIL?=
 =?us-ascii?Q?XFlnwq7/ptWkwT7mN3O3nJhRJuHfvmB+kUztO64xFlXqqB5krGopS9r9Tx7N?=
 =?us-ascii?Q?ChqYvWx96HF7DRhBSwZ+/YaIMys9dhs4QcyK761h3x+sZPKs0Mc/NByRKFuZ?=
 =?us-ascii?Q?2odQAyVjSERQwLF4V92uhWEWZvi0GZlSxSoD8C0POko2Elw8YrS/W0BFJWGb?=
 =?us-ascii?Q?NNrnBep9MlNh00BL9HnhVYGtPcSODYOIud72D/oOt1ahbd6eCBxBJdL4vuZm?=
 =?us-ascii?Q?jEUT60MawYQ2Jx/Et60oa0j9pF3VjMPJNi3G1S7IZb4aqjMARA4mQEQT4K/4?=
 =?us-ascii?Q?IYbtvJkD2G0F94vx5sdfuWXByKmRXd7SJNmF4NRMb2YBx4M9yR7FcSr5JHaX?=
 =?us-ascii?Q?wteEMqd/S2hhFPPtr8wjCQHHWuFmjwqufTYqFFyokvCE9NUxb82KpB6mCuWi?=
 =?us-ascii?Q?2OIQosMQ4DurwjX6Xn3TkyX9PNay2Paw9z1Cw1frtD9XbW7xmhe4ikGjZT+Y?=
 =?us-ascii?Q?FTh8rpNq+ATM/Af2DIxjR8059QST6dWtJxJHIgF8ysSVUMzr2Bg7N6X1iXpl?=
 =?us-ascii?Q?2InnRg8dbxKc6o9zbmEZccIvJJzZKJhEcKMVoWskWMBs1UN3SCWmiZTvLBno?=
 =?us-ascii?Q?N0JCeeiLxPZdkS7YMOVPHiy3qM3aqBXIapYSC6eg2+PyV9gcekD5MAKiBVX1?=
 =?us-ascii?Q?SPwV/HTLsBT5orxxALrwzRpQ2+7qlk1tcE6q4YwEgifFYCA7yv0xO7XmzyZH?=
 =?us-ascii?Q?FdgfBr4q0afhVyGao+embWPsgJHRkwblyXvrMAJTXANlnNmU/1Eu8yyq0BDi?=
 =?us-ascii?Q?M8VyzqQX3OnzfHmIjeLxwT+oezMQmv/e7+Pn6Ik3T+0l0Qa1iv47HR4I/Oxv?=
 =?us-ascii?Q?FfvRyGgyEtA0t4hln6B1HFMjasEwOrxesQNG/YVgXWeRQOuGgu+5OXvuFmKE?=
 =?us-ascii?Q?cyBylu8DqtG8HC1k=3D?=
X-Microsoft-Antispam-Message-Info: E2+pmHZ3tKDlrrgXg1Sl5vhNtx3aBHEFir1YpOFUGnFIfVeoWs1OjwzkGxKcQkdWonZxSNYeHqw3cqo4CROG4NBWnkNzotqw4A0uR6uLl1lPv/IWYJtd7w+kCG+k4CmazCl2xl2JWqx0DD6mxIoU+EEsc8WaG8u8vM0H0eOoSABKQb4YhIki+0ouaYYtu5c/
X-Microsoft-Exchange-Diagnostics: 1; AM5PR0402MB2690;
 6:O+ZTwzZNQJfCXSr8wQ22Y+otWQmkY+LKa5zDvqyepoXhw+bTxR44Cc59axLwHAUBWWFBbIzk14eT6CPIrwWuwywmo+Pq6a1bABp0yHuh99WRMcOcOAYldvFtHL08VtuPLeHe+L4DLFi26SDaeFBkR8O2Kmg9KwxCIIwMgLq7HgODYQ2aQuYCuziihFvqFNJDrflVswcc4YJ2dTDFIbBt0poKDpMnvd4kW2CflBVh1lULaRn0NUg4w+hVcoMACCCKYEyW9fdzNGsAk831LFTG8sGnfX9/dp6T1v2X+vWgun9ApoGCLhoGeuQLTw0wUMKQSL4XwOAf9Np5xqyhoQwCUUYLFcOTOAtd9KzUJWfUnMHRkpLT6Tag3v8nz41wkncoPCT+1n+HfG3BVASlYsDndbvizrJ0BZaC7wmmLIOZBpgke2bQ2LhbCW4k97JtjWc7Kj625ssub+pIn9Acelzyhw==;
 5:fV7oAr8DnsSN8diqz5nOUCdhJNoE5TYpG/n9z+pGnKnhDj653mUQgyyXv3kPmVJxRWmtsaS4bAmhfHBZ5Nm1CixSOgnXNSz0cw+aXuT+sJt92vZ108NEoy5KHuQ3FCPNcs6UrCCsULrqkf1lq3bBY/RqPktgUFS1DrpJOBuitoY=;
 24:yuFZu0gXe+sQIB/z0eL61DO4sCafkP/paYqXBPfZNyOBjBJEgolkI3T/yYsgc1OU/99AjS/VPz856N07aD/kLJGld8Ogvx4LlBXMDNg3I/4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1; AM5PR0402MB2690;
 7:GEV2pi36y1vDptrP6UQcg54ECo2Hv20EcFZSgC/RQ/kQOoyzpp8PS14euRs+kTGYjD3CqNqe3rubD+HsxSK0T4Qt+PrYC8CXkj8GaIL8fbR1xFGTef9YqkKAJ22bIng9PYhcFt6/qDC2dJTUh9O1SQP2GVH5X/S+KY1o5r2akQdLImE8L/PLUmtdB3y17k7+bp4LWFbppXhLqRbYwVz1ucH/ezACDAGsjnDz9BsE/2T4sUUZfuU4Nvo1ihxtEokA
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 13:44:36.6697 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db61649-4291-4eff-cc97-08d590c43856
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2690
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
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We mistakenly allocate space for too many entries in the
scatter-gather table of multi buffer egress frames.

While it doesn't have a negative impact from a functional
point of view, it wastes resources so fix it.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
index 9994922..14bd8fe 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
@@ -373,7 +373,7 @@ static int build_sg_fd(struct dpaa2_eth_priv *priv,
 
 	/* Prepare the HW SGT structure */
 	sgt_buf_size = priv->tx_data_offset +
-		       sizeof(struct dpaa2_sg_entry) * (1 + num_dma_bufs);
+		       sizeof(struct dpaa2_sg_entry) *  num_dma_bufs;
 	sgt_buf = netdev_alloc_frag(sgt_buf_size + DPAA2_ETH_TX_BUF_ALIGN);
 	if (unlikely(!sgt_buf)) {
 		err = -ENOMEM;
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
