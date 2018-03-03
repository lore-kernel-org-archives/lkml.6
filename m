Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520120869-2-10205267147442445789
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
    t=1520120868; b=lSxeSUbgaRlfktJgmA0u7IGdB59gQNONFCtiBZJBn2SkXSu
    5/dRspCiegcIeKNtF+8gvKm2QsYhrEfrsd2+R+1dbX63Gh8M7nw1ppm6qOqAzg94
    2W536xSbLxPJvMcUGlTSgufITtcFEh2L1iWqsWJVmnJoHklFYf7x6J1cXcEFTWN9
    wx/16LnJi4haDBQrp/qers6/JKCdUZKv1+x5JkBulunDydjxe9A9F100aAeRZZzE
    wuvhtm/JPzT5NF+bRMrI0RU3U2yOeuQpNBimOVRqVh+YCf25i5w04hhC16n/7tuP
    fimUSVLju8uM14jydV+NJJUpmMt+L0P5AZcZO1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120868; bh=bG+2U6
    EZnj8c+wrO0zab/p/OFVZ5WqoshrHe1vs59G8=; b=g7/EsfIq7I4P0dJVpZM/SK
    0X/d3P3rs75vwKLMwGK0D71meDgLTfFUERD7wdJj/X2IqMUD+dAmXj15m0rKMJXi
    UYj1WoCfBzmObJ6plxPWUx6R9fJsKoHJf8Sx5lgSP+h6wg1WLjJkDgrrAjEa8cbN
    /idxUFFjLgNyN9oyfVMPdAWtOfBKdjiqHiqG+G1iuF3FG5qycKbeYama/N5nhODC
    g9ZpuFTbiSjtd+C/ABJJbuuSYIuIBG2uWymHqMQqkXrzBzA7UmpD9oVnA+2geicP
    Qxfc21QRJ0d/YnUpKng6atIMNqHEKbbCvBy/TbqB4sYoZ/MiGbJxH/afKeHFh6Xg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=G3/UBPtT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=G3/UBPtT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934105AbeCCWeD (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:34:03 -0500
Received: from mail-bn3nam01on0116.outbound.protection.outlook.com ([104.47.33.116]:3173
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934078AbeCCWd5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:33:57 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Chris Brandt <chris.brandt@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 096/219] ARM: dts: r7s72100: fix ethernet
 clock parent
Thread-Topic: [PATCH AUTOSEL for 4.9 096/219] ARM: dts: r7s72100: fix ethernet
 clock parent
Thread-Index: AQHTsz8Bw3BIi0EL4keftVjrQTKIOA==
Date: Sat, 3 Mar 2018 22:28:51 +0000
Message-ID: <20180303222716.26640-96-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1065;7:tjW3YEnSDF5IXjG8Mah7oXs/7A+hZbHF8zIaAavaLKKVIUg+zp0OatJtg0jFwhm70z9wuHyaQYUV1pZDUvOMIq4OrA0iQwlqj+Nm29B+n3610Xh6QXupyvrR1LSptGs70IqTSR+9PbM8ZBzEV0ePkGupfFEZYeZSkZ+xWIhmEu1N8DdZl5BXwA5HtoxxaosaasuzC5rUvSGPxwIXII7iqeBsF+mQhiq6PvNQ0/yo0mXil+KRjQUoxDBpcZtVXiwU
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c5e00e5a-2082-42f9-a6f3-08d58156d82b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1065;
x-ms-traffictypediagnostic: MW2PR2101MB1065:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10652DAB9F44306A837FE5BBFBC40@MW2PR2101MB1065.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1065;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1065;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39380400002)(39860400002)(189003)(199004)(6506007)(22452003)(54906003)(25786009)(186003)(2950100002)(102836004)(5250100002)(2501003)(110136005)(97736004)(316002)(2900100001)(36756003)(76176011)(6436002)(59450400001)(6486002)(26005)(4326008)(99286004)(68736007)(6512007)(6116002)(10090500001)(106356001)(105586002)(478600001)(66066001)(107886003)(3660700001)(305945005)(86612001)(14454004)(81166006)(7736002)(86362001)(1076002)(72206003)(2906002)(10290500003)(8676002)(8936002)(81156014)(3846002)(5660300001)(3280700002)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1065;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: INLwd7wQtK9wEFBaetL2DwZ9LBtWb230oyNs09Pv0BtfLCiZxnG1Tn9NGpQaj/RRGKpDU83Wv9Bzrcae1IluvyYAJ0I+JXGMJoaPbcE5fHr5iu3Hvvg1H/H3ESu5HeYqJZqMqtyM3CoUk7fiKC9OV7sKlsxP7Kej/BGE8LclYyY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e00e5a-2082-42f9-a6f3-08d58156d82b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:51.3850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1065
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Chris Brandt <chris.brandt@renesas.com>

[ Upstream commit 91a7c50cb4fabfba218549dfa84356069918bfbf ]

Technically, the Ethernet block is run off the 133MHz Bus (B) clock, not
the 33MHz Peripheral 0 (P0) clock.

Fixes: 969244f9c720 ("ARM: dts: r7s72100: add ethernet clock to device tree=
")
Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/boot/dts/r7s72100.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.d=
tsi
index fb9ef9ca120e..959e3edf367b 100644
--- a/arch/arm/boot/dts/r7s72100.dtsi
+++ b/arch/arm/boot/dts/r7s72100.dtsi
@@ -112,7 +112,7 @@
 			#clock-cells =3D <1>;
 			compatible =3D "renesas,r7s72100-mstp-clocks", "renesas,cpg-mstp-clocks=
";
 			reg =3D <0xfcfe0430 4>;
-			clocks =3D <&p0_clk>;
+			clocks =3D <&b_clk>;
 			clock-indices =3D <R7S72100_CLK_ETHER>;
 			clock-output-names =3D "ether";
 		};
--=20
2.14.1
