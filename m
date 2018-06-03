Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751104AbeFCAw1 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 20:52:27 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59906 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750964AbeFCAwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 20:52:25 -0400
From: Song Liu <songliubraving@fb.com>
To: Andy Lutomirski <luto@kernel.org>
CC: "riel@surriel.com" <riel@surriel.com>, Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>,
        "Ingo Molnar" <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        X86 ML <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] x86,switch_mm: skip atomic operations for init_mm
Thread-Topic: [PATCH] x86,switch_mm: skip atomic operations for init_mm
Thread-Index: AQHT+aQkoCM4OwpdokeqAd0pb+8n46RLgj4AgAA1YACAAAc8AIAAD3yAgAAFuoCAAAjKAIAADQIAgAAOY4CAAFn5gIAAGL4AgAD+bQCAAE1rgA==
Date: Sun, 3 Jun 2018 00:51:46 +0000
Message-ID: <A87157D6-4A0A-44F8-8AC8-4411F5EDC57A@fb.com>
References: <20180601082811.4c0d33ba@imladris.surriel.com>
 <CALCETrUVFdrtorJBVg1fizUx+c23MVVqNnzGs3oWpN8LHyEvMA@mail.gmail.com>
 <1527877328.7898.80.camel@surriel.com> <1527878882.4448.11.camel@gmx.de>
 <1527882207.7898.86.camel@surriel.com>
 <CALCETrVE5ugmiSOjQ5sw7V+S4bRpMDs419rgrbTzfvjfhbWeqA@mail.gmail.com>
 <1527885324.7898.88.camel@surriel.com>
 <CALCETrWMouz7VzYgwC=Ys3-C2O7ZVCn4FNwesH1np4c9iG1g_A@mail.gmail.com>
 <20180601181327.367f0fe3@imladris.surriel.com>
 <CALCETrXTLqcro4uu5f77EmeaDvNqGZNLpsk-w_BApRNmzvcz=Q@mail.gmail.com>
 <1527915842.7898.93.camel@surriel.com>
 <CALCETrW5m3Y3CGnRZwDTMT9g-1an_LO6Fp_6FWOokydhN9BDLQ@mail.gmail.com>
In-Reply-To: <CALCETrW5m3Y3CGnRZwDTMT9g-1an_LO6Fp_6FWOokydhN9BDLQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.6.18)
x-originating-ip: [2620:10d:c090:180::1:183e]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1520;7:KbNu6f16oQDI8yxGDNnyIPG56s7e8piZwA0icz0skoYnQtMBv9kBQGvPzF6z6dLKyGa8ZbTqJxcBIVuKHTFoSdLFISli4s/qIh58ojasW7vnC3hUMx0FekhOYnF6zATxtHSmVBjETirBT2g7ihtbSBv1znI6bTPcSlBNJlpa0kwVsduPgBwkQDize73ZiX5RzRNzL8c/AGwLDRUqBboPfNqZPODFYRq+M+1VdK/4pjhbScO6LvKSuuW1vU0BH1qD;20:zU2i65K5lnpXfEIrvK3NaOVeSiXIWlQgnhNJxTbHwU6Ae69ikDZpEbW7IGxHYtLCqDFKIJ/1YFCcXuKES2EAdJCuA/0yADoTC/bW4oZJ6cZTRJ/2ON5cHIWfTlI+YZwHdR7z5MyDlgbe28sH2XEiQ2uBZPpLEm9WZiQd1yMdCUo=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1520;
x-ms-traffictypediagnostic: MWHPR15MB1520:
x-microsoft-antispam-prvs: <MWHPR15MB15203717AF758464F3A4F718B3600@MWHPR15MB1520.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231254)(11241501184)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR15MB1520;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1520;
x-forefront-prvs: 069255B8B8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(39860400002)(366004)(396003)(54094003)(189003)(199004)(8936002)(8676002)(33656002)(105586002)(97736004)(486006)(186003)(4326008)(6916009)(478600001)(81156014)(25786009)(6486002)(68736007)(106356001)(54906003)(86362001)(81166006)(11346002)(8666007)(6436002)(2900100001)(50226002)(476003)(2616005)(446003)(5660300001)(3280700002)(229853002)(305945005)(93886005)(2906002)(53546011)(6506007)(76176011)(82746002)(102836004)(46003)(36756003)(6512007)(53936002)(83716003)(5250100002)(6246003)(99286004)(7736002)(6116002)(14454004)(316002)(57306001)(3660700001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1520;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Bz7nz9hkmp9QLgX1kgDc3Pbr4C/eSXpPUYEuVjXjNqjBMs8eYlbeWrX7sThSZoqanQKeFJWIVwuiBk2yTJF5rvlX4+XLn/9hTRBDYrVGy6gOEFRwAEA776WRbdKu3DjjA0kibm0x1QMS1EsxHhpWPsbv7nBI9F4zFnufj8M57m4MlxvODXiRkz0uzr0SGRQ1
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CDE48D3EE00C0F4BBBDE637D86C63988@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 1b992ecc-06e4-4595-f9a1-08d5c8ec2ea5
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b992ecc-06e4-4595-f9a1-08d5c8ec2ea5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2018 00:51:46.1697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1520
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-02_15:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w530qaBO009191



> On Jun 2, 2018, at 1:14 PM, Andy Lutomirski <luto@kernel.org> wrote:
> 
> On Fri, Jun 1, 2018 at 10:04 PM Rik van Riel <riel@surriel.com> wrote:
>> 
>> On Fri, 2018-06-01 at 20:35 -0700, Andy Lutomirski wrote:
>>> On Fri, Jun 1, 2018 at 3:13 PM Rik van Riel <riel@surriel.com> wrote:
>>>> 
>>>> On Fri, 1 Jun 2018 14:21:58 -0700
>>>> Andy Lutomirski <luto@kernel.org> wrote:
>>>> 
>>>>> Hmm.  I wonder if there's a more clever data structure than a
>>>>> bitmap
>>>>> that we could be using here.  Each CPU only ever needs to be in
>>>>> one
>>>>> mm's cpumask, and each cpu only ever changes its own state in the
>>>>> bitmask.  And writes are much less common than reads for most
>>>>> workloads.
>>>> 
>>>> It would be easy enough to add an mm_struct pointer to the
>>>> per-cpu tlbstate struct, and iterate over those.
>>>> 
>>>> However, that would be an orthogonal change to optimizing
>>>> lazy TLB mode.
>>>> 
>>>> Does the (untested) patch below make sense as a potential
>>>> improvement to the lazy TLB heuristic?
>>>> 
>>>> ---8<---
>>>> Subject: x86,tlb: workload dependent per CPU lazy TLB switch
>>>> 
>>>> Lazy TLB mode is a tradeoff between flushing the TLB and touching
>>>> the mm_cpumask(&init_mm) at context switch time, versus potentially
>>>> incurring a remote TLB flush IPI while in lazy TLB mode.
>>>> 
>>>> Whether this pays off is likely to be workload dependent more than
>>>> anything else. However, the current heuristic keys off hardware
>>>> type.
>>>> 
>>>> This patch changes the lazy TLB mode heuristic to a dynamic, per-
>>>> CPU
>>>> decision, dependent on whether we recently received a remote TLB
>>>> shootdown while in lazy TLB mode.
>>>> 
>>>> This is a very simple heuristic. When a CPU receives a remote TLB
>>>> shootdown IPI while in lazy TLB mode, a counter in the same cache
>>>> line is set to 16. Every time we skip lazy TLB mode, the counter
>>>> is decremented.
>>>> 
>>>> While the counter is zero (no recent TLB flush IPIs), allow lazy
>>>> TLB mode.
>>> 
>>> Hmm, cute.  That's not a bad idea at all.  It would be nice to get
>>> some kind of real benchmark on both PCID and !PCID.  If nothing else,
>>> I would expect the threshold (16 in your patch) to want to be lower
>>> on
>>> PCID systems.
>> 
>> That depends on how well we manage to get rid of
>> the cpumask manipulation overhead. On the PCID
>> system we first found this issue, the atomic
>> accesses to the mm_cpumask took about 4x as much
>> CPU time as the TLB invalidation itself.
>> 
>> That kinda limits how much the cost of cheaper
>> TLB flushes actually help :)
>> 
>> I agree this code should get some testing.
>> 
> 
> Just to check: in the workload where you're seeing this problem, are
> you using an mm with many threads?  I would imagine that, if you only
> have one or two threads, the bit operations aren't so bad.

Yes, we are running netperf/netserver with 300 threads. We don't see
this much overhead in with real workload. 

Here are some test results. The tests are on 2-socket system with E5-2678 v3, 
so 48 logical cores with PCID. I tested 3 kernel (and tunes 
flushed_while_lazy):

Baseline: 0512e01345 in upstream
Baseline + lazy-tlb: 0512e01345 + "x86,tlb: workload dependent per CPU lazy TLB switch"   
Baseline + both patches: 0512e01345 + "x86,tlb: workload dependent per CPU lazy TLB switch" + "x86,switch_mm: skip atomic operations for init_mm"    

The tests are wrong with the following options: 

./super_netperf 300 -P 0 -t TCP_RR -p 8888 -H <target_host> -l 60 -- -r 100,100 -o -s 1M,1M -S 1M,1M

There are the results:
                       flushed_while_lazy    Throughput     %-cpu-on-switch_mm_irqs_off() 

Baseline                      N/A             2.02756e+06         2.82%    (1.54% in ctx of netserver + 1.28% in ctx of swapper)
Baseline + lazy-tlb            16             1.92706e+06         1.19%    (only in ctx of swapper, same for all cases below)
Baseline + lazy-tlb            4              2.03863e+06         1.12%    Good option 1
Baseline + lazy-tlb            2              1.93847e+06         1.22%
Baseline + both patches        64             1.92219e+06         1.09%
Baseline + both patches        16             1.93597e+06         1.15%
Baseline + both patches        8              1.92175e+06         1.11%
Baseline + both patches        4              2.03465e+06         1.09%    Good option 2
Baseline + both patches        2              2.03603e+06         1.10%    Good option 3
Baseline + both patches        1              1.9241e+06          1.06%

I highlighted 3 good options above. They are about the same for this 
test case. 

Thanks,
Song
