Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523242679-2-11975306943019221437
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523242679; b=VnnGVeTlQbtmXBoQckv55tKUDH8jswaKjEhKfvWSYo36HZiTSQ
    F7i7boOuDuLA1VJ8voFkwJ6FHimOqcgGXCy7E8Gxb7OheQcmvXkmpwTz449mLd5R
    WZqXQNylso5MKWTPxK6LP8hHNpwY0xCDSZz/HvYVxZsGzmAGk20WXj4Xew7j5wB0
    ClT0wgphnsR5/9mIj9Oe5S2LBiR5IPNdsRjOVLOxJ/P9Tr56SUnIUhzEwcbwNmv9
    7rcgAzIeyny9UPbD8GQXx7eGjNWsf7ZkKS+z3zHxB88MD9xxqFu9ZhpG3X5uFUCf
    e+urLYpOwNQr3LkRTlsxJ1F+YQUqw5v4EdRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523242679; bh=fGTiL8jciK
    Ad5m6laOcfAG1nBmngSbu8HbHSA6WhUKY=; b=KgQbU/ko+ZFpL6C0rS2QOiO3lp
    jaL0NwdjwSk0XW551OZpKjnGF+WgYjeMNSpt+LNHF/I8mM1vZbSzRTn2G2//ntJx
    FCNxPXDxt1DF9insMdPaRCtpx+I2s/dfy1i76DLwO69NUi6ypAvhLbufm1YtGusV
    dT+x4P1pnMVUm4DGctkc6ZWWYPCNZPfsaxY9+LnJoMAt/atrf/ElkqWQ+haB2l1E
    WaiSPb6xzBd3YQSVmkF+1JmnwQlTfCgSd/37UnSlPxpCN9IBw/Y2zbUAU7T8zwB1
    6yTxzalU2BiEZsCkjAIbYUH1lWLtmX3MjirpaiOsrKIP3CSdPfAyTJbPqjXw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Iwn2iP3j x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Iwn2iP3j x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGmC7QmF40MEBfTO8ysTU1CpacemVg1Ed7PfGvznN0IQTEai7deEalKscL1GVtTysWxU8m1se0ImRLdH0KwwvRupam/xA4MTk1brc8ObCHzspiD+xn83
    RsZ1dRIfeBr7yYrc7lgl+PG5zYNL2l47chnJcItNCI6mm362NCW2X8ledNhmZHzpa3Kgm8PQDDG5uigKOaUvjiNqj+hbqzff66V/7WyBkjuNLhqu2Hh1MiQh
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=QyXUC8HyAAAA:8
    a=pGLkceISAAAA:8 a=JfrnYn6hAAAA:8 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8
    a=eLQIdrT-S-XZpLnzvJcA:9 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755581AbeDIC5i (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:57:38 -0400
Received: from mail-bn3nam01on0139.outbound.protection.outlook.com ([104.47.33.139]:14848
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755216AbeDIAZj (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:25:39 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 127/161] perf evsel: Fix period/freq terms
 setup
Thread-Topic: [PATCH AUTOSEL for 4.14 127/161] perf evsel: Fix period/freq
 terms setup
Thread-Index: AQHTz5i56uE3/CxLJUSBgLCvTgx0Lg==
Date: Mon, 9 Apr 2018 00:21:37 +0000
Message-ID: <20180409001936.162706-127-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:1ur1rx4yGXMaUjzkRQ4wOuSAZUWFQWScB5e692whgjG5ZwSTHOSj4ojBDUsvaMzC10Ig/KwQhQYV7a8cJgp9KDt3EBH809vwTdzmrsJQCGN8ZwXFtfb8o91qWhJYhBxOv/tryLz/xRgHBBMMs7tqJpJDamywS7ygKDRkPxONchUOTrqFyFbxFqfWzlkYnSxRw+quALq/3SNzjWuzGu1R+66Gqba/7/2HVTA5z2HxkMVV3ljujVqXOjEr0riTgs/e;20:RUY9yFrElhgicGOoa1VAMOgmIOuzAblcJJ1mBlPv7hoHZeWi39sn5cZx0MB9vSVd/jS1dDyWKZIKwtGpqyqsf2weAeAuB0ppTRq7iLQtuhZxoRGuEoRXTPbh3O34XxgC9a/X+bxHFSXpItMtIxpSWU8TxdUDxGf4Amcsi0TIaGA=
X-MS-Office365-Filtering-Correlation-Id: 6be7c5fa-c7b5-457d-b4b1-08d59db0695d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB101313CFA98F7FF08E37FB4FFBBF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(211936372134217)(42068640409301)(153496737603132)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(396003)(39860400002)(39380400002)(189003)(199004)(3280700002)(2616005)(8936002)(7736002)(476003)(446003)(11346002)(53936002)(3660700001)(86362001)(575784001)(86612001)(81156014)(2906002)(186003)(81166006)(105586002)(1076002)(8676002)(26005)(97736004)(25786009)(6306002)(6512007)(3846002)(68736007)(72206003)(106356001)(5660300001)(6486002)(6116002)(966005)(14454004)(4326008)(305945005)(6436002)(2501003)(5250100002)(10290500003)(478600001)(2900100001)(22452003)(110136005)(39060400002)(316002)(99286004)(66066001)(10090500001)(107886003)(76176011)(102836004)(54906003)(6506007)(36756003)(486006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 05uU/SfCksLXLt6bzWFVjuJPLZ0x352p4x8xjYmPxDwecUrhsvQylUtPmPwOJr2Man3dE0b2Ro0IP1DIdBxqpIrObzYj2q2iQ997aOrrNmT5qboppFGPY18/OrvqGsMq4VATptGkh7sJfvhWO45y/i+EyY3tmgJvTS0nC1tHn3CYKfp0s/YtdG84MWOSmmqtKxtuqapABDEfkogKTmyCTE2CECwfZhhAh0T3l3CgS9Aw7OHt4NUrT4/HWOfzCSUt5nAgAw++CNlkjQh3c92lh1YY+uTiLLrtElKL/aoI6X1GwkF7JZBsQXfV7+Mh/PiqifMnK9csEK4X0eGAULVlrb99B9JOWPO7caLEjxdCsQJMljpRDvDjgicrMiPn6RPhulWRTjq8wkfRreY92emaA4tXoR25g4AeHOjejBe2+7g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be7c5fa-c7b5-457d-b4b1-08d59db0695d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:37.7374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jiri Olsa <jolsa@kernel.org>

[ Upstream commit 49c0ae80eb32426fa133246200628e529067c595 ]

Stephane reported that we don't set properly PERIOD sample type for
events with period term defined.

Before:
  $ perf record -e cpu/cpu-cycles,period=3D1000/u ls
  $ perf evlist -v
  cpu/cpu-cycles,period=3D1000/u: ... sample_type: IP|TID|TIME|PERIOD, ...

After:
  $ perf record -e cpu/cpu-cycles,period=3D1000/u ls
  $ perf evlist -v
  cpu/cpu-cycles,period=3D1000/u: ... sample_type: IP|TID|TIME, ...

Setting PERIOD sample type based on period term setup.

Committer note:

When we use -c or a period=3DN term in the event definition, then we don't
need to ask the kernel, for this event, via perf_event_attr.sample_type
|=3D PERF_SAMPLE_PERIOD, to put the event period in each sample for this
event, as we know it already, it is in perf_event_attr.sample_period.

Reported-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Stephane Eranian <eranian@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180201083812.11359-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/util/evsel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 7c335d84becf..81d032e56ea5 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -736,12 +736,14 @@ static void apply_config_terms(struct perf_evsel *evs=
el,
 			if (!(term->weak && opts->user_interval !=3D ULLONG_MAX)) {
 				attr->sample_period =3D term->val.period;
 				attr->freq =3D 0;
+				perf_evsel__reset_sample_bit(evsel, PERIOD);
 			}
 			break;
 		case PERF_EVSEL__CONFIG_TERM_FREQ:
 			if (!(term->weak && opts->user_freq !=3D UINT_MAX)) {
 				attr->sample_freq =3D term->val.freq;
 				attr->freq =3D 1;
+				perf_evsel__set_sample_bit(evsel, PERIOD);
 			}
 			break;
 		case PERF_EVSEL__CONFIG_TERM_TIME:
--=20
2.15.1
