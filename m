Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753360AbeENRgM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 13:36:12 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:37589 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752347AbeENRgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 13:36:06 -0400
X-IronPort-AV: E=Sophos;i="5.49,400,1520870400";
   d="scan'208";a="174675123"
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
Subject: Re: [PATCH 0/7] psi: pressure stall information for CPU, memory, and
 IO
To: Christopher Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linuxfoundation.org>, Tejun Heo <tj@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>, Mike Galbraith <efault@gmx.de>,
        Oliver Yang <yangoliver@me.com>, Shakeel Butt <shakeelb@google.com>,
        xxx xxx <x.qendo@gmail.com>, Taras Kondratiuk <takondra@cisco.com>,
        Daniel Walker <danielwa@cisco.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Ruslan Ruslichenko <rruslich@cisco.com>, kernel-team@fb.com
References: <20180507210135.1823-1-hannes@cmpxchg.org>
 <010001635f4e8be9-94e7be7a-e75c-438c-bffb-5b56301c4c55-000000@email.amazonses.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <cb81b9f2-a280-d8a9-c720-247fb9f5fa90@wdc.com>
Date: Mon, 14 May 2018 10:35:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <010001635f4e8be9-94e7be7a-e75c-438c-bffb-5b56301c4c55-000000@email.amazonses.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [199.255.44.250]
X-ClientProxiedBy: AM6PR0402CA0029.eurprd04.prod.outlook.com
 (2603:10a6:209::42) To MWHPR04MB1198.namprd04.prod.outlook.com
 (2603:10b6:300:71::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB1198;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR04MB1198;3:a12i7whn0SwF8P1H2kJu/naCh/1Gdh/ycf8wSKfYOiXDQQ0FsB84Jh4SIn4YG6bT3Ug87ZThw67Hm93apdQPNmidprfkpfTAH6W2qjQCd97PJ9vm9bteO1q1xlmgI5+laVdzwd18MqoBZTSRXvCZqlNi+4JyZigFFC56Dv7zYXGR4z7BSbsS2BkDPgwxYazjVFJjwkx/KoWfdpekm17sRGlLW3umoD9U6V0PXOwMiSVBQwHsFL5qpDlp4ATQP4Xp;25:44s3/5YvGBo4F/pvb/XZla6DxZaujAwmeUQ6YoGHews8dlMpyTpJc1La3DyCo01V1OxgaBa05XU+LSkowU8I9zBouXTE0fn9gSeyFNnlqtN0ADA9Vox51GbbnASn6IVi/Fr64irWtrQNsytHwD/HsEn5BfFexIqK2d4CLMoftZMEinUSznRI9mW/wjHisJzRwsbp3H4GzRu8UeP1fDLB6oxe6/Hn+Z+5Z1r0wfeBv3bgTwsh78y6Jsu2gMY9PSZwiVkTp81qC0VvzOSmHGpujRm1NhxQhYvo/1mR/z3ibOugAOqEt/aHLitdUoqqAkEdzhAfIdrDu9tH4+kEw2Xopg==;31:CuKEzJnT65F4q7O2KHCFlatwtG9kArgjTuq2KofmKUorv5V0X2oCWUOIRjTel1lP0LbObQ1Gk7attdAxE3fFaTAmcMT98YWdnML38C9wp6nOtcM7J8hRclyHLZG1HXLlluJ2vltQY7vbg078a7bMzdOUHSiVeeBd4ywInc1MFROubQQ1G0t9l2JMKH1Y3j8jhjX5xq+hY/CC/TtVWnAG/WzfTnr5L7oGhSA1wrvB+EE=
X-MS-TrafficTypeDiagnostic: MWHPR04MB1198:
WDCIPOUTBOUND: EOP-TRUE
X-Microsoft-Exchange-Diagnostics: 1;MWHPR04MB1198;20:hxgsbiMT+yOAKcfjvBGqCkR0MXnF0e6WADp3z9sO9hK1bqKqIusmwu9nvKMoiwDMxL9TRmU1R/SvljKTvbwFgyGPjZuta3Z4lSByg4UD7cDvj/GMpZNTl0ObdqByIbzjpSH6e+29Jhs1YYCQI6C1zkQ3C+lJrJzQQifhAz2dsD0tl0Z6qxYnjevk1SZI7q7lpnniTfsUHSv/pRjO3GtchNgfCthWLio4q4iZeaQxJsl02JxsAZSis2Ng6m1DA2EP7jLnhTvAsozWCjHcIHuUa9mmVnjHGccv7TeVKbzdbCuv9YXqt9si98jV5Al67+wA+v09g+lwOvrZjv9x1PGfNMpt2j+UHdiOw5uRL1mrYHNXO70L9B1FnVFxdcI+jj8qrwXdL5RUo60TyLVBA6J995EEUCbx1XtywqMgRM+GThIpQVrw6IMZpuRDx/PVZQIrhAdeeMw8IuzhIW8ubNHnN+24I1EB06mZT+ESf9O4RXY2/vjLIY05QrRTY35mi8g/;4:h0iC5nkV6wApaADAD7gViicU3JsgHAciQ/whaCzp/hWJmc/jlMbTrjCD54n6ETU0md6/la9KfTSuIniRIdZjhDhqFcsp8NZ5+DRM8Cfab4eQv9EKIyQbDCBliSB7PPBD8TcQdkPLhfqvdNAIgXS5GX0+BniZmirvjQ+qIrkpRcPUh4P5wZBDVA3TWM02QYjuRu84rpzqP8e3hZLveaomsRwrjJvIEZu3Ee6sm+J2IqT6bkTO3U392biZVg7dVpYuZF2/VlBdqK2d91CFNK8q1A==
X-Microsoft-Antispam-PRVS: <MWHPR04MB11982630D0268E7C806BE4ED989C0@MWHPR04MB1198.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR04MB1198;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB1198;
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(376002)(366004)(396003)(39860400002)(346002)(189003)(199004)(8656006)(25786009)(52146003)(2486003)(7416002)(67846002)(54906003)(16526019)(16576012)(316002)(72206003)(305945005)(478600001)(53546011)(386003)(59450400001)(58126008)(76176011)(81156014)(81166006)(8936002)(966005)(64126003)(77096007)(8676002)(186003)(26005)(110136005)(50466002)(7736002)(36756003)(23676004)(52116002)(53936002)(105586002)(6306002)(47776003)(8666007)(65956001)(66066001)(65806001)(5660300001)(3846002)(6116002)(2906002)(106356001)(4326008)(229853002)(6246003)(65826007)(6666003)(39060400002)(6486002)(31686004)(956004)(31696002)(476003)(2616005)(97736004)(68736007)(230700001)(486006)(86362001)(11346002)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB1198;H:[10.111.70.1];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjA0TUIxMTk4OzIzOlAxU1Jwek5wczhudzN6S0JzZ2VTWTJ4QU9I?=
 =?utf-8?B?NnF0Y3ZVV0hrMWEzNWNGQUp1Q1lVUkxZblRKcVB3N0tnZWdvMFcyekwyV291?=
 =?utf-8?B?aE9BWUgvTStBQ3YvTGorOVlQVWZWeEs1MjU1TjZZajB3YzJUalJKSWYwLzR0?=
 =?utf-8?B?U2hjdFhiaHdBYzJFcmZyLzROVEJkOGN1TXUxRDFHdE9ZU1NVVHZUWktHYUNM?=
 =?utf-8?B?aUlUeUpEWGhscjZCNlpIVmFtSEp5N3RZaTFJcEFETXVQS3B4RGxPMnpwVk9I?=
 =?utf-8?B?KzR2U3ZSS3phdHhGTDRSd2JIMW1hcTRiNlJkOEwvNXJIbFJ2TWllSEdnRHdH?=
 =?utf-8?B?cEVVWHJUUzlVRmdLbWVsTHVMeGZ0eXVkVlhKYzF6WUlhYzRJNXlrcEh5dVJH?=
 =?utf-8?B?TGZuTGFLaXRMZkNPd1hoZ01FbUkrZ2llbEVmZlp5emFkZUdIVjAyWGtQMnRt?=
 =?utf-8?B?aWRzR3ZxcTY4akV1bVJWS0gzMzBUcmYyR1ZiRC8ydi9XVlhvYzlEdGNlTUNi?=
 =?utf-8?B?VkpXRzVPTGROQ1Y2VjM4c3NRV3FlTEErY3J3YVg2VVJydko0a3dNRzZlcVc2?=
 =?utf-8?B?U3JsNUIwczlBTUVWT3U4dFVtSXVabVZNaitjQ01UdWFZQkFYMGx5c25VZ01j?=
 =?utf-8?B?NFRxbGxFc2EyQ1JCajQydXI0NG5QTDhHZHpvT1dnS0xpb2dsaVJUK2kvblF6?=
 =?utf-8?B?SjNYOEJPT1hLNy9uOUEwY1ZnM1MzdkFKTWxjcGhwUllZWXp6ZVRITEdFeTVn?=
 =?utf-8?B?cS9iQk9FaW9MMSswZm9mUEptK1JGY0w0dkw3bGV6d0NDekFxa3BnU3Z4UTlO?=
 =?utf-8?B?S09sT3RBM1FkcWxBeHBvNXpBTjFlbU5WcGdWNmhWOC80RENHSE9LcjRvVzIv?=
 =?utf-8?B?UGZrZDBOby8vekN6ZTl1QzBicEpwRUFXVGV6MmxpbTRJYndQL2l1cXZFK3hY?=
 =?utf-8?B?YXNEbGdaWkhzY1RINlJxUGFhODllMUFidTl0RStveG9rWmhKWVVyNXVlVlZo?=
 =?utf-8?B?c3pGSDFONnc2MEZVSUxpTkltZmV0QWxpN2dMRnVxL0VxVjBvSHY5alJPRy82?=
 =?utf-8?B?NU5sQTlnTk1tTDF5NU9DbEgyT1dyMk9hUlBNeEJOVmxTazIzcDVNTnFoMGNC?=
 =?utf-8?B?cVVCRnJkWnBYM0o0czZQTnR0d0FlQmRGMWNDMHp6MmVCR0F1MDE1VW5OSk9O?=
 =?utf-8?B?SC8vN2tkZm1oQ2VrcHBaNFBsVVJXRlZWb0lyUFRPUjBxWFY3MnRtRU4vSkd1?=
 =?utf-8?B?THY5NWVZcEdFR3VvZWl3Q2pMR0xKWEJiNXdHNjdHb1FnUzFZakx6OUpuUG5l?=
 =?utf-8?B?MUZMS3F5OUFkZEFBY3J4TTVWdjNabXBFcE9NeHVCejNXa0ROUngrOGNFcFNM?=
 =?utf-8?B?NUNDOUF5SVFRY0RZZkNVOXlmZ2EwM2szUGs4clVpSmRiUGF0U3ZOdlluTWpB?=
 =?utf-8?B?VEpMeEpGdlRKNG85M0x2ZVR2aDFVZWU3RUtISjk2eUk1YWxVTFdXWFA2V3JG?=
 =?utf-8?B?Y2VDNFFDUk9aUnliSnNhK1liS2VRRlhYRjNzQVVOT1FPRWs0ZEhhaUMwZjFh?=
 =?utf-8?B?eGRzbnNLLzRWaC80eHIza1k1dHZqNUlHYWplTkttWGtLcTZwWTdhQ05sUnZU?=
 =?utf-8?B?T1lsR0JJQ0d4dERJZldJQ25wd2J4SERXTFQ1clJkQkpoVHZEUzJrOEVPL3dU?=
 =?utf-8?B?WjQ5WkhCSFhNSEE2N2xzSUV2R3VjeTFuWjI3UjB2aWFRcnBtV1I2SmZXaVp1?=
 =?utf-8?B?ckdrV2U2YndPb0llV0lpVVVxbTJxT3U5U2VIZk4ybHE1TkpnWUl5dkhucnc1?=
 =?utf-8?B?WVFXbmplQzIyYjBFdmIxTXhaMXd4QTlLOXpkR0JyQUZ5Q05pbSthbi9lRnpm?=
 =?utf-8?B?QjE3V1lRRGpMcGhKUUNSYW5kbVBKZjFjSDJEQnNvU1g5K1h1Zy9OdnczR2ps?=
 =?utf-8?B?eHRtWmEzSU05ekZOY0RkYkpJVEpCY2lmQ2toNkZLQlc0cTNpdHVDNVhWZGUw?=
 =?utf-8?B?NEVTM1lRK1BHOU1VaU9KeXJFK2x1QjFyclc2MzNXU2lUaWxBTTV0Nit2R2Jq?=
 =?utf-8?B?Y3VUcUl1Y3BXUFp4a1RSUmZaUGMrT2xpbnBiVlUxeWtZbzluc1FjTTZLemJt?=
 =?utf-8?B?dWZmZndYclN2aW5ZY1crQ1lJQW5QcDZFTFhlSDlWckJNUlRtVG1iWkVoOG5r?=
 =?utf-8?B?THZJSE40VXZSNlZjMFBPMjB5QlZnPT0=?=
X-Microsoft-Antispam-Message-Info: nDdn+1QsE3XkDA1oEhE16dGfS51FQ3Um4QooaCwfrGrLfxWvRAnJBAmTO6EzgV0jDRSFRVhH5cuHrAV4pmf24JjvM0w9cDifCkWaV+cMK2CGl1yvBpQ+/cIOZGglzIOa+KpJyLxFcViCbH8/PVOuCngWT8SIsTKx8rwvaKdiF0xH1DZd3r/YCq18JBOPO1Il
X-Microsoft-Exchange-Diagnostics: 1;MWHPR04MB1198;6:Rz6FmiHT0/76SD67KhTk90Q3hT8nvGluq+4RV0HnTYJW0ob5Sh7Ug7mB+7wVVk1vZQgpfGB+OQqFELFz80Z1WuRxvFErMRQSFjgs+x8cdRsplJ6S5B/T5G3iGazG5KkJk/TYUBfmc7qEJwg/QFC7/MtYdAtPdV4fuXBQuA1TcFhuqjJ/WqQAXficX6pJvY92nB52DKicznr32WJqXb2E+owpOtyFAnBuO/s1Iiz2kJI8H9/vzGZLIN7IWKoHwNUqQGNjReYI6dJIq371GM1mK4FOOvBONMY9tMkj9m18jcxvYYu6/BFGfWotWY4VrxgDegHO6/QkimpEy1uFEim077buAKhZibbuoQH1noCmT+b/BBz7dt3sr19Z4OWonTLu+PoIE7D3jI9ZSTM+cYTizlPtbM5bNAOh1sgUmBQNzFHGQf7g+Loce2v74bIXNRLLNA634HEviqGDChDPmE7N+A==;5:B9qHifiqeAfdmaiDYM05EM1rvXDh3KS642IonoVTLSYNBEHxrmVc0/3UWDfXu3I7UED5OjI8JZ87M7hqos962hgEGHX5jwkx7ndyyOlMGI/eRpDSVvjVnPmC2sC470iWs9O9zlokTuRATMXruSlV76GaOQnIr9+8qH9va1deGiY=;24:swwNXZi6egA2cellV9NBVIdK2LXn7Ep/iRRHvlnR0bvt5DBmMjRDpWVbLCfLev2JkMa2w9x3iPe4XQwquwfmKXabqvBgrph5szuSAGjxH64=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR04MB1198;7:GlJIC2u9s9YSz8Kh/A6/d9mQJnwsuQG5Tmt0xiBGLTYDIlFVgl0o+r6W+PM3jvs4u/NIwrDy/dlkgIVQWTPcn0BRJkl+2Tb5xP8ZJuVEHOfU0lgYgntpgx1o0f8zUYVczIL3tVacJiB/4kLo7zTVCsGRu3uxHi3l7n4CNnc4ImOn2xYo+4eDju6u4dVQ32EbjRm53L+TWht4ZXXB9PcflH/UZsa4XJ0ADNIzpMmudXIQFVNU6jYCDWXet0fzrb9n;20:bCg/Cdnivhd9ONlnPR1F9N4x05x4Le7CZLa42NQE9YTeegKVuep5KlsbOFCEIf1p2IuGNVbkiE2oN4wJA8bQfdpofvIQiQz/Ry/EwlFg3LNoFh034lsTu/xR8oy6e4qKvQLB5vIRobcur/gqagVqUEu7Go1ug243U3rX51VfiMY=
X-MS-Office365-Filtering-Correlation-Id: 7595f85f-55e7-4c49-a1ac-08d5b9c128cf
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 17:35:53.8096 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7595f85f-55e7-4c49-a1ac-08d5b9c128cf
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1198
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/14/18 08:39, Christopher Lameter wrote:
> On Mon, 7 May 2018, Johannes Weiner wrote:
>> What to make of this number? If CPU utilization is at 100% and CPU
>> pressure is 0, it means the system is perfectly utilized, with one
>> runnable thread per CPU and nobody waiting. At two or more runnable
>> tasks per CPU, the system is 100% overcommitted and the pressure
>> average will indicate as much. From a utilization perspective this is
>> a great state of course: no CPU cycles are being wasted, even when 50%
>> of the threads were to go idle (and most workloads do vary). From the
>> perspective of the individual job it's not great, however, and they
>> might do better with more resources. Depending on what your priority
>> is, an elevated "some" number may or may not require action.
> 
> This looks awfully similar to loadavg. Problem is that loadavg gets
> screwed up by tasks blocked waiting for I/O. Isnt there some way to fix
> loadavg instead?

The following article explains why it probably made sense in 1993 to 
include TASK_UNINTERRUPTIBLE in loadavg and also why this no longer 
makes sense today:

http://www.brendangregg.com/blog/2017-08-08/linux-load-averages.html

Bart.
