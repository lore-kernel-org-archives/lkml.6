Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754721AbeE1ST1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 14:19:27 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55566 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750771AbeE1STY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 14:19:24 -0400
From: Song Liu <songliubraving@fb.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, "tj@kernel.org" <tj@kernel.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>
Subject: Re: [RFC 2/2] perf: Sharing PMU counters across compatible events
Thread-Topic: [RFC 2/2] perf: Sharing PMU counters across compatible events
Thread-Index: AQHT4/1I0VvljCz19kKJ6lkiWpLgdqRFJPqAgABzvgA=
Date: Mon, 28 May 2018 18:19:01 +0000
Message-ID: <56FBE4D5-A83C-413D-8EAE-0AE637FFDB05@fb.com>
References: <20180504231102.2850679-1-songliubraving@fb.com>
 <20180504231102.2850679-3-songliubraving@fb.com>
 <20180528112445.GB3452@worktop.programming.kicks-ass.net>
In-Reply-To: <20180528112445.GB3452@worktop.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.6.18)
x-originating-ip: [2620:10d:c090:180::1:be]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1181;7:iMt++HjpN6cBl4bA4r3N3En4ow1PtipgJQM/Leiw/lJypintnjvUW2UOBX+r2bYXeL9WEjy61RVcvriznqPhUfJ3fLK2Mp8C1s+g2qhoIXPEU2KSX+PQ+eoustQ0hZs0cGsw6XpRh9TcSHM81OK6Q5Aubkf4YeHVV4GfFY/qUhCi5RnQlBEeudwwCJPagAJdHkhqqBXlSo4EJVLvopRIN4+gnKx3vUfxAPgMiFzxyOjU1ytnVO0FB4fWQYgTLrVs;20:OXroTGbFYRU1aqdHLyD/ElgviXr4D23lCHRR8RRCORQLjgD+ZvO8raBnw/xq+QvkMCD3/2t+9pe8He7TVQsS/zIduzHRarEWPRM8G/8yHirml2tfsTuOQ0Tfzd3f72Ruz2/nGGuPl+6G3girbtR48q5kEcCegdgMf91PtaScS34=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1181;
x-ms-traffictypediagnostic: MWHPR15MB1181:
x-microsoft-antispam-prvs: <MWHPR15MB1181D00F1361A1AB2FAA6F78B36E0@MWHPR15MB1181.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(11241501184)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:MWHPR15MB1181;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1181;
x-forefront-prvs: 06860EDC7B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(396003)(39380400002)(366004)(376002)(346002)(39860400002)(51914003)(199004)(189003)(25786009)(102836004)(486006)(476003)(76176011)(6506007)(6246003)(446003)(11346002)(53936002)(2906002)(4326008)(2616005)(6116002)(54906003)(82746002)(68736007)(46003)(57306001)(59450400001)(5250100002)(50226002)(81166006)(186003)(53546011)(8936002)(8676002)(2900100001)(81156014)(33656002)(7736002)(229853002)(97736004)(316002)(3280700002)(478600001)(83716003)(99286004)(305945005)(36756003)(6436002)(86362001)(106356001)(14454004)(6916009)(105586002)(5660300001)(3660700001)(6486002)(6512007)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1181;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: dvKsBk6sjSwePcbHDFhGoKqF3qm3jOvtax0dqr1bbi1yTnUSrRyjMGNln0v9cu11h1iygC/4owWLaoC+L96NHQ9a/kSLShMpqCBD9MdAvTWt1gSzTP8EqwfiUgSpvHUzStz/3ns6RsXhUyMAwjwUMLJWEyjQ/p2HcZCYz9bt9L/HUmUMTtRgIF4m1CfDshuC
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2BA2770EFF6B034598FB453168ADBDE6@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 42d977ab-6753-4afb-44af-08d5c4c77ccd
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d977ab-6753-4afb-44af-08d5c4c77ccd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2018 18:19:01.2906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1181
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-28_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4SIJfi6019779

On May 28, 2018, at 4:24 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> On Fri, May 04, 2018 at 04:11:02PM -0700, Song Liu wrote:
>> On the critical paths, perf_events are added to/removed from the
>> active_dup list of the perf_event. The first event added to the list
>> will be the master event, and the only event that runs pmu->add().
>> Later events will all refer to this master for read().
>> 
>>   cpuctx ->  perf_event_dup -> master
>>                     ^       -> active_dup (list)
>>                     |             ^  ^
>>         perf_event /|  ----------/   |
>>                     |                |
>>         perf_event /   -------------/
>> 
> 
>> +static void add_event_to_dup_event_list(struct perf_event *event,
>> +					struct perf_cpu_context *cpuctx)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < cpuctx->dup_event_count; ++i)
>> +		if (memcmp(&event->attr,
>> +			   &cpuctx->dup_event_list[i].first->attr,
>> +			   sizeof(event->attr)) == 0) {
>> +			event->dup_id = i;
>> +			return;
>> +		}
> 
> (style nit: this needs {})
> 
> So we merge events when the attr's are an exact match; which includes
> sampling and all those fancy things, right?

I think we will need better analysis on which events could share the 
same PMU. I will refine it in the next version. 

> 
> I think this scheme causes phase shifts in the samples when we combine
> two otherwise identical events. Because while they have the same
> sampling interval, they might not have the same effective runtime and
> thus have a different 'remainder' for the current sample interval.
> 
> This could add up to a significant sample skew for unlucky
> circumstances. On average I think it works out, but if you're always
> landing on a shorter interval, the effective sample rate can go up
> significantly.

Maybe we can somehow shift the reminder here? Let me think more about 
this. Thanks for the feedback!

Thanks,
Song
