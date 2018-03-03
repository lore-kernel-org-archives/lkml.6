Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520123329-2-11897835273810754310
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES daenno, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520123328; b=t81huMq510GIRPpnZzGO3HqJ1f8n2NnzeUVbBrWvpTHn7Cb
    xEa6xqoM9VbCxzZy/x2xzEI8UY9PvkmY2H7j9wkutr7QoA8jLadSfH23SltJFjSY
    oSIBXk9Z9EbvfQSVUjP32ff/1TBY584gh3Zn//rX6iCDZeoDqjNztYOUnceOwBBA
    tSPbSzklSXnfsMp8/A5+zlLDGN+fc0WGYQCeLcJm0ZqBXPYUsKYaDmC5qIBq7SgG
    xuQj3RzmNFUaxfVQjorPojw0jrN8PEGOvIdHsAoGdcuUf+yLCd//CP0ZXkYi5Jed
    GlI4Ukarup9DpR5qdtFJx89R1U2B/lOh9jBcWZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520123328; bh=zkGtsq
    hEu6vqSqqDd6Ff//zmbYuhRfXiGKvaIsUl3Rk=; b=BabEsU7Vq9kUdbz7eAZgL1
    OkyImWfd6cjEVeJUfWELfiHHRTW3b8ScsD5soUvAUmT88F31+gLK2DvMr90/35zy
    4mITv/flWyNMBivXaoHlX/Ol0abSmzg4GMVdubxcfeq1RNGfY3pMJyuwueNFEXPe
    HpxRfs7UkVCaEWXsSP6zQeanbUexEgq2MlgSi0LSyFmMDsoCrAQX1/bRb+ZwF2eg
    JDwxBheefw+oWgVTUJR7sq+ecirLzMHaVDQa2oluZ/NxbePNGpSmpuA3QyXU6Tqa
    g24ViQ0QbmiF8m2Qi3pH3Gmg2urEjrVhMLQ7KoaQBf/hXGjmg9ipWjjhii3T/Dfg
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mZYunGu3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mZYunGu3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932417AbeCDA2b (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:28:31 -0500
Received: from mail-co1nam03on0110.outbound.protection.outlook.com ([104.47.40.110]:19475
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933081AbeCCW2I (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:28:08 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Yixun Lan <yixun.lan@amlogic.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 08/84] clk: meson: gxbb: fix wrong clock for
 SARADC/SANA
Thread-Topic: [PATCH AUTOSEL for 4.14 08/84] clk: meson: gxbb: fix wrong clock
 for SARADC/SANA
Thread-Index: AQHTsz6eQH561eZ0T0qjWK5+CKf2Sg==
Date: Sat, 3 Mar 2018 22:26:04 +0000
Message-ID: <20180303222518.26271-8-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1067;7:bci4LcID3jYT+n2POo+KsMiFaE0SDJyP4K97+XpU0x5+OMFYb/W/1U8S/pHMuG0Aon33sAHMRWiULm/3wzQIPYaqLlQtNsmEDAqaaQleka+Wuj70KSi60izbWIYBML8jC4fH2mLFedtQrlIFCiNjHoX9tlcc98KRAbdOi+FRKxQvZzMZMfm2Dis6qIthHFAPo3XSUjJUCssnfkmCFL2Iatl2wIs6SGBWx4kiG3/H9+bO4wFd0xTjgC18ovg+RfpK
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 180d4cd7-5b86-4fa9-4298-08d5815607cb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1067;
x-ms-traffictypediagnostic: MW2PR2101MB1067:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1067CF71366F80F6C28F0F54FBC40@MW2PR2101MB1067.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1067;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1067;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(199004)(189003)(6512007)(99286004)(10090500001)(86612001)(106356001)(53936002)(66066001)(316002)(97736004)(6436002)(68736007)(22452003)(105586002)(14454004)(54906003)(36756003)(6486002)(110136005)(8936002)(305945005)(81166006)(2950100002)(81156014)(2906002)(5250100002)(4326008)(2501003)(1076002)(86362001)(76176011)(3846002)(6116002)(25786009)(6506007)(5660300001)(102836004)(575784001)(478600001)(107886003)(72206003)(10290500003)(7736002)(26005)(186003)(3660700001)(2900100001)(3280700002)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1067;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: QXJLApUIl7adZBQ+CC2H1Gfa/FerGdgEJAVC9nX77LVzoRwYL78kvvBzWceDCDrFg2u1NCdFUMp2mbYWxGFMuhvCcBeTe2ACG9b7YWPETwWOaI4l+RMaUROqZLaVreDXYTWkWIqhOtKSNZLjBwPjMf06X0vZHbmh97I0sQmQp6I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 180d4cd7-5b86-4fa9-4298-08d5815607cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:04.6817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1067
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
index b2d1e8ed7152..92168348ffa6 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -1139,7 +1139,7 @@ static MESON_GATE(gxbb_pl301, HHI_GCLK_MPEG0, 6);
 static MESON_GATE(gxbb_periphs, HHI_GCLK_MPEG0, 7);
 static MESON_GATE(gxbb_spicc, HHI_GCLK_MPEG0, 8);
 static MESON_GATE(gxbb_i2c, HHI_GCLK_MPEG0, 9);
-static MESON_GATE(gxbb_sar_adc, HHI_GCLK_MPEG0, 10);
+static MESON_GATE(gxbb_sana, HHI_GCLK_MPEG0, 10);
 static MESON_GATE(gxbb_smart_card, HHI_GCLK_MPEG0, 11);
 static MESON_GATE(gxbb_rng0, HHI_GCLK_MPEG0, 12);
 static MESON_GATE(gxbb_uart0, HHI_GCLK_MPEG0, 13);
@@ -1190,7 +1190,7 @@ static MESON_GATE(gxbb_usb0_ddr_bridge, HHI_GCLK_MPEG=
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
