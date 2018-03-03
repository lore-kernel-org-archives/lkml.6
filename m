Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1204544-1520118830-2-16155622448127068048
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520118829; b=CMqFk6Ycm1xIILCG6L2bqxRHP+yMo00gd4adsIixJnW2hmO
    A1QYecfsCUn9wRaPZ2J7FI9Vh0YWLOmh/CkSwcjfuAfhBlGhi0hvVqj90pFxLZz2
    455qA8SgwaykAJYukP0Wd3iv6oGdiCu5bGtuZL4Hk7eX1mKyPj39q1NYn8p8SmOp
    nXJCaIACZ7c6BNdoSUGlPF2w3gY/jCBbEYZGcl+qCc8Vgxmt/PITREq5toVPqIAG
    fCZ8S3I3fzSk7lh48TRNFu9qC7Z778rs40w2cPE7q8LbJtxnahVRl0ZSPdw/h8xd
    06532UnrQSK0EuY2ZQ8SjCqJ7IZZm0Qs4FAeFBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118829; bh=yVjjti
    WKWqy3obQLuTNG71Kkl88vrfeNYNa3D5P2KC8=; b=BTdL/mMC/WKQQoBb8+lj4n
    os0ocTfideNXNXRqueDuHsFL0fvWpdsEnMPxr9oi4wpnx9ZMoQSemtgkx0SRy3NR
    LPt2rO8g8f9NRJOPqoostCtClohdCLED7How4WSVw2JSrkcEVy2W3ac+kgsr2Bfy
    xlLJs2wOSb0TGPclCEYOZa4KwQUCsbl/7XLyXIS0Lwzgr/7S/T/DipVqKWsDgrKp
    I0DTA7eKga5Wi9blPeFYBFufYW7hplbCuEuwTGFzNtejE+xNR7Sw5bE9lpFDGU3a
    w9CHVdaBy86j/WIxse9HtrDtNd+ek/v0UMl/KPQ/7P5e+8SxRLP7uNDeY9/emD9w
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=megSsTKE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=megSsTKE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935020AbeCCWjJ (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:39:09 -0500
Received: from mail-by2nam01on0114.outbound.protection.outlook.com ([104.47.34.114]:65056
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934197AbeCCWjF (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:39:05 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jiada Wang <jiada_wang@mentor.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 034/115] dmaengine: imx-sdma: add 1ms delay to
 ensure SDMA channel is stopped
Thread-Topic: [PATCH AUTOSEL for 4.4 034/115] dmaengine: imx-sdma: add 1ms
 delay to ensure SDMA channel is stopped
Thread-Index: AQHTsz9TOm0n6iIbGUKC+14bBirp9g==
Date: Sat, 3 Mar 2018 22:31:08 +0000
Message-ID: <20180303223010.27106-34-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0938;7:qI9FdGlvv+Of7cCS7N8Z1Cb06ORJYKbaLupZkAubWGA83gnHTAZ+04LOsKo9MJPVvfFXfhbMjW65xPbAOzeW43GN0MJ5nbvO7+5gx9+tOR62vSS8DcjP3XWOb1pUKkydtPaIj8F8lMJ74q/3DpBQ21fUP91HrX6azSnDYk/tQ8pJI24u8SBZJZ4NvpXmXJrPeFL6KF0txFEtq3qwKJjvejk68Z4b4JtkNwJWRo6Xp0IKC52cCQR3gsyEFwY5bFVq
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 744ff752-ff81-4fee-86e5-08d5815784a0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0938;
x-ms-traffictypediagnostic: MW2PR2101MB0938:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB093845691B0DCE394C4079D1FBC40@MW2PR2101MB0938.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231220)(944501244)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0938;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0938;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(396003)(346002)(376002)(199004)(189003)(54906003)(4326008)(72206003)(22452003)(478600001)(25786009)(66066001)(6436002)(6512007)(14454004)(53936002)(2906002)(6486002)(105586002)(99286004)(10290500003)(3846002)(106356001)(6116002)(305945005)(5660300001)(110136005)(1076002)(36756003)(316002)(2900100001)(2501003)(5250100002)(10090500001)(59450400001)(102836004)(68736007)(2950100002)(26005)(97736004)(186003)(6506007)(8676002)(107886003)(3660700001)(6666003)(7736002)(86362001)(81166006)(86612001)(81156014)(76176011)(8936002)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0938;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: LSscY1DIj61dWkSuf1P0lx0cQbH9hQJbiCHkMSC9F3HVDzEAdYT24+V5zOQNq6sj80I1PbjzAKRh+T4OPCAhBs4UgP8sSSQZg2r0II5SjbobJvq1CMNo9oqmCm7vbEmN2TpYlPPGogWX/1+afth1wRst5jLMIXJhOxP/SwPKq5k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 744ff752-ff81-4fee-86e5-08d5815784a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:08.5884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0938
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jiada Wang <jiada_wang@mentor.com>

[ Upstream commit 7f3ff14b7eb1ffad132117f08a1973b48e653d43 ]

sdma_disable_channel() cannot ensure dma is stopped to access
module's FIFOs. There is chance SDMA core is running and accessing
BD when disable of corresponding channel, this may cause sometimes
even after call of .sdma_disable_channel(), SDMA core still be
running and accessing module's FIFOs.

According to NXP R&D team a delay of one BD SDMA cost time (maximum
is 1ms) should be added after disable of the channel bit, to ensure
SDMA core has really been stopped after SDMA clients call
.device_terminate_all.

This patch introduces adds a new function sdma_disable_channel_with_delay()
which simply adds 1ms delay after call sdma_disable_channel(),
and set it as .device_terminate_all.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/dma/imx-sdma.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 0f6fd42f55ca..f8d740a6740d 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -911,6 +911,21 @@ static int sdma_disable_channel(struct dma_chan *chan)
 	return 0;
 }
=20
+static int sdma_disable_channel_with_delay(struct dma_chan *chan)
+{
+	sdma_disable_channel(chan);
+
+	/*
+	 * According to NXP R&D team a delay of one BD SDMA cost time
+	 * (maximum is 1ms) should be added after disable of the channel
+	 * bit, to ensure SDMA core has really been stopped after SDMA
+	 * clients call .device_terminate_all.
+	 */
+	mdelay(1);
+
+	return 0;
+}
+
 static void sdma_set_watermarklevel_for_p2p(struct sdma_channel *sdmac)
 {
 	struct sdma_engine *sdma =3D sdmac->sdma;
@@ -1793,7 +1808,7 @@ static int sdma_probe(struct platform_device *pdev)
 	sdma->dma_device.device_prep_slave_sg =3D sdma_prep_slave_sg;
 	sdma->dma_device.device_prep_dma_cyclic =3D sdma_prep_dma_cyclic;
 	sdma->dma_device.device_config =3D sdma_config;
-	sdma->dma_device.device_terminate_all =3D sdma_disable_channel;
+	sdma->dma_device.device_terminate_all =3D sdma_disable_channel_with_delay=
;
 	sdma->dma_device.src_addr_widths =3D BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
 	sdma->dma_device.dst_addr_widths =3D BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
 	sdma->dma_device.directions =3D BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV)=
;
--=20
2.14.1
