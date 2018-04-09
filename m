Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523235011-2-6159076621602677025
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
    1523235010; b=cG5cl/Mvh5U4Kp/AiuRWziaeK6BvwNvKwlf1OwA0TBNG0BjaaL
    /NPAqWliHMtEp43oGZNFePnCyR2hOe/a1xzJpi8aTxs9qSSycd+lhK91HAHjCb4o
    PHjeFabptj8SPAkUrtnEH+98axjTgKTEcKSXOGj3HqYs7ESPyLKrjeTFhgIdd15G
    +0LAFC69ZCHsiM/9kk4v7Bno3sKDtH6P1xBIL9vXuocsV0ZMLqIh+Q3TSS+wzJQ9
    ZppBgm8PCBaQr3K4PybPU4dmELWHPfsQN7mBBB52kJxxmHyHfP9yfv15A0bmKzy2
    k5yFlq5lP1857AXaMIzzQQf4Kw9Zou02styw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235010; bh=QYwJ3ULVvb
    W61np+Qveb2pxWVRya+JZDJf1S2HG6b24=; b=b84MHiz5JJoiXuv+1u4ZzA2FBR
    6zQs84TZiTxxoFLzAE/QkY5jmxW7j9Nx1jtqc/tM4Q8aN1PzkeE7mivh07cCqspF
    srsE0iU/fznFs1ttloauNOPKabEdCelG8jlSh9bts9j1qIx92S4QvGnGiJmfJVc/
    uo+lU6jjl8ZyIoHSr9WJoXIVd0bHwnAKYd15A1pjBKyfZTpTEtcXaQ7yZZXxD6Uy
    0tP/+Aqand6NWan13m4ODuBFIOVfDJrcgyu9ZMpAWZti4HKvtRjdQhshmXHQ7lYY
    qvDkFQOIP7VBWwtkpi0xiqynkhWXzB89IZKKqcasgC5f4bewlUiRtAl6gfEw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=d8S1MpA5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=d8S1MpA5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMXDwDaktedwyjvv4ywwNMfRtVb5kpRp1tlg52ViqGTD5LYMgbz8ia1hqxRknZqZ9FhzH+rGx33Enu3RljSuX7YB1MPjVAk+q0t2dRzKjlvo7frXddhb
    pmbA/9FMH6engfF0eTbmea+nrvzXJpMFrrtri97PFvEMRo2b5xjATNhBBLGbxBlfIMRMnvgmKdKQwF+L+WZTjgVfrYcA/eLabwgPrDjwC7RDHr5Nr6dgz7aQ
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
        id S932257AbeDIAth (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:49:37 -0400
Received: from mail-by2nam03on0126.outbound.protection.outlook.com ([104.47.42.126]:24363
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752865AbeDIAlg (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:41:36 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 069/101] tools lib traceevent: Fix
 get_field_str() for dynamic strings
Thread-Topic: [PATCH AUTOSEL for 3.18 069/101] tools lib traceevent: Fix
 get_field_str() for dynamic strings
Thread-Index: AQHTz5uAfWkk0F6GnE+shwq46QMJKQ==
Date: Mon, 9 Apr 2018 00:41:31 +0000
Message-ID: <20180409004042.164920-19-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0901;7:c2tE5Dymd49S2JgSLbNWZARB5Tv35XFHs6/l4b+6r7mtM0Wov3hC6j5VAy5N/1XME14lWI/s+Qt0opbQW5PhQYCZwU5UCoNtCfXb/gVpK6THu9UuWkHkLgJ+Z3/Ek7K/ksMkf+bsaODinIPJhInOa3jwdIyheXmF620k0Dcl2fmHOO/c8e2fjWzK7exmYAf/kEdnGs93cJFLpPY5upWCzlDcNGaegVNHlI+Xs0Bx96LRLKRFxbXn0QFHGBsw7Eim;20:NaKNv7gKG4EtOv6GKKU/y6rtGFyyNZs18u2IWz71x+o2EX5gVCI6oN7NTX0KN6stFVvjJTlG8fo1BQ7V+I3R/O1DJd7DHG/G23ANazaApdzD5AjZDU+UD7zUcxgeRaLlqVRwyM8xV5HyF6XNUDh5kpClvdtiLl1Dk4bPnsGQVp8=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 54241127-f300-498f-ea92-08d59db2a350
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0901;
x-ms-traffictypediagnostic: DM5PR2101MB0901:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB090191B4FA17C6438F69808DFBBF0@DM5PR2101MB0901.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301)(201166117486090);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0901;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0901;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39860400002)(39380400002)(376002)(346002)(396003)(366004)(189003)(199004)(59450400001)(99286004)(68736007)(10290500003)(25786009)(86612001)(6116002)(66066001)(97736004)(3846002)(76176011)(6512007)(6306002)(54906003)(6436002)(4326008)(53936002)(105586002)(110136005)(6486002)(3280700002)(1076002)(107886003)(8676002)(10090500001)(2501003)(966005)(81156014)(81166006)(5660300001)(14454004)(186003)(3660700001)(102836004)(7736002)(2906002)(26005)(5250100002)(36756003)(478600001)(446003)(316002)(6506007)(2616005)(106356001)(8936002)(11346002)(575784001)(22452003)(2900100001)(86362001)(486006)(476003)(305945005)(72206003)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0901;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: M3go8di+qYO8Y9ozI1WKTOGWteABxS0qFYNnUDA7fbkrZ2CypCjGE5Deb456+edl26wL0tw5E//7dKfcdm4FIm8YIJ7Cip457nTkZquS3jXfxpYRxoMI9tcNHX5JaarsdBKsVssTIAuXQ4p+emk+XC9zhbWEWSwAbKdpyy+qyPCk771kaFhm1/n6ujGoVcsRF2EUN/Du1DEs7YZZK8dqksGIGpoqBkth43Q8qyddGcZR/oPTx32NFlZQWrMCbpLI066fw/4dHc6xt9O64cVt8yghoHdMaUz5jZJJWUdPXe70HQ7lLiOX4rRBbLTej34RC3B5i5H31/9en+hhc4hlROKhQUIiVlc7poJM8KTXMXx6lX4IUISaxNOaefXpCu1duVrpvNuxQJVVK6TKrpyFie15ZeOFnWKtP+tLZBI1psM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54241127-f300-498f-ea92-08d59db2a350
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:31.0646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0901
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
