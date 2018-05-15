Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752878AbeEOKat (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 06:30:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45914 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752243AbeEOKar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 06:30:47 -0400
Date: Tue, 15 May 2018 12:30:43 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH RFC 07/19] perf tools: Workaround missing maps for x86_64
 KPTI entry trampolines
Message-ID: <20180515103043.GA7425@krava>
References: <1525866228-30321-1-git-send-email-adrian.hunter@intel.com>
 <1525866228-30321-8-git-send-email-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525866228-30321-8-git-send-email-adrian.hunter@intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2018 at 02:43:36PM +0300, Adrian Hunter wrote:

SNIP

> +
> +	for (i = 0; i < ARRAY_SIZE(syms); i++) {
> +		if (syms[i].addr)
> +			return syms[i].addr;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * These values can be used for kernels that do not have symbols for the entry
> + * trampolines in kallsyms.
> + */
> +#define X86_64_CPU_ENTRY_AREA_PER_CPU	0xfffffe0000000000ULL
> +#define X86_64_CPU_ENTRY_AREA_SIZE	0x2c000
> +#define X86_64_ENTRY_TRAMPOLINE		0x6000
> +
> +/* Map x86_64 KPTI entry trampolines */
> +int machine__map_x86_64_entry_trampolines(struct machine *machine,
> +					  struct dso *kernel)
> +{

would it make sense to put all this under arch/x86/util/machine.c ?

jirka
