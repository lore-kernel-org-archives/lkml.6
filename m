Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbeDTTvU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 15:51:20 -0400
Received: from mail-ve1eur01on0101.outbound.protection.outlook.com ([104.47.1.101]:53792
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751159AbeDTTvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 15:51:18 -0400
Authentication-Results: 01.org; dkim=none (message not signed)
 header.d=none;01.org; dmarc=none action=none header.from=virtuozzo.com;
Subject: Re: [kcov] watchdog: BUG: soft lockup - CPU#0 stuck for 22s!
 [swapper/0:1]
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: Fengguang Wu <fengguang.wu@intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-kernel@vger.kernel.org,
        lkp@01.org
References: <20180419030135.nn454aqxlqdwe7ah@wfg-t540p.sh.intel.com>
 <be75eae0-624d-f5ab-1b07-9a0d86d366b5@virtuozzo.com>
 <20180420164523.zrjykc4jhx73cfjo@yury-thinkpad>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <2c5e3996-d50b-416c-92aa-a554085cd656@virtuozzo.com>
Date: Fri, 20 Apr 2018 22:52:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180420164523.zrjykc4jhx73cfjo@yury-thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0301CA0020.eurprd03.prod.outlook.com
 (2603:10a6:3:76::30) To AM6PR08MB3255.eurprd08.prod.outlook.com
 (2603:10a6:209:47::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3255;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3255;3:B+vzqrSwGMIlk44uirQiZClM+2fkSTwDHREgvlf3bAjvbgrgo2ef8uXFREWlaJPVGhPYdrHyibrg7sw0enTCkhlyWqRVruqiDN2mvSbHqRjj/ch7RM/g8KNsF9CngsIGJ+vu6I9q2EOWSQZFOvyRpBPTgVydRs9lEjSvUlzW4xrZNhSoI3zVD7sfxFIaYIRwuM3lVIt9xH2V2eDXHgsANH4ImhYUooKOVouRrOTZvhucWPNaM+Nsgm1diC3E69zH;25:rjx2z6XAhSvtTlDapzIR+stKklzLoleZKKZAPtOaMXK+h5bKudDNunnasPRePBdi5xpKShpVXw4BbOcMRxELlEQxP6ZhtUojirDTTC9ZecXo4TN5sJWlLQsOIPkcM3heQiX6DHxa5RAX+qBKG7rFpA3NQICNDSG45hAF08n/G3zOGUMHBZEDL6Sc0iXnm7vm7k0RLgrarTjl+PENIOC7aE69ak9QTGEuLtX7iY8LhWpv3Ebuuzr37IQ/D8jRpQI/v/swqcX0ZtauHozrKJ+Krdh0Pp32dXfmfvGZOuo8oeGrIHfpBwtYZMTMOq1S53q6vnl60lU3Yf1xPJDaictokQ==;31:s4hBa76ALp05Z2EOrNDI6+blIk4aJ7toFBSLHW++fQBzqubf0qGMqRT+KKZHW6EaekzLH+lFQvXcS94NxjzzmZXxKQqLZFfqLnG99Iok9wPX7bIG6acGW6R3VFQZ6T08j1Gxa/o/0MghPF9qBhk3ME5MnEW18Izb3T57MryqVqrGeCHPOmzpE83xbD8SOdraqr5OtxpN/Ck8khsfAGMGLoK2A2rdafW8lMkJTaDhQ70=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3255:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3255;20:tA9fRCIGS6z+Ic2tNYoZ6KPxZddq4tSbjGjvQaLrq0+Yqv7akffAgFlaCZnzcxYlSpIQV99szMnRvqbJ3cDv4SuGu4GKFfi813tf58ejunfqvfsVgoDffpP2WKZNvJaMCHpEskLp4++3eb8Vw0EyZQ8nw+uy3USU+lQGbYBWvlL8WhuZZ8oSDw7VJxmXjodPrRB2wEEy/nBjndqy3j72MjGQAw26ov8iG1IzUVtgyS2tnMQ9+isXy+4bvlfb7ADQruW09D7Xl5u53/hoqGZX/ywVHAZbZf1BCUDNzIJ55TGiRzlW3ulPVCe5tpkQ1AjoxmrpOWzkP4pIXvMZOrDI/0P7y0I9NnN4khwXyAoY8IFiWy+9XxxhUaTsTGdxu9z+Ny7dp2MjqnYhqs9gutm8PfMK7YIO0TSVt+yq97CXd8Lbl1f520EBNEZMG/0uyhQ18fgk1u4+AKARnWAF5uIuvyVrH9SlDH3K3txyMOwc7Ob9beekR4sz3Ha2PEFWSVqB;4:/RLal9MrR61jDxtNg1UVHHe3gc1nImhgXKorzRKUoCbtZdy3ErfLJI1o6K4l8WuqQBJQ+C/6GSAHlF1p93waquXqdnE1Me0J8hrJ1qDQBYuQ1r5oB8HxsE/slbLK/Q5mJ7EY8zEkxQnCsnfPgqZQNLYVni7BxOps/vG9X1anNxZnDoXiWYnjsXp+u+56EIT7qy8O4RqTUCkK0mkqD8Ge/pkd61zuJ1DfLfwM6IMH9qHqPYqfk0EaKtxk4Dc+anbu5K8C5AMAhwm9tEAkv5toWw==
X-Microsoft-Antispam-PRVS: <AM6PR08MB3255FC3BA5ADCA5409FCF21BB0B40@AM6PR08MB3255.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231232)(944501397)(52105095)(3002001)(93006095)(93001095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:AM6PR08MB3255;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3255;
X-Forefront-PRVS: 0648FCFFA8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39850400004)(39380400002)(366004)(346002)(376002)(396003)(69234005)(81166006)(76176011)(305945005)(66066001)(47776003)(4326008)(2616005)(77096007)(956004)(26005)(53936002)(11346002)(52116002)(230700001)(2486003)(8676002)(6916009)(65826007)(52146003)(186003)(23676004)(6666003)(446003)(6246003)(16526019)(25786009)(6486002)(7736002)(2906002)(8936002)(50466002)(54906003)(3846002)(6116002)(316002)(36756003)(478600001)(229853002)(5660300001)(16576012)(31696002)(31686004)(55236004)(53546011)(386003)(476003)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB3255;H:[172.16.25.12];FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjA4TUIzMjU1OzIzOmlFeDUwQ0V1YnkyNEVqVTVqMzNmOWJKWjhj?=
 =?utf-8?B?clYyeGtoUEhwVFovakhJVUJnTDVFTkpYNDQwaGl3amFzcnZIaDB0dGpyVjMy?=
 =?utf-8?B?M3B2V0luVVpTQUJjN0Q5eFNlanlmWnFQbnZOWGZqUm1tRUJyNlQ3SmdLZnc5?=
 =?utf-8?B?MURNT0FUVFA5M3VWblQweCt5azVqVjhYaGplMTFGWmV5QjdRbXovb2VyZ0FX?=
 =?utf-8?B?YU1BQjJMK21oVzFxYmpFbExNanV5RkVFcElmOGFVQjZQcFJHZzRjZTl1ZTEx?=
 =?utf-8?B?SW1Gc0ZQQ1JOTFF0SEVUUHA0T3laQUVLTEJQOXg3MmpWZ29GSkNrLzN5Z2FF?=
 =?utf-8?B?NWJCNEsyaUNwYmlpOXpzeVBmcXhObEV3b0NJWUV2U0RGbUk5MEd4cXFZZ2F4?=
 =?utf-8?B?SmFtZ3R2NVkveVRHNXBvQ3B3dXYyUjZGVFJxbFpLWEw5aXR1emQ5L3REaG9w?=
 =?utf-8?B?S2llb1hIaTQ5d3grWS96TkpUOW1DY3QxWmo2cm9TRlJpdjdaWCtKN0V1cFE5?=
 =?utf-8?B?M0NOUUFTNlJsQmhqSzA4RXJFMTZnYVNDOEdXRDlMVXFYajhiN1hTZ1pRdW5L?=
 =?utf-8?B?Q3dUN3FKSTZHRFNrYUc5MGZab1BWQk1TckxMS2dqUlBiQTl0cTR5OXlXZFh2?=
 =?utf-8?B?YUJFR0MrQXRPd3ZKRjE0bis0Lzh5WXJZT2hzRmsvcndUSlRGV2tWRmNuZnNS?=
 =?utf-8?B?bHNSZFJWYmJOWHpoTFpPczI1c2RHYmVSRFc2eTByWmFod1VteVV4c2FwREJI?=
 =?utf-8?B?ditveHdVR2ROTjUweUw0dHZDNDRMOHFoc0ZYL2FWT2tkaEh4UmhITXZmcnBI?=
 =?utf-8?B?VE05UnU5MUtuOCtycWV3WElWVkJubjVpQ0FLdkFpcUx2R0NFcWZGZVF1YURO?=
 =?utf-8?B?WklTaVlkMFRsLzRWMFlBcGQ2azlUQ0VSY1NoSUh1RnRvVVZFbFh6UTF1Z2RO?=
 =?utf-8?B?eFdob2pUMUlUbHMzSGx6czc1dTZja3VkWndjYUtDM2hsS2pOSWpNdmtZTDJu?=
 =?utf-8?B?V3dRSkd5Qi9Ed09jV1dnNmdkN29XQTZEbjMvelUxb2M2MUM1NVYvd3hCRGYr?=
 =?utf-8?B?M09Wd2k3YjQwRlkrR0Ywamd5NEg1YS9nV05ybEhIdnNDOUl3ZEJaODhtcUVQ?=
 =?utf-8?B?MFVXeWRwdjljblViRm5HVW5vRFJsTWROaStKbFNLUTVjUm1LUU93cmFTU0Zw?=
 =?utf-8?B?NUthaEtSdXJCVHF5MnRRa3IrcWNBYlZ0cEJva1ZDSkgvUjFFMisveUhoTlV6?=
 =?utf-8?B?bStMRXh5RjJrdXVRVEcrQXlIOUNxbnNKdndRT29ZUUFPejVjMkdqL1JoL2Ri?=
 =?utf-8?B?dGprRmQrbld2U0JoRy81cmNVdE5zUkZ0VzhJSFFhY0R2RjNKcUdGcStWVjZD?=
 =?utf-8?B?a1NOZDNXUkhHZGRXWkw0a0hBWEx4V0ZXZVBzRDF5ZVZsckExTHRNdnRlOTBZ?=
 =?utf-8?B?NXNmbnRsOStqZ2s1aVZzT1VZVmdyeHZEOTQ3T1FKbWlxR1ZwZFF2Mno2VUtC?=
 =?utf-8?B?c2d5cSt2elpIcU5XZmthajhpUzhDTk5FUWk3UGl0YkFvZWtsR0ZPdzNneXBY?=
 =?utf-8?B?SVp2QkkweS9XcmxiTnl3cGphNmV6aVR6K21zaS9TVUZKdWR4WW93M3U3dVA5?=
 =?utf-8?Q?WvTWVxCKFcW7tLTskBW+?=
X-Microsoft-Antispam-Message-Info: vXd/pNcJJnXnN8XV0PeEqBDLoObxw4qlIw640evxmyrV4Q1VXA+smq5uiixpI5amOucKUbOY7kVEfjdxtCjLvKj1qhDtZgabBNAfCP8ensBTyA0s5MVL/9PyqxUn+CdMQ5nNvagYnRC6TYzEmm3AAcvnAt0CU6Yqk+QJhG7rXCSq2gMcbfiXCJeRquhCPlSW
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3255;6:IMjfwV/ysUUU4TfW7XzxyzVJoKV+sU336P+EetoOiIfC/SuB3ZCRGmsKueVmFElpWaNxb9veTIOCKnM2NvcE7AIgnBg5+Xc07lSDCIIc7uystr9SK/TE3IQxkk43YQya2QJ9KGdPuuqW0ZHjsHPiS6RkK8u231hsuHHNfvmjqcIaITxuj0QdRHqsuGYKQOwXq2WJaErjLB+WKlVwXvZopRra7sTk5hQkkYZxlEzXsBg22BjJsTkWco4vOYBXrIEtmBCK0gu/B988kClEsK1RDn3A0XOf06jiAj7WTnlwW36CXrzpYwOEMktLr/tHkaR+rhKjnJYkUU9RHGQDukDWZ6Fr1WDU985HftwTlRDC+WCAFJkQHl9GRaf6kD8JXYdpmn+eCzX9duZ6+uJBEfNI7jN3HMyJ38ByctvGE1uigKzaZq3xnidmrGsgPwAi3juA0PMpcvna/1UYGCfcMMls5g==;5:L2hwLt8XZ/zKv+Zq0PtjwOb2LkBOvXAsniAb+an9SSA3X+cO0w4dK+XYsn9tCmuz2CJJJhwNFIfgG/YxRCKVkGoXSrM8uBGEIitLQH0udm3G6QSmvk7rfkPuHLZbfby8IiNEre1p2fEPzmkmM3ay+fLWiamr6VXlKKqJDlRtFoo=;24:9U6oYePSgnaJSH4p1fUwVltqrgvZUvF7uk1S+3q2xmt2Keyk8Qb7kONrKQJ1/G15w2OEyZhXQW9uLYyNP5293LoOemoEBjV+q+yDVx//R/U=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3255;7:la0vZFrRayH+uycMxTgQiIEUsPR9Ni9mLv+BizJ4GBIfc2BrHEwBLyU3puFXlG1jvCPhdIAuBQyfohAJXT7k8MA0YUEN5aCiVl2mIhimPjtEZA4kt7jJ3YIrF9RKH4+YzpXBsF2Df0v/9345e+bGVQGdr3A0H88O2y+DNt/KoAm8ra5Nx034Jn/0uam7jPbhpKA/TzVSWvmYvCmsXJ2gr5T8S/Ub/At+TggvSn9ysFoUkkXeVlREIlopgMLR208r;20:zXJo4ivQauF19l/fjFLhxYnArIIk2t8zaMDWsArLijs8FNBBgyCOSHgwm3xzqYId+L7V/PjyLFSKSvkV+xwpA/7fvvAl74kXI0S89f06nUeeKz5zs1KXp+3OA8Eh1QIOUE2c5S2EUW5K2V2V+zk8c0jkCNmFNq5M0IAsO3iZSCk=
X-MS-Office365-Filtering-Correlation-Id: 904a3372-8382-4035-b288-08d5a6f813c2
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2018 19:51:14.9232 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 904a3372-8382-4035-b288-08d5a6f813c2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3255
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/20/2018 07:45 PM, Yury Norov wrote:
> On Fri, Apr 20, 2018 at 05:08:23PM +0300, Andrey Ryabinin wrote:
>>
>>
>> On 04/19/2018 06:01 AM, Fengguang Wu wrote:
>>> Hello,
>>>
>>> FYI this happens in mainline kernel 4.17.0-rc1.
>>> It at least dates back to v4.8 .
>>>
>>> [   25.697463]
>>> [   25.697463] Start testing find_bit() with random-filled bitmap
>>> [   25.736615] find_next_bit:                30203201 ns, 163965 iterations
>>> [   25.783266] find_next_zero_bit:           45554622 ns, 163716 iterations
>>> [   25.832480] find_last_bit:                48003878 ns, 163965 iterations
>>> [   52.050031] watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [swapper/0:1]
>>> [   52.050031] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.17.0-rc1 #210
>>> [   52.050031] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
>>> [   52.050031] RIP: 0010:__sanitizer_cov_trace_pc+0x65/0x66:
>>> 						__sanitizer_cov_trace_pc at kernel/kcov.c:111
>>> [   52.050031] RSP: 0000:ffff88000fd43e40 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
>>> [   52.050031] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000017
>>> [   52.050031] RDX: 0000000000000000 RSI: ffff88000fd3e000 RDI: 0000000000000002
>>> [   52.050031] RBP: 0000000000050000 R08: 0000000000000008 R09: 0000000000000000
>>> [   52.050031] R10: ffff88000fd3e000 R11: 00000000222e2c32 R12: ffffffff85565d90
>>> [   52.050031] R13: 0000000000030f80 R14: 0000000000030f80 R15: 0000000000000000
>>> [   52.050031] FS:  0000000000000000(0000) GS:ffff88001f600000(0000) knlGS:0000000000000000
>>> [   52.050031] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [   52.050031] CR2: 0000000000000000 CR3: 0000000003c6a000 CR4: 00000000000006b0
>>> [   52.050031] Call Trace:
>>> [   52.050031]  find_first_bit+0x66/0x7c:
>>> 						find_first_bit at lib/find_bit.c:106 (discriminator 1)
>>> [   52.050031]  test_find_first_bit+0x3a/0x93
>>
>>
>> I suppose test_find_first_bit() needs a little more than zero cond_resched() calls.
> 
> Or just decrease length of bitmap in this test. find_first_bit() takes
> lion's share of time of the test.
>  

Yeah, that would be better.

> Start testing find_bit() with random-filled bitmap
> find_next_bit:          240043 cycles,  164062 iterations
> find_next_zero_bit:     312848 cycles,  163619 iterations
> find_last_bit:          193748 cycles,  164062 iterations
> find_first_bit:      177720874 cycles,  164062 iterations
> 
> I'll test the patch and send it soon if you OK with it.
> 
> Yury
> 
