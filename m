Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520121297-2-13253674411632716298
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
    t=1520121297; b=lTj0V6dh9+xkYFqGzf9vE8JWdf/i10n5Ekbd0O2x5DcsReX
    fzHgF2VRdYKkMKCkKXnApW3pWsO8Lt67MG6y2CetibA73MokNZKyb5xbCN1f0FCN
    PMIqPxTiZHy8Dld0gqfz6xJhqObegI+zbxH+TOGSZHXCPtWN9nlZGfv1PzfsW+mQ
    76jWLS+ACUDW7Zs1lQWhX/gUn+bYYqNs2S/YwslyaM+8O/0YCK5rCSjrjT+3aUU3
    JPbveV9FMtasmQO4NMch/CN+O560DkcJCUx+wBQk4OhELI9lLWfI0axg+uXHhhoE
    IpERRrx3Kn6+6dbXChdl3pFwOXotKvuFUvVb7kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121297; bh=q+xcTD
    GfsfzSu8eFBcfIH/f45J4pY80CRSmZx8tgaW4=; b=s/fEyRJtqTGkRK6rhb6cU5
    qqMFUALIDoLO0ryEo65ZFLsqWn5Mr6bCLm1iEkjsoxhs1PEdSl1jN7rUrcuyWRa3
    KDvPW30HCyHv37ZOCWNW1O/TTyc0pme7brwG9wdfhUVAxUZbbMKQFPbeU3TBZjJt
    kmZlHXIRrG/zyO/GQIp/TX90TCkjVsUXq1j4gE77eGo4zxBuk2F9BlUmhQz197Li
    4sHmuK+tQUm+Fi6J6AFmN6ZujKHvIZdS1Er2L4WeA+wW5+Ylk81FRwcZCPb2stRJ
    H0s+WWnu2hPbq3v0cslE0RsGUS389ayV3czZSluFVU8ARD7RDCIz0b0AIiccYXSg
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hGsYJMDE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hGsYJMDE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752279AbeCCXyV (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:54:21 -0500
Received: from mail-cys01nam02on0126.outbound.protection.outlook.com ([104.47.37.126]:47215
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933518AbeCCWc5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:32:57 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jiada Wang <jiada_wang@mentor.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 067/219] dmaengine: imx-sdma: add 1ms delay to
 ensure SDMA channel is stopped
Thread-Topic: [PATCH AUTOSEL for 4.9 067/219] dmaengine: imx-sdma: add 1ms
 delay to ensure SDMA channel is stopped
Thread-Index: AQHTsz73PIYhn7ZVWE2wo9GxKLY0uQ==
Date: Sat, 3 Mar 2018 22:28:35 +0000
Message-ID: <20180303222716.26640-67-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1098;7:QCwyACAmJ9Kq6u3ZjaNWUCdNFWKpVbTepv+CEP6JyaKcDEqC9ex4B3YYRG4lSTiepEC/ehFoFQm+2ecjHrD1oXUitmENNaeYhVWfaQhcFgn9peXxpVyQz4qfF3Z8J0UJbf+GBx15knqPJ+wU3wJtihWOCrziOaVC5g1F7dM8SJrZzGjtgysv4ELfkh69yR+mGaNS4Jx3JCTMEDcM4PKmwOzj2rOypHlpUiYHPFFwfzPZxmiEMoLwlRWvX+e7+wo+
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: faff538d-1469-48ad-6a17-08d58156b391
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1098;
x-ms-traffictypediagnostic: MW2PR2101MB1098:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1098FCAC9A230F09B9D3090EFBC40@MW2PR2101MB1098.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1098;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1098;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(39380400002)(366004)(396003)(346002)(199004)(189003)(2906002)(8936002)(36756003)(6512007)(81156014)(10290500003)(81166006)(99286004)(6436002)(68736007)(478600001)(3846002)(22452003)(53936002)(8676002)(110136005)(54906003)(4326008)(316002)(76176011)(6116002)(7736002)(105586002)(305945005)(3660700001)(1076002)(14454004)(97736004)(25786009)(186003)(72206003)(26005)(102836004)(86362001)(6666003)(2501003)(3280700002)(6506007)(5660300001)(10090500001)(59450400001)(66066001)(106356001)(5250100002)(2900100001)(2950100002)(86612001)(6486002)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1098;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: sUnrRME66qLHn5VdwWkdbJn/AU/0IaxOTQFomxxFbumm/6lmORUGc1XLiYG+32UN4whTa8b63wRqrSeaKYDrGmPRBvlbcLR/gv58oOMcStbo37nn+F46JRTTlF2xmve8MyRCkwzG8hyZq4M9JReDDQ0yLpwHtxPJCSUwgn75bsA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faff538d-1469-48ad-6a17-08d58156b391
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:35.0569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1098
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
index d1651a50c349..21726a270fc4 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -937,6 +937,21 @@ static int sdma_disable_channel(struct dma_chan *chan)
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
@@ -1828,7 +1843,7 @@ static int sdma_probe(struct platform_device *pdev)
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
