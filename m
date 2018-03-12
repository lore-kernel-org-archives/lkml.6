Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932252AbeCLOwr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 10:52:47 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55502 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751780AbeCLOwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 10:52:43 -0400
From: Song Liu <songliubraving@fb.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: LKML <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        "Kernel Team" <Kernel-team@fb.com>, Ephraim Park <ephiepark@fb.com>,
        Tejun Heo <tj@kernel.org>, Stephane Eranian <eranian@google.com>,
        Lin Xiulei <linxiulei@gmail.com>
Subject: Re: [PATCH] perf: update perf_cgroup time for ancestor cgroup(s)
Thread-Topic: [PATCH] perf: update perf_cgroup time for ancestor cgroup(s)
Thread-Index: AQHTucOe7ziRzRNPqkGX+Gl8VBh5sKPMin4AgAAlZQA=
Date: Mon, 12 Mar 2018 14:52:15 +0000
Message-ID: <36C68BD5-8FF4-4D2D-B35A-A94393EF6E24@fb.com>
References: <20180312053244.2593974-1-songliubraving@fb.com>
 <20180312123824.GF4064@hirez.programming.kicks-ass.net>
In-Reply-To: <20180312123824.GF4064@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.5.20)
x-originating-ip: [199.201.64.3]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR15MB1690;7:DouQzWcdm80RFrPwMHkVmFuxayUMv/SveIUYNAeko2qKsByrhqQNbCreUiioqmFdUGjFfWvG+6yQRqovrnSJz0EU1IEQau+liWQkcwJeUnpeykpW/epFvELihLArF6FCmthHyH3vopSf68DwIrg3K0vxS8IKzcLYlocnjbRv8PUYIOnf+JGOvE3/E1EdbgVCJ6F2Ef8FgpCDavA4KS3q+J07MqhtF8/W30k3q1ZcMcuWXmBtfzOrhjUwnxKXPM9A;20:srcTICowrb8a/cveOHSe8OcF4NhDr7Ad/lEL3phRlQ7SoOfjs9Kl06DkL7wzuWugpO+46FcBFztWfYvv+JZW1R4bb2y74acjtRVVDkXvdz175AqFJqM5onSGrDem7/nUhoamNv55MYDOexFzH7EoWcmvX9zzkS9GIX2Z0rq16yY=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-correlation-id: 0ba6c893-713f-41af-22d9-08d58828d842
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR15MB1690;
x-ms-traffictypediagnostic: DM5PR15MB1690:
x-microsoft-antispam-prvs: <DM5PR15MB1690610D76EA472FA35DFD5BB3D30@DM5PR15MB1690.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231220)(11241501184)(944501244)(52105095)(10201501046)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR15MB1690;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1690;
x-forefront-prvs: 06098A2863
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(39380400002)(376002)(366004)(189003)(199004)(83716003)(99286004)(5250100002)(68736007)(6916009)(2906002)(2950100002)(86362001)(3280700002)(3660700001)(6246003)(53936002)(6512007)(81166006)(8676002)(81156014)(76176011)(316002)(5890100001)(229853002)(66066001)(186003)(57306001)(36756003)(6116002)(3846002)(59450400001)(26005)(53546011)(15650500001)(102836004)(6506007)(7736002)(14454004)(97736004)(478600001)(54906003)(105586002)(33656002)(305945005)(2900100001)(106356001)(8936002)(6486002)(6436002)(4326008)(25786009)(39060400002)(5660300001)(50226002)(82746002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1690;H:DM5PR15MB1548.namprd15.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: MOYPbh0tgJ6zKo5Iz3kVnAWuxVtolsKOi9LA+Mt7Ah2sWg0PV4J3Shk8rD1Pd/HxChkaRn2d3aR8DlLOLM7Qj/MrkdyMe+Vn7FPN3LNyK5Aw3hfqTURODPQVyR1akBWP/IbJiJipawNSrhxMPO4VOMsQIO42tT4NfjfI3/I7+SqpwXodZaxrgCBFBddppeSXSd4ZwK9CHJpzEWSqpLoG3cQ/BfSFFEw0kuO3jVLJF7fwgGKYikzJONWtJg4unwtngb3bJ7Ma99qsZxsMXAdSBF9alAwGkyMIumselSMDaEg60k1SOwZ8tkamtthtrfzGC3vIuKKJqI5HhwDHgpk90A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DA54107B526CAB438FB87F614634375C@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba6c893-713f-41af-22d9-08d58828d842
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2018 14:52:15.0294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1690
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-12_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2CEqoRS019760



> On Mar 12, 2018, at 5:38 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> On Sun, Mar 11, 2018 at 10:32:44PM -0700, Song Liu wrote:
>> When a perf_event is attached to parent cgroup, it should count events
>> for all children cgroups:
>> 
>> parent_group   <---- perf_event
>>   \
>>    - child_group  <---- process(es)
>> 
>> However, in our tests, we found this perf_event cannot report reliable
>> results. This is because perf_event->cgrp and cpuctx->cgrp are not
>> identical, thus perf_event->cgrp are not updated properly.
> 
> It might help now and in for our older selves, if you could provide a
> simple reproducer for this.

I will add a repro to v2. 

> 
>> Signed-off-by: Song Liu <songliubraving@fb.com>
>> Reported-by: Ephraim Park <ephiepark@fb.com>
>> ---
>> kernel/events/core.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>> 1 file changed, 67 insertions(+), 1 deletion(-)
>> 
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 5789810..623d38f 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
> 
>> @@ -766,6 +821,17 @@ perf_cgroup_set_timestamp(struct task_struct *task,
>> 	cgrp = perf_cgroup_from_task(task, ctx);
>> 	info = this_cpu_ptr(cgrp->info);
>> 	info->timestamp = ctx->timestamp;
>> +
>> +	/* set timestamp for ancestor cgroups */
>> +	if (cgrp->css.cgroup->level > 1) {
>> +		struct perf_cgroup_info *info = this_cpu_ptr(cgrp->info);
>> +		struct perf_event *event;
>> +
>> +		list_for_each_entry(event, &ctx->pinned_groups, group_entry)
>> +			perf_ancestor_cgroup_set_timestamp(event, cgrp, info);
>> +		list_for_each_entry(event, &ctx->flexible_groups, group_entry)
>> +			perf_ancestor_cgroup_set_timestamp(event, cgrp, info);
>> +	}
>> }
> 
> That doesn't make any kind of sense... if we're interested in ancestor
> groups, then WTH are you iterating _events_ ?
> 
> I'm expecting something like:
> 
> 	struct cgroup_subsys_state *css;
> 
> 	for (css = cgrp->css; css; css = css->parent) {
> 		/* fudge time */
> 	}

I guess this is what I have been looking for! Thanks Peter! 

V2 coming soon...

Song
