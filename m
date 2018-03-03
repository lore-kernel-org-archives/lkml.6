Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1247250-1520121104-2-614262393543838242
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
    t=1520121103; b=aawU7RM4TxABvN+vZC+4CUZaZa/7nhdHF30wsyC3RoAruhe
    Voru2X9k04Cr9024uCV4IJkOlzziPC/WsGjIX+xIDlVYrxevpceEwHvWvkqEisbE
    88pq1gn12N5DlmwpsbBXFcEdGjSUOrHGb73p3eiaPzHnj5cZ4P4kZKiVxQ7J3gOX
    Jn+vBnzZNzc85a61pQmUjCU/ZRAFXZFbu/aSHdv24ROUavHSr9lzogID/k1H3x7g
    C/4p1vyKeyYFq8ZxRs885lm4Ti0POisXHuhfC0W9Y8JJtnVA1gY4mZlzwwySZme8
    abqJMuTq7hkLhKhTaRdXkgsd9Z/f9eI1nmmLwBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121103; bh=mrAeIs
    l5a6koSxy9ThpCjvIO/w3+xR7MTvvJCTfY20w=; b=P08wWAisoV3C16Z0QGzDsp
    NG7omnn/lNOvsmgEq6D/1CsqYG3nkQGAm86NSrr2QO8psMRWVz45F/C6hUcWPrd8
    N5YKKPyB0KV/1FwUWlKyi3ZcoO1XfjcTRgXVMhcBAJCtAXjaEHzv0YswgU2Pywwn
    CIPFADO986fYH19MEEOXcx+DTY48xXqno8WD8sipYWDZl3K9z3espMlrJdYhzANz
    zU6nvQ1pnraJ8Y6Csqx/V97FF/qJOqdkw9Eu/7ApqIIqikX4E2asqlxgSn+elv9n
    m2rEmC1m/iWVYteTeivWCTwr8ZIwwycy6PU8XNuSjywt6BUlFrYzq1P0GfrLTlwQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NaCaQeA2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NaCaQeA2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934229AbeCCXvV (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:51:21 -0500
Received: from mail-by2nam01on0133.outbound.protection.outlook.com ([104.47.34.133]:49841
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933735AbeCCWdJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:33:09 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 079/219] ARM: dts: r8a7794: Correct clock of
 DU1
Thread-Topic: [PATCH AUTOSEL for 4.9 079/219] ARM: dts: r8a7794: Correct clock
 of DU1
Thread-Index: AQHTsz776qsFWH7gc0+vV7Lg3ZNxfQ==
Date: Sat, 3 Mar 2018 22:28:41 +0000
Message-ID: <20180303222716.26640-79-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1097;7:X6O0NSqpHNkFB2vLh0cihJIAcQY65wTzkS2pvhJgGCwsLZ0MnE3CZFyWwihhzNeo4+Uf8XIAkU6eR4sbEC+uyygjG4zWb4v0Rld9D8cS6qoHTKdF1rlzo9hZdTipnC4lQnzEndJEHgtEaimRIapBiSraPNspctrrk/OTmaR5kVVOAdnA+TAUJ31myvxcVAs/p8fsg7pxzKR1vwxPuEL0bkR9qTv+CsKFBUWv35CIFVonEAvuuOE/qPqZX8jHKuYN
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5ee151af-0739-4e57-c0ce-08d58156bc71
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1097;
x-ms-traffictypediagnostic: MW2PR2101MB1097:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1097670463A693FFA51D7B05FBC40@MW2PR2101MB1097.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2PR2101MB1097;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1097;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(396003)(39860400002)(346002)(189003)(199004)(305945005)(105586002)(36756003)(3660700001)(86362001)(6666003)(66066001)(2900100001)(5660300001)(8676002)(10090500001)(81166006)(81156014)(8936002)(22452003)(10290500003)(2950100002)(4326008)(25786009)(5250100002)(2501003)(68736007)(7736002)(72206003)(14454004)(478600001)(186003)(110136005)(26005)(316002)(2906002)(97736004)(6512007)(99286004)(107886003)(54906003)(1076002)(6506007)(106356001)(53936002)(59450400001)(6116002)(3846002)(102836004)(6486002)(86612001)(3280700002)(6436002)(76176011)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1097;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: xqrAYAhjGz9bVg9K8oizQht262F+tOd1jm8pN3723Fsc94svbAigjZlg1v7IeAaOg8KcE1lNAefWYKxfDNUfjlUHySaUtHFY5GJ1071XwOVAxw3Jo1t8YIvXg5zZ2bKOVAr+XR62IFE6fK499hwQZBw3/h93lYPjXmpFOna8Mgo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee151af-0739-4e57-c0ce-08d58156bc71
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:41.9006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1097
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 89675f36c9e17512812b9d14d9824f8ef92782c3 ]

The second channel of the display unit uses a different module clock
than the first channel.

Fixes: 46c4f13d04d729fa ("ARM: shmobile: r8a7794: Add DU node to device tre=
e")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/boot/dts/r8a7794.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dts=
i
index 6c0150dcf146..9bf2051dacdb 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -916,7 +916,7 @@
 		interrupts =3D <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
 		clocks =3D <&mstp7_clks R8A7794_CLK_DU0>,
-			 <&mstp7_clks R8A7794_CLK_DU0>;
+			 <&mstp7_clks R8A7794_CLK_DU1>;
 		clock-names =3D "du.0", "du.1";
 		status =3D "disabled";
=20
--=20
2.14.1
