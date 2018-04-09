Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523238971-2-4198914458772243290
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
    1523238971; b=HYT3Z1B98lUEPn81gL+OP7J/lAk7qlnqxXJ4YouiDNsB8VD39O
    GmSdvaiaIu9l50a88+AHG38FV3jaws/CThxr9xRfsCldYN4PEbaf7qI0/tqDI1Sf
    K+GDkoaMWKSadXYk3PJ15yxa29OV8SJLFfumIxW/tahIWzBVUs4C339kfHItsc+a
    BlLd+QMCR0t7ZjzOuTBgU14ltsi4udwIfeult+SxOY0TF9B7gYdtWygX8cANmAZd
    rD5u7vlI8uwx3rfpNz5VdKaYXyFCZ5+yzkszkUUpxs9rWnsJMlFoJTp+qg7zl00u
    tQgzjb2bokflJvWn6l4hNyvoOC/viRu3WKsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523238971; bh=BGZGKVLPX2
    ozJv971rgLYMF9s565z/nxvw5lRzjb+VE=; b=M0xLBAg67TCd0l4HcLZZ7tISxD
    6tgMsI9Zl/HMQ4YUXDEyZPSavEuvyeuFitDmUT0dwSNlDXW7G6vJ33K4etrwTrWX
    uq7ywZeIZY9UQi6SlZOQtlAtQ1tf3ZweIzL2pe//vTCji7EW0LrXMFprOPXf6OA6
    78DjPw9ekhDD6kxKWuVDo5DvhkR9Rwg6OH6SHhF6WBu5fAByZmEfzvafVCvNOXAv
    BIyjvGKLKrPbNlQv7n/S0m5tGtVP+Gwqy+Xz/AtaSniDQ1JAXIroihlk0ko3O4rS
    hPLo0NGSRssN75IYJbC+JRYD5qRe/tGNY09uCNU7PMaFfqKTc2T23t0iS88w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=G1LdfgIV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=G1LdfgIV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPU/wta5hcnOpJHFCIi/AOPt1Lp2g5DObKLZC56DdwNb37OgLC5R3ZS8TuErETwi3WQiUwJLNS3gNpjogpTzAZ8UiNInrdtkuoXTdJF7aKkZ3mc3DKk+
    ShopNaAMetkOcalozgzIWQULqlvVay5J5nFM6uA7qehLFWiMpZr+bd3DIPPW8VbG8dUNAouBLnCRMO+GiR9Ia+Xb9Vq0i7fARCZoR7DpPMejVeD3KmhRANkm
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=meVymXHHAAAA:8 a=CjxXgO3LAAAA:8 a=VwQbUJbxAAAA:8
    a=Z4Rwk6OoAAAA:8 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8 a=AihKrKVWWoDczpLLqEoA:9
    a=wPNLvfGTeEIA:10 a=2JgSa4NbpEOStq-L5dxp:22 a=AjGcO6oz07-iQ99wixmX:22
    a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932392AbeDIBz4 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:55:56 -0400
Received: from mail-by2nam01on0100.outbound.protection.outlook.com ([104.47.34.100]:61248
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932170AbeDIAc5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:32:57 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 223/293] tools lib traceevent: Fix
 get_field_str() for dynamic strings
Thread-Topic: [PATCH AUTOSEL for 4.9 223/293] tools lib traceevent: Fix
 get_field_str() for dynamic strings
Thread-Index: AQHTz5lOCI3gA6iahkyqtoB6beF+Qg==
Date: Mon, 9 Apr 2018 00:25:48 +0000
Message-ID: <20180409002239.163177-223-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0998;7:wfPgjQ24V5U5Of3OkTJvhFs0pbNOc6Oxes2hROYPml1HihyD/uJMXTJrWPN3bLaBSb42zCBSlRvv3S21leCHAgNFYt8odAgBLqxWMrJvK2vNWOmWi2RIbwTKJoGpjKOZDHVz3VC1OBMCZCu4PxNmzDK9VAq+r66mz0rQRSbC2PmYbp4ybdVlmGfQKFkh4w1rLMpJmU4Q3UElltu3dpxZ87G5LVRXj/O292KF9aMJ5wi+4IGxX5eM7W9ZOJR2Xktn;20:8202pT3ZZah19ot7RnD0tFsZjS0ojIe9yC7Sp0DzE9H1uPRF5gSKMg7vHkJ/J7/34nUQSb1ZaCL9xReM0LY9IrP6PhfljNRhf9g285fhK38iHbaHR1mKPFUABrIemHdztkrh2nPkE0+0yCOIGyw5YnKTjxlF7IbFjjFbczag2hc=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: f384954e-adc9-409f-bcce-08d59db16f16
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0998;
x-ms-traffictypediagnostic: DM5PR2101MB0998:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09987CAE0213E5638570C0F7FBBF0@DM5PR2101MB0998.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301)(201166117486090);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0998;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0998;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(376002)(396003)(366004)(39860400002)(189003)(199004)(25786009)(59450400001)(105586002)(14454004)(76176011)(68736007)(2906002)(316002)(97736004)(8676002)(966005)(86612001)(3660700001)(3280700002)(102836004)(6116002)(4326008)(8936002)(36756003)(22452003)(81166006)(81156014)(54906003)(6506007)(10090500001)(2501003)(6512007)(186003)(6666003)(3846002)(486006)(5660300001)(6306002)(26005)(7736002)(5250100002)(305945005)(99286004)(2900100001)(110136005)(1076002)(6436002)(53936002)(106356001)(575784001)(107886003)(72206003)(86362001)(476003)(446003)(66066001)(11346002)(478600001)(10290500003)(2616005)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0998;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: PFdGzKP7IFRgjVXgsVE34QGC1k2i9wSyPSAHwOBtFpsIn5Ymol9pdq31DM+RYtFjX8MHe1WeOJaidQbcfqVX713eZ66aIgNlFTeXI6HHFD6bN53UCPbsjiQ0asLtSe6B1fCIXWcvcT6gasE4E5dxaqdEp/dTa7CCERafjByBZYT4SK6NA9gd0/hlQ3K+CpOBRzQQ18N6gHXCL4bM4XAFZH1SkKlbttNW/07LtQ2WIhf6dzZpBiJCl0QlWJD2cQ1KtC1XSuEGuv5+M7y4u873F72aPAFz+jwfVzkHhg89PIS/GtkkYLPeN5QNtLNHiR1xs9p99D9hAe3OtoezR1PiM6sL/oGTo+jV4EH8lVluUJeBfNAC+3uoM4x79c6GxfT25UJvABQIS0jvSwz+w+iuaCIOWaWjQkKfk3GbMTtC8BI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f384954e-adc9-409f-bcce-08d59db16f16
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:48.3316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0998
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
index 7c214ceb9386..5e10ba796a6f 100644
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
