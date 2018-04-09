Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523236527-2-2594384541000453342
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
    1523236526; b=CIYi3qbTz/+4hdIlxqadbHVCKkHrq8w1thlgByni3+tafaInyy
    XUoUO/w0jlRnAuj7b4pKoPg/EdxDHY6zYJGcA8NEItciwCihl6bMwmaYF1Od+ttQ
    PNuvbpTrCj8fgE2bkWBb5raiXMT2TbhWgSYTUqD5lrcfYjf1FpQ9MYIbhRi/4k2v
    gTDbEiw4CyLoDuYDNgtGeZPNim9n36+NWatm+Yy0Q1gqq436FUFPZRzYM0IYD1QG
    flnoCzdbmCnVq2kyHUrPlwinych8VB5skuQy9jzebVuIq13inLjjkw0vdUw6l8T/
    ON+UdiAwAlhP7PgpIR4lDxAOPcx6kmWpq69Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236526; bh=QYwJ3ULVvb
    W61np+Qveb2pxWVRya+JZDJf1S2HG6b24=; b=AjJNzKEmnfdCRFLrc2MPEdI8oN
    4sxf283ZSnIFbuTAV3cwOSgXtL1ywR4Q5Httwy5ubSPZkgWJsM10UM78CvO28sa6
    LyrhKO7KrYrRDiJmBSg0eu5NSq7ZlMvquF8ce2CCDR3tUbCbzqY+K9cUvXLCwr+w
    5GF1qhzPK8IQIeQJveXa/JtHOMvLGl0Dsf6RoGvlXYT5CxeUttnOcadgEHEsFQ0h
    mleW1hvXo9KIEbcAwKOv5rv5pctsU5tAt37UZE/Xc9szPjlOfYqxuQKIItyVhrLm
    AiaGG6t68UcEXGyCL9zcaxNpV8Q3HgaMrCtu0rfAjU/5Sj44O9A8DNgPzuhw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZNK+zP7s x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZNK+zP7s x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIcbxsAt7Wn1GyCAu6E/ktF6V48U32IAxvXttVcYhFFmxS44hpAHCXBC9c0Lvh2tNuebqcWyEnUcbd9bgXyzkoObH8h9ujNQ2Lykwa3DU2gmjG2/yfW7
    E55QGM31MuQE8gKQ1p4VCZ1OzfeLmHKYjqvfdVVsUpHE+92gNlPuMX1UkwSAWGr0jQ3qAJsNFFo7i3YyuwM9jX/pvdjeD9CliwcwU2RHGJ5TYiRiOmQN7u7M
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=meVymXHHAAAA:8 a=CjxXgO3LAAAA:8 a=VwQbUJbxAAAA:8
    a=Z4Rwk6OoAAAA:8 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8 a=AihKrKVWWoDczpLLqEoA:9
    a=wPNLvfGTeEIA:10 a=2JgSa4NbpEOStq-L5dxp:22 a=AjGcO6oz07-iQ99wixmX:22
    a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756708AbeDIBPX (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:15:23 -0400
Received: from mail-bl2nam02on0103.outbound.protection.outlook.com ([104.47.38.103]:27456
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932879AbeDIAhz (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:37:55 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 114/162] tools lib traceevent: Fix
 get_field_str() for dynamic strings
Thread-Topic: [PATCH AUTOSEL for 4.4 114/162] tools lib traceevent: Fix
 get_field_str() for dynamic strings
Thread-Index: AQHTz5nIrbOuDs+ICU+EqXjTBVLQ6g==
Date: Mon, 9 Apr 2018 00:29:13 +0000
Message-ID: <20180409002738.163941-114-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1110;7:CRD+aJKrQRsZd6MLF3Xnd+o9kXuqsNNcJ7aptJ6ibXiwOR/7/ygDKEY2QZOU9BuDkONWeYpMpXbCRmVcOt+BnB8VwaVhTJfcC4nJwvqLtLl9ha9QrgCxkXqAMitLrw7Ls8H9zxR3lnd4/YlCBVLlwVbrPVsAlQWXu7u9gPB+JXldfGLHGNCLlXynmI2vMI/PTdtLxFCPGVfoBsd/wawo3mKtN1THeIdlsPtfAkqfD9203xnFI4uf/noXUhuaH2+i;20:f1rn+GG5m/MxEmHMy4mXl1YcDkuHprr1wCKGNj1f8WzE1Xv57cvcMZbfQuLNW0B20dKGKB6p5eaC8uCh9SpwTk8d5+ieA1a4wbZbDGPoOjxhGvUfnENepmQFa43oepxwT9AluYKWy6wo1QxVMpn1D4cYQlSJZ3reSyDFTX5x5UU=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: ec67c57f-d696-44d0-cbaf-08d59db2203d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1110;
x-ms-traffictypediagnostic: DM5PR2101MB1110:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11101DB553BF4F007B5D2722FBBF0@DM5PR2101MB1110.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301)(201166117486090);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1110;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1110;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(346002)(396003)(376002)(366004)(199004)(189003)(53936002)(6306002)(186003)(5250100002)(105586002)(966005)(11346002)(99286004)(476003)(66066001)(6512007)(86362001)(575784001)(3660700001)(1076002)(54906003)(68736007)(110136005)(3280700002)(316002)(305945005)(4326008)(107886003)(22452003)(14454004)(7736002)(446003)(6666003)(2501003)(10290500003)(3846002)(6116002)(72206003)(106356001)(25786009)(6486002)(6436002)(8936002)(478600001)(5660300001)(86612001)(8676002)(81156014)(59450400001)(2906002)(102836004)(81166006)(6506007)(2900100001)(76176011)(2616005)(486006)(26005)(36756003)(10090500001)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1110;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: ljpsrO9d1f30VR3M4VGs3NSmPp8K6LmJ0sjDKUyklBdlQbUOynIMdfO2a4smIyM31EAiUL4DMRSjW6/H2OknOE0bE/rnY0I3jpUGIFwdqyC5OSt5aFI9wNpWEQJN9ZDbQv5yRjM2Gqnw5aZEj8rcZxYPOH5IG6/UgKAhiDZE4zLTYYY52ipxxvHM0bduKLbhKMTUymf4U2kOI6xgBJ4KEI3ai1oKpxJ2rIHZ4AWiWZDRMP+VRRHI1rTpbU2x8huDOW+2NOa7HmZ4A62TpAo1QCoR3t8p4yRYUgkfM5FfYrhRW10sHq580KbWUjoC1jZHWHRpYblcEdiF0/gxXARytdD/Tu8sapJZBy7RwLF0C4U0dM50HSSpY3i+WJUh0yOINz8C8AhF8cGCRfgFj248ZzwUhxpsNBUyxgydgoU0j7o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec67c57f-d696-44d0-cbaf-08d59db2203d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:13.2242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1110
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
index 88cccea3ca99..64309d73921b 100644
--- a/tools/lib/traceevent/parse-filter.c
+++ b/tools/lib/traceevent/parse-filter.c
@@ -1867,17 +1867,25 @@ static const char *get_field_str(struct filter_arg =
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
