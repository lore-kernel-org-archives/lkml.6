Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523238995-5-4818275271424069097
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
    1523238995; b=b/Dokbuhxj77bGP6uTIyS7PTzfRJrHhPAkKQPKwUTMdCMCgnJL
    clHvSy/3K0MLdJBMbg34Ev7RijKWWwHiOgREjAt2ZchLG2X2gzVcXf6ni95hGOAS
    NrWU0rXn0g+JmT4su1KeUX7JKyZELFutM1FW7E42SHilPW94nW/qNY5HNICFXKch
    +TIvTcs8PNaGWc+q2hG7IR/pk7Bg5W+6Yy+TpQ8K9CzdnSVbqZyv5HNHrQzdLWvm
    8CNgbv1mrjDj+d073SS4fRZzSt3vJ2i//qwu0MBwmpzh/aMhU85+e1Fsl+66FY4d
    s6DGBsd+9prdk3NlyEaxRA2lY98KWNQb34mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523238995; bh=KznR2mhkcj
    Sok9wVH67zZeIi3AhGggXrYp7HUZQPcL8=; b=kkC14vY5sG0082ok90G/EaN1zB
    jJDvhpgWDyPfIXBAmoPywE7cBKu39MiNNIKh363ZGt4YmxhnnnD+yqxTxdoOrUHT
    A1y/j9aJujN1JfPnUd+xC/feQeqx30Tj7pKNZAzyr8Tg1j4JTwp411U8o8tKW1yh
    pjB+EjjpDMWXsS4cI/eY4EgXBVAKsbaiXaV/nbRtwrYf2nErEdkjyn8a4raR5Abz
    ISE/ZA8UCDwY9aB/kuLUs0QwpW9kg2Qp4hlGEVi0kEAq8CLB8T9Df8culeB3Z3IW
    BblHXBJvAg67l0Yfpg0RO1nGx8M/Pl5XspSiqX+tDG/x78CZmpdA13mCxfuA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iXodTy4C x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iXodTy4C x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGe7+o49o5Z8IPZ1LA6JYmyylG+PV2buuE+GRVydbIxPJnBqUQmZAhYzClaQoeZqKBvf5VqIg4kFpyAngckr1PVHrKdM8wSaD96kmt7VxZXIRNuCjZjp
    cpTuUuzWIY5ocKYKvkQfFWmQnbGk/TKAZ0GSHzLHZEX8oJAFTo5LshywUmvC6vQnyZD1Z330Cq3wOHGIQOzEIKKj5U0uwKYymWl/XA3J4/ZylS/aEfeDhiWd
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
        id S932166AbeDIB4b (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:56:31 -0400
Received: from mail-by2nam01on0100.outbound.protection.outlook.com ([104.47.34.100]:61248
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932165AbeDIAcz (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:32:55 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 221/293] tools lib traceevent: Simplify
 pointer print logic and fix %pF
Thread-Topic: [PATCH AUTOSEL for 4.9 221/293] tools lib traceevent: Simplify
 pointer print logic and fix %pF
Thread-Index: AQHTz5lNzk3xGdBTN06JRaISO4nY5A==
Date: Mon, 9 Apr 2018 00:25:46 +0000
Message-ID: <20180409002239.163177-221-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0998;7:o4rQparaU/3WSoLgZ/r2xlpN1gH/qvPZVXQ2GL53+b6QNgYugVsm1zZ9XZ/pQri82XXMwYiKnBwMMZ//dWDcl5B8QJXaEdjNX+SyBVAOEA/UQiMQT7l6zDv3a/Q5vG+4FDBmqKCNL0zMeVrlFDZP4X34phLjWsEldrPWKoTc/PD6SxzJXgMMSAdZT+WsBNjYwdBN53/8EcwtRaiWEjUoFvuwmYGb0Yv47+JTEkspsjGnd0XkVcTX4gmQ9ifx/ri4;20:Q6xTn3h5au8nD0yNh/9WscCOaS69wP/TOceUG9eFYyefUSUCUWZMQbbyxqCnOxACtM2LnLed+TINTWBPPrjEHD/UfDJq0BRzwcT9abjTPsgzgFLTQaO+d5Yp9HZxgaKE8yry2UIfCdWjXhLkpMnw/uaQgbGEUHjzxuUODsxf7YM=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 39baa282-cb31-42fc-2c7b-08d59db16de3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0998;
x-ms-traffictypediagnostic: DM5PR2101MB0998:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0998265C69C49449F2BE8AC1FBBF0@DM5PR2101MB0998.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0998;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0998;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(376002)(396003)(366004)(39860400002)(189003)(199004)(25786009)(105586002)(14454004)(76176011)(68736007)(2906002)(316002)(97736004)(8676002)(966005)(86612001)(3660700001)(3280700002)(102836004)(6116002)(4326008)(8936002)(36756003)(22452003)(81166006)(81156014)(54906003)(6506007)(10090500001)(2501003)(6512007)(186003)(6666003)(3846002)(486006)(5660300001)(6306002)(26005)(7736002)(5250100002)(305945005)(99286004)(2900100001)(110136005)(1076002)(6436002)(53936002)(106356001)(575784001)(107886003)(72206003)(86362001)(476003)(446003)(66066001)(11346002)(478600001)(10290500003)(2616005)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0998;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: W+iGvfxeEe9Ip7d0Bc/q5Qy9/E3LUgsjPUcgnt7vmp2shNfEysmKowcaWdmeEJl3EbDlVe9LhOHVrmokjVv85Z12X8lZ9lvTznVHlbPndP1V7+46MzTgGLbbVwEJNOadYp6tgiQ0MfntqsPsijxGtfJ+WZ/NgLRBPyZyGmWBIbbdfRtZh3gmxe7cl3mJt4LzRYtfPHbR2KpwET/b6eYbMV5aIL9ulT9ny10UC3x+l1NIVxU0BlTcLT/jP6xcHw8TgxxpHDWUOrsmm+b33cW2f5eIbzJiI+9jtF4tByCJmsuF5hxu+2v2eLOwjqM36y/Eruf15e0u52UWHOelX9qYUTxrQGGmHYFxbYDkNuNA/9lxiKg5pp8J4ZGm2CoSB1TDvS4MKYMU8lXQvLM595tehOxmNs9mMU+t64myMofmjso=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39baa282-cb31-42fc-2c7b-08d59db16de3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:46.6910
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
index 664c90c8e22b..669475300ba8 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -4927,21 +4927,22 @@ static void pretty_print(struct trace_seq *s, void =
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
