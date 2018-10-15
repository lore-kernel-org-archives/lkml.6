Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26093C04EBC
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE10E208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="bybRP3ri";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="eZp0Yq2C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE10E208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbeJPF6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 01:58:07 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57218 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726185AbeJPF6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 01:58:07 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9FM5hD9024704;
        Mon, 15 Oct 2018 15:09:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=GV1dnDjZu/PDnmH1vUzRkoUnEJOxqRbOC5nNiE0AylE=;
 b=bybRP3rif1Wft2PpNJxHo74HkTVMdUG4UnAiowGCChpKPWo1O575hyLVfXjEgi81iCZO
 ssjBRDm78l9pGiB4T9gFJr1jKYyzEQrQ2/CJ3W88+vDeettzE+2bme67AiNEIahmatjW
 SBlPmSoEH5vdZGdGH2hVFtEBFbocJXpWG+8= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2n51hnrea1-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 15 Oct 2018 15:09:22 -0700
Received: from frc-hub06.TheFacebook.com (2620:10d:c021:18::176) by
 frc-hub06.TheFacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 15 Oct 2018 15:09:08 -0700
Received: from FRC-CHUB14.TheFacebook.com (2620:10d:c021:18::33) by
 frc-hub06.TheFacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Mon, 15 Oct 2018 15:09:08 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.34) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 15 Oct 2018 18:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GV1dnDjZu/PDnmH1vUzRkoUnEJOxqRbOC5nNiE0AylE=;
 b=eZp0Yq2CazFaf7UlHsjmgL0TV8hLH9UKuX+Vz/Jk2offOgeonYmAmon/EnURsVM9gn/Kyln8aoYXtVpylg6E0F9ZbuUuPBA7ADAslvihrL7C0Twvjin5zPguLrcT+Lu4+Ees1aOEha6STZ1fgOM3Uni0ErfzFozC29JNg8S5NdY=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1391.namprd15.prod.outlook.com (10.173.234.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.24; Mon, 15 Oct 2018 22:09:06 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f809:2e0d:6e1c:924a]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f809:2e0d:6e1c:924a%8]) with mapi id 15.20.1228.027; Mon, 15 Oct 2018
 22:09:05 +0000
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
Thread-Index: AQHUYIaFJ/VvvMmSxkC06uIJGGK3pKUf754AgAATMgCAAOOBAA==
Date:   Mon, 15 Oct 2018 22:09:05 +0000
Message-ID: <AF0FCD08-E014-4D29-B023-EA780056DBB5@fb.com>
References: <20181010104559.GO5728@hirez.programming.kicks-ass.net>
 <3a738a08-2295-a4e9-dce7-a3e2b2ad794e@linux.intel.com>
 <20181015083448.GN9867@hirez.programming.kicks-ass.net>
In-Reply-To: <20181015083448.GN9867@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.9.1)
x-originating-ip: [2620:10d:c090:200::4:2a22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1391;20:k4MzRfvLEA9PJeivLqCNC56CQeJ5ZInw2ZGb62qJ7B0UE5PUCytQ5+iTVKQ//dxmi3PNUY0wHg9ofQKgpMQRRy/QYrL0yKlzOMVPQQ7PnMffiUttNlsBxn6+sKSKrxH1KCviDDde7xj1fgdi1SrbvK9wUcfq1vxRsCq1paihFM0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9f425410-10f7-4327-e803-08d632ead2c3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1391;
x-ms-traffictypediagnostic: MWHPR15MB1391:
x-microsoft-antispam-prvs: <MWHPR15MB13910232F537D5CE713CA158B3FD0@MWHPR15MB1391.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72170088055959);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(11241501184)(944501410)(52105095)(3002001)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991067);SRVR:MWHPR15MB1391;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1391;
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(136003)(346002)(366004)(199004)(189003)(53754006)(50226002)(2616005)(446003)(186003)(486006)(97736004)(11346002)(46003)(68736007)(33656002)(476003)(229853002)(105586002)(6512007)(6116002)(53936002)(5250100002)(106356001)(6486002)(81166006)(2906002)(7416002)(6436002)(5660300001)(8676002)(316002)(14454004)(8936002)(81156014)(82746002)(4326008)(25786009)(6246003)(7736002)(6916009)(102836004)(478600001)(6506007)(54906003)(99286004)(76176011)(2900100001)(53546011)(57306001)(86362001)(71190400001)(71200400001)(14444005)(256004)(36756003)(305945005)(83716004)(21314002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1391;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: U/qhNQqqjY14cDjzyXhKct2hNQyjK7db4edwRArz/wQ5JE7pmtopQkf30BRGYFzIz53vFPTgt7nBWDrU7iNw7s8LRkvThM3WFSHP+bMBZv4Tjy7AxRit2k1TKt2R4f8vr2CLLePcwEH2G79WIi9UEmvPoNvyPgX4dt4T8MaEObneE9ZvLAGN2T8rFjk3eL8xvFDiN3gQDf5fZ6lo0spG2wimlB7t/NowwQazLmCe+WT5Bh27dGUkmMPHSa1mt66NoG7PO4HHWGJApZZdXhajWpOxx5nDk6ZcErptFTN0lBaGxCcLCHuR2jLuFWfPwWUtxHVlLpgB0sAev8j8qtIzlOcOeeHbdKuri2SsWwMNhzI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BAB7A45BFFE1B548AD425F0BF87214FA@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f425410-10f7-4327-e803-08d632ead2c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 22:09:05.6651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1391
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-15_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 15, 2018, at 1:34 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Mon, Oct 15, 2018 at 10:26:06AM +0300, Alexey Budankov wrote:
>> Hi,
>>=20
>> On 10.10.2018 13:45, Peter Zijlstra wrote:
>>> Hi all,
>>>=20
>>> There have been various issues and limitations with the way perf uses
>>> (task) contexts to track events. Most notable is the single hardware PM=
U
>>> task context, which has resulted in a number of yucky things (both
>>> proposed and merged).
>>>=20
>>> Notably:
>>>=20
>>> - HW breakpoint PMU
>>> - ARM big.little PMU
>>> - Intel Branch Monitoring PMU
>>>=20
>>> Since we now track the events in RB trees, we can 'simply' add a pmu
>>> order to them and have them grouped that way, reducing to a single
>>> context. Of course, reality never quite works out that simple, and belo=
w
>>> ends up adding an intermediate data structure to bridge the context ->
>>> pmu mapping.
>>>=20
>>> Something a little like:
>>>=20
>>>              ,------------------------[1:n]---------------------.
>>>              V                                                  V
>>>    perf_event_context <-[1:n]-> perf_event_pmu_context <--- perf_event
>>>              ^                      ^     |                     |
>>>              `--------[1:n]---------'     `-[n:1]-> pmu <-[1:n]-'
>>>=20
>>> This patch builds (provided you disable CGROUP_PERF), boots and survive=
s
>>> perf-top without the machine catching fire.
>>>=20
>>> There's still a fair bit of loose ends (look for XXX), but I think this
>>> is the direction we should be going.
>>>=20
>>> Comments?
>>>=20
>>> Not-Quite-Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>> ---
>>> arch/powerpc/perf/core-book3s.c |    4=20
>>> arch/x86/events/core.c          |    4=20
>>> arch/x86/events/intel/core.c    |    6=20
>>> arch/x86/events/intel/ds.c      |    6=20
>>> arch/x86/events/intel/lbr.c     |   16=20
>>> arch/x86/events/perf_event.h    |    6=20
>>> include/linux/perf_event.h      |   80 +-
>>> include/linux/sched.h           |    2=20
>>> kernel/events/core.c            | 1412 ++++++++++++++++++++------------=
--------
>>> 9 files changed, 815 insertions(+), 721 deletions(-)
>>=20
>> Rewrite is impressive however it doesn't result in code base reduction a=
s it is.
>=20
> Yeah.. that seems to be nature of these things ..
>=20
>> Nonetheless there is a clear demand for per pmu events groups tracking a=
nd rotation=20
>> in single cpu context (HW breakpoints, ARM big.little, Intel LBRs) and t=
here is=20
>> a supply thru groups ordering on RB-tree.
>>=20
>> This might be driven into the kernel by some new Perf features that woul=
d base on=20
>> that RB-tree groups ordering or by refactoring of existing code but in t=
he way it=20
>> would result in overall code base reduction thus lowering support cost.
>=20
> If you have a concrete suggestion on how to reduce complexity? I tried,
> but couldn't find any (without breaking something).
>=20
> The active lists and pmu_ctx_list could arguably be replaced with
> (slower) iteratons over the RB tree, but you'll still need the per pmu
> nr_events/nr_active counts to determine if rotation is required at all.
>=20
> And like you know, performance is quite important here too. I'd love to
> reduce complexity while maintaining or improve performance, but that
> rarely if ever happens :/

How about this:=20

1. Keep multiple perf_cpu_context per CPU, just like before this patch.=20

2. For perf_event_context, add PMU as an order for the RB tree.=20

3. (hw) pmu->perf_cpu_context->ctx only has events for this PMU (and sw=20
   events moved to this context).

4. task->perf_event_ctxp has events for all PMUs.=20

With this path, we keep the existing perf_cpu_context/perf_event_context
logic as-is, which I think is simp=10ler than the new logic (with extra
*_pmu_context). And it should also solve the problem.=20

Does this make sense? If this doesn't look too broken, I am happy to
draft RFC for it.=20

Thanks,
Song

