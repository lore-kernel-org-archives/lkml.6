Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4147991-1523246827-2-13247223919589686375
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
    1523246826; b=tyRaWViWceqM6z88q1Je7WkKKOwjoltPv0+mrMeazWvA6BCenP
    nTKEf53xDgcItNgYYTTIUdoXctLwaD1GXsAHDYJ9YF2/QrHsAqzeeAwftp6wEfXu
    p38GqHWmDpL1P2zrAqzGkWvatpObhVvshd/OEnJcFz4CzamgSQpqLGAq+D2+g0W2
    GRvfxVSdLc/epCxEAyuyQa4HtS9PS5jtMiVwMj7WW0HjmoLMlPPNkWMXO2TgCKiq
    P9yvXwo5b3rNTacXebJr6x6jHhwHw/1Sj753nKrqaCAGJEA63aXc578KWWB7wG73
    Gox1ZhFAvQXWlIwxxjcPoAfXdTrc3KdzeL5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246826; bh=FL7VU5+1Hg
    3qfgTcco75C2Aozv/Xkw0r/ynpJnJMTPs=; b=FKjOEEUMVj1eCoCopOn9l4U05V
    khvMwJ503vLon8UDMfWc1tSpbNC1XklL2dBKO4CSt7vbG8jiu8LoqcvuqwTbRlGV
    r8caVoeNH+DTfpX1+qTisHHk4VjdykT1ri9rPSAG81ic75jdRNZbZWqRyKlYhZtG
    +6D1mQRzIyiQKf9RxmQPjVVSjO8CmFYQ3N82iZ7ESAtRO5dk7c29n3zYJqg2cp6l
    V+/UcwyhUAsgMpK2oIhfEagKquuT6lwAsqy3vkzagjWfY/S0hg89KpGoK2bWfRY/
    EXVyPtcoGKoUjSSAl4CHW4QfPBNvpBouQSCEbb8klYNQSDSEXlUQ87aK9A4g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nziSb05t x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nziSb05t x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKHkpmx41NczAXKJJmcTDJy9kdDahLcxKLs98BLbHA2DgsIK5FWJaP3dDBsoeeJaDJOPKrKbme9QyeD1BCI/1zoEsFK90kgleUuX/fKZbjKA9fCnCVvs
    01WiSqCnaiXRnivGNCQNSS2aw79QnVkNzOBS0Ol9t+P39Nl9y5OEahJvVWIreZjq8TJv3sGzD2fp4W7D825rthDZlOl2Rrry+4WSTIdBM9cDeiQtbe0iJfPk
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=meVymXHHAAAA:8 a=CjxXgO3LAAAA:8 a=VwQbUJbxAAAA:8
    a=Z4Rwk6OoAAAA:8 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8 a=AihKrKVWWoDczpLLqEoA:9
    a=wPNLvfGTeEIA:10 a=2JgSa4NbpEOStq-L5dxp:22 a=AjGcO6oz07-iQ99wixmX:22
    a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753205AbeDIARs (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:17:48 -0400
Received: from mail-bl2nam02on0136.outbound.protection.outlook.com ([104.47.38.136]:51875
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753180AbeDIARo (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:17:44 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 031/189] tools lib traceevent: Fix
 get_field_str() for dynamic strings
Thread-Topic: [PATCH AUTOSEL for 4.15 031/189] tools lib traceevent: Fix
 get_field_str() for dynamic strings
Thread-Index: AQHTz5ga7et8I7wda0uPtGU9itjvwg==
Date: Mon, 9 Apr 2018 00:17:11 +0000
Message-ID: <20180409001637.162453-31-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1048;7:XNErfR19LlUPTf8AtwCUdt/8jm4g4KU2jCibirC0Uqs1ccGA68FRMsBQF0VPxgaiICgPMJhaFOfjc/puM/jsukAMENZg5096Woe010TUF2/WOGrBoM7zRHQrBQ3qYA9Tm/ByompnIWNpDTMs1IrF79v2szdLfoFedsXEGVLp1jLh7o+Ly1CfXmzb1eikH/0XNHZaw06vvxVI22K6Np9BDmlo5VV++lj6RetMArXPzmRvRBLziXb4hOUU9FF0QeKa;20:+ah1PAMXD+00rF3LYjPp2pM7/+sC/q2qtxeBlaHKII/om4rmlKv6CSMH8fgaiFVedmGWrUZjYUXrLCHgovjRvzmWS63mlucOLCZLZBqhuxDOm3KiZXeO8/LYjFLsb7mmQeLnBmBm2GDQ1bteRfZStoO3+vLtOzwCMCBHV9zlbys=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: dc2b248c-16a6-49b4-6ce4-08d59daf4ef4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1048;
x-ms-traffictypediagnostic: DM5PR2101MB1048:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1048459797AFDFDF25A011A1FBBF0@DM5PR2101MB1048.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301)(201166117486090);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1048;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1048;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(376002)(39860400002)(346002)(396003)(189003)(199004)(86362001)(1076002)(575784001)(99286004)(6116002)(110136005)(3846002)(54906003)(22452003)(3280700002)(105586002)(2906002)(76176011)(4326008)(6512007)(6436002)(6486002)(3660700001)(6666003)(7736002)(59450400001)(86612001)(25786009)(2900100001)(14454004)(97736004)(6306002)(53936002)(107886003)(68736007)(102836004)(966005)(36756003)(6506007)(26005)(186003)(106356001)(305945005)(5250100002)(72206003)(478600001)(2501003)(10290500003)(81166006)(5660300001)(8676002)(66066001)(316002)(81156014)(2616005)(10090500001)(11346002)(446003)(476003)(8936002)(486006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1048;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: W8IUfRymIDUkQHyt/+N7fw7cnPC4WSiS7BInrflxZf2Q0IQoMThW4hY8pYL2BlBkDiHK2jIRL2fZ65d/0PNattixwjfppO7w/kQDEV9hC5EZXVCv9o80rtQftS0iEvNNFvME/NTpvptJ8mcG2q+os9dqiL6+kq9mtU2byuUV2ibIg3q2jMGe1dn+ui3RHEcVoSVd5nBSOn4BU4T/GVDvSA4rkqfvmmiiHq0heo3iTHbPU9NxZqeEVizmdHxYRPfvmfnYQ6L64R65V9GX7PvlLjoyHruZD2u25tXUYUQaNBc76wOZDaYJlJQHxrTMlzJoA9F7Z2ux2kERnkHNJgnMi9JU7RYNVnfVp2boGcK9bchdB610p7O3F6zzEiYVjxqYyqUFSuhMra5bdrqhBt0swwl0lz4zDsavbGo9lMm3sFU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc2b248c-16a6-49b4-6ce4-08d59daf4ef4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:11.0427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1048
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

[ Upstream commit d777f8de99b05d399c0e4e51cdce016f26bd971b ]

If a field is a dynamic string, get_field_str() returned just the
offset/size value and not the string. Have it parse the offset/size
correctly to return the actual string. Otherwise filtering fails when
trying to filter fields that are dynamic strings.

Reported-by: Gopanapalli Pradeep <prap_hai@yahoo.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: http://lkml.kernel.org/r/20180112004823.146333275@goodmis.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/lib/traceevent/parse-filter.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/lib/traceevent/parse-filter.c b/tools/lib/traceevent/par=
se-filter.c
index 315df0a70265..7b664fd1ebe8 100644
--- a/tools/lib/traceevent/parse-filter.c
+++ b/tools/lib/traceevent/parse-filter.c
@@ -1879,17 +1879,25 @@ static const char *get_field_str(struct filter_arg =
*arg, struct pevent_record *r
 	struct pevent *pevent;
 	unsigned long long addr;
 	const char *val =3D NULL;
+	unsigned int size;
 	char hex[64];
=20
 	/* If the field is not a string convert it */
 	if (arg->str.field->flags & FIELD_IS_STRING) {
 		val =3D record->data + arg->str.field->offset;
+		size =3D arg->str.field->size;
+
+		if (arg->str.field->flags & FIELD_IS_DYNAMIC) {
+			addr =3D *(unsigned int *)val;
+			val =3D record->data + (addr & 0xffff);
+			size =3D addr >> 16;
+		}
=20
 		/*
 		 * We need to copy the data since we can't be sure the field
 		 * is null terminated.
 		 */
-		if (*(val + arg->str.field->size - 1)) {
+		if (*(val + size - 1)) {
 			/* copy it */
 			memcpy(arg->str.buffer, val, arg->str.field->size);
 			/* the buffer is already NULL terminated */
--=20
2.15.1
