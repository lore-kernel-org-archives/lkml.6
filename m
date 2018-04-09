Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523244157-2-12245387665577596010
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523244157; b=CJFFwYzhSrRlHHVq22M2qneNpYz5k7Os5jRte+BmLWXzy8Mx1i
    CBAjuFT8I3niyNiXXcPOY6lzYY21f1UCuUNtBaVaTEWXeS720NuU5BywLiUP5pA1
    +Dwzv060Tx0KjtQOWyoWQWWIPz6s+DoTtVFwnC2lQ7wxc2eivq3R9rLGQxhzkXvs
    0GppZhB8itgAieKdoUV/JZZNuMSwu+ApMfYyBhIZzJT/n1uVyGwE1aWpCeXKVkgQ
    aj+TeQHRuPMGHiSLxRiB+BHwgbh1uDTXaRO6KRzemGL7zCoxNzpbFGfaoV0S2Rer
    6h5LC21x0tgcxe68v0zpmQWBFtmxmKp4nEVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244157; bh=rWThu3jr1I
    8EvsF6RDs86jM4LlV13ElKJ9DwU5jN4K4=; b=L/5tD8Q3j5791mgTGoCxrCM0UW
    NGNz/ftYSqHpKckID5lkeKqWnEqrgWe8MxEnZGUQJzhW/vGZs2yUCBW96M4p9nAL
    7gL0ojC4Aoa6hSEpYsdQX+KGIRYcx4jf5h94ZvT98gyb2tBFGSXlHtDKP9u+6dt1
    xH6SNBTErAJJ+KIKGmBy4oP53tD8M5E1YFe7D+nmp2Z0gSzNPCEXiAcQw0VjXm1L
    0SnA4EMmOO9Nv6Xoj3Rc0UK5C2nuUKfQSiYUJ+xuza5bSm3X9hexYjKgynksTsB+
    MZ550stzYBMEIXr7lrDPvPOdeZWsRkFu+c6iGtnAJYCgPGv56Jm+ESUylJqA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PyL620oD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PyL620oD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPH/29ots1ARCMiRFv3+DePaX0EkgxqRs0skiX9maPMkm1QZg4Uc01RPtQzUO0Ene746KX5zV0wrsUbxQqFo1pc9rV6qTOBuvLf2+T6lcSXSDg+HYH33
    quiD06VrVuJULi74tPvBqHolh0s8JvqGaZZuHHlDLZu9cX67xSqlIhXkbEOVGN1MiNl+psEgAY0RwH8Xhsrs1XgksPOEfRt8YWROFC+3OqazjQm0H+teq8xa
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=ER_8r6IbAAAA:8 a=LpQP-O61AAAA:8 a=WPyIoOwQAAAA:8
    a=EHaNKQqtAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=PIe8psd_NT3qpsEeU0EA:9
    a=wPNLvfGTeEIA:10 a=9LHmKk7ezEChjTCyhBa9:22 a=pioyyrs4ZptJ924tMmac:22
    a=S-HzPIwwDS8t1QcwSuWs:22 a=KIA0-nbnOXq3vJi0w304:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752235AbeDIDWW (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:22:22 -0400
Received: from mail-sn1nam01on0134.outbound.protection.outlook.com ([104.47.32.134]:37792
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754755AbeDIAWy (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:22:54 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 042/161] clk: ingenic: Fix recalc_rate for
 clocks with fixed divider
Thread-Topic: [PATCH AUTOSEL for 4.14 042/161] clk: ingenic: Fix recalc_rate
 for clocks with fixed divider
Thread-Index: AQHTz5iKJStlnLPab06IcEbPJ4Cn5g==
Date: Mon, 9 Apr 2018 00:20:19 +0000
Message-ID: <20180409001936.162706-42-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1014;7:Rax+blONOPe5nqRofZs05kTHyiVjDiTphE+FrOpy6daWm3SaETJS23+lUeTZqy68qcMMdUiVqwaxqQ/YzeZ3MqI+GJ9dFvMn0BQ6iDCdRE6YOOmpilM+hrRW6JWg2d7YndqjOCJxq09dAxfDdGJDEAAektceL90V0bPvlfiRa74OWD/09omZGGLA/u2s6+zUZzLAqf05N+tOHxd2lK3NFfDq0XbXX0duP3zO4DHCCWqaSHGc70hSggPEW8Yh7nnD;20:s09wohf5L8deFyNu75N1JqAY0hGF3/KRuI4EedQ9UkKLsGujCyL8xf0rjULo3TfYd5O49L/d22QcWNnXzX7Jdm0YvVPr4ORFXMmuWBekYG3PtuH3k+hdcL8c9FSQBb2a1v+tzWDqbPgzpBnh1ccygIq0JlyLe6yLNWrvH8TFy/4=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2b1d2b7e-24dd-4eaa-f57f-08d59db0081d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1014;
x-ms-traffictypediagnostic: DM5PR2101MB1014:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10142792160EE3FEE445F403FBBF0@DM5PR2101MB1014.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1014;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1014;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(39380400002)(396003)(376002)(189003)(199004)(81166006)(81156014)(478600001)(6436002)(72206003)(8936002)(10290500003)(106356001)(99286004)(86362001)(2616005)(7736002)(2501003)(6666003)(446003)(476003)(8676002)(11346002)(105586002)(305945005)(5250100002)(6512007)(53936002)(68736007)(6306002)(107886003)(66066001)(86612001)(966005)(2906002)(14454004)(186003)(22452003)(25786009)(4326008)(2900100001)(486006)(36756003)(6486002)(3660700001)(54906003)(26005)(3280700002)(110136005)(1076002)(10090500001)(76176011)(6506007)(97736004)(316002)(3846002)(6116002)(102836004)(5660300001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1014;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 7QewX96dVr1e9Vb6yf9VqK06ZrLqOmUZDfqDLDkePJZTOrnPMB8bipsGdi3NAbAPF18Nl3gBXGcq0Azb7dAdULOTSbWdyv4YwneB+Jiw0zQ7mZcvI6eawILlb95IK1ja9vBWmSpFTNkvYs5hr4UjsOw5OV+nGsGj4aZBJUEkBmVmCEwo0qOx5/ayiVz0jaUUZ4MA2aksK0UM1Q4kU01FW3zCMrdAT2uzE+kty1QFgyf/Zmvis6UXgC6+G1R0pPmjFQ+UqzfnDqr9PRkWnrZWp8175iFefDwlO+aUW0yRPiyf/3KRBCpJ0f9uCpi8qgvvbF+dR4X0I23kAKDC44ASJmArxjDC83fQ2/IafaVSAZ3Q2iMu8H9Hwj1aUktC9m7V7bJRTHviTE5P4dsVRlKXYnfPXbR8F8pzUx8P3LHcDVA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b1d2b7e-24dd-4eaa-f57f-08d59db0081d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:19.1132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1014
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Paul Cercueil <paul@crapouillou.net>

[ Upstream commit e6cfa64375d34a6c8c1861868a381013b2d3b921 ]

Previously, the clocks with a fixed divider would report their rate
as being the same as the one of their parent, independently of the
divider in use. This commit fixes this behaviour.

This went unnoticed as neither the jz4740 nor the jz4780 CGU code
have clocks with fixed dividers yet.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Stephen Boyd <sboyd@codeaurora.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Maarten ter Huurne <maarten@treewalker.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/18477/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/clk/ingenic/cgu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/ingenic/cgu.c b/drivers/clk/ingenic/cgu.c
index ab393637f7b0..a2e73a6d60fd 100644
--- a/drivers/clk/ingenic/cgu.c
+++ b/drivers/clk/ingenic/cgu.c
@@ -328,6 +328,8 @@ ingenic_clk_recalc_rate(struct clk_hw *hw, unsigned lon=
g parent_rate)
 		div *=3D clk_info->div.div;
=20
 		rate /=3D div;
+	} else if (clk_info->type & CGU_CLK_FIXDIV) {
+		rate /=3D clk_info->fixdiv.div;
 	}
=20
 	return rate;
--=20
2.15.1
