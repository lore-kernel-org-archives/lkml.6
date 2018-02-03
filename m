Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517683262-2-12128703699036807244
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517683261; b=KH4Q0lA4j8oLv6M5nuQvLOf9ivdnl8IKenh0B6nFx7aM5vR
    b2rP4ylcWDqRnBlB9qLAtf97xrwIVnndbkFEVj7JWYg1KLa0lCkiLxBL2IEw1DSs
    vMu3P3uYWv8etX/1VsJ5rh5ZxAgDxkg3SGDMt+TMsGAvu/XsQHcSoWcIg2FhRpu0
    gfkp5zyejZ0ywE/p7yG5D9tb6hDbWn8Yu5Orcsw3h7ueGDJ9yJm2ewN5AWQRMcUQ
    zoxfgvtU2zgn2SXw0tHjws6Eakoc7SlXvhPDag6UQB0Y8Ha8eY2ZmdfcFX3d+Xe3
    8NvwYucXCBkCyUaHPQZv1ajmG6nuAZaEmP+su1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683261; bh=gPVttJ
    zhxjxKsie7T9c56VhZGtLho8yEygIh2p9Ct3s=; b=PYXn1avOOlyxc0CELxrErF
    TyrwFg+gm2/pbEmSe0jIMNgc3OS74/8ubqTPy4WO7uNUS7deRmLohv6IUuVky8DG
    4HSrUdKwVbsjV5knbCOoEoLj5iDyH6yAlwK+OMMKcnNsQMBcQEjXKd2Che2co5YZ
    ybDtcWjgWfIh0k5ukugXWmpC7kCatl4doHSVccA67yGdbHvc22lgfMWoJgkHElnQ
    Toj8MpK7xyufqLFFKAOClKivuwj/xBr+VpMG3mC9eykxIxCjWqJn4W6nsjTp/Iye
    fa/MiJZPnOLBY5C00wMyU9LJzSxGcMRi7ZpqGWzqJ5trm4JQ2DS2jxkkBGBfv36g
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Y2FuuKbj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Y2FuuKbj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754795AbeBCSiv (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:38:51 -0500
Received: from mail-co1nam03on0092.outbound.protection.outlook.com ([104.47.40.92]:4928
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752623AbeBCSDi (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:03:38 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Bogdan Mirea <Bogdan-Stefan_Mirea@mentor.com>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 054/110] arm64: dts: renesas: ulcb: Remove
 renesas, no-ether-link property
Thread-Topic: [PATCH AUTOSEL for 4.14 054/110] arm64: dts: renesas: ulcb:
 Remove renesas, no-ether-link property
Thread-Index: AQHTnRjv8rQBMd53EUyOQmi+09yLhA==
Date: Sat, 3 Feb 2018 18:00:54 +0000
Message-ID: <20180203180015.29073-54-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1092;7:yLFa+5gd7F89kAuZa3nph5FkYJ/oqk1A8N3hrZ48NBuPff5P54QkwGJ4NQgsm1wL3NBxI99+LAsrM/Y5Nnjq4eirbPb3MXiyufe32XOLn3QptjWmgzxQ+Y3yLbCFUQ5WWoq6bz4UDEmsgRvPV2xdwQBCsQNMkEKWa8Q+alli5F2Yt3BTvBP2V4wpZczoJFj9jXCxZL8qWfWSIxotT5hl6OKD/OYYmeLt8FQ2Pwyp6iSvJ/SugP7gzN5nwL+MS8p+
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 68277a8d-ab56-432e-ca60-08d56b30266e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1092;
x-ms-traffictypediagnostic: BL0PR2101MB1092:
x-microsoft-antispam-prvs: <BL0PR2101MB1092415BE807DE407CB69536FBF80@BL0PR2101MB1092.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231101)(2400082)(944501161)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1092;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1092;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(346002)(396003)(366004)(189003)(199004)(3280700002)(14454004)(3660700001)(105586002)(3846002)(6666003)(22452003)(6116002)(99286004)(305945005)(7736002)(2950100002)(66066001)(478600001)(54906003)(110136005)(68736007)(316002)(86362001)(106356001)(186003)(26005)(59450400001)(6506007)(76176011)(6346003)(10090500001)(102836004)(6436002)(4326008)(8936002)(2501003)(53936002)(86612001)(2900100001)(6486002)(2906002)(6512007)(25786009)(97736004)(72206003)(1076002)(107886003)(36756003)(5660300001)(5250100002)(8676002)(81156014)(81166006)(10290500003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1092;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: TsGpVtN2a/fwu7I8fMSoz8vabNMGMe9SqxB9oUMbiRwsymyxGEOqLmFh5XC7DG4LjnTrn+l32L+g9009Y1HRrA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68277a8d-ab56-432e-ca60-08d56b30266e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:54.5034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1092
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Bogdan Mirea <Bogdan-Stefan_Mirea@mentor.com>

[ Upstream commit 7d2901f809c110bd9a261e879d59efe62e3bc758 ]

The present change is a bug fix for AVB link iteratively up/down.

Steps to reproduce:
- start AVB TX stream (Using aplay via MSE),
- disconnect+reconnect the eth cable,
- after a reconnection the eth connection goes iteratively up/down
  without user interaction,
- this may heal after some seconds or even stay for minutes.

As the documentation specifies, the "renesas,no-ether-link" option
should be used when a board does not provide a proper AVB_LINK signal.
There is no need for this option enabled on RCAR H3/M3 Salvator-X/XS
and ULCB starter kits since the AVB_LINK is correctly handled by HW.

Choosing to keep or remove the "renesas,no-ether-link" option will
have impact on the code flow in the following ways:
- keeping this option enabled may lead to unexpected behavior since
  the RX & TX are enabled/disabled directly from adjust_link function
  without any HW interrogation,
- removing this option, the RX & TX will only be enabled/disabled after
  HW interrogation. The HW check is made through the LMON pin in PSR
  register which specifies AVB_LINK signal value (0 - at low level;
  1 - at high level).

In conclusion, the present change is also a safety improvement because
it removes the "renesas,no-ether-link" option leading to a proper way
of detecting the link state based on HW interrogation and not on
software heuristic.

Fixes: dc36965a8905 ("arm64: dts: r8a7796: salvator-x: Enable EthernetAVB")
Fixes: 6fa501c549aa ("arm64: dts: r8a7795: enable EthernetAVB on Salvator-X=
")
Signed-off-by: Bogdan Mirea <Bogdan-Stefan_Mirea@mentor.com>
Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm64/boot/dts/renesas/ulcb.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/ulcb.dtsi b/arch/arm64/boot/dts/re=
nesas/ulcb.dtsi
index 1b868df2393f..e95d99265af9 100644
--- a/arch/arm64/boot/dts/renesas/ulcb.dtsi
+++ b/arch/arm64/boot/dts/renesas/ulcb.dtsi
@@ -145,7 +145,6 @@
 &avb {
 	pinctrl-0 =3D <&avb_pins>;
 	pinctrl-names =3D "default";
-	renesas,no-ether-link;
 	phy-handle =3D <&phy0>;
 	status =3D "okay";
=20
--=20
2.11.0
