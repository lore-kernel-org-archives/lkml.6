Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751612AbeDDRY6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 13:24:58 -0400
Received: from mga06.intel.com ([134.134.136.31]:56165 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751494AbeDDRYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 13:24:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,407,1517904000";
   d="scan'208";a="213911128"
Subject: Re: [PATCH v4] x86,sched: allow topologies where NUMA nodes share an
 LLC
To: Alison Schofield <alison.schofield@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "H. Peter Anvin" <hpa@linux.intel.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Prarit Bhargava <prarit@redhat.com>, brice.goglin@gmail.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20180403211230.GA12842@alison-desk.jf.intel.com>
From: Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <2d00edef-c8bf-2fc6-c342-274a0681e225@linux.intel.com>
Date: Wed, 4 Apr 2018 10:24:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <20180403211230.GA12842@alison-desk.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2018 02:12 PM, Alison Schofield wrote:

> +
> +	/*
> +	 * topology_sane() considers LLCs that span NUMA nodes to be
> +	 * insane and will display a warning message. Bypass the call
> +	 * to topology_sane() for snc_cpu's to avoid that warning.
> +	 */
> +
> +	if (!topology_same_node(c, o) && x86_match_cpu(snc_cpu)) {
> +		/* Indicate that package has NUMA nodes inside: */
> +		x86_has_numa_in_package = true;

Why does the x86_has_numa_in_package has to be set here when it would have
been done later in set_cpu_sibling_map?

> +
> +		/*
> +		 * false means 'c' does not share the LLC of 'o'.
> +		 * Note: this decision gets reflected all the way
> +		 * out to userspace.
> +		 */
> +
> +		return false;

Thanks.

Tim
