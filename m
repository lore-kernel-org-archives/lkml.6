Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755120AbeDTOH3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 10:07:29 -0400
Received: from mail-he1eur01on0108.outbound.protection.outlook.com ([104.47.0.108]:62384
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754987AbeDTOH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 10:07:27 -0400
Authentication-Results: 01.org; dkim=none (message not signed)
 header.d=none;01.org; dmarc=none action=none header.from=virtuozzo.com;
Subject: Re: [kcov] watchdog: BUG: soft lockup - CPU#0 stuck for 22s!
 [swapper/0:1]
Cc: Fengguang Wu <fengguang.wu@intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-kernel@vger.kernel.org,
        lkp@01.org
References: <20180419030135.nn454aqxlqdwe7ah@wfg-t540p.sh.intel.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
To: Yury Norov <ynorov@caviumnetworks.com>
Message-ID: <be75eae0-624d-f5ab-1b07-9a0d86d366b5@virtuozzo.com>
Date: Fri, 20 Apr 2018 17:08:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180419030135.nn454aqxlqdwe7ah@wfg-t540p.sh.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: PR0P264CA0036.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1::24) To DB7PR08MB3258.eurprd08.prod.outlook.com
 (2603:10a6:5:1f::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3258;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;3:ssFNtUB1ZxpVdz6mCk/HE0l8I+H9HJzqQqGjBeq0MdZ8wHJmgf/0hgLKINuxNV33oKOuYdGxoQQc2+zt4c+BaI3IH0uGFpPVeLYlIF/io4S+SsvORg7kLakz9HX/cHjqyCCLX5r2cRyLunlU28aQj0slvld9nRrJ5vYUNiZKzyLyVjn806fDG4pVmtDkL8onTTbWAkF2AtsLM0WD63sE+D15opCNmJ1Xpl0udku3dMOofVSfciCLTBfAHfqx6jeo;25:P/QU+9xPmeBUOYtVDNkKLYxbxib5GEb8x9lQ2qK3UvOkd3/ADIGNjL700WbHH/idtHte2RfOvgAVV13i9Xy/xQo9rNRtHDA7QA3oqRLQk6bhZPO3pRivde51aqVQeK/akYLmW9wfpcwg2joWn2i4AgZCJZgKI2UpENQ4VGMvhiaGCJfG+yJO9xqkUFR/RzbjnFqTU8fmcenRVH/J0yPqvdhWFQdaDUKl0xnaX9a8d4BA+VLkhfumCFdmBbYybjQVq0rGskKXXzpRIPU/xBIeqm9EwJ5UPDCXc6ZOZlDWWMwF+GtI2oRS+EvWg+a+jwzLjr+49wYCvOEfuVYlF9zbHQ==;31:6YsSD4GpUhPbpKWpfDtbcmoo4n0YuV4X2TnejR6+dCebQ3u7MnaYmonOvHuL735xMyJcqHPlWAyA+ZtwEu1x20huOg87bD7bW+XjXKI4FXmT1UzYMvdBv22ZYdT0wEEMBku+k7b8muD9HBgkp0AdtSKx0995Mfe4AM/araR/wv3jly6Vb1dwKFs6Mc3PBvO+GOj/qSBlZ8flnzIo2mR+OQZR6aJh3o9e2atMd+WIhHs=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3258:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;20:qckwbKgz6YMrTUExwBi+wuGDjjMdmLvBWoFbMPcp+aLdMeJsnelvYGZy7M1Cbi4TuZ+2w1zRcZRN6NCNxftLZz2ymu+rRimIPYW0r3cYrsGtChP81/RpLYjr34EWd4rzf3NWI69Oz4QmmXQAF1l5DwOBAstubMIa5u5LTFm3HPcWI0YmhOtvwDi1BIMcTZilxN7oowonEgLVq4e6l0bO+WielREGWBjY4RPjyJwM1FwUh2i2jBeDi7Bjpcb0eGwFOsdqwZZRInbJilM2UNi/BNwNayxdJfyS0n5SK07D5E5z/rLTIMKHPEXZF7Xx3KqiXoVO2pu2qoHABaE3D5s4nfWloV2o0RdG6Mq7sRoENCVr17mVvrk5pOBjpO92u5bAaD3DMoioqWt6cOHfznkIBJvdDmLo7S3kLEAKo9c+hEhmM579ndVURWkZ50vxZrLscujff/hqF+7Hbow82FZrXTRWOqmV5BDYnNtSFIUUgNAycsxcHJivml85+qIY20tJ;4:8MwAMq5vjwf4GEwNfeN8S/uhNBvjX61833J41/aWXooN8MVBZV420ByGA3dDyj3kyXzcBYov6EHWsdNIZ6/g2fCgpj0lXW5KVC6TQ013fIRxB+ZhpSGsD6w6OU44dOrq1TONv05F/TnEEuzcIYR8wDKw8PAFVwqXl1rY4DglOpk0ska02jrVSPuF002F7i2NdEiN/lB/WgnY+MN9qc6RjxU0ycip6OYY1fAxzx4Fk99fyjcCDdgrn6iw/DJFCgUdUulRU2AUU25+3CvkDXBCNw==
X-Microsoft-Antispam-PRVS: <DB7PR08MB325816D73D8459C1887A895AB0B40@DB7PR08MB3258.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(944501327)(52105095)(10201501046)(93006095)(93001095)(3002001)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DB7PR08MB3258;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3258;
X-Forefront-PRVS: 0648FCFFA8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(39840400004)(366004)(346002)(376002)(69234005)(66066001)(3846002)(6116002)(305945005)(4326008)(186003)(47776003)(16526019)(6246003)(476003)(2616005)(316002)(77096007)(31696002)(478600001)(26005)(23746002)(54906003)(229853002)(86362001)(25786009)(16576012)(6916009)(11346002)(53936002)(53546011)(31686004)(386003)(55236004)(76176011)(2906002)(7736002)(52116002)(6486002)(50466002)(446003)(36756003)(8676002)(956004)(230700001)(81166006)(8936002)(65826007)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3258;H:[172.16.25.12];FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;DB7PR08MB3258;23:Cf+CJvVn4ulwqGjWmibpE/Skd41673BdVf+Bb?=
 =?Windows-1252?Q?xBPgGCDjSvqX4BsfcEoUIZkQdttQShfejlbd++waa5hDvB0MTKqjKqC0?=
 =?Windows-1252?Q?N0SRdYDSNVRd2eI74ECdfecqnLAfwAJwNl4v40iPw+Xa3N6fxJqsqnYw?=
 =?Windows-1252?Q?nlX211b+Zg34khIo881B22QlTV7a/2HGABbxbrDvONbAaRBW6Qysv4IJ?=
 =?Windows-1252?Q?JA+JLHCrUtSEF5ly9YLvOKJ2SpTfbXJRRn5YAQwm3Vrtd/9M0+mChdzC?=
 =?Windows-1252?Q?UOr0f9kqtzC8lEzFOkm7DZvOkQ8Kj9A4R4bR4noG/ETmeZnh/0oqAa4r?=
 =?Windows-1252?Q?55tZpHyo5ByPowQrsA8MiWOWlubxewGMYLBg+VzKc8DvIhTFgKrzDE3R?=
 =?Windows-1252?Q?eiTSHtXncjBrepNiQkR4SJFGtBtj83jgR2kNdd0m/LOKI+8sFJJeI6TU?=
 =?Windows-1252?Q?zJRs0d3jLXiTAkegMiqbWOsDPvPAkVT0d1A06TBM9UKYZw7ldURmxxIp?=
 =?Windows-1252?Q?xrq0U5p7bwGpmx3CWsVgCmu9Xe+cgihDwZowQaC2cp7upE1MIaXfRsjR?=
 =?Windows-1252?Q?I9ZQYbP4ujwh0OdeClBsCAZDy6rwZ/vJEqx7G5swwgbcTtRC/o6H13Zv?=
 =?Windows-1252?Q?bURh7+vs5LgE1GEGzxUcINkgaIqo+xk4FpLdIGfBOHbMohkjtBUPumbf?=
 =?Windows-1252?Q?x+4/bOizVn+YnBKDx0IwF3Jf5aeZJzKzJSE/s+UYlPOMv9GTxtYxrBdg?=
 =?Windows-1252?Q?JbPouCE12Iz37iXWEuTYQfKfTev/JJHr59OxM3ZLMK24jpNfP4SCoSd+?=
 =?Windows-1252?Q?9tWD3/Xa2Jqyu5RI+m1Pj85xOjV8PMoFSUGxjMIdg0D8u6h6SGdSVMm6?=
 =?Windows-1252?Q?jZ66nxRcqyVoytrZTlbtym56kp2Won1vcinIOsv1XIvBNlkyOM0VkhY6?=
 =?Windows-1252?Q?TSql3cjjLuxrp2atXmgzMv7wV1YZK5YhdfO1yD07JdPacT73lf+2C2Jl?=
 =?Windows-1252?Q?M5ubL3fEJSbFDn5w7W2pomm4i0lis+KEjkyWogkATW+vbp9evRBkpEna?=
 =?Windows-1252?Q?zVLAc7A4iuKWpGehM2sfU/RS/FYq4XH9RC7hK8HJOEgvIxZajschVTOk?=
 =?Windows-1252?Q?pI/JR9FtmTkGVy8zTWzFUVemAnyKRTrU8VKSHlyMqzMBlwujTqgEKoF6?=
 =?Windows-1252?Q?4F/TNmaY9zZ7knYbUpmu3zcTbGneuF4WF1t+A9DW+vgtd6k1Uy18Uqs/?=
 =?Windows-1252?Q?CRNtmdHLrysgXHM6w=3D=3D?=
X-Microsoft-Antispam-Message-Info: chUw8rh3fmoPhZk+3k5fNJ95p6zvDJ+FyddfP950tyvdK7q1eUYBmv9Z6SFDf0q79qSkgsW7kvbgo24ga/Dq3A0AG78UCc3LdbEFryIvOsHX4kTCZdSwhX/WsAKvK9/wxDeOiWxIVv8wv3MQAbMYYIwHZE9ubDdvWA8XcyNzqcjPPLEjUQbs/1HFlYyC/gXE
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;6:2+Oy8tudEJkqbl6ODnE2tm/zWTSveLiLSjd+uVm3fKIbmuLlmUspJlPpd1Rdh83pd0Rsz927gIlf2SSSO253cEBLl4XDK4q7uMREVzjk1HfR/g7ozPzYbfR9yYZGL8malo6QEs+de+m+UoW/oWvI8weFQVMb+a5hKidK/a9W7azjcEsP/WyjHhgOskbXqCrCtnBdsiFRw/U34wbYZAXwkZAaCo2INYVVup4YHR6vzaTxaUxgiNnrNRc96iwilPv66qIZ4Peu+Nm/fj93DVULb2u1ukpZfDDfwnnvHj1IimDAY/cgiYcJjWgJDN5WoY9NZd03snlbd0Pdo/XIqa8obdKsWZ3NdFq0pEpVszgfVV/sOeLP+CkvYcy8TjWXvb1LHYxpJJW0eFpf53HDtmbDjtss8bcBqlwx4tZRbVF1LK8JGL82e38CSTCFnT6fv1vUVW/8WOK7uktEQfbHve70MQ==;5:y+rhpBlY9anhhBQSolk6eF0t/LhT+Lzff66BatLe8lKlD3zpf1kY9ev7Zp07Puhbp9OWyA340EOmH6E6f3yn/ZzV6ZtfU5YggFIBuPyyFnr8xf4Qs83pJJJ8xu0iBp0z0frckBD9mWQG0n6c3wrBQZK+8ldzw0JLsjef4uMxHxk=;24:IdMjkU8e06qOcB8nmcvlYHyeMN12UKMJsafmNfDrxzY2o2z2ewVr/DlwPF85Cb/dWzaERt5iBRzZu+Xr1/FNYYnfrpk59LOgW/RK8dY18Vs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;7:q1pU2ptTgypw+9SgucbELEqf1r/KWgJ0U1Dvq7zvDJfWLkfu9c0dak7pEGBDQ+qKZnsPgOWsyJw+UdBa6BcDyyaQnAqLZTSraOf6H+kBWefW1uAqh6URESvn9Pan6ljLx6QqlUwKjM6yjkbWxAEHYGhyC3Q3iX1iS3CfgoHqAC3NLjiCKAdlVWnO+RfkPy9BIlXGainimYLIJyR46w8qAHeynyNP4Ki12ZeS4TjQaHLouANtGFi9O8EvmJRuVZEv;20:bxatuhwqTr7XGdoF0hM8XiaNx6tnQIQygLuRGu8maElwOO5BWYHqjEOtvwYAVklprJhyFaY3cTezvvz+vtoNUf6C2SiMuIOrSoiF75DK09SU3JsPii1rS8a+Yn92AbHfGOq26MB9nWg/Y5sdPcyBFyJKv73ykIceIN4escx9EaQ=
X-MS-Office365-Filtering-Correlation-Id: 0b2a85dd-49dc-41d1-089b-08d5a6c80ab8
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2018 14:07:24.0671 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b2a85dd-49dc-41d1-089b-08d5a6c80ab8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3258
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/19/2018 06:01 AM, Fengguang Wu wrote:
> Hello,
> 
> FYI this happens in mainline kernel 4.17.0-rc1.
> It at least dates back to v4.8 .
> 
> [   25.697463]
> [   25.697463] Start testing find_bit() with random-filled bitmap
> [   25.736615] find_next_bit:                30203201 ns, 163965 iterations
> [   25.783266] find_next_zero_bit:           45554622 ns, 163716 iterations
> [   25.832480] find_last_bit:                48003878 ns, 163965 iterations
> [   52.050031] watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [swapper/0:1]
> [   52.050031] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.17.0-rc1 #210
> [   52.050031] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [   52.050031] RIP: 0010:__sanitizer_cov_trace_pc+0x65/0x66:
> 						__sanitizer_cov_trace_pc at kernel/kcov.c:111
> [   52.050031] RSP: 0000:ffff88000fd43e40 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
> [   52.050031] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000017
> [   52.050031] RDX: 0000000000000000 RSI: ffff88000fd3e000 RDI: 0000000000000002
> [   52.050031] RBP: 0000000000050000 R08: 0000000000000008 R09: 0000000000000000
> [   52.050031] R10: ffff88000fd3e000 R11: 00000000222e2c32 R12: ffffffff85565d90
> [   52.050031] R13: 0000000000030f80 R14: 0000000000030f80 R15: 0000000000000000
> [   52.050031] FS:  0000000000000000(0000) GS:ffff88001f600000(0000) knlGS:0000000000000000
> [   52.050031] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   52.050031] CR2: 0000000000000000 CR3: 0000000003c6a000 CR4: 00000000000006b0
> [   52.050031] Call Trace:
> [   52.050031]  find_first_bit+0x66/0x7c:
> 						find_first_bit at lib/find_bit.c:106 (discriminator 1)
> [   52.050031]  test_find_first_bit+0x3a/0x93


I suppose test_find_first_bit() needs a little more than zero cond_resched() calls.


> [   52.050031]  find_bit_test+0x84/0x173:
> 						find_bit_test at lib/find_bit_benchmark.c:135
> [   52.050031]  ? test_find_next_and_bit+0x9b/0x9b
> [   52.050031]  do_one_initcall+0x18e/0x3df:
> 						do_one_initcall at init/main.c:883
> [   52.050031]  ? check_kcov_mode+0x5/0x37:
> 						check_kcov_mode at kernel/kcov.c:60
> [   52.050031]  ? __sanitizer_cov_trace_pc+0x2b/0x66:
> 						__sanitizer_cov_trace_pc at kernel/kcov.c:101
> [   52.050031]  ? check_kcov_mode+0x5/0x37:
> 						check_kcov_mode at kernel/kcov.c:60
> [   52.050031]  kernel_init_freeable+0x250/0x3a5:
> 						do_initcall_level at init/main.c:951
> 						 (inlined by) do_initcalls at init/main.c:959
> 						 (inlined by) do_basic_setup at init/main.c:977
> 						 (inlined by) kernel_init_freeable at init/main.c:1127
> [   52.050031]  ? rest_init+0x13a/0x13a:
> 						kernel_init at init/main.c:1050
> [   52.050031]  kernel_init+0x17/0x218:
> 						kernel_init at init/main.c:1053
> [   52.050031]  ? rest_init+0x13a/0x13a:
> 						kernel_init at init/main.c:1050
> [   52.050031]  ret_from_fork+0x35/0x40:
> 						ret_from_fork at arch/x86/entry/entry_64.S:418
> [   52.050031] Code: 1c 00 00 8b 8b 1c 1c 00 00 48 ff 05 d2 2d fd 04 48 8b 02 48 ff c0 48 39 c1 76 0e 48 ff 05 c8 2d fd 04 48 89 2c c2 48 89 02 5b 5d <c3> 48 8b 0c 24 40 0f b6 d6 40 0f b6 f7 31 ff 48 ff 05 e9 2d fd
> [   52.050031] Kernel panic - not syncing: softlockup: hung tasks
