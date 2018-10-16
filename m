Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260E0C5ACCA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC96220645
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="AQ26uP5H";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="LmAg8mMX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC96220645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbeJQCUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 22:20:31 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47664 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727006AbeJQCUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 22:20:30 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9GILHOp014593;
        Tue, 16 Oct 2018 11:28:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=zZ1cwEg4SV+36DolvMYJNYXlKPuHWHT/cW7jN0P1yBs=;
 b=AQ26uP5HZCN34rCazzjLimAXa+FqU9TU10d9NhX5SFIZQlhxtCXmj3EXr2oVic7kmQ8n
 0nAnwofQugCv3gQKOsJn8zWb5fvOhXULbYsSvr6QWZZk27RccUdwsqZtFPDxo7fonKXO
 /AoLt5giIJfEFptjOrykLnTpHNIyV2F0lE8= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2n5k27gh0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 16 Oct 2018 11:28:17 -0700
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 16 Oct 2018 11:28:13 -0700
Received: from PRN-CHUB08.TheFacebook.com (2620:10d:c081:35::17) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Tue, 16 Oct 2018 11:28:13 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.18) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 16 Oct 2018 11:28:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZ1cwEg4SV+36DolvMYJNYXlKPuHWHT/cW7jN0P1yBs=;
 b=LmAg8mMXh2/u9/OxC+2fGpahtDOwVRBwFFYb/fLvhyfAKxpfLjEPBcjPJnhVW8Y1EZVA2H3lE7E4sRQK6vy0wNpSX1VCqnbvgovYOmim/U4RUF4l22i5yQFWduul6ApNWLMDVP7nrvyNhByebjC95ee8rt0svKUxavMt8jso0ys=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1616.namprd15.prod.outlook.com (10.175.135.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.25; Tue, 16 Oct 2018 18:28:10 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f809:2e0d:6e1c:924a]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f809:2e0d:6e1c:924a%8]) with mapi id 15.20.1228.027; Tue, 16 Oct 2018
 18:28:10 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "megha.dey@intel.com" <megha.dey@intel.com>,
        "frederic@kernel.org" <frederic@kernel.org>
Subject: Re: [RFC][PATCH] perf: Rewrite core context handling
Thread-Topic: [RFC][PATCH] perf: Rewrite core context handling
Thread-Index: AQHUYIaFJ/VvvMmSxkC06uIJGGK3pKUf754AgAATMgCAAOOBAIABVJuA
Date:   Tue, 16 Oct 2018 18:28:10 +0000
Message-ID: <FE66AE20-9785-4CF7-8D8D-CF2A9C696923@fb.com>
References: <20181010104559.GO5728@hirez.programming.kicks-ass.net>
 <3a738a08-2295-a4e9-dce7-a3e2b2ad794e@linux.intel.com>
 <20181015083448.GN9867@hirez.programming.kicks-ass.net>
 <AF0FCD08-E014-4D29-B023-EA780056DBB5@fb.com>
In-Reply-To: <AF0FCD08-E014-4D29-B023-EA780056DBB5@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.9.1)
x-originating-ip: [2620:10d:c090:200::4:9180]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1616;20:/rHKVwmiUpdaVy2dLXXuu57xT9DHkxzdDebuW9DnKjtdcYheGHuLNewpOa+HSujSe/6IWoN1hnYo0sliA1ZGmWBwftQZ6SWdP/Bg7cYjcy6gSmu7pmeymj4mDvYmef9o6XBGVKJTs8JpC4GffnRrpIG7RaIMphaV0otaI4odVCE=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 4aec9290-f09f-475c-50dc-08d633952082
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1616;
x-ms-traffictypediagnostic: MWHPR15MB1616:
x-microsoft-antispam-prvs: <MWHPR15MB16164E9387BF6053338EEAF9B3FE0@MWHPR15MB1616.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72170088055959)(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(11241501184)(944501410)(52105095)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991070);SRVR:MWHPR15MB1616;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1616;
x-forefront-prvs: 0827D7ACB9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(136003)(376002)(396003)(189003)(199004)(53754006)(71200400001)(6246003)(446003)(82746002)(54906003)(7416002)(11346002)(53936002)(71190400001)(2616005)(83716004)(6512007)(14454004)(25786009)(93886005)(476003)(6116002)(2900100001)(33656002)(305945005)(486006)(7736002)(2906002)(14444005)(4326008)(8936002)(36756003)(81166006)(86362001)(6506007)(6916009)(68736007)(53546011)(105586002)(81156014)(50226002)(186003)(46003)(256004)(316002)(57306001)(8676002)(99286004)(5250100002)(102836004)(478600001)(76176011)(106356001)(5660300001)(97736004)(6436002)(229853002)(6486002)(21314002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1616;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Rh/HbyivHRk7aCN7661hE64sNY6ouvjnsQefkGIybAVZA9XdzwV2yZcZZs9FRXjjWxlxSjZCWonZ0KGRmRJDxZTfHTLYNPyovu+rp9xl5UihIdvHJLQJmBaPxYI/ZeRegTrx6UBHn19L2J2qwS69G9X6ACesAvDzRAl/ycWdNFe5Iir07nqgSqfGYLHvcFiy1Dt0PPhwAvaRRGQ/qUEaQA9ayt9DFiaqxIaGhEQCnJ1b8MBpmYiPrcOhMNKis2PCuAdy3TzL1rHh5Fo9isvgwrsE62X9xTfPJLxHguPFUg2uBn5TQGsaa+YYFAN4gykeoCuZVxXLI9YChvVeK3HaQrqI5VecOcCWl60V19DQVRg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F52FC9D74A06AE4BB926C7BA09EC52B1@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aec9290-f09f-475c-50dc-08d633952082
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2018 18:28:10.6757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1616
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-16_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

> On Oct 15, 2018, at 3:09 PM, Song Liu <songliubraving@fb.com> wrote:
>=20
>=20
>=20
>> On Oct 15, 2018, at 1:34 AM, Peter Zijlstra <peterz@infradead.org> wrote=
:
>>=20
>> On Mon, Oct 15, 2018 at 10:26:06AM +0300, Alexey Budankov wrote:
>>> Hi,
>>>=20
>>> On 10.10.2018 13:45, Peter Zijlstra wrote:
>>>> Hi all,
>>>>=20
>>>> There have been various issues and limitations with the way perf uses
>>>> (task) contexts to track events. Most notable is the single hardware P=
MU
>>>> task context, which has resulted in a number of yucky things (both
>>>> proposed and merged).
>>>>=20
>>>> Notably:
>>>>=20
>>>> - HW breakpoint PMU
>>>> - ARM big.little PMU
>>>> - Intel Branch Monitoring PMU
>>>>=20
>>>> Since we now track the events in RB trees, we can 'simply' add a pmu
>>>> order to them and have them grouped that way, reducing to a single
>>>> context. Of course, reality never quite works out that simple, and bel=
ow
>>>> ends up adding an intermediate data structure to bridge the context ->
>>>> pmu mapping.
>>>>=20
>>>> Something a little like:
>>>>=20
>>>>             ,------------------------[1:n]---------------------.
>>>>             V                                                  V
>>>>   perf_event_context <-[1:n]-> perf_event_pmu_context <--- perf_event
>>>>             ^                      ^     |                     |
>>>>             `--------[1:n]---------'     `-[n:1]-> pmu <-[1:n]-'
>>>>=20
>>>> This patch builds (provided you disable CGROUP_PERF), boots and surviv=
es
>>>> perf-top without the machine catching fire.
>>>>=20
>>>> There's still a fair bit of loose ends (look for XXX), but I think thi=
s
>>>> is the direction we should be going.
>>>>=20
>>>> Comments?
>>>>=20
>>>> Not-Quite-Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>>> ---
>>>> arch/powerpc/perf/core-book3s.c |    4=20
>>>> arch/x86/events/core.c          |    4=20
>>>> arch/x86/events/intel/core.c    |    6=20
>>>> arch/x86/events/intel/ds.c      |    6=20
>>>> arch/x86/events/intel/lbr.c     |   16=20
>>>> arch/x86/events/perf_event.h    |    6=20
>>>> include/linux/perf_event.h      |   80 +-
>>>> include/linux/sched.h           |    2=20
>>>> kernel/events/core.c            | 1412 ++++++++++++++++++++-----------=
---------
>>>> 9 files changed, 815 insertions(+), 721 deletions(-)
>>>=20
>>> Rewrite is impressive however it doesn't result in code base reduction =
as it is.
>>=20
>> Yeah.. that seems to be nature of these things ..
>>=20
>>> Nonetheless there is a clear demand for per pmu events groups tracking =
and rotation=20
>>> in single cpu context (HW breakpoints, ARM big.little, Intel LBRs) and =
there is=20
>>> a supply thru groups ordering on RB-tree.
>>>=20
>>> This might be driven into the kernel by some new Perf features that wou=
ld base on=20
>>> that RB-tree groups ordering or by refactoring of existing code but in =
the way it=20
>>> would result in overall code base reduction thus lowering support cost.
>>=20
>> If you have a concrete suggestion on how to reduce complexity? I tried,
>> but couldn't find any (without breaking something).
>>=20
>> The active lists and pmu_ctx_list could arguably be replaced with
>> (slower) iteratons over the RB tree, but you'll still need the per pmu
>> nr_events/nr_active counts to determine if rotation is required at all.
>>=20
>> And like you know, performance is quite important here too. I'd love to
>> reduce complexity while maintaining or improve performance, but that
>> rarely if ever happens :/
>=20
> How about this:=20
>=20
> 1. Keep multiple perf_cpu_context per CPU, just like before this patch.=20
>=20
> 2. For perf_event_context, add PMU as an order for the RB tree.=20
>=20
> 3. (hw) pmu->perf_cpu_context->ctx only has events for this PMU (and sw=20
>   events moved to this context).
>=20
> 4. task->perf_event_ctxp has events for all PMUs.=20
>=20
> With this path, we keep the existing perf_cpu_context/perf_event_context
> logic as-is, which I think is simp=10ler than the new logic (with extra
> *_pmu_context). And it should also solve the problem.=20
>=20
> Does this make sense? If this doesn't look too broken, I am happy to
> draft RFC for it.=20
>=20

I am not sure whether you missed this one, or found it totally insane.=20
Could you please share your comments on it? My gut feeling is that this=20
would be a simpler patch to solve the problem (two hw PMUs). (It might=20
be less efficient though).=20

Thanks,
Song=20


