Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4122441-1523246878-2-17769612584292893804
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
    1523246878; b=ONHwjWrol0ExnknecTDyYQph+/UkLE1cTLQnz7Hq41z775bETr
    jiDij5Yn7/NSIf9sDv4J9XNSIynt9zHAORQy2TaEAHDQ6DhD66V8eQ6F8bNqd2c3
    7gh5bhZulHcdSissQZVypHoOA7QIs4ArgxfAN8oSfqtk+GS/NtONgJywwrApjIKG
    f04BEakaLC9ubUNYvo1JlbBaRgYJ3DRrEjazoGLL2fuwypp1Y3RJ6MC9GkDH8PtV
    NU4td9QpZPWV8DfPF3EIEuWoOlZWz09uTbVJCue27ImTwKMXQSX+0iVjGJHENojw
    6mcLcU6ODwkBYDSyU9jZdovrxy9ccUnAq0ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246878; bh=Efnd2MRltG
    CABucCEZR3ZyG6PD2bybN7herY4qiqo5o=; b=Ce5ZRvUc13jYCzfXSGBmiwvFRg
    AUc6jkxrS+Vpqw2CAG6gMkcw5Lj2KkHYLGPdOhfdKu7AVt5l2ecW3ahHaAalCozj
    gAgmLVFiGEKKpnsYMvwXPE3fuJ0ya2bREu1/EHjZdmgJaD93PvT+vqTyvDE6K1U3
    Ff1dyHxN3tPeXMqY/qh4oYui5bskBshd8DH8AAfEwBhXWsGKZ9YRbvdxUsQ176UM
    wR8q34i25SCxUUIsISN3P/VwOBM2PiVVkaUvebeBLU2hiAJlNrNhq0GOueybAJ3S
    jhI1prM4DPkqO3bc6GQdExTQTSzbKyGDZVzwji00dU1828CFl9VewBcmlb4Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YlxTynpi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YlxTynpi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBdhFlurOi8xPH2TWF4KNV3jiR+pVjA4x/cBxBsJqblsArkhwSROYajKTzZhrPv8DwIldGLLHMKeVo2wpYBhQ/A4SuydlI7Jf+FwjK4F0S4iiTPA7Qmm
    igIpaLEtcV7ELXVrt/lRIUay/rnz6X1IVWlZqIZvK7HC+SIhFlRyDPP9DRAe97NAfGEIM6aB9eQUMBHBFoOuWGYQnIJC3k4YDt7Jgq5kAyD+eCFrVS71HzEm
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=AxAqW-uwn50A:10 a=wRwT6uffUbIA:10
    a=t_PdEiP4ckcA:10 a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10
    a=Kd1tUaAdevIA:10 a=Lf-vpJhqX20A:10 a=meVymXHHAAAA:8 a=VwQbUJbxAAAA:8
    a=Z4Rwk6OoAAAA:8 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8 a=xQp5KPISSQHezL6feeIA:9
    a=wPNLvfGTeEIA:10 a=2JgSa4NbpEOStq-L5dxp:22 a=AjGcO6oz07-iQ99wixmX:22
    a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753136AbeDIARV (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:17:21 -0400
Received: from mail-co1nam03on0101.outbound.protection.outlook.com ([104.47.40.101]:48974
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753097AbeDIARP (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:17:15 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 029/189] tools lib traceevent: Simplify
 pointer print logic and fix %pF
Thread-Topic: [PATCH AUTOSEL for 4.15 029/189] tools lib traceevent: Simplify
 pointer print logic and fix %pF
Thread-Index: AQHTz5gZ7p5r7qlp/0mCOghs0h8vJQ==
Date: Mon, 9 Apr 2018 00:17:09 +0000
Message-ID: <20180409001637.162453-29-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1127;7:T0dDEO1z6md9EmUJ2KErwwZV3fWy+V/Y8ckASHxZi2/OU5/Nub8QlgyP5Dwq155biKpZw1k1RrLbU9sufSmMVIGjpcKpB3yW0sEJg4ythuw7kQgRWYCeTELfMKxkCV96nur8dFzGGzuPAO2fQ5fBL5tZHiQwvj5DQDMNMdm2xUJDv8HKRG/dsmkKDLHASU1iArsLL1wrsSxrHN5bjevmXuPT9pwb+YR5Y2dvqTbsgBPmv3jeeg79MLXxjQ3xhm+M;20:kZqWSDARCRXrRVLf2WxHUP53Z+W0JToxFuq+C9T98SRIsruj1PxQZZdcKci31bUz4cSiKrCUFuMUrtwnV4p0yR5aUvlidxaizaPPlpRVCnNGdkkeMp6CKhyMh+wpqd1NiZobmx6MfwvUOn2bEq0+rVG/If0a5JbMYxAV7FE5BYA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4786fa7d-4c24-42e0-19f9-08d59daf3be2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1127;
x-ms-traffictypediagnostic: DM5PR2101MB1127:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1127C64C1927A0CECEA5844DFBBF0@DM5PR2101MB1127.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1127;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1127;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(1496009)(396003)(39380400002)(39860400002)(376002)(346002)(366004)(189003)(199004)(105586002)(186003)(66066001)(6486002)(54906003)(7736002)(26005)(575784001)(86362001)(316002)(305945005)(110136005)(478600001)(3280700002)(86612001)(10290500003)(25786009)(5250100002)(2616005)(99286004)(22452003)(5660300001)(966005)(3660700001)(2900100001)(81166006)(3846002)(2906002)(106356001)(6506007)(107886003)(486006)(8676002)(81156014)(14454004)(10090500001)(68736007)(4326008)(6116002)(1076002)(72206003)(102836004)(6306002)(97736004)(11346002)(8936002)(476003)(2501003)(6436002)(6512007)(446003)(76176011)(36756003)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1127;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 4MUYOT7WfnJO/TvO4UG008QF8kBnB2eitAMq2PYGkSpyToG8I/uO9OCb6cBgSacFIV69O3tq5tuO40FfFQLO7MVnok00f7JVoG0NqJkoOj+Yw+ObVdHGHCzggulkkqta3B0/s3wbwctUF79VVIHQ7nHB5n8gAOzqPEeLZt2bw/bwr1KkUF1ZM/aE/QuTp1ukML7IbiZE7/8a6w/l6aVivwuE0UG3KfZcuR5RxAekbqn1LQk6SVYkoDvbAdddYRyjFpUlBhZM3Z4HKdo/V2yv9aHMvb8zm4WAeNoWhIdFHFMzJPqUp2wil6eXpoO5EtditD28hTqqmciHq5eHx3LBsNvBReuYmXC/PbCjArhQEig+ioPSe7WE23iBXDZujdmaD/ZmCvn2f51JDsBLQx0VkCQPZP/Dk12HF8mtMvJ4fLY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4786fa7d-4c24-42e0-19f9-08d59daf3be2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:09.1366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1127
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

[ Upstream commit 38d70b7ca1769f26c0b79f3c08ff2cc949712b59 ]

When processing %pX in pretty_print(), simplify the logic slightly by
incrementing the ptr to the format string if isalnum(ptr[1]) is true.
This follows the logic a bit more closely to what is in the kernel.

Also, this fixes a small bug where %pF was not giving the offset of the
function.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: http://lkml.kernel.org/r/20180112004822.260262257@goodmis.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/lib/traceevent/event-parse.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/even=
t-parse.c
index 7ce724fc0544..9a17bc27296e 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -4949,21 +4949,22 @@ static void pretty_print(struct trace_seq *s, void =
*data, int size, struct event
 				else
 					ls =3D 2;
=20
-				if (*(ptr+1) =3D=3D 'F' || *(ptr+1) =3D=3D 'f' ||
-				    *(ptr+1) =3D=3D 'S' || *(ptr+1) =3D=3D 's') {
+				if (isalnum(ptr[1]))
 					ptr++;
+
+				if (*ptr =3D=3D 'F' || *ptr =3D=3D 'f' ||
+				    *ptr =3D=3D 'S' || *ptr =3D=3D 's') {
 					show_func =3D *ptr;
-				} else if (*(ptr+1) =3D=3D 'M' || *(ptr+1) =3D=3D 'm') {
-					print_mac_arg(s, *(ptr+1), data, size, event, arg);
-					ptr++;
+				} else if (*ptr =3D=3D 'M' || *ptr =3D=3D 'm') {
+					print_mac_arg(s, *ptr, data, size, event, arg);
 					arg =3D arg->next;
 					break;
-				} else if (*(ptr+1) =3D=3D 'I' || *(ptr+1) =3D=3D 'i') {
+				} else if (*ptr =3D=3D 'I' || *ptr =3D=3D 'i') {
 					int n;
=20
-					n =3D print_ip_arg(s, ptr+1, data, size, event, arg);
+					n =3D print_ip_arg(s, ptr, data, size, event, arg);
 					if (n > 0) {
-						ptr +=3D n;
+						ptr +=3D n - 1;
 						arg =3D arg->next;
 						break;
 					}
--=20
2.15.1
