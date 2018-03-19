Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3293580-1521479124-2-251837152764799254
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
    t=1521479124; b=T9D2kRySY5Mg8o2AV1DFyDt8296wsG2viiSmDy14zLUarDE
    1re/0cTYw9L7PeL2uJALgUMyBesz4LPMab2kZoSi6E7u8hJyIvKfhkM2+6kCBftt
    yVqcUi3WWf2DmyJbKuDAUm3IZ0PQG2vJ8mVSYoVyxjb1AQ9460lmOhJZe18nRWNu
    /gMQ7vSNvrKWQeLkJFVndcMf/6krVUhyd3C/oR+vt8Ed6BVmlJRiJ5xPli7upMCU
    4XracWeCMzuf9LXJEexem33auGZ15s7mbuFpUMkrFW7cGxVH0HFNtqGiOsmwsrLj
    aorYFV1dQJTvXvsZyX7pd0AW7YK8q++8nESNI/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521479124; bh=DDedtj
    OEw5vus2TfA3D5qhufkQUPz00PiVcW7rk8PF4=; b=NNNM9Nbfw98mI/bN87ruw3
    KxGct1h4tKb0JNuRP+VZX40UWlSLGYJEeXh/eAbXPLJs1sS62U/zP8E3dIb/hbg4
    0LYvRfgwIdTyNo6/bqhJcz7cuHSkb0V/gYZB14dgoZbeA21HALQVBFuwaJQ8OXuZ
    /f1B1HlVRt/kauypvtLeqqtfMM7my/TAVBR0370E7VneBP4HODovd6lIYmPTzoX+
    FSx+ssgzMKrwEcdbtdbkfabf0VBYMduC93UjFaxHYIfz810gvY6exDWIcACbo3+r
    cyr8ugyCV5g1/eoBwWpWBxbspIdejgf8EhOxxWAPB+lXkxci9wB0KskZKLz2Pgxw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ei+81dQJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeljeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekgedvkeenucevlhhushhtvghrufhiiigvpedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ei+81dQJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeljeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekgedvkeenucevlhhushhtvghrufhiiigvpedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934717AbeCSRB4 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:01:56 -0400
Received: from mail-bn3nam01on0108.outbound.protection.outlook.com ([104.47.33.108]:5984
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966703AbeCSQLE (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:11:04 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 150/167] ACPICA: Disassembler: Abort on an
 invalid/unknown AML opcode
Thread-Topic: [PATCH AUTOSEL for 4.4 150/167] ACPICA: Disassembler: Abort on
 an invalid/unknown AML opcode
Thread-Index: AQHTv5yFzsGj/YIlD0uXheKZtqj7+Q==
Date: Mon, 19 Mar 2018 16:08:30 +0000
Message-ID: <20180319160513.16384-150-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1095;7:e/v2svxVuEn3RpTEwGOG1G15i5zSmCPUqYYX00L5/kvCNMEb+rjulxt08V5cUI+7HUdN1IO0qOMtDg6aMmoCf1rt/TBG8KMy+SVb6xlFB4W0WVMgtInKOXf0rFXisH0Mew3GLohbxjuPXZjdd+Cdzpz+LODGxvaaxOdDCpBzhddO1regnZpIusdoFkYAefxuZSkKUBOGbDbzj66iePrWQLNvGi6RW/Xp3E6YrtOi6Tyf7B+2NTuhx5vSXhHYLlzx;20:461oRH6FpO6APawnlrlAlrW38n5q6QXFUOXVCG2T9GFEqRTNSH+z3P2Bw4gTAEuwq0cSMYqnEorNE79P+s9YW4zBHBLdCTve6FppL0+EChiT9HLFtS20XhuUK97u+ePa5Hzt7Gmq0CvvIZEDus/aApvdgx0H+JsXA693rK4nE+Q=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 671b9926-2d10-41b5-6434-08d58db3fba0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1095;
x-ms-traffictypediagnostic: DM5PR2101MB1095:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1095E5251AC5C674FD5A54DCFBD40@DM5PR2101MB1095.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(166708455590820)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1095;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1095;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(39860400002)(396003)(39380400002)(189003)(199004)(305945005)(316002)(1076002)(7736002)(14454004)(86612001)(25786009)(8936002)(2950100002)(110136005)(66066001)(186003)(10090500001)(6666003)(5250100002)(2501003)(99286004)(76176011)(86362001)(575784001)(4326008)(68736007)(3660700001)(105586002)(8676002)(81166006)(81156014)(106356001)(3280700002)(72206003)(10290500003)(478600001)(2900100001)(966005)(59450400001)(97736004)(54906003)(6512007)(6306002)(53936002)(6506007)(102836004)(6436002)(5660300001)(6486002)(107886003)(26005)(2906002)(22452003)(6116002)(3846002)(36756003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1095;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 3kh08M959MKXljesXeJY+RFm6ZQogr8aZwt7HVCSZnes+aD8JhnsXqGrYdrfs3azQsibhjwnrrrgvZsuez7IabcIfqPxujYoLVmzLdEUd4TSW52QXGpZHffeplJKyWaGxjpPL5RHpycOckq8ADy4s9yoijUe4rYmF3hNwHkF+jEuJSG12Md9t0psJBnFRxylhcde4nGWhU5CYnZUyBi7a0OWSbqJfKRtjkEfPNRdN1RgnFmQL21Mune+07LXGXwd9+1whFyuq+D8gSaPe41Q0K6OeKMlKCOlm+pvdCWsrzKPr9Sawc8KQv+czxOjOzIBW1G4H+x3PaMEao6bPkHlNg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 671b9926-2d10-41b5-6434-08d58db3fba0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:08:30.8790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1095
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
index e54bc2aa7a88..a05b3b79b987 100644
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
