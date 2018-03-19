Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3230508-1521476399-2-14533678142446994287
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521476399; b=kQS0V2v81UJfucs7Jep60MBgzAd5HFA0JU4jt/zRPI64opE
    lOdcgS8KmsurohauQzOG27NmGJ1kBMHyPwfU37xzy8771LCTYrclYvxxdUJMT8ke
    n4Jc9AmGXjEiz38ETsVyGPHCAAaP4d2Rw9vpAYj9+w+xE4BXr69oj/wNgv/LQlR1
    FKG1Prkrz2ct6YggiZXSC0Hu7InhfIiuNJBxqBYqwijSpQzzQKeGBa8SiFCdLYjT
    6fgYOU8od1XFYQ5pxvC5bteatoh4nr4VJQUX55TqxXuH/PcHhulbviZNc8jr01T/
    GTVZmn7Y6pdH2WLUFvB4vW1SY1t+R1y9nKQqVRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521476399; bh=flcgBR
    NGFTrsQZBR7b+YGhHBr+RoJlutalg4EBqO4YE=; b=B63n5+NjuVKzqXSDN23YY6
    sGAH4lioEqd0QVVSRUlN+UXBdeaTp1YnYsGtofLy5sCY03+wb/iAHXD/eIANW/OT
    rn2T+Uv7OwS92yA8ePb7XEpOAnaDsj0vbT77jQRy2m0csFj6zBPNcn0RnxaV1W0l
    XhiL4Do4drtEc06Cz0foq5Ox8ABoED4sgoH3wiyFpQ9wU4eBsByCmWs9eDBG77Nh
    ez7henVnyDT4Oda879AlkMnw2oQfl2nAjrzmq9Ovik4acsAGz55RaU1u0pkc/FEh
    uXSK7j+CYyJA1ixCZwiJwKP6wcFYkTt3XTrHKIPupJO38F8jHUqG3uPsNmlEhhlQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aJasZyua x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekieculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekgeegvdenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aJasZyua x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekieculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekgeegvdenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935248AbeCSQTW (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:19:22 -0400
Received: from mail-co1nam03on0091.outbound.protection.outlook.com ([104.47.40.91]:37504
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965918AbeCSQO1 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:14:27 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 090/102] ACPICA: Disassembler: Abort on an
 invalid/unknown AML opcode
Thread-Topic: [PATCH AUTOSEL for 3.18 090/102] ACPICA: Disassembler: Abort on
 an invalid/unknown AML opcode
Thread-Index: AQHTv50zLPP7xcZUoEiJ4+IrZbCCQw==
Date: Mon, 19 Mar 2018 16:13:21 +0000
Message-ID: <20180319161117.17833-90-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1112;7:MKJ4dnSraHw/oHCJCzFJWW4LoSx7JwuF2lm+RDNAAtiNIFMe1EheKyBBSp9u/HWn5TWXWhfM0yQSPv4HATiLTgyMISnzfTbAD5rbPdC4F138m7zZ7Upa/MDjofyRZTTuKJMpWrIkCxouUWpeficL1HpLpIwoG1oZgGFc6Jw5f2OcY94PtTOB3cdI/cPUgaJBiUTo+AEWhJz5avMDk8bSAq0ZI7bcNxu17uCMFFFBCiSQ121MLNi4biASDlCrPFJN;20:ppw1mKM9dizcVj8OvGJJKriOlKf8EK1Er+kRxvDngdtbB9nOJs+8XEddmMua1flAjhNkwnMJ5cjysxe58xc/7ovK1JPZnDJJB7CyBC2LQ0JU9VoANj/+OxdjK3l0+TONxQBSd747opt0r4cLAt1i8sle6UT+skYj+D+fUjLg53o=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 414399e2-2abe-4ab4-0617-08d58db4767e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1112;
x-ms-traffictypediagnostic: DM5PR2101MB1112:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11128DBD3C305930885E3210FBD40@DM5PR2101MB1112.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(166708455590820)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1112;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1112;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(376002)(39380400002)(396003)(199004)(189003)(53936002)(26005)(14454004)(36756003)(2501003)(186003)(305945005)(86362001)(107886003)(316002)(575784001)(7736002)(6506007)(110136005)(5250100002)(4326008)(2900100001)(25786009)(102836004)(105586002)(72206003)(10090500001)(54906003)(2950100002)(478600001)(99286004)(106356001)(6436002)(3280700002)(966005)(3660700001)(10290500003)(66066001)(2906002)(6486002)(6306002)(76176011)(81166006)(81156014)(8676002)(68736007)(8936002)(5660300001)(6666003)(22452003)(86612001)(6116002)(3846002)(1076002)(97736004)(59450400001)(6512007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1112;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: weO5bHarWY8BCC6q4A2qRKYt1SRMmpRjXwb3TZFmMfvhFLqXr36MXJDln19cU4qnOUWoNM0EGUXPbrM4AOn6wunlBPLieZ5JotXtuREMSzHwqFQi4Tjcitx7frjGVSqTRwosaYOi3SAJBuue8kLsRoeRSc/gKSApRf0g+LsyAkLgfPnhr9aieWGr59A96t9himU0U8TX5UT5RGld1r+5St3GemCtBwM20tNMJzDkdwVNTdxjYHwpA4BuvHsynkbCfFY4cmHys59+ZVM0yP0bh0ymljFnJsRmsoydJ509iAxgKrHbOUcGli2xbwuPMeHYCBDCltfXfpeXImASXnXAfw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 414399e2-2abe-4ab4-0617-08d58db4767e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:13:21.5176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1112
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Bob Moore <robert.moore@intel.com>

[ Upstream commit 6f0527b77d9e0129dd8e50945b0d610ed943d6b2 ]

ACPICA commit ed0389cb11a61e63c568ac1f67948fc6a7bd1aeb

An invalid opcode indicates something seriously wrong with the
input AML file. The AML parser is immediately confused and lost,
causing the resulting parse tree to be ill-formed. The actual
disassembly can then cause numerous unrelated errors and faults.

This change aborts the disassembly upon discovery of such an
opcode during the AML parse phase.

Link: https://github.com/acpica/acpica/commit/ed0389cb
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/acpi/acpica/psobject.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/acpi/acpica/psobject.c b/drivers/acpi/acpica/psobject.=
c
index a6885077d59e..e49a7fa4789e 100644
--- a/drivers/acpi/acpica/psobject.c
+++ b/drivers/acpi/acpica/psobject.c
@@ -118,6 +118,9 @@ static acpi_status acpi_ps_get_aml_opcode(struct acpi_w=
alk_state *walk_state)
 			     (u32)(walk_state->aml_offset +
 				   sizeof(struct acpi_table_header)));
=20
+			ACPI_ERROR((AE_INFO,
+				    "Aborting disassembly, AML byte code is corrupt"));
+
 			/* Dump the context surrounding the invalid opcode */
=20
 			acpi_ut_dump_buffer(((u8 *)walk_state->parser_state.
@@ -126,6 +129,14 @@ static acpi_status acpi_ps_get_aml_opcode(struct acpi_=
walk_state *walk_state)
 					     sizeof(struct acpi_table_header) -
 					     16));
 			acpi_os_printf(" */\n");
+
+			/*
+			 * Just abort the disassembly, cannot continue because the
+			 * parser is essentially lost. The disassembler can then
+			 * randomly fail because an ill-constructed parse tree
+			 * can result.
+			 */
+			return_ACPI_STATUS(AE_AML_BAD_OPCODE);
 #endif
 		}
=20
@@ -290,6 +301,9 @@ acpi_ps_create_op(struct acpi_walk_state *walk_state,
 	if (status =3D=3D AE_CTRL_PARSE_CONTINUE) {
 		return_ACPI_STATUS(AE_CTRL_PARSE_CONTINUE);
 	}
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
=20
 	/* Create Op structure and append to parent's argument list */
=20
--=20
2.14.1
