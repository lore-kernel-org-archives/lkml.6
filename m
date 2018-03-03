Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520121608-2-16655673561228650852
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520121607; b=gIZ3TKkXFHuTa/guG3sebFZYs5dTXCSiZq+CQq4e4zoXpVY
    hKixv4ONcR14z8rVea4O3YYa+M1U6+wNNJvS5iN7+QxreQk3D3COjPtbI4ML9QQ7
    hYH0QY2DKykBleLPKUFpVH950uSXn1iBn6DNFdDcnpeY5Mxuof65jOgzWDxP5R2m
    3W1XUZym8eIbem8TW+aIOWC3yMzwvZkh0RcFr3hXl7I0buPsKC9n6ZKmEOi+n2V/
    ea8Oh2PyWeNaI0DitMip+gsVSleJon57zRJckQI9Bqm2wdgJbsIPwnTTrGWc0c2m
    CnVoFeuxHDp/267XUmVj76tKTjESLntGctvH3Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121607; bh=JVW6zc
    sWthnJSEL8cYj/qT6hTe78df6XzX/CgG2C9Tw=; b=v2bU0MEK1mg0mAgJkfflaY
    VWivCafppE0tEZde2BkNmvzf+qf6H27PTxbkzP50kiLn245BVP1lk8T+hZfjC9kw
    QNkQnsGDROlRG5uG6EL+IFv8L9lUWD8Wygd2k9jhot6i8g3yK1GJGIJMmFHx68ra
    wLX0RJMS4JBnEBi9fHez/CoCETiOUkZ6tHUegrt5yumRO2Jj7eTkaqDjesvIThF+
    OU5TalCi+DMWxLchh7xwPX4esjeKB9VMnZpTi5RHrEstYLyBwSO44yjPLuhx/7/h
    +yKlbq+ozNTyufg+b3a1QQj5C4WslIYVRRIeTcWNfSHvW3b6Yq2Qk5LSa1gFmycw
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IS7Qz/Nm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IS7Qz/Nm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752531AbeCCX7z (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:59:55 -0500
Received: from mail-co1nam03on0109.outbound.protection.outlook.com ([104.47.40.109]:6764
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932796AbeCCWcJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:32:09 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 043/219] perf probe: Fix
 concat_probe_trace_events
Thread-Topic: [PATCH AUTOSEL for 4.9 043/219] perf probe: Fix
 concat_probe_trace_events
Thread-Index: AQHTsz7vSvLCZ/yFoUCC8pvj5ZD8ZA==
Date: Sat, 3 Mar 2018 22:28:20 +0000
Message-ID: <20180303222716.26640-43-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1083;7:qSOBZIfSO0ju7mBDkgooJqzyYKqdlTaP3rcA6sAwpjtUWLm2YeQ1ZHy2IpC9Zu5mtZQKDNzeIk05Jo2HXPpgJWVAXOavr3/qlUh06E1YJZpGXaNyBywo09uDXAHBqJkFy5bUx/PYw5h4wTUGtEmdelbuotBsQ9uXRPF5B90ywx1Uh7Qq3qNGSOLl7AxevAshHmh4tCBjvEjCGbFWIFN7d0Y2QtDL61uOt7dTPEZceXwwWbLuonMXAbIiVz1jyYCm
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 588e4500-0537-4df7-848c-08d581569668
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1083;
x-ms-traffictypediagnostic: MW2PR2101MB1083:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10839CC9D945FA9915398EA8FBC40@MW2PR2101MB1083.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(131327999870524)(42068640409301)(104084551191319)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1083;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1083;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(39380400002)(396003)(346002)(366004)(189003)(199004)(106356001)(53936002)(316002)(305945005)(7736002)(3280700002)(107886003)(2906002)(6512007)(6436002)(97736004)(3660700001)(6306002)(6486002)(99286004)(81166006)(8936002)(81156014)(76176011)(8676002)(25786009)(2950100002)(6506007)(4326008)(110136005)(5250100002)(54906003)(36756003)(575784001)(105586002)(6116002)(6666003)(22452003)(86612001)(10090500001)(186003)(68736007)(26005)(2900100001)(86362001)(66066001)(102836004)(3846002)(14454004)(478600001)(72206003)(10290500003)(5660300001)(59450400001)(1076002)(966005)(2501003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1083;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 8dSoSUcZnhUFWP4Yrszwxabp7lqhKpdOWVy7SAEUayqF3YYYAPbzkLRNzYllPGy3VKpMV04lYX37eqfrm3Gmy+5vgbyEwHGZifxiLVST1Jkcy4sqd41ypZ2+A5ikOtGdP68wrwG5TF2ISgE97fUAOVKKDF6AvjHxBcj6WZqC2Ak=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 588e4500-0537-4df7-848c-08d581569668
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:20.9006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1083
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>

[ Upstream commit f0a30dca5f84fe8048271799b56677ac2279de66 ]

'*ntevs' contains number of elements present in 'tevs' array. If there
are no elements in array, 'tevs2' can be directly assigned to 'tevs'
without allocating more space. So the condition should be  '*ntevs =3D=3D 0=
'
not  'ntevs =3D=3D 0'.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: 42bba263eb58 ("perf probe: Allow wildcard for cached events")
Link: http://lkml.kernel.org/r/20170308065908.4128-1-ravi.bangoria@linux.vn=
et.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/util/probe-event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 6a6f44dd594b..4d2e22f8bd94 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -3060,7 +3060,7 @@ concat_probe_trace_events(struct probe_trace_event **=
tevs, int *ntevs,
 	struct probe_trace_event *new_tevs;
 	int ret =3D 0;
=20
-	if (ntevs =3D=3D 0) {
+	if (*ntevs =3D=3D 0) {
 		*tevs =3D *tevs2;
 		*ntevs =3D ntevs2;
 		*tevs2 =3D NULL;
--=20
2.14.1
