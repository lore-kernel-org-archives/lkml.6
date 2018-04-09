Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523235746-2-110997818863340302
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
    1523235746; b=KGgfccnU9IGikn/clFsArbkGBcdftQYd55OWhwalPEhgy35ooZ
    IjlwHJhN4ZhDR8qLn8WVNPBaTqgJ7QBCnkzujzc83sde0EPO4ArjC0XCmdCA+TFf
    8ZZ/y8C/9kG+kn+8nEcfh0zEaDpQJS5KaSO/cMUfdJaaDtTrL1qUkSOtRx1mA2oM
    psVv+diOBf6D5OnSVyhKqANjAnCg1jxRdd5TzJhkdISye3sf1iYwvvNqCnxyTyf4
    GpAA31B7NieoPRc7dVu+07U2DFTsL9ZY5tdd1ACxoSMNqIAKpYOFFAwMc84w0ygI
    IG4LYZp2eTdg+vF2bFiUiDAreEJ3onU1oz6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235746; bh=jtjWTj+tqN
    /lMBW4o5XJjOhE9Z93ek79eJRHTEpgI2A=; b=Ud7fzqzvNh77KeJmwcAKaThths
    dHfiHm/1BVw+cc1PnnBGnXk3IPiXkbqlhhhunOr7MQ0YUrtB3aruMoXO6q6OH9AL
    1AMyWCmIUlpjSXa+W2nJY4zWdYbv0TY4gSHgxZVkfbEgd4CUXB3VSX46662q7no1
    6nzy/Te6nFzU5XPlmCy9QnzcV2oS5V49/eCl7awH1XtcxT08bLEpIDAb5h9qJMhV
    u0h2mh3B+nmS1Njj8mrGo1r3f89Ln3V52cwPUBsEtduGvmqAmRzyQuc04eaZ2chH
    t/S7eUYgL5WMwvGN4j4Yb/8xfHBxQdzBT2ZSdbkMFqR2ktdYgyDaXyCSlSBg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Z1SqK3ny x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Z1SqK3ny x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDYlcFcyvg7g6yb7nAdxcJ2kmjZ5zBH7rL+gX426IZUn/i8pVXTVkSaMO1iPhfQJyv2sxp2h5265kJs7v7SuBjyDNbiduHiBifPKgnt1BQNZfgv22ixa
    XVc9Bbi4iiCH6ZhE/kyalZTeS4fcLSgrGCwHQp1w7LYjIhmSXUBrk6E9iFzByWCUax+NBLEgR3gXvcfJr7FAB4+SZE62omhUgnaLusevvLavZoud8OwM9OAM
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=NEAV23lmAAAA:8 a=yMhMjlubAAAA:8
    a=WVfum9TogFa7DQqzukUA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933409AbeDIBBQ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:01:16 -0400
Received: from mail-co1nam03on0103.outbound.protection.outlook.com ([104.47.40.103]:45124
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933113AbeDIAjj (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:39:39 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 016/101] ACPICA: Disassembler: Abort on an
 invalid/unknown AML opcode
Thread-Topic: [PATCH AUTOSEL for 3.18 016/101] ACPICA: Disassembler: Abort on
 an invalid/unknown AML opcode
Thread-Index: AQHTz5qlfDj6CXpLkkaG7gkd+iuljw==
Date: Mon, 9 Apr 2018 00:35:22 +0000
Message-ID: <20180409003505.164715-16-alexander.levin@microsoft.com>
References: <20180409003505.164715-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409003505.164715-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1047;7:3OqzY4wcDXrPZFrtbzeGJzc1gzu3K1DlVMksXJc5gUTZjIDWFLOk5qJWba7xWlsmUIoEEvDFJXhBcOZwag6W3gB1ei8LodWDR1zKSRotBxuPmUl5fKopxiTfU6M2THLwpV1/PyZM3m9sdjETAcE4cEV9MC1iQGvk8dhK+cyaUTZNhsxhIgmdVrnMU5dTKtYJSAqPdWM6yWU1BfO93nAyC3f3iUZsLQ/XeW6hg7ZPJMvxpwtvWWebJM6WJZrIIK4P;20:wAMXrXr4OCbGFAkzzLONtzAnHl+yqW+masRE6anj/TjmJorbeOpxj6VfQrVZPptvrz580uRv6/EB3r4LoMzLpWtRDtmcQGuXUTuSDASkUzKdPxucracvO6jNoPMmzMWqHNzkHWKBCOdlOU4ZOle+dyorigppSigtoTpIF0EIlrs=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 498f0c62-e559-48a6-5a1a-08d59db25e7b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1047;
x-ms-traffictypediagnostic: DM5PR2101MB1047:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB104787958A453603490F7DA3FBBF0@DM5PR2101MB1047.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(166708455590820)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1047;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1047;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(346002)(39380400002)(189003)(199004)(97736004)(3660700001)(2900100001)(2906002)(8936002)(11346002)(3280700002)(106356001)(446003)(68736007)(72206003)(1076002)(966005)(86612001)(25786009)(3846002)(36756003)(107886003)(6116002)(81166006)(4326008)(486006)(81156014)(6306002)(6512007)(6436002)(53936002)(14454004)(8676002)(26005)(575784001)(5250100002)(86362001)(105586002)(6666003)(305945005)(186003)(10290500003)(7736002)(10090500001)(102836004)(6486002)(2616005)(5660300001)(316002)(2501003)(66066001)(22452003)(54906003)(99286004)(110136005)(478600001)(59450400001)(476003)(76176011)(6506007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1047;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 4cdRBRSDihDLa/JMtNSpnrU54VHfqdGUNacFrVAExuu1Ga88hIpZwFgDWO4YJZhMDkp48cUZq+q+nEmkuPYPNTmkO7hv4nzpJTUThqR8oVfah4tV5/u+01tnkGPxGnV+tYz2gvfS1UXvAYbDLXFLh3/8rcb64AAELL9nokIc3E8X2Cus++7DtM9fXeFhMRC1jLNEusLP/V9Jmk376BLNtGG/d6PWd03ywVhq1JsIwQfx/MMd2/1aH9+LdFf+7lYkDB5Ysg4BiIGrHaQUZJz9Rv2hjupjGJzIckHnxNDs9ygUiKS/0cqIe0ECjYPx9a59Ml5KPzKFvq5YV3fU/1poR9jACK8+PjYZvieFia41FSKs5oWFf9vCDTw/yLCSYhXQDgCwQnjKyYXwVksxcTvKh8q6llvHVNE2j6U1bw+Lqus=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 498f0c62-e559-48a6-5a1a-08d59db25e7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:35:22.9548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1047
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
2.15.1
