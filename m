Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523244294-2-14298164280861500343
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
    1523244294; b=muVgbo2DdoGejt24hxsIRR//PrcCI1J1yi2qcKio/AbI5R3B84
    8pHg8ZCJInxhvhCHN8Bz9XVgK+5Sxdlm/QptD8sK7A1I/Z9m8KlBSAed6o2Fasxh
    ATcAuawYA//ASJlqZ+LcL8L5c1jsXvjuReHfxPbYLmRcMY91SNqVg16T/XbF+jq8
    lZeIZo/DvFtDwnfbkjw6rlyi9abfpIQ15c7gftSi0txkojLFol+LN6PLRgMLjQ8Z
    WZ+jfuFa31QhEDCYzwB8fzwEAt2QxnTqGbYwk5L377IqIcmO52aMolLWimjwqFO8
    pFILAYQYkJMpQCeawxC57JG30CGulkSrC0Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244294; bh=eyMz3f3J3d
    7y/IucDMLKj+xbR9EEzTOZHfR6Nr+qN04=; b=kHUbh2j0LgfIsDVjUpmaZ2Jz0/
    BwcjkCgMuLl0b6GdX4b13V9ALcha4QQBIz3eHbpZC+tz36Y/0ojdxjfyX73Isk08
    TDe4phQv+6wIwIG4apAmLUO89fbM5dQ5+eJo/SWazYoCy0OHW8GQySOM7sK5nwPy
    BShrCXRUlxmhNAULeiFVYfvkR2ipEuA5/sUzeZfaF7MN7wKnKsAqSfonjUHOsqAI
    0gZp8yoYc1BzyS7A7rRiYGQI4CMJjnKCoFwTInrndCVlx+jRqbS8OQeRAOK3CEz8
    2qT2ypi/rPjcrWBHHfFgt+B4B+IR18yhyKJy37lGnwdiQ/FV7BRGoMm8zQuA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=G4UNLxUM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=G4UNLxUM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHKCZ2sLCndoPaAZJCD1iB4Wo741U9ze6s+LI+hK7tvot6BR94PV5QSIUCIM31CssnMxe1J3bi/CUgP+onXoJi4uocnEo15c+WEu/x602h+5AT2YwK1G
    i9xY+eRaukFLNQF0XIKJUAnC7AUYPy68msypYrWpSEx9mfcJJgjX4fz1vewPUCDqxCL1SmdtQoO4VhAth57Q/fn5c6NzSAfrpT+kNrB+6IjWNP6jvzqtMplG
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=yMhMjlubAAAA:8
    a=qzGuX5oTmwzrNtUhZyYA:9 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752279AbeDIDYv (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:24:51 -0400
Received: from mail-sn1nam01on0122.outbound.protection.outlook.com ([104.47.32.122]:20813
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754696AbeDIAWo (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:22:44 -0400
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
Subject: [PATCH AUTOSEL for 4.14 026/161] perf callchain: Fix
 attr.sample_max_stack setting
Thread-Topic: [PATCH AUTOSEL for 4.14 026/161] perf callchain: Fix
 attr.sample_max_stack setting
Thread-Index: AQHTz5iBslZfCXPnjEisBrc21d1Ezw==
Date: Mon, 9 Apr 2018 00:20:03 +0000
Message-ID: <20180409001936.162706-26-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0966;7:XMkK+SVGil6//+dlCbvxGI+rBkhBITLjIxU664qun3Bl412xWwgaWizPVlSr1mQPKlePcv8PPSjPVRXvPSzD/JFzNdrIdNZT48+WNPns4ST4C8sOVY2yhZYk+rwtN927cEMZ1IInN42/MZwwOlCHgIZf4kN8Z9Z354VkrrIW+mMQJCopi16AvEjBYVEr56uXsJKCr+dfyqzpCJX25i2l8FSH0gGxUV/G3iufkC2wNrTr1sFSHEXU8JuERCvSzsJ3;20:JN3m50LWh0fLQmtztorRv70D+TZbGvfg12ImagocI8r7QQqhFAG4SoXrQgjNUaWGwRK9cLq0k9Kt5QNXozxnrpXI6NgkhbDYhQqxTbTa/JgX1dWMF03CMlUW78U0rOOblvm6RC1swVcLUjkzq7Qa/92eoT/9tkQ9itPD7cQV05A=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 987ca6b9-a7b0-4407-ddc7-08d59db001b0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0966;
x-ms-traffictypediagnostic: DM5PR2101MB0966:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0966EB420626D633A7664878FBBF0@DM5PR2101MB0966.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(85827821059158)(42068640409301)(84791874153150)(104084551191319)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0966;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0966;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(39380400002)(396003)(366004)(199004)(189003)(6512007)(316002)(6436002)(186003)(6306002)(6666003)(2900100001)(966005)(8936002)(486006)(6486002)(6506007)(10290500003)(81166006)(22452003)(25786009)(1076002)(81156014)(53936002)(106356001)(10090500001)(5250100002)(39060400002)(107886003)(102836004)(76176011)(8676002)(66066001)(2501003)(446003)(476003)(36756003)(99286004)(575784001)(478600001)(86362001)(72206003)(7416002)(2616005)(68736007)(5660300001)(305945005)(3846002)(6116002)(26005)(86612001)(14454004)(97736004)(3660700001)(4326008)(2906002)(110136005)(54906003)(3280700002)(105586002)(7736002)(11346002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0966;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 1mfxSv7yvTNZVJGTPTZ4Bst65AJon4ABFs7bJJvrDQkZNEHUOyD1FBiYtpxTn2jF8lvnm+dS2pVz1OcPNa24k0OH9CYWDqECIBAq839TlvL+zSkdxsNDdbdKPY14geflMhC/0FK90uWUXdZiJ2TDJEEql3bE+aGIa3O6Hsc4cWpGzaRnivgEDBtuMCunchLXkxpO4a1y9xSRJRmHI33HlDwYUlh2BxVibMJweWg2ZtZ0Jno7F/AU0hEp/sl1Uo+gtuEl8++xBJ88qz4EC6T5SXextriSGmxlt5LNOGiIVsffLzhVgFrqZ5e0CeWPZic77k8NQnAUrRp9UZieZuBzQ5q1qSrRy+jk2eTW9DXjxxK2YyzxYoRR5N35vCfJDRku0Eb2WgWmaGMCyJjO+w+Z4n8LevEX3zLTZLIUIzPeuH8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 987ca6b9-a7b0-4407-ddc7-08d59db001b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:03.4260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0966
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
index 1f6beb3d0c68..4c31a22bbaa0 100644
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
