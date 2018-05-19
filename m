Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752519AbeESPVq (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 11:21:46 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:56021 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752344AbeESPVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 11:21:45 -0400
Date: Sat, 19 May 2018 17:21:24 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Reinette Chatre <reinette.chatre@intel.com>
cc: fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com, gavin.hindman@intel.com,
        jithu.joseph@intel.com, dave.hansen@intel.com, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 13/39] x86/intel_rdt: Introduce "bit_usage" to display
 cache allocations details
In-Reply-To: <907ae15e0f840e47874ebf53fce828c7cda65fdf.1524649902.git.reinette.chatre@intel.com>
Message-ID: <alpine.DEB.2.21.1805191720130.1599@nanos.tec.linutronix.de>
References: <cover.1524649902.git.reinette.chatre@intel.com> <907ae15e0f840e47874ebf53fce828c7cda65fdf.1524649902.git.reinette.chatre@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Apr 2018, Reinette Chatre wrote:
> +		for (i = 0; i < r->num_closid; i++, ctrl++) {
> +			if (closid_allocated(i)) {

You can spare an indentation level if you just do:

			if (!closid_allocated())
	      			continue;

> +				mode = rdtgroup_mode_by_closid(i);
> +				switch (mode) {
> +				case RDT_MODE_SHAREABLE:
> +					sw_shareable |= *ctrl;
> +					break;
> +				case RDT_MODE_EXCLUSIVE:
> +					exclusive |= *ctrl;
> +					break;
> +				case RDT_NUM_MODES:
> +					WARN(1,
> +					     "invalid mode for closid %d\n", i);
> +					break;
> +				}

Thanks,

	tglx
