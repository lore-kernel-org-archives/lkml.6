Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4147991-1523246907-2-1077600077172287844
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enrosv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523246906; b=kNDmKQqkMFYGGrPtO+cnvoj9wjUKRw4D7tDZqPLDmmPAEh1yth
    kU/Frf2CWyW+Y3p/QnzbTv+596vJxLCd21FXw3P6eDUT8ig7XFGwUbS7X2YvYXKf
    j4FWXAEjHi2rg/VG1YpbWIigIMAWV8a3yAhQThV8zWDC36+YedAal8Er1kkZzgNz
    Po3ylEUge5532Q1TGESJs+et2AQF0AqtQM7afc0Ltf34X/CMcJk0ojyYCy/Bci2D
    5QVaZvdcji9utyJATx1XcFH1cugJJCOl/N+SyYU9Jo8YmMIECkxTSKltA9AqFamO
    1k+DCwq5oUzg4xGIRYABaXm1XdqigaTtC+dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246906; bh=XH7psHMVzF
    egc6P8d73ZzHHn4NIlSHUArYLyAFAYpyA=; b=HG20+e0CykZ6QNGd7erGsgTvaz
    kP3NlXEm880wQyZC5M4+PQpCNC+3UXNdj4/zS3CMLRWx55FmCFmO7oVNGbr/rVE/
    y7TuGkZ67KW24tAXzAOJY6606OLLOG7JFDYUFhURpTY4FoXF2JnLo0Q3QyyqBrLj
    d1kfsMqPifruk3RmUE4NZPD1iIRUjG27+OYF0z8bXJddELUcXmeVVseqfjz1Ttm5
    W0ZI7flBlvl/4gkrVq2o/MdQgF/a9cBE92wa+ftLZt4NjyaXKFEJ0FPzfXsaIO74
    e3Woxr3eWAUCJmnxSfbcMtc+cyuXatuCTs6zVYqA4aNqI2hvPMkmT+YtcWDA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TYtS0PHY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TYtS0PHY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfA5N1GKB33szFtUukuf5a7jRh76a0E3j+9DGn+FAt1gt8YghaPuT0Yb/xmeUHSndAzYnAlU0UxSVHwZ2wiBvC812suT57hwR6xNlkFQ6sfyTQ9yVMYbA
    nRlNH0Q9N8E27qNFowA98oDM+vvYHNC2ElsY4wvrDdW1h8oLs3LpUtvujKy058HifvEoFd0PyvYqkLsuHERyAWF5jeDBCmT9Rq1l8/JlLBcvQxzko4DafgCm
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=yMhMjlubAAAA:8
    a=qzGuX5oTmwzrNtUhZyYA:9 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753450AbeDIEIJ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 00:08:09 -0400
Received: from mail-co1nam03on0128.outbound.protection.outlook.com ([104.47.40.128]:49080
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753101AbeDIARQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:17:16 -0400
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
Subject: [PATCH AUTOSEL for 4.15 030/189] perf callchain: Fix
 attr.sample_max_stack setting
Thread-Topic: [PATCH AUTOSEL for 4.15 030/189] perf callchain: Fix
 attr.sample_max_stack setting
Thread-Index: AQHTz5gZnAPabOG5pkyhNynPOZz8RQ==
Date: Mon, 9 Apr 2018 00:17:10 +0000
Message-ID: <20180409001637.162453-30-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1127;7:aY6yhG3dYo7wfzgXhlZKkKpZCG8V/EdIRU3IOs3UXeRgfONL9KNIVyvHiVuiX/aUe0AF0oSBBx/l5+8Gs7eIWUl3OpQAlrOG5w7NzxDbkec+XP1MqtyAFbgQcuIkzQ2EO6OP+nmUY8LO/75ZL/jIsq36o216uVl+p5LFzFHb7D5X73lR9/yS6e0kEUD87lRDxmEUDqG/5hM0MdvCUgcHdIZG3U4RlWisC76ymIguKffrpHOilBWgAA+oDMs8Pn34;20:hkDoy3YWoXSzQsOWJB1gYOoYhgdSyxCs9sRtgf3+3CO8RQ3EUZU4xDrGdqd9gzLwf3y2NopHK/Lyh42kl1HOHm00zkjRQm7r0KWIZNOV4qE6vlKTEu74z3o/IXHyL71aJPnT7Bm5+lIjcmx8OA5byrHyUespQW0iG7Aa2cO1VTY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 68e807b9-c901-46fc-0e63-08d59daf3c7d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1127;
x-ms-traffictypediagnostic: DM5PR2101MB1127:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB112704BC52567A3439AA6B48FBBF0@DM5PR2101MB1127.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(85827821059158)(42068640409301)(84791874153150)(104084551191319)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1127;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1127;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(1496009)(396003)(39380400002)(39860400002)(376002)(346002)(366004)(189003)(199004)(105586002)(186003)(7416002)(66066001)(6486002)(54906003)(7736002)(26005)(575784001)(86362001)(316002)(305945005)(110136005)(478600001)(3280700002)(86612001)(10290500003)(25786009)(5250100002)(2616005)(99286004)(22452003)(5660300001)(966005)(3660700001)(2900100001)(81166006)(3846002)(2906002)(106356001)(6506007)(107886003)(486006)(39060400002)(8676002)(81156014)(14454004)(10090500001)(68736007)(4326008)(6116002)(1076002)(72206003)(102836004)(6306002)(97736004)(11346002)(8936002)(476003)(2501003)(6436002)(6512007)(446003)(76176011)(36756003)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1127;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: vVJ/v5ris4SNNNGA7L/6MfhecbPAVx4Q7/G12UJJcjP5gxE3qp0Jz+X4QB2Bxhc/DMpWkkg5w5Pw/iGWzvNJXKe/ZWAGvd2ajiQsNM2VXWq5MoCX3M2Iw9Zso2TLyHUZ2IIw16i5b0rK1wzkqj/WqkHqz5q6sJKWBEz4ySvlLgmT/YyBIhpq0EWWp6m038+xyJN9OJ8QKlp+cma+9tftn4Bho7ddBNYKQo3fKqfFCajaaANa0sV5ZHsNcdHCNYj4zdDm0Ax369b1IB8PvrIMOgzWyFXCEPlkVvHvFFIbQDRiTZpF5nkt9SWyVsJfjd+qujEJ0QBU9IxMFF2ZCeqMhgqYg7Jg8d9X4ggi4HPoYIUGcEYFPdIyc/H5AXjWtZYIphE5gX5xrvHqfxszOgtVfJrCJS1i0z0pM2cCRFV5bBQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e807b9-c901-46fc-0e63-08d59daf3c7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:10.1209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1127
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
index d5fbcf8c7aa7..784d852c91cc 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -722,14 +722,14 @@ static void apply_config_terms(struct perf_evsel *evs=
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
