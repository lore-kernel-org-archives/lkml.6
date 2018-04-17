Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbeDQP2y (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 11:28:54 -0400
Received: from mail-eopbgr00090.outbound.protection.outlook.com ([40.107.0.90]:25312
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750741AbeDQP2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 11:28:52 -0400
Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia.com; linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=pass action=none header.from=nokia.com;
X-HPESVCS-Source-Ip: 10.145.164.233
Date: Tue, 17 Apr 2018 18:28:01 +0300
From: Aaro Koskinen <aaro.koskinen@nokia.com>
To: Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: 4.17-rc1: early boot crash on x86_64 & pti
Message-ID: <20180417152801.GB11166@ak-laptop.emea.nsn-net.net>
References: <20180417150130.GA11166@ak-laptop.emea.nsn-net.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180417150130.GA11166@ak-laptop.emea.nsn-net.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:131.228.2.240;IPV:CAL;SCL:-1;CTRY:FI;EFV:NLI;SFV:NSPM;SFS:(10019020)(979002)(39860400002)(346002)(376002)(396003)(39380400002)(2980300002)(438002)(3190300001)(199004)(189003)(305945005)(86362001)(8936002)(6246003)(97736004)(68736007)(53936002)(8676002)(106466001)(26826003)(356003)(55016002)(50466002)(81156014)(81166006)(46406003)(97756001)(59450400001)(16586007)(23726003)(26005)(7696005)(47776003)(229853002)(316002)(336012)(5660300001)(478600001)(33656002)(77096007)(76176011)(1076002)(186003)(58126008)(11346002)(446003)(486006)(106002)(110136005)(126002)(2906002)(476003)(22756006)(9686003)(44832011)(18370500001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR07MB4392;H:mailrelay.int.nokia.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;VE1EUR03FT055;1:/Oa+SOyy3BfUoilNcxXBFxticukXMA++lFn+oL8/YNXa4hDf7CNAYTA8tgnEJp2w/Q6mFOV/QLjmvwBxMBFiKkmFSD+lxQaNnt9oSl2SYNZSFkbsae7kXI8nlCfbsymJ
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328);SRVR:DB6PR07MB4392;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR07MB4392;3:Af05SgXVDg7uvDDaMR4HKkTCPhGUxQvKCY7b2fruD7PG6e9uhWSSFyg+A4hPcrDCBaqu1oqXQGdbX1EjsZn/BjGKU4QC8/BDOOQCo9Sra0ufije8d99TnPyRsCjykVmIER+DB8OUEQjMAMDFd+42ZkCD3thvSueSQUaNxfYO4uIOsBjb21239/SVQCgCoOKcl4er5Ju7J5Qo39rqS1lpKEA6siMLGD9YOZzXpc0k3nWwXDs9XxIVg3/iUccuvyiLr20z7Mepv4hQKiCRB5AwdajTdhitL+WWZWh9O6BPjDdAklaiHxCKYRkiFHlNI9g1ICIDYw9Ge4M6HFTBjRZGuYHnJ4yMjUr4CiA9Y92NIbY=;25:/ssKAAQ2/BWDXKhIPpBswrsBI4FOpmVHGycyFEZtf+tyME2IWW4+uQcLKt8GMK4Hmtaul6h7O1Cha4F2TdoRR0/zzaVWBbSl8r0lfWOAmeSoMsWPxaYT1Hi7f59DMZC/vArfSXWlhNIX0sOH777y5cuh6IVEIZ1JsvPEeYk/ZcP1pZkiI1gCz7UFNw2BZ6UfVoi0K8Lz1iG1C4KJcMJ5gjlr+4mdqY8cyUlDZXz3PeXNFlng4J8wiqoLSi9YUADOM8DwmKouYaHnWDWCwwUJnyd84/fnNTr3TuN/6d6mvnUXcU9wgbPQ9i7L/81Sz/GntisMwoRJPMj0WQUBzLOp3Q==
X-MS-TrafficTypeDiagnostic: DB6PR07MB4392:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR07MB4392;31:ejZ/ECm5ZoC7TJzhtFT5rUTlAsNS6tubcIdXy6pIPoFnY4fqP2EcwlXkneQUfN6cmjtgwtvcyBI6VvH9XC6Q0OJJxmAGEMJL6asdgOc/XsGfDxY9kkVXBTRcw7cBcUXknp1Sdm9PU9TDnoogsQ0YhAh8upDafhYHvufmCHfLj/UYQGEGl+Zmu00ADbiUwKQBVzdOBUqmnaKa/T1/QiN5VqMVlHdYL/JHx7KgkjALfW8=;20:Oyv2/2UJwly0+q3AdsT00EMlE30y9+GRkIjju+VGfrnlVuEua8Y3JnuHXZVIsSPTm0iJtXMrAo4vw3Pv4ZDHPe2DlXU48kb43d0YUR+fXbTmq/lh/VFGezBRU+wk1KaUumI2yJGlCToT/n+Ji+qwu2o36ku3HcPCPKI4w+Vukf0QGMuRMKuIPeNf31VbTwQrTnxC80UYRz0MWIn3djwrJftCkKxIHflhUAAFf14OG3Dog56c9wRsrCt8U9ZwKJLV3vS+AzbiEkXWB0D0wGtQKLKlwQIuvLVR8T6TVnHVs+JcbhNp9r+Y9XfjeRtOYvxAjY5cAj/ltDu1QaxJ8AMz+tlSKno1HmmzvmY7kwIn7IEAbASucK8y89CAV1z5eX+JZkNKM3GQ55h9B8d3ar2QMuVEZdf6BT+SvwxYp3T3TIeXsrUzKQEG37iuCIyxyAJUQdlmfnKwa4jp1y9XxLNq3BHWfiKAWmvV3idxO47GR0D1cVDBCebteYmYoT/rZsWFNUhnc3N3EJHn3479SuB9+iJeSXdrELSsRYigITqcFGhD1Xswja2qiHv8bm59B0vWna/M+V9RDp8EBuHPr1i4H7ywJsE9FbM5xE5/35+3EEI=
X-Microsoft-Antispam-PRVS: <DB6PR07MB4392461F056F956BCC1D56B7F4B70@DB6PR07MB4392.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228905959029699);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3231232)(11241501184)(806099)(944501327)(52105095)(10201501046)(3002001)(6055026)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DB6PR07MB4392;BCL:0;PCL:0;RULEID:;SRVR:DB6PR07MB4392;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR07MB4392;4:VDUwzdwIhQCtVK/OGN2uByUrf1KlIw+0g30zXyjvl2f6pH0FjyyAYvwNtyjP9xil/2RiiMI9cIPHbiG7frE5U2JBkxgfifQd2kpsLktCgM0YqjheZBJSmvKTZ8e8Xo8jn64N1PZ0psM9l8vhzXOxaTGxwSj1ob8QoJw4utvKc2RIZV0T4WFHag/wJF2vKsQUf16b3VrZmNIBDsuVhWSP6uZw//iFXg4lbyPb4DQcDx9RdNt4ToTPlp/jxtqhpAYoX5XNM2QVC3NaR7WAC/q4PW/Xd4Gl2RaJHXPTtkP/Y4AhRVlKD/9sZPrKbv5yxOtb
X-Forefront-PRVS: 0645BEB7AA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR07MB4392;23:GhvCm8SosOtsXYptGNdTf3AMa/X55Ji5/jPEh7QN1?=
 =?us-ascii?Q?NxjPdCVw6UDacbsQt6OYwR+WXlDEocIkHDjo3iazmw2BGWvQUJRehZa8p4f9?=
 =?us-ascii?Q?rLrhqWlWIjEDLCdzLl2tw8SwKYywollYCSwpiIPRTdh4nnGc9j+4kZ4urE0w?=
 =?us-ascii?Q?/JVxZwgwzZ3lOMo23jkfKeh9VErm+0diGULtAUfZMrC4fwig2+0BVogTWjY0?=
 =?us-ascii?Q?Bn/ame22HfLr/JEXgKQtyUHYl9tCvNDNF62L//WgGhmNBeL6dPbPAd/muHfD?=
 =?us-ascii?Q?xTWOtj26HVDlWlUEeWBA0ANBmx/SYvs0j/AdF505qjW/VUdTk7nzvvnUJZsa?=
 =?us-ascii?Q?XqeJ5MsBb2l8epF5g+RxSRF0j+V5M2kkVMEHzJHYqMu9kagbErC/ZnjZMjp4?=
 =?us-ascii?Q?P/0DChd+xYVBlg/F4ydIDL0hmKIAl0x8HdFSe8aNik+9hun0LlCnp/ck8nSV?=
 =?us-ascii?Q?rsdT4YTnS+yK/TPsPvB2qkZhsdhxJFf8r8RKI+42cMDeTKbzEbG5Az2dwFLx?=
 =?us-ascii?Q?J4ZVMLKVrDCqWynb9ZAbjJJzgKAavgoS7ZLDJw1goFd6TuOHeYIOu2vftbmn?=
 =?us-ascii?Q?tLm2hvBLXoNAizXqRhkRbDGid6nkZymWQvV8Z7Icmz3AwO5MpF9kIIwb/KL1?=
 =?us-ascii?Q?4V23X36mO1WYLiLGxWNdaLGxqFwM4HCcVbvIZFMG4bSl71+exxPn7aAb2NjI?=
 =?us-ascii?Q?FDfhBSxgd2BN8k90DNNU4q4tGYZCCHBxaV0ei+ChPyrtJQBSDVQQbeQPbpQb?=
 =?us-ascii?Q?vLufPV3z0MteDYHiusuZ1IKMmnynSUrsXUY50lr4bvRvTM60i9Hjzy9gT2GQ?=
 =?us-ascii?Q?ZLT2H7ke/lWFR2Mel8A4IyHnrcTXKI82YkiYqipr2KUfSiN0YKcgT6ehpwbw?=
 =?us-ascii?Q?5ij3VfEh+Kr3/PR8h6Zk+/9KlOZsVI3uCeLKNcRevfGD+pP7h1zVLptLtDGE?=
 =?us-ascii?Q?/qxaauuU3/sY/A0Hh+X9c+j+LhzRhjTARenGFWzKIIZywnPOhMp6hoFIDgcq?=
 =?us-ascii?Q?Nufqy3SJZ/7Q6Vj7+ILihTj2qEqrXg5g5g+GWNL9buvj2javS1KqepvLspKB?=
 =?us-ascii?Q?C5J63xujJS28PhuJVNc5puGrz/ldLr8mnYocBO7MNWLhohq9vcmcK/Qfa6UQ?=
 =?us-ascii?Q?uygJjckR88VjKTQrfEEW2RqTmUWS/c6b53PkGgauhyHfXaAeD+gYLo5k4pb0?=
 =?us-ascii?Q?3WCGFiTynULE+jQd+3mxgspJ3i9tavz4Z+aw93FKPOTVq8j/WUnuw4iZAof7?=
 =?us-ascii?Q?IByyZkzVpKtQuG6+Y5OO/C5k2E3IyS9TmAH/kxx1dORQbl7UYm+nKoocyp0v?=
 =?us-ascii?Q?QTYHVhOhWbwQmELWrzRgF0HvBtiSTc6EmNSuWql/UfOhzNJ3+tGQw6S0boBS?=
 =?us-ascii?Q?ngSog=3D=3D?=
X-Microsoft-Antispam-Message-Info: AvQyYSTvtmbij1OulJIGzxuVkU7juTQxO8/LT6puLS898Xg2AdiTrLqs/4m8nHA8MCGRlFs8j7B1nqogeM7arwbrZ64L/Xp8TvBAmcdOIrKWoMEvml1j/yVRy4Y17VfXMXgquUWcBEokIUELzhsLFuO68JF8J0d9PnDx988EqJwg0dlG3kA+4NdSYVu32jLugFOSjPElqauM+vHlSqKc9tVMaigneHDZqz5CN4O3R+FRwpdyTgHF+FO9mLxBg66fytltCyglr+NtcIPs9JkL4aSHWPwdinFJCYA2pIGE+1eRC7OGk82jxDbpzHd+//o6SZWLcW7bV+xt76cNIFWUO9HZ6gVtNeJwZlw3hHr2mNiMB592qsTQKSQ3XwsWMdoR5Z3+xEpYffMFz4e9pBbG7VvORZZgo3br+2gJ3jZuqSK6RT9A8XalkHzrky3E3ysMwp+VZERKfnL5kbXlFs5Lww==
X-Microsoft-Exchange-Diagnostics: 1;DB6PR07MB4392;6:mWcMmIHb/56VovrcVY36EV/lqs5/r+BHveyp57CEOFxFddSDD8mAf1X5TAQpQguKlf/wOhjhQs7orNIk20DEiFcbuk+oCjLOGUWKeJ1tao8hwo8xpmcnEbONS6GKIVwdMZd4XUjezxWD9KKfwaYTtfoYAVJnafei6fmOnXBz8bbXS7IKThxKyykERE/cKOPwp2V83TFl1CxF5GIeILHpgm3IYeh/p2mB+0hFPyfzQb9TTyBlu5l18CnbvJRh07pSzO2wdhJ9bt1k5ccbr5oX6DvZq52UL4XDfomBYe80zCFYGxuXt/RrL9JBPS3APtsIKuteu4BIVRtpLXGGR6vg719N3qGuRfTZ0A6qVZS4pzfQqR2Z1hLyaRyi3w5uUHw9qgUWFhQ70zIz+kgRwQuC4jQt9t3EUi1F9bj4yVBrrySoChCLpA2C4SybtYqDtDlJS7Ix3FVYhorGNmerajJmokoGKf3YPHT4qOSsDG8hNI3swWcVAAjjI7MhxQ24VgGD;5:MMfElIUjWP/gtQx9GUQqPHcrREtH3rrWrkpR834S9FUIw5Yy9N9eHW0RIkYE5pK0hIgnAW/qBlW3568HaX99Y32a+vVg5SAsyb4yaMj2bdaDUUUxkCce2h1dq8IN6KytD5rlC4K3t0N+y85+Zy4og5iY8MNffNJJNTWR3zD/l8g=;24:GuX9XCGvaaNv8s2XC1HBa367yi9B4O/1dhDyb91EsYIBg8VSzv/iV6BUBZJN/kP+9V0Dv1pJEIAfnoR3FDiwRYnYX+HnR/CIa6BF6Ui+2m8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR07MB4392;7:eZ/zpHO3rukXEb063iThgvbimb+pV4emf2rOye5eGLQdNB7l68eGGDW+7HTuVjPq0qYGK+FFeoMabj44ymgekxXL4QaFVAPa/EUPf18U4ETlMMgQyqb8nMm85S659CDLe4k2sgdZyK2aaU+Vg3XrNxcvSkemgaVDW4j4IDcFmQFFUKKXJn6ESePf4NT5fNsYlQEf3KW9ylyo+vP8V16gYodCeVo6Jxe9N/0I5zxPsSJGomYyJq68lWJjo6iTk6Ya
X-MS-Office365-Filtering-Correlation-Id: da46d8bd-9ecf-42e3-72b2-08d5a477eb1d
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 15:28:49.3713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da46d8bd-9ecf-42e3-72b2-08d5a477eb1d
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[mailrelay.int.nokia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR07MB4392
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 17, 2018 at 06:01:30PM +0300, Aaro Koskinen wrote:
> I'm getting early crash on x86_64 box with 4.17-rc1 and PTI
> enabled. Bisected to:
> 
> commit 39114b7a743e6759bab4d96b7d9651d44d17e3f9
> Author: Dave Hansen <dave.hansen@linux.intel.com>
> Date:   Fri Apr 6 13:55:17 2018 -0700
> 
>     x86/pti: Never implicitly clear _PAGE_GLOBAL for kernel image

[...]

> [    0.000000] Kernel/User page tables isolation: enabled
> [    0.000000] ------------[ cut here ]------------
> [    0.000000] CPA: called for zero pte. vaddr = ffffffff8d000000 cpa->vaddr = ffffffff8d000000
> [    0.000000] WARNING: CPU: 0 PID: 0 at arch/x86/mm/pageattr.c:1189 __cpa_process_fault+0x4d6/0x510

I started enabling more .config options, and it seems that enabling
CONFIG_XEN_PV does some magic to make booting work... But I shouldn't
need it.

A.
