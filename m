Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754294AbeDTJnu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 05:43:50 -0400
Received: from mail-he1eur01on0111.outbound.protection.outlook.com ([104.47.0.111]:54025
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754194AbeDTJnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 05:43:49 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH] sched/rt: Rework for_each_process_thread() iterations in
 tg_has_rt_tasks()
To: Juri Lelli <juri.lelli@gmail.com>
Cc: mingo@redhat.com, peterz@infradead.org, linux-kernel@vger.kernel.org
References: <152415882713.2054.8734093066910722403.stgit@localhost.localdomain>
 <20180420092540.GG24599@localhost.localdomain>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <0d7fbdab-b972-7f86-4090-b49f9315c868@virtuozzo.com>
Date: Fri, 20 Apr 2018 12:43:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180420092540.GG24599@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P191CA0016.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::26)
 To VI1PR0801MB1341.eurprd08.prod.outlook.com (2603:10a6:800:3a::27)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1341;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;3:f7qz0fXZC4AaeqyOVKscmp7JuTzTA1BXugw67uy8mmXM93XdArzq7C2qvPoyjD+Z+xbwh5pwCqBlwyFkX0qyPSo5O+RWUp/khzMWt400VtICGcwl7f7K+x0gCCdqQeyl58VK/ROqvfkXgN5NluuOKKGnmj3Etb1BVv5wjLy8trlslr2lbUbwLPLrAV0VsuO7RmYxjUcexCEdcy13LD60vOsZ0f3E2o2lqrPDSe6FgW9Pcb4TjqlMFzuIidcLJw0n;25:j3YGZgp1b2IPwR+ev8Y4YsjSBraA0Ta7UQEq23xilkkn7TzGqwgZ+Q5jBzchLDfsIOeeigEbl+P8gOlPkk8ATaNIzieL1nT9Qcg21EDAjB/mvq2iyERRXgqC46K9i6c8n9TeEwuWboNk+uIUFW0zzucZyg/GyI6O93QKFPmzDV1rUcTfpGw87V93w/sDwT2/iwXQK2SbzHHFr84HWfLZGomKzBENoQs/EFAb2oF9xI2G1BDktfZWN0zgrwEt3pZ69Jw/lAXPnBVbcD/Dv8Qt2Itb1drHmZnBY0GKPSqR0z0+kNIzfndZIo17XyW5x928opz18TEAjLSu+feuRAx47Q==;31:VQbhuMnO2ioU2UlakPhgmue7DBxFVoxpKsaaXDOrViv6Bukk3VxX5z1F2Dt5s9v4m1Z1BQKlyymIDBi6M/Kh6k2xfIItaMBV4j32/RhqFxysVsPnsQ7M1CfDd8KYjSzZzhm9tIw2JfsiXS8dSMuhsHgzOkC7/Mk/bjcFXr+QvTWIoAipVFz8lpV7kGCU2+IcV90wlTKeblf9CWC33Ij6s5OxNG1bWOOtlQdxQ9brL6M=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1341:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;20:YWjLFAwRWluzcDI3wE616bF69VJ1OCfwkPRXmlI+jq+vqlh4b1XeLcS1G3hgW/45BZqRCL+hcq9/GRg1cxNCaYtjtHgTMmoS5aVLbJNifjFRhWjTJ/5F1+YSPoiA02c9FgaUODvq2gYlbGZx1nBrxEse7RIo0Z4YQM2wP5EzoUz7d3YcNX6apuoVM7meuGNFgSl2yd435jiFdR5YDvyfc533i8b2dFUsLEwUOuQwKS2ZQJnRssw3CSDM7Fg+hDovrRBvZvxKbocThyqH4UCMucnM27sKetG24yED6zJQxQLuQsaXaR4YOhq1H3TWHftYxFOyT5TdUoGrshS5S6qQ70/PyhOvmSHwhDQcW5b6erXhkbEcXYWNbWqqBES6scl/42htkN10LgYkO5whyjJ12zl1vJkrYdoGAwDJMwOF6IIp6XoGg9eOyqI363453MB4pPiM8kqBotPxbi2CS3TGhzPfzfXHJtVzMHbAYpqRfgN1xjt534zionNghlA5lCdQ;4:v7E3LsYkbE6PVbz2m6QneB5Z4/+aS3Cd5017g72bO1zp9Ia2csRBdQyHyunDVQUucCSTdgu2imTM4R4I0ifCU32be/B9Xo1/8CbgnK9ONZ5V7MAqgyLLw13dPG1gdtUe2MgEggELoUWttBZu01QpgyGvDVmBNllU9U6FBlyvumosaFA2aetsuiN/rzMF4dsV4hwht5H0mcdOwxwfxO6OZkg4fKJOkETwQ/Thm3YE4qcjy55GUZpnjLCmxhgMUSBs+2rPNnBxlISFTUCsGtqUUA==
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1341EABE924DBD46BDBC2D2CCDB40@VI1PR0801MB1341.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231232)(944501392)(52105095)(93006095)(93001095)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:VI1PR0801MB1341;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1341;
X-Forefront-PRVS: 0648FCFFA8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(376002)(366004)(39850400004)(346002)(396003)(16576012)(16526019)(58126008)(3846002)(2486003)(52116002)(26005)(6116002)(77096007)(59450400001)(6486002)(25786009)(305945005)(478600001)(2616005)(8676002)(575784001)(186003)(23676004)(31696002)(7736002)(6666003)(316002)(11346002)(229853002)(52146003)(6916009)(76176011)(55236004)(476003)(956004)(230700001)(86362001)(53546011)(386003)(446003)(8936002)(65826007)(4326008)(39060400002)(31686004)(64126003)(36756003)(65806001)(66066001)(6246003)(53936002)(47776003)(50466002)(65956001)(2906002)(81166006)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1341;H:[172.16.25.5];FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDE7MjM6ZUxsYTAxdUpYZGZ4SmszM1FRTmRnbklo?=
 =?utf-8?B?RUE1cXdCTnBaVEFqUWMxYXM0VGE0S3VKMXJic2I3QTFrMUcrWEtZNTA1NWJB?=
 =?utf-8?B?TTdXZnYvcTZpUDl5aWtVTU14SXg3aFhRbUpxRmRIckdhTzhBVHB0ZUZwR0pX?=
 =?utf-8?B?RldoK0tOd3lCZDdHOEZnREhuSUxUdnhZS21lSTQ5Um5EMnJiNk52VDcyKzBo?=
 =?utf-8?B?OGVRNUdyWG4vZDQ4MEx4MzhoQzRmaXdweGE4aEQ3VmRZSGdCYnVkY0ZwVjhZ?=
 =?utf-8?B?NGp2N0krcDZJcFF2V3RjVWRXVDlDVGIxZENiQS9EejZrcWV3UFN6WFZ0SFVK?=
 =?utf-8?B?VGZRcFB1OXdWNzFtQWp4aUZ4RW1ydEtsbXgweUhrUDRZOFFUMkwvVFBHN05k?=
 =?utf-8?B?RU45TnVmNTNDVnQvT2FoZGkzc3lvTHQzQ2VLRjRZNVp5Rnc5WCttQXJTb3Ju?=
 =?utf-8?B?NGxCMjdjZWZhZ1kzZWJBWWNPVXMxYU51Nkt0VUtUVEdtOFRHVzZmY2l0Q201?=
 =?utf-8?B?c1ZUZGtGU0ZXakdMWGE3b0dZWGNkSDZ1bUtSN2w1L1doUkxOcm5MMnFmT2Jr?=
 =?utf-8?B?M3FPbE5nZlFnQU5pUlBTbUxDbnFWRC9WRE1BRWFoWkdrWUoxWTB3QWxxNGtB?=
 =?utf-8?B?SmhiV3kycFFzN2tUYWZ4WEdDaEQ4d1EvZUZrdkRNVWFGdWRSKzFvQzRMbnlw?=
 =?utf-8?B?SDJBbWxyMjllN0ttY01IRDlzejYvUUZzSEJVMHh4MFRud3ZhTFdoL2JKdkhi?=
 =?utf-8?B?UnVpamtSL0kveXZpVmwrazFQbEVYdVAwK1l0Sk94ZEp5Yi9sd1p6TEFaZDBi?=
 =?utf-8?B?YVNnSlBNVUtkc0VOUjQ3UnZmTE9KOGhLQVZiRFBQY1JaMXJVTDlsdTdJWWhj?=
 =?utf-8?B?Y1ppZUw3cmttSzJOTUtwWVpOZjZrcnphRGVOWUg0Y0hrV2lrbGZsaTRkT0ov?=
 =?utf-8?B?NnF4bnZOSVh1bk0vb2hiNWR2TFVERy82Q1pxdzM4RGt3OEx4NVZCWDFTWEsv?=
 =?utf-8?B?SlViaDlYWkVrYjJrYms5Tnl3TmNKNmRwWWRkSEo3K2VISCtTRThUMlQzb2xl?=
 =?utf-8?B?d2sreXpOd016cFE5aEpmTmxWVktBZTVQeGdOblkvSWR5R1k5VHRDWVVDcDVP?=
 =?utf-8?B?aGdmZk1xRWY5UjlHa2JDNFE2QTk5dDE3VG05TXRQT1YzWnlwSW5BVFNKWGYx?=
 =?utf-8?B?bDNES3ZYT2FNWEV6ejNJck1rZE1KSkZnbERlRkhPZ0ZNQkdjc0IwK0NxMkJ5?=
 =?utf-8?B?TFpnZlpMa2xRQlZjblByQXlmRkFpaGVTMHlTTzVlb2pXMms0dzUzam4yVHM0?=
 =?utf-8?B?QnBrc1pPNldNdjRhS0JZemRXSGdWZmVYWHR1M1NNempyZnlFMTRDTUFwL21G?=
 =?utf-8?B?R3pTeDlJYlc0RllJajVyMlRYVVhuQWtqZ2FrSmYwMUsvdk5Lc0VYTkdEbVFZ?=
 =?utf-8?B?RkpjemwxdmxaWVVCTEtUS2FFRVZqTUVnZ2plRGJMVmVmQW5HTVQ3UDJubHVL?=
 =?utf-8?B?cEJrTERiY2xFMjhhK1l6VkYyQWVoSXFtckdoSENGRVhmVEZtd2FzckUwc3Iy?=
 =?utf-8?B?WXBrSVFMU0xSZks3R3RDbDBCakpHNEZLdUNtbzF4SE1CS3BBSUsrdk9heUxa?=
 =?utf-8?B?aS9URzR6QVhRMHRWbE9ybE81aU94QW1rOFRadU0vVUpxNGpYczhqRm00M2Ru?=
 =?utf-8?B?SHdlQjRpd0crZjNvWHFZVWdmQWZ4SzBsdHF0elNkdDZGc29Id1hUcnBQYTdk?=
 =?utf-8?B?cThTVVZ1bzVaVGlSNzhXV2tibVhjZktDSEJjWDdubkpuT0FPNmJKQlhoMUFt?=
 =?utf-8?B?MXhoUmFyWmd0QzF4RVRwdHVuVTNWU1J0Q09yd3pkT1VDWFN1QT09?=
X-Microsoft-Antispam-Message-Info: Xyeup91mLD1TAHpg90frvGO7fiatVEcoJTKxrF6tFt0I6usWQX0IWuiGELelfYzr/f1UVeKCGpFLm+3oLD3vZxyNijhyFtaVPeewfLYpN1ySr/YGEmIBINkZdFzRHw7VJ6lL0rDhU0yWfB5fR7e/XaY41lTg1IypjzLxaRmmGPCqyZ1//SvSoMoq4KrYvcz6
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;6:WfiTUsIOhKRNUefm7a0Ni1Tv79FpabWetiKG0XD8TaUtfJffXFfiDiku1hk7ZCv81c3/kxjFddglb0veI6AXz/HLg58hu28jqUKIve5idjYMTzHOQCLkgXVeRVfTkCNAuGhy3SgJuA45IDo1JnrBaunEOB/zEB6EclSz21vDcDrBIryaCEfm7KJ2jj5ZFFdCzGnTYqe1rya0H4p1x+61OHS5WA4RnR0WCtobN2NawBSEOL1G8QHI9vLIlHwUYBZSm/7kkrYPg+DZl+ZQbr0PenqqXO57L97KMMskXHYxeDLJqmxOCd8kopcJPG/GyyPOqyfYR28SF1aWj0FBxIVnYFgV26USqW6TF9MtD6Um9RohpZjcmc9x5ox1MmJ2za0eabPFeI6s6dEm+PNb/hu86mDj4t529YY9f55w/9kPb+YWH1wRwKpnjB381KfXaZRlEG7BwSgfTRu6TUJrnCFZIg==;5:sMWLZPF8+pl9ztZa/wBxmdF2vuouGa9BdDFtey9fsfGyw753LJ9rQ1tXkPbMVioYtPUnljok9O4T06zwGEWmAKIrO9Pxv36/n1KetcXi9FdcbFRaI63c325/JK7r4DWgS/818/aHZacSkTgUL62Fhoht/u8+/YsdgbkigzCUvTk=;24:DOuzhp8qFTN2ML4d14L9ps1zTOmybPrXSawJxbxcGKIQzWXos45vy9zh6yXn7bNHiwJ1w5ht63MNeEi94n+JM2v99uUAwUFbJbBhwkY0Zus=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;7:4ESr/SJDvonBc1nWV59e5uumJC1xo3EJeWpRRwgeFNSBca1RymAiTYBDNxsJ9oIiK/9yYd+c9GoKLmwxQ0jDujZxv5OTU0fK1G11+5Or0kPXE+fsOuBsQK0TCAKmbWQQ3RjV5554VrHEfX/HlTpQGUu6U8oaaKfC1FQcLNBtsxehIs+pgiKVxSMhU4wJkDyWV5bohBVHBICppb+YCOYuglJ+vikOC7QLLKe4vGq4A5UANbnlyBoaFbm4eDf8O8TG;20:iCsiFhE7dru1JU0OCgtbqBNhXBJd2LFNG2rp0gzI/txVOkJ2p4vCYbh2WUTaNzyPRHZ0W7NeiJZFsv4Cw9KJ3STLiljnxQHZv7kuDn3xWStBV7es8d2A3nInrThIFJB4+nWcFjc/EMZOaF6VvctynJl+NyGWAM+ErAmvHJOmzJk=
X-MS-Office365-Filtering-Correlation-Id: 4f0821e9-add4-4485-e03d-08d5a6a3354f
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2018 09:43:44.3194 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f0821e9-add4-4485-e03d-08d5a6a3354f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1341
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Juri,

On 20.04.2018 12:25, Juri Lelli wrote:
> Hi Kirill,
> 
> On 19/04/18 20:29, Kirill Tkhai wrote:
>> tg_rt_schedulable() iterates over all child task groups,
>> while tg_has_rt_tasks() iterates over all linked tasks.
>> In case of systems with big number of tasks, this may
>> take a lot of time.
>>
>> I observed hard LOCKUP on machine with 20000+ processes
>> after write to "cpu.rt_period_us" of cpu cgroup with
>> 39 children. The problem occurred because of tasklist_lock
>> is held for a long time and other processes can't do fork().
>>
>> PID: 1036268  TASK: ffff88766c310000  CPU: 36  COMMAND: "criu"
>>  #0 [ffff887f7f408e48] crash_nmi_callback at ffffffff81050601
>>  #1 [ffff887f7f408e58] nmi_handle at ffffffff816e0cc7
>>  #2 [ffff887f7f408eb0] do_nmi at ffffffff816e0fb0
>>  #3 [ffff887f7f408ef0] end_repeat_nmi at ffffffff816e00b9
>>     [exception RIP: tg_rt_schedulable+463]
>>     RIP: ffffffff810bf49f  RSP: ffff886537ad7d50  RFLAGS: 00000202
>>     RAX: 0000000000000000  RBX: 000000003b9aca00  RCX: ffff883e9cb4b1b0
>>     RDX: ffff887d0be43608  RSI: ffff886537ad7dd8  RDI: ffff8840a6ad0000
>>     RBP: ffff886537ad7d68   R8: ffff887d0be431b0   R9: 00000000000e7ef0
>>     R10: ffff88164fc39400  R11: 0000000000023380  R12: ffffffff81ef8d00
>>     R13: ffffffff810bea40  R14: 0000000000000000  R15: ffff8840a6ad0000
>>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>> --- <NMI exception stack> ---
>>  #4 [ffff886537ad7d50] tg_rt_schedulable at ffffffff810bf49f
>>  #5 [ffff886537ad7d70] walk_tg_tree_from at ffffffff810c6c91
>>  #6 [ffff886537ad7dc0] tg_set_rt_bandwidth at ffffffff810c6dd0
>>  #7 [ffff886537ad7e28] cpu_rt_period_write_uint at ffffffff810c6eea
>>  #8 [ffff886537ad7e38] cgroup_file_write at ffffffff8111cfd3
>>  #9 [ffff886537ad7ec8] vfs_write at ffffffff8121eced
>> #10 [ffff886537ad7f08] sys_write at ffffffff8121faff
>> #11 [ffff886537ad7f50] system_call_fastpath at ffffffff816e8a7d
>>
>> The patch reworks tg_has_rt_tasks() and makes it to check
>> for rt_rq::rt_nr_running instead of iteration over task list.
>> This makes the function to scale well, and its execution time
>> does not depend on number of processes in the system.
>>
>> Note, that since tasklist_lock doesn't protect a task against
>> sched_class changing, we don't introduce new races in comparison
>> to that we had before. Also, rt_rq::rt_nr_running contains queued
>> child cfs_rq in additional to queued task. Since tg_has_rt_tasks()
> 
> s/cfs_/rt_/ , right?
> 
>> is used in case of !runtime case:
>>
>> 	if (rt_bandwidth_enabled() && !runtime && tg_has_rt_tasks(tg))
>> 		return -EBUSY;
>>
>> the behaviour won't change. The only change is that walk_tg_tree()
>> calling tg_rt_schedulable() will break its iteration on parent cfs_rq,
> 
> Ditto.
> 
>> i.e. earlier.
>>
>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>> ---
>>  kernel/sched/rt.c |   22 ++++++++++++----------
>>  1 file changed, 12 insertions(+), 10 deletions(-)
>>
>> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
>> index 7aef6b4e885a..601151bb9322 100644
>> --- a/kernel/sched/rt.c
>> +++ b/kernel/sched/rt.c
>> @@ -2395,10 +2395,10 @@ const struct sched_class rt_sched_class = {
>>   */
>>  static DEFINE_MUTEX(rt_constraints_mutex);
>>  
>> -/* Must be called with tasklist_lock held */
>>  static inline int tg_has_rt_tasks(struct task_group *tg)
>>  {
>> -	struct task_struct *g, *p;
>> +	struct rt_rq *rt_rq;
>> +	int cpu, ret = 0;
>>  
>>  	/*
>>  	 * Autogroups do not have RT tasks; see autogroup_create().
>> @@ -2406,12 +2406,18 @@ static inline int tg_has_rt_tasks(struct task_group *tg)
>>  	if (task_group_is_autogroup(tg))
>>  		return 0;
>>  
>> -	for_each_process_thread(g, p) {
>> -		if (rt_task(p) && task_group(p) == tg)
>> -			return 1;
>> +	preempt_disable();
>> +
>> +	for_each_online_cpu(cpu) {
>> +		rt_rq = tg->rt_rq[cpu];
>> +		if (READ_ONCE(rt_rq->rt_nr_running)) {
> 
> Isn't this however checking against the current (dynamic) number of
> runnable tasks/groups instead of the "static" group membership (which
> shouldn't be affected by a task running state)?

Ah, you are sure. I forgot that rt_nr_running does not contain sleeping tasks.
We need to check something else here. I'll try to find another way.

Thanks,
Kirill
