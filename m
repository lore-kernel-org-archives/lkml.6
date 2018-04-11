Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754152AbeDKSDg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 14:03:36 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37060 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753116AbeDKSDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 14:03:32 -0400
From: Song Liu <songliubraving@fb.com>
To: Ingo Molnar <mingo@kernel.org>
CC: Vince Weaver <vincent.weaver@maine.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: perf: fuzzer leads to trace_kprobe: Could not insert message
 flood
Thread-Topic: perf: fuzzer leads to trace_kprobe: Could not insert message
 flood
Thread-Index: AQHT0NsKF6lgcxb36UeZZJCEysMOEaP6arGAgAEOK4CAAGP5AA==
Date: Wed, 11 Apr 2018 18:02:37 +0000
Message-ID: <C0B2EFB5-C403-4BDB-9046-C14B3EE66999@fb.com>
References: <alpine.DEB.2.21.1804101043490.6068@macbook-air>
 <A3B3905F-3364-462A-BE02-B01D52482791@fb.com>
 <20180411120447.2gzrwijrtayjv3eg@gmail.com>
In-Reply-To: <20180411120447.2gzrwijrtayjv3eg@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.6.18)
x-originating-ip: [2620:10d:c090:200::4:bb2e]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR15MB1562;7:aBXkthG3FNUB52ajGOGfivQ138d+5Gayels9WP6ybl3vUjN32dD1p/9zFBQQ6Q6pQBswA/Dlef/z6g2X0XgEzaognwyiHX3epbTQAlvueu7OuEFY6WOfXzqFjO22cp41zUf4ilNAPmCdwU48iWuGvKjFt9q1q+WvawTkKNec7sbxavg9vMYhO2lfZj0TmblPV0WGLOIaE7kRs3PBantUg7hn15lNR3qiL1d8ABH9fTRg/PmFbhqZuylGe2EAgR0G;20:Z/2cHmsUu3IugME5jvGJUPdXxBxmZ75krHcezCuYYwC/TlzJbff4AKVr0gsJVwlpWeJ1ARfaG3lMDEmPczuIo6mEIBbKt5tP3aU7xeN36RHIUr+JVlmj99cn27E3xE3x1EKndzbfFn+x+jxhFtaWps3h/V5pDJze7xXBeWe92w0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR15MB1562;
x-ms-traffictypediagnostic: DM5PR15MB1562:
x-microsoft-antispam-prvs: <DM5PR15MB15620851BA3C9CF961B7CEA3B3BD0@DM5PR15MB1562.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231221)(11241501184)(944501327)(52105095)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR15MB1562;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1562;
x-forefront-prvs: 0639027A9E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(39860400002)(366004)(346002)(376002)(51914003)(57704003)(189003)(199004)(54906003)(25786009)(57306001)(3660700001)(105586002)(106356001)(186003)(486006)(3280700002)(476003)(2906002)(68736007)(6512007)(15650500001)(229853002)(33656002)(97736004)(4326008)(2900100001)(6436002)(7736002)(305945005)(82746002)(6486002)(478600001)(5250100002)(102836004)(36756003)(6246003)(53936002)(46003)(86362001)(6916009)(6116002)(11346002)(99286004)(83716003)(8936002)(81156014)(81166006)(50226002)(53546011)(6506007)(59450400001)(8676002)(14454004)(5660300001)(76176011)(446003)(316002)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1562;H:DM5PR15MB1548.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: HJoHf9mhrFG20M8d2ndv6l8OED0mcDchXC0mEbrfFIjZ8txAYSLN+MIEBKEHuR2f1QT8+qq6J2YGyKg3ER7cJF+kH75Hem9OvEHt21WArEEj6PKdQYz2iAz5f0y/DhWzFVkOIVzC6ascZfPg2+IUwkCzkGDEerFuzY+T0QdnCmbwAOrEMTgb4IfuduouL9MxCzWDOQ17W98gzOS+3jRTIWMX0WUSDkOm1IzR1aaCvMSU6uOFJCzjorUhBs+pnHsr4ax0onE1mP1Jt0FvQfRNmYEqGuvkDQPN3tV/TaRPwThGGaY8aIOk6hcm/GxbCwr3Ah1BRAeh8jYIgQdIMrI8Ea9MoYi+rMFAFIdkbrQ2s5A29eEXt136TpHBFsTpWwtLXTyN5DH6UJdp9vCw4fF6gb3gpiEfM1B0YRBh4oKVod8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <763552D62E7F8B4BB68471725BDF2B8F@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 869babe2-bbc3-4f4b-aa52-08d59fd66909
X-MS-Exchange-CrossTenant-Network-Message-Id: 869babe2-bbc3-4f4b-aa52-08d59fd66909
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2018 18:02:37.5758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1562
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-11_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3BI3n55008765



> On Apr 11, 2018, at 5:04 AM, Ingo Molnar <mingo@kernel.org> wrote:
> 
> 
> * Song Liu <songliubraving@fb.com> wrote:
> 
>> 
>> 
>>> On Apr 10, 2018, at 7:48 AM, Vince Weaver <vincent.weaver@maine.edu> wrote:
>>> 
>>> Author: Song Liu <songliubraving@fb.com>
>>> Date:   Wed Dec 6 14:45:15 2017 -0800
>>> 
>>> When running the perf_fuzzer on a current git checkout my logs are flooded 
>>> with messages such as this:
>>> [71487.869077] trace_kprobe: Could not insert probe at unknown+0: -22
>>> [71488.174479] trace_kprobe: Could not insert probe at unknown+0: -22
>>> 
>>> Presumably this is due to the introduction of the perf_kprobe PMU in
>>> 	commit e12f03d7031a977356e3d7b75a68c2185ff8d155
>>> 	Author: Song Liu <songliubraving@fb.com>
>>> 	Date:   Wed Dec 6 14:45:15 2017 -0800
>>> 
>>> Is there a way to get this error disabled, or else rate-limited?
>>> 
>>> Vince
>> 
>> Hi Vince, 
>> 
>> Thanks for the report. 
>> 
>> This is a new API that creates probe together with perf_event_open(). Based on 
>> my limited understanding of perf_fuzzer, it doesn't understand this API, and uses 
>> it in an abnormal way. [...]
> 
> Vince's point is valid: the kernel log should not be flooded with pointless 
> messages as a response to user-space ABI uses ...
> 
> Why is there a kernel log message at all, isn't an error returned?
> 
>> [...] I would recommend perf_fuzzer to understand this new API and test it. 
>> [...]
> 
> This bug needs to be fixed: a new API must not effectively DoS fuzzing efforts by 
> spamming the kernel log ...

Yeah, the new API allows non-root user to trigger this message. We should only 
allow root to create kprobe with perf_event_open(). 

On the other hand, do we need to fix this for root? In fact, a simple bash loop 
can create something similar through the text interface (with root):

root@virt-test:~# for x in {0..5} ; do echo p:xx xx+$x >> /sys/kernel/debug/tracing/kprobe_events ; done
-bash: echo: write error: No such file or directory
-bash: echo: write error: No such file or directory
-bash: echo: write error: No such file or directory
-bash: echo: write error: No such file or directory
-bash: echo: write error: No such file or directory
-bash: echo: write error: No such file or directory
root@virt-test:~# dmesg | tail -n 5
[  664.208374] trace_kprobe: Could not insert probe at xx+1: -2
[  664.237882] trace_kprobe: Could not insert probe at xx+2: -2
[  664.268067] trace_kprobe: Could not insert probe at xx+3: -2
[  664.297395] trace_kprobe: Could not insert probe at xx+4: -2
[  664.327614] trace_kprobe: Could not insert probe at xx+5: -2

This happens before the new API is introduced. 

The following patch does capable(CAP_SYS_ADMIN) for perf_kprobe and 
perf_uprobe at an earlier stage, so non-root user cannot trigger 
this error message. Please let me know whether we need to fix this 
for root. 

Thanks,
Song



>From c6708e9e3cd5ba7afb5a7f693b04abf64fec031e Mon Sep 17 00:00:00 2001
From: Song Liu <songliubraving@fb.com>
Date: Wed, 11 Apr 2018 10:37:00 -0700
Subject: [PATCH] perf: need CAP_SYS_ADMIN to create k/uprobe with
 perf_event_open()

Non-root user cannot create kprobe or uprobe through the text-based
interface (kprobe_events, uprobe_events). So they cannot create the
probes with perf_event_open(). To ensure this, we check
capable(CAP_SYS_ADMIN) at perf_[k,u]probe_event_init().

Fixes: e12f03d7031a ("perf/core: Implement the 'perf_kprobe' PMU")
Fixes: 33ea4b24277b ("perf/core: Implement the 'perf_uprobe' PMU")

Signed-off-by: Song Liu <songliubraving@fb.com>
Reported-by: Vince Weaver <vincent.weaver@maine.edu>
Cc: Ingo Molnar <mingo@kernel.org>
---
 kernel/events/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index d7af828..2d5fe26 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8400,6 +8400,10 @@ static int perf_kprobe_event_init(struct perf_event *event)

        if (event->attr.type != perf_kprobe.type)
                return -ENOENT;
+
+       if (!capable(CAP_SYS_ADMIN))
+               return -EACCES;
+
        /*
         * no branch sampling for probe events
         */
@@ -8437,6 +8441,10 @@ static int perf_uprobe_event_init(struct perf_event *event)

        if (event->attr.type != perf_uprobe.type)
                return -ENOENT;
+
+       if (!capable(CAP_SYS_ADMIN))
+               return -EACCES;
+
        /*
         * no branch sampling for probe events
         */
--
2.9.5
