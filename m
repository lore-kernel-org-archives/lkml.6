Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1379734-1520124148-2-15389447265684629481
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
    t=1520124148; b=fE8GI8hBVQuwTtqnrmtSfUPdtrZG85r9gIel6hJ0oUyQjSD
    jy6mPoVLptrJsiJV4ootkqoFuU/Btpe6byU/NiEiHkYs5XOjzyM9tfpRuD98XEWr
    n8KjcGJEFgzs/8Jfl5ysNAroqc//Ts2R0f0JWYMJfYH2aO7xzHRDH0WzxIBYKwoK
    37CRaDeKURhb22m84h/tizq4psQqSJ00s8ZsYhLRH/JW7D/qFelz9doD4KOLqU+8
    c3FmmqKOcNzx/IHP66+Y5gRRB+KV9eHUq1k/K4LqFmB9/kjplEp3zAWhdO4gtxBI
    VxqEswkV4vbKg/EsVFYBTObAxLQ3KhfEkNDdNbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520124148; bh=JBZn8j
    8cR5UTnGLp6r/4c0VKcz9B2k6P7Skxveoow6g=; b=foANIqexqn6ZoEkYbiV5ru
    5jNGXdDKWlapJKSjaz2DQTAxIMdxH2vqsGWNgAl95VNuJz7oKSCshSwD8xI53ere
    Lt/ErIIRIB11QJ5M9sWXyYf2NIBJHzq/9Gm3WWLYaB8aUI2rkvSjTzPD3FJPNLnW
    6fQ23GrLSZcKl//J0LVCUPK5ne9ApFrYiFM0PFNIaaZT54/AuXRnnCNzcK34737M
    iTWH3zbtgZ2Lhufp4Rtb7T+ZFUENXB0nTErhYx+iWBpBPqDgjBGmED/OitXyxrLC
    XdhM4lLM+l2l+RLr2AhCJ11ET7vKmKLCajq93SH5BiN6wpPcLC92Lqu2MI6WlKRA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AEHUk/Ur x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AEHUk/Ur x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932613AbeCCW0P (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:26:15 -0500
Received: from mail-bl2nam02on0099.outbound.protection.outlook.com ([104.47.38.99]:14560
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932577AbeCCW0K (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:26:10 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Tero Kristo <t-kristo@ti.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 042/102] clk: ti: clkctrl: add support for
 retrying failed init
Thread-Topic: [PATCH AUTOSEL for 4.15 042/102] clk: ti: clkctrl: add support
 for retrying failed init
Thread-Index: AQHTsz5nzm4BvvZGl0q5zfiDH2sxAg==
Date: Sat, 3 Mar 2018 22:24:33 +0000
Message-ID: <20180303222318.26006-42-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHSPR01MB353;7:yEF7sRihUCq27q9cjkP8Hv8ZfRcZMPYMVXvpbjr0xi29sXigIALO/kM/XfMye9HfoBQf5/hGrTfTPHuG9aWtynnSJdgr72tpwsQ5J2NIj9vL7r1GudaCL4d1UO1Lmjo5tIfAEUaOWzq04utNHdwFARltf0HzS24eJoqSMAKuehf6IoYzTj1XOIXRP9cw2G86bLZLfsAKSlUFazTle2cYZRbhscXjbzJdinQRk1SsoUwwe2mPM2MgAIKOebWcAM1w
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 69d8d4df-2cbf-43b5-1443-08d58155c028
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MWHSPR01MB353;
x-ms-traffictypediagnostic: MWHSPR01MB353:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MWHSPR01MB353C056BA0F202540759B9AFBC40@MWHSPR01MB353.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MWHSPR01MB353;BCL:0;PCL:0;RULEID:;SRVR:MWHSPR01MB353;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(39860400002)(39380400002)(199004)(189003)(6506007)(8676002)(59450400001)(8936002)(36756003)(105586002)(2900100001)(3280700002)(81166006)(81156014)(99286004)(6116002)(1076002)(316002)(110136005)(26005)(3846002)(72206003)(5660300001)(102836004)(68736007)(305945005)(10290500003)(76176011)(86612001)(2906002)(478600001)(7736002)(14454004)(86362001)(3660700001)(186003)(97736004)(54906003)(6486002)(6436002)(10090500001)(53936002)(66066001)(6512007)(25786009)(2950100002)(6666003)(2501003)(107886003)(5250100002)(106356001)(4326008)(22452003)(22906009)(133343001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHSPR01MB353;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: GtJIDaq5pFL4k94M4OhroMvqObjkx/VG8OgqEAfEe5z9cu9Lx2L+7ZNLRDBg0X/wzpUXUCHyEKKeMvZ/ZJyBO5gU5N1G7/LGY0Vo3pASiuu12uq/EnMFxO4XAbqWfYppKLSGJjJ3ZJBRe7iUkXpTOAsGV/ExuILSdDrdfPuxLdM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d8d4df-2cbf-43b5-1443-08d58155c028
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:33.7596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR01MB353
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Tero Kristo <t-kristo@ti.com>

[ Upstream commit 729e13bf58e643b9accd2a14c55b555958702fb0 ]

In case the clkctrl node contains assigned-clock-* entries, registering
the provider can fail with -EPROBE_DEFER. In this case, add the
provider to the retry_init clock list so it will be cleaned up later.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Acked-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/clk/ti/clkctrl.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/ti/clkctrl.c b/drivers/clk/ti/clkctrl.c
index 53e71d0503ec..e7c51bea97f7 100644
--- a/drivers/clk/ti/clkctrl.c
+++ b/drivers/clk/ti/clkctrl.c
@@ -400,6 +400,12 @@ _ti_clkctrl_setup_subclks(struct omap_clkctrl_provider=
 *provider,
 	}
 }
=20
+static void __init _clkctrl_add_provider(void *data,
+					 struct device_node *np)
+{
+	of_clk_add_hw_provider(np, _ti_omap4_clkctrl_xlate, data);
+}
+
 static void __init _ti_omap4_clkctrl_setup(struct device_node *node)
 {
 	struct omap_clkctrl_provider *provider;
@@ -411,6 +417,7 @@ static void __init _ti_omap4_clkctrl_setup(struct devic=
e_node *node)
 	struct omap_clkctrl_clk *clkctrl_clk;
 	const __be32 *addrp;
 	u32 addr;
+	int ret;
=20
 	addrp =3D of_get_address(node, 0, NULL, NULL);
 	addr =3D (u32)of_translate_address(node, addrp);
@@ -485,7 +492,10 @@ static void __init _ti_omap4_clkctrl_setup(struct devi=
ce_node *node)
 		reg_data++;
 	}
=20
-	of_clk_add_hw_provider(node, _ti_omap4_clkctrl_xlate, provider);
+	ret =3D of_clk_add_hw_provider(node, _ti_omap4_clkctrl_xlate, provider);
+	if (ret =3D=3D -EPROBE_DEFER)
+		ti_clk_retry_init(node, provider, _clkctrl_add_provider);
+
 	return;
=20
 cleanup:
--=20
2.14.1
