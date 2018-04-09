Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523241052-2-459020266272595108
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
    1523241051; b=VMmBKpjsjzG/GP+nBeZ0jGYaB5FWW4acEyDVmpwh4ygrSxvScH
    3yncIBxaFBEBuGweedssMxs3kQUS9x6pUBpwE6m/GYEn3N8sHD6vOzzblH5N7Y2a
    7kLsXbqgb7gDoVRlooKNUpkgFpYZjknxMjM8x73KBUwMPbqCdEk27n86Oy4iErRb
    ALHuNHjJh7QWTXaallt8pSXLVAfZtuvrfrb8F93gr+XUAfEyMyLKUADOT35miphJ
    YqoiGM9fqfalWIl30lgYn7napM4WrwCqrflto12Zxhp8OiIiIsF/iPjMI9WBSgKQ
    0kx9aZP1otvteAy5xMUZN7f1XZFdrYvew+nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523241051; bh=dFjE5+Dmta
    7yu0tsbMQggNFUCa6RAaOTMGlPFACV7II=; b=KraKct7gsKCS+Zyjzl10TBCErZ
    Kffpk2ShFzTxBkdx56Tb6+MKdRzhfa709xd8acg3cObNowOLmzHoilcjsCdKDyxb
    qbnnws8JvJFytUCV7m1kBdNU8hiXDirvPo9SIMSWb/pBowWwC0n8LRupFaI5Ft42
    gsHL+oPaDTD4MRhDp4BJNC9PU//pXdItYkBjVfPifdBslwkoFgXaP2+7i3ir1NTl
    0pXur5K443IQG+GPpyp4tB8DHBJ2durQUFptlUa/YcqQ+mhhNi/YgIVrDh5aAf2O
    QvCPS/sUMAQavvUdYHYgTPVClJwaxo3bKVjn+0Jk+HXYvBh9iia2OWeNl+GQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=X47fHjs2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=X47fHjs2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDdO6j5olNlnJ8V/fSmXiEifd0FIGQ0rAvhyejQSFhCJHhcGqGhLJf8royhnxwnJkJI55gFwhX5NLM0w+ZWREsy3MsE5Cy2aO6djdYw78w6F69HlYDAz
    AWc9Tf+Dg44sIktLwQJJ3274EIe/NOt48ihGG3Y0BoU6fMohT8PuczmXCkWnj25X2a21TK9/9RlphrHbnBsYjF3kXf10X3QpNBVpva+EhWV/oCJ2lpxm2pvv
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=QyXUC8HyAAAA:8
    a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=i0EeH86SAAAA:8
    a=yMhMjlubAAAA:8 a=EjWtLyn3Rv0cpx1RPmUA:9 a=wPNLvfGTeEIA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755847AbeDIA2d (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:28:33 -0400
Received: from mail-sn1nam02on0093.outbound.protection.outlook.com ([104.47.36.93]:56217
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755842AbeDIA23 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:28:29 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Wang Nan <wangnan0@huawei.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 072/293] perf evsel: Fix probing of precise_ip
 level for default cycles event
Thread-Topic: [PATCH AUTOSEL for 4.9 072/293] perf evsel: Fix probing of
 precise_ip level for default cycles event
Thread-Index: AQHTz5kIwDEed94dWUuuEtJTFzE3zA==
Date: Mon, 9 Apr 2018 00:23:50 +0000
Message-ID: <20180409002239.163177-72-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0871;7:2q3pzIqtmu868Tcy6kb7Nl83jVhNBgkLCr7eyS6Fl9fClt6GPbpnhAzJZBRFUWAxzC2uYYbPLrSl4I/3BnahnN6tGbuIlNUAnSff3ZuvhxD40xR7zCtBCtQ9x9z5/iE0QOy9ZePFgzGvO2lNBYW8FYHZtrBMg7IAqMDbxvbyRqlneLLxloSp1qjhryfD5YavoKrLqD+2eKWbhxnxljceyCh0hzNPKhYh6oKhX3oFYgQlzc6sbpvMUnZhV+RhzuTI;20:DEDFIYeNPOqNL4eQs6chTVraSg/pEdjlGJoz82rTkeFAhEztBEQKi9yIYGbBffUfofwzwY7zH+S8kf1c4L1HbWNlkdi1jSAeEEStRbiGACCzV1FfUjOWmtRIrpXbbuHcgwptGPJ79ZiGEUkUEEp9DKe4z2c1XzWjia87AMUSqDA=
X-MS-Office365-Filtering-Correlation-Id: 5b7b7759-14ee-449e-62d0-08d59db0cc48
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0871;
x-ms-traffictypediagnostic: DM5PR2101MB0871:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08714168D7B959A8D748F255FBBF0@DM5PR2101MB0871.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(85827821059158)(42068640409301)(84791874153150)(104084551191319)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0871;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0871;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39380400002)(376002)(39860400002)(199004)(189003)(105586002)(8676002)(59450400001)(3660700001)(3280700002)(6506007)(81156014)(81166006)(14454004)(99286004)(72206003)(110136005)(8936002)(54906003)(305945005)(2906002)(316002)(966005)(10290500003)(478600001)(7736002)(53936002)(6512007)(486006)(11346002)(39060400002)(4326008)(6306002)(86362001)(575784001)(446003)(3846002)(102836004)(76176011)(476003)(25786009)(22452003)(36756003)(107886003)(6666003)(10090500001)(5660300001)(6486002)(86612001)(6436002)(2616005)(68736007)(26005)(1076002)(186003)(2501003)(5250100002)(2900100001)(106356001)(66066001)(6116002)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0871;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: bIm1Tn1L/Z6sfA3MzZXJSco5/nIZWkhsv32/6TQsD100c5QQuom2gtW5SH2ep/oSm+CAeGnSUbGZTx9aVurSA2Q50GEIe6FR5eAk/hI5S6g4fN6dEiarLynASuR3edt+mk6Lzmg6RH2LH0t3WUpEKHwmUF6EAX2SVmhS1MdteJJUR2huh0z2nOzC2mYbHOgIJNP0kCG558vprYHWPPRfl8FQo/LP4fYb9TBWvh+NfbCSAnfzOtiSjz/oy7LI/Vp/QTVi3ksCmD6pAAiuR2zHdrlwwMi+uDXyZqub2ZeKYehEtNo4/aBwd1jmy1fQdaU3s7rnUN1dh1mCvbA0MC92xCp5qPQxm5kpFX7+/W0Kqphb58l+eeFdJArzMipTrs6RSttWSykM9BUU+MZCyIV2tgEiYMlVns+8dm8LrHJdoks=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b7b7759-14ee-449e-62d0-08d59db0cc48
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:50.2218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0871
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Arnaldo Carvalho de Melo <acme@redhat.com>

[ Upstream commit 7a1ac110c22eb726684c837544a2d42c33e07be7 ]

Since commit 18e7a45af91a ("perf/x86: Reject non sampling events with
precise_ip") returns -EINVAL for sys_perf_event_open() with an attribute
with (attr.precise_ip > 0 && attr.sample_period =3D=3D 0), just like is don=
e
in the routine used to probe the max precise level when no events were
passed to 'perf record' or 'perf top', i.e.:

	perf_evsel__new_cycles()
		perf_event_attr__set_max_precise_ip()

The x86 code, in x86_pmu_hw_config(), which is called all the way from
sys_perf_event_open() did, starting with the aforementioned commit:

                /* There's no sense in having PEBS for non sampling events:=
 */
                if (!is_sampling_event(event))
                        return -EINVAL;

Which makes it fail for cycles:ppp, cycles:pp and cycles:p, always using
just the non precise cycles variant.

To make sure that this is the case, I tested it, before this patch,
with:

  # perf probe -L x86_pmu_hw_config
  <x86_pmu_hw_config@/home/acme/git/linux/arch/x86/events/core.c:0>
        0  int x86_pmu_hw_config(struct perf_event *event)
        1  {
        2         if (event->attr.precise_ip) {
<SNIP>
       17                 if (event->attr.precise_ip > precise)
       18                         return -EOPNOTSUPP;

                          /* There's no sense in having PEBS for non sampli=
ng events: */
       21                 if (!is_sampling_event(event))
       22                         return -EINVAL;
                  }
<SNIP>
  # perf probe x86_pmu_hw_config:22
  Added new events:
    probe:x86_pmu_hw_config (on x86_pmu_hw_config:22)
    probe:x86_pmu_hw_config_1 (on x86_pmu_hw_config:22)

  You can now use it in all perf tools, such as:

        perf record -e probe:x86_pmu_hw_config_1 -aR sleep 1

  # perf trace -e perf_event_open,probe:x86_pmu_hwconfig*/max-stack=3D16/ p=
erf record usleep 1
     0.000 ( 0.015 ms): perf/4150 perf_event_open(attr_uptr: 0x7ffebc8ba110=
, cpu: -1, group_fd: -1      ) ...
     0.015 (         ): probe:x86_pmu_hw_config:(ffffffff9c0065e1))
                                       x86_pmu_hw_config ([kernel.kallsyms]=
)
                                       hsw_hw_config ([kernel.kallsyms])
                                       x86_pmu_event_init ([kernel.kallsyms=
])
                                       perf_try_init_event ([kernel.kallsym=
s])
                                       perf_event_alloc ([kernel.kallsyms])
                                       SYSC_perf_event_open ([kernel.kallsy=
ms])
                                       sys_perf_event_open ([kernel.kallsym=
s])
                                       do_syscall_64 ([kernel.kallsyms])
                                       return_from_SYSCALL_64 ([kernel.kall=
syms])
                                       syscall (/usr/lib64/libc-2.24.so)
                                       perf_event_attr__set_max_precise_ip =
(/home/acme/bin/perf)
                                       perf_evsel__new_cycles (/home/acme/b=
in/perf)
                                       perf_evlist__add_default (/home/acme=
/bin/perf)
                                       cmd_record (/home/acme/bin/perf)
                                       run_builtin (/home/acme/bin/perf)
                                       handle_internal_command (/home/acme/=
bin/perf)
     0.000 ( 0.021 ms): perf/4150  ... [continued]: perf_event_open()) =3D =
-1 EINVAL Invalid argument
     0.023 ( 0.002 ms): perf/4150 perf_event_open(attr_uptr: 0x7ffebc8ba110=
, cpu: -1, group_fd: -1      ) ...
     0.025 (         ): probe:x86_pmu_hw_config:(ffffffff9c0065e1))
                                       x86_pmu_hw_config ([kernel.kallsyms]=
)
                                       hsw_hw_config ([kernel.kallsyms])
                                       x86_pmu_event_init ([kernel.kallsyms=
])
                                       perf_try_init_event ([kernel.kallsym=
s])
                                       perf_event_alloc ([kernel.kallsyms])
                                       SYSC_perf_event_open ([kernel.kallsy=
ms])
                                       sys_perf_event_open ([kernel.kallsym=
s])
                                       do_syscall_64 ([kernel.kallsyms])
                                       return_from_SYSCALL_64 ([kernel.kall=
syms])
                                       syscall (/usr/lib64/libc-2.24.so)
                                       perf_event_attr__set_max_precise_ip =
(/home/acme/bin/perf)
                                       perf_evsel__new_cycles (/home/acme/b=
in/perf)
                                       perf_evlist__add_default (/home/acme=
/bin/perf)
                                       cmd_record (/home/acme/bin/perf)
                                       run_builtin (/home/acme/bin/perf)
                                       handle_internal_command (/home/acme/=
bin/perf)
     0.023 ( 0.004 ms): perf/4150  ... [continued]: perf_event_open()) =3D =
-1 EINVAL Invalid argument
     0.028 ( 0.002 ms): perf/4150 perf_event_open(attr_uptr: 0x7ffebc8ba110=
, cpu: -1, group_fd: -1      ) ...
     0.030 (         ): probe:x86_pmu_hw_config:(ffffffff9c0065e1))
                                       x86_pmu_hw_config ([kernel.kallsyms]=
)
                                       hsw_hw_config ([kernel.kallsyms])
                                       x86_pmu_event_init ([kernel.kallsyms=
])
                                       perf_try_init_event ([kernel.kallsym=
s])
                                       perf_event_alloc ([kernel.kallsyms])
                                       SYSC_perf_event_open ([kernel.kallsy=
ms])
                                       sys_perf_event_open ([kernel.kallsym=
s])
                                       do_syscall_64 ([kernel.kallsyms])
                                       return_from_SYSCALL_64 ([kernel.kall=
syms])
                                       syscall (/usr/lib64/libc-2.24.so)
                                       perf_event_attr__set_max_precise_ip =
(/home/acme/bin/perf)
                                       perf_evsel__new_cycles (/home/acme/b=
in/perf)
                                       perf_evlist__add_default (/home/acme=
/bin/perf)
                                       cmd_record (/home/acme/bin/perf)
                                       run_builtin (/home/acme/bin/perf)
                                       handle_internal_command (/home/acme/=
bin/perf)
     0.028 ( 0.004 ms): perf/4150  ... [continued]: perf_event_open()) =3D =
-1 EINVAL Invalid argument
    41.018 ( 0.012 ms): perf/4150 perf_event_open(attr_uptr: 0x7ffebc8b5dd0=
, pid: -1, group_fd: -1, flags: FD_CLOEXEC) =3D 4
    41.065 ( 0.011 ms): perf/4150 perf_event_open(attr_uptr: 0x3c7db78, pid=
: -1, group_fd: -1, flags: FD_CLOEXEC) =3D 4
    41.080 ( 0.006 ms): perf/4150 perf_event_open(attr_uptr: 0x3c7db78, pid=
: -1, group_fd: -1, flags: FD_CLOEXEC) =3D 4
    41.103 ( 0.010 ms): perf/4150 perf_event_open(attr_uptr: 0x3c4e748, pid=
: 4151 (perf), group_fd: -1, flags: FD_CLOEXEC) =3D 4
    41.115 ( 0.006 ms): perf/4150 perf_event_open(attr_uptr: 0x3c4e748, pid=
: 4151 (perf), cpu: 1, group_fd: -1, flags: FD_CLOEXEC) =3D 5
    41.122 ( 0.004 ms): perf/4150 perf_event_open(attr_uptr: 0x3c4e748, pid=
: 4151 (perf), cpu: 2, group_fd: -1, flags: FD_CLOEXEC) =3D 6
    41.128 ( 0.008 ms): perf/4150 perf_event_open(attr_uptr: 0x3c4e748, pid=
: 4151 (perf), cpu: 3, group_fd: -1, flags: FD_CLOEXEC) =3D 8
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.017 MB perf.data (2 samples) ]
  #

I.e. that return -EINVAL in x86_pmu_hw_config() is hit three times.

So fix it by just setting attr.sample_period

Now, after this patch:

  # perf trace --max-stack=3D2 -e perf_event_open,probe:x86_pmu_hw_config* =
perf record usleep 1
  [ perf record: Woken up 1 times to write data ]
     0.000 ( 0.017 ms): perf/8469 perf_event_open(attr_uptr: 0x7ffe36c27d10=
, pid: -1, cpu: 3, group_fd: -1, flags: FD_CLOEXEC) =3D 4
                                       syscall (/usr/lib64/libc-2.24.so)
                                       perf_event_open_cloexec_flag (/home/=
acme/bin/perf)
     0.050 ( 0.031 ms): perf/8469 perf_event_open(attr_uptr: 0x24ebb78, pid=
: -1, group_fd: -1, flags: FD_CLOEXEC) =3D 4
                                       syscall (/usr/lib64/libc-2.24.so)
                                       perf_evlist__config (/home/acme/bin/=
perf)
     0.092 ( 0.040 ms): perf/8469 perf_event_open(attr_uptr: 0x24ebb78, pid=
: -1, group_fd: -1, flags: FD_CLOEXEC) =3D 4
                                       syscall (/usr/lib64/libc-2.24.so)
                                       perf_evlist__config (/home/acme/bin/=
perf)
     0.143 ( 0.007 ms): perf/8469 perf_event_open(attr_uptr: 0x24bc748, cpu=
: -1, group_fd: -1           ) =3D 4
                                       syscall (/usr/lib64/libc-2.24.so)
                                       perf_event_attr__set_max_precise_ip =
(/home/acme/bin/perf)
     0.161 ( 0.007 ms): perf/8469 perf_event_open(attr_uptr: 0x24bc748, pid=
: 8470 (perf), group_fd: -1, flags: FD_CLOEXEC) =3D 4
                                       syscall (/usr/lib64/libc-2.24.so)
                                       perf_evsel__open (/home/acme/bin/per=
f)
     0.171 ( 0.005 ms): perf/8469 perf_event_open(attr_uptr: 0x24bc748, pid=
: 8470 (perf), cpu: 1, group_fd: -1, flags: FD_CLOEXEC) =3D 5
                                       syscall (/usr/lib64/libc-2.24.so)
                                       perf_evsel__open (/home/acme/bin/per=
f)
     0.180 ( 0.007 ms): perf/8469 perf_event_open(attr_uptr: 0x24bc748, pid=
: 8470 (perf), cpu: 2, group_fd: -1, flags: FD_CLOEXEC) =3D 6
                                       syscall (/usr/lib64/libc-2.24.so)
                                       perf_evsel__open (/home/acme/bin/per=
f)
     0.190 ( 0.005 ms): perf/8469 perf_event_open(attr_uptr: 0x24bc748, pid=
: 8470 (perf), cpu: 3, group_fd: -1, flags: FD_CLOEXEC) =3D 8
                                       syscall (/usr/lib64/libc-2.24.so)
                                       perf_evsel__open (/home/acme/bin/per=
f)
  [ perf record: Captured and wrote 0.017 MB perf.data (7 samples) ]
  #

The probe one called from perf_event_attr__set_max_precise_ip() works
the first time, with attr.precise_ip =3D 3, wit hthe next ones being the
per cpu ones for the cycles:ppp event.

And here is the text from a report and alternative proposed patch by
Thomas-Mich Richter:

 ---

On s390 the counter and sampling facility do not support a precise IP
skid level and sometimes returns EOPNOTSUPP when structure member
precise_ip in struct perf_event_attr is not set to zero.

On s390 commnd 'perf record -- true' fails with error EOPNOTSUPP.  This
happens only when no events are specified on command line.

The functions called are
...
  --> perf_evlist__add_default
      --> perf_evsel__new_cycles
          --> perf_event_attr__set_max_precise_ip

The last function determines the value of structure member precise_ip by
invoking the perf_event_open() system call and checking the return code.
The first successful open is the value for precise_ip.

However the value is determined without setting member sample_period and
indicates no sampling.

On s390 the counter facility and sampling facility are different.  The
above procedure determines a precise_ip value of 3 using the counter
facility. Later it uses the sampling facility with a value of 3 and
fails with EOPNOTSUPP.

 ---

v2: Older compilers (e.g. gcc 4.4.7) don't support referencing members
    of unnamed union members in the container struct initialization, so
    move from:

	struct perf_event_attr attr =3D {
		...
		.sample_period =3D 1,
	};

to right after it as:

	struct perf_event_attr attr =3D {
		...
	};

	attr.sample_period =3D 1;

v3: We need to reset .sample_period to 0 to let the users of
perf_evsel__new_cycles() to properly setup attr.sample_period or
attr.sample_freq. Reported by Ingo Molnar.

Reported-and-Acked-by: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Acked-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: 18e7a45af91a ("perf/x86: Reject non sampling events with precise_ip"=
)
Link: http://lkml.kernel.org/n/tip-yv6nnkl7tzqocrm0hl3x7vf1@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/tests/task-exit.c |  2 +-
 tools/perf/util/evsel.c      | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index 01a5ba2788c6..b0d005d295a9 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -82,7 +82,7 @@ int test__task_exit(int subtest __maybe_unused)
=20
 	evsel =3D perf_evlist__first(evlist);
 	evsel->attr.task =3D 1;
-	evsel->attr.sample_freq =3D 0;
+	evsel->attr.sample_freq =3D 1;
 	evsel->attr.inherit =3D 0;
 	evsel->attr.watermark =3D 0;
 	evsel->attr.wakeup_events =3D 1;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index bce80f866dd0..97fe0c80ff02 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -262,8 +262,20 @@ struct perf_evsel *perf_evsel__new_cycles(void)
 	struct perf_evsel *evsel;
=20
 	event_attr_init(&attr);
+	/*
+	 * Unnamed union member, not supported as struct member named
+	 * initializer in older compilers such as gcc 4.4.7
+	 *
+	 * Just for probing the precise_ip:
+	 */
+	attr.sample_period =3D 1;
=20
 	perf_event_attr__set_max_precise_ip(&attr);
+	/*
+	 * Now let the usual logic to set up the perf_event_attr defaults
+	 * to kick in when we return and before perf_evsel__open() is called.
+	 */
+	attr.sample_period =3D 0;
=20
 	evsel =3D perf_evsel__new(&attr);
 	if (evsel =3D=3D NULL)
--=20
2.15.1
