Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751828AbeFEQAq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 12:00:46 -0400
Received: from mga09.intel.com ([134.134.136.24]:63161 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751653AbeFEQAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 12:00:45 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,479,1520924400";
   d="scan'208";a="234858114"
Date: Tue, 5 Jun 2018 09:00:43 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH V3 02/17] kallsyms, x86: Export addresses of syscall
 trampolines
Message-ID: <20180605160043.GC7220@tassilo.jf.intel.com>
References: <1526986485-6562-1-git-send-email-adrian.hunter@intel.com>
 <1526986485-6562-3-git-send-email-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526986485-6562-3-git-send-email-adrian.hunter@intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +#ifdef CONFIG_X86_64
> +int arch_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
> +		     char *name)
> +{
> +	unsigned int cpu, ncpu;
> +
> +	if (symnum >= num_possible_cpus())
> +		return -EINVAL;
> +
> +	for (cpu = cpumask_first(cpu_possible_mask), ncpu = 0;
> +	     cpu < num_possible_cpus() && ncpu < symnum;
> +	     cpu = cpumask_next(cpu, cpu_possible_mask), ncpu++)
> +		;

That is max_t(unsigned, cpumask_last(cpu_possible_mask), symnum)

Rest and other kernel patches look good to me

Acked-by: Andi Kleen <ak@linux.intel.com>

-Andi
