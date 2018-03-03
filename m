Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1379734-1520124550-2-1585551170486600765
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
    t=1520124550; b=sjsVfrP3P6ouTPKiQwrtfFXjRc0UARtFSKY0OtztcKsbI/7
    Y4Kac23znFvza8BkytddL2uEAr/03a+sZYCRuSG89V9oBLYiKaYhLAiMJ0xEmAJB
    5J0OO+FfXW8Qx2MOJsEsyA8gVR/FjplfFInVNp9LpB6gWyz5CYBjO5+GDUKXC7jq
    vgtsJ23BsAooWSq1Iu2hCCIusXg7BuEpFI96XsY1g3e94nMr4RYQ0Kt3glYhrmxk
    HwvpadeGPIcWLtcDZvkA5dFCAMETXISqTQGWOAiKEo1j+Sjjs5hCYAjvCssevDQi
    QLSUlzFpn3XUKJaq2AJHKao5XmYLc9Z5sLJ13QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520124550; bh=gIFdbX
    0lAtZTqpK07AE4miMQ0GdgP2aiPM8xX/HFI/I=; b=q+4savTbFAPVKzZisXlHnE
    TOgk3JaugFfi95c0NboMGLXb4gpQig/lK5djf8zaoxLU36r4DxlkWrzvZqWxqh8u
    2ea2kOLjcr7UMBq5S8+1gn7zJaF/h82xfUaFMV4q++6hLa4vYhukOzxds/upP9v/
    z+957J9DFyC05R9iGrGg6Tsb1B8TQIOUZhNri6HUNDhF5YYAc/ppsb5IM2y9Uz/G
    IlOSYDWw38fJ5wmKm+P+kFI0GcqGYW6a+JseHF6+wjfm7oBN5LjA6d/vuoe0t0/T
    yMwr4mPI71EB5Wg06BTA+Nzhtldw2bEfZIW+XvHcVQh6Y2vB+wlKQUVJGRVOE9Fg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jAPzeY5r x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jAPzeY5r x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932311AbeCCWYp (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:24:45 -0500
Received: from mail-bn3nam01on0138.outbound.protection.outlook.com ([104.47.33.138]:45124
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932193AbeCCWYm (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:24:42 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Simon Shields <simon@lineageos.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 013/102] ARM: dts: exynos: Correct Trats2
 panel reset line
Thread-Topic: [PATCH AUTOSEL for 4.15 013/102] ARM: dts: exynos: Correct
 Trats2 panel reset line
Thread-Index: AQHTsz5dOWeiiiJjY0mvpEaVz7+bZA==
Date: Sat, 3 Mar 2018 22:24:16 +0000
Message-ID: <20180303222318.26006-13-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0890;7:mW7AYdQBFqJKo3eFtpW+aQRMBUp7dpw5UhK0fDvz2f51maNJtyuCEO/qGepXIlltDPTI+lVClWPA4p6IlKsn4HnHAalg5X+M0bhQ4lpLAQSMZyOMq65sbINKpgXPTMKIIo6mN/AEwYMRvieHgC6zzut6cRKpumR172/OnfXggoYm+f2CO9CERhm0G8fKq+p+qebyBXVARYMXpWU4cAsVFKiva8YfPlYOvob+aHXErb2qgsOFjc+dTBKQunjiBq4r
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 41c9a23c-e481-488c-90e4-08d5815582f5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0890;
x-ms-traffictypediagnostic: MW2PR2101MB0890:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0890B1A8BBD33A4EF8648F25FBC40@MW2PR2101MB0890.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB0890;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0890;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(346002)(376002)(396003)(39860400002)(199004)(189003)(86362001)(105586002)(1076002)(14454004)(8936002)(6436002)(66066001)(59450400001)(6506007)(2906002)(99286004)(53936002)(6512007)(25786009)(97736004)(76176011)(6116002)(6486002)(3846002)(4326008)(86612001)(186003)(3280700002)(2501003)(316002)(22452003)(72206003)(5660300001)(2950100002)(8676002)(81156014)(102836004)(81166006)(6666003)(68736007)(107886003)(305945005)(478600001)(54906003)(10090500001)(7736002)(10290500003)(106356001)(110136005)(36756003)(2900100001)(3660700001)(5250100002)(26005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0890;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: mhx7US87QUfetoPqBZ8YG4hVIz1SgFNhOKi/W3GTR7u5hILl7mDoCahBErwuh/e8tI89WDqhe0gDCKNwT+yQ2kEbvCxWY10QWNrCtqGTuiAuMGmXYPR+iah9Bw4GCqejG8goP/CjjP1IJRPkybaCFwF5Sy6TtqdKg/ZL8ss61Bg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c9a23c-e481-488c-90e4-08d5815582f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:16.6502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0890
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
index 220cdf109405..9f4672ba9943 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -454,7 +454,7 @@
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
