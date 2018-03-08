Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1171329-1520492634-2-4555145846104610452
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520492633; b=VFjyJlmfiFrlvOCCkeN7a7ZKB2EbaDSI+C57zrPI3b4cMdM
    OoLF+0b2JnlbgUwNro8ivnm0saqNfpkkSsbMJfWKigctGMCUM+xKH2v/fFXK+96x
    Es7iU+eOwiAgxlrPjwyS+XLEvpBc8Qmoa8IasXbHUTVeEmk2rw8LQy1Dku2AnHSz
    MajC8ryTlC80BW/WV+7WQ+nJ/lRRARWC9BS88eQrPVN2RCNTOPvZXBRm8u0X6NR2
    qaaRWeafXYvVrX+/+yLHbOOxIdW79hxojFTOTmOMQjT8l2Xeoj9/A+YCHvA/QStS
    7yYyDX/hm/KfJv0/kzj5L4hSSiyomB9tcVC4amA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520492633; bh=NbwClY
    HcGl2iVLBaur5Np7VVD3WQVd/3TT4LvjP/DLQ=; b=lxbTtT+iD/zlyf1fxKW9PF
    vRLuDuEHsXngCIfR7PjfxD1qkaUDi1LNwVpRdgzHJ3tomr7/yiuREpzbifEM1sNi
    f4A6V6jM5jU0PqK/xpJhCjwCN+U9gL6Yu46NvSMykzdJ9jiGuGQgBZFbEKVbipKc
    MyDdsb38m/5rXxzvTqxfEhJHDp3wW6vqCwJbEuI70JHonrnbJ8pho3XV6JvKwQqC
    U9iXP6zEC5pAKxI2nh57ZjiWtsUICO3rMmf2tGX3F+gwhtOQdQUWlp9S/HGlYgPz
    rsoOzU1GR0w97zpgpICVMhNwoFmIVX3bkCjVtm9niFMXJnjIrX5UzTtt7l1uV/vw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZHu7J3na x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZHu7J3na x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934577AbeCHE5L (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 23:57:11 -0500
Received: from mail-bn3nam01on0102.outbound.protection.outlook.com ([104.47.33.102]:13054
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755212AbeCHE5I (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:57:08 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jerome Brunet <jbrunet@baylibre.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 36/78] net: phy: meson-gxl: check phy_write
 return value
Thread-Topic: [PATCH AUTOSEL for 4.15 36/78] net: phy: meson-gxl: check
 phy_write return value
Thread-Index: AQHTtpnKj1bzUDm9ckao0zJwpMWJ8A==
Date: Thu, 8 Mar 2018 04:56:17 +0000
Message-ID: <20180308045525.7662-36-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1079;7:LDmgMeLCNkdCeIxdXzUEhFU9B0JiKQGeKgzFS2WdqjdZXOE/mGqCpjz+Ca0/MNOI6fQZAR2j8F7mJDrjo7IxBT6HqB6Y7/3OUnjICUCXtFWjbZfmmzUXl5H6L44oxXG/qjBzdfCbmi/ljn/2LVw4+BkLiwFcfOBtuHuxmsJfVO2vlVU4O5sVrqG1F4QPRgr3+0aqQoFjgYVGycEotgqGO4nv8metKAn84y2oXGWDVgsUY+2wXkjZ6mVoG92+p2Cf;20:Crwx0ZDTHXaF1XSbIs4HGyBeMzSJ1Da26mE1FCyQbPjg04xzy/PY1LIKN0cELWq8XWCzNlb9nDzdW3qohEp2FDs3SsNRApQwHIFERwQXeyhOPymFg/4LYw94X86FZJQ1zPc+zB343SOalb4HDojOR1qkOCzatbSXi9aHBaEPc6I=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f39dd92f-7ccd-45a8-3ab8-08d584b1094f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1079;
x-ms-traffictypediagnostic: DM5PR2101MB1079:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1079298A0BD9D2D3727B3BDFFBDF0@DM5PR2101MB1079.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB1079;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1079;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(39380400002)(396003)(346002)(366004)(189003)(199004)(36756003)(107886003)(4326008)(97736004)(2906002)(2950100002)(1076002)(6666003)(105586002)(7736002)(186003)(3660700001)(5660300001)(106356001)(305945005)(6512007)(3280700002)(25786009)(14454004)(575784001)(86362001)(86612001)(81156014)(10090500001)(76176011)(26005)(99286004)(66066001)(102836004)(110136005)(81166006)(72206003)(54906003)(5250100002)(478600001)(59450400001)(10290500003)(6116002)(2501003)(8936002)(68736007)(53936002)(6506007)(6486002)(8676002)(6436002)(3846002)(22452003)(316002)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1079;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: trZsldvG004wsoXW1HQmlt9JxJLkm4aABWXE6eV5T/Ew7GUb9jfomcEBS+s74eVy+XVRDZZJgj4z6SRday5+mnNEfcVFFd40hma/b5WvbaaLPS2i6Wy/Zga5A2dWxYZ3UefSPv6PHSJ1K85yGexje+HGKhvUPGM/fKT41lGdGdQxXPoO9D2Wvqwr6k5DjlqQh6lGmxaY/QUY+MAiyLvoNNeqQ0cZqaqx9BbaSBNAMD7XoJjQ/fM4zgzqfzmJ6yPgX32sYy4KZfopjKbmc30WMUaGzgwi2kuQtHcBcLA5UaJqotnzUZ6hqkMHSSNh6L64emK63HSrY7d2AR0YW+8E0A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f39dd92f-7ccd-45a8-3ab8-08d584b1094f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:17.3480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1079
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jerome Brunet <jbrunet@baylibre.com>

[ Upstream commit 9042b46eda33ef5db3cdfc9e12b3c8cabb196141 ]

Always check phy_write return values. Better to be safe than sorry

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/phy/meson-gxl.c | 50 ++++++++++++++++++++++++++++++++++-------=
----
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/drivers/net/phy/meson-gxl.c b/drivers/net/phy/meson-gxl.c
index 842eb871a6e3..f431c83ba0b5 100644
--- a/drivers/net/phy/meson-gxl.c
+++ b/drivers/net/phy/meson-gxl.c
@@ -26,27 +26,53 @@
=20
 static int meson_gxl_config_init(struct phy_device *phydev)
 {
+	int ret;
+
 	/* Enable Analog and DSP register Bank access by */
-	phy_write(phydev, 0x14, 0x0000);
-	phy_write(phydev, 0x14, 0x0400);
-	phy_write(phydev, 0x14, 0x0000);
-	phy_write(phydev, 0x14, 0x0400);
+	ret =3D phy_write(phydev, 0x14, 0x0000);
+	if (ret)
+		return ret;
+	ret =3D phy_write(phydev, 0x14, 0x0400);
+	if (ret)
+		return ret;
+	ret =3D phy_write(phydev, 0x14, 0x0000);
+	if (ret)
+		return ret;
+	ret =3D phy_write(phydev, 0x14, 0x0400);
+	if (ret)
+		return ret;
=20
 	/* Write Analog register 23 */
-	phy_write(phydev, 0x17, 0x8E0D);
-	phy_write(phydev, 0x14, 0x4417);
+	ret =3D phy_write(phydev, 0x17, 0x8E0D);
+	if (ret)
+		return ret;
+	ret =3D phy_write(phydev, 0x14, 0x4417);
+	if (ret)
+		return ret;
=20
 	/* Enable fractional PLL */
-	phy_write(phydev, 0x17, 0x0005);
-	phy_write(phydev, 0x14, 0x5C1B);
+	ret =3D phy_write(phydev, 0x17, 0x0005);
+	if (ret)
+		return ret;
+	ret =3D phy_write(phydev, 0x14, 0x5C1B);
+	if (ret)
+		return ret;
=20
 	/* Program fraction FR_PLL_DIV1 */
-	phy_write(phydev, 0x17, 0x029A);
-	phy_write(phydev, 0x14, 0x5C1D);
+	ret =3D phy_write(phydev, 0x17, 0x029A);
+	if (ret)
+		return ret;
+	ret =3D phy_write(phydev, 0x14, 0x5C1D);
+	if (ret)
+		return ret;
=20
 	/* Program fraction FR_PLL_DIV1 */
-	phy_write(phydev, 0x17, 0xAAAA);
-	phy_write(phydev, 0x14, 0x5C1C);
+	ret =3D phy_write(phydev, 0x17, 0xAAAA);
+	if (ret)
+		return ret;
+	ret =3D phy_write(phydev, 0x14, 0x5C1C);
+	if (ret)
+		return ret;
=20
 	return 0;
 }
--=20
2.14.1
