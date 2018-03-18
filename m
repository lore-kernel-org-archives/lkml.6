Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754608AbeCROxv (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 10:53:51 -0400
Received: from mail-sn1nam01on0076.outbound.protection.outlook.com ([104.47.32.76]:46799
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754357AbeCROxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 10:53:34 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com;
Date: Sun, 18 Mar 2018 17:48:44 +0300
From: Yury Norov <ynorov@caviumnetworks.com>
To: Chris Metcalf <cmetcalf@mellanox.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@redhat.com>, Tejun Heo <tj@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Christoph Lameter <cl@linux.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Francis Giraldeau <francis.giraldeau@gmail.com>
Subject: Re: [PATCH v16 10/13] arch/arm: enable task isolation functionality
Message-ID: <20180318144844.ehkbx7npszfreyeh@yury-thinkpad>
References: <1509728692-10460-1-git-send-email-cmetcalf@mellanox.com>
 <1509728692-10460-11-git-send-email-cmetcalf@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1509728692-10460-11-git-send-email-cmetcalf@mellanox.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Originating-IP: [36.85.197.25]
X-ClientProxiedBy: LO2P265CA0127.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::19) To MWHPR07MB2910.namprd07.prod.outlook.com
 (2603:10b6:300:1e::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 875a7d63-ede7-4fe6-c946-08d58ce0042a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR07MB2910;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB2910;3:im8ynZC2SaUlSdSQTUvVp7Nnl54E3x4BtsiKAgMnlBI7W481tDOx1Ys+L21cO3gulVKki9XZm7/hurjPAkrRUgQ7pvdtpSc/b0NVTL/PeC5iISOgR1+ylZaJSu7jNiLa2fpmkaWLA2EKJOYp7HJ/dYqSFZZE3sl9poYNkIhlFGCuBKfFiU8X/l1s2MUxq2/F5r0zkLS3R6MpUV+/GJJvE4PqHBXQpSYzx/gA/ZKjFj8vqPN95N1c0T48iRJe8zcs;25:G4wAAlZluN3vjWRuQcWMyHCNTLdegeqRokcWhmWJFJhrQxCUr3FPhbV/L3FGCSGERZCSaErDcvCY5nhqGT9RCrpAase9RwRW2zuzkE+O6AP10MXsWsk0myMR3oouvHL1kVVQJF4sL7ssd9SIM3CU2QKiW+ecSxXfXg8+iVeoOauLON6Sg0qspzQOK9EzRQq7SFtYuBjAUFT2wXvNzmMB2ZU5lUjvrA+Y+vQwYODn19MxqKTeoSKq4ba5+4Es2Ui2TWe2C4a1LFK4RUyyxH0TLtKQC0nFfY75r0tmWC3g+rvRBbtffFKOeun5KhBapIaAKsbFQDBN0Xc5EY+FA/Vytw==;31:o2vyZaARcZjWNyq4eKa+FtjESd7WwFLJbMBgFLq2V47NmseGV/5hF4p25U2dkvEgm+mh+K5Wvc4ucnItCKfK/I0zTWzLfAqOhpVmfYdyXyyUEWSqZgxXQBvsvEMbGNr7YrXZRlDGcixAmjUHi/Nc0Gcqh67SllDw+6yj2a14PnW0bQxj8e1X6ioy4NsjDpcX0HCkWsP2qg7VFwi5jAC8HwBLEzbJmNMn2MiKz0pIlz0=
X-MS-TrafficTypeDiagnostic: MWHPR07MB2910:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB2910;20:ZnOi27t6TdDQUB6e/Unr153GT1bD3ZRDlH5NoJFwJ6uEkyuWCtw1ZU3z2ytywbigEB8TxEc7AcAVv5bWdFPSN0yjFEDd8sGLYfYEXDmwlcXr/fS4sEV4HfqEGFMheNSkS+zRnDR2bTNyQBctMTOk8OPVGyczHYiUAtCGxPSyQHeWJucxbfMVs3JKpWoMXWVPOa2YkUEGeh48+SXVp28xc6cAdBNW5xrHjWxh30CTXfUIm4pkVXBVTZ58G+FooTuDqtm7O9mEwyQBP8jUDbfwgdyTRx7CkrSiYCSO0DB9OV7w524gLwcbgYrHgsbPl/fS8wTkKVW4SsrGCRl0TWtWWuzuIwvLm7sETIpGR1kRBtA8tmimSJocTSZmIPkdEMUzjRJuq1s8FuUoYZ30I8cqYhKACKjW0NkkrBp7nHJE9N7HO6uf/jMVylugtIOvTMWqKx/edqszrIplRT2MWixpDgh/DoFdKXBcrHqtfvx1r8rvAX+T3XhF3kslFN3+9c6mA6rrfOk+woeTF4XsC868c+75kMMn3pj0xeoUJh/EEQ0LThrrMxzcTMcAsfNvCnQrknMil3aQ66U+4ZLvL4r04uIbkcrOVRypGuCbZ/5I+dY=;4:wnOB7iuQ9QGhzT5XW8lz3EQBRdb1BqE7CRrtHgWgIgamgqqBwbEI2nHkb1HsEwMOs0JU7gIlbKCO7eokYN4I9Baiqoa7KiPBGi/E0SDhroktkZGmEynLNJsaQc98Fs4XzM+x0YN2Sg1VYSsBeBTD9lPlPeRNvTDMMQPW82dW+g2ss1V8/iWb004QyW4M/j44eoLs0USs7Hzqrw2OYu0lVCoHbtRFPmuXyrmoXxLhjzSJBqiYSo1T3n8lo1oWpJx/3mf0ont1umZGYUYw/VaTC3E30esgoMuZ84fatjnm1P2YvVIT4y64RZdrEc+wodzv
X-Microsoft-Antispam-PRVS: <MWHPR07MB29109EB2BDAB50F9EF436E73E3D50@MWHPR07MB2910.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(3002001)(3231221)(944501300)(52105095)(10201501046)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR07MB2910;BCL:0;PCL:0;RULEID:;SRVR:MWHPR07MB2910;
X-Forefront-PRVS: 06157D541C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(7916004)(39850400004)(366004)(396003)(39380400002)(346002)(376002)(189003)(199004)(5660300001)(4326008)(9686003)(66066001)(76506005)(25786009)(39060400002)(105586002)(6486002)(2906002)(6246003)(50466002)(53936002)(97736004)(52116002)(72206003)(478600001)(3846002)(186003)(16526019)(6116002)(23726003)(6496006)(33896004)(106356001)(7416002)(8936002)(58126008)(81166006)(8676002)(229853002)(1076002)(33716001)(81156014)(42882007)(7736002)(305945005)(316002)(47776003)(68736007)(16586007)(6916009)(2950100002)(26005)(76176011)(386003)(54906003)(55236004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB2910;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR07MB2910;23:dRNaIvEo+OnoGDltVVbc+BaPJD2W4MjGu66PjbglC?=
 =?us-ascii?Q?Yx+g/r08tyI+MtH5P1IK5pmKHONZ3o3Veqh0OG5NoT9OyogAgRZS7h/u+Mmv?=
 =?us-ascii?Q?O2Y08kmaYYdf2PSyQK6xTO8llHicq1+dA4DTNH6p680qv2tfrQBMOfY0ADaM?=
 =?us-ascii?Q?3bcxrj3Ie6Gr5mumlwvI70wO8ziv9cbaa0ELWpo4+wzSeD7rRhSjC0p5fRjS?=
 =?us-ascii?Q?ID3rNpKBymMjjGWmgFinMup1h8sngUjU7BzqIiEPPyL1rzhOABqHUL5n4ZDJ?=
 =?us-ascii?Q?h2zTlVH3If9E/sKeIH0/DfSA2wA8GYsjENqV0h57txRBVaM1J8Af4X+Oi9kQ?=
 =?us-ascii?Q?w+O4O6YIhZmj3SDEktyomGuy5CoS1yAaXgvV1E/lpJ7/b/UbS8dYV1qGSUye?=
 =?us-ascii?Q?kfhz5s6fjNrhW9CfaWTMV5cosTVGeUm2d4dzkgMFXZBgPpqleDezf+2jgRUU?=
 =?us-ascii?Q?REVkxxX4OZ0RewalEExP1djpfwiXIZYBsY8fR9icjLCeKWzz5ZoWeFKhL9A2?=
 =?us-ascii?Q?drllc/WhGSqhy0tOum1iUZsrGNDAagtmiiePszszAMiAZ7nRltjy4Jfx47VR?=
 =?us-ascii?Q?CU5lAJugqZwlgrYdawCeCG72/GABA1LsjWBlGcvTV77y50zQ88MJsz4hT/kj?=
 =?us-ascii?Q?8Iss5Nv5B8EWrjNQRoA9GF/BDRatYzlKqKT8i/aEEu1XgDuglK7kdnxqf+rP?=
 =?us-ascii?Q?XAh4/+JiSQBrFexZRwJgh09Qhpk5co2ViB+Isg/RzBPj/Vilw4KaXAbJRWvZ?=
 =?us-ascii?Q?8hCx01S3YaHt1krYG0A4oaq7pYUjvzYPuhnUtPZaYnVGGDdbJsLYIkfBLDun?=
 =?us-ascii?Q?TanIjHKn5kJGxbtGDu0NHvj/IkLInfJvH5lBBkOsRf0vEsYOjz5ZfwdJB5Gl?=
 =?us-ascii?Q?pYd4h6Bv7PYr+Bf3iecPtOOYwjJTP2ot1+LqL6qtbrkAcEXLsqdBydDapiry?=
 =?us-ascii?Q?7CEnzqGh0+MgG1xzXPEg8X8DPUYbignn32kYHH31eBnpEgcvJ5RqNfrMWFd3?=
 =?us-ascii?Q?WDFIaAfx98HsyYjHPARDaqx1pnRHKCyT+UxVZi6jzqEie7Zs9eW1X2wyDXyK?=
 =?us-ascii?Q?1I5N80ZYimrxqWumJUIM8tUENr6jHq8nrvydR3/BH5nfimL+QzQPxTZUUS56?=
 =?us-ascii?Q?42sdE6GrTeh/w9L3ZJSUknTL+RJnz6mn/Qxm5j6MAIjUNcbQk3QWg6FD502l?=
 =?us-ascii?Q?/YYszy8O3Fyr0Qf8UoPdRZlqa/zhy/IidkBqDU11GKovVD8bYxK312Q/Ghms?=
 =?us-ascii?Q?iM/dtnBq0o0hdAb8+/nndbc9riXbS57180uf7ONCWYDd01UkC+2nRSyd/9QA?=
 =?us-ascii?Q?cGpTlxqVxFHBp6D9koGjoU=3D?=
X-Microsoft-Antispam-Message-Info: 07FyynoqDlZmjZtMSWJvXSWInUeTw40OwrfxEgXFgRo+JDGBWN4NqnO2wRt+4p/PxgMY2yQ/xVyg7OD4T7HaX+/hwFrExQgGlCnNY28orTIK3GG5HWvc3OWtmVX3RmkYhHZ7Ccv65rqLmhpfOOAcu7LmGBkhH+0cqeMVyIsiO/9hQYoACzIuKgUOX5N7m/4o
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB2910;6:xMbjda+oKPoqmPqseS/mjDKCslFSOUv//sGoyG26+s3GW9o3CJAAQAiC4Gvd17CUXcXgWNvCuajNLcpee/WJUcitRPGNkuWQUJoMUgDVVdRAbH2x55CMP1OcAvHKqgVDRf3pg+S1l26sAyIFkEG35lnoJyZymSVWwB9KWGocxqK1+oJFvBmQbAUkvaRidgD8MOZVF5lTctAuLqBU4czIIUTfYeJzcgzf3iqUDdx1myLol42zeFQO4IBmS5jiT2mU9hmB7j0Tk6af+w8/SQZKZtGp1xpbXpt+CvqDdFw3/Ez8t/iqgVri2HiBaYlHF7z4oZ70zqoqNhvjAW3G+aGb24xS4M0BoCSG0BdVnXUPnjs=;5:fkO7DHENlHnR3X4puoDA3YzNItBGJARBhG8jxlXA9isW0rGjEQgwo4TOaIoD4LfLnf4oCpSwGip3XpcAVbNE1Byo60IEIEizFXVyvsD0pWSepvb+m0Hj065lFRFAAZ6JlSpiqwaUdofSsG/tWtGrHDb9IN59pyO8mP3Tx5n9z5o=;24:+cUbLs/KdfQy5cn7q315XUIQsOogqWDALWo7nfN7jt+OkKfYA+M91Bn9Wg22FKb0Yy/YFrDmoUEOvwhsbbWMWl8idAFgAubPQF/7fvCl3/w=;7:fmNHmqa5gpJDCMykd28ODN1hRh/K2r9arC3qENP+o8p3TfpBQcCYea5LtcYrerJqyGeuNm1516OXmY65SrrZb22LKGACWrphakHhY4iWPDGVVjbKoplxyGxQa1sP7tkL49vn+eyQIYpuAtU/Zmw8BezLvK0zvWEcvXuxopN+dVep0JBlt8iqOc04Qrskvi7rmeJL5Tu6a6fFb4xAtYbUCC/thbX4hsAtajK2DpkGniaY0U4ZqhbBR+Rl6+JeAawe
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2018 14:49:40.7255 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 875a7d63-ede7-4fe6-c946-08d58ce0042a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB2910
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Francis, Chris,

On Fri, Nov 03, 2017 at 01:04:49PM -0400, Chris Metcalf wrote:
> From: Francis Giraldeau <francis.giraldeau@gmail.com>
> 
> This patch is a port of the task isolation functionality to the arm 32-bit
> architecture. The task isolation needs an additional thread flag that
> requires to change the entry assembly code to accept a bitfield larger than
> one byte.  The constants _TIF_SYSCALL_WORK and _TIF_WORK_MASK are now
> defined in the literal pool. The rest of the patch is straightforward and
> reflects what is done on other architectures.
> 
> To avoid problems with the tst instruction in the v7m build, we renumber
> TIF_SECCOMP to bit 8 and let TIF_TASK_ISOLATION use bit 7.
> 
> Signed-off-by: Francis Giraldeau <francis.giraldeau@gmail.com>
> Signed-off-by: Chris Metcalf <cmetcalf@mellanox.com> [with modifications]

[...]

> ---
> diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
> index 58e3771e4c5b..0cfcba5a93df 100644
> --- a/arch/arm/kernel/ptrace.c
> +++ b/arch/arm/kernel/ptrace.c
> @@ -27,6 +27,7 @@
>  #include <linux/audit.h>
>  #include <linux/tracehook.h>
>  #include <linux/unistd.h>
> +#include <linux/isolation.h>
>  
>  #include <asm/pgtable.h>
>  #include <asm/traps.h>
> @@ -936,6 +937,15 @@ asmlinkage int syscall_trace_enter(struct pt_regs *regs, int scno)
>  	if (test_thread_flag(TIF_SYSCALL_TRACE))
>  		tracehook_report_syscall(regs, PTRACE_SYSCALL_ENTER);
>  
> +	/*
> +	 * In task isolation mode, we may prevent the syscall from
> +	 * running, and if so we also deliver a signal to the process.
> +	 */
> +	if (test_thread_flag(TIF_TASK_ISOLATION)) {
> +		if (task_isolation_syscall(scno) == -1)
> +			return -1;
> +	}

I think it would make sense to load thread flags to local variable
because later in the code test_thread_flag() is called again to check
TIF_SYSCALL_TRACEPOINT flag, and we can avoid it, like this:

unsigned long work = READ_ONCE(current_thread_info()->flags);

Also, all other architectures cache thread flags to local
variable before use; so doing this would make sense for the sake
of unification.

Yury
