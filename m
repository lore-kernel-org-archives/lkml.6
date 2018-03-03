Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1379734-1520124510-2-13846366346049788903
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520124510; b=dzIhgf4k/0ZVhnPYBRddESvGv/QRW3jOFIU4lkQA7mL0bIv
    m+Cn6IFg4EPSVHA6OaekYDF/kmiBbaAFVVKaWwREDwwbSM/dy15+5VwhxXl1Bqj9
    I5oM9N7lYrQYI9tUD5pMhtTgpYs4sEvAkPsCWPg09Y22alo2JJSmQ9fhmIBWWnGJ
    QV6LFHllYdXyZo5WJwFydbxrJHzXywICipwV9cq3Budkh92MV07KczuVy0sbvgeR
    gNPqrEmas/19ZvjZN+23+hUIGbvbTPHQNnue64OLLo7JeSmHYxkCsiN1eQNTChTz
    faoo0ew9RvzTVq/KbfQXS3clUV6jIBlKkemMj2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520124510; bh=3RAykH
    cCHUMbQR0Ka2QzpcCgVDFz84GL1YB7M2CDos0=; b=fv3jWt6qA18LZhmzUs3QFn
    vt3XAXqC52xTqFxBlOJv1P19T56zpOV7pFoS6HeVowTEXuSUiVjOEOwWvXVKEjES
    9QtiuCG4x3znppAoXYL6HO07fSWO5m8ZPNKr8bY06H+8gyw4FN9DPu0F5trGyCB2
    LTrn8gVrscQrlrndyGwruzSX0KExhr88nP3IrUqD/rKZqSZBhQ9fxo43V4YPZYYD
    3ZVccZ06PTruS2aaLRQ4E17JJHmH/irPKAoIpg1hyvFw088YIPSkT0diyx23Hvwy
    2l9bhW0M/n7gzB3iczhgRtNJQBDRpfWjNh9uP+sI/mu6oqVfYSlNtAftG8i39LFA
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=G0uwvP53 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=G0uwvP53 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932193AbeCCWYs (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:24:48 -0500
Received: from mail-bn3nam01on0131.outbound.protection.outlook.com ([104.47.33.131]:61181
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932242AbeCCWYZ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:24:25 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Yixun Lan <yixun.lan@amlogic.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 012/102] clk: meson: gxbb: fix wrong clock
 for SARADC/SANA
Thread-Topic: [PATCH AUTOSEL for 4.15 012/102] clk: meson: gxbb: fix wrong
 clock for SARADC/SANA
Thread-Index: AQHTsz5d7kRpzB5QNkmgB/aUVsyilg==
Date: Sat, 3 Mar 2018 22:24:15 +0000
Message-ID: <20180303222318.26006-12-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0890;7:P0js2uQquprBuXhAb/dzTYI1OMdQo7PVChytvMwDSjubiIMNc++CdWpswRGNjy8Bw65zkj8e+AVcuHQTv0jy3MiK9Y+rC2VgrmsRIsAaG9KrpqU5tLqFYbu5QJbFKgvgdRU/vW7Yk6Qri6N3IPaj7MucoPonWAJiOdrPUX5iv+qx0IowJfOx21LthidJ2IpWedpbSlIzlefJ6wa46m/OieIbIu2/+qPS6QYCtpjX0Dq8bT+WNNOmRDZaA2VBLYMF
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7d286e4c-7c7d-4d93-951f-08d581558298
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0890;
x-ms-traffictypediagnostic: MW2PR2101MB0890:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0890E4752F47743E2E7F8AC6FBC40@MW2PR2101MB0890.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB0890;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0890;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(346002)(376002)(396003)(39860400002)(199004)(189003)(575784001)(86362001)(105586002)(1076002)(14454004)(8936002)(6436002)(66066001)(6506007)(2906002)(99286004)(53936002)(6512007)(25786009)(97736004)(76176011)(6116002)(6486002)(3846002)(4326008)(86612001)(186003)(3280700002)(2501003)(316002)(22452003)(72206003)(5660300001)(2950100002)(8676002)(81156014)(102836004)(81166006)(6666003)(68736007)(107886003)(305945005)(478600001)(54906003)(10090500001)(7736002)(10290500003)(106356001)(110136005)(36756003)(2900100001)(3660700001)(5250100002)(26005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0890;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: jWAKzVYSNhNBcfZu6RcgirgyFcGmSyPYv/p+ax1OvkwljP24Im465/+Rnt9qCzJStCSuyMDLAvsmB7jtCtIrquiCIwyVjDtbibFaop4euMckXex+BGoHiLatfbSFCemJQPoLc+1c/gNv15sDBGUsgUnmJFa790GWyVxjC0e/OXE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d286e4c-7c7d-4d93-951f-08d581558298
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:15.9471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0890
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Yixun Lan <yixun.lan@amlogic.com>

[ Upstream commit 75eccf5ed83250c0aeaeeb76f7288254ac0a87b4 ]

According to the datasheet, in Meson-GXBB/GXL series,
The clock gate bit for SARADC is HHI_GCLK_MPEG2 bit[22],
while clock gate bit for SANA is HHI_GCLK_MPEG0 bit[10].

Test passed at gxl-s905x-p212 board.

The following published datasheets are wrong and should be updated
[1] GXBB v1.1.4
[2] GXL v0.3_20170314

Fixes: 738f66d3211d ("clk: gxbb: add AmLogic GXBB clk controller driver")
Tested-by: Xingyu Chen <xingyu.chen@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/clk/meson/gxbb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index ae385310e980..2ac9f3fa9578 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -1386,7 +1386,7 @@ static MESON_GATE(gxbb_pl301, HHI_GCLK_MPEG0, 6);
 static MESON_GATE(gxbb_periphs, HHI_GCLK_MPEG0, 7);
 static MESON_GATE(gxbb_spicc, HHI_GCLK_MPEG0, 8);
 static MESON_GATE(gxbb_i2c, HHI_GCLK_MPEG0, 9);
-static MESON_GATE(gxbb_sar_adc, HHI_GCLK_MPEG0, 10);
+static MESON_GATE(gxbb_sana, HHI_GCLK_MPEG0, 10);
 static MESON_GATE(gxbb_smart_card, HHI_GCLK_MPEG0, 11);
 static MESON_GATE(gxbb_rng0, HHI_GCLK_MPEG0, 12);
 static MESON_GATE(gxbb_uart0, HHI_GCLK_MPEG0, 13);
@@ -1437,7 +1437,7 @@ static MESON_GATE(gxbb_usb0_ddr_bridge, HHI_GCLK_MPEG=
2, 9);
 static MESON_GATE(gxbb_mmc_pclk, HHI_GCLK_MPEG2, 11);
 static MESON_GATE(gxbb_dvin, HHI_GCLK_MPEG2, 12);
 static MESON_GATE(gxbb_uart2, HHI_GCLK_MPEG2, 15);
-static MESON_GATE(gxbb_sana, HHI_GCLK_MPEG2, 22);
+static MESON_GATE(gxbb_sar_adc, HHI_GCLK_MPEG2, 22);
 static MESON_GATE(gxbb_vpu_intr, HHI_GCLK_MPEG2, 25);
 static MESON_GATE(gxbb_sec_ahb_ahb3_bridge, HHI_GCLK_MPEG2, 26);
 static MESON_GATE(gxbb_clk81_a53, HHI_GCLK_MPEG2, 29);
--=20
2.14.1
