Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1378361-1521812685-2-7616559353497911941
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521812684; b=alkWdstwPCgchaIWhLABEoIJUzCqLFm8Fc85aIBo1Fp6bpf
    waXvIx28P87ov9ADNTROpQjvic/6cat/G3Bxuxu2ILWNq+BMezQD5y5IY3Rxtyno
    t98FW+LTtpOSdWfImdrGQ6jFd0lNRBaYy9oHxKttItJeX/dpdZ5LoHi/3iO8wTD9
    sQXscZHefDZvM7kIdAbDmQQ6P2pb0SBtkFtJRa0xrAd0H05cIz3pEYXGQocluB5t
    PbqmCuV4BgjCsvJjO5ldxlJZKMvPiMGqOBdyx8cyXsRHE2NddjGx0ReF0SaJZXvH
    /1LWh507kT7nbWIrXwK4BspF0tIXUwHE0vI46IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521812684; bh=t
    ykdLhYPzjDHllxVS//fJbXuC2bRRmX9yF/tCT5scP0=; b=tqT8tz2hTLVs8l7JO
    il3GyP1PPUUdi7fEJCObBY14aKVq5rhESLO0vSbXaDaUyqDKquzdrX67Q3pi2BK7
    Gfjc2Q1J0Q8sx20uR4T+GEBVZasfZwu9PtJmzvFz4wYlFhi2UQmL/6gFg/cq9vqS
    a0CwMgUNqZVBJmnWkk4XmeJEGWSU82mnaLhyQjAre6kp/m6jO9k5vhAaHtPqteH2
    gHU3ynSi+qZn0MQanbWjNMz4bIEOpOrb7jl3zeLY9tUux7K1A4eM43KlWY8KR9hu
    dBRU1nu1Lwq+kZipvyOcA9W8ounPvTZcPH2TOACKIHkUUmC3aOCQjCoCA8OZk5mk
    RTo5Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=wgwRKWSO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=wgwRKWSO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
Subject: [PATCH 1/9] staging: fsl-dpaa2/eth: Use generic irq handler
Date: Fri, 23 Mar 2018 08:44:05 -0500
Message-Id: <20180323134413.1532-2-ruxandra.radulescu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: a3fe1ddb-ca04-41cf-e13c-08d590c432b9
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:AM5PR0402MB2690;
X-Microsoft-Exchange-Diagnostics: 1; AM5PR0402MB2690;
 3:9LbIu1WgdXryav4lAStN1M1afLrjZYvr3DEmF2uCJbYAmth8PsJ+5bhInL3FyppUTfXyzcsFkA/gdETKWdS2KtADwqN3GcD7JunEBAFu6aH1fUNbsdcjFd1aWQ3UGwxx3qOlHuNji8aDeAJAbNsM5PUZ9dU3nI1i7BaKmKA+2m7gD0qf4Gqf3xn+nnOhLVRUVFFHn/sSXXptVuYVvFfm/VzZFa9Fh4N4jAAuYqCoxiDEAtv0xC/3ElikYh+2mHb0;
 25:ea+dURy60X5aoJaN1WfTbOy7eRWRCYoCB7fhXX/t6o4CRL/Nm/uqDEyQ5rzFKf3ErKg+4eYqQc3u65iYXLxC9MX6cApxwlvz+Wp88av0TEuM8xiV8k5ejoHXUaTo6uRQsXsGYD3trlarJfMkBcb+K5rw959STO7ISuGbkLR+1VdfrZWPZiRPHuWH4jaEDTjLwYNDHCKR0Afy7sk96Kv8D1xKj9uq4h1BtVMZgLpI9dWvUU9fF8wkXG6STDKLD7hsxZgLE+sEYSzwGhzcgdI7v3HrgIGHGstYaZD60DfEXacWjVUZaVdHs/jrgRvJGwGViEFBnk7mG28hzhPgseT0mw==;
 31:CluNRl4XdDW+3iZ0bslI9psEXvWf9Xco7kk2+6lL/felZdM/LiPWwTe7pu+nwFIKDlvOZZ4aj98+Cj2njBsbwHlBdcSbn8h5FAN5BRgmrZdBp5LAIBs1ptVbqQlBW+a7Rs3mnEcftPFS69qbrc2PoRrnW/Fk6Fgn73MeR9/Sp/pJ7/u3Dnuw2nVHeBEEWtRqtM1uIhDOmqA9NZEEpMeg6+AzyDfEQGE9MVOAWnbFlBE=
X-MS-TrafficTypeDiagnostic: AM5PR0402MB2690:
X-Microsoft-Exchange-Diagnostics: 1; AM5PR0402MB2690;
 20:s8KBCKOh2OJJUO+ZTgCyL2U3li4dlyCScEEea3px1Qa1fjVRoiCFpKnIcu71YPZKXcJlwohp3f+aJXki1vtTjMuUoBnqqFu5ZvmtZU2hR+EUhGmH+Jfg6T4IZYLQuJA3KHtmPib/rXY5z53eVxgPLxMktYZvCW6HbtDYx7rj1cqZL0dIg3r7ys050oD4o/GqH2vMW9tFhZoFJgi3JAYGvYLmWoY6nU4MjbfxVCcwvLZ8/0i1beJp0FR9HSXX0VEGbrrjnkWFHdsOYe3UUzbFTAcPlHkoa/tVwvOqCgXA90XDN8pWde3VJIDk3+INoi38gvjjvD848cLVpIiVldVOaPZDb/q+cBOnirl2CnOrWSITZ9/3MerV1+wpnbXqwChng1mH5iQj9boniPOuwsI+3WOUxdeC19L0Xxz5LFaUeaMAFcRDkMO35imsGYcMTEik9/VgF5GR3G6z7oyPDgdoPfghhybKnoLCsF+a84he0Qmz9T01OhogNajmbWsJHBRk;
 4:HIj6XUtZ45NAG3di2P8xC9dI88agD4sHY1UeDWGkeehUHIbKyRl05MlcyMQayA57Yd8vawytHym8BrRoQ/Wk8g+FxROmYXw8s536rL49+TUOjbTjfOXX/gh1GTQTCjkNMjmkysJ7DTBlVcYwP4TACffMGciexLW7Bs1L1F0qaxJ2ycIT/B2a/7BFCPERtnEWXdL5Jnz5P9r5wjFjTOIJ/zNzkWZPPIYpHTUC0qrrWWa/Jua844X2JtQowmWEDWeG69qbmbQM9JpSEGpFpLZ7tGbRrMnek8sfXPx3Pev09NNBD6EDlpHRozkL+/3KN3rR
X-Microsoft-Antispam-PRVS: <AM5PR0402MB2690FF634CB94FF5E5ECD7C094A80@AM5PR0402MB2690.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);
 SRVR:AM5PR0402MB2690; BCL:0; PCL:0; RULEID:; SRVR:AM5PR0402MB2690;
X-Forefront-PRVS: 0620CADDF3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(346002)(366004)(39380400002)(39860400002)(199004)(189003)(50466002)(25786009)(6512007)(6916009)(59450400001)(6666003)(7736002)(305945005)(5660300001)(386003)(6506007)(81156014)(6116002)(3846002)(8676002)(16526019)(51416003)(50226002)(1076002)(446003)(2906002)(36756003)(81166006)(76176011)(186003)(66066001)(86362001)(8936002)(52116002)(4326008)(316002)(53936002)(68736007)(47776003)(26005)(48376002)(2361001)(478600001)(6486002)(105586002)(2351001)(106356001)(97736004)(16586007)(11346002)(41533002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM5PR0402MB2690; H:rhuath.am.freescale.net;
 FPR:; SPF:None; PTR:InfoNoRecords; A:1; MX:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; AM5PR0402MB2690;
 23:BJkYVjq9ZULHeyezIHxRhI383LN0MvrXWVyAiHg?=
 =?us-ascii?Q?ApIZ2P4HndK7iZF7VVOWDviWRG+Efn9pAmdfBDCGPD49eGNglXqVY6QJWq7T?=
 =?us-ascii?Q?z13La//PXmIlzmfAQCBH2ETzUyW7dLUM9G7RoTEY8/Ml6MDnctZRz3kzJzn8?=
 =?us-ascii?Q?Dr2TKqj+sHQ6sCc+uIYP15P5+OijyQB+opdBgshoGIoM/ysJijnJ6gvoBWwq?=
 =?us-ascii?Q?HT+yw7ZjSLf3/scIhmKWY/CMuZOWGYAmERkxWmaGZgsEb98OE6kD8UQFWA6I?=
 =?us-ascii?Q?xO2eC3Vl4Iy/4FG3jPOM6oE8zrZ0mzRXdyFhq+a+x5yG+SV22pHJIeoLjQmp?=
 =?us-ascii?Q?V7QxZsSQvFD8snuyyFK3xtGuO66xeh1MKMSHQ4rg8MqXAZCYoOwovLSrCIts?=
 =?us-ascii?Q?+Kr1Bebr2zpLmwJ4OTos3bliwPury3BmL2FbzwkmGJaWf82lOJ+JFGCrQouw?=
 =?us-ascii?Q?+y7fbBlOqduEHsELbZJF/hopwGLD1KJz+0/qcfXckLCIl005sj/dpDCylozq?=
 =?us-ascii?Q?8AeWaUktxNAt1WINL3hr+KUx18Lae2n/fdNwIdlvG+l+6GrxupVw5e3Xw/kz?=
 =?us-ascii?Q?4UvhBb/q0I8WobBHXFGW3rVMBR6pTCOkcobNDB1XxNXPZ3QE68lsCEF1A5Dh?=
 =?us-ascii?Q?bqDngzO+5MWXmpHvhzMchvzog9lB+Mu5As9VfTYi6VHXK/5L0bJSpHS9mX53?=
 =?us-ascii?Q?Nzdm2lKwPu2sOaE4WTGZyKYiGciL236sgxcRCkNakBPJjj66I28tMLNMc0Lc?=
 =?us-ascii?Q?h/lWAvnUR1ENKTxWLDWEtcppGxB396/2//C3m4iT7mIjMqbSH76JTJn0UqUo?=
 =?us-ascii?Q?fZgpQx/Se3oLc+jR+cQnX3WdTk8vd21OOEO+2gOeTDokBc3MY6iyatekZUv8?=
 =?us-ascii?Q?rDciai2bL7qRnOAJ35NT2yXA7MeCKGJLyhfA9UYO8OGsKOfiTH2G4MHwC4PR?=
 =?us-ascii?Q?d8t496IcAK7cuNTv0nBjYIN2ie2u5ISzQtdUOTCldWyUCjMdOYgk+9ND8wl5?=
 =?us-ascii?Q?iKRqYT+fXebtohzCoHfZqkD/8M6YvyjwChD0sCjgN6NOlppC/WiDYCAylkjx?=
 =?us-ascii?Q?dqL4RP3y+nUEHdKZaibv2Y8kqtXK4vb0dOEjDsbrZEqaDoc9gfx376WMK1hP?=
 =?us-ascii?Q?hkHIGoGLUhcoSrLAnnOhsznvM+SBG4fXcNxYOTCc4qIMquAzWXsWxN07aDQF?=
 =?us-ascii?Q?iegg135QKS4goHlzcih2q/W8zBbYX62zNfYea?=
X-Microsoft-Antispam-Message-Info: spM4W+C4vkJ0i09FOOlbphZAqoaAfZIu18UVlLMx5LQIJU2/+VB9LtujKQLNE8lnW+/nCkwviK4ydcxf65fPvI/vTZDj9QMa5lNRTQC7sdW3cJvnUxBDYKlT9QvW3k+G1s7aMGtv7OeHjNw/+qCEjIq+DSoQBYfu7lX4zJJLdWq5sus1oOT4WRNGmxtva6df
X-Microsoft-Exchange-Diagnostics: 1; AM5PR0402MB2690;
 6:SPYCFGYzAm4f8dv0Z2hGrl0fG7wr1WqiQnJu4HLzetyc9ZgdwQL3dntECf0M9YcSHn0JcJpRBxMH/bmoPUa4WusLUxWDUTQsRyqtcGY8zaLHs9vwg230uCVaKrJlLiBoNYnlTrTmdpJYJmyoXBUTFwoIf6Q56fQRw2xOSxqcoXCUiwpZhOe0/65m/1DsvW/HZYVTX+iKd4Zt3s1CF9HMpoTwaCvWQQv6Ldpwpj6uWck5IbVtsFssY9PnAUYJAtgNOzkfNgWUK4NwSiKlSR1xGEjP0hipQkqnyWeD+akPFHcetcmCI1yVK2jlR1Y07RPBPOtTal0FM3PMJTaGAdbgUsE1heWKF7FXhoLNC0mH54d4Y0+U+1DXfIi0QvFV5kh9oxt6i70bXX3r2noPzo8XclARLmJMFEvnsV5yWJjXsWQhkT9+fzU02Mtlo+IOHlCqUc+NGj8VDY9AMlX8FdiopA==;
 5:evBgRfWjwc9Ul+xD2mME5RnkwR2PT1RWbvHwA1W3p9Iy2LJ+Po9S0dQQYTW6ZtMWDNX74Ep4i2htbxgynNEngNBuRg27YApVParO5bKPccWsb4aFGSpYO1CZbtljzQfe52FJiBYB7o3QrgFFN4U/Relg23M54ki4F7+bkc9d3U8=;
 24:OvqiV7KF1i9yzUmegAAAnPAWG+67xnTAzU+zg/HWkm7iLFZIVyE21cit2PZYSwaVciJ2Zf8GEZ7x+p/BeThxhF+bgk9Gc3Zuqx2xjXiq2e0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1; AM5PR0402MB2690;
 7:tsCqXwRscbPo7mv5sTr1aJ9afhBxkNdOl4fAQBwpf+2LZ2KNPGVjjSLI8CS0eoIMubOdsnmlNyrgu+LYppoxDTY6HrSa1fb0rLo5BzgRj6lyYL1kXJSMovMKVN2TnQ56nq3AsXkUqtCtX/Gjvfn5VEjYcXr4FUoJ9IjVGwBYKIyw3Sr0t1ezXtOWSiSa1m+1kf3R2Jzr4jhN0p4tSjic8Zm3J+Uw0QOhcOK1vRXxVkBcqrrnv/jSsSr3CHOhJtoX
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 13:44:27.2527 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3fe1ddb-ca04-41cf-e13c-08d590c432b9
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

For the link state interrupt, we used a dummy non-threaded
irq handler, which had the same implementation as the generic
irq_default_primary_handler() function.

Give up on using our own irq handler and let the kernel use
the generic one instead.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
index ac1a750..beb5959 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
@@ -2317,11 +2317,6 @@ static int poll_link_state(void *arg)
 	return 0;
 }
 
-static irqreturn_t dpni_irq0_handler(int irq_num, void *arg)
-{
-	return IRQ_WAKE_THREAD;
-}
-
 static irqreturn_t dpni_irq0_handler_thread(int irq_num, void *arg)
 {
 	u32 status = ~0;
@@ -2356,8 +2351,7 @@ static int setup_irqs(struct fsl_mc_device *ls_dev)
 
 	irq = ls_dev->irqs[0];
 	err = devm_request_threaded_irq(&ls_dev->dev, irq->msi_desc->irq,
-					dpni_irq0_handler,
-					dpni_irq0_handler_thread,
+					NULL, dpni_irq0_handler_thread,
 					IRQF_NO_SUSPEND | IRQF_ONESHOT,
 					dev_name(&ls_dev->dev), &ls_dev->dev);
 	if (err < 0) {
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
