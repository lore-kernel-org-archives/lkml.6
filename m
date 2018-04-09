Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3992186-1523244043-2-11562777905970274426
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
    1523244041; b=AFoQW9dM+MFru33rlQv/+Z79zJ8WSwbAKZ5RfhGzJkC02SKfE1
    3gBC9HdVEG3wKVK/35aInJGHmJunFWX/QqBlC5SldIZ6/V1Hm6RQjXJiUZ051cMl
    4u70XPVpAznL/r2sWXH2ZlCQ1WPrjn4PO7tHtAXZjMJ+l9jxpBEdeMDLUuOlGS0B
    NDbhCXxM+So5cShcw8Dxg/D4qaB6STQrCd0TsuOdTdwzMqkB4kIYvaMQow9Wx43K
    kpnierGiOspm4MaxZsd+U92SlSATDsfOuSUvDzc6ygFzPbDOpnksBK/7jhwmOIwK
    XW5NX4qEGbw+2RuWxF/ERz9WsLzBGemZezaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244041; bh=eYC+tcftct
    65xJ9KPvm6CjrzBzRAPwnFjY5ULLvDlSE=; b=qVpOiov2hU7JaScotAWmcS5m6Q
    SiZF2HQFWI3p+XCSKSi3AXZOGdr2+ltieodA4sQYcbbA0iH5Nef0RZH8/LLhqQwx
    i080EhC6dFBV9MGWPzTds45nQxfC+0e7Y9wf3N8WdiYljZcGEdo2xmGjX6VBW8ke
    +VA+A5ViGzUYOc2Cw4CCTfKzKmnHI/W/5Qe6Bl+uE/RAokqQrAxDfyDijb0580YB
    TuYb62fLGiVl8ThB6eFlTZMwQ5PPfXwQj6gVj5aNHhyBLtOv7gcwET/2hGHP8TXV
    8H2Ufw8FLISa3R+oLtbe5zXBMNTxShcJivHVUCtENu3laXC1rLupx5OmBwkw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UrfSzlkK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UrfSzlkK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfO6g8DH/3yQ2fd4NZ8FOo8AmM0dNlvud6HdlRndK+CflA2dczu4ppeFPv84ZL0oPlXw1iwlEZWOqb5RcHsiR42lSl56YvI3G8OmldQnnlg6oRrVQ7532
    +Vmpx8TutMP+7H6fKNPnH/lOVfa8GJP/zIvV06SzGO5C6DAOUK4EqRh8rqy/xDkc5dr1isKXlHc2H4i2NjcrKUA7mEydxmTI1wr8xrmuMX4+QWICWabaa2FH
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=c-n4J4-pAAAA:8 a=yMhMjlubAAAA:8
    a=RBgMQm25thbOlHJsUAEA:9 a=wPNLvfGTeEIA:10 a=L0NDqeB7ZLmQzAogN4cw:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751968AbeDIDUi (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:20:38 -0400
Received: from mail-sn1nam01on0134.outbound.protection.outlook.com ([104.47.32.134]:37792
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754775AbeDIAW6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:22:58 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Ulf Magnusson <ulfalizer@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 046/161] kconfig: Don't leak main menus
 during parsing
Thread-Topic: [PATCH AUTOSEL for 4.14 046/161] kconfig: Don't leak main menus
 during parsing
Thread-Index: AQHTz5iMb3k3lnIpDkiWr971cw7iUw==
Date: Mon, 9 Apr 2018 00:20:23 +0000
Message-ID: <20180409001936.162706-46-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1014;7:gqLXn0YDWAumUyoO8uU3gQ7DNzI2n6GAPaU+w7l2N9ftz/hiK2+RT3swIgRkiZp9W87IVFEe+IEuQK2gRib5G8LkWwMK+V4Vk7V7FnTS98nmARt3eh+63keMoomoypfmqK9B3WdnHt/rXCoVkTBwEbgEQMwid5veS+cC6LXzGK1dhGxzKxIW6VXk4wPg7qCYorvGZwA51wrNcgHhjo/Eeopkkzq6n1+Kah9NHkX9WVLCzSv16arqHA2jRZRe2npD;20:Z11mCyzG++8pHj97hadfzPSgLYgvEcMSvaYPnZqh+jQWMCZboYWwzZUm5XgIrGtBkD0G62GG1Bb2zfVyzdLkCb/RwFmvcYPwJvZUJ59kELF8P3apKBhSCLzgw/CzuAXMimYdNMPtQjBPh1gjvjNmO9QkuACi52igsNLAE1DvqrE=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: f9ace474-ef7b-42f9-a3aa-08d59db00a12
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1014;
x-ms-traffictypediagnostic: DM5PR2101MB1014:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1014CC03C5F4ECAF79ABF7D9FBBF0@DM5PR2101MB1014.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1014;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1014;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(39380400002)(396003)(376002)(189003)(199004)(81166006)(81156014)(478600001)(6436002)(72206003)(8936002)(10290500003)(106356001)(99286004)(86362001)(2616005)(7736002)(2501003)(6666003)(446003)(39060400002)(476003)(8676002)(11346002)(105586002)(305945005)(5250100002)(6512007)(53936002)(68736007)(107886003)(66066001)(86612001)(2906002)(14454004)(186003)(22452003)(25786009)(4326008)(2900100001)(486006)(36756003)(6486002)(3660700001)(59450400001)(54906003)(26005)(3280700002)(110136005)(1076002)(10090500001)(76176011)(6506007)(97736004)(316002)(3846002)(6116002)(102836004)(5660300001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1014;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: kMQa8uxhdTrVfu8YVAGB6XTHyKLlNKzi/9wV8jN0sidXrgpAVuIZ3cvcO5mT3A+JfosY95Y277WuHqy4z65LdvJ1w4oQBAmP5XSNWvemPKec+G4kmYzZ7IIB3b0GV11qjQE0Of1kEi+Ezz/9TTm0bwG4S/xL7L2dqAk4sGLTsJ7ajx50PdDN1RyucYjFoMACud4SBlEHaOQMjHA91gU64VL1+n2Z9Ibs2gEGuVwPS65kOenOipQvN3m5iZVFHPK9i1Mvu0KtSnOVD908aYhG+u2SJdRUZcKxelWbhK+FqaUZTbtO/llR+SZ8AX/GLLGCLgHx9ahQhRsZNgY0FMm/xsTOr9gxbNbTES1rmlluaxD+rxL/UYT2mAqruwtSBahsybovEEVLn4ddp4XgnyJJIvqe7SYn5Hlh+Ja0L9q0oVo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9ace474-ef7b-42f9-a3aa-08d59db00a12
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:23.1913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1014
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
