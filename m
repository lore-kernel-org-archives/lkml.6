Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523245299-2-5220337838542253882
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
    1523245298; b=mdqeDYdqACWb53SEQVI5CBIcJuNsNWIigHxhHOKWwlEjQa+YWP
    eD3+7ZtjESi64uQ6tM6uCevluxstJxjQIqqr3tplZZQ0AJT2eJVlkGtuvumlwIhy
    SZovrpdrA/PnYth+1RxbyrbNhQ4HhUgWHfDTvpOhpjr6Yjip9DP9pgc9QSwWNC+P
    Mw5mA/eZoesVhR3SuA76JdZEERhyUa4IFpf7rMsY0jhjcLNM34qv/qJPmebIQk4t
    QrNmE4IOQtiSgmCn5b1HZwzqIfuLH7BqPTkaNGB5C0fcWhvPseOB/7+1LXjvAN4v
    ax2eT+1lPre1j/AJh1TlsWIgPP2+NI2YRyEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523245298; bh=Liga4kne7F
    FqSg8q2PjuWgdzH8VGsnJlyOF5HvfefgQ=; b=ku5xHvTke8usLG17Uj0AKQ+0gk
    +kyvEgpAlT7JGjRZpmBhDYVVA39D73oINp84AvaaXOBGvs64NRdE+94jNnwr9bYd
    yO0M/5/9K/mWU4ER2wUGiIPaSKd3pXafnV+NL/RIRW2oCzr9eMJqrkqUGvSvTgJE
    byUpxo/9Bd9Zc8jtqwSylqkpi+3HBhjBmMVPNQojpdrop/P0ge4sI0C56OVlEF9+
    eHKsUGacbwV3WJgnAmmG9FR5MwqpRx2kfL0BYW7diXGa11u2CqRWuP+TA75xsqPu
    PObomZbkP7Ttyvh+Wa06uYb0++ikKF6ZzOPDnm3Csuvv0WIPNXub3GM3PtRw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=N7SvDuIq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=N7SvDuIq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPyTdUu2Z5gs3H2TbJt/qA/Y9UEPIhSBMSeF4FBqmVPqj0w0+I5HEQfJPN/XvQ8PBHT1sBCfEEnk2VkMixAiCBwE72k0XKOCZbz+SiyVnVPYAjmCW+wu
    npvoweJNrE0iCCBgwkEHfeZSUQCuTi48SypYpcL0nAXJLUbYGGShWAqLPlg9e+W8PtjbvrOAYzzY5YYl66x8zwJMXgCHc6y/MToKYDO7ogHFY994qvD93gKk
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=QyXUC8HyAAAA:8
    a=pGLkceISAAAA:8 a=JfrnYn6hAAAA:8 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8
    a=eLQIdrT-S-XZpLnzvJcA:9 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754347AbeDIAVC (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:21:02 -0400
Received: from mail-sn1nam01on0114.outbound.protection.outlook.com ([104.47.32.114]:12752
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754340AbeDIAU7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:20:59 -0400
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
Subject: [PATCH AUTOSEL for 4.15 151/189] perf evsel: Fix period/freq terms
 setup
Thread-Topic: [PATCH AUTOSEL for 4.15 151/189] perf evsel: Fix period/freq
 terms setup
Thread-Index: AQHTz5hVyGc5ZkM9zEuIu4XHLmjWZA==
Date: Mon, 9 Apr 2018 00:18:50 +0000
Message-ID: <20180409001637.162453-151-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:2+v/PmLQINkI6betFImO2g73fYiGXP/LzNBb+QoKcGbYMWMeqfx3o+yD1BMVfqQV7J3Z0Fw6+dw1G5EvY0SWr/+e5iinzlk0n+5u/S/lr4fphBSsexkxwuTKQN+CEJ4MQX5CB+Ax/eytP2D8RXUrE+ySTz0dtFjE9B1xCVfhkDQC4o2xuGWZYWKbF9PANiiUyGedNiOOMGfItFMh8IWFfW9jannnoFG2RD78+SqGyQ+5BjYJn+T0YYEhLVpbRP8y;20:akPYp8XBfJCwvTY+62z0uAk1LiffeVASrHLM/zN2JrAPJmUByCeUaKSTjvJZIlFisZCUj862+4qFp/6/WIcpSkF9A3R8e4rl2ZP5vC1eUvrOEaFpDkvFMhY1mpZO8Pd6sbx7wuguZ3Op62TQ5gx4lRtJg34meii1QEHvLfOp2fs=
X-MS-Office365-Filtering-Correlation-Id: d26437b2-4b31-4301-f34d-08d59dafc3ba
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB092064871FDE48CA39B35C1BFBBF0@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(211936372134217)(42068640409301)(153496737603132)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(346002)(376002)(199004)(189003)(66066001)(86362001)(3660700001)(3280700002)(25786009)(76176011)(2900100001)(36756003)(6506007)(2906002)(99286004)(86612001)(6486002)(102836004)(305945005)(1076002)(7736002)(575784001)(97736004)(2616005)(446003)(11346002)(476003)(486006)(26005)(39060400002)(6666003)(6512007)(4326008)(107886003)(6306002)(5660300001)(478600001)(6436002)(105586002)(10290500003)(966005)(5250100002)(22452003)(316002)(186003)(8676002)(110136005)(81166006)(54906003)(6116002)(8936002)(72206003)(53936002)(2501003)(3846002)(68736007)(14454004)(81156014)(10090500001)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: JI72cqwxUvHuMzh+aOIQqjPBd7dYdFFcHqKgm+VpLfQ4fWiz+KvYXNvL4CMytDe0m1o2D+QTS6KkYwBd41+Ze7yhs6D1/1brAeYSio6/RcvQmu2PjyrlLnglXxTGuLyUkDCxCinrhnIaU31ah0Zdz5FJkOfxhkCLPvA2/il1Unm7a7giWevPA2XfHPOX79qblnY9Ny/9tLFMBzaLSJUdObEz/4391gnaeIy0iWmPk20x07RQQWUIZOadD+rm/2mMkqj52KRevzb0tw/8dJKaY/mmR0ohKtBRTiBMEaR4W8f6MY1thASEeI3ETKQdQK651RwCB3ULXdI6mFGvF1rIGntpwnlahexon+MoBWd29t3uD0aCHfYwvXDrYVKvMr6Fmr8K5xOgDkn3uztdxk1PuMdCp5Zcvwp8EA9thj2ltQs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d26437b2-4b31-4301-f34d-08d59dafc3ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:50.1747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
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
index d23a8c51b307..7349a5d22464 100644
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
