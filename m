Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751788AbeEQKnI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 06:43:08 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52994 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751047AbeEQKnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 06:43:05 -0400
Date: Thu, 17 May 2018 11:42:16 +0100
From: Roman Gushchin <guro@fb.com>
To: Michal Hocko <mhocko@kernel.org>
CC: =?utf-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>,
        <akpm@linux-foundation.org>, <rientjes@google.com>,
        <kirill.shutemov@linux.intel.com>, <aarcange@redhat.com>,
        <penguin-kernel@i-love.sakura.ne.jp>, <yang.s@alibaba-inc.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Wind Yu <yuzhoujian@didichuxing.com>
Subject: Re: [PATCH] Add the memcg print oom info for system oom
Message-ID: <20180517104211.GA5670@castle.DHCP.thefacebook.com>
References: <1526540428-12178-1-git-send-email-ufo19890607@gmail.com>
 <20180517071140.GQ12670@dhcp22.suse.cz>
 <CAHCio2gOLnj4NpkFrxpYVygg6ZeSeuwgp2Lwr6oTHRxHpbmcWw@mail.gmail.com>
 <20180517102330.GS12670@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180517102330.GS12670@dhcp22.suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c092:200::1:48a5]
X-ClientProxiedBy: AM0PR0202CA0005.eurprd02.prod.outlook.com
 (2603:10a6:208:1::18) To CO1PR15MB1080.namprd15.prod.outlook.com
 (2a01:111:e400:7b66::10)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CO1PR15MB1080;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1080;3:YKeBpKeNuYhVFpH34JCDPA7e+7R8+viiT4PSHucqcw9mA8qlHXDmq1S6kdaVVBjckdjuiCuxr/8uxnshLHzm+NIlpVOyvJJcxWwSV859UUPx1JkcieTDbEt859cYvLndKR960KPqTFiOg8img3jliDcXPcBDxpcyqeqS2hnOsz2ALBwKyq9Uu6fWoXzY8WtsTTd+1nMMtXFbY/WpILBsiU8FyUalZLYmtO4UQ5MBUN8uuZQBVkezUABi0sUHLaFm;25:ePi0pDdycfF663lm3ZWptQ8kmpuzhHWCdC0cOgh4rVWsfYoZSZJeBT0RGdXZQ1k9ltI5zqJ9WnfnwbTDLUTsMywesQQLUYgd5+uxv6+dHEJ9WSNl0BHbFwMSkGd4gm6Rh1VPArnGY4vUqyaZRemmIbv5QD4Xc0hAZhJnETY1YSiovd4keHMp9j+ECRL/BGKnuCxMPD3gguchB6gOTcPHM/uDtFM3iLm040Q/p93ygKNLlz59kKVKdOYtz0/grDREAJPsgbtpfkEvRnX9mHbQyY7ry9nHJLcu3W/tyttk0Iuf5SBQJvuBpFbtnpNUWBCH+TOVvuMyt27NdZkE7UFxAw==;31:pSFAZt7t/gmfpZ9b90h1h+xCJXEgMabSVI1fE/f4NKeoODTE30RJNGuZkM9axpoZBmwhVehKWMxeG4n/+XSRprwlHKyR+kSKmW2D+JMaoPhpVKRnFt7JLXPOYscrhezl7xPVPqMNbjlhHdBWfV3Y8zgylndYkpl6j/HedBRxJSoshDFqOkxabYb7Erge4m6cV1goMtcJEQe5mryXBc8KrBoqFKKjOwsl/Ko8jeA4H08=
X-MS-TrafficTypeDiagnostic: CO1PR15MB1080:
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1080;20:OCPb97TS2k39dF9EZJHgBU+ERTVvq4q5sonlS6SgmjGZGFhwAJgf8otKogGBjeWaSD0Si5aPakkMt8w5pi21foPrVUPLGI9w0XJuT582Bcp4l+NKEGB0OJ9HA8xFiLsykJixwQeFSqHnuf1Mrb4/vTMx/TWWCZVbPHPbnaSm05lO+6zR0v1JAXshWI9KPsTbotlz4RBsKBfDaavM0wcH7/3+6DMNSN5wHlM9NSsYt6rMRxMPrvYw+ZItfB0M0P9biIqjVzWNFW/aKW9JDcmEV4XBbCFQiRwOqIxGZpFjuCbzZyscLOroV4h0ZAK4IM4IsFoRh4ZThVW2iUet0EAPdruKxh1BG5Df0aE667qcPRaaop/CPhsSwfLSdCZjaQ8all32UOmxtryFIOlYppFZ0jgMCleemXTe1747upOodVnaLT+WX64rO/MO1t3At1+rG9yUfay4eTvUkLZAQwQnB4y00vuKaiT5jrCZ2oqdv0h7AnLFG24eCs4qAPYooXti;4:TcXKKRPTWuI43rD6Rp36NMGoan7k0nFCGY0PU3jWEW7e8xBmzdNJw9nAPFGM8JU+QUj0NRW/n19dZgEvEa8MiJC07LsYyR+KoAvImtPHHo5bc2Eb1ihESrjFQCuVSe6M4u95wS45O+Uft+HfrOiGk6/qPpPGRKsQGZ98JzXPhXZa+J3iOuCo6D4XPSXy0RRUP7gzxWn/llIxxRuN8eDVaNVLn10Q/wXkHU7CIzANUfPdtOF+IZdjAHxidWSqg/7dcqm4htK+zebvjiOwv49ckLamhVIu3M/0CbtbCVVwZrwSpuxeIg/XgjSZbIXWjYPa5GPVF34vF9Q/XjgEwIdPyls5//ecEA0rWL1/DpG9QENLt4uvVtUleMcXuWAGsZDI
X-Microsoft-Antispam-PRVS: <CO1PR15MB1080C8C81BA8C78901B9F57DBE910@CO1PR15MB1080.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506)(67672495146484)(42068640409301);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(11241501184)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CO1PR15MB1080;BCL:0;PCL:0;RULEID:;SRVR:CO1PR15MB1080;
X-Forefront-PRVS: 067553F396
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(52314003)(377424004)(189003)(199004)(97736004)(59450400001)(229853002)(478600001)(6916009)(486006)(7416002)(6666003)(76176011)(86362001)(5660300001)(4326008)(476003)(68736007)(11346002)(446003)(47776003)(25786009)(23676004)(52146003)(52396003)(2486003)(52116002)(6116002)(1076002)(7696005)(305945005)(8676002)(81156014)(81166006)(8936002)(33656002)(7736002)(105586002)(561944003)(106356001)(6506007)(16526019)(186003)(386003)(50466002)(55016002)(53936002)(39060400002)(2870700001)(2906002)(46003)(9686003)(93886005)(6246003)(58126008)(6306002)(316002)(54906003)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO1PR15MB1080;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDTzFQUjE1TUIxMDgwOzIzOitSaDZhTnpXNjBtWUM2SHdRYWpPSDZjVUlo?=
 =?utf-8?B?NnUwdmRueTFSdjRJZE1OdkltdmQ3aTVjRTdmL2V1WUNhZXJTMlVRb09kTTEw?=
 =?utf-8?B?WjdpNHFpK0VrZFdxRDg4Rm1hQUFMRVp6V05Xams3alJFK3lXWVE3RjFKRGhD?=
 =?utf-8?B?NkhHSW5JWXUvVXVnVUxQY1FrSDh0RzdUcnlrNFloSWdZcnZGL1VBT3EzUnky?=
 =?utf-8?B?RHl3OHA2SllPaUJlYkRsbFltVzR6MWVFZUFWblNtaFlTME9xYWthQUNXdHM2?=
 =?utf-8?B?NnM2WjhKdjVZVVV6VlNJNFdBcTZtRFBHbGNqOVdrQURoRGtlRC93RFRYbWpG?=
 =?utf-8?B?OUYxd1dWMUF6bXRkUjJpa1RQckxWdzEvdDh2SG9URkErZWFWbC9Ja2ZQbUUv?=
 =?utf-8?B?T1lpcDBOYnRkZTFtNTJjYXJKbjlIUm9jdU5XY055aHh2dEdvY2lvSWNuRStR?=
 =?utf-8?B?U3BnbVV6RU1GdWRmc1MvNnUwZjI5OGVnYUwzV3J3bzVaTWl2OG81SzhHbmkv?=
 =?utf-8?B?b2tRb2R4dU5kSWVsMGRyaDdXVUtOTk9kMHQzQXRQN1VpM2tGNnV2bDN3dHZl?=
 =?utf-8?B?NVFXdDlHZ1VSQkhnVDkzRk1zOWJ0V3l1WEpHUkJGeGY3bklBWnNVdnhMeklq?=
 =?utf-8?B?Y2hJdlhJNDg4S1BHNFlGdEVzcHRia3pMVERWRGVMTWtlaEM5bUhsSWpUQnhQ?=
 =?utf-8?B?eThnd3VrMmJDcU5nOGg1MVgzOVNnTmFpTnpoM3ZuaVZnK1l3cEFzS3Y1WXpL?=
 =?utf-8?B?WFZscVVIdnFpdUV2QzJHNWVBV05CY2dJODhBVFMxcFFkRDJ6c2NRZkZ4VTlW?=
 =?utf-8?B?c0NNWWgzVU5HeFpMdVVvUjc3bVBIOHJ4R0dpaWxZUzMxU0NOS0JIM2pDRzBu?=
 =?utf-8?B?Rlc2QU9LZTRKVFRwdThPSWJoY1JZbXd4aHJwM2R5a1hWWHdlRExRU0tDUGFw?=
 =?utf-8?B?bmFqQnpsaHZNR1NMeElJKzZTdWFNRUdISU5OT1JMYjZlMG43Q09xZWVsVXpi?=
 =?utf-8?B?Q0o2aE5SZVhRSkxITldCamtLQnU5cVVmY2Vzb2NjZkM2cFMySklXc2psUlRX?=
 =?utf-8?B?eUptalRJdjZ5U3g3VDF1eEw5WDduUVNpM2loRVVpdlNMTlgvVnBkRHZ2Wlln?=
 =?utf-8?B?RlF1L2JIVng5V0JQTXlaSzZaeHhoUVQyTkV0MUdPT0hVTUtCTGExTVA5WEo1?=
 =?utf-8?B?TXhoSHRWY0xiTUxvOGpsRTh1QlU3ZWNkR2tVbVo5NE4zbmcvMk1VcnJoSG9H?=
 =?utf-8?B?UGlQcmlodllFa3RlbWZrWVcwUWpKSlA1NWNPQnkvc1dSNE14dk4ydW9zSkpj?=
 =?utf-8?B?b3BBUVVJcGptUEhtLy96Um5yQVlEK3huRUFPanNybFFlcXZpZU4rd0VHcWRU?=
 =?utf-8?B?VnJyWm1mK0VKVTlLd0t4UjVHNDNHWDh4ZVVQQWx5clFLRnQ3WVNsOWRjQXZz?=
 =?utf-8?B?dTE1eFd0bGdpQUZaZkV0RkRiUnlkaVZvaDNLUlJDallNT25reU0wbGtUNDh5?=
 =?utf-8?B?WFRNTjdnWCs3dndKS0Mxa3RNdVpxK25DVGg0cWp1QlpIZS9UVnFaMHYyZmtD?=
 =?utf-8?B?SFFVOXF6NDJWU1UvVGxBcEVSd0VweUhRbkVzVHdUaWhuS0lYbzVqRHRPK2Vm?=
 =?utf-8?B?ZVBDUjJDQ3BrMmRYZXZoTTM1eUl5N2EySmgyUDBWbUMvdnc0bC9kWWNqNWg5?=
 =?utf-8?B?V255b1hGK0VkOU9MWlFnZXBFTEszUGNTRGlxS0dSdzRZNUFIYUM1empMN2Ra?=
 =?utf-8?B?NjVqYkp4VkhjVmladyt4dVZabDRLOVIxbDc0cEN4bnBUY0VMQVNJRWFuUENm?=
 =?utf-8?B?UGhUZThraURBL3RoUDY1OFBkY1JQa1pDUGpDMkZKcUZvS05WUGhIVmhDL05q?=
 =?utf-8?B?TnVESTlQSnB5ajVpMmdFSmNKQ2RpYmFiSHJEeDZpajI0VDZnbzVtR01DUVgw?=
 =?utf-8?B?RXovdlNBRElEc3p4SU9DbC9CYWt3dW1VOWhRT1kzRmNZeXROUmo4d2JVZC9W?=
 =?utf-8?B?SXBSbXJxQWJjdDhYRkVlRmpZOG5aVXp5bm1uQT09?=
X-Microsoft-Antispam-Message-Info: MVISqLPDMQ7/ukJRG+f8LPoHUZOI7MwFYA1uszCnArpQLDD9s6RpcRylvhp7AEeNqNpdZeOE/0geTFTUvQwQ7syp/2H+WTokO9jeApVe4gZBwu4sJkZK0c7hG/XcuaXCvoCAyCrqbCIj79MB+Hn3fnGu8/pT6kE6Cs2Qha9ewkbWivypQosACwwuoqlCjQIC
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1080;6:aMtes3wTzDOHxYVoJzq5LP1II3qH3OkybXAjv8OL5DM0QGUYV1JIVmnXNQRZYuX0YLkpu5AzrTxoFNS/CeX0YUzc11Sv1m3Eqp9V820MFZ6tSyR/CXPQ8ei9EJ1LkcazMWCKfqtCir6qzbjntsGKFuSx/+jJZytjUTab4lGM4oRpiz/MDa+Y9V7mQdvulCB0ZcpD+QS5LaXrewWNz6QGtvCECxr1Y/aI310YqpAst6Hp0srZjLSrQhVcJAPeegw2s1WEmUX7hiRGH5+TMGRXc1ytc3/bL8/l7BJbfgMpUVp/HJZtmpT5b7Uc9vrqvNplvLbbRXwtkcrnzmVTBPFUrR8Q6u3sjw5yHyILE6pcARifIFinnW4M8bk7djMAQv+gqg4rzfTXwXCRvKDxXGI+KIwz9plyarL8yR6q6Q2fsdMph2tnvLdalcOqTqsro9cfo160HVTKHbI2/WeHjqY8hg==;5:yne12lHWV2t1FUEBP84MZt7A91RE3IjjvaRbnvGnEXMVaGLWLHAT+Ui0Y3VbkkT32Q20Ige77HYBGGqLZI9NAif7MKiuATeOxvO75LYoeI11fyklyj0Y1KkAUPE5X7NawHRctRMWxXx2pSLN2sQyC3gpIGTCQvGNLDFf9w0zrF0=;24:MtgnhWz5bjspkQapwrs8Wj4a2sSzZS6yJ5DXN/uxXYNJmBb5N2oB0ZMuWgp2OUEkjhYQABY9skLQ7KRBa0xGghqACuWTfs26IHK6L/ae79A=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1080;7:9FeThqG0vtWlra0wzC7te4dRe4Q6H2Fky2g071BNbK8Yo3ijw9++S818EW3GJyfVbZWEeluePLECGKANSq62HuzR7jgaHfjssFusVtrmTjnFxoiPP9okW6FVkugdQHbEtW/8mDHd4yn9pCuR1t1XiLQItapKzbc83LqiW1OUN89SVULvS0s0zcAclnL3cG7xSctXT6kB0BvR9maTDmADIsdfid3ihMFRiHU2/Je6qfxXiSC9xzdM9wDTWPe2nj0z;20:ZRoch5IqKH7FEyk8MIGJopprRPIUmzu8bhwCJWhVuFsItFc007XfSMIjVcgkfSPY+VVOxyx7TpaVPGaZOZ9j/ef0cZdEyqHjvmTe9aHk3VKqUQnKkGrpvWGJXPCPZ3X4zx6QpBPFcl+hr4zQYk8ZyWWZ3haCp27Zuxr056DRj+U=
X-MS-Office365-Filtering-Correlation-Id: cfadebbe-975f-49a0-2544-08d5bbe2e3ca
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2018 10:42:27.8658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfadebbe-975f-49a0-2544-08d5bbe2e3ca
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB1080
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-17_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 12:23:30PM +0200, Michal Hocko wrote:
> On Thu 17-05-18 17:44:43, 禹舟键 wrote:
> > Hi Michal
> > I think the current OOM report is imcomplete. I can get the task which
> > invoked the oom-killer and the task which has been killed by the
> > oom-killer, and memory info when the oom happened. But I cannot infer the
> > certain memcg to which the task killed by oom-killer belongs, because that
> > task has been killed, and the dump_task will print all of the tasks in the
> > system.
> 
> I can see how the origin memcg might be useful, but ...
> > 
> > mem_cgroup_print_oom_info will print five lines of content including
> > memcg's name , usage, limit. I don't think five lines of content will cause
> > a big problem. Or it at least prints the memcg's name.

I want only add here that if system-wide OOM is a rare event, you can look
at per-cgroup oom counters to find the cgroup, which contained the killed
task. Not super handy, but might work for debug purposes.

> this is not 5 lines at all. We dump memcg stats for the whole oom memcg
> subtree. For your patch it would be the whole subtree of the memcg of
> the oom victim. With cgroup v1 this can be quite deep as tasks can
> belong to inter-nodes as well. Would be
> 
> 		pr_info("Task in ");
> 		pr_cont_cgroup_path(task_cgroup(p, memory_cgrp_id));
> 		pr_cont(" killed as a result of limit of ");
> 
> part of that output sufficient for your usecase? You will not get memory
> consumption of the group but is that really so relevant when we are
> killing individual tasks? Please note that there are proposals to make
> the global oom killer memcg aware and select by the memcg size rather
> than pick on random tasks
> (http://lkml.kernel.org/r/20171130152824.1591-1-guro@fb.com). Maybe that
> will be more interesting for your container usecase.

Speaking about memcg OOM reports more broadly, IMO
rather than spam with memcg-local OOM dumps to dmesg,
it's better to add a new interface to read memcg-specific OOM reports.

The current dmesg OOM report contains a lot of low-level stuff,
which is handy for debugging system-wide OOM issues,
and memcg-aware stuff too; that makes it bulky.

Anyway, Michal's 1-line proposal looks quite acceptable to me.

Thanks!
