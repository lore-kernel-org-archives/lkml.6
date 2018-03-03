Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153505-1520116295-2-18276474320072761143
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520116294; b=MG1jyptb21LuEVHpNwMs5v09SqSL8bKjsRSXVqbtm+Uykpl
    Mli5mvJdw77YSDM7iX3+4A9LaDKvePgldSBSKXFsolz5g5QryNAnT/KXyVDrsOQo
    iG35PReqCb815w13SdMZ20bXBSr0FKiEr7I88WzKbVb29XTAZH0yrkF9azx1n2cG
    gAR8pZuylHqsuuGH3Ykqv+aWgoLD7yuUY+8R9lo6EytQ0zAWYncA15fOti6aq/eu
    BlgYg+HBD74L/868d9L+0UJy6YsTImyLNOC0apLVeER5JQpKJQPVFgj+0vxFOWJT
    tQCAMRDbLBoCHcHEQlutq/Z5/k+47wI+7lM53GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520116294; bh=wLQr+0
    1yTfCS06q21lXFESjZb4/3/v3xbMzXt/pQC3w=; b=fXPkVS24huvA2umFI1djc8
    jTiaoGoTSwWtEzV0c1quUiKRmMY9XrzaiQS4IRhmp4xxaJetDToxbSqStitkyTKo
    D0IsrKo0YK2nRmpY7cYvaundG0Tbn/ieNE9S7SvB1Mcsz1Z9n1WlfJjEVkCkDMah
    22Yk8qJ23R26gEqDHawZd4CuvwdgmAoMODwkib8nCsb5mrHgxV2+O6+9eLrtFzg+
    9UBPxN8Yyb3G7uKYbIRu2xQ5eR9Wz6f/tldXd+2EUVhzlCEEgjJVm52mEJSOasAF
    fciBr0zQVd/LHkm76v3eNbUWV20UYVK4ua1N+YWgl99YQyC9e0mcsWH4iG0PjSRQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MpHM2TTE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MpHM2TTE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933247AbeCCWbP (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:31:15 -0500
Received: from mail-sn1nam01on0122.outbound.protection.outlook.com ([104.47.32.122]:11440
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933579AbeCCWbK (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:31:10 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 012/219] ARM: dts: r8a7793: Remove
 unit-address and reg from integrated cache
Thread-Topic: [PATCH AUTOSEL for 4.9 012/219] ARM: dts: r8a7793: Remove
 unit-address and reg from integrated cache
Thread-Index: AQHTsz7kJu4Ef8O5R0mlmr3U1SoMfg==
Date: Sat, 3 Mar 2018 22:28:02 +0000
Message-ID: <20180303222716.26640-12-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;7:ijBa2vGO8yALgJVPDLRB2B/cjATUQnKZuQM517gVEHpWtSJLp6GRCDwYAR8dIFHaoupqb603HNlNJJyr/4BAe91AgT6ngo5bWkbKqBxKNHwmABBGSNuBGHDrjZI7Pc518hyiaGB2cxxOtb5fFxaLBI3uxeeojJWVenWVMooqCDax9UF3G8uIFsdw2oSbRzF6QVKuy9SNbVt2yh3uYeZ8mT00eV5thz80F+EASh4kyxGhufgxJUWR/xzLJFBZ0Gix
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b9ad35f5-caa6-4d74-06e5-08d58156737e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0970392C8A23080C5B587582FBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(366004)(396003)(39860400002)(346002)(199004)(189003)(575784001)(86362001)(110136005)(4326008)(6506007)(14454004)(99286004)(8936002)(1076002)(36756003)(2906002)(102836004)(76176011)(25786009)(6486002)(316002)(478600001)(3280700002)(107886003)(186003)(54906003)(26005)(81166006)(7736002)(8676002)(6512007)(81156014)(305945005)(72206003)(6436002)(53936002)(6116002)(86612001)(68736007)(3846002)(2950100002)(3660700001)(10290500003)(22452003)(10090500001)(2900100001)(106356001)(2501003)(66066001)(97736004)(5660300001)(5250100002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: g1HiK4rdXcFF5us6WEcYLCn470lOn2046K4JpJdKdpa1bFT7CSH8BK8kVVkVdsJ1Z406clq1TTRcwQi2diWTFFc0VjaHdX2zl0/eZQYicrrjMBoUfzbrxFfelPG3HTTvNipjzxZae3+uDT/BqJ74t0rJOxvsmUZ0DyRjwxEnAWc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ad35f5-caa6-4d74-06e5-08d58156737e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:02.5725
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

[ Upstream commit beffa8872a3680ef804eb0320ec77037170f4686 ]

The Cortex-A15 cache controller is an integrated controller, and thus
the device node representing it should not have a unit-addresses or reg
property.

Fixes: ad53f5f00b095a0d ("ARM: dts: r8a7793: Fix W=3D1 dtc warnings")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/boot/dts/r8a7793.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dts=
i
index 8d02aacf2892..bd7ee309f509 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -65,9 +65,8 @@
 			power-domains =3D <&sysc R8A7793_PD_CA15_CPU1>;
 		};
=20
-		L2_CA15: cache-controller@0 {
+		L2_CA15: cache-controller-0 {
 			compatible =3D "cache";
-			reg =3D <0>;
 			power-domains =3D <&sysc R8A7793_PD_CA15_SCU>;
 			cache-unified;
 			cache-level =3D <2>;
--=20
2.14.1
