Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751780AbeCNVbS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 17:31:18 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54768 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750779AbeCNVbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 17:31:14 -0400
From: Song Liu <songliubraving@fb.com>
To: LKML <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jolsa@redhat.com" <jolsa@redhat.com>
CC: Kernel Team <Kernel-team@fb.com>, Ephraim Park <ephiepark@fb.com>
Subject: Re: [PATCH v2] perf: update perf_cgroup time for ancestor cgroup(s)
Thread-Topic: [PATCH v2] perf: update perf_cgroup time for ancestor cgroup(s)
Thread-Index: AQHTuiObtKE3IWr0GUeWD+gmr8hDj6PQQy0A
Date: Wed, 14 Mar 2018 21:30:53 +0000
Message-ID: <B3C675EC-C458-4A15-B91D-5B17E3D6319C@fb.com>
References: <20180312165943.1057894-1-songliubraving@fb.com>
In-Reply-To: <20180312165943.1057894-1-songliubraving@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.5.20)
x-originating-ip: [2620:10d:c090:200::6:edec]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR15MB1178;20:1SCF33TQXntc9A0RlEBMlWGzxaF0MOhIxiBHJDCesnHV09x6g28wW87CGrlWIGzIVcjfvsnd8BQyPwN/UxsTHE0REN018n0YR4CgHTb3BlujP9kVSYnnKlcSsdtQBYf0Mhw/PvfD1o2NEddd6KJGSYWnK31QYGLVt1ANQMHN9oI=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-correlation-id: e73ddd71-5496-4bf3-ff06-08d589f2ddaa
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR15MB1178;
x-ms-traffictypediagnostic: DM5PR15MB1178:
x-microsoft-antispam-prvs: <DM5PR15MB117849E5C80979CEFD5952E8B3D10@DM5PR15MB1178.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231221)(11241501184)(944501269)(52105095)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR15MB1178;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1178;
x-forefront-prvs: 0611A21987
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(39380400002)(346002)(376002)(199004)(189003)(53936002)(4326008)(3280700002)(5890100001)(229853002)(82746002)(25786009)(6512007)(46003)(2201001)(316002)(478600001)(54906003)(14454004)(86362001)(83716003)(110136005)(50226002)(2501003)(8936002)(106356001)(5660300001)(5250100002)(57306001)(97736004)(76176011)(102836004)(105586002)(36756003)(6506007)(6246003)(8676002)(6116002)(68736007)(81156014)(2950100002)(15650500001)(305945005)(59450400001)(413944005)(2906002)(7736002)(186003)(6436002)(81166006)(33656002)(2900100001)(6486002)(99286004)(53546011)(3660700001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1178;H:DM5PR15MB1548.namprd15.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: OrOMUkZJbJb2lE9EKwcCr1qQZkbQOdFUCleWrsb3sIIId9RmqIbs36/6aqsHFg1a7qv9WrYBN7myp4tbmT2+XprNEiPApX1byFmzXcxJyzUDMDblqWQZFIPSHPyqpIeKlGAEdBGIttjj1JJTh8gTumnpQsumW1F+p4hKSLPNILRbWxygTdW9SJDkdKIlkc5lWZl8aZoAZIZczU7gGPkOVXkKjHyr0u/T5XeA+kIdYgfWWlZ43nycMJDQH8S0+wD741BtIB5r+MQJzRC5B+0SavsQe492Fmz88FN1piikHods/QdBMDfnU0iyOYIS1Vs5HryOg7fbRGgfFOTWGSoytw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BAD2808A72EF8440B4563903798BEF70@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e73ddd71-5496-4bf3-ff06-08d589f2ddaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2018 21:30:53.5605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1178
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-14_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2ELVMmU008186

Dear Peter, 

Could you please share your comments/suggestions on this patch? We would
like to fix this issue in our kernel, as we are using perf events with 
nested cgroups. 

Thanks,
Song

> On Mar 12, 2018, at 9:59 AM, Song Liu <songliubraving@fb.com> wrote:
> 
> When a perf_event is attached to parent cgroup, it should count events
> for all children cgroups:
> 
> parent_group   <---- perf_event
>   \
>    - child_group  <---- process(es)
> 
> However, in our tests, we found this perf_event cannot report reliable
> results. Here is an example case:
> 
>  # create cgroups
>  mkdir -p /sys/fs/cgroup/p/c
>  # start perf for parent group
>  perf stat -e instructions -G "p"
> 
>  # on another console, run test process in child cgroup:
>  stressapptest -s 2 -M 1000 & echo $! > /sys/fs/cgroup/p/c/cgroup.procs
> 
>  # after the test process is done, stop perf in the first console shows
> 
>       <not counted>      instructions              p
> 
> The instruction should not be "not counted" as the process runs in the
> child cgroup.
> 
> We found this is because perf_event->cgrp and cpuctx->cgrp are not
> identical, thus perf_event->cgrp are not updated properly.
> 
> This patch fixes this by updating perf_cgroup properly for ancestor
> cgroup(s).
> 
> Signed-off-by: Song Liu <songliubraving@fb.com>
> Reported-by: Ephraim Park <ephiepark@fb.com>
> ---
> kernel/events/core.c | 20 +++++++++++++++-----
> 1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 5789810..6f015ff 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -724,9 +724,14 @@ static inline void __update_cgrp_time(struct perf_cgroup *cgrp)
> 
> static inline void update_cgrp_time_from_cpuctx(struct perf_cpu_context *cpuctx)
> {
> -	struct perf_cgroup *cgrp_out = cpuctx->cgrp;
> -	if (cgrp_out)
> -		__update_cgrp_time(cgrp_out);
> +	struct perf_cgroup *cgrp = cpuctx->cgrp;
> +	struct cgroup_subsys_state *css;
> +
> +	if (cgrp)
> +		for (css = &cgrp->css; css; css = css->parent) {
> +			cgrp = container_of(css, struct perf_cgroup, css);
> +			__update_cgrp_time(cgrp);
> +		}
> }
> 
> static inline void update_cgrp_time_from_event(struct perf_event *event)
> @@ -754,6 +759,7 @@ perf_cgroup_set_timestamp(struct task_struct *task,
> {
> 	struct perf_cgroup *cgrp;
> 	struct perf_cgroup_info *info;
> +	struct cgroup_subsys_state *css;
> 
> 	/*
> 	 * ctx->lock held by caller
> @@ -764,8 +770,12 @@ perf_cgroup_set_timestamp(struct task_struct *task,
> 		return;
> 
> 	cgrp = perf_cgroup_from_task(task, ctx);
> -	info = this_cpu_ptr(cgrp->info);
> -	info->timestamp = ctx->timestamp;
> +
> +	for (css = &cgrp->css; css; css = css->parent) {
> +		cgrp = container_of(css, struct perf_cgroup, css);
> +		info = this_cpu_ptr(cgrp->info);
> +		info->timestamp = ctx->timestamp;
> +	}
> }
> 
> static DEFINE_PER_CPU(struct list_head, cgrp_cpuctx_list);
> -- 
> 2.9.5
> 
