Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754992AbeDYPm3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 11:42:29 -0400
Received: from mail-ve1eur01on0094.outbound.protection.outlook.com ([104.47.1.94]:45028
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754919AbeDYPmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 11:42:21 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH v2] sched/rt: Rework for_each_process_thread() iterations
 in tg_has_rt_tasks()
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: Juri Lelli <juri.lelli@gmail.com>, mingo@redhat.com,
        peterz@infradead.org
Cc: linux-kernel@vger.kernel.org
References: <152415882713.2054.8734093066910722403.stgit@localhost.localdomain>
 <20180420092540.GG24599@localhost.localdomain>
 <0d7fbdab-b972-7f86-4090-b49f9315c868@virtuozzo.com>
 <854a5fb1-a9c1-023f-55ec-17fa14ad07d5@virtuozzo.com>
Message-ID: <114d4690-7c52-cc22-9a7f-060719d0fa30@virtuozzo.com>
Date: Wed, 25 Apr 2018 18:42:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <854a5fb1-a9c1-023f-55ec-17fa14ad07d5@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0202CA0004.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::14) To VI1PR0801MB1341.eurprd08.prod.outlook.com
 (2603:10a6:800:3a::27)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1341;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;3:gJwJRoHTQI+pMZH2JqksZBwwgmHHNvCmeQ2siw6MtXhcw6lIieINhxI/QCIZ9vq8cT25rIAza4bxKRuFExu9mzDUx6E/IIQDQ3YA8aSr+zUMMJMrL9JsjDQi5BvkDzQ5PQC32dtTSxIAPjm/txdE7IcSXVwhnmBVJKAefzfKKAJ3LiKs7GhQuUDDApEhDc26/m2WNfjpKUV7jBSUuDGwcSd7VnOwQzEPzg5InDEnAEz6NNHf7f8PQ92Buy4ulztl;25:BptDdEMBh4eReLz8rvllFXvM1Eqyx0u3PRJ3fxtzBqTn/qdCjlOlsu+vzN3XTxLyz2ud100x0N3dOWT1QZ9yULKr2f22GYzmw86W+hZ7UykzffRcarsfmWLcS1CCNEbKNs54p1aKneqPph0zeMxBo8clC9oapUlvqq/zI//SX3ijAzs6zGneL5inbEL33MY38rOULDI/IbG8lS/jm7dfC6iGCJ2oQI4DmVkkVDB3OduMQcFShUjYgyicdsOXOYX3Ra3EA5jQTApp4O4DXv4iUVDrCz85MO/X1xhPU2TC3pSNej9/OGboHa1iXJAqHb+culvvb5cLkkwxGwdeEFuSkQ==;31:IdG1/1FfWDwUgj53DvmsBbr9CinlfbnwYViXm5V135FqaFJTNiLnidJ6A10l/W7bNc9WKNuDH6aE13UYznz7ccVDp1BVrOMIxmhKadXJRGfKYxxObJcAP3bPjcdbCqdtsOLwpGrRMQqfAbe0IIa90ac3iZ6UAi6feepYtC89ONK4QmRPrcKRnJCuQCspfOBBfMkUyAlnX7rMQ5D5meVnHKat3pgnFnl93EtzreejNC4=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1341:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;20:agEEFjeTHVUCbSL/LFngy6mLqunl0OETFQpx7I44Oq84Ao+TSFoiPHYFEzPucDJccNb8I2OXuRBEl6JaPXwNZE1nbzdnkbI/r6tcZ3VxrfLmP3JRBhP0aqTSB3JbeMmHrjlKpm0ei6tKtwV+ZJsKPVpPTr3hHkCwMnlVS0PTxJswL+oK1fA+867H5yLxBHYXtYkD2K6TFc/31ZuMDTgnYcnFXWOYQqVesuzhJlcnyBgMZkM1Mwy2gThMn4jgonqUAEzh+McT/q/0hBIAgzQr+wDIVZVOxni/8xdroCeQRLM/BaHB2h24rLofKkA0D117bArzm/2xci9iAO6r3k4/djU293johvQEedfs+mByOpumWLGrVgkANZ9oKzyZc3yjMeuEW9/U8QLWkIkD6Mn6hDCJ3hSMzJssUlh6LX73o1+SDA6kylmwufMVagx41goTuyePHJHhx+fdw6mlqJSiNsrbyE6RLwfo8UMiXeRYvFl17Kp9LUfXVlHdy5JX8A6P;4:LSdUMFLfo7ui+jgaoTrku93+QnGKjQCGVf7Y7xqywUMkU2tZFUNdKVLN4ZOd+ZkmmOLfpEXGldOWGZKgi3h7jipQjjyOzDTZieKMQCz8GhUjNsN9h62pRgpQb5NvQV55plE88k/i5H0qjOXqbK1K/65IrvXWkDZ9Bjj3FBKMbDypii4ygLh+nb27O9S3G0urdkkpHAmbZQuFqPvlEJ3rZmT5ZNG74tQN2tXcb32D9nBp4vCd/4XsLS2/bK+wPFr8/GsztozZM4O+oxHEg1/H1g==
X-Microsoft-Antispam-PRVS: <VI1PR0801MB134152A8081EAA76E08C7902CD8F0@VI1PR0801MB1341.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231232)(944501410)(52105095)(93006095)(93001095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR0801MB1341;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1341;
X-Forefront-PRVS: 06530126A4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(39380400002)(39850400004)(366004)(396003)(376002)(199004)(189003)(76176011)(5660300001)(53936002)(16576012)(97736004)(58126008)(8676002)(65806001)(65956001)(47776003)(26005)(316002)(65826007)(230700001)(106356001)(66066001)(64126003)(93886005)(52146003)(8936002)(23676004)(2486003)(52116002)(81156014)(81166006)(105586002)(186003)(31686004)(3846002)(229853002)(59450400001)(50466002)(7736002)(6116002)(55236004)(6666003)(53546011)(16526019)(6486002)(386003)(31696002)(476003)(4326008)(575784001)(36756003)(86362001)(77096007)(68736007)(478600001)(305945005)(6246003)(25786009)(486006)(446003)(39060400002)(956004)(2616005)(11346002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1341;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDE7MjM6cGpWcFRQNlRwYXVFQStwL1htb1VYTHh3?=
 =?utf-8?B?S095eEt2Q3F4NytkU1llRmpHbllPZGozbm02T2JtTmhHZmIxeHpTZVVINlJS?=
 =?utf-8?B?cXJGMHNQaHJyTnk4N3NGakdzZkZGNUpra0VhaHRHeERXcTRRdXN1M2pXait5?=
 =?utf-8?B?dG1IaUhJanBXQWI5Ylg4VkZOUFBjVXN3c004aDM1bW9aNlNCTjV0aDdyQS9h?=
 =?utf-8?B?T2x1V3B6ZHNPSFBWaENhZWNwajc4cDJzS1J1SFdUNnRNWWJlaGdmdmVKUlpo?=
 =?utf-8?B?emltV24xT1JNTHA3dmQ2dDFCKzFaTi8xc3g5dGpLU3BVcCtQa0hHQld5Vyto?=
 =?utf-8?B?T29UMjlWcFNHRXUvRU91QkNrN3VRZWtMcGtuTGRXNnJacTFLMFNlUEhTbGFq?=
 =?utf-8?B?QzNPdldkd1l1cGJkSktSUXJnUFAvZHdieW5MWnQ2Q1NLclg0MnJpZFNZWWxq?=
 =?utf-8?B?WkdCTDh2VEI3SnQvcUE1SUl4QkVVUnZrRFVQTjlGN3ZtcnFCbU9yZFRIZ2sx?=
 =?utf-8?B?azlWL0JkWUF5UGI4bGZ5MDJER05hS0ROTkRFeWZ5OVpWTERuc2xTYmNTSlBP?=
 =?utf-8?B?NDlWV3BJbWdKbmUwTGlGQVJrb0x1Q0lrcVNUc25LR0JQOUgvZ0Z5ZC91SnR5?=
 =?utf-8?B?c1ErTHg4NjdvQ0ZUY2IyakFzZDkzcC9MTGVWbi9mdkh5L0tpY0YvRWhna0sv?=
 =?utf-8?B?bEVKb0ZFVHc1RGpkVmVVMDNVOWRrNVZjM1ZrOUw3ZytWRjRDOC9tLytma1oz?=
 =?utf-8?B?b2toTGRrTTl4OTZkQWM1RWFDVnFJTWRNMjVhazhJWGJaNFVCWUlyVURYZ3FZ?=
 =?utf-8?B?QTJ6cHY3T3g2VTVhRitVaVRidVBWdE1ydW9ZOStwZnFDWGY4UXJ3c0lUTEtT?=
 =?utf-8?B?N2s2dDZUOUFISC9nY2Z5U1lybEZPd3VuZGFsaWZsZkIvVXFDYkVjL1I4a3NQ?=
 =?utf-8?B?ODlWRUdqdW5WRzhXU1NidjBjcUdKeGlOd0VoUXoxWHhDcEN2clhjazBYQTdE?=
 =?utf-8?B?UVhOYUtSemFzZkd0VGV1Ris5c0tOWC9vTytCUUZ2TGpRdmh2bDhjYklMbFZt?=
 =?utf-8?B?aDFncFh3YmZzcFRyZThrN09NdUgzUDdUYU9ySC9HUWliSUdETlJmTkFUNk9G?=
 =?utf-8?B?ckRsZDFnQU4xYUEreGpHeTZURHpqTWR2RTRPL0pZZ0RMbHlKNGN0cHFZRlNy?=
 =?utf-8?B?TDl6MU9rM0F0aG5nVFRJWENpSmthazlpS3h0UThBMG0zdUNPdnl1Wkk0djR4?=
 =?utf-8?B?QVJvQTg0c0JTOWJNZlpMQjN5NVZxTkZtQVZ4b3ZhWlJTRFdqN0xiT1RnMjNv?=
 =?utf-8?B?dnFZNHlhcWVTc0RVYXZRbWNHMG05MEIvRCtGTFNjMkM3bEVLeDVIRnM5R3pE?=
 =?utf-8?B?dEtVUW1LZzgxeGlhalZ2Q25aWTlPUDdXVW56NnZRbDZoRHlYa0VmSWE4WVUy?=
 =?utf-8?B?QUd2RHhRSWowYkhvSDlXUXZ6cjZjRWc4Rm14ckFPSXNNU2d5RTdJLzA4OFJM?=
 =?utf-8?B?YnpxZ0hqQk1HcW9VdUNQN01KZkpJQXhjaDJWUzdqdFkvRitmdVc0VDZuMlNw?=
 =?utf-8?B?Tmd4RTQvTExZM2IxVnZJdEpIRURISm00S1pKT2F5NHI2RjN3a1UwZXJvWVkv?=
 =?utf-8?B?Ym1LTHFZV2tWc0NPaGRrYnd0dnkxRDEyRHl3M0xJbVVCZWhmNU4xdUtHbmcx?=
 =?utf-8?B?aHZjTElOSk1iVm42ZjZNNEVta2ZlVnFZMzJYb2o5VTlxMVlqYzRzVm5Xc3Av?=
 =?utf-8?B?QjZpajdxRW1ZenhUOVpZVENCaCtFNXcyUk0rVjJxcjFJMDIveHJlSWdrSG9i?=
 =?utf-8?B?alRhbHBMWnIvWU1HbTlDaUx4YzRFNFRKMHI5VGwzaUFyV0ZjTmhzQzBUME13?=
 =?utf-8?B?d05UUG5qNXVEa3lEakVCWTlVR3JTaU9oRFZhd091WmtOMVRvYWI2VmYrU3FY?=
 =?utf-8?B?SnVTMDJnczczUmV3d2tTZDlySmJVemVxeVJ0VVJ4RXNoUjlyTGtFclMraU1u?=
 =?utf-8?B?ZnBRa2RVMzhTdlZYVUk2NkVJRzNnL3l0R3hsSFUwUFpkemUzL0lZR0xzb3FI?=
 =?utf-8?Q?27HHyU=3D?=
X-Microsoft-Antispam-Message-Info: 7CmrRVgaSVboPhTucIz0FZCaVwk7/kfBeyL9ZW/KYwZZ58bJuwnPshXlJSzV/vasex3spHmAk1iCzZQpMWWiZf8KQe3DvrV8vJzTwRPxv5P0caIqM+NFBrgCli2gZfzTitsVyVIHnihYdOkMmJm5iLRHLJL4i7G9/BEyrcklksr4dqmL0X6kQzQQm9yLUspU
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;6:xti9wQ7jMJz60Jz4D1uFiqA9/1Eb23FTlNaWIxWJrcBj2DcoDuiG5rf3L8Um+XItocUC5q+mBEM/tPgxpKnQ9P9uBk2p3WFuLFmYpdkBQ8BOO9T4pd+J8VrnlmymkD8pa9VeXFayg2ANpH3gICiyKxmi6tncktaRbNaCvDBDZtDOf/B0Jcu44IuXxSx0EgHM9uKuBuLZtEhrkbnl+rCP+Ycolwsxuo8DdOirK61V28lqgbOfQOH+eKGQ6PuABbjnsoTFUzym+jZjnVdn9zFQIq9PzILHXTMAXGQFg6T1RVwGGusjVfx4BRJl8L2H36bHAAxqgYe1aEIPQHkIQNPBn1aVW5rIhJXMvIlVmNKELF+ILP2o+0feLahFxTVchoVBfXn2pl9L+XhJQcZR/eCDdBbZaJiYuU+41lrz7vjrEHHh3QdBo0oQnU2DcNQRTK0pr0ETCMvV3IRCgyM+JxCtkQ==;5:Rj/bJ++012MxKvPT7sHHyG3s2VslWD2O1TPjBhysbXIhnSIMLFTKwsJ489HkZjbtp2LJh6vpMDBjaAXEqvfb6V6ufkOsOrd5bsgcYv4ZwuB5fppetSEv4Q1Ylq7oVsHRvEM3FuAomkYAfy60xy855006l0DwhI2SXuMQzOXLz1o=;24:KXTZN+5iMXLqX9As4cntMq93VA6Gmf8hIzGHLEmu8THj+sdJf0UThrGjAYqhy7LLhpSNWXOYUltuKb2DqkI+2HrHI6qVPKW4Fj0BgeKb530=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;7:QhAAXDtaQDB3d1U+gDDhmZ9mi+DSiIfVBaLf4FeEvdpx0jhH9BGT5Zdk3zAEdM+h06JEFQ7TKWuazJDlP9UyD6yJvf+GIS7D8XlnUNZEg5Ewt89uk4lPRL/tA1yHWWX8bZFhZnqmoyJW4GNR7AFU5JjiLPMbxthL/3Kdj7b50y0QDF4O/mduOBrWxC1XNjIuh9FcNPTw0I4mhnkryJSNl85YX9t8S5LTlajpZRi/tOBMqsNxfULkWhH4YIDCXX0R;20:Z5b3Z6g3f9Tmmx8sa54iFRJInsmoDtn7xMBgqYQ1gbMOmWv/7Si6IfN+skx8tGrB4Z2tGYBp8vgKOkpz+2m7Qfcq+xsyuU/G1f6+uLInUPPE2XaGJOuJwDyP7rkAGLYp62V/lp5V9cESK+Jrqz35P0EY2LpOILrEkxdP00lM/44=
X-MS-Office365-Filtering-Correlation-Id: fe4a2ceb-2598-4786-6132-08d5aac32089
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2018 15:42:17.9949 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe4a2ceb-2598-4786-6132-08d5aac32089
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1341
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

could you please to give some comments on this?

Kirill

On 20.04.2018 13:06, Kirill Tkhai wrote:
> From: Kirill Tkhai <ktkhai@virtuozzo.com>
> 
> tg_rt_schedulable() iterates over all child task groups,
> while tg_has_rt_tasks() iterates over all linked tasks.
> In case of systems with big number of tasks, this may
> take a lot of time.
> 
> I observed hard LOCKUP on machine with 20000+ processes
> after write to "cpu.rt_period_us" of cpu cgroup with
> 39 children. The problem occurred because of tasklist_lock
> is held for a long time and other processes can't do fork().
> 
> PID: 1036268  TASK: ffff88766c310000  CPU: 36  COMMAND: "criu"
>  #0 [ffff887f7f408e48] crash_nmi_callback at ffffffff81050601
>  #1 [ffff887f7f408e58] nmi_handle at ffffffff816e0cc7
>  #2 [ffff887f7f408eb0] do_nmi at ffffffff816e0fb0
>  #3 [ffff887f7f408ef0] end_repeat_nmi at ffffffff816e00b9
>     [exception RIP: tg_rt_schedulable+463]
>     RIP: ffffffff810bf49f  RSP: ffff886537ad7d50  RFLAGS: 00000202
>     RAX: 0000000000000000  RBX: 000000003b9aca00  RCX: ffff883e9cb4b1b0
>     RDX: ffff887d0be43608  RSI: ffff886537ad7dd8  RDI: ffff8840a6ad0000
>     RBP: ffff886537ad7d68   R8: ffff887d0be431b0   R9: 00000000000e7ef0
>     R10: ffff88164fc39400  R11: 0000000000023380  R12: ffffffff81ef8d00
>     R13: ffffffff810bea40  R14: 0000000000000000  R15: ffff8840a6ad0000
>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
> --- <NMI exception stack> ---
>  #4 [ffff886537ad7d50] tg_rt_schedulable at ffffffff810bf49f
>  #5 [ffff886537ad7d70] walk_tg_tree_from at ffffffff810c6c91
>  #6 [ffff886537ad7dc0] tg_set_rt_bandwidth at ffffffff810c6dd0
>  #7 [ffff886537ad7e28] cpu_rt_period_write_uint at ffffffff810c6eea
>  #8 [ffff886537ad7e38] cgroup_file_write at ffffffff8111cfd3
>  #9 [ffff886537ad7ec8] vfs_write at ffffffff8121eced
> #10 [ffff886537ad7f08] sys_write at ffffffff8121faff
> #11 [ffff886537ad7f50] system_call_fastpath at ffffffff816e8a7d
> 
> The patch reworks tg_has_rt_tasks() and makes it to iterate over
> task group process list instead of iteration over all tasks list.
> This makes the function to scale well, and reduces its execution
> time.
> 
> Note, that since tasklist_lock doesn't protect a task against
> sched_class changing, we don't introduce new races in comparison
> to that we had before.
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  kernel/sched/rt.c |   22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 7aef6b4e885a..20be796d4e63 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -2395,10 +2395,11 @@ const struct sched_class rt_sched_class = {
>   */
>  static DEFINE_MUTEX(rt_constraints_mutex);
>  
> -/* Must be called with tasklist_lock held */
>  static inline int tg_has_rt_tasks(struct task_group *tg)
>  {
> -	struct task_struct *g, *p;
> +	struct css_task_iter it;
> +	struct task_struct *task;
> +	int ret = 0;
>  
>  	/*
>  	 * Autogroups do not have RT tasks; see autogroup_create().
> @@ -2406,12 +2407,15 @@ static inline int tg_has_rt_tasks(struct task_group *tg)
>  	if (task_group_is_autogroup(tg))
>  		return 0;
>  
> -	for_each_process_thread(g, p) {
> -		if (rt_task(p) && task_group(p) == tg)
> -			return 1;
> -	}
> +	css_task_iter_start(&tg->css, 0, &it);
> +	while ((task = css_task_iter_next(&it)))
> +		if (rt_task(task)) {
> +			ret = 1;
> +			break;
> +		}
> +	css_task_iter_end(&it);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  struct rt_schedulable_data {
> @@ -2510,7 +2514,6 @@ static int tg_set_rt_bandwidth(struct task_group *tg,
>  		return -EINVAL;
>  
>  	mutex_lock(&rt_constraints_mutex);
> -	read_lock(&tasklist_lock);
>  	err = __rt_schedulable(tg, rt_period, rt_runtime);
>  	if (err)
>  		goto unlock;
> @@ -2528,7 +2531,6 @@ static int tg_set_rt_bandwidth(struct task_group *tg,
>  	}
>  	raw_spin_unlock_irq(&tg->rt_bandwidth.rt_runtime_lock);
>  unlock:
> -	read_unlock(&tasklist_lock);
>  	mutex_unlock(&rt_constraints_mutex);
>  
>  	return err;
> @@ -2582,9 +2584,7 @@ static int sched_rt_global_constraints(void)
>  	int ret = 0;
>  
>  	mutex_lock(&rt_constraints_mutex);
> -	read_lock(&tasklist_lock);
>  	ret = __rt_schedulable(NULL, 0, 0);
> -	read_unlock(&tasklist_lock);
>  	mutex_unlock(&rt_constraints_mutex);
>  
>  	return ret;
> 
