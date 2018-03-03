Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520119920-2-11006457132959328688
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520119920; b=HUMIyaAW+dFJlnLU9G6q2aOiDydvs4F0ZykyWKvVxrl+mPl
    z2KPpfMlwDVbVfHREM+TnzOKFAwHYxDAz4wCh4su9LKydIvlpmFl3LuPlkJ3QaI4
    1tgTBgM4iBFuRIlStFYWRIrKLjceqiZPuBdwCMcsw9z+gyEhC0xEnkdc2gfjmp37
    pmSG7Whh359dw8iXbSpkqmfyqQ934qmrGLfyR5/A6jPy9Wec9ZLkol030Hge0RTh
    W73Y5qLZswljsEGzMK9QpvZhPIucWSatIndRVxMVwshkDtka+L55/fPfplwyxX6W
    NZ/RsuE9hmlqqx2CINNpxxeu8lDgWgJB24Fu8HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119920; bh=tS5wfA
    GafwiKL0BNCEJ8naw4CsVXfKKorPN51qnK5IU=; b=sZoBRCIy5pgeJG9OjBzZ0c
    Wt3eWYoE/jiDjAOMRCXROPXKvb6Xq8XkJYPmlnuAdmo/iccodywT5jwt+9P1tAWs
    YGmVcwiUdWsBJIYDt4kKmjzPr6HRL5/WF5uZtQ4SRkqsokk2xMkAMpCqUDxr+Flj
    S7mslxd/nssDm7lWy58+B7rSA/EC85IOYGAndlL2eBucbYvEXPpn2KrDfpx4pDmF
    fE1XJUyr1SlM4RbcnYoKX6ge2QOoarHRKz6jYgOYLgTIqzaFKx9cm1LsAg6IhjiS
    yaK/0VYKFj8p0Qky7unoLUEfaE8uRoTCGLQYBCojFc7Y9H2cG+YAUqjzVilejjbw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ToYtI39o x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ToYtI39o x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933521AbeCCXbq (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:31:46 -0500
Received: from mail-by2nam03on0118.outbound.protection.outlook.com ([104.47.42.118]:7707
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934195AbeCCWgL (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:36:11 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Simon Shields <simon@lineageos.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 176/219] ARM: dts: exynos: Correct Trats2
 panel reset line
Thread-Topic: [PATCH AUTOSEL for 4.9 176/219] ARM: dts: exynos: Correct Trats2
 panel reset line
Thread-Index: AQHTsz8expMdkWJbNEWKkpU1LXWEZA==
Date: Sat, 3 Mar 2018 22:29:39 +0000
Message-ID: <20180303222716.26640-176-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1020;7:3yAtexWh6bhqbTLlTHoZMpJa8Nt8OfEvtx2KzAG9qqm+dIx10mwJua7+cgjk9a7jUqyWePESZ8dWuVG+mgm9//xcQqQC3Oc5oXVdvDHJ0y5IYZwSI+NvtX+bZ6MIhuQrrMaH2c9eQ+QSLRZDOSgB8UvYXeVP4qA2A+ZKyoYhofnW808DxGmSDFCNq2sN0nn6YkwsYcv7dW+wJSA9bmRiHv1Pb7PM6mY57z/B63vaRbanU/T3xp8JEuSnZwgKgMYu
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b22487e7-7611-4054-7d12-08d5815727f5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1020;
x-ms-traffictypediagnostic: MW2PR2101MB1020:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1020F87A0A049F273E080C0FFBC40@MW2PR2101MB1020.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1020;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1020;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(346002)(376002)(39860400002)(199004)(189003)(6436002)(5250100002)(99286004)(3846002)(6116002)(8936002)(22452003)(86612001)(86362001)(4326008)(10090500001)(68736007)(6512007)(7736002)(97736004)(25786009)(76176011)(1076002)(6486002)(2501003)(66066001)(36756003)(107886003)(2950100002)(8676002)(305945005)(5660300001)(105586002)(53936002)(6666003)(3280700002)(81166006)(6506007)(106356001)(2906002)(81156014)(316002)(478600001)(72206003)(10290500003)(2900100001)(54906003)(110136005)(59450400001)(186003)(102836004)(26005)(14454004)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1020;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: pNJXRHSb1g5yJb//J3DL3t+iSspEYz2uxfIahspnZ0EiCcjleQsChDhSI3/e+JCZANTzLzzT9Wau7JRTA+OfsOksmGhjlYNxKYVMfZ9vHUv74dcBjk4WoA5j5w0q4aUWIsGTckdz6AZ2jlevv3996eVZGHGLhf8YbbAeXs+OHGQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b22487e7-7611-4054-7d12-08d5815727f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:39.8382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1020
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Simon Shields <simon@lineageos.org>

[ Upstream commit 1b377924841df1e13ab5b225be3a83f807a92b52 ]

Trats2 uses gpf2-1 as the panel reset GPIO. gpy4-5 was only used
on early revisions of the board.

Fixes: 420ae8451a22 ("ARM: dts: exynos4412-trats2: add panel node")
Signed-off-by: Simon Shields <simon@lineageos.org>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/boot/dts/exynos4412-trats2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/ex=
ynos4412-trats2.dts
index 41ecd6d465a7..75a60633efff 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -408,7 +408,7 @@
 		reg =3D <0>;
 		vdd3-supply =3D <&lcd_vdd3_reg>;
 		vci-supply =3D <&ldo25_reg>;
-		reset-gpios =3D <&gpy4 5 GPIO_ACTIVE_HIGH>;
+		reset-gpios =3D <&gpf2 1 GPIO_ACTIVE_HIGH>;
 		power-on-delay=3D <50>;
 		reset-delay =3D <100>;
 		init-delay =3D <100>;
--=20
2.14.1
