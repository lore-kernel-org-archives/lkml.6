Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520122054-2-1803181402496199039
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
    t=1520122054; b=tIOODRr0ofxcPGA59LAczxgRYYwbpuztVrYw3gg7VWvj77o
    JWwBv6JLq9h0OrTRs+XW74cw72KCuMUGUgifp8Vm/kJLZeMnUdqKgxIN0cdz1gGY
    8Admv1ro9b+wwiQ+49agz13/vXhVPxUGM8Y0P25GEZ1IWVA/IghvJg/C1tCLabKH
    gkkV259sz0wg1PvvsMpwh1IDe0ioLztz5BbNnjMJ8aVMqFlXM9txEjMIN4louV2R
    gsINQR34WKdAaFCIDdoBhPaffx10woG4eHTlBr3sbdbrEAzsgNjDGLKH2s+mFMCF
    T7I1JKTgy+2Zz0oMip1EAAPUEevWGWOynKa3enw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520122054; bh=6Qw5Sg
    7x20NZQGrlTDUXDNTTBPgUDPFXEh9o+1MsaeQ=; b=oL7XnRPR4w9juxMLj81ait
    TZIpcYQ92H4esf8Zi8zGG3m3hWtiRgO8/JneeQ17gjP9yrefJJnkpTeSkXjc+r+Z
    Mz0qYv397xAbrnHJrrJslm3yFlNX0po9QQKFwAjr6LiFPrqN18BW+wcImQrgqzHp
    C8nYWnIvHPKkSAr4vTuN63TYx20PJJl+Pg0ZRf8MoEZv25WAwihVN/Ac0A7reEcY
    ONLxP6VMv30Fp+VH29u1gxl/0VEYW8z4RqiaPbVCjxSdy9Tgdn/r9A4mtzCq1GVJ
    yDlA7FNhpaRVggbKU76GpiY+PIe1buBJIhSDmablLwq1ou2fC2AMwhJ8YYrkgEOw
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PSJ287CU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PSJ287CU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933479AbeCDAHY (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:07:24 -0500
Received: from mail-sn1nam01on0122.outbound.protection.outlook.com ([104.47.32.122]:11440
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932368AbeCCWbM (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:31:12 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 014/219] arm64: dts: r8a7796: Remove
 unit-address and reg from integrated cache
Thread-Topic: [PATCH AUTOSEL for 4.9 014/219] arm64: dts: r8a7796: Remove
 unit-address and reg from integrated cache
Thread-Index: AQHTsz7leD4TDzOhCkWqjQ77vOezpw==
Date: Sat, 3 Mar 2018 22:28:03 +0000
Message-ID: <20180303222716.26640-14-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;6:BVMx17kGqne/ccqj9KjlKKY2ziZBoTFDNmMAUmStpSTKhe+hOH6dpPVy8nCB0XzbMEB5X19kf1rJRiXYQyV95UHKeKLZWjD4ue/WU0bAck4aFxQCWw2S4s6iPAxmtqend7eStTG1Od5SmhihNIzv+veHYsEABRev+dFIR0OkW3lThi9x5ivUM9xxjxq/uQyXNtSZg5TZUdrfcsFn7/37uud4a64W6rAYIcOpigwqX5bDnAA3J9Y4wFV4ZcKmSMEl2NAD6MqE0jxoaAG+ep4cSMeYi4kDKqxOMoPmvuXRS7ZVj7UvHZzgRDzh7WgVRVfLd16cTNrGX3IUlA7wlMdlZ97zns4ssm1Vkqy3ri6nab5GftTVg0tWlW7D61nkVHZG;5:QjLkDqCE4ZGAbMM4Kx34Az7pJ21ITu/W2nNsStax9EsYgyRh9G2WqdynkjIDFDCAeVcWT+wGycgbt7xrC14zSXFZm6UTGygO8KvmyxABZTRxY7+6AkNuFmGCOFzsmEi3bXHC9XJQ9z7aE+qDY7y+BNLvNpzKor+jmLR/wNTjdbk=;24:EoPYE+2lNk9Lh9xiiROHddTElrSzPaJGL1JW/I+UN2wmkrNTIjtOL08B8oPcFnp7G16yC0I4xC6GcYu3nYuKytbhXh0iksJTf3/FUuFWuo4=;7:pRPKobqVzT7DIhsjP9NM0jMiBJ8v+79I9WVTlICTQuebOMVILXvAHqc7S/p5a57weaupZXvXZrTgOgHum3SEt0LGjltaHWC6yxJ6LDx0BGNyTvZKY4k52LXu8Gzj1gOR0zUApXyeT6No/bnvE7hLy5k877L8s7EJ3pfn+20muIlX/wv0KzvMP4Q73HDRZR9oDGXSscgRiwM0FsvHMVRBdPKtmacYhA0riCVFY/oka9WkHuJm8P/K21sTErmlAKXF
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8090c2b2-e282-4a88-26f1-08d581567420
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB09704821064A8B53BF40C1E8FBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201703061421075)(201703161042150)(6072148)(6042181)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(199004)(189003)(86362001)(110136005)(4326008)(6506007)(14454004)(99286004)(8936002)(1076002)(36756003)(2906002)(102836004)(76176011)(25786009)(6486002)(498600001)(3280700002)(107886003)(186003)(54906003)(26005)(81166006)(7736002)(8676002)(6512007)(81156014)(305945005)(72206003)(6436002)(53936002)(6116002)(86612001)(68736007)(3846002)(2950100002)(3660700001)(10290500003)(22452003)(10090500001)(2900100001)(106356001)(2501003)(66066001)(97736004)(5660300001)(5250100002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: /LVvcaBlvf+CH2IRyAfy/DGBIHa3IuB+Gt8SFW4VC3VNka4IW27hGxpXq0pbOR6LdqlfcDwWEMHObm50wNepfeC6Y6VNMVxI6DxJqTsO2OoHTWavdFNqmli4My9NuUXew+9e6UscgJ2nrBBvDhYl5kyAaZZMu/UWgsZ7mWO88a0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8090c2b2-e282-4a88-26f1-08d581567420
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:03.6506
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

[ Upstream commit 57a4fd420c6e8a04b6a87ff24d34250cd7c48f15 ]

The Cortex-A57 cache controller is an integrated controller, and thus
the device node representing it should not have a unit-addresses or reg
property.

Fixes: 1561f20760ec96db ("arm64: dts: r8a7796: Add Renesas R8A7796 SoC supp=
ort")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts=
/renesas/r8a7796.dtsi
index 9217da983525..53d03cb144e4 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -36,9 +36,8 @@
 			enable-method =3D "psci";
 		};
=20
-		L2_CA57: cache-controller@0 {
+		L2_CA57: cache-controller-0 {
 			compatible =3D "cache";
-			reg =3D <0>;
 			power-domains =3D <&sysc R8A7796_PD_CA57_SCU>;
 			cache-unified;
 			cache-level =3D <2>;
--=20
2.14.1
