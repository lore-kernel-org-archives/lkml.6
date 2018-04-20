Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755261AbeDTOa5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 10:30:57 -0400
Received: from mail-eopbgr10128.outbound.protection.outlook.com ([40.107.1.128]:45752
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755050AbeDTOay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 10:30:54 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH v2] sched/rt: Rework for_each_process_thread() iterations
 in tg_has_rt_tasks()
To: Juri Lelli <juri.lelli@gmail.com>
Cc: mingo@redhat.com, peterz@infradead.org, linux-kernel@vger.kernel.org
References: <152415882713.2054.8734093066910722403.stgit@localhost.localdomain>
 <20180420092540.GG24599@localhost.localdomain>
 <0d7fbdab-b972-7f86-4090-b49f9315c868@virtuozzo.com>
 <854a5fb1-a9c1-023f-55ec-17fa14ad07d5@virtuozzo.com>
 <20180420141145.GI24599@localhost.localdomain>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <5fee2cc2-e6de-6bc2-7644-778ef2185803@virtuozzo.com>
Date: Fri, 20 Apr 2018 17:30:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180420141145.GI24599@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0202CA0015.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::25) To AM5PR0801MB1331.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1331;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;3:AHGOJUpRMCVGIthaA14+FwFZ1AV7QTTEQLt2EZ/N1dgIr6sUCiMbfYOXN/uEJi0dW8vLHixLm0wWn1xO2q/zV4zgF+TjNMjn5kbKWhYSpXywSEAnQxmCpuQQdUl+VJ2Z3OUXqJVH6ddRQXktdUOfjM+Q0Xi6hPr7WJMLQMK7wktzYemDizttnYEATV2my/k3eSUcDdu1BzEnyRHiZsg7cZ2RsCuV2dfwJI6rYYH7Et7IQ3SOObhU/2LI8uph+IVm;25:TYVeW/GUeDUqXSQv1RTGmneFJ7QR4s6/Uny2zsZwF1HCeP3wQ+e5xD9fOMoIbtxaFN1etFmk7fbQSE1L4gGq1Svru+aoYQg/wDeHV7oJ8oP8dHKNtS4kXEWaEdROkCEzIt7/Lg/5ep21waohSzNZx9uncYsmFLbpSLr9UsACXKdV5neX2dL58b6aHv/uTWGUdVtJ2pvmjiPogNog3tlRpo92InPuswqJJmLSXUf+YV4RxtL/ozyJPhrpjnpx4Vt9AO31Kf7farN31MVandhpgH7hzEStRVtiHMZNQ0BFePJf0XVXVbrKJaN/QllAuWRpHUMiOjHKs26xuaRbLK/Vbw==;31:QMm+auQy3JMfHxW2Q85l4dKx3SR4wshyRHC00a9/VkM60qX93Bsjxc2yhTJDxIMsXc2h4+dL/QTmfRYhTVgqNzaaVnmaMbXDpGU8XYrDcFG7DJoq/S9Yd0pDydH95xDvDz7eKd15nj6pZz2dkDbuDFQftAF3aW2fCGPB+vmPnZmSHfYh21QZZODAmXnksWv0DencBAYiO5e1cmN+wxGSz+VDAct71rWJaSggD68cwVg=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1331:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;20:pNGp/sA7wEfRYNO5Lp0WEZiPNcnmqoIUJ+Orw+ZjNF4E0sjwL+zxWuQ2Jo/RLn4azM4VNWXTJmuaI/XTgIx77juMFRUAeoBbxvcevvNpMYmbKF1uaovNUOqyTXgTmhHUK+X2gbWw/7mYck6tGgV9uM5r7aqVBdCz1H4up5DQHU2rB7efuyE1ZtxooGiuhxSDWUkCwpPh7aL6VZYT1cI9pZPRb+nfqrhQ5XeOA3PJjyACRBntFlZzXBCOX3M20ngkzTGRxXebIUqsrzZUoKTHyv7ar71qDijmAPt1c35rvjQdO2bZFIfj0OvYvDc9BzCeONAPAgi1e8Oq7PwJtIMiiHk5R5/oyZosH+EfuD9ZpxqBOm8rnAVdN31eTtbrEWy4YjpEUTxkkV0gYKwosDiUtbU4PIvpANMo4hm7ZLUzplS5qYTm/Wwyx3gPAYoi0tzd9Zz70gtwrkQXZaXwmv8BqWNkZwnOhnebokCu7h4AJqLo3xDaM/5vA/FzyFdQHDLG;4:hTx3lKlHbG6zrwoRCXeW3Tu6pk/8g2t15etKzuxARAkxhS85sCqBtq8szDWc3RUuuaoGOZgwBpynUHD6VQxNeq/MfKqeSL83dSn7YgcRYMnriZ3GUtyjlatVu3dfuJg9o5sn1sS9SJguCSGKcdQCY7P4vhjHewZzbBU1j14gKpyx1uChpvpdU+lcCgzzXINpeYE8+YyLo+V1iVE1KdzBX9Mq9aP3yhC8VVsuMWA7fc14TJWfImv6JZ5BGw16eDAIKjX3NOljww+RaTRjvjT5PA==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1331E2FCEA99955A5A5D219ECDB40@AM5PR0801MB1331.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(944501395)(52105095)(10201501046)(3002001)(93006095)(93001095)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:AM5PR0801MB1331;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1331;
X-Forefront-PRVS: 0648FCFFA8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(366004)(39840400004)(376002)(39380400002)(396003)(386003)(8936002)(16576012)(65826007)(446003)(58126008)(26005)(230700001)(476003)(36756003)(65956001)(956004)(65806001)(186003)(11346002)(6916009)(52146003)(64126003)(66066001)(47776003)(2486003)(76176011)(23676004)(81166006)(31696002)(8676002)(7736002)(4326008)(316002)(305945005)(575784001)(2616005)(2906002)(39060400002)(86362001)(16526019)(52116002)(478600001)(53936002)(31686004)(59450400001)(6246003)(6666003)(55236004)(50466002)(53546011)(77096007)(3846002)(6486002)(5660300001)(6116002)(93886005)(25786009)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1331;H:[172.16.25.5];FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzE7MjM6eXI5RVh0aGMrSzJnbHQwdnF5V1VCMXl3?=
 =?utf-8?B?bWUvSGU1OGR2cjFGNHlISWJHODI2Z1A5TnpCS2JCQWZsRW1DRUptcFRHMGVw?=
 =?utf-8?B?dGNCd2tyRGczNWdXTHpxbEZsTG9DSXFzUGFYaE4waFQvd3FSa0pvZEdyWXdj?=
 =?utf-8?B?MlFjODJ5Vm1CUmxHbHBVakZ0ZEJVRG9kK2lxejl1OFJCS0hyTjlEKzZqelVN?=
 =?utf-8?B?N1l2VnpaRzJpQlQ4MkdjL3pLYUFoUHFHUmRkTFZnZ0hZdlJTcWoyUm9JWDR5?=
 =?utf-8?B?dVg5T2l2L2tWczVFM3lnZVNtaWdRQXc4eE5zanNzc1B2Y2duVDZKd2I5QVpI?=
 =?utf-8?B?KzJ1QlJsRnBWYllNb0tJVllVclpvR2hUUmM5bFFtWW0zWkE5SzVlQTF3eEhz?=
 =?utf-8?B?V1JVaUMzZk9nVUFESXJXTVRhVHhvQ1cvdzdlT3U5bjRsWW5tY3JQd0w2RXdI?=
 =?utf-8?B?eEhJMU9tUmsrVFMwZ2VoTG14QjNEQU5YdklLbkg5VEZBYnVNTmNkM3E5NU82?=
 =?utf-8?B?NWxPbWg2QThIQXIvTFZrbHc4UlBWM3J6ZGRFWmxmblNsdkI4bWFUREplU2ww?=
 =?utf-8?B?eDJ5MXBkTUZ5TElCL28zNVlXd0l5KzViVmM1VlplY0pNYUhSdWU4TG1ZMk1n?=
 =?utf-8?B?Uy9jLzkwbHYvcGNibzY1UDdweStvZUloK1k0dFBQdzFwWWVSUnEwY1ROd3ZT?=
 =?utf-8?B?UzR2Uk1HTmNQbVo3VERCbXZldktzOFU2VEpWZlRwUUVKUWxTeFF3ZWMrZ0tC?=
 =?utf-8?B?cks1UjFuOWUva0dGWjgvZTFjZEk5enV5dllZbThnQTVBVlRiR2RvQ1lBWlJL?=
 =?utf-8?B?cDFlV21vU2xTVWFmWStRdVpXK0FiTEJMZ0xpSGlBUXhkaUU2eHVwbHorekhW?=
 =?utf-8?B?WklsWXFjZVNnbDVDWmpJQTEvZXdjakZDK3Uxd0tvczdjM0RKWTkzdDNmYTRR?=
 =?utf-8?B?RzFtanRORk93bTRTOGVzL1BWTnF0THYrQXZIcDhLUHZydE1GZHA5Q1NibnRm?=
 =?utf-8?B?T0wzL0dMN0pZMlIvYjNZTWxqdmo0S3dxZVBxZEE0aC9ZcHNjNzJySElSOTZP?=
 =?utf-8?B?QlJ1NDg0Unc5YThJc2F1U0VxVEdVY1I5SnNkQlc5eGFHd3lXbjFsOElWN0Ro?=
 =?utf-8?B?VFllZEY0NVBKSFhXa0lzUkZuRms3NFplb2lSa1NSTzB3RFQ3N0JyQ1M0K1hM?=
 =?utf-8?B?WkpUQTVsbEJwVXVyVjlSTy9acGdVMytXNEpTdTZhdGxMUFNudUNqcGNnL1R4?=
 =?utf-8?B?V3ltRUNsSUZhYjdNdEp3Si9TVFZKeVkvTUZnNENKbkpFd1VwaTJBZWxETnlw?=
 =?utf-8?B?RXBOekhVTDhlTEpOdzBhWk5xUEtrOUdUalRJNkJFTXZlUjlkUDlxZzdIVEc4?=
 =?utf-8?B?TlUxZUFzZ1N0NDdId1dtWE8waHVZNjFEdmZPdlk2MXgxcEhiYlFTc2MwRE9q?=
 =?utf-8?B?bWNmUUZleW1IaVNWNkw2TmxUbzcxWGdlbVh5WEJrdFFSNHBjS1VRNS9McjhR?=
 =?utf-8?B?RGRYZDQ0YUpOblYreWNHdXBKOGVxVlU5cDN5YllLaWlJTG1sYW1wTy91WEkw?=
 =?utf-8?B?QmZnUzZJNjNHaEVncWRWNDBwWDBCcGRLdHdQTElDVXkzcW9jZzVuVjhoME5t?=
 =?utf-8?B?SW1wYStBUVBPb1I3c2hYME9lMGVpTXlFMUtHZ1JvSFhXTnhFMlM4MWdQRUpG?=
 =?utf-8?B?VDlrUTFEZVUvU1lreUJQSS9qMlU1ZXdLYXp4N3hMVTVzeGZNM09JWHZxQk15?=
 =?utf-8?B?SHlVUGdYNmtJY3BYSC91UnYvWGZsWmNQcFJXM2xtdUw0aDJxUG9FRGY3ZGli?=
 =?utf-8?B?TFZHRG1xdjljVkNvY0VTaEdrRXJMclhvQmsyWFg4YVh1VkQyQ2FuamRrSTF0?=
 =?utf-8?Q?kPDaY0f33NFW0=3D?=
X-Microsoft-Antispam-Message-Info: 9VJIGdldjavV6veLLZ8+yU2Am+PQz/JKUbYjCS7ThTcUkrJxXL32aKI3K9H++u68QgC7BcA18jujQMN8uPTUgCE93V+WcCj+z1P+lgtTdz1ISO4cKQOtrQ5RVkQsfR1fiLe6BRoZ3M3iU8lrLf7jBDyy/FBUtKfVriGWIw/bQJkEV46a9l6orAupgl2OirwH
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;6:5apJjUH52lm9sjsNSYn2gQhb690gYGO1fbdH6pLs6B4IdgUruEnZr/T3d03K8T9y1j8Fgtb0BCW8bRIvXKjN2q9w9wfA4Mw5l0b57IaxJablCFEJLtxxRlhQ8Mk4mWaW6IWHR85I7mm9rI46TnxwnI4AKHTIXfCy0O/RSEmZpCEvN/I/W5Yg0pwzZCZS2VTRpI0k4boX1Jaiyy8502hGHHHweh1VZzUfK/e57cEJG6CxMs35kU6l5hYapWAJYK78gSD7HguiuaJ/i6LHRmfhi2ZMdRukca0hT4OH0UWx/sl9HYFwuGPTyW0+LxQ2ZD4EfPXxcZAvc/zDCqYbCFuy2JzaeLVlm3EvkpBGCi2u4CbOeXFYs0jeTwKrBvfkM6ptKQSDx3kVpRD9c4K5lA8ogkvLGCPNhnO34xSThfTaAYBl3ziSGDgd0Mprd4U8V3q7ie8KRxeck5o2c11HzkvOcg==;5:TWstgqXG6lvGtFdBAYM75n/dbyMZ2rRU8DBa1hTHSZyHFHCSw63I4If/DFuuRtl/w7clrcmD2dX3N3+iD2dddOAKhqg38FmAk4LzBuLS7bDF1xD4VynIfbcwViN5y4rKob1qSrqRShCkXQZx7BJ9BOIQMMvYzA9/ahhHw7a9K08=;24:SNMZwpTCxjUm4om6lTEop6+9sp61d5aBXopci3F/8HQADFj9HkqFpGXrkj1FdgLeV4ZF/44cWSa6YOu7sf1XfAmGgdNiA6GqMrep57nV7HM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;7:0RwndEebLdJIShNEPoIfc4Jn/8gP0QTJpAvSaa6AlJKDV3M20jvBC0j9GZ3uNNFNfLMNE3iBo3nRrie8opyOx0/VTT0lmS+2rWXwAO+JFYaBIu+s47qRVS54ztePVpWd8LzE8k2htw8YXQp5fbrjd85jll3/N6T1RjDpRKKnvQZg94/TkCIwBbIMB/Y7LlswRYNRmuYqqKnT795on224VypxODdkpXsE9exQ4lurqlwb+yOrDtCHMDkr2QqyunD0;20:6qaKl9pNqjHYKhsL2vdCRaI5hRKDwlDZPhPMyLRg3GmF/Ru5j8Lz8gg2OMxVzOY7/gKmDh8bcsGNWoQ9PGBojeU1Wp8XDcAHh90E+z4MzmDluUF8nkDvmdhw7J4BeOATmmrqjFvz0DPDk7XjSzn2yKkMZqiVW8lk3x0Xz7CbiO8=
X-MS-Office365-Filtering-Correlation-Id: d6faafe3-dc24-4f0d-99d9-08d5a6cb4e45
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2018 14:30:46.1016 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6faafe3-dc24-4f0d-99d9-08d5a6cb4e45
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1331
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.04.2018 17:11, Juri Lelli wrote:
> On 20/04/18 13:06, Kirill Tkhai wrote:
>> From: Kirill Tkhai <ktkhai@virtuozzo.com>
>>
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
>> The patch reworks tg_has_rt_tasks() and makes it to iterate over
>> task group process list instead of iteration over all tasks list.
>> This makes the function to scale well, and reduces its execution
>> time.
>>
>> Note, that since tasklist_lock doesn't protect a task against
>> sched_class changing, we don't introduce new races in comparison
>> to that we had before.
> 
> This seems to be true. However, I wonder why we are OK with current racy
> code (against tasks moving between groups). :/
> 
> Can't a task join the group while we are iterating and we miss that?

Yes, it can, but I'm not sure either this should be considered as problem,
seeing the race design we already have. It's not a real protection, this
place is to warn a person, he does something wrong. We check for zero written
there, but really written "1" will invent the same problems.

There are cgroup_threadgroup_change_begin(task)/cgroup_threadgroup_change_end(task)
to protect from cgroup change, but it seems we can't use it as they have task argument
and aimed to protect single task thread group in the future (despite they take global
percpu_rwsem).

Kirill
