Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933506AbeBMGwZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 01:52:25 -0500
Received: from mail-eopbgr00114.outbound.protection.outlook.com ([40.107.0.114]:34752
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933404AbeBMGwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 01:52:23 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=avagin@virtuozzo.com;
Date: Mon, 12 Feb 2018 22:51:56 -0800
From: Andrei Vagin <avagin@virtuozzo.com>
To: tip-bot for Jacob Shin <tipbot@zytor.com>,
        kirill.shutemov@linux.intel.com
Cc: linux-tip-commits@vger.kernel.org, tglx@linutronix.de,
        willy@infradead.org, gorcunov@openvz.org, bp@suse.de,
        peterz@infradead.org, kirill.shutemov@linux.intel.com,
        torvalds@linux-foundation.org, mingo@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, luto@amacapital.net
Subject: Re: [tip:x86/boot] x86/boot/compressed/64: Handle 5-level paging
 boot if kernel is above 4G
Message-ID: <20180213065155.GA14087@outlook.office365.com>
References: <tip-b4b56015ed1c98cbc9469e35ebbc4373a2844030@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <tip-b4b56015ed1c98cbc9469e35ebbc4373a2844030@git.kernel.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Originating-IP: [73.140.212.29]
X-ClientProxiedBy: MWHPR08CA0009.namprd08.prod.outlook.com
 (2603:10b6:301:5f::22) To DB5PR08MB0741.eurprd08.prod.outlook.com
 (2a01:111:e400:599c::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1d3bfbc-61a8-470f-9151-08d572ae5325
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DB5PR08MB0741;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR08MB0741;3:iNh6EoaFJyHqAugHVVNw5unpsXSjeWsWbu0AljNhzAAqsfbxTpH7dZu06cqYHNaZVymetIY83GSn9cKXSb6DQrkK/JZ6eltvPKggBiv7Fq/3kaS/USvhCQZLIfMZURmTbpUyFu6wiz6yWNHq0f3X8BMafovHO/5uzt5IG+//7wUp+Phx94AlMUc6GKkqwqZgZWZ16Urt64PMuoQq4Z++4C6L0LCfEGRqNIjGhRL2m5NgOzDj7SPvyJJrhOLwfvMq;25:xA4nYVNN+s6zCEqJmTJPrcn+FvAqIAxJeqEdgMkkt+fQFHeKJmD2nkDrVPtevNVKI7pNgSXTLQp0g9hRm5O4K0CznpOYgjf+wC7N6pTVrmk75QOXxDcEAtKQ1LrhdnJajTBrq0w8UOL5kKOX6LLu9t5SwJMbemrQHhb5vo2ABz7Q5ScXcHNRGZvBgMMZ5k/jNxon2X23QWTSkfKudjCdVnPvfVc+0eN+nTUFxGXhlSiyQY0NBIBCe7Ojsoj46GW+nELufNKGD1tb7bPvzV6tMSrpwX/xyUq3RVK6DrvxLB21Iy+EUL2shVEaFk3OJRJr2URPR2DdQ8fax7Ety4O2vQ==;31:0t7gNzMbtVhnMV41x++PIXObHJWyXnXqe0T50X0Ydkevks8qhqwvWPvFFUHELxvPNOrxMGGGbMjtwMUqlU4+WFlZZ5Y8iojOvc3NQ0SCW9Y5grscAeeChQNYokuYFcfjMehpXkBObUcE6ufQl1e8MxFE4WLZlEgfGpdyBvQxJai9E+Uy4l4TIyh200JY79xr9+VaLQsG4EthPHsK7YTdII9Q8hjCd0Cx6vsIynj4FaQ=
X-MS-TrafficTypeDiagnostic: DB5PR08MB0741:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR08MB0741;20:P43QCbM+p8IG/om1P9vq894T7mn9AqvwzEL2LmwggesGgH6yJF+ZCG71E9Onee1roZlbWP7H+yVUjZerlU44wh1f9sqJHTsLR1JbWlIumv1AoYWISeWv5OEzMtTDgSpbK6abh4fPnNKW0v2YLiQZEFsl78xcgTV19xBrEO8VGsW27Xis6E4951Qbe8PpzGcCLRAOIPcBvDob/kGIyaEX5nvFO3wFgK0IfgJsnMoF/LMHKAq58zF1EiLKfeClaqYtx8USVljzILgyxp0l90IXiNZ8LSzldBoSRk7PgRd8pu/qEXaj68a3fX/Po3lsr0ZmesKWOcmkvIrFJx62gBP/uiTJbNRViAr46eOAmtSI3dIg4YZ9dyz1FNohmZAI33k0FhMC8uCqvcXoYhjhuATcrkbZahf4gpF1QUx2MUJZTgk2gWB3KapWxhxH9XYYs/3BzvcxKaTZu0PJq9I+l9YwdbGAlYb1nQQVsfY9AdjE09oqVs4wCLnAy7VjQWWEUUSt;4:iCqplJ1uAO+OYAG9IoC+4c8MTL4IbzU6AYIzGdLRlwvJTUiZGt+Lw1Tdl1VCJrN8yrFPHpBVVero+5P+d/Px7bc42cHKhQPzHqRWxmiwrfulcGwb2bm8URSZO0No+rEov3DqyMQ5llhB/QxAp4IadGyWgenq7tFRgSOelSnXgOs7pIjvr01OSdfGs6MbM3kjp/en66kltGxL0SKtaJqZpSA70wtosbTtbzw9YSyLGhDnP0X9iL+CBUs00GHK8viN6AE1vIvTUfQc1nS/TizrWdDu/2EcwCu1cezo78v4UJrtQa/qiRRABPbfF/zylB6VNhcT1GlsRYNevz4Ei5nU6fcjGXypW7yoh/eR5v1xyjs6FeYzy3oBR2q4pjrDaiDNU2E7B1AeazZVxisRM4ljx6qjD17yYMNldkNk5WHBlN0=
X-Microsoft-Antispam-PRVS: <DB5PR08MB0741372D2A227288BF46D12BCFF60@DB5PR08MB0741.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(251416522907027)(42068640409301)(84791874153150)(228905959029699);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231101)(2400082)(944501161)(6041288)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:DB5PR08MB0741;BCL:0;PCL:0;RULEID:;SRVR:DB5PR08MB0741;
X-Forefront-PRVS: 0582641F53
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(39840400004)(396003)(366004)(189003)(199004)(47776003)(53936002)(55016002)(6306002)(9686003)(6246003)(66066001)(33656002)(69596002)(105586002)(7696005)(53416004)(52116002)(3846002)(6116002)(1076002)(86362001)(2906002)(83506002)(5660300001)(2950100002)(6666003)(106356001)(16526019)(186003)(26005)(6506007)(76176011)(386003)(59450400001)(81156014)(8676002)(81166006)(478600001)(229853002)(4326008)(50466002)(25786009)(97736004)(7416002)(305945005)(7736002)(23686003)(16586007)(966005)(316002)(8936002)(58126008)(68736007)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB5PR08MB0741;H:outlook.office365.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?koi8-r?Q?1;DB5PR08MB0741;23:1pYfDvye1Rkm3+3sMAsxVMzXgw9vOCt1HdP4b7rMEme?=
 =?koi8-r?Q?q92aseCD/D8QSCu3xBtPIvzlqzB0Zsiv2/AGSQWjboxqYCRHrJks8eiODOqp0r?=
 =?koi8-r?Q?7zO22ZKhl40cjdw48MV5YSgRZkkpXR78/c1+WfGToJmSNyMXp+RXuzSs0OAmNv?=
 =?koi8-r?Q?S+PTR05Yv/WW7sulFdci8X0mJZ1zKkvf8eHJ6LafwfXdqXKJp5idBetp8+6ru5?=
 =?koi8-r?Q?mi4DsN1MKb/6Iwlj4r4ycxfWGT3WzyvVjWEW1K8EDtpwRlgH6LDtFmZ98SaZLP?=
 =?koi8-r?Q?szsH/Qm11U+XOF7XRaRJHpCiWEjsn/YUgtit0OiI9KhW2lA3HDXGT3PfBadlFw?=
 =?koi8-r?Q?ccUzWWHpW2U+8cOQSf0E5M/fOzErdVag9sEsIqEJyORIEIR2VR9qCItrPsCAiw?=
 =?koi8-r?Q?CA3+LIne7eetHDQjCFIt3/XvXW6agCjHNgPWbjwkjOM8/S9fpgS6ETZtFjFyOB?=
 =?koi8-r?Q?S83jMwV7gPw0q3NS1giq5pZGyT8dxBFQoEr1mzsMCqb6wDUmaK9OHDCV4TZ4AE?=
 =?koi8-r?Q?sBbPoL1m1UqjgKmmgkDfaPgxUo768CO5S9z4m7eZ6vdVuxNsSfJpGogHTGeC7P?=
 =?koi8-r?Q?KH/rV1I+SmU9y549IsFp5/7p03YWdnYcsl9L6lMrPO4U7BofOi5BXxMfrI6cJl?=
 =?koi8-r?Q?cENrPsALemWQLGUxqXpAFi5jIwFH9CWoX5sonzm5W6bQGYEPTjn1/vFI8oYbbC?=
 =?koi8-r?Q?iFqMnMPMXOJe/prBA8oje11//XRSZwNavVougyrWVO5t/2y4Sjq8hV3QHbcyFn?=
 =?koi8-r?Q?WHJjMe6WmnjZbOc43cWFaPy5TVHfVcGPjqecMpTykrV5MkF+fp25s6+xL+XLj8?=
 =?koi8-r?Q?BoXVOD9yOTld/054zVzsfpaln50ffYTPthZT/e9Qck34woZgy4fc7EXn/OSeK4?=
 =?koi8-r?Q?6fbwyVlaK4Sw4YjVve+PxeLcVV8XpJp6yE3RZeAGlxzS02+4bULGLelx9P0tNR?=
 =?koi8-r?Q?DgxvV5kbqv6u3qGZ/J0EqiLwUM/Cki+OB8dJ7axF83QxapeO8l6ClxWSjeYEGs?=
 =?koi8-r?Q?rWHCIVamdSUHVr4kO8UEX76qorqqCxMw/Yq/G5WKksZJ82YRyqT3PbVDb2Ci27?=
 =?koi8-r?Q?qq5+nFpBBNLM3+oZwbDILTxdy/k9y1ikZbfNm9CtgrwzG0qk8jrw36tS7m4jfW?=
 =?koi8-r?Q?ESKDbe7ss2UQYldEMUG29zZY81TKAu+6XZmkvMl7RJxa6OdNYOCg2+mOruvjjl?=
 =?koi8-r?Q?/Lavz06LrgxdR+sPwy11i64ZFXa2fJTHVSdmu+NxBpt23mV3x39hqrwIlZCMKW?=
 =?koi8-r?Q?8+yQan72JUldQKpmhJJ6NqbBrcxqzK1yakk+bFqw=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DB5PR08MB0741;6:FHyO39akhZfHa3CrnBm+Q0zjoAgoDWMUZh6Ku1YdYXyZ0whsY2hg+OLzmmRByXhwB8ECsBBYkbY8yOloHTX548PnArf63AuDEkxl87sKvebeV3V/Utk3gdNHYha1EP3m0R0Oo8vs3bQTul2QR8KDPk+245trktaHmw5nX8DvBLWiyeze7yhQIvmYpbUXF6sJ0vMoQsLVaeQpuVjeuTZ25M67vK98FcI28tNW3405lOuquwi2RlstGKX5jcXMNlan/B8THywpu4Bhv+h7pRCRzVteUVq3XgJ4IhyPd2priwNslJlxHEhItZE33AjqotsZBjIKcNQNLeFb4/YBcETHeJA1Y76Wekl+D1ZeEm5Xoik=;5:BvhiEnSvxemATwCrQO3ZlM1DHZEEq15dG0msniimnxpc6Q5nck0NkYLqN/BDMoG+31qy5J7+ly65Iu7t9SYOjOR2lxllQ0prSBjrkuuDLHTZtVT5K6d8xUMT1qu72th4drh5OqmKYKaNLtji6u8mw/4uzKmQ1cSBtGZbWaXmB20=;24:nGwaVrJCY6vNjh+rFEIb9EIDhLxSjpGqX3prlX5Bso6I6nbKaPF6EVguq1BE4rtf+tb/Wg/J26mnNgxJu9mlTwWbcJJERbsycPQSoI3g2iw=;7:BV42S7ad/Nhwsog974ZMqo9qVmR41TIgT5d0Mm9FzKNNBzRhifw6Vm9WLSNmBeqw1vlrYzT+aD9J6UkayMFLgwDQLKmI5Fc/WQ/nHHyNxqrOCdjGCpa9jVzT+Ww3+O9Bv0Jsm2WNdxEpcdy5iHrpgQiPNktT3pYPp/4awVDP6wWBGPNPf95NGMnc1AEaHVasUBEzxaCnhzMfDBv3okieq9qhg9c6EjGfeM3D4ECXZyWBoZC7sQ6VLwcpm+Tcdx/b
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB5PR08MB0741;20:p4y0kKXnQkOnx8hKnybOm2MOH49tryi9zM+xHxHrCeJP6VoqX65aHUS6xsNO6glIFGRhC7agEBpo5cuU0XpfargJ229RDesr5TAfpBKph5U8DBRTAFayuLe9SDn/QQ6/kXbRCGvFQmqFzSpVfwOoQyMmfIKMGKHglBzsbOnHfDg=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2018 06:52:10.3729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d3bfbc-61a8-470f-9151-08d572ae5325
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR08MB0741
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kirill,

Something is wrong in this patch. We regularly run CRIU tests on
linux-next, and yesterday I found that a kernel didn't boot. We run this
tests in Travis-CI, and we don't have access to kernel logs. I tried to
reproduce the problem localy, but I failed.

In Travis-CI, we build kernel, then dump a travis deamon, boot the
kernel with help of kexec and restore the travis daemon back.

Here is logs without this patch:
https://travis-ci.org/avagin/linux/jobs/340820418

Here is logs with this patch:
https://travis-ci.org/avagin/linux/jobs/340820584

Thanks,
Andrei

On Sun, Feb 11, 2018 at 04:20:04AM -0800, tip-bot for Jacob Shin wrote:
> Commit-ID:  b4b56015ed1c98cbc9469e35ebbc4373a2844030
> Gitweb:     https://git.kernel.org/tip/b4b56015ed1c98cbc9469e35ebbc4373a2844030
> Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> AuthorDate: Fri, 9 Feb 2018 17:22:28 +0300
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Sun, 11 Feb 2018 12:36:19 +0100
> 
> x86/boot/compressed/64: Handle 5-level paging boot if kernel is above 4G
> 
> This patch addresses a shortcoming in current boot process on machines
> that supports 5-level paging.
> 
> If a bootloader enables 64-bit mode with 4-level paging, we might need to
> switch over to 5-level paging. The switching requires the disabling
> paging. It works fine if kernel itself is loaded below 4G.
> 
> But if the bootloader put the kernel above 4G (not sure if anybody does
> this), we would lose control as soon as paging is disabled, because the
> code becomes unreachable to the CPU.
> 
> This patch implements a trampoline in lower memory to handle this
> situation.
> 
> We only need the memory for a very short time, until the main kernel
> image sets up own page tables.
> 
> We go through the trampoline even if we don't have to: if we're already
> in 5-level paging mode or if we don't need to switch to it. This way the
> trampoline gets tested on every boot.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Cyrill Gorcunov <gorcunov@openvz.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-mm@kvack.org
> Link: http://lkml.kernel.org/r/20180209142228.21231-5-kirill.shutemov@linux.intel.com
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  arch/x86/boot/compressed/head_64.S | 127 ++++++++++++++++++++++++++-----------
>  1 file changed, 89 insertions(+), 38 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index af9ffbd..70b30f2 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -307,13 +307,34 @@ ENTRY(startup_64)
>  
>  	/*
>  	 * At this point we are in long mode with 4-level paging enabled,
> -	 * but we want to enable 5-level paging.
> +	 * but we might want to enable 5-level paging or vice versa.
>  	 *
> -	 * The problem is that we cannot do it directly. Setting LA57 in
> -	 * long mode would trigger #GP. So we need to switch off long mode
> -	 * first.
> +	 * The problem is that we cannot do it directly. Setting or clearing
> +	 * CR4.LA57 in long mode would trigger #GP. So we need to switch off
> +	 * long mode and paging first.
> +	 *
> +	 * We also need a trampoline in lower memory to switch over from
> +	 * 4- to 5-level paging for cases when the bootloader puts the kernel
> +	 * above 4G, but didn't enable 5-level paging for us.
> +	 *
> +	 * The same trampoline can be used to switch from 5- to 4-level paging
> +	 * mode, like when starting 4-level paging kernel via kexec() when
> +	 * original kernel worked in 5-level paging mode.
> +	 *
> +	 * For the trampoline, we need the top page table to reside in lower
> +	 * memory as we don't have a way to load 64-bit values into CR3 in
> +	 * 32-bit mode.
> +	 *
> +	 * We go though the trampoline even if we don't have to: if we're
> +	 * already in a desired paging mode. This way the trampoline code gets
> +	 * tested on every boot.
>  	 */
>  
> +	/* Make sure we have GDT with 32-bit code segment */
> +	leaq	gdt(%rip), %rax
> +	movl	%eax, gdt64+2(%rip)
> +	lgdt	gdt64(%rip)
> +
>  	/*
>  	 * paging_prepare() sets up the trampoline and checks if we need to
>  	 * enable 5-level paging.
> @@ -331,30 +352,20 @@ ENTRY(startup_64)
>  	/* Save the trampoline address in RCX */
>  	movq	%rax, %rcx
>  
> -	/* Check if we need to enable 5-level paging */
> -	cmpq	$0, %rdx
> -	jz	lvl5
> -
> -	/* Clear additional page table */
> -	leaq	lvl5_pgtable(%rbx), %rdi
> -	xorq	%rax, %rax
> -	movq	$(PAGE_SIZE/8), %rcx
> -	rep	stosq
> -
>  	/*
> -	 * Setup current CR3 as the first and only entry in a new top level
> -	 * page table.
> +	 * Load the address of trampoline_return() into RDI.
> +	 * It will be used by the trampoline to return to the main code.
>  	 */
> -	movq	%cr3, %rdi
> -	leaq	0x7 (%rdi), %rax
> -	movq	%rax, lvl5_pgtable(%rbx)
> +	leaq	trampoline_return(%rip), %rdi
>  
>  	/* Switch to compatibility mode (CS.L = 0 CS.D = 1) via far return */
>  	pushq	$__KERNEL32_CS
> -	leaq	compatible_mode(%rip), %rax
> +	leaq	TRAMPOLINE_32BIT_CODE_OFFSET(%rax), %rax
>  	pushq	%rax
>  	lretq
> -lvl5:
> +trampoline_return:
> +	/* Restore the stack, the 32-bit trampoline uses its own stack */
> +	leaq	boot_stack_end(%rbx), %rsp
>  
>  	/*
>  	 * cleanup_trampoline() would restore trampoline memory.
> @@ -503,45 +514,82 @@ relocated:
>  	jmp	*%rax
>  
>  	.code32
> +/*
> + * This is the 32-bit trampoline that will be copied over to low memory.
> + *
> + * RDI contains the return address (might be above 4G).
> + * ECX contains the base address of the trampoline memory.
> + * Non zero RDX on return means we need to enable 5-level paging.
> + */
>  ENTRY(trampoline_32bit_src)
> -compatible_mode:
>  	/* Set up data and stack segments */
>  	movl	$__KERNEL_DS, %eax
>  	movl	%eax, %ds
>  	movl	%eax, %ss
>  
> +	/* Setup new stack */
> +	leal	TRAMPOLINE_32BIT_STACK_END(%ecx), %esp
> +
>  	/* Disable paging */
>  	movl	%cr0, %eax
>  	btrl	$X86_CR0_PG_BIT, %eax
>  	movl	%eax, %cr0
>  
> -	/* Point CR3 to 5-level paging */
> -	leal	lvl5_pgtable(%ebx), %eax
> -	movl	%eax, %cr3
> +	/* Check what paging mode we want to be in after the trampoline */
> +	cmpl	$0, %edx
> +	jz	1f
>  
> -	/* Enable PAE and LA57 mode */
> +	/* We want 5-level paging: don't touch CR3 if it already points to 5-level page tables */
>  	movl	%cr4, %eax
> -	orl	$(X86_CR4_PAE | X86_CR4_LA57), %eax
> +	testl	$X86_CR4_LA57, %eax
> +	jnz	3f
> +	jmp	2f
> +1:
> +	/* We want 4-level paging: don't touch CR3 if it already points to 4-level page tables */
> +	movl	%cr4, %eax
> +	testl	$X86_CR4_LA57, %eax
> +	jz	3f
> +2:
> +	/* Point CR3 to the trampoline's new top level page table */
> +	leal	TRAMPOLINE_32BIT_PGTABLE_OFFSET(%ecx), %eax
> +	movl	%eax, %cr3
> +3:
> +	/* Enable PAE and LA57 (if required) paging modes */
> +	movl	$X86_CR4_PAE, %eax
> +	cmpl	$0, %edx
> +	jz	1f
> +	orl	$X86_CR4_LA57, %eax
> +1:
>  	movl	%eax, %cr4
>  
> -	/* Calculate address we are running at */
> -	call	1f
> -1:	popl	%edi
> -	subl	$1b, %edi
> +	/* Calculate address of paging_enabled() once we are executing in the trampoline */
> +	leal	paging_enabled - trampoline_32bit_src + TRAMPOLINE_32BIT_CODE_OFFSET(%ecx), %eax
>  
> -	/* Prepare stack for far return to Long Mode */
> +	/* Prepare the stack for far return to Long Mode */
>  	pushl	$__KERNEL_CS
> -	leal	lvl5(%edi), %eax
> -	push	%eax
> +	pushl	%eax
>  
> -	/* Enable paging back */
> +	/* Enable paging again */
>  	movl	$(X86_CR0_PG | X86_CR0_PE), %eax
>  	movl	%eax, %cr0
>  
>  	lret
>  
> +	.code64
> +paging_enabled:
> +	/* Return from the trampoline */
> +	jmp	*%rdi
> +
> +	/*
> +         * The trampoline code has a size limit.
> +         * Make sure we fail to compile if the trampoline code grows
> +         * beyond TRAMPOLINE_32BIT_CODE_SIZE bytes.
> +	 */
> +	.org	trampoline_32bit_src + TRAMPOLINE_32BIT_CODE_SIZE
> +
> +	.code32
>  no_longmode:
> -	/* This isn't an x86-64 CPU so hang */
> +	/* This isn't an x86-64 CPU, so hang intentionally, we cannot continue */
>  1:
>  	hlt
>  	jmp     1b
> @@ -549,6 +597,11 @@ no_longmode:
>  #include "../../kernel/verify_cpu.S"
>  
>  	.data
> +gdt64:
> +	.word	gdt_end - gdt
> +	.long	0
> +	.word	0
> +	.quad   0
>  gdt:
>  	.word	gdt_end - gdt
>  	.long	gdt
> @@ -602,8 +655,6 @@ trampoline_save:
>  	.balign 4096
>  pgtable:
>  	.fill BOOT_PGT_SIZE, 1, 0
> -lvl5_pgtable:
> -	.fill PAGE_SIZE, 1, 0
>  
>  	.global pgtable_trampoline
>  pgtable_trampoline:
