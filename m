Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753905AbeDSXZY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 19:25:24 -0400
Received: from exmail.andestech.com ([59.124.169.137]:15042 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753772AbeDSXZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 19:25:20 -0400
Date: Fri, 20 Apr 2018 07:24:18 +0800
From: Alan Kao <alankao@andestech.com>
To: Atish Patra <atish.patra@wdc.com>
CC: Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, "Namhyung Kim" <namhyung@kernel.org>,
        Alex Solomatnikov <sols@sifive.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nick Hu <nickhu@andestech.com>, Greentime Hu <greentime@andestech.com>
Subject: Re: [PATCH v4 1/2] perf: riscv: preliminary RISC-V support
Message-ID: <20180419232418.GA3902@andestech.com>
References: <1524017523-25076-1-git-send-email-alankao@andestech.com>
 <1524017523-25076-2-git-send-email-alankao@andestech.com>
 <c057c7d1-421f-f4eb-3f03-2abda16d876a@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c057c7d1-421f-f4eb-3f03-2abda16d876a@wdc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w3JNHr6U002593
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 12:46:24PM -0700, Atish Patra wrote:
> On 4/17/18 7:13 PM, Alan Kao wrote:
> >This patch provide a basic PMU, riscv_base_pmu, which supports two
> >general hardware event, instructions and cycles.  Furthermore, this
> >PMU serves as a reference implementation to ease the portings in
> >the future.
> >
> >riscv_base_pmu should be able to run on any RISC-V machine that
> >conforms to the Priv-Spec.  Note that the latest qemu model hasn't
> >fully support a proper behavior of Priv-Spec 1.10 yet, but work
> >around should be easy with very small fixes.  Please check
> >https://github.com/riscv/riscv-qemu/pull/115 for future updates.
> >
> >Cc: Nick Hu <nickhu@andestech.com>
> >Cc: Greentime Hu <greentime@andestech.com>
> >Signed-off-by: Alan Kao <alankao@andestech.com>
> >---
> >  arch/riscv/Kconfig                  |  13 +
> >  arch/riscv/include/asm/perf_event.h |  79 ++++-
> >  arch/riscv/kernel/Makefile          |   1 +
> >  arch/riscv/kernel/perf_event.c      | 482 ++++++++++++++++++++++++++++
> >  4 files changed, 571 insertions(+), 4 deletions(-)
> >  create mode 100644 arch/riscv/kernel/perf_event.c
> >
> >diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> >index c22ebe08e902..90d9c8e50377 100644
> >--- a/arch/riscv/Kconfig
> >+++ b/arch/riscv/Kconfig
> Some check patch errors.
> 
> ERROR: spaces required around that '>=' (ctx:WxV)
> #517: FILE: arch/riscv/kernel/perf_event.c:356:
> +	if (riscv_pmu->irq >=0 && riscv_pmu->handle_irq) {
>  	                   ^
> 
> ERROR: spaces required around that '>=' (ctx:WxV)
> #529: FILE: arch/riscv/kernel/perf_event.c:368:
> +	if (riscv_pmu->irq >=0) {
>  	                   ^
> 
> WARNING: braces {} are not necessary for single statement blocks
> #529: FILE: arch/riscv/kernel/perf_event.c:368:
> +	if (riscv_pmu->irq >=0) {
> +		free_irq(riscv_pmu->irq, NULL);
> +	}
> 
> WARNING: DT compatible string "riscv,base-pmu" appears un-documented --
> check ./Documentation/devicetree/bindings/
> #626: FILE: arch/riscv/kernel/perf_event.c:465:
> +	{.compatible = "riscv,base-pmu",	.data = &riscv_base_pmu},
> 
> ERROR: trailing whitespace
> #634: FILE: arch/riscv/kernel/perf_event.c:473:
> +^I$
> 
> ERROR: do not use assignment in if condition
> #635: FILE: arch/riscv/kernel/perf_event.c:474:
> +	if (node && (of_id = of_match_node(riscv_pmu_of_ids, node)))
> 
> total: 4 errors, 3 warnings, 595 lines checked
> 
> 
> Regards,
> Atish

Thanks for pointing this out.  I happened to develop this patchset on a machine
without the post-commit settings.  A new version is ready.
