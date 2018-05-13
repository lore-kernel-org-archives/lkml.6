Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751887AbeEMTfd (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 15:35:33 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50929 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751338AbeEMTfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 15:35:32 -0400
Date: Sun, 13 May 2018 21:35:22 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Vikas Shivappa <vikas.shivappa@linux.intel.com>
cc: vikas.shivappa@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, fenghua.yu@intel.com, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, ak@linux.intel.com
Subject: Re: [PATCH 2/6] x86/intel_rdt/mba_sc: Enable/disable MBA software
 controller
In-Reply-To: <1524263781-14267-3-git-send-email-vikas.shivappa@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1805132134250.1582@nanos.tec.linutronix.de>
References: <1524263781-14267-1-git-send-email-vikas.shivappa@linux.intel.com> <1524263781-14267-3-git-send-email-vikas.shivappa@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Apr 2018, Vikas Shivappa wrote:
> +/*
> + * Enable or disable the MBA software controller
> + * which helps user specify bandwidth in MBps.
> + * MBA software controller is supported only if
> + * MBM is supported and MBA is in linear scale.
> + */
> +static int set_mba_sc(bool mba_sc)
> +{
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA];
> +
> +	if (!is_mbm_enabled() || !is_mba_linear() ||
> +	    mba_sc == is_mba_sc(r))
> +		return -1;

Please use a proper return value as this gets propagated.

Thanks,

	tglx
