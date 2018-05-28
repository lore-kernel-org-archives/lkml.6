Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933183AbeE1SYt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 14:24:49 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:41254 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932268AbeE1SYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 14:24:48 -0400
From: Song Liu <songliubraving@fb.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, "tj@kernel.org" <tj@kernel.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>
Subject: Re: [RFC 2/2] perf: Sharing PMU counters across compatible events
Thread-Topic: [RFC 2/2] perf: Sharing PMU counters across compatible events
Thread-Index: AQHT4/1I0VvljCz19kKJ6lkiWpLgdqRFInuAgAB3rAA=
Date: Mon, 28 May 2018 18:24:09 +0000
Message-ID: <0EA2C468-0D02-45A7-AED0-4298E8BC5D87@fb.com>
References: <20180504231102.2850679-1-songliubraving@fb.com>
 <20180504231102.2850679-3-songliubraving@fb.com>
 <20180528111549.GA3452@worktop.programming.kicks-ass.net>
In-Reply-To: <20180528111549.GA3452@worktop.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.6.18)
x-originating-ip: [2620:10d:c090:180::1:be]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1198;7:nmTvrfTPUUP+s8+cMFNVyX58DvVaLlYlB7neJwIvte6Oeb/DjinUE8nSkE69xaCiqsKlthA2bqaXlWAsvRYe2UvzBpQc9voyd9BQ1jbnksJhD1OCMa14uNDKf2KqtR/mNvuLROy6HTIuNLxiewPEdBAKnB4Am4Y9Tf6ipptM8zoj609Uj4hkAqRxk4/GhQOUhH2ksMOdWadP640iQEEyPP8HokBytigQkXg18XdWQqYX3xTjaBI50E5X39CM06KQ;20:TZpqrVFHxhLbcwr5iGUMEXYHitLPHxBT48ZvXWLvnsjKCb7G+cJJyXhrWm8fCtZUA/FjLSwVgf6YICZixhox6LXJqT0R0zApSkhIRkoERl0nDfPWMGXEw/jMRNFLK4gEd44EaAn9Kf6wJ4rvnb+5FGWiYZGzbxVomVwwYS32pMs=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1198;
x-ms-traffictypediagnostic: MWHPR15MB1198:
x-microsoft-antispam-prvs: <MWHPR15MB119861BABADB6756037CE293B36E0@MWHPR15MB1198.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231254)(11241501184)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:MWHPR15MB1198;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1198;
x-forefront-prvs: 06860EDC7B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(39380400002)(366004)(39860400002)(199004)(189003)(59450400001)(33656002)(6512007)(8936002)(68736007)(2900100001)(53936002)(5660300001)(97736004)(6116002)(2906002)(53546011)(7736002)(105586002)(82746002)(81166006)(99286004)(81156014)(102836004)(76176011)(186003)(305945005)(486006)(8676002)(11346002)(2616005)(46003)(36756003)(4326008)(6506007)(476003)(14454004)(106356001)(229853002)(50226002)(83716003)(54906003)(6436002)(316002)(86362001)(446003)(478600001)(25786009)(57306001)(3660700001)(3280700002)(5250100002)(6486002)(6916009)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1198;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 7fXxT2OMPyDpuRDcSyFe/PMGaRhfOzaD09UZXKL6KVkip9VlFCE6zjdt1QYbQBHAy6IFSzS/rZetlACRPb3HnRO9L1eeNHPwekHJwATzFpcIDwclO8suXUD4+Ljtnd1WH7HmLD9q5gj3R7efTtnJ/5Z6lSAkHcyWAJfVRZQIBYhsdgJeJiy0bHwA6eX5ERzK
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <69A7903FB62B6048B86099DCE7D10102@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 1bf6782b-e972-4dd3-b803-08d5c4c83456
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf6782b-e972-4dd3-b803-08d5c4c83456
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2018 18:24:09.2144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1198
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-28_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4SIPcHM019829



> On May 28, 2018, at 4:15 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> On Fri, May 04, 2018 at 04:11:02PM -0700, Song Liu wrote:
>> Connection among perf_event and perf_event_dup are built with function
>> rebuild_event_dup_list(cpuctx). This function is only called when events
>> are added/removed or when a task is scheduled in/out. So it is not on
>> critical path of perf_rotate_context().
> 
> Why is perf_rotate_context() the only critical path? I would say the
> context switch path is rather critical too.
> 
>> @@ -2919,8 +3014,10 @@ static void ctx_sched_out(struct perf_event_context *ctx,
>> 
>> 	if (ctx->task) {
>> 		WARN_ON_ONCE(cpuctx->task_ctx != ctx);
>> -		if (!ctx->is_active)
>> +		if (!ctx->is_active) {
>> 			cpuctx->task_ctx = NULL;
>> +			rebuild_event_dup_list(cpuctx);
>> +		}
>> 	}
>> 
>> 	/*
> 
>> +static void rebuild_event_dup_list(struct perf_cpu_context *cpuctx)
>> +{
>> +	int dup_count = cpuctx->ctx.nr_events;
>> +	struct perf_event_context *ctx = cpuctx->task_ctx;
>> +	struct sched_in_data sid = {
>> +		.ctx = ctx,
>> +		.cpuctx = cpuctx,
>> +		.can_add_hw = 1,
>> +	};
>> +
>> +	if (ctx)
>> +		dup_count += ctx->nr_events;
>> +
>> +	kfree(cpuctx->dup_event_list);
>> +	cpuctx->dup_event_count = 0;
>> +
>> +	cpuctx->dup_event_list =
>> +		kzalloc(sizeof(struct perf_event_dup) * dup_count, GFP_ATOMIC);
> 
> 
> __schedule()
>  local_irq_disable()
>  raw_spin_lock(rq->lock)
>  context_switch()
>    prepare_task_switch()
>      perf_event_task_sched_out()
>        __perf_event_task_sched_out()
> 	  perf_event_context_sched_out()
> 	    task_ctx_sched_out()
> 	      ctx_sched_out()
> 	        rebuild_event_dup_list()
> 		  kzalloc()
> 		    ...
> 		      spin_lock()
> 
> Also, as per the above, this nests a regular spin lock inside the
> (raw) rq->lock, which is a no-no.
> 
> Not to mention that whole O(n) crud in the scheduling path...

I think we can also fix the scheduling path. To achieve this, we need
to limit the sharing within the ctx. In other words, events in 
cpuctx->ctx can only share PMU with events in cpuctx->ctx, but not 
with events in cpuctx->task_ctx. This will probably also solve the
locking issue here. Let me try it. 

Thanks,
Song
