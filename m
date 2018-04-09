Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523234960-2-5996149123008232264
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
    1523234959; b=f69qcjKouImZPlQhjHPP7jFgvJ87jNt4JFKeKRlzXjHUlbrGJr
    8Y5oq0n+aK+sFG7B7sM/XlV6DJ+vxeuFu6WFppaFlMdt2UDBMTXTJrGIz2oCPjCq
    z5cWVAvr+2OahMEqqvtM5PDvsl2eie7q1SRl/TvA9ZASezQH6oaY5oBFtn3thTkH
    zu2PeE7P46X2pMNa7HcFBqlSSyWv77a6FP384ZP7eeT6Rl0VSFqarhiS9wAhihf0
    OmsVk3n1ke+NqMf57CFzUqYpEWinkFpXBASWpARPsKqTVY1dtDgAPAuqG5NYhCm9
    3Pbj38fkemvvmJVCiYbIZeAgGOyLkW45hKbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234959; bh=Fsc3+1d2SF
    hSuCCy55P3KDfTAS3mbeGRMK11PHHqo+s=; b=vZGXESMCMb4XQZVYYKs0UgLXI1
    XgOz7Dl6OG94IyW+cqQwmOirGPBmqvaKRWt7oIjvCxpqjPqcItZfgjQ6axOkpdY/
    u6uGELHMGh5VR7H9ccCy/ZQCEavGiaGR/WoQmRh5eQJlfWQiv94r+x9iAZtD3fMO
    KTAJP8PvUSEpEd2qeGiTkJTFh10NP8PkAAecLWa3SWu87OO1FXpcxTQiUx40uo3g
    0JJXwTmVTeMMNeG8KKT+Jkg7fm6KDTOovOOE2SeCQcReV/ThWsZfuLV4ZLj3lWgh
    b2GGYJ/LA19pcgHdZy2g5YU6Zyws7bchRHxZx3fM0OemhFpfAonNOIrhoQ8Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TYfAHS83 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TYfAHS83 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNwZLnG8qfWIbDmV5dUU8W4wG6bxAlMEz0oW6zio/nT449T1LDSMzrdkfke2Ju4M5pi9S37tdbU0OYokyV8v8maQNAPxyVfsCuJMTCEEwGaUUTTYrLeu
    C3ZsrPXDVxptM4GGlp3s/NnL8Tj5UZ1tIxTMQ8fPBtbhMNvEGsEh6Cp1NGxyoGdlCiacFo+16MxK00D/VKWd/J9epoVSsHUm/3oajWsgOQ+rYwheUrSRRrgK
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=c-n4J4-pAAAA:8 a=yMhMjlubAAAA:8
    a=RBgMQm25thbOlHJsUAEA:9 a=wPNLvfGTeEIA:10 a=L0NDqeB7ZLmQzAogN4cw:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757104AbeDIAsm (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:48:42 -0400
Received: from mail-by2nam03on0117.outbound.protection.outlook.com ([104.47.42.117]:14462
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756350AbeDIAlj (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:41:39 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Ulf Magnusson <ulfalizer@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 073/101] kconfig: Don't leak main menus
 during parsing
Thread-Topic: [PATCH AUTOSEL for 3.18 073/101] kconfig: Don't leak main menus
 during parsing
Thread-Index: AQHTz5uCeQ04WTESCE2qOXD4fz7zag==
Date: Mon, 9 Apr 2018 00:41:33 +0000
Message-ID: <20180409004042.164920-23-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0901;7:WXzs0BLHEF42ma5YlSVMwOQqTbOzYE1D7D/6M0aO766FaYUP20oj9CwX2X9x/WyCq0OdKu7YNdmtLG1J4xdF6/Ys3SXSfPZgKsynNFfgeZ4sQxsgINjbdGi6/9r1/IS/gcLQBwfyUcFYoTFP2j9L4ksYOFGtP+73N6AgEoa5hZiLCcpRGL/eUdMICJTCZ36IvymWyuLLoKJPMMyLuw2WONPeZ5YS9sHJhzAPmvCvrD4bFamG30DTsjG7kkRo7F7v;20:G4zhSvvzqRM+XEKqjX1X4BQbJCQc6r77AyQZVAgmZTsSdzP0i216kTzarUFBFjnyyZjrNIuN6nFTo/QKcHN4fNeZcR192giJBRDn6sKamrdoTFOaE6h28sDHZVndfcGonTO5kD+GR+ie5Fg5C4Ka1cBgujacIz+cKf16uIaV7qk=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 89aa079b-4440-47da-b32c-08d59db2a663
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0901;
x-ms-traffictypediagnostic: DM5PR2101MB0901:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB090118566953F3C1E001DA6AFBBF0@DM5PR2101MB0901.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0901;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0901;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(346002)(396003)(366004)(189003)(199004)(59450400001)(99286004)(68736007)(10290500003)(25786009)(86612001)(6116002)(66066001)(97736004)(3846002)(76176011)(6666003)(6512007)(54906003)(6436002)(4326008)(53936002)(105586002)(110136005)(6486002)(3280700002)(1076002)(39060400002)(107886003)(8676002)(10090500001)(2501003)(81156014)(81166006)(5660300001)(14454004)(186003)(3660700001)(102836004)(7736002)(2906002)(26005)(5250100002)(36756003)(478600001)(446003)(316002)(6506007)(2616005)(106356001)(8936002)(11346002)(22452003)(2900100001)(86362001)(486006)(476003)(305945005)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0901;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: JYZLI9U9iqhEXDBQAvabH5yiylgDwJY5EdhamjRnp5RraGh+KWi5kUnwNRes6/E0Ur0VuPJjYsU6h8PhGev+//kgdNMffHzM1nvx9GEAWPpVqdSMVssDpbMh8/AkhBCWBowTu7r5Aw7EgL2akiIxIM8xiqGT67i1xnEqRtojFSr/uFXwWNFy8nAQKq6OGY3ZYQXM7TZujvNnEiJQ6hQBru9cj5W7Ulru9iTvJS1FbkkDzV6hhpcjJ1INNt3Rei3wgg05cpNX03u0zY3oEmGeepiPK3KRiQnpFGivbsa+XDdfKk5tbh9sbE7ED+Y0QJQxblsA8N99jGXdvZ9/+NKqgOnVPDW4adHgHf2Izn+6HcWegPu6YRvTCPRExsRrNdwF1MDTyqj4DlURpABPIRQsLoarFwySSKGDCQbAWN3Lj1A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89aa079b-4440-47da-b32c-08d59db2a663
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:34.0021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0901
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
index 0f683cfa53e9..52dda772d181 100644
--- a/scripts/kconfig/zconf.y
+++ b/scripts/kconfig/zconf.y
@@ -102,7 +102,27 @@ static struct menu *current_menu, *current_entry;
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
@@ -339,13 +359,6 @@ if_block:
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
@@ -486,6 +499,7 @@ word_opt: /* empty */			{ $$ =3D NULL; }
=20
 void conf_parse(const char *name)
 {
+	const char *tmp;
 	struct symbol *sym;
 	int i;
=20
@@ -493,7 +507,6 @@ void conf_parse(const char *name)
=20
 	sym_init();
 	_menu_init();
-	rootmenu.prompt =3D menu_add_prompt(P_MENU, "Linux Kernel Configuration",=
 NULL);
=20
 	if (getenv("ZCONF_DEBUG"))
 		zconfdebug =3D 1;
@@ -503,8 +516,10 @@ void conf_parse(const char *name)
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
