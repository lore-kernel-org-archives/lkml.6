Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932848AbeBLFr7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 00:47:59 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54650 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750838AbeBLFr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 00:47:56 -0500
Subject: Re: [kmemleak] unreferenced object 0xcd9c1a80 (size 192):
To: Mathieu Malaterre <malat@debian.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        LKML <linux-kernel@vger.kernel.org>
References: <CA+7wUsyxpHnq_POujjwEVXhJjE5GRLN9GypV+63g1OFmfq=_ZA@mail.gmail.com>
 <CAADnVQJnobUCg4ZEkHUgAAMXiw5w1K1DLqo09005mPPgOuLD+g@mail.gmail.com>
 <CA+7wUswo-XwiMEcSTnB3HQE6qo2YUJxeSNije3KtFoy6CqzQoQ@mail.gmail.com>
From: Yonghong Song <yhs@fb.com>
Message-ID: <3fa5958d-c14e-56bd-de49-84fc43db4b32@fb.com>
Date: Sun, 11 Feb 2018 21:47:02 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CA+7wUswo-XwiMEcSTnB3HQE6qo2YUJxeSNije3KtFoy6CqzQoQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:180::3766]
X-ClientProxiedBy: CO2PR06CA0055.namprd06.prod.outlook.com (10.165.93.13) To
 BN6PR15MB1826.namprd15.prod.outlook.com (10.174.239.11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9063beef-49c4-4a77-c2c2-08d571dc109a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BN6PR15MB1826;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1826;3:9BcBVpgvApaNj+tH8EXyXsdOl2xo/dysGPgp1pu+kyXwO28zsSOcQBw2KmOmSUSjsZWDfZSSpdaw1+92OxKqd/kz4eYUfAoMSxtAZdrdeIeECJlJhAgUpeY4+HHUYjwo8WSxFrOf4aJcb0TXnlg2CVVsXul5ugK+nGjLGoV3ztKvSiGSctcT+kw4nxXcb6NBclwlD7RE1ANvFQmk794hjIjyN7I7Jq8HmADWr9HyM4ASpGWSHDuosPK4rWSUHcfl;25:YaBanNRVqHRB9gLY8mh1Wb0YJK79GL5krPcX59EnqRf0z+QIvKpUARIDazWs/llodq8O58t9ELYT1maejscIFzW7VIHsN+EmTMSwWsron5YJlyWgdaOp9UQ3YzI7o3g1uUt2t0MENQRfjeEdHKtK6OYcDBBQtWD3e7LcxxO4Tfg99+YxugZQO37qyy3Losu6B8IpSy10XLCUjI63CO7Cue9sFJKQc+4qFVnZGtD5s6zqHrLoJA3WRw71PjhCB/09UOViCGWY3mEIFyx2dJoRkyDPnxinQKhEPmA5WSdrCI26VRDR1nVy/Bolu1xtZA2jqYHyl02JZlM1A7tUwWcA6w==;31:QBaEtoFHbbaS7kfTJa61Q5CeuSRm8uBnahQBfTCBWxPOtaj6D6gmlL2/huke7peJksj+GOeRVG+rcPuXui8fTBXktQbnRietXNAIDswPP4T4Rxl5dwHZsIBY9LKuHXX7VlOhsQONSK+cKJhmC6PmfvxIxaY7nWuc93IMBwzWWIS19Y81k8Pk7f4Z65m6Vc/sXNjpqWZmq0JnCF/MLkiXETRBE5kjKHkaQWyXt+DU9pU=
X-MS-TrafficTypeDiagnostic: BN6PR15MB1826:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1826;20:PdfpLQbLHHndbY8mnGPE89+9YnGWiOVLyzY5DkiUUvcMkJgZPzoX0otMzzZsOOm3E1vQSziSi1NFbBoAwrU8EgjjfjqEHygohqow1DhFyXnRhfgEqP30sMbGwnKxMryKM0mtEk6qA6kQJOSbV3Mpj27+pc9ZizyYk6lTryWBjwRAgFK2m7HXVh7cpoSLmFoyOJUfKKwgjhvCowpzaMoxwm0f0GS0JU6IpHIkuyi/mf72CZ0EPcJ3Rdi8LRSi1RL8ySEN7Fg4FCm7Zpx1f5m+ceH1srv09r5h5Wlz1eOjEikpfu2o9DNgFCPytrVrTVKZtEdW1/y/WdlQhq7hJ8SzF5CcxAO59Iuw0RZmyZAL/EC8WSFpziu3Hrj7oOsS4a82UfylDCChsiEA3tV56Bmh/L+MPLyTXNxmeoc/Yd25FkdyR0il8k4hBGnVxftTbrDqeSfgNq27gWd2jX3mTz5HbfSvIWy3GsBu/iKosdsKbRK6gf1/fTDIE2YkQ2wqpRQU;4:+BCeF4w7jdwhtGyRCh/scSstnvqEkCSQ9xhGxvAz6V+S6l5qb3ILX6/vc0vFXrtIjh2mrAzj9cczSJYdxUKK1lnFKkuJ31yvDgWB9tMDyDjL4x3qFLn78vYbAPqkubZaFKRL/F8F+inNuSJOzqIraYcsfNokANhhjK06yBsNmzduG4PZE6cmWPHp4LrgsiBwH5fBxvwpYX9IINyCNi/OCo+LAIpXPYXFafl4rbk5iY8X7ZZAeuMfTgphj/Zhap02Q7aYj6rmQTgOMozSdsE757q9cArBJivvM3peU2FcKoLibco5QaN7E9Z3JFpV7Pb/ylJP8Lk4FnvywzYD6JeBQPFPzGj3OxeV5ZjE9sb5+dU=
X-Microsoft-Antispam-PRVS: <BN6PR15MB18265B34A4CDB9938A7BAE03D3F70@BN6PR15MB1826.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705)(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231101)(11241501184)(2400082)(944501161)(10201501046)(6041288)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR15MB1826;BCL:0;PCL:0;RULEID:;SRVR:BN6PR15MB1826;
X-Forefront-PRVS: 0581B5AB35
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(376002)(346002)(39860400002)(366004)(189003)(199004)(65806001)(50466002)(65956001)(229853002)(2906002)(478600001)(97736004)(47776003)(6486002)(6116002)(316002)(4326008)(39060400002)(36756003)(6246003)(31686004)(25786009)(54906003)(106356001)(52146003)(65826007)(83506002)(7736002)(58126008)(110136005)(53546011)(53936002)(67846002)(305945005)(59450400001)(64126003)(6506007)(2486003)(6666003)(386003)(52396003)(5660300001)(68736007)(52116002)(81156014)(76176011)(23676004)(8676002)(86362001)(186003)(2950100002)(81166006)(8936002)(31696002)(105586002)(6512007)(16526019)(230700001)(42262002)(505234006);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR15MB1826;H:MacBook-Pro-52.local;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjE1TUIxODI2OzIzOjFOU3Z3YnlobzYwQlNFc1pKN1E0cTJ6K0Ev?=
 =?utf-8?B?M1ZoV29YSkZQY0NwNkh5K0lWd0ZSZmYwTE4xZmprL3MvWW9HdW8rSEJNdHlR?=
 =?utf-8?B?czl0dWJkSzhUbm5paGxRR1FYcVI5ZGE1bXpjUnl6dTdkMmt3WGVLRHJUdnZn?=
 =?utf-8?B?Ui8wc09USitjaWVCOXVRcEdMakhNNDErdG1McVZkK3kySFpOMzRjZkNpdzRF?=
 =?utf-8?B?cmpqc3dDaGlmT0x2WU8rcVNiRnJCWisrTEtyT3UyQlpNc0FNSWNJcFdJdDI2?=
 =?utf-8?B?ekZjR2tzVUdLbDlIQUpIZkNoajhFS08yL012RXQzdm9wZ2F1OEJZWUg1MDNj?=
 =?utf-8?B?M3UxMG1USzR2V0d5dDZ6eEs5UFhqTThnaXk2K3p5dTJublB6ZlR4djd0QXUy?=
 =?utf-8?B?dWgrRWdVUXdvcExsQ1N1dXZFNGlKa1piUTJrQXU4Q1BVWllnYksrYjBOUWFv?=
 =?utf-8?B?Tmg0Y2NuTndIMUtNSDB4RG1rQTZQb21Sb1EvVm1xYU9NYlN5NjVETFRFQ29V?=
 =?utf-8?B?b0VHNllrK0R2akFUbm5BK3pvYys4VXJiclRYZnFBVjlTb3pXMit3aGFBUkRu?=
 =?utf-8?B?bndxTmlkZHhxbTVWM0hhbm9YWTBGZkxwd2Z6TC9nL3plbnROWnJTbDNhZ2Y4?=
 =?utf-8?B?V0ZwVnM1aG93YjNTbk1ycXJZeUdTWVJVd3RDUEJMY1J0OC8rZXZCcis5SGFw?=
 =?utf-8?B?dXVYZG1QSDlxM2wzcURieFNYLzNhVVMrNWJjUURHTnJzSmNRdk4xSGxKMTRH?=
 =?utf-8?B?Rjh0QnNGSmFubXEvSVVRL0M5K0FmSzVWTnB4UlFHYWF2SmhwQVVKcitSTFU0?=
 =?utf-8?B?RzBtOUdYcFZJK0NHUGQ5VDIrSDBBVFBKU2NXVmZ2YUVjWVlYWjc0N1BibUg5?=
 =?utf-8?B?Y2pPNTFWZjViZnl0WXJpcGsvYkNUSVI2QjJadE5raFMzQkFRRk5GSUVKSmVY?=
 =?utf-8?B?cXR3cytuMC8vVFZWdXZvMWVINU9OYjNRYlFFYkVjVVA1UzF3QnlOZjg5bUJN?=
 =?utf-8?B?QzhJQ0MwdEtYb2xNcFNqNHIvYkVJNDNDVE5SMnhqaWE2RGZLNXl1MnhodFRl?=
 =?utf-8?B?RkxCVEJoYngvaU1scjdFNXRGQklTU3ZFSVc0Sm55UGc2ZnR2aHE1RVpCaVlR?=
 =?utf-8?B?RzNISVF2RGdDdjkxcnFjMzY4V3g1UXAwTW90Rm9aVkpjUnhMdEJwM0dlcVlz?=
 =?utf-8?B?Y05BdE5tQ0VBWEV6blQrR2NTQ3ZHZ2FoTjhKemdyeC9MYUFwdjhqZmNvN3g0?=
 =?utf-8?B?eG1hek51N284Qm1ZRGM0UFlhTkk0SzBVQU1xMnI1THNGaHgyYS9OMUFLdGhj?=
 =?utf-8?B?OGJZa3BjbmluZVRxeFJaRGJGYWV2dmZVRW95dVVkd0puVkorQSswSk5JR0lU?=
 =?utf-8?B?dTVPWlJoWm9XdUQzQkJUTm15YUVLUVVuZ2hPZk9CY0Z0OTRhMmgvZjRPcEZu?=
 =?utf-8?B?b2h6MkU1bjZUSHB3ZU9NS1BvVzVuZEF0ZkdnQkM5VW1jeDB6Q0dleXFNZXBv?=
 =?utf-8?B?ejhBdG1UTVd0ODlPRWd6dk8ybkYzOEVNek9hTjAwQ0N5MlFlelFzS0tteGE2?=
 =?utf-8?B?UXFYNUpwSXlNSitsUnpPc2lQUXFvYVc0K2xEekxPcnJiM1h4T1JHNW9iMFBh?=
 =?utf-8?B?R3YvYTFpMjlXdllUMXltc1YvUUZxdjRBMHFBRjQveTZzY2hhaGdJdUx2SFlI?=
 =?utf-8?B?WnphbEc2b3pxT2oxTEl2UFBaT2xBUDU4cWZDQVB3WUdWaktTRmRBSUVxcDla?=
 =?utf-8?B?Ymo0Rkk0MjRQQ1R0S1NrbVZScG9zeThEZlZMOEJaendNUmpxdVN4bDJvUG5z?=
 =?utf-8?B?YlBudGh1WnB4S2oxVDVIdS9PUGgyVEJPZUVidUE2THlnWGJ6UFA4WmhYQjJN?=
 =?utf-8?B?NEdXb1M5dU1GbXZ0cXRCMGY3VUs4b3pha3NUSlFldXhiT0hOWDBCK2FiWkUw?=
 =?utf-8?Q?QcH2hCGMxcO4VWVgOtRMlwYuYapRpA=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1826;6:5lIP2iNG9juyN7wVhFowSpyyv0ppCm+PAIgpVinO0URVKPwI8k9ukBMsmgcWpwz9kFDtHwTYPq/K3f9/hA4OoF6MZ50LTTt9wNNBIRaFlxOndPyFtpE5s12KieDYdif7GIw1rHkhLUzKbbfs6oipjQYkPfRcq1N364JZFjN9FZiILMG5fVP+v++VTnDUOI0m5p0jQlKR/7JB8PPvDy0Z/ifpRrIJbaf+BvHw/82ZIH9BRr8SPjP2dp1AHszEGBacz/w3v5kmHDUgdco6zB2uh5sOyCTZrG7tPt49F3isT7XnHJLXB0/a6bC4I+SynTbhcZrAFYyNalMWIGyQDaFCVUKQRZAcOVndDDOEE1P6PXY=;5:QhIGl6kqIu2ZSany+oI0e032Ekizk3aEVSNiJOJ0T61teRm8XiKRO1mz7rhf3p7buvbAwYewHcN+rGupzolgOjLTdMwhAvW4r7p7jgWvw+5wEFoOI9j7NcG5vOoHozxqxbYy0lkSVpRwtjTGvWSeNh2FRozu/75hZKqOfEAfJKY=;24:wT9aACUsgzXiez8sI1TToznNPCWJaP+kEV3c9wG/KCy78Qa4ivjNUEiAKeO5vyYd4rkN3vtDcVOo5DBrVqTihhzK6r6oRSYHUeUdxtJlQzo=;7:DvfVC2NW44VM2uA9rNB1QJXlnvR12ikDljRBDo46owpKziHLyYeVbPfQezciuSvN2qTme/Ilh5C21bbb3/CjSbAePeFmjU1hZQqrywzPusRVMLjwd6WepJoWl2hVBZ14/R4rrymp63rWn/uUUD4lFb49fy2VZTewNwvjo+N/Lc4ChVC1vVsCX1bCI1wcKehxHEPYLpVN6lUiozAWCSxE8mhbnwIJPT6FXn9x5Dmm9XEVLNNd/v3AiFLKMcOtnagf
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1826;20:ZYFsYSfDlHk/lKzLMuptAxmYVew6yuute6a9L5SJjhsvvw34wiU+yEUtKNZhjdxOdM8twLwAwpT8AnoubChHtn3q/H7eBQ5vft5KuQWuRlqdL/Hbi0gBbjy4OvKIuhMqvH4AlE1vHrAPedsiO4/iQap74drf/QaNkRW7GZegVWw=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2018 05:47:11.8466 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9063beef-49c4-4a77-c2c2-08d571dc109a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1826
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-12_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/11/18 11:18 AM, Mathieu Malaterre wrote:
> Hi,
> 
> On Sun, Feb 11, 2018 at 5:54 PM, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>> On Sun, Feb 11, 2018 at 7:24 AM, Mathieu Malaterre <malat@debian.org> wrote:
>>> Alexei,
>>>
>>> Could you please comment on why I am seeing those memleaks being
>>> reported on my ppc32 system ? Should they be marked as false positive
>>> ?
>>>
>>> System is Mac Mini G4, git/master (4.15.0+), ppc.
>>>
>>> Thanks for your time
>>>
>>> $ dmesg
>>> ...
>>> [ 1281.504173] kmemleak: 36 new suspected memory leaks (see
>>> /sys/kernel/debug/kmemleak)
>>>
>>> Where:
>>>
>>> # cat /sys/kernel/debug/kmemleak
>>> unreferenced object 0xdee25000 (size 192):
>>>    comm "systemd", pid 1, jiffies 4294894348 (age 1438.580s)
>>>    hex dump (first 32 bytes):
>>>      c0 56 2f 88 00 00 00 00 00 00 00 0b 00 00 00 0c  .V/.............
>>>      00 00 00 08 00 00 00 01 00 00 00 01 00 00 00 01  ................
>>>    backtrace:
>>>      [<6c69baf5>] trie_alloc+0xb0/0x150
>>>      [<fa093284>] SyS_bpf+0x288/0x1458
>>>      [<82182f53>] ret_from_syscall+0x0/0x38
>>> unreferenced object 0xdee25900 (size 192):
>>>    comm "systemd", pid 1, jiffies 4294894540 (age 1437.812s)
>>>    hex dump (first 32 bytes):
>>>      c0 56 2f 88 00 00 00 00 00 00 00 0b 00 00 00 08  .V/.............
>>>      00 00 00 08 00 00 00 01 00 00 00 01 00 00 00 01  ................
>>>    backtrace:
>>>      [<6c69baf5>] trie_alloc+0xb0/0x150
>>>      [<fa093284>] SyS_bpf+0x288/0x1458
>>>      [<82182f53>] ret_from_syscall+0x0/0x38
>>
>> hmm. looks real. Is there a reproducer?
>> Yonghong, lpm map not cleaning after itself?
> 
> Not really. I simply boot up my machine and wait for the first kmemleak scan.

I am not able to reproduce the issue. Tried with latest net-next on FC26 
with kmemleak on. I only got this one after bootup,
'cat /sys/kernel/debug/kmemleak' or
'echo scan > /sys/kernel/debug/kmemleak
  cat /sys/kernel/debug/kmemleak':

unreferenced object 0xffff99701a7386e0 (size 32):
   comm "mount", pid 1856, jiffies 4294669263 (age 98.440s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<000000004668ec00>] security_sb_parse_opts_str+0x36/0x50
     [<00000000a9807d2b>] parse_security_options+0x3d/0x60
     [<00000000cc1e1d58>] btrfs_mount_root+0x139/0x720
     [<00000000bdc4f1a3>] mount_fs+0x30/0x150
     [<00000000f189f1bd>] vfs_kern_mount.part.26+0x54/0x100
     [<0000000093ae5db7>] btrfs_mount+0x184/0x914
     [<00000000bdc4f1a3>] mount_fs+0x30/0x150
     [<00000000f189f1bd>] vfs_kern_mount.part.26+0x54/0x100
     [<000000003b67b9fc>] do_mount+0x5b9/0xc70
     [<00000000de4073a0>] SyS_mount+0x80/0xd0
     [<00000000fc5a968a>] do_syscall_64+0x5d/0x110
     [<000000003d61f5fc>] entry_SYSCALL_64_after_hwframe+0x21/0x86
     [<00000000458a6ffa>] 0xffffffffffffffff

Not sure whether the above is a true issue or not.

However, by inspecting the code, I do find the trie_free in lpm_trie.c
may have missed freeing the trie memory.

The change likes below should work:
-bash-4.2$ git diff 

diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index 7b469d1..cecb259 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -589,6 +589,7 @@ static void trie_free(struct bpf_map *map)

  unlock:
         raw_spin_unlock(&trie->lock);
+       kfree(trie);
  }

  static int trie_get_next_key(struct bpf_map *map, void *_key, void 
*_next_key)
-bash-4.2$

Will propose a formal patch for this soon.


> 
