Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752530AbeEPLza (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 07:55:30 -0400
Received: from mail-db5eur01on0041.outbound.protection.outlook.com ([104.47.2.41]:65376
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752241AbeEPLzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 07:55:18 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vladbu@mellanox.com;
References: <1526308035-12484-1-git-send-email-vladbu@mellanox.com> <1526308035-12484-13-git-send-email-vladbu@mellanox.com> <20180516095953.GI1972@nanopsycho>
User-agent: mu4e 0.9.16; emacs 25.3.50.2
From: Vlad Buslov <vladbu@mellanox.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, pablo@netfilter.org,
        kadlec@blackhole.kfki.hu, fw@strlen.de, ast@kernel.org,
        daniel@iogearbox.net, edumazet@google.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, kliteyn@mellanox.com
Subject: Re: [PATCH 12/14] net: sched: retry action check-insert on concurrent modification
In-reply-to: <20180516095953.GI1972@nanopsycho>
Date: Wed, 16 May 2018 14:55:06 +0300
Message-ID: <vbf4lj724th.fsf@reg-r-vrt-018-180.mtr.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [37.142.13.130]
X-ClientProxiedBy: VI1PR0602CA0004.eurprd06.prod.outlook.com
 (2603:10a6:800:bc::14) To AM0PR05MB4690.eurprd05.prod.outlook.com
 (2603:10a6:208:af::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM0PR05MB4690;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4690;3:PFEFcgvLfUVnBMLn4gLJuVV7J/iKBG04xQnMr9RdsGzRdJy1oTcho01yJbXRKY+n4a1zdu5l9t6qA3OSDB5SeZEWYDJbSO9RidiKpLnKAJRLrCdc+8vPUVEvNlsW0SugawelFF6NR39JEsmqZsJjggsD401Cnk0HIX7M/aY1usq48Fa041E8Dt3T6hRueQmyyCM/QZMJJbC5aD+ThFcUCTktdyybAjXRss67p44kCpuWwIeFu1wiMQr1bb1F0Vuz;25:HvAVshGrRiAkTVs5XJdDsaw2ujM1ftCq3y8oLF5Ghz6xcBcU/wk3Sigd+FXpRyaOCepBPjPTpdZyNqShzh4EQkBbfYHtd+FMH5+AHmZLs1AMBQy1SQ+qtWZ5VVG3vevTARbs3Y201jWh6byuxbeSIM2tHz6YsClCwzSsZxLXaCx/xmTCTdvYXlXqpItS5eBK7Qjj0xwx6KrHASa4ER+G/DNGqhn3uKMgTHcg9GQaeCJdOeGEiwRbrJyUupjtGpvUNTRYBnccgg4C+AmS0yib/nxLLtoOylCxFVtgDQL58P9B13BU69V8STcVvOw604TAVQrbtVsHTyAL+z0ugo3swQ==;31:YNzRb6I9giv35EvPZ+YpNlu48IqGcIEHOqmyIaPg/1/JSDd9n7jngiD1mmuC4WSBAcLXXrAPYIZ2WjSgo1jidgFLcwJag6tcTn+UMltdB2Q1EHrTVttw0ST27pEmOdQCSRAj+F4AEAAeIUpoM13qMkMTS7hTsnaJuoP4USyw37ldAvsKaZtS8HjcBDSPxHBDzHmpEpbKE/ppm5eF1G9YnatLxdGwmGdGb+MKMYX0Z8A=
X-MS-TrafficTypeDiagnostic: AM0PR05MB4690:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4690;20:R5zKW6SIES3/2EXE1L0d2jefgH1vppf/nEslZPgQV6Q68urVWfelGYJERcuRYTLtbgr5b6hBQtdP2ruPEYMCha6JhiNWGxODg5dcJTcsSZ25cg51NELnQQ1cqHGEWmm9WuPHUhJYmCQ9gxzJ47jc0CfjMsK+KAPeVE3+/jCfJOSJxeQXqLv/2sANM8KhQA1R1gd1eAJhPBv819jQ4OV+X8S3EtIa5npPo7a/6XjvN7Li7FPbwYWqbf4g/GdaqWWAd4sXgI9YsamTaHwCzkXcvsdFnGQuyGqlRRA2Wdq6UwvtpoSHDzs8pf24wmRtftNSNjNBSSMJhosYu9PqNQU6qSwYCXBRZC7ovqgFjl78UlHr2qM8s0UTgzYsTdoHzK2F3fNWOKSYWUVXMnkK5dUKdtHv/CTdEHiKQe4qhhY8XimB+51zBHhTodnE3VXrGi3oJ1gtqXWOpL3IZbdfIWHJ92NyJidlOpEHUk2e7ZM9lNuXVipAxEVTicNAMot0wxuE;4:xwGnS7gMWXjjkB6qT45r68TdTjvmp/jAxuO2IjVIbt3QAHFejKh+pkSkKyCXr8u33tB2ZGXU+EchB14xZN+zDHfqaJOuK69D5vWrqQiAkQy0KtT4tr+DdWshzOzR9iSfYNyXgtQzSWKwRVXLFM1qlDqwMiX9lx1s7bserOR3BsYXMuOk6+XQmXB8qi0R/1H8zULuPR4xtO8MI2516gRVMioDyorjZ6GhjrDBlAymj7CANBMgWbSBdfRvb0BHr+GTNt1ApKg0nNBg1c39PTeN0g==
X-Microsoft-Antispam-PRVS: <AM0PR05MB46908DEA2C63F0D321EAAB20AD920@AM0PR05MB4690.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:AM0PR05MB4690;BCL:0;PCL:0;RULEID:;SRVR:AM0PR05MB4690;
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(376002)(39860400002)(346002)(396003)(366004)(199004)(189003)(11346002)(2906002)(39060400002)(446003)(6486002)(16526019)(86362001)(6246003)(6666003)(7416002)(956004)(486006)(476003)(386003)(16586007)(26005)(58126008)(316002)(25786009)(5660300001)(66066001)(48376002)(81156014)(50466002)(106356001)(76176011)(229853002)(105586002)(52116002)(7696005)(478600001)(7736002)(53936002)(51416003)(107886003)(68736007)(8676002)(6916009)(6512007)(305945005)(81166006)(9686003)(8936002)(6116002)(3846002)(97736004)(47776003)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4690;H:reg-r-vrt-018-180.mtr.labs.mlnx.mellanox.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR05MB4690;23:1lMTUE5Mf4mA/svkP1gHAP74CGWw4GlFfI1o7B55v?=
 =?us-ascii?Q?gqy4ZgdURGy/lZGVwQKsbPHHb/ZQbcr2dWsISXKiDdcXl5ZXQvbHR637K9aW?=
 =?us-ascii?Q?dwg6W0hGYGgnogxxv5ScR3mN6EFNTIEmWd1Do4u2ToA2/NTCX0Qs9xYDhofk?=
 =?us-ascii?Q?fKCXEiZXIoE67vI961DEK0zr5RnQON5yWkJ/aixzcD6Epbt10as+ksixUM7q?=
 =?us-ascii?Q?M4vzA+XrwvjsRKi40cEYHmeEmj59OMfU8wv6TvwI6Ipqumux7Xsdyx1xHrJS?=
 =?us-ascii?Q?iNcwliihmCePmZu5rRP3xPbvjdOiVIT1ULzTCzGUjJLbNGNl3KF7WMxeWzUl?=
 =?us-ascii?Q?+yUVNGaYkvuU/MkV8GSRY+/krtUM/zshnQQVxbXOcUkZNvtdgDqKScSKsWxO?=
 =?us-ascii?Q?ranBHCMr0SVMhzuKOtbleR64Cb7ks2z5EFXDpP1i0qkyUeVXZG21W9wA8zIs?=
 =?us-ascii?Q?kEFoX7LrayISWiyUr6MBKZ2MxprYcWh96XcyJUvuUE3uclA+N6bpRAE8W14J?=
 =?us-ascii?Q?zJwEhlaKjiyRIAuroJDOXw06b6QHDZVYIiJUqcRn4LgW0fTMnJaVbfRo4R3G?=
 =?us-ascii?Q?mRErqy1wuymZYjmbTm6X6h01GD8plfkR6PCG6Hv9tR6wfWoidd3uq/ARZQ9z?=
 =?us-ascii?Q?IbsLC6qKBxdmqtEdZY0rrSoyOWZbRM7QjUjxLoBBpGovFXy2Ox9RVB3iMLdL?=
 =?us-ascii?Q?peYgrzKS1CoKUKeHGfvc2BjLAzLwExQ2v8asLAad/xjO2ibATwNsQpXFhIQ2?=
 =?us-ascii?Q?ufD30s0QbWnPMYsZIr1f49rGbGAo/jA/IALUVXFOm6x+t5n2KlS1vlrY0J26?=
 =?us-ascii?Q?DKR12rrLqMREzRaYRJm9rjx41C05aTi/z8aY0BbygvKsrPbyYaEOx9rrJUZD?=
 =?us-ascii?Q?Ge9egSizrwI0BnWrGSE5dzGkZmu3e1Ibe7WBSd+V5pVdJl1T5Avd2BLLLv/g?=
 =?us-ascii?Q?XfOnUv5HvoawhVDVsjrznMSu7VRF80QdC5dpWc5iw/vqvRusMiD7KiovhkAL?=
 =?us-ascii?Q?6Mgjbf/CALmi5x0h86s1gdj4s5nTSu5V0srFsZsN0yklyCSZAjLVewKwbbML?=
 =?us-ascii?Q?XCIyIo3NDKKyzGbMZBx6j4F/oLPngkL42nigYF/TrBnGRjsm1yvtyRMZaOVw?=
 =?us-ascii?Q?QeBPHq7Xje/hO0ZHX0ZkCsfZ+k366d4JXc5o7S7YKw02Qpct9VusNZaq6GN/?=
 =?us-ascii?Q?VU8uI+ML4Bn+uofRNhcyiVT5kTSVuSvJFh0uLo6CWuSqidRbEkD8zy7VGH7x?=
 =?us-ascii?Q?dYcDaxToG77SXr/Pig=3D?=
X-Microsoft-Antispam-Message-Info: 0/09uwLYDcu22ygpI1ErQem/5JsEe1B5nEFYQJIIpztp/h7/Z3kSKy/9MCeuZv9vIT9vH2lGbGg6LvSBHW+rSbfEXVmRKiFmY//6AmjYOFReREroEQQGeuck2b+r+OZ6D/hIeGTBbB1Hx5ZgVM7Ao4sRktZgrLHJ4mxckM6YldTJu5UM9/ednVCRmq1GNyMe
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4690;6:jfGYam7yRLhFuhnI8w8Sg1tXi4YFT+1DmSA1DNpxS+tqw9radW5fvebvmyjq48ipeVgtg3G9M6XQHFWdwmzmrX49maX4883TC2MW8I+rqT5Vndaixw7t2wa5cRM0et1IrhBL0WX/kPxH4SXtVybr+/bgrw/40ZTnwwi8qpWpWGavOre/5Yvres57BXqVuRezpMxagsQg0XWYXYrtFN9lXO0qBA/N9deYRIoj5T4AjjJgjNG/5CXlVQa/wc9JlRy1UHhMRUWvkzgmdC0lGAhE7rddbX29d3KCo18jz+CArnnFH8k7HY+pySUarCA2bYcrgTRKTox/ZC83CiR75lovYjfWYSebnGAytjJ1Dnrp2IxYHKvXRBwj2A1uSN3x2ZjtPve0gtS3gWI7vARxzveMHQmSGwD5opI/pRJWqijYGwQHZVEnFVUETugBCsIwrLMHr4Aev9kYxqsKZQntryGGbA==;5:Mrvch+0aUpkvVVToJBJTpHaffjKH4gtrbGlFdZYgAiPAkj8xC6juDnbAXzEaCk03dbOXHIXm/EM3iLh5bm9UGsdXe+fA7Nc1howfST5aYpjY2BOBEx324rNnIc37fYTMhl+sd4I1NxPVg+3xchLAMLmYca5pU7QRaQDXfVGvp6g=;24:ThXCtCItQhrB6WHeOEZujaW34ZtLJa3lDFPty5NiaUtxEWmcfDVCVcADi2ptRaZBdA7xM29iJgutRYhGDTkKCdS6RQP75pIWKhXSfPaNq+Y=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4690;7:GnEOgYhPWgSFe5cZOixpPu0fzswC/3HQc6OJXKlIkdmnzG7+G6U4fh8xseHBZZrtTd5ayfTnjg/XhAiY2FmISezzxbd/O0Xe/OPecgNILeVOJGpnoqdlm6QgIbSFG88CjdyTc1ULW8XOHoBq/VLwWG2YY0P1GEqKGgwIzPOfhvp2OzO6zoYqS00oiJ0uhOaEWbjFVxXXjoZUHFNJE/9w29mbWw0sYn/sL2mb2m3eIMdQJ4io+NzjAghd+CyxSd4A
X-MS-Office365-Filtering-Correlation-Id: ebde107b-fcc5-49c7-4772-08d5bb23e290
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 11:55:11.8086
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebde107b-fcc5-49c7-4772-08d5bb23e290
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4690
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 16 May 2018 at 09:59, Jiri Pirko <jiri@resnulli.us> wrote:
> Mon, May 14, 2018 at 04:27:13PM CEST, vladbu@mellanox.com wrote:
>>Retry check-insert sequence in action init functions if action with same
>>index was inserted concurrently.
>>
>>Signed-off-by: Vlad Buslov <vladbu@mellanox.com>
>>---
>> net/sched/act_bpf.c        | 8 +++++++-
>> net/sched/act_connmark.c   | 8 +++++++-
>> net/sched/act_csum.c       | 8 +++++++-
>> net/sched/act_gact.c       | 8 +++++++-
>> net/sched/act_ife.c        | 8 +++++++-
>> net/sched/act_ipt.c        | 8 +++++++-
>> net/sched/act_mirred.c     | 8 +++++++-
>> net/sched/act_nat.c        | 8 +++++++-
>> net/sched/act_pedit.c      | 8 +++++++-
>> net/sched/act_police.c     | 9 ++++++++-
>> net/sched/act_sample.c     | 8 +++++++-
>> net/sched/act_simple.c     | 9 ++++++++-
>> net/sched/act_skbedit.c    | 8 +++++++-
>> net/sched/act_skbmod.c     | 8 +++++++-
>> net/sched/act_tunnel_key.c | 9 ++++++++-
>> net/sched/act_vlan.c       | 9 ++++++++-
>> 16 files changed, 116 insertions(+), 16 deletions(-)
>>
>>diff --git a/net/sched/act_bpf.c b/net/sched/act_bpf.c
>>index 5554bf7..7e20fdc 100644
>>--- a/net/sched/act_bpf.c
>>+++ b/net/sched/act_bpf.c
>>@@ -299,10 +299,16 @@ static int tcf_bpf_init(struct net *net, struct nlattr *nla,
>> 
>> 	parm = nla_data(tb[TCA_ACT_BPF_PARMS]);
>> 
>>+replay:
>> 	if (!tcf_idr_check(tn, parm->index, act, bind)) {
>> 		ret = tcf_idr_create(tn, parm->index, est, act,
>> 				     &act_bpf_ops, bind, true);
>>-		if (ret < 0)
>>+		/* Action with specified index was created concurrently.
>>+		 * Check again.
>>+		 */
>>+		if (parm->index && ret == -ENOSPC)
>>+			goto replay;
>>+		else if (ret)
>
> Hmm, looks like you are doing the same/very similar thing in every act
> code. I think it would make sense to introduce a helper function for
> this purpose.

This code uses goto so it can't be easily refactored into standalone
function. Could you specify which part of this code you suggest to
extract?

>
> [...]
