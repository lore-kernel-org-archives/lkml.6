Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1171329-1520492062-2-1870517505611354552
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ensvda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520492061; b=gDRxjhWdehvL+RIIU4OsbgtzCPItopz2D1bSzqO0KHYb7NN
    ReFywz6TSbDOam9Uaww+1zvWC64smHdxeJRC5dvYWIHxflPVgApdTj7uj3hUiZDe
    HqKh4z8t52Nu/zGmhlmOS/8UTHSAXukZPtRpb0SUjlvzC6FrDSM+IkZmN0tUCJtQ
    m1jxGxM8sY9ni71/81bIruhCbM//XzLssmWGC+kG+ey05sWmWrqg0ah75Kd04RYC
    KbOtQAm6t3Up63WDuzIs9xqEi/bhsgF0bnHKsY6u/9SFuKO7yZ1Gsu8EU/06jDhP
    nlp7WaeE6QFdkGnj7yYaT8eshDBOrSZhQpkrwaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520492061; bh=J7F5GP
    6frzALeVQ7fdvNbBEO/UsIh1GvQvU4hu+wxpM=; b=EaOCjo/tC2tWhXfdRYYn1D
    whziILBam3qoQ0rmTTOUO9qvg2PQU3L6HPHvuMEji8E1Joi/xLwIj13R44y+ifeo
    qGuZ+buIZo/MSs8HovKuDDZ26qMXN9jA4GuyJETmkK5ryCp4QLYNRQ10CUUaPwX9
    b7+xutCj8VGSarFlPiBSUD5nZBeWXB1BvgJ5TSJJJpvKmSsNTD/HebCsY9ioYM3u
    /ld6sxqClw38VTF5YO3nZ8fT3p3D7FqnIGWRyR9Q1YDDNHWYhcWe871zD0z58UoS
    iFi8XPS75+dVO+YhHLS1d7ukfQ3IkNh2vzWD0glfOygwkpZ7WYHmJ2lwAXhLBbpQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Fkkf4jxV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Fkkf4jxV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964938AbeCHGxe (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:53:34 -0500
Received: from mail-sn1nam02on0119.outbound.protection.outlook.com ([104.47.36.119]:48736
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935218AbeCHE6F (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:58:05 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Sergej Sawazki <sergej@taudac.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rabeeh Khoury <rabeeh@solid-run.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 75/78] clk: si5351: Rename internal plls to
 avoid name collisions
Thread-Topic: [PATCH AUTOSEL for 4.15 75/78] clk: si5351: Rename internal plls
 to avoid name collisions
Thread-Index: AQHTtpnVSu7ls5bye0SMAuR/mF0L5Q==
Date: Thu, 8 Mar 2018 04:56:34 +0000
Message-ID: <20180308045525.7662-75-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0936;7:zON7uQrtd5fhaW915/etD5wu0sppKFxMZywkZ+SUW+tX8uXNkz/v4ya6XAu2XEnJAci8juGY/2eDVCJHOaUlDSMnf/qt1PVNjhmJAV4nWntqykEPETFQIXoojsWmqLk1H3IWsEjBCj5Aace9tNFBF1M47Oh0MizPrdl14sjfCQ7QT61WoeQtQxAsnxQh4Ppk/tox5ikKdq4RMj/M+OcWYVCf7aBHj8MLKvi0TZs6aeWkdzOFd2Ad+5MoQmnunw5O;20:RTi5ob9bxfFlbgVYqmQp3jvOgybNPyuRLIqZSO4MlZ/iHxsy3y9TM520nGfhEQklQy9GBwdTZbKgnXKfi6YWfHGijHLdZ4VrmTCWKnFQMZGkVWFtqRe6No1AYTNq5643e0lMHJMKEnJakuXStaCAN/V0SYKcTxfxW4PV5JObAMI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 676fa180-1f48-40d7-a892-08d584b12a8d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0936;
x-ms-traffictypediagnostic: DM5PR2101MB0936:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0936C100DB6730C0DB67DDBDFBDF0@DM5PR2101MB0936.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0936;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0936;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(39380400002)(346002)(376002)(199004)(189003)(478600001)(99286004)(575784001)(6506007)(59450400001)(3660700001)(36756003)(86362001)(54906003)(6116002)(110136005)(2950100002)(102836004)(1076002)(3846002)(6486002)(3280700002)(39060400002)(10090500001)(10290500003)(305945005)(72206003)(6436002)(6666003)(26005)(5250100002)(2906002)(186003)(2501003)(105586002)(76176011)(66066001)(7736002)(68736007)(25786009)(6512007)(106356001)(86612001)(8936002)(107886003)(81166006)(2900100001)(5660300001)(4326008)(81156014)(53936002)(14454004)(97736004)(316002)(22452003)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0936;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: /HGtog93DbRVxwdsMB3/8PgscFY/JRRjEVPlnEc77ExSXTxDlGNjQKybRDq5+x1iDp2k1FRsaLJxIvXzll7m1k9SNcZDU+3XgM/eNNNRhAsbQSa3CcyfEsPkfHpA5FWhaDwwOMjxn2qoxCzv7wyeVi9mjmqdiPP5yW/OborViQzBE1Mt5Aq8vHOHG/wx6DDnpRzPYFuG7LAuq/ZaQ0uD1GR09hJxMrtIN4HQrNmIQ2uYuBZDcPRF2TVGOs8Sh3Zmqb109ckXn3Jgt5nisc7CJdiWDwCcbi7cmd9AhhBhdjj3PzckG7WSfWbqroBelM3I6D1YXzmf8jmRxtKGDQ0bNQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 676fa180-1f48-40d7-a892-08d584b12a8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:34.7572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0936
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sergej Sawazki <sergej@taudac.com>

[ Upstream commit cdba9a4fb0b53703959ac861e415816cb61aded4 ]

This drivers probe fails due to a clock name collision if a clock named
'plla' or 'pllb' is already registered when registering this drivers
internal plls.

Fix it by renaming internal plls to avoid name collisions.

Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Rabeeh Khoury <rabeeh@solid-run.com>
Signed-off-by: Sergej Sawazki <sergej@taudac.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/clk/clk-si5351.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-si5351.c b/drivers/clk/clk-si5351.c
index 20d90769cced..653b0f38d475 100644
--- a/drivers/clk/clk-si5351.c
+++ b/drivers/clk/clk-si5351.c
@@ -72,7 +72,7 @@ static const char * const si5351_input_names[] =3D {
 	"xtal", "clkin"
 };
 static const char * const si5351_pll_names[] =3D {
-	"plla", "pllb", "vxco"
+	"si5351_plla", "si5351_pllb", "si5351_vxco"
 };
 static const char * const si5351_msynth_names[] =3D {
 	"ms0", "ms1", "ms2", "ms3", "ms4", "ms5", "ms6", "ms7"
--=20
2.14.1
