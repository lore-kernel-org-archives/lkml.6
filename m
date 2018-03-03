Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1247250-1520119969-2-4714694555474859069
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES daensv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520119968; b=sc5xiGExftqEZRc5edXOQP1jEphPUliNURHoDl3cSSkoLz2
    plaQFDBD9vFRLEHgAYNixfEVVuupgzy76LCZSGPwRtA5ePwNqxHtJpwLZx7OGUfN
    78hH/iegg6gJ0B97aS/SuCJru2v82cWDdPavHrjZo5SWBjgx1XBveCcLkS2F3hLn
    Gvtjt3wLSPks90CxUu+xx1xirBl9eCW75FuMc3TecrfIbklcxFwQULhmMBryGsux
    UUqgbWcXQ83brIIivfzL88vIdPB2fNGLxye+EXbJZc04vxU+3sOffYqwDKWj307S
    xfjCuL5rQv2DuqiWRXN6Tpzxn3hmk65OTHDxR2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119968; bh=nQYjPv
    DwmjvR/KKmvqmTDUtwwzj8GZfQ6ANQ/ugZ5+Y=; b=rr54tvSwhBIrnmaAFZSDhs
    JMm5qNTsmx7EANMQ7b6q0g78EOdMjW0BZpsbzwyECcX498Mjr5VWKn54+Ml3oY8i
    WEOMisycM+mRKDKvP0TTDtbg/Bhj3Yp194nlmBsrt4EW+wESLAbRz+TVIf3xlEVJ
    jzdyM23LZ1AUJtxE8nlNJre0w0DwVFBlW+YYXI2YLjOKvLxrMwnTivFFcJroQydF
    cYx2gBkziGLH2DcFC/7wfjUSgq1Z4TK9IJe5nucZC0fFx845n4FnAYwKhK5W/O1W
    OzkNA/hdlT+XjA5oC/hnE/6RNOGosJSFxR/cE/MEMjuLTqflAtP5FSR5UiQ8JLIQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ndm5BVge x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ndm5BVge x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933690AbeCCXcC (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:32:02 -0500
Received: from mail-by2nam03on0118.outbound.protection.outlook.com ([104.47.42.118]:7707
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934521AbeCCWgL (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:36:11 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Yixun Lan <yixun.lan@amlogic.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 175/219] clk: meson: gxbb: fix wrong clock for
 SARADC/SANA
Thread-Topic: [PATCH AUTOSEL for 4.9 175/219] clk: meson: gxbb: fix wrong
 clock for SARADC/SANA
Thread-Index: AQHTsz8eBD1TrYcPHkWCHdKcHZTULA==
Date: Sat, 3 Mar 2018 22:29:39 +0000
Message-ID: <20180303222716.26640-175-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1020;7:rSlH0F4PmmXXG7KM0vXHpLECvPp1hHPUsyCDSxeb3LwOY5X62UFWtL5ekwv7uh/Wy9pA4Umj2+ghfmEfWvd2f4mGFjhuD0q3ZMt3UXUm1wSBL2ruTG2aenM4550DOPGIww2KFYCoqzoIbhJYtbUnTaiB1+2MujCuX2L78yTLAR+x2mS6FSlZ5LqLHLQaGAF+WOijx62qdATL7YXB9B3RzZOEpsxjQi0p0Wdn0sCPFpdGFTo8xtP2EfELYF7+i1NR
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4f16890b-bf21-40ee-59bb-08d581572791
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1020;
x-ms-traffictypediagnostic: MW2PR2101MB1020:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB102060E64F728A6C00328B6BFBC40@MW2PR2101MB1020.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1020;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1020;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(346002)(376002)(39860400002)(199004)(189003)(6436002)(5250100002)(99286004)(3846002)(6116002)(8936002)(22452003)(86612001)(86362001)(575784001)(4326008)(10090500001)(68736007)(6512007)(7736002)(97736004)(25786009)(76176011)(1076002)(6486002)(2501003)(66066001)(36756003)(107886003)(2950100002)(8676002)(305945005)(5660300001)(105586002)(53936002)(6666003)(3280700002)(81166006)(6506007)(106356001)(2906002)(81156014)(316002)(478600001)(72206003)(10290500003)(2900100001)(54906003)(110136005)(186003)(102836004)(26005)(14454004)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1020;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: NlBvx/v8SY8+DZFJ+gdupLlStfznAA3DR0FQsQ0JqnlWFDeTl8aSKz/uhndSqp556wCAKyVotl28XWpGQavSG9VE7ZjhJ+JY1FPnaOPLSkmk3GVfqHf7bB7dUIr/mxwluikjCDTCv7lz8/Fh6SPYF7ZDm4ayqPL2WteFRoB13sc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f16890b-bf21-40ee-59bb-08d581572791
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:39.2601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1020
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
index 9d9af446bafc..37e05d6e010a 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -572,7 +572,7 @@ static MESON_GATE(gxbb_pl301, HHI_GCLK_MPEG0, 6);
 static MESON_GATE(gxbb_periphs, HHI_GCLK_MPEG0, 7);
 static MESON_GATE(gxbb_spicc, HHI_GCLK_MPEG0, 8);
 static MESON_GATE(gxbb_i2c, HHI_GCLK_MPEG0, 9);
-static MESON_GATE(gxbb_sar_adc, HHI_GCLK_MPEG0, 10);
+static MESON_GATE(gxbb_sana, HHI_GCLK_MPEG0, 10);
 static MESON_GATE(gxbb_smart_card, HHI_GCLK_MPEG0, 11);
 static MESON_GATE(gxbb_rng0, HHI_GCLK_MPEG0, 12);
 static MESON_GATE(gxbb_uart0, HHI_GCLK_MPEG0, 13);
@@ -623,7 +623,7 @@ static MESON_GATE(gxbb_usb0_ddr_bridge, HHI_GCLK_MPEG2,=
 9);
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
