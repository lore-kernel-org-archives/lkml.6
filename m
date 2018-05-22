Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753237AbeEVWAf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 18:00:35 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43848 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753023AbeEVWAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 18:00:33 -0400
From: Song Liu <songliubraving@fb.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Kernel Team <Kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] perf: fix group with mixed hw and sw events
Thread-Topic: [PATCH] perf: fix group with mixed hw and sw events
Thread-Index: AQHT4xfMnYhufb63+UC4PYAV0shgOaQ8aisA
Date: Tue, 22 May 2018 21:59:39 +0000
Message-ID: <960090D7-5F81-486E-B00F-ED9411A5A094@fb.com>
References: <20180503194716.162815-1-songliubraving@fb.com>
In-Reply-To: <20180503194716.162815-1-songliubraving@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.6.18)
x-originating-ip: [2620:10d:c090:200::5:2c8f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR15MB1660;7:qYqAiDLItQ60jLQyc5sPS4gxvtL7FwlUrLg9l3Ty9AG3Zg214LylJxo1RzlWXbUkfhtkzgI/xS0svbTHA8OKrcmGdnlG58F/993bt8seZxiJEc7rkRvC2FvocKdqkZ/tivmq5v9dfPl4BL6lHrCtdJmHVl22YxV7L08vsh9TgaYMJW2gECFbvsCXLi36b2YTIh2HzXZNUJAU3mEcfySEU3caUI8NmGk/n5G/mG24cwhr9iWxQxD7F9jb6ZmE7/9H;20:sPN8TDhmLeC/PNFLBSXDtZfqdUxhc2ll9dPeZFHGdeeU3cvz/3eR0Ng4aNtYF5Y/hJE9klWQ4hTmOzvsduh0gpXgUZjWtFEJlxxLMwA75CWn9Yee7nB2VhzyqAcjwJUK5smjkoOHtxJ0k6QaVr8Kdx5ual40SD13Ld64wZTXk3w=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR15MB1660;
x-ms-traffictypediagnostic: DM5PR15MB1660:
x-microsoft-antispam-prvs: <DM5PR15MB1660B9AA0F8C187F6C93063EB3940@DM5PR15MB1660.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(11241501184)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM5PR15MB1660;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1660;
x-forefront-prvs: 0680FADD48
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(376002)(346002)(39380400002)(189003)(199004)(54906003)(2501003)(14454004)(83716003)(186003)(5250100002)(102836004)(5890100001)(82746002)(2906002)(50226002)(36756003)(8936002)(6916009)(5660300001)(305945005)(7736002)(46003)(25786009)(6506007)(105586002)(6116002)(86362001)(6512007)(53546011)(3660700001)(97736004)(33656002)(57306001)(53936002)(6436002)(316002)(2351001)(81166006)(99286004)(81156014)(478600001)(229853002)(106356001)(76176011)(486006)(2900100001)(4326008)(11346002)(413944005)(3280700002)(2616005)(476003)(5640700003)(68736007)(6486002)(6246003)(446003)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1660;H:DM5PR15MB1548.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: DzMp/dwpU7oBJCmzPwsiLMXfJtb5ncKjyNg+OtDWE+QK7UO6ae6Fm8gtjdHtA7myn1RBWMtnNoWNnnal+hGKoAymWdaigQ6ni6S7t/FowaTykFJdTKT1woSSoKfPKsTEzz4kdj1AaMH1qmSrH5CQst9AWGx+bI60Tjh/Hf1HEQNAX9BfudslLsaSEQB6HMpk
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0D7CCBE8314C2D4F86A5CD39B9EE03F4@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 6ca52bc8-f476-458f-bfa2-08d5c02f50dc
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca52bc8-f476-458f-bfa2-08d5c02f50dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2018 21:59:39.4495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1660
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-22_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4MM0e3T006521

Dear Peter,

Could you please share your comments on this minor fix?

Best,
Song


> On May 3, 2018, at 12:47 PM, Song Liu <songliubraving@fb.com> wrote:
> 
> When hw and sw events are mixed in the same group, they are all attached
> to the hw perf_event_context. This sometimes requires moving group of
> perf_event to a different context. We found an issue in the moving. Here
> is an example of it.
> 
>   perf stat -e '{faults,ref-cycles,faults}'  -I 1000
> 
>     1.005591180              1,297      faults
>     1.005591180        457,476,576      ref-cycles
>     1.005591180    <not supported>      faults
> 
> First, sw event "faults" is attached to the sw context, and become the
> group leader. Then, hw event "ref-cycles" is attached, so both events
> are moved to hw context. Last, another sw "faults" tries to attach,
> but it fails because of mismatch between the new target ctx (from sw
> pmu) and the group_leader's ctx (hw context, same as ref-cycles).
> 
> The broken condition is:
>   group_leader is sw event;
>   group_leader is on hw context;
>   add a sw event to the group.
> 
> This patch fixes this scenario by checking group_leader's context
> (instead of just event type). If group_leader is on hw context, use
> pmu of this context to look up context for the new event.
> 
> Fixes: b04243ef7006 ("perf: Complete software pmu grouping")
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
> include/linux/perf_event.h |  8 ++++++++
> kernel/events/core.c       | 21 +++++++++++----------
> 2 files changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index e71e99e..def866f 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1016,6 +1016,14 @@ static inline int is_software_event(struct perf_event *event)
> 	return event->event_caps & PERF_EV_CAP_SOFTWARE;
> }
> 
> +/*
> + * Return 1 for event in sw context, 0 for event in hw context
> + */
> +static inline int in_software_context(struct perf_event *event)
> +{
> +	return event->ctx->pmu->task_ctx_nr == perf_sw_context;
> +}
> +
> extern struct static_key perf_swevent_enabled[PERF_COUNT_SW_MAX];
> 
> extern void ___perf_sw_event(u32, u64, struct pt_regs *, u64);
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 67612ce..ce6aa5f 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10521,19 +10521,20 @@ SYSCALL_DEFINE5(perf_event_open,
> 	if (pmu->task_ctx_nr == perf_sw_context)
> 		event->event_caps |= PERF_EV_CAP_SOFTWARE;
> 
> -	if (group_leader &&
> -	    (is_software_event(event) != is_software_event(group_leader))) {
> -		if (is_software_event(event)) {
> +	if (group_leader) {
> +		if (is_software_event(event) &&
> +		    !in_software_context(group_leader)) {
> 			/*
> -			 * If event and group_leader are not both a software
> -			 * event, and event is, then group leader is not.
> +			 * If the event is a sw event, but the group_leader
> +			 * is on hw context.
> 			 *
> -			 * Allow the addition of software events to !software
> -			 * groups, this is safe because software events never
> -			 * fail to schedule.
> +			 * Allow the addition of software events to hw
> +			 * groups, this is safe because software events
> +			 * never fail to schedule.
> 			 */
> -			pmu = group_leader->pmu;
> -		} else if (is_software_event(group_leader) &&
> +			pmu = group_leader->ctx->pmu;
> +		} else if (!is_software_event(event) &&
> +			   is_software_event(group_leader) &&
> 			   (group_leader->group_caps & PERF_EV_CAP_SOFTWARE)) {
> 			/*
> 			 * In case the group is a pure software group, and we
> -- 
> 2.9.5
> 
