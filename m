Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523234320-2-17769021204779532947
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523234320; b=BuZews0IieWi7zPln3RqHlBNrnjByt2yZO0On02bCbWhp8eJKM
    VZPY2+EgOJt+s3rwiu0hWs2noBsXskEFoiisDIs1ZprvT8B7nMKKhj2GoaMA6Lh/
    TZeOML/EicDhXqhIzXSwwVM2Bbm17i9Aun3fHZ0/ndsYobYGTy43V3pcUCbjI7aM
    p1p41k1KkvNqTgTXuuyzIJKUkxpDXWlh4utf1cxYlDZJmX3mrTxL0ttBsaAfp1pC
    ct47l/y9w/TNpPZpc6T6o6PKry1OIjPkfMKR1v1w9YFm10Qlwk3RjU5+agTDz0It
    s4mgReIsE+suDxSvisXUWDYtY3SmTrjYPN9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234320; bh=xGUUxqJKGp
    q3k+FUKvlOFQM9Ljfl+xyqerXYD4bhT2o=; b=M0fUrb8EacUIxQ4HYgazl8W6x0
    y9e7aWv3+6jefXGqpS8Iqoqf6hXYMgjppaeMB4GTRPCZL7V9KQfKc4vlbYZJmCtb
    rdMy8IOd0pbAGnC+S5uOopNRWZjNbazPAti7KdYf+Jl61GZed7Uusj16u9QdFCDf
    XBogdVoi8crRZiTgV+Y0dhAKR5qzNoRsSenSIagL3WuvMngbc9qpAexyDrYvPH9F
    Kw4a4AbE0Jvv8WAVWp4FGMkI1VyASHGMLWDrsKE2frbb95WU3yxhVKP2liQrcWxj
    olQDcseFQdHrHSvecSo3zhafip2dVQVJssAGsWjw56pPtSxHD/dYIXQOT7gg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GFVDc+Il x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GFVDc+Il x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH135/+LQhJSMjJrmfRSZJ4o+5+8x5OsOCq5iGuLDT8KnnfRZ9OKFFvbBAy+M/eEM7yFEMhUtJghuPoHeV/PtV9dUJJvC82OVhHaJB9RdhUJ8xYbbhpI
    RBKVju60Fz5c1nKRSeKnxFKZiUk6+R4z7ys7hcwUjLHM1QuYEJwKyuYZEfEfh7ZCuVdnkw04qg2Y885BmHZt79OjPSLOHpYozMq2RovrPGsR1Mx7Np+HPAJP
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=c-n4J4-pAAAA:8 a=yMhMjlubAAAA:8
    a=RBgMQm25thbOlHJsUAEA:9 a=wPNLvfGTeEIA:10 a=L0NDqeB7ZLmQzAogN4cw:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932906AbeDIAiU (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:38:20 -0400
Received: from mail-by2nam01on0113.outbound.protection.outlook.com ([104.47.34.113]:17312
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932913AbeDIAiC (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:38:02 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Ulf Magnusson <ulfalizer@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 120/162] kconfig: Don't leak main menus during
 parsing
Thread-Topic: [PATCH AUTOSEL for 4.4 120/162] kconfig: Don't leak main menus
 during parsing
Thread-Index: AQHTz5nLpef0xzqSkU6fpI7MrRxxNA==
Date: Mon, 9 Apr 2018 00:29:18 +0000
Message-ID: <20180409002738.163941-120-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1110;7:gmtt7YNEt4x594heTiy6TJpUr7mcDsKCLDJB8Elm6GwrYoUIVJ/w5inGWHarrse404tmEpA8DNZba0KwYxy/2APjFhWkR8APbslvME3pWTvDbvOYiVTkWz7Pbww2EYayzYZwiKa9CY/FuQxcw9eREvvaZTvCfgCa9Rbk4UlDZnhrt7Lr02SGjcXspSNxw4Du9NACaRSHK0NKMGLOQQLUTAM/yXAFnU5Cv9KLjS0ZZkLylU2bI89QKUM1LNUtK8YB;20:G8gf/0l8UPmWX7hVJlOLv1+W6NoWweFxTFH8EE+pyxQ0wpLqdE1SdIY5yLgjgbCp/Rk4K5Z3IiKT30EO+9nsL9AEQR0jRb5AHY2V1oEj9Mek2jO0VNGr9H+ASntoTNTLiBD+lp6m9uey4iv+K/whL6EBjUGcvueCQz14KPSFSLY=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: c5d4d4b0-3ef5-4115-6820-08d59db2256b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1110;
x-ms-traffictypediagnostic: DM5PR2101MB1110:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1110DA4DF8C3103549E2A69AFBBF0@DM5PR2101MB1110.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1110;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1110;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(346002)(396003)(376002)(366004)(199004)(189003)(53936002)(186003)(5250100002)(105586002)(11346002)(99286004)(476003)(66066001)(6512007)(86362001)(3660700001)(1076002)(54906003)(68736007)(110136005)(3280700002)(39060400002)(316002)(305945005)(4326008)(107886003)(22452003)(14454004)(7736002)(446003)(6666003)(2501003)(10290500003)(3846002)(6116002)(72206003)(106356001)(25786009)(6486002)(6436002)(8936002)(478600001)(5660300001)(86612001)(8676002)(81156014)(59450400001)(2906002)(102836004)(81166006)(6506007)(2900100001)(76176011)(2616005)(486006)(26005)(36756003)(10090500001)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1110;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: EwDwLcLEivMf4LJFT5zUlD0dsokrt6qddvZSv5DEh6/tiq0tM0YpSB46qMFML6ZoL9KwTX7q7IaeVyeilEKbITjPBH74KapVXZloYz+XMFTroDUdyoIviOcu4QyNmV1prr4ee12/DE2bBMdsdHtDGdD0TrzTpA04PipgDu1z6+WIwpn9JTyRfJt9yRoSKt3r8tpWm4CxDiSVjAssJ+K/qU9BLBhgY7dVPJDLcIoy3U6vX8Tf6x8g+N1te0mtcuG5XXw7+VyVSi7KHS8EtdSyTN6cq69UONuFDxsk3Gs1Kpkg4OfLc63ydt0n7K6FdW3K4jmv7JvcGDeOgjyP+M6iSMHvsc5qL12hpvqgMoF9nDyVEEei7Eo++FCGz5BpyvfrGIl1cZL26STlkBJyZsE8cuZ4qhLQh51GPwePUitNsrQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d4d4b0-3ef5-4115-6820-08d59db2256b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:18.2243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1110
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ulf Magnusson <ulfalizer@gmail.com>

[ Upstream commit 0724a7c32a54e3e50d28e19e30c59014f61d4e2c ]

If a 'mainmenu' entry appeared in the Kconfig files, two things would
leak:

	- The 'struct property' allocated for the default "Linux Kernel
	  Configuration" prompt.

	- The string for the T_WORD/T_WORD_QUOTE prompt after the
	  T_MAINMENU token, allocated on the heap in zconf.l.

To fix it, introduce a new 'no_mainmenu_stmt' nonterminal that matches
if there's no 'mainmenu' and adds the default prompt. That means the
prompt only gets allocated once regardless of whether there's a
'mainmenu' statement or not, and managing it becomes simple.

Summary from Valgrind on 'menuconfig' (ARCH=3Dx86) before the fix:

	LEAK SUMMARY:
	   definitely lost: 344,568 bytes in 14,352 blocks
	   ...

Summary after the fix:

	LEAK SUMMARY:
	   definitely lost: 344,440 bytes in 14,350 blocks
	   ...

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 scripts/kconfig/zconf.y | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/scripts/kconfig/zconf.y b/scripts/kconfig/zconf.y
index 71bf8bff696a..5122ed2d839a 100644
--- a/scripts/kconfig/zconf.y
+++ b/scripts/kconfig/zconf.y
@@ -107,7 +107,27 @@ static struct menu *current_menu, *current_entry;
 %%
 input: nl start | start;
=20
-start: mainmenu_stmt stmt_list | stmt_list;
+start: mainmenu_stmt stmt_list | no_mainmenu_stmt stmt_list;
+
+/* mainmenu entry */
+
+mainmenu_stmt: T_MAINMENU prompt nl
+{
+	menu_add_prompt(P_MENU, $2, NULL);
+};
+
+/* Default main menu, if there's no mainmenu entry */
+
+no_mainmenu_stmt: /* empty */
+{
+	/*
+	 * Hack: Keep the main menu title on the heap so we can safely free it
+	 * later regardless of whether it comes from the 'prompt' in
+	 * mainmenu_stmt or here
+	 */
+	menu_add_prompt(P_MENU, strdup("Linux Kernel Configuration"), NULL);
+};
+
=20
 stmt_list:
 	  /* empty */
@@ -344,13 +364,6 @@ if_block:
 	| if_block choice_stmt
 ;
=20
-/* mainmenu entry */
-
-mainmenu_stmt: T_MAINMENU prompt nl
-{
-	menu_add_prompt(P_MENU, $2, NULL);
-};
-
 /* menu entry */
=20
 menu: T_MENU prompt T_EOL
@@ -495,6 +508,7 @@ word_opt: /* empty */			{ $$ =3D NULL; }
=20
 void conf_parse(const char *name)
 {
+	const char *tmp;
 	struct symbol *sym;
 	int i;
=20
@@ -502,7 +516,6 @@ void conf_parse(const char *name)
=20
 	sym_init();
 	_menu_init();
-	rootmenu.prompt =3D menu_add_prompt(P_MENU, "Linux Kernel Configuration",=
 NULL);
=20
 	if (getenv("ZCONF_DEBUG"))
 		zconfdebug =3D 1;
@@ -512,8 +525,10 @@ void conf_parse(const char *name)
 	if (!modules_sym)
 		modules_sym =3D sym_find( "n" );
=20
+	tmp =3D rootmenu.prompt->text;
 	rootmenu.prompt->text =3D _(rootmenu.prompt->text);
 	rootmenu.prompt->text =3D sym_expand_string_value(rootmenu.prompt->text);
+	free((char*)tmp);
=20
 	menu_finalize(&rootmenu);
 	for_all_symbols(i, sym) {
--=20
2.15.1
