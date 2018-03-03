Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752150AbeCCQRG (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 11:17:06 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47152 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751898AbeCCQRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 11:17:04 -0500
From: Song Liu <songliubraving@fb.com>
To: Jiri Olsa <jolsa@redhat.com>
CC: LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [RFC] perf: a different approach to perf_rotate_context()
Thread-Topic: [RFC] perf: a different approach to perf_rotate_context()
Thread-Index: AQHTsZcV+ejFiFHeiEK2h1wCYdO9K6O+hwYAgAAryAA=
Date: Sat, 3 Mar 2018 16:16:33 +0000
Message-ID: <F0DB38F8-7A56-4E8B-AEF7-77D9AE71852B@fb.com>
References: <20180301195321.2608515-1-songliubraving@fb.com>
 <20180303133950.GA2704@krava>
In-Reply-To: <20180303133950.GA2704@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.5.20)
x-originating-ip: [199.201.64.3]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR15MB1180;7:s3jpYd38mQPG8vE6XnjUHK1RKhmUSQ7cvwtXbADn3MFuPRDZ63PX1E4vkk+B2BRgo50gdNZTLX1v+t5OSUa+oAQCWpx/HlqVERjRp4xtFehzQg6nqhNLXqUnmjUQnk1KujlhEnhAD0769DzhtG7j8/BocBJKlwVwFBP/0RKSCNJGMOycAiLUxnJIpkEV5Jtt/SMVL9gKonrD71wghKtzKD/xMPyLVOB/wK1ZXgCNz2Cgc8hD2ktiWM3oN0nPRdTp;20:31oDxZdmSlajHy+F2woSkJbpLfpRO4ZZ0tVsC+B+0XtH6GYhGaXHgRj1504p+iNp+teHsyR+Xzc1JM3hNb/Mo02ltgts5ZHuKkledqQ9ziq5pF1ftTIXCbZmcRW4CMNF2pFOqxPLeVh8kEiyYQWryRcVrqDaaawuUmrkvUd3Ths=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: cef6b193-324f-4cd1-6fc3-08d58122218c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:DM5PR15MB1180;
x-ms-traffictypediagnostic: DM5PR15MB1180:
x-microsoft-antispam-prvs: <DM5PR15MB1180E74BDC88910282E1BD14B3C40@DM5PR15MB1180.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(11241501184)(944501244)(52105095)(93006095)(93001095)(10201501046)(6041288)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR15MB1180;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1180;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(376002)(39860400002)(39380400002)(189003)(199004)(6116002)(5660300001)(186003)(86362001)(3846002)(14454004)(2900100001)(99286004)(36756003)(6916009)(478600001)(106356001)(966005)(4326008)(54906003)(33656002)(68736007)(25786009)(316002)(26005)(7736002)(2950100002)(105586002)(8676002)(2906002)(97736004)(6246003)(57306001)(81156014)(3660700001)(50226002)(81166006)(6486002)(305945005)(66066001)(6506007)(53546011)(8936002)(83716003)(3280700002)(6436002)(59450400001)(53936002)(5250100002)(229853002)(82746002)(76176011)(6306002)(6512007)(102836004)(5890100001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1180;H:DM5PR15MB1548.namprd15.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: iaajiUxzbjzE+ELwvTJqCCBPJtVY3X09JRbwEsaqHvtLSjv+CwkhIdmzNZ+zwBIiJFtWN7w3A3EbPBfS4hCFSLJpSeXgjKe7kgHTup82grSaTZjRqYTtYtYt6KcvqoaYhZv/+W76Ghcu2Xw7iGyzkhQFVFZiyPMh4l+RP2GtYtE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E5ECBDF360BA2646838A592C83B7D0A7@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cef6b193-324f-4cd1-6fc3-08d58122218c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 16:16:33.3422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1180
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-03_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w23GHAoq019518



> On Mar 3, 2018, at 5:39 AM, Jiri Olsa <jolsa@redhat.com> wrote:
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
>> 
>> Special rotation_id's are introduced to handle the issues above.
>> flexible_groups that conflicts with pinned_groups are marked as
>> ALWAYS_OFF, so they are not rotated (fixes issue 2). flexible_groups
>> in cpuctx->ctx and cpuctx->task_ctx are rotated together, so they all get
>> equal chance to run (improves issue 1).
> 
> hum, so the improvement is that cpuctx could eventually give
> up some space for task_ctx events, but both ctxs still rotate
> separately no? you keep rotation ID per single context..

With this approach, both ctxs are rotated together. It is possible that
cpuctx->ctx only has events for rotation 0, 1; while cpuctx->task_ctx 
only has events for rotation 2, 3. But both of them will rotate among
0, 1, 2, 3. 

num_rotations and curr_rotation could be part of cpuctx, as it is 
eventually shared among two contexts. 

>> 
>> With this approach, we only do complex scheduling of flexible_groups
>> once. This enables us to do more complex schduling, for example, Sharing
>> PMU counters across compatible events:
>>   https://lkml.org/lkml/2017/12/1/410.
> 
> how could this code do that?

We still need a lot more work to get PMU sharing work. I think one of the 
problem with Tejun's RFC is more expensive scheduling. This RFC tries to 
pre-compute all rotations, so we only need to these expensive scheduling 
once. 

> 
>> 
>> There are also some potential downsides of this approach.
>> 
>> First, it gives all flexible_groups exactly same chance to run, so it
>> may waste some PMC cycles. For examples, if 5 groups, ABCDE, are assigned
>> to two rotations: rotation-0: ABCD and rotation-1: E, this approach will
>> NOT try any of ABCD in rotation-1.
>> 
>> Second, flexible_groups in cpuctx->ctx and cpuctx->task_ctx now have
>> exact same priority and equal chance to run. I am not sure whether this
>> will change the behavior in some use cases.
>> 
>> Please kindly let me know whether this approach makes sense.
> 
> SNIP
> 
>> +/*
>> + * identify always_on and always_off groups in flexible_groups, call
>> + * group_sched_in() for always_on groups
>> + */
>> +static void ctx_pick_always_on_off_groups(struct perf_event_context *ctx,
>> +					  struct perf_cpu_context *cpuctx)
>> +{
>> +	struct perf_event *event;
>> +
>> +	list_for_each_entry(event, &ctx->flexible_groups, group_entry) {
>> +		if (event->group_caps & PERF_EV_CAP_SOFTWARE) {
>> +			event->rotation_id = PERF_ROTATION_ID_ALWAYS_ON;
>> +			ctx->nr_sched++;
>> +			WARN_ON(group_sched_in(event, cpuctx, ctx));
>> +			continue;
>> +		}
>> +		if (group_sched_in(event, cpuctx, ctx)) {
>> +			event->rotation_id = PERF_ROTATION_ID_ALWAYS_OFF;
>> +			ctx->nr_sched++;
> 
> should ctx->nr_sched be incremented in the 'else' leg?

The else leg means the event does not conflict with pinned groups, so it 
will be scheduled later in ctx_add_rotation(). This function only handles
always_on and always_off events. 

> 
>> +		}
>> +		group_sched_out(event, cpuctx, ctx);
>> +	}
>> +}
>> +
>> +/* add unassigned flexible_groups to new rotation_id */
>> +static void ctx_add_rotation(struct perf_event_context *ctx,
>> +			     struct perf_cpu_context *cpuctx)
>> {
>> 	struct perf_event *event;
>> +	int group_added = 0;
>> 	int can_add_hw = 1;
>> 
>> +	ctx->curr_rotation = ctx->num_rotations;
>> +	ctx->num_rotations++;
>> +
>> 	list_for_each_entry(event, &ctx->flexible_groups, group_entry) {
>> 		/* Ignore events in OFF or ERROR state */
>> 		if (event->state <= PERF_EVENT_STATE_OFF)
>> @@ -3034,13 +3099,77 @@ ctx_flexible_sched_in(struct perf_event_context *ctx,
>> 		if (!event_filter_match(event))
>> 			continue;
>> 
>> +		if (event->rotation_id != PERF_ROTATION_ID_NOT_ASSGINED)
>> +			continue;
>> +
>> 		if (group_can_go_on(event, cpuctx, can_add_hw)) {
>> 			if (group_sched_in(event, cpuctx, ctx))
>> 				can_add_hw = 0;
>> +			else {
>> +				event->rotation_id = ctx->curr_rotation;
>> +				ctx->nr_sched++;
>> +				group_added++;
> 
> group_added is not used

I should have removed it. Thanks!

> 
> SNIP
> 
>> static int perf_rotate_context(struct perf_cpu_context *cpuctx)
>> {
>> -	struct perf_event_context *ctx = NULL;
>> +	struct perf_event_context *ctx = cpuctx->task_ctx;
>> 	int rotate = 0;
>> +	u64 now;
>> 
>> -	if (cpuctx->ctx.nr_events) {
>> -		if (cpuctx->ctx.nr_events != cpuctx->ctx.nr_active)
>> -			rotate = 1;
>> -	}
>> -
>> -	ctx = cpuctx->task_ctx;
>> -	if (ctx && ctx->nr_events) {
>> -		if (ctx->nr_events != ctx->nr_active)
>> -			rotate = 1;
>> -	}
>> +	if (!flexible_sched_done(cpuctx) ||
>> +	    cpuctx->ctx.num_rotations > 1)
>> +		rotate = 1;
>> 
>> 	if (!rotate)
>> 		goto done;
>> @@ -3382,15 +3492,35 @@ static int perf_rotate_context(struct perf_cpu_context *cpuctx)
>> 	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
>> 	perf_pmu_disable(cpuctx->ctx.pmu);
>> 
>> -	cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
>> +	update_context_time(&cpuctx->ctx);
>> 	if (ctx)
>> -		ctx_sched_out(ctx, cpuctx, EVENT_FLEXIBLE);
>> +		update_context_time(ctx);
>> +	update_cgrp_time_from_cpuctx(cpuctx);
>> 
>> -	rotate_ctx(&cpuctx->ctx);
>> +	ctx_switch_rotation_out(&cpuctx->ctx, cpuctx);
>> 	if (ctx)
>> -		rotate_ctx(ctx);
>> +		ctx_switch_rotation_out(ctx, cpuctx);
>> 
>> -	perf_event_sched_in(cpuctx, ctx, current);
>> +	if (flexible_sched_done(cpuctx)) {
>> +		/* simply repeat previous calculated rotations */
>> +		ctx_switch_rotation_in(&cpuctx->ctx, cpuctx);
>> +		if (ctx)
>> +			ctx_switch_rotation_in(ctx, cpuctx);
>> +	} else {
>> +		/* create new rotation */
>> +		ctx_add_rotation(&cpuctx->ctx, cpuctx);
>> +		if (ctx)
>> +			ctx_add_rotation(ctx, cpuctx);
>> +	}
> 
> that seems messy.. could this be done just by setting
> the rotation ID and let perf_event_sched_in skip over
> different IDs and sched-in/set un-assigned events?

Yeah, that could be a cleaner implementation. 

Thanks,
Song
