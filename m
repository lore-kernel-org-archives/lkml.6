Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1310899-1520122064-2-17649864799668273205
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
    t=1520122064; b=Jrzr5g82NRlugcR42q9vMbF5uh11mwFLsLD/AqAOZgA++Aj
    v1b0oi6rwlVErH3JRIap/BH/bPOGYnIWt8PE1ZF5jCTdp+b+3Mkbt01ZWx4GdtvH
    nGM1uQLEXlmz2Jl75Z+XoHuuewcxNubmDwRPuzdgvcwNeYtRP/Rql9NR3v7WOR2s
    yifnYxM9MpYGz41H7CnczkB4fEBr7+LqWXmJYKScGixED2TNyyA5g+rsU78dBLBU
    tt1JohIJ1KpgK4f5r/ilO4WuimhbNVqyKMgtsUQMhe2H2/LUNmihb3jwfu1sue6B
    b7d+F4So2NQLcQNDRb3NdOaKM2zZQUBXiRGE+tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520122064; bh=nQAEuS
    iVNEcYy5s0ztsmm8hnyDYE4l/DD09HEbW0Nfs=; b=wTgbKew05SvyK1ZwxAmOUg
    070EEOFVQxFzjjdf7ZgBOIzefnwmHN1mjZ1cnfljbXWam7fausbrevenmvdfhQmm
    PAPxlD5AZxAQAwkNNx0HbbavALAyjca7Pq8Qu5+a0Vfgp+be3w/ceNvKcmFW95X/
    D9p3+RVKT2b3LdiwGfvTeJ5MFQnp5zTkzHeIKH/biudRTRUoVnqzlKRXvvFak2rZ
    /SiwOqENNqakUtYWWxs62kVQYiqVmWBqnAWHdxSiCnyMKD6RSbHrZ/5QQosMfaMg
    Fq0IEci/IjqFttrpe3lja5rvviqSgcqL39if1yWU3mYcYIJ3xktswS4au0sjNlaA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PeptbqcI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PeptbqcI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933613AbeCCWbM (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:31:12 -0500
Received: from mail-sn1nam01on0122.outbound.protection.outlook.com ([104.47.32.122]:11440
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933362AbeCCWbJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:31:09 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 011/219] ARM: dts: r8a7792: Remove
 unit-address and reg from integrated cache
Thread-Topic: [PATCH AUTOSEL for 4.9 011/219] ARM: dts: r8a7792: Remove
 unit-address and reg from integrated cache
Thread-Index: AQHTsz7jQVeNL1jrD0G2z1rLiDAwog==
Date: Sat, 3 Mar 2018 22:28:01 +0000
Message-ID: <20180303222716.26640-11-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;7:Dmp2AcsrN+38nkNmjDHZLdGBU3CCil0nTwCuAfUHENZ0pY/mkJ2m9abv2QP5pCRzV6jTCDCqwV8dS1QtJHkex2ZeZpYFzGmwht+ivp85NKHfL8+jhz2BZgJ5vBE0DlXfoG5SdYNSjfheKm+lmpZAzIGIJQanNTiFEt3m9SLjaTfmpWzNLhsQRkei1wN6a6vD5VV8I9dIJNwzfdyKqKDnhI5YTVY+FOIxAnLocTkqWfkYTI1j434dwXsqkKrXovaC
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 05c42160-9a69-410b-0c7d-08d581567302
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB09708B6E448E1BD686612FA8FBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(376002)(39380400002)(366004)(396003)(39860400002)(346002)(199004)(189003)(86362001)(110136005)(4326008)(6506007)(14454004)(99286004)(8936002)(1076002)(36756003)(2906002)(102836004)(76176011)(25786009)(6486002)(316002)(478600001)(3280700002)(107886003)(186003)(54906003)(26005)(81166006)(7736002)(8676002)(6512007)(81156014)(305945005)(72206003)(6436002)(53936002)(6116002)(86612001)(68736007)(3846002)(2950100002)(3660700001)(10290500003)(22452003)(10090500001)(2900100001)(106356001)(2501003)(66066001)(97736004)(5660300001)(5250100002)(105586002)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: Lc9qzVv+qnDHludPNJaGUj7gFDD0bz6hEVStcqlUpqsIurWgBL8Nx/hUspStTBOVApxqYuKsgBjpAeqOx1M6aKOhGxZTUKRpJaED0r5VakjZ9Vg8TndHEkGcBmgr2BsTzd7Luj0PiCgL45pHzKpWA8SV3L3DXz94u0qO2UBnnOM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c42160-9a69-410b-0c7d-08d581567302
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:01.7756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit a0504f0880c11da301dc2b5a5135bd02376e367e ]

The Cortex-A15 cache controller is an integrated controller, and thus
the device node representing it should not have a unit-addresses or reg
property.

Fixes: 7c4163aae3d8e5b9 ("ARM: dts: r8a7792: initial SoC device tree")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/boot/dts/r8a7792.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7792.dtsi b/arch/arm/boot/dts/r8a7792.dts=
i
index 713141d38b3e..0b50c6766867 100644
--- a/arch/arm/boot/dts/r8a7792.dtsi
+++ b/arch/arm/boot/dts/r8a7792.dtsi
@@ -58,9 +58,8 @@
 			next-level-cache =3D <&L2_CA15>;
 		};
=20
-		L2_CA15: cache-controller@0 {
+		L2_CA15: cache-controller-0 {
 			compatible =3D "cache";
-			reg =3D <0>;
 			cache-unified;
 			cache-level =3D <2>;
 			power-domains =3D <&sysc R8A7792_PD_CA15_SCU>;
--=20
2.14.1
