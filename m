Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523239036-3-5557530252582210599
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523239035; b=svSOIN8348t/3DTVOT046p5jE7llZQtQBr5rxyCPa5dcfb5UaR
    Vz0cWTtPyg6jsIQ7AOE2EXhcJ+bSWYyHAbcXWZFPF0g2vOyufOid3OoenzIWYizf
    F0SIW7YFliEazDvMIOrITyWkqahovjdD4Go8Rf8Wgnte6vk91RsS4J4v+5FGegnb
    NKnFikNSWdnaCKvB7p/bTQBDKuz/uxHlpnffNDONn0/Pw8o0htPcf0hSIi47XdI9
    34cgCKtSnVHmQcQkf+6HGYEe1lpyi8wYhugBHqAO8wVG8QnFcmyMSG+mV8hpMs5z
    m7bnfKjWxsqCCkrXmUHFylRXxbQwmYOFOMvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523239035; bh=IMssmUjYeH
    SjaVq+h4tNc8TaBjIvh/Iu89ytNRyi5Fg=; b=DGq7gsnP3N3tLG0O92EwwIOFfQ
    uzcCR8BBDkdT9N3YlpF29ovOucHmNbPi3xxKwyxCTZ8pJT1Y0RCXJ0QX0ZAHfNsw
    LTeXKlfY/7RgOLysEJXF3ajoRy1D5rRqSX+uArKvMqJkxPJ/LZsj0i6j04eoMexJ
    Y5+L7GlChjo6sJr62znSboZYTAD6Vun6Kdhbwa0/F3LNTKEQKYEeMjhgugfNGYPg
    Qdsl1SGyJmm6aEIPw0hSpJRQzRPy3LNQLnKW6B78059U/q2spt3dMpejK00DNvQs
    lVgktsEvoCjYyJAm9OIPtC22CS3VUYI0kRVv295PbypEvDwLJjcijEbH2COg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dLli/KEm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dLli/KEm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEc6BkJ4GA+BJYh1JWoZefy4VokcCv4bOfSlOo5VzSUpx/l94lH9Yk/aqW9odltPBJxpr+lqprDEpUVHZTq4T5OAEHIJe219teyfL7IGSrj2cOA1qvBO
    Uk44L3hAOkjoIYAb19fUMXFSo24wvPC0993QkDt2YT6cafqud3hkVN9R3N3BNmbC82ZF9cgC9NIeCfF33Qr/bVKyAdryeSSMEXnuUyLzDIiZ6Vg0yeZJs+dm
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=yMhMjlubAAAA:8
    a=qzGuX5oTmwzrNtUhZyYA:9 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932765AbeDIB4a (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:56:30 -0400
Received: from mail-by2nam01on0100.outbound.protection.outlook.com ([104.47.34.100]:61248
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932166AbeDIAc4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:32:56 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>,
        Hendrick Brueckner <brueckner@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Wang Nan <wangnan0@huawei.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 222/293] perf callchain: Fix
 attr.sample_max_stack setting
Thread-Topic: [PATCH AUTOSEL for 4.9 222/293] perf callchain: Fix
 attr.sample_max_stack setting
Thread-Index: AQHTz5lOyYQ9akMXqEukLvfH4IETJQ==
Date: Mon, 9 Apr 2018 00:25:47 +0000
Message-ID: <20180409002239.163177-222-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0998;7:Lq+qt7/JMsaRzhDYSjCslLDhiLdSMElxp5OVFz5AkytWQY3qOGUCBpI0LHu5nwc9qwbmz5EBHysuQ4NK0d2LrJ/OCUkC4BojmblJNKClbwHuTxqGBo0lgHZoNrw36AFa/uWdDMwCpXF+lBokiWHVBpJTrTffd6eKhxuFEh6HIwncecfTvlygc2oV+Wjj2JWaxKp/1YfaD9fCHFQW9m+7WL8i3tkn7yWFKOzc56KCjNx9xGS+tnRHw4Y4JqBQOgw8;20:VK791p1DNYoi6YgZY9YmJ6PawARVLFHk37yaJesXpycPJpgFda1msyPaOcoVk44Y6T0qevFCq1YLnDhtleUObIe6ZmZ4FhLDr3JA1dXGNzWSCDbgnD85msr/KgY+QpRE1+DWLkOrBA0mls1bMU5+w+4ZqlQnVsoTSycKxiFLiOc=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: a6e74057-c0a0-4850-3a05-08d59db16e72
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0998;
x-ms-traffictypediagnostic: DM5PR2101MB0998:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0998CED04569BDE199728E52FBBF0@DM5PR2101MB0998.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(85827821059158)(42068640409301)(84791874153150)(104084551191319)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0998;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0998;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(376002)(396003)(366004)(39860400002)(189003)(199004)(25786009)(105586002)(14454004)(76176011)(68736007)(2906002)(316002)(97736004)(8676002)(966005)(39060400002)(86612001)(3660700001)(3280700002)(102836004)(6116002)(4326008)(8936002)(36756003)(22452003)(81166006)(81156014)(54906003)(6506007)(10090500001)(2501003)(6512007)(186003)(6666003)(3846002)(486006)(5660300001)(6306002)(26005)(7736002)(5250100002)(305945005)(99286004)(2900100001)(110136005)(7416002)(1076002)(6436002)(53936002)(106356001)(575784001)(107886003)(72206003)(86362001)(476003)(446003)(66066001)(11346002)(478600001)(10290500003)(2616005)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0998;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 8lidKBULycVSfIzAJWKarQk+6XLyfqLEZpz0l7wHrqYOBK5i8YDDOmBPuyEUWvDlK6P2udnRuAiOpWwC15Ebh+crf7IUzjGyIRi0FcngK49Mpabu2D32lIqsHwmTWGt5WC6Lpp6NTMYFQb7rL1D72NIfAQBNHrs1ZXtjbVNycDIxk1l/ZLsAMO3nZLlkIzGZpox0BzdeEghfPMLPOy3k2bK1AYnqPEMK8AmZ5a8UoB/32TAhssJ7T66bqABLYD4MUd7Kh3i1zcOGYHkBl4JOb4EAtxVL/bXH1t0hL+emtH8ULjHlAP9jS2bJqlR8rUofWX7L9owKLqnhyxooo+Na5aUxzyeNNsKjQSot7Q2T10bvjx6QJj3jB/cpc17u02x9v40jOQBXgVNtjLRRXOAmmPTSZTlDy0kU4u9erf5Z8Gc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e74057-c0a0-4850-3a05-08d59db16e72
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:47.6441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0998
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Arnaldo Carvalho de Melo <acme@redhat.com>

[ Upstream commit 249d98e567e25dd03e015e2d31e1b7b9648f34df ]

When setting the "dwarf" unwinder for a specific event and not
specifying the max-stack, the attr.sample_max_stack ended up using an
uninitialized callchain_param.max_stack, fix it by using designated
initializers for that callchain_param variable, zeroing all non
explicitely initialized struct members.

Here is what happened:

  # perf trace -vv --no-syscalls --max-stack 4 -e probe_libc:inet_pton/call=
-graph=3Ddwarf/ ping -6 -c 1 ::1
  callchain: type DWARF
  callchain: stack dump size 8192
  perf_event_attr:
    type                             2
    size                             112
    config                           0x730
    { sample_period, sample_freq }   1
    sample_type                      IP|TID|TIME|ADDR|CALLCHAIN|CPU|PERIOD|=
RAW|REGS_USER|STACK_USER|DATA_SRC
    exclude_callchain_user           1
    { wakeup_events, wakeup_watermark } 1
    sample_regs_user                 0xff0fff
    sample_stack_user                8192
    sample_max_stack                 50656
  sys_perf_event_open failed, error -75
  Value too large for defined data type
  # perf trace -vv --no-syscalls --max-stack 4 -e probe_libc:inet_pton/call=
-graph=3Ddwarf/ ping -6 -c 1 ::1
  callchain: type DWARF
  callchain: stack dump size 8192
  perf_event_attr:
    type                             2
    size                             112
    config                           0x730
    sample_type                      IP|TID|TIME|ADDR|CALLCHAIN|CPU|PERIOD|=
RAW|REGS_USER|STACK_USER|DATA_SRC
    exclude_callchain_user           1
    sample_regs_user                 0xff0fff
    sample_stack_user                8192
    sample_max_stack                 30448
  sys_perf_event_open failed, error -75
  Value too large for defined data type
  #

Now the attr.sample_max_stack is set to zero and the above works as
expected:

  # perf trace --no-syscalls --max-stack 4 -e probe_libc:inet_pton/call-gra=
ph=3Ddwarf/ ping -6 -c 1 ::1
  PING ::1(::1) 56 data bytes
  64 bytes from ::1: icmp_seq=3D1 ttl=3D64 time=3D0.072 ms

  --- ::1 ping statistics ---
  1 packets transmitted, 1 received, 0% packet loss, time 0ms
  rtt min/avg/max/mdev =3D 0.072/0.072/0.072/0.000 ms
       0.000 probe_libc:inet_pton:(7feb7a998350))
                                         __inet_pton (inlined)
                                         gaih_inet.constprop.7 (/usr/lib64/=
libc-2.26.so)
                                         __GI_getaddrinfo (inlined)
                                         [0xffffaa39b6108f3f] (/usr/bin/pin=
g)
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Hendrick Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-is9tramondqa9jlxxsgcm9iz@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/util/evsel.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 1c1291afd6a6..4b52c76fb2a8 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -694,14 +694,14 @@ static void apply_config_terms(struct perf_evsel *evs=
el,
 	struct perf_evsel_config_term *term;
 	struct list_head *config_terms =3D &evsel->config_terms;
 	struct perf_event_attr *attr =3D &evsel->attr;
-	struct callchain_param param;
+	/* callgraph default */
+	struct callchain_param param =3D {
+		.record_mode =3D callchain_param.record_mode,
+	};
 	u32 dump_size =3D 0;
 	int max_stack =3D 0;
 	const char *callgraph_buf =3D NULL;
=20
-	/* callgraph default */
-	param.record_mode =3D callchain_param.record_mode;
-
 	list_for_each_entry(term, config_terms, list) {
 		switch (term->type) {
 		case PERF_EVSEL__CONFIG_TERM_PERIOD:
--=20
2.15.1
