Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372889-1521481488-2-3905256041157823572
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
    t=1521481488; b=OZrlZheS8ckQNF0kwhAiWGA0M6D1tg9MVQ/wHEQKy3Vuo6C
    h0+lKv5U/ohek3a4a/ax8JFrEqBRR+Qv75Hk9R4rVJ4BCdSdgMxCR0OgvlaXn3mp
    /RzHYFlpKFi8zGO23LzIU97B4v/NTWXITVvOnhRieY3hQt5CY/wKbqBV0E5Dxz+p
    +/6ARRr4O4LYRQlY3KBWLYRi+4osFyk0cGs9pEmweZHOZ9SMIlAcY/y6LQl8IidM
    BQBgkZw+WEmU8KCW5uQ8U0mWheKLMaBlMbZharWJsfCWkcpUQzuRiRKmqdbi4uOh
    gJe+/vAP6DepCqHS9x5vIrbI+79Rh6XfUIyayNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521481488; bh=nXWmO/
    UcDk0cny1PZ+0NnMrd217tHLo2d2OxkD0+NjY=; b=QZ15x/zpFYCOPR/sxRH+Ka
    omMYnX8eah5pPmgRaCuyY8DyNShHz/BcBQpJG2DyzbVamhiYsCEG7tFz5FHJMIFi
    k7f4ZlTY2ui9bN/6mHQ9Wt8YzZxyyOe0bDusG7/WJn71h3pH7LN3hiSdPIteyljj
    MAmV32YLUdHdPiK2uJWxqvT2JKPEv1sXQToRH5Q9uszCPEfqJwFt8oP9M6RMjpAo
    4q6NRsjd/h6pguw4d4EeWhAm2QfMI6IlR8hqv/fVD+vpPcL6l+TO4PZw0hKAif5h
    u49BJKyvNpTtEt4OnQHBsVlQWw1VxOgBiLN6uXkadCnoapuzxS0soC2gEA1kOVvA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=W7XBsWNB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeegfedtnecuvehluhhsthgvrhfuihiivgepke;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=W7XBsWNB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeegfedtnecuvehluhhsthgvrhfuihiivgepke;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965860AbeCSRoc (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:44:32 -0400
Received: from mail-by2nam01on0102.outbound.protection.outlook.com ([104.47.34.102]:50048
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965393AbeCSQFj (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:05:39 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 256/281] ACPICA: Disassembler: Abort on an
 invalid/unknown AML opcode
Thread-Topic: [PATCH AUTOSEL for 4.9 256/281] ACPICA: Disassembler: Abort on
 an invalid/unknown AML opcode
Thread-Index: AQHTv5u/Hk2316L8xEq5AVLkAb1hHw==
Date: Mon, 19 Mar 2018 16:02:57 +0000
Message-ID: <20180319155742.13731-256-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0728;7:p6FF9HeAwsrb95kBALXL9uyeeFqdYxOSKj4XMheHIl0sB3EWh56EeS7ppfTcdZwDQtqBV2Rl/0XWRxKyAFHdSkax290TmVmkhYJ1LPpgTO2af7St4Ip3FnrEnB8Yge8iXXq06CBvSCOW05VCiPbA5QQsm/hBLQvpBnkf8wDbA4zA3uKzs5i4cPnxPO+iQVD2nLpGucx4Tgyn6ls9lZvTmfkP13EUTA4QF3iM9Q5tW6uDlFNHGyxaff51zg9bsQPu;20:PM0C0F2TdcdLjllPEx7KF/i23eQvRrFQGcf1fW0VW4e+FBsAwydGer29v5bjvPD2/K0R3LZHZmdunEorjKuQ5LAjZ6UgkWeLC2LPPZhvjLlsUgiHFjyCyHsN4klro0bXheuTUjS5k7e824n9grca45F04eg2CYKi4NyJw0Sdpi0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d67a6f35-e177-4cad-2e87-08d58db33ff3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0728;
x-ms-traffictypediagnostic: DM5PR2101MB0728:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0728DD89AB20BFA8224D682AFBD40@DM5PR2101MB0728.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(166708455590820)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0728;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0728;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(346002)(376002)(39860400002)(396003)(199004)(189003)(8936002)(99286004)(575784001)(478600001)(53936002)(107886003)(966005)(110136005)(86612001)(72206003)(97736004)(76176011)(316002)(3280700002)(5250100002)(2501003)(36756003)(2906002)(105586002)(1076002)(86362001)(14454004)(6436002)(54906003)(6512007)(6116002)(6486002)(6306002)(106356001)(3846002)(22452003)(3660700001)(186003)(59450400001)(68736007)(66066001)(25786009)(102836004)(4326008)(10290500003)(26005)(6666003)(305945005)(2950100002)(7736002)(10090500001)(81156014)(81166006)(8676002)(6506007)(5660300001)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0728;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: wz/i/osDWNOVo9kBZemGVJmBR2//vE8acn28vkp3E80QVST/q5JaBBEeuGU+pDqEeFtjFiWcFPr5BjAAgOVMB5/RVhZBjm+y/Nwrs/vwgiHGG2SJ1I8t7ZQk31gk14KK5grnajowQJPnVZU18hGuShqgnbiyJcYPk8UsSPg79Sji4YSaiwSN0fF/uydOoYSnbW0ZvA9sVMPobxx97o9bNsObkkncUyhhZAlm9iDIAd30LzVqF+GH+ZgOFJStzfNYykHaCWUsD2zvcmGB2i08Wzz3yclRHq2h4d7rfMZKJflIngkCSjfEFeWv7FXYNxwaPFnK8UKbM0Q30Wbyxy4XtQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d67a6f35-e177-4cad-2e87-08d58db33ff3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:02:57.2699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0728
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
index db0e90342e82..ac2e8dfdf74e 100644
--- a/drivers/acpi/acpica/psobject.c
+++ b/drivers/acpi/acpica/psobject.c
@@ -121,6 +121,9 @@ static acpi_status acpi_ps_get_aml_opcode(struct acpi_w=
alk_state *walk_state)
 			     (u32)(aml_offset +
 				   sizeof(struct acpi_table_header)));
=20
+			ACPI_ERROR((AE_INFO,
+				    "Aborting disassembly, AML byte code is corrupt"));
+
 			/* Dump the context surrounding the invalid opcode */
=20
 			acpi_ut_dump_buffer(((u8 *)walk_state->parser_state.
@@ -129,6 +132,14 @@ static acpi_status acpi_ps_get_aml_opcode(struct acpi_=
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
@@ -293,6 +304,9 @@ acpi_ps_create_op(struct acpi_walk_state *walk_state,
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
