Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153505-1520116149-2-7538278665642614987
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
    t=1520116148; b=ajW8/nbDscGq4PnHY4LEnm5CIRLVg+/gypNDuHEyWG2tSZc
    NlFN4ksHyjp1dzw+zjypvNgTQSq0Ns2F7OInU5UvjnraubHD0UNaS7S+vrXsPkiZ
    FhIBVxci0+tFi4NIQ/QBqUKGGv+XFACmKnfXEA7he4IZTvLba4T9nGJACeXwc/cG
    dQw5Jazk6P7vi6VhBuBwe89OCPI/44VmUE8qunqb+YHo9UzpUitscVndD822TQ89
    X3MWFs099zKgqLKM6QPEnFLWExyeC4aHXvNmsoEiUhbixxnjLX6D7DUy3hEeqs1/
    /eLfjjq56se85oSof/g9L3A6aAF08aM3XQjVmAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520116148; bh=JBZn8j
    8cR5UTnGLp6r/4c0VKcz9B2k6P7Skxveoow6g=; b=vzuzN6+3zXGG42RPOYFP+p
    rwQwMlZliuixiOSzkb8hpGEORFuUAeJ/JkflsC8QiPfM0NerQlN1urkd+duk4FVc
    RvP622xozKNuavEXKfkMc0z6VGJKppVHXSd70PnhwBJnV6dtx1R2/FLPMWDuxjNk
    wTIa1p8GOomVYkA5VnH0sQjlbUdoHu/hS0w8suxToqv/D5SN6MCjm9Cx7yC+Ungt
    xGNUTcBNoMAuUHKgXphZADES/AUi4BX0SFLRpUjHHb3zF33E8Z04ogPIjZJSXDGb
    QIlV7b+7I5W1ifufMmhTo2oiqjACo7l+2b85D/vsHeUpuaBRegi5pM75a5hNAY5w
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZminENQl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZminENQl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933264AbeCCW24 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:28:56 -0500
Received: from mail-by2nam01on0114.outbound.protection.outlook.com ([104.47.34.114]:45301
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932402AbeCCW2y (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:28:54 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Tero Kristo <t-kristo@ti.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 31/84] clk: ti: clkctrl: add support for
 retrying failed init
Thread-Topic: [PATCH AUTOSEL for 4.14 31/84] clk: ti: clkctrl: add support for
 retrying failed init
Thread-Index: AQHTsz6mAopMc8HQzUq/v4zqnntPUw==
Date: Sat, 3 Mar 2018 22:26:17 +0000
Message-ID: <20180303222518.26271-31-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1115;7:vPHI9t6foG7H2vAf6F6sf6hA5yfJuVIb35NEaed2X7ASaAfC9bfGf5jRjlPCgzc/PFKY2m9tnKzzqUYixMD+YUWxvDAzToNCIcc5/EfOKycpakaz3cRzCeecYhWEgwXLzAcB5pjodFIv0VBujSxQnOLPGqUScCUGb06i0xODr+DwDOl+K0XGruS34HJsb99EhrUy0bQ0XoFeLMof1tPWuOvCtTdUbVO8IXxGQUYd0lA+wIISuuHJnztPPPnpemzy
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 29be0356-2888-4784-6201-08d58156250e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1115;
x-ms-traffictypediagnostic: MW2PR2101MB1115:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1115B838CB67B33278201468FBC40@MW2PR2101MB1115.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1115;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1115;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(39380400002)(189003)(199004)(26005)(97736004)(186003)(2900100001)(316002)(59450400001)(6506007)(102836004)(36756003)(110136005)(106356001)(54906003)(72206003)(4326008)(8676002)(81156014)(25786009)(2950100002)(6666003)(305945005)(10290500003)(5660300001)(107886003)(14454004)(8936002)(3660700001)(3280700002)(105586002)(81166006)(478600001)(2906002)(6116002)(3846002)(1076002)(2501003)(6436002)(5250100002)(6486002)(68736007)(7736002)(10090500001)(6512007)(66066001)(53936002)(99286004)(86612001)(76176011)(22452003)(86362001)(22906009)(133343001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1115;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: /V9tTynIya6JBFsudccbZ0KE1WJbrvPCg9Ae1eUuZ0T6s4k9vtAn7hVXezh5IHSV1tuTbbyzbdWB3TKNaxkzQ31MnEwhNZ1tBLOf4VS5ctjzDpbh+QA9yKxRudKe1rDLS1D5SGvEB+3RTs071j3gQzpJFmyX9OHMoH8P2TPmO04=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29be0356-2888-4784-6201-08d58156250e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:17.9004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1115
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
