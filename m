Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4122441-1523246535-2-6106665420017828781
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
    1523246534; b=dkXvV3+e6AkHvtXnT+L639w9lzD/vRO8xkhe2Y5Gi7AdegdqOq
    hCSA8Wfaytm/z6vJo8DL1/ed6P8EE83bPPhGfrnaxqXhFldejC9JOttQDHSq7l6v
    6EqnVhvUDmND9SfcR3vnCkI1JPHXzQh6cEYstwsBpd9M1ElMNkFsvje1U1ix8WJi
    dcBj2B69sBBBtXG/FX34JJuhFiL9uEXZBx+nOZ2MjdEyZh8/XiMQI1YgUALr7R9p
    ZVEcAPUmy9qTw0urT7E9uZSaeGPNnV4fZU60zSLCnb8i9YKgGzre9HcawUZzLcxM
    O9MBc7EvVxMIbvxwR0z/0i6y3mJI7UQr6wqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246534; bh=eYC+tcftct
    65xJ9KPvm6CjrzBzRAPwnFjY5ULLvDlSE=; b=D8I96y/i0D2yaYNRfMw5Zph08T
    3VZybqIDi1h54zkGmNpeaNQZd2SeKZ/mHtmbvSCLg8LQ4NJfD0Q4Xn0BgDKu1sdf
    ZEWuVAANrJ5ZbMyQUXuV1FVTy7HuDKIfBrHDWycItxHaagXFFoRq3d9e8TeS5Nkg
    4LIH0oowME6vEfsVnN/71z/moF0dbmDpebtkFbLKcKFNKzsnJzuZKx5xSJUTcE0v
    DjfpYSnIZU/OM+PWSlc8f3WDbZuhgXv2T8nnRIRyJnZ1jwNiQRvdNuUa7T3z2Hcc
    jsmHMqNB11U3jMYQu2FaQ2fWP4Rr3I9fHrmlH/SxxFhh4qOEO5wkPUm7WGqg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Kv9jbr3l x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Kv9jbr3l x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNMshdpqlCHYFb9e4xS+pAiB8TceHoabQIqTZ2IwCbC8FDUzaiQM+NJ9LX+fUuDIA7wM+Zq2cin9e5P8Kz+WmX/ZlMcFjapVUhJO/aGYmMn1z2UAhaWt
    gnPfWO1aDr2vZUHeXx1gdfXjYLPK9kvZYulSZVf7BGnjwpPzts4azJTNJafsG7COqoRVchV18OrVDlFRNoZqujZWAhv/XfP4IL6qMatssiQGOvuKsE4Hd18P
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=c-n4J4-pAAAA:8 a=yMhMjlubAAAA:8
    a=RBgMQm25thbOlHJsUAEA:9 a=wPNLvfGTeEIA:10 a=L0NDqeB7ZLmQzAogN4cw:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753831AbeDIEBp (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 00:01:45 -0400
Received: from mail-co1nam03on0092.outbound.protection.outlook.com ([104.47.40.92]:42112
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753397AbeDIASH (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:18:07 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Ulf Magnusson <ulfalizer@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 054/189] kconfig: Don't leak main menus
 during parsing
Thread-Topic: [PATCH AUTOSEL for 4.15 054/189] kconfig: Don't leak main menus
 during parsing
Thread-Index: AQHTz5gkXXmeZHHwyU2kzNmbCO9fyQ==
Date: Mon, 9 Apr 2018 00:17:28 +0000
Message-ID: <20180409001637.162453-54-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1046;7:SxxNf29l1Xr1ImIM/L40VSVYbrF2EwQTFHOC1phzc79ysSpIpHiDzQVwDzbIKWCM6DM2lHyVQMmfgSY0Bx7nbk8Ve3SaYJ9qv2ts8HL+ciz8Y32GwYZTw6WzMXs05fxPCAlhC8D/abhBKwTyXrMRZW3zJ+ZhNNptR2RTecRgrs8CTrEpI8O9YT58jytUkoBJa5Mebui7IoDlQqkE2hAITCtbYDA9XPRMZ9eG2iCtu6OanuZIYGkKW6REjnxBfhKi;20:g3HIFX1McGaVuyiwwiTQUKD3NDOjxldymYvSSQ76UjBywl9gm8JeQ8rdER+aYjTmY9SCBFj/4hpRkvdZUuqb1m3u0hcdJHOjUWRlyf2i22qn+U5ZvDrLcIFLmUVoHNm68GorY985l6kZnCrjFdhkoYOggN9UAJ/N2JX+6gFtNn4=
X-MS-Office365-Filtering-Correlation-Id: 4ba8e45b-2a89-490a-e750-08d59daf56b3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1046;
x-ms-traffictypediagnostic: DM5PR2101MB1046:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB104649580EF06E1C0BF8CAB7FBBF0@DM5PR2101MB1046.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1046;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1046;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(396003)(366004)(39860400002)(199004)(189003)(36756003)(186003)(11346002)(446003)(476003)(2616005)(7736002)(5660300001)(26005)(10290500003)(478600001)(106356001)(6666003)(68736007)(10090500001)(54906003)(3846002)(59450400001)(22452003)(6116002)(86612001)(110136005)(99286004)(86362001)(72206003)(305945005)(76176011)(102836004)(6506007)(486006)(316002)(3280700002)(3660700001)(81166006)(81156014)(8676002)(2906002)(14454004)(2900100001)(97736004)(6486002)(8936002)(1076002)(6512007)(6436002)(105586002)(39060400002)(25786009)(4326008)(2501003)(5250100002)(53936002)(66066001)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1046;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: nNr2pPPUGYNVPZpoRz/PYypy1qU0ruIBikGPbgFq16joWixc3XQpHZY/7169XVdcR8qKCzsc6GHWsP3d+ZrPro5m/1EQxSnHtVxCJj5sARb3OlnIg7CaxnYaLVL42rWVfsLF+UGpk9ccKTSvf7Ee8q4i598pUcEJgVWrubBJMXKrIXW5Yy8wKgNPFZuwcQPluJKbVEbxs1BBtp1LyKP5EnaBlON1qQipoT6/lGUt78XR07PYeXXU86I9Un1xKrRlOR3EOMKWEkWT/fUHtY/lQDzaXTnDWJOfOKfkKBj5raIWcN1QrOCRpWkMYwYR0rzV4l4TDu1m/Yool2q/JSx//WclofjpZl3/No5T7BDtSezOKo5OWaVc2Dz1XQTDA/oRB3P867u7bbnfftqhU4Y45vMAfYQ47TfJTyCQea2idDE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ba8e45b-2a89-490a-e750-08d59daf56b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:28.5565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1046
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
index c8f396c3b190..20d9caa4be99 100644
--- a/scripts/kconfig/zconf.y
+++ b/scripts/kconfig/zconf.y
@@ -108,7 +108,27 @@ static struct menu *current_menu, *current_entry;
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
@@ -351,13 +371,6 @@ if_block:
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
@@ -502,6 +515,7 @@ word_opt: /* empty */			{ $$ =3D NULL; }
=20
 void conf_parse(const char *name)
 {
+	const char *tmp;
 	struct symbol *sym;
 	int i;
=20
@@ -509,7 +523,6 @@ void conf_parse(const char *name)
=20
 	sym_init();
 	_menu_init();
-	rootmenu.prompt =3D menu_add_prompt(P_MENU, "Linux Kernel Configuration",=
 NULL);
=20
 	if (getenv("ZCONF_DEBUG"))
 		zconfdebug =3D 1;
@@ -519,8 +532,10 @@ void conf_parse(const char *name)
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
