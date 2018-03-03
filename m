Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752152AbeCCQni (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 11:43:38 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54136 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752091AbeCCQnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 11:43:37 -0500
From: Song Liu <songliubraving@fb.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [RFC] perf: a different approach to perf_rotate_context()
Thread-Topic: [RFC] perf: a different approach to perf_rotate_context()
Thread-Index: AQHTsZcV+ejFiFHeiEK2h1wCYdO9K6O+pNSAgAAVcYA=
Date: Sat, 3 Mar 2018 16:43:16 +0000
Message-ID: <E3827285-28C6-4CFD-9990-1FA922CC792C@fb.com>
References: <20180301195321.2608515-1-songliubraving@fb.com>
 <20180303152631.GF25201@hirez.programming.kicks-ass.net>
In-Reply-To: <20180303152631.GF25201@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.5.20)
x-originating-ip: [2620:10d:c090:180::1:8f4]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR15MB1131;7:Fs8Rssrci3T1lLMefpjBcDc4kJOakAg+uy7l+j7h+zozEZM0yBxjJmqDdd7prr68oNMYNS4LhuuPcljjvu3vHGTJewGJvefI3oN0vWRPw/L4b8/MYSZvggeKB8rCvXhM4EpA4+wfd1kCSAgmdixk/t3YvNBa4W3sOyHi6FNFnuYieZ50bEMymSqVlkvymcf/7lJhE1/c1QRGMuJcKBeE4fUsX03v/b5GVmL69+6o5I9C2qiNCtCY/YLkyqA1XZSL;20:h9diGDxksEJTstEoV17mafLUEhSueoUoLyuMPT0vq/eANhfNYeM8vKXf20UcsRmqRucaNvlIgxWehvdsbNy5It4X426OCQbRSBwZOPjG9TPLzpmYgOtKTKlzyd9k1h/2b6qO1ARq3ZGao3Fub9iY+vawkaNQjEn53pG7uhU3IrA=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 0ed63fd6-a740-4c1c-db56-08d58125dd1e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:DM5PR15MB1131;
x-ms-traffictypediagnostic: DM5PR15MB1131:
x-microsoft-antispam-prvs: <DM5PR15MB1131814497C313640F89B1BAB3C40@DM5PR15MB1131.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(84791874153150);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231220)(11241501184)(944501244)(52105095)(10201501046)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR15MB1131;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1131;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(366004)(376002)(346002)(51914003)(199004)(189003)(2906002)(2900100001)(102836004)(2950100002)(5660300001)(6916009)(82746002)(7736002)(305945005)(6116002)(229853002)(57306001)(54906003)(76176011)(99286004)(33656002)(6506007)(53546011)(14454004)(5250100002)(478600001)(966005)(46003)(5890100001)(105586002)(3280700002)(6512007)(6306002)(6436002)(6246003)(50226002)(53936002)(8936002)(81156014)(81166006)(8676002)(83716003)(6486002)(316002)(36756003)(186003)(106356001)(68736007)(86362001)(97736004)(3660700001)(25786009)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1131;H:DM5PR15MB1548.namprd15.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 9Qh6Npt4koheXr/vGTmlvmvQiFalJIlfPP271N4jIiXIO4LBh8OUISQUamnpM3yStXbyjisYhNhBnco/+4Xc2oMQ1wKGwz45dORJyxXhXk1rzG6ZkXPF5L+2EHNHx1anI/ImMV6RkmkqFz0sF+GQHzP0Pzwl5a2cwyOMKDrNOEQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6ED8567BC3011B4FAE853177E9A8228D@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed63fd6-a740-4c1c-db56-08d58125dd1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 16:43:16.5103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1131
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-03_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w23GhjcH026957



> On Mar 3, 2018, at 7:26 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> On Thu, Mar 01, 2018 at 11:53:21AM -0800, Song Liu wrote:
>> When there are more perf_event's than hardware PMCs, perf rotate events
>> so that all events get chance to run. Currently, the rotation works as:
>>  sched_out flexible_groups in cpuctx->ctx and cpuctx->task_ctx;
>>  rotate_left flexible_groups in cpuctx->ctx and cpuctx->task_ctx;
>>  try sched_in flexible_groups in cpuctx->ctx;
>>  try sched_in flexible_groups in cpuctx->task_ctx.
>> 
>> This approach has some potential issues:
>>  1. if different rotations of flexible_groups in cpuctx->ctx occupy
>>     all hardware PMC, flexible_groups in cpuctx->task_ctx cannot run
>>     at all.
>>  2. if pinned_groups occupy all hardware PMC, the rotation triggers per
>>     perf_event_mux_interval_ms. But it couldn't schedule any events.
>>  3. since flexible_groups in cpuctx->ctx and cpuctx->task_ctx are
>>     rotated separately, there are N x M possible combinations. It is
>>     difficult to remember all the rotation combinations and reuse these
>>     combinations. As a result, it is necessary to try sched_in the
>>     flexible_groups on each rotation.
>> 
>> This patch tries to do the rotation differently. Each perf_event in the
>> cpuctx (ctx and task_ctx) is assigned a rotation_id. The rotation_id's
>> are assigned during the first few rotations after any changes in
>> perf_events attached to the cpuctx. Once all the rotation_id's are
>> assigned for all events in the cpuctx, perf_rotate_context() simply
>> picks the next rotation to use, so there is no more "try to sched_in"
>> for future rotations.
> 
> I'm not following.

Let me try explain it in different words. The main goal of this approach 
is to pre-compute all the rotations, so perf_event scheduling is less
expensive. It does change current scheduling mechanism, by introducing 
rotation_id to each event. With rotation_id, all events in the 
flexible_groups have exactly same chance to run: 
   if num_rotations == 2, all flexible event runs 50% of time;
   if num_rotations == 3, all flexible event runs 33% of time;
etc.


>> Special rotation_id's are introduced to handle the issues above.
>> flexible_groups that conflicts with pinned_groups are marked as
>> ALWAYS_OFF, so they are not rotated (fixes issue 2). flexible_groups
>> in cpuctx->ctx and cpuctx->task_ctx are rotated together, so they all get
>> equal chance to run (improves issue 1).
> 
> I can't say I particularly care about 2, that's a really daft situation
> to get into. And changing 1 needs careful consideration.
> 
>> With this approach, we only do complex scheduling of flexible_groups
>> once. This enables us to do more complex schduling, for example, Sharing
>> PMU counters across compatible events:
>>   https://lkml.org/lkml/2017/12/1/410.
>> 
>> There are also some potential downsides of this approach.
>> 
>> First, it gives all flexible_groups exactly same chance to run, so it
>> may waste some PMC cycles. For examples, if 5 groups, ABCDE, are assigned
>> to two rotations: rotation-0: ABCD and rotation-1: E, this approach will
>> NOT try any of ABCD in rotation-1.
> 
> Yeah, that doesn't look acceptable. In fact, people already complained
> about the current scheme not being optimal, what you propose is _far_
> worse.

I agree this is an issue. Our initial goal is to get more events running
with PMU sharing (Tejun's RFC). However, I found the sharing is difficult 
to implement with current scheduling scheme. This RFC tries to pave the 
road for PMU sharing. If there are other ways (virtual time based 
scheduler, etc.) that make PMU sharing possible, we will be happy to start
from those. 

>> Second, flexible_groups in cpuctx->ctx and cpuctx->task_ctx now have
>> exact same priority and equal chance to run. I am not sure whether this
>> will change the behavior in some use cases.
>> 
>> Please kindly let me know whether this approach makes sense.
> 
> What you've not said is, and what is not at all clear, is if your scheme
> preserved fairness.

This approach gives all events in ctx->flexible_groups and 
task_ctx->flexible_groups exactly same chance to run. I am not sure whether 
that is acceptable in term of fairness. 

> 
> 
> In any case, there's a ton of conflict against the patches here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=perf/testing
> 
> And with those the idea was to move to a virtual time based scheduler
> (basically schedule those flexible events that have the biggest lag --
> that also solves 1).

Thanks for these information. I will study this approach. Maybe that is 
our path to PMU sharing. What's is the status of this work? Would it 
land in 4.17? 

Thanks again,
Song
