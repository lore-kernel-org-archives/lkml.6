Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523239179-5-16261855151957697853
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523239178; b=u4P8atF8MYgNSWEkT6whtETxr/B0yWoimt2oLq2eJYPGVVodPz
    1TzvCk3qZlv/2HkY3lHN+Lx4PUqOpYWpdBRVNvM9JsHAXpa/xDo4yVlLPZSKIPA/
    yYqppDcYTqn2TaCc+X1pwi47iny3cnuvGx+mmoqgcXfWNDoj3DsG7mqA1+c+7hA4
    M0tZBhgo07EqOpBsWzpF8LfB93/F0fypk0YagXht/9eoaS5OzoQa5VaYdu2ZP6p6
    87W1ezhXEuqRc3YAwt7+pgSFvBqwNQ1/w3hLTybgDp+sy1FwQ1YWDF1TYxfnWVRJ
    puV/EzrHZAcaQgtw6WgynLB4Mkyxj+citjcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523239178; bh=76ClGiYnYy
    Xbn2QmKN6KV0ZyforSs1CFkSDiIuluyP4=; b=WfWnlWRVTIAsmnl2xLIGEv3IWY
    Ko+8Ljkmg8etFswRRE3M/3ogKElT53KmYdESRjnNHI4NJRT3z1P3QmX/lqGthUHe
    94yWczy0F8MbKA28/BsUHraeigQ8QGyKsXF1M/ZtFNvAoz7gtHwDpGQy7c8wNl+u
    R3dANym/tECzF2RPuHG9i3+MIoWW/cDKs4lNeqWL2YWBO9+eTpo+FfPc1yBQGRJr
    heQikwpPcaqdj88ih7m1lLzxf0WKmsq61fBTwVC7rgz+mLa1XhMawDsB6beOud4H
    /p8wn8G4e1fMNeK8TVjWXCAmRPWJglVjlZd8vnZ9AVC0/OYAS1PWFYKA2Fkg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oxbWKwmR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oxbWKwmR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ398dXqDgVD5tcFb9A8O6SIOPVpoCAskHtJP/zidGuZ2baodvzY0QzZqXFZHIbk8s46+kIOTOyjezXqp3/lgM5og0Lkvtqi4dMrOQTzqAmg2ADalIcE
    mZ1dTceumhmoNcSqXFi8pdXYrqRn36HUK5aJOdg2mas4cgDYQ6tI9SX/ikcMx7vUusu39sj6hYU5klDZw7Z9DhwdbVQRA0PZnKsR2c01sBoMhss7BSyhUUaF
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8
    a=pGLkceISAAAA:8 a=i0EeH86SAAAA:8 a=yMhMjlubAAAA:8 a=DyacyPj45CTjLpzs6Y4A:9
    a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757524AbeDIB7b (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:59:31 -0400
Received: from mail-sn1nam01on0103.outbound.protection.outlook.com ([104.47.32.103]:45281
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756483AbeDIAcR (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:32:17 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 207/293] perf evsel: Set attr.exclude_kernel
 when probing max attr.precise_ip
Thread-Topic: [PATCH AUTOSEL for 4.9 207/293] perf evsel: Set
 attr.exclude_kernel when probing max attr.precise_ip
Thread-Index: AQHTz5lHY9sln8VNC0uUfuUwfkHTBg==
Date: Mon, 9 Apr 2018 00:25:35 +0000
Message-ID: <20180409002239.163177-207-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0870;7:Kq3b9OLQxRVMzwV+UQYDPfWBFenI18RB2Nxzgc5JIa0bVh25q623St98RPm1YzY0WGS826H6V9EwD6bjU0wTnE0IgWNR/qCSoRBgUrY8oVYv2HfA5EiHluPmvlhcq8KYQohJCE0IrXq3Z7hNNQAgxC2N+h+fMsKDsa4VA20iTVk0m9fyJYF5TrYydfAk+sSfGC6h3p0cO2YSdAdZnaVs/1HjJ5pYFr6WiMNW6OOrcAwQcRZtuauN2Ft1iRyifwVp;20:iOtNc2XmWP9YKxDxQk7zxCsY3OdM3jsOPcrdS740EQnDnhOEO5BBfCfkCMYFb6udvX5kVaKRIAZ4Q6kYk8cl8VdblUbG0i3ekp4TLcB3dFI6/U3k0rEBxJQiqmsgLaG2Cbg1+pQvKux8rPU9dEKV0ugn/GropnnZddcx7uI3v8I=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: b5009054-2951-4a2d-a066-08d59db15570
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0870;
x-ms-traffictypediagnostic: DM5PR2101MB0870:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08703D7F4413B91B63B5FD5FFBBF0@DM5PR2101MB0870.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(85827821059158)(42068640409301)(84791874153150)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0870;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0870;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(396003)(39380400002)(376002)(199004)(189003)(53936002)(2906002)(6512007)(6306002)(102836004)(2616005)(76176011)(14454004)(446003)(10090500001)(11346002)(476003)(39060400002)(486006)(107886003)(2900100001)(97736004)(966005)(66066001)(6506007)(6436002)(106356001)(99286004)(105586002)(3660700001)(6116002)(86612001)(3280700002)(6666003)(2501003)(10290500003)(26005)(8676002)(8936002)(478600001)(68736007)(5250100002)(5660300001)(316002)(4326008)(72206003)(186003)(110136005)(6486002)(7736002)(25786009)(3846002)(86362001)(36756003)(22452003)(81156014)(81166006)(575784001)(305945005)(54906003)(1076002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0870;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 7hocWithlndeQqaJ2TSYCTAZRBp7yptd1bnKnqc0n879aqJPqgYx/7JmgbwrTjoAguFqmGtiUiKNXyspOeju1sVf/yRVMOJLWpLVh5IyI32HH6DhxkJFTfxy0Wj0I+y6IGkharOHWMxZK2SOLgDdjagBbxRPjw+vfLvv08CQgsmyWnbgyzrLzX5XI/JAV321RowYHa3OIMnwG23wWBNCOrjYROnZ3x6+7PlKFYLz/5faQZqLWuo/9Pw2Y2sWWvy/pWZoeqqyv7RfJRcndTLqBIPQI5anxgGFQ7KGyqpyM6ZcBqA7c+Zpn4GMgmt1Og56uyQQB45f20JMae1040vB8eKjpX1p2L2/axBEspEE71GJsLSfhBwBtq6yGOJTLLb+WC4b/kbk3eZk+nBU4NySqrIuH9Ifsyr9aQevw7MMS7c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5009054-2951-4a2d-a066-08d59db15570
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:35.6596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0870
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Arnaldo Carvalho de Melo <acme@redhat.com>

[ Upstream commit 97365e81366f5ca16a9ce66cff4dd4c5b0d9f4db ]

We should set attr.exclude_kernel when probing for attr.precise_ip
level, otherwise !CAP_SYS_ADMIN users will not default to skidless
samples in capable hardware.

The increase in the paranoid level in commit 0161028b7c8a ("perf/core:
Change the default paranoia level to 2") broke this, fix it by excluding
kernel samples when probing.

Before:

  $ perf record usleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.018 MB perf.data (6 samples) ]
  $ perf evlist -v
  cycles:u: sample_freq: 4000, sample_type: IP|TID|TIME|PERIOD, exclude_ker=
nel: 1

After:

  $ perf record usleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.018 MB perf.data (8 samples) ]
  $ perf evlist -v
  cycles:ppp: sample_freq: 4000, sample_type: IP|TID|TIME|PERIOD, exclude_k=
ernel: 1, precise_ip: 3
                                                                           =
          ^^^^^^^^^^^^^
                                                                           =
          ^^^^^^^^^^^^^
                                                                           =
          ^^^^^^^^^^^^^
  $

To further clarify: we always set .exclude_kernel when non !CAP_SYS_ADMIN
users profile, its just on the attr.precise_ip probing that we weren't doin=
g
so, fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: 7f8d1ade1b19 ("perf tools: By default use the most precise "cycles" =
hw counter available")
Link: http://lkml.kernel.org/n/tip-t2qttwhbnua62o5gt75cueml@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/util/evsel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 97fe0c80ff02..1c1291afd6a6 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -258,6 +258,7 @@ struct perf_evsel *perf_evsel__new_cycles(void)
 	struct perf_event_attr attr =3D {
 		.type	=3D PERF_TYPE_HARDWARE,
 		.config	=3D PERF_COUNT_HW_CPU_CYCLES,
+		.exclude_kernel	=3D 1,
 	};
 	struct perf_evsel *evsel;
=20
--=20
2.15.1
