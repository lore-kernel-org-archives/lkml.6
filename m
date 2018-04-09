Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523236593-2-9505817637416124175
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
    1523236592; b=IhbZ4WmtFj+A9BaEZbYnCx+SBvrNmOsymxzSWFhKBceKrUPcHT
    AfZRtn1nE+nU58O798Q+wQYm+XXUyJ6W8O3hRXv7gqI5R9NsM3RNWhx5RjE0DgGn
    mlohMpVqzvMQ9cibn5xE2yuajY4XVN7gwceKWqA0cckjvuCZPjDy9LSQk5qvetAJ
    G0mYLEyAzS13C3YKqv6c1QQisct0Sj+bBnNmbB5AQ7WKIoJJ9+FsruHasPbPQMMQ
    QIx6s0zYpVH5tRM72Hl0iG7jBpDfBu7y7bdjinaVkcdWPFA3LlsishFzm+9pkXj7
    /FcKqdk5d+3XSpUp77IVW0SqV+OlUQqtj+3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236592; bh=AMwvpkC0u8
    L7GAlnZJOZICdOz6zpObtg5xI0nVtNI8Q=; b=WHRU2RHspfL3M23sIdj5ye9T7Y
    uL+80BzvAXHaRkTJpuBUzcrsogCC+c8f1ijg+LB9FcgJdBipybMr2xLjcgZcH7MP
    NY61wHK44X3bnjJQsiYucAUWNdOKVMNc3e7Ms3CBKIh0/iuLLU13hJ492bofnSo+
    qsN3Zl/NqnvEp7tvcbggwaC9wDLnqD33sEh/n57/n/XL18lz5CgRnuhyZgUpIWom
    G6PtEuSQb9tUv5+jcWApMRtMjAUXGaH/ZKShRpZBZLY6dRlpSiCQRshUY2Z4d5lL
    6iMuVXS7lts1HfDLvRelYZ8W2vnieiIFYPbRSBSPbpk/kv+/d7ReI7JtgnKQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=S2Ki0t10 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=S2Ki0t10 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD3nFeoz8WSdGQu+cCkwZAJssoe39KSdY4MhvSO3Rd41WbCLiaTbh0T81boxwoq3Xf2Kx48yviiXCJ6Nmzm1nEbMTNtAwEphqSic2gVmc06RStH66zD6
    7COUazj+cokSVcdWHpTTFzKrAftEC4sL0AQLuPRf+bMlXHtIJJ8Y8M1TeAwxoDU6nTxOAlPmW3HxA8SDTvrbVB+lZctPch61zoOMINhWrbowTG4+HwfQq5CM
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=AxAqW-uwn50A:10 a=wRwT6uffUbIA:10
    a=t_PdEiP4ckcA:10 a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10
    a=Kd1tUaAdevIA:10 a=Lf-vpJhqX20A:10 a=meVymXHHAAAA:8 a=VwQbUJbxAAAA:8
    a=Z4Rwk6OoAAAA:8 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8 a=xQp5KPISSQHezL6feeIA:9
    a=wPNLvfGTeEIA:10 a=2JgSa4NbpEOStq-L5dxp:22 a=AjGcO6oz07-iQ99wixmX:22
    a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932262AbeDIBPm (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:15:42 -0400
Received: from mail-by2nam01on0100.outbound.protection.outlook.com ([104.47.34.100]:3232
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932823AbeDIAhy (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:37:54 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 112/162] tools lib traceevent: Simplify
 pointer print logic and fix %pF
Thread-Topic: [PATCH AUTOSEL for 4.4 112/162] tools lib traceevent: Simplify
 pointer print logic and fix %pF
Thread-Index: AQHTz5nHZgGGqO+uMkW6Ra/UzTVVZg==
Date: Mon, 9 Apr 2018 00:29:10 +0000
Message-ID: <20180409002738.163941-112-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1110;7:gK1jrXy7ZiSLh0YWABLvFlGLgzurtlo1J/PENZlviOTMfyiiCXCqxfE1za75jtzANB24OSiFB+3mwvfuz5Od0Q6niMIZE/sQGhUZnUI+K0+VrEiLa5N6JlCjSL5HOtT5BFURN1NRR94PdJkK+wPI04YmwVK6WQBBIgdWGOArmY9J+H64/gd6K15B4/ILmzAp01Xsmiq+o+HL15RdN/zb7DQb5jbul2q/ZqVN6hejgGtaNeduxJxknQ4ehll3Eelh;20:MpuAVq785qe5YDwkyDalQRC+Mr/TbPZ19xBbt6HSByqKT4DDfKgz6jOaALvn3UofIog3810T6gDriJ/Zmx5YZz3alkcia+AbWbhCSXU152U4tvd5U/kseJDMSuSZwGd+YWrn0Z6lIcXHZ1TGgjsiJdxfYvGAnipSY7yQtHm0c0E=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 64b60e62-d6cd-4f54-f9da-08d59db21fa9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1110;
x-ms-traffictypediagnostic: DM5PR2101MB1110:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB111060B5F584E03DC3EF320FFBBF0@DM5PR2101MB1110.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1110;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1110;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(346002)(396003)(376002)(366004)(199004)(189003)(53936002)(6306002)(186003)(5250100002)(105586002)(966005)(11346002)(99286004)(476003)(66066001)(6512007)(86362001)(575784001)(3660700001)(1076002)(54906003)(68736007)(110136005)(3280700002)(316002)(305945005)(4326008)(107886003)(22452003)(14454004)(7736002)(446003)(6666003)(2501003)(10290500003)(3846002)(6116002)(72206003)(106356001)(25786009)(6486002)(6436002)(8936002)(478600001)(5660300001)(86612001)(8676002)(81156014)(2906002)(102836004)(81166006)(6506007)(2900100001)(76176011)(2616005)(486006)(26005)(36756003)(10090500001)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1110;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 7ULAVb/25f8CBkp9zhWPHm6WbBeCbDnIe8oyzb3q0s1K1nNWqoMN5CANhpjIiD1afhBwvyt5ej8irtAr3EputcGF/tJOR6+Q9QawTqEJ/iK6E1/WKMqIcZ1qDCvk+MOnqjHoftSCxjXM4t/N01jq19m5HqZB/kC4uVlJGMKVA1Yci1txxlGko7hFJVdKduwTWx7dB7wgFkCb6dKt25Oqg0dXQP4xEgz9JOAJ6LQ5iMr2MCsSry57x0gMDRZR3LIiyamRd/hV+Y79wqtW/x6aakfOI8RVvbuInbXG1GFq5p3ZrxUmTNRUSxSr/ocpXg/wF7zDHKKh+fiNwBGuNN4S/FWWgnwebBcG47ayndDyVM8Scc1hXyf5emSfM5+7JV+KQSDOiWFuDEWTP8S9BAvs138Jjwmf9atdYFKozW7hEHI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64b60e62-d6cd-4f54-f9da-08d59db21fa9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:10.8961
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
index 68276f35e323..6e4a10fe9dd0 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -4905,21 +4905,22 @@ static void pretty_print(struct trace_seq *s, void =
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
