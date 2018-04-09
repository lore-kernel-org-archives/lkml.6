Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523237851-2-1305197623726780031
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
    1523237850; b=D0eaU9xZnV8/ee6nRkCaZLWaDvkX/sXNJ/P+6oRXfq1sxhpAsV
    2Z/zoMrfmogVOp2as1EedohYS8rYQswOkeqid0DJjP+5LnyJB23UlWUm4uL9aqss
    DJRL5a4t1HCNZbACwFk2Le6diu1BJ6XMX+b86zAJ4f1AhVXtquFoBGb+r/4GI85F
    KoOgdWLPErKA28ETmIT9FPhrYSNryutt1JqHcA5tHE/WXLx9R6eFrswpuKym1q9g
    K9SG4u5Vq4L8qYBFJ+hFZZYSdW2vRPy3ONxaEpq2JWPVUAIT2Be0o8s/WsuEnf71
    Gu81fIZgREYB4VJdRNDJYA4albW54jzVz3yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237850; bh=a+ryFzz2Yo
    SYziBEr2r9Lv54Fq4fhTMgtWKKzRVGVnw=; b=ZTOQxGm28VSHyy96BebZ/36Hvf
    r7iDBaR1sZesI0iHlAQrKpCWy0f0pgUgAU/fmucPQY7QnEwk5CZywECLVAb9aQXB
    5ERygxsLqQ0ZKD9hFOpxvVRGKgvulwFpbT1mkLsVdzLT9a7GD3liN/F39VS4grKP
    o8Ae7PxFKqUIiwyPLyH7FAANdlW18GIw4tnakD2AblLiBo578ZfYd0L5bEehze6o
    O7YxIPZ48YQ/RNBC3nQlzCwJ/PgfQoiQvdWpxm9rDMS0FPrPhVmyI6Zwlo+mWn/E
    GjpbagB9C7JcSXlHkijou78CNpQHJLdmRT+Fd2b8IuZqhE1DbkW6jCQ1xapA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BjcH32S/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BjcH32S/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAqlAoLXxjyUDi4LyrPP8O8LKbeK3sJi7fCtg50PO37DG4z2B27wxxLFmdDqlOzMBXSeDPsUpzr/PimpkCMgRe7koaTv4/9ztFhjpmo5BOEs8lQHjYTI
    hsNA2qcH++Kx/ey1+wNDCyhkXJMy/8ias86/Jdvn4iwX9smSurWqoV5y9tG+8sohCvOwjbVYd1R/VbcqazOyKuiz01vadYMPJiu08740NooskGRqF4EwwUvP
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=NEAV23lmAAAA:8 a=yMhMjlubAAAA:8
    a=WVfum9TogFa7DQqzukUA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756062AbeDIBhA (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:37:00 -0400
Received: from mail-sn1nam02on0094.outbound.protection.outlook.com ([104.47.36.94]:35040
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754839AbeDIAfF (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:35:05 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 019/162] ACPICA: Disassembler: Abort on an
 invalid/unknown AML opcode
Thread-Topic: [PATCH AUTOSEL for 4.4 019/162] ACPICA: Disassembler: Abort on
 an invalid/unknown AML opcode
Thread-Index: AQHTz5mbZRSPQNnwlk6WZ9G0lNmnBQ==
Date: Mon, 9 Apr 2018 00:27:56 +0000
Message-ID: <20180409002738.163941-19-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:WFjfwuf7KExNA+O8AMxUDYZSeno/mhimuiC/n1OmanlNM2D/2ggrbOWKLq6gNNi+92X0Xo9UoXZZB85IibboNjt8HrY9UwRjTeMfWN2ty8CmwlssXC9rNwe/cFSR/3UsilbOQUIRi5F7FBB5vR4jApy9d1xe5BJps2Kvo1wOQGjgA+sSlhA4Tjn8f/b/0WrYNqLSMt+634vnIxHSXlao3tktoTraR3J9mneg7YSX+dzOPVoEHJtovz5+zIjJ+1iZ;20:nMFYjk6CjXEOHA7vqIR1lkJxr7RTSCy4j09nSVtTT/lLHHTOGgZcTxtBWGWgj+KUW3XhT7ORphflry5f3DMkQqMhizBbU0UJPCA9HArULvegppWQFYD8ul+NlfTGVLXEiQev9Tm7yfsNFP4MEMTLEbHRGdkkoxakzSGihfycsDA=
X-MS-Office365-Filtering-Correlation-Id: 3566ea9b-a940-4d40-f7b6-08d59db1badd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10130484CBC20EED0D3FB97EFBBF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(166708455590820)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(346002)(366004)(376002)(189003)(199004)(478600001)(10290500003)(6436002)(5250100002)(2501003)(14454004)(966005)(305945005)(4326008)(66066001)(99286004)(10090500001)(6506007)(36756003)(102836004)(54906003)(486006)(107886003)(76176011)(59450400001)(2900100001)(22452003)(316002)(110136005)(575784001)(86362001)(3660700001)(2906002)(81166006)(186003)(86612001)(81156014)(2616005)(8936002)(3280700002)(11346002)(53936002)(7736002)(476003)(446003)(72206003)(68736007)(6116002)(5660300001)(106356001)(6666003)(6486002)(8676002)(1076002)(105586002)(26005)(6306002)(6512007)(3846002)(97736004)(25786009)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: M5fhbDU2s4YwdSFGp3CxdtbJFC6kCMjFIuw7IMmd65WoZms+oMbx6a+RecSOj/Vn5cvSmqyKLHzZBmST5m8e5meYeqMCNjUalZP0JvUNvwnn+izsXLGjBIypccNZpH77zgUZHQQCEbZ+PjJ0hK6EjWJOPv9HY9vEMGrTbAsREFENNqdA8rmwkcb8L710UXCPNaCGjbVwXnq2SWaq88LVtyW4W4duOWEfaC/RHZbGbWu8uv9tXRQAEQg+efwXrmHF7uwoLLAg1qfJ2+HjppASCeDNJZ7QDPqbkH0XQvdWuN3+v9waTYYsLcHYF2V45MYzfqotmd5fRrM5t+ET2waGxT67AcVcgKhLNXCRVJ2BwWda1bZqxs5A7vH/92n/aRh1QA57c74un/NqhcK2iGcYeCMG43Rn9zYbo38jpsP084A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3566ea9b-a940-4d40-f7b6-08d59db1badd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:27:56.6766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
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
2.15.1
