Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752898AbeBFS0b (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 13:26:31 -0500
Received: from mga17.intel.com ([192.55.52.151]:46567 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752702AbeBFS0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 13:26:22 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,469,1511856000";
   d="scan'208";a="15495016"
Date: Tue, 6 Feb 2018 20:26:17 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        x86 <x86@kernel.org>, Jiri Koshina <jikos@kernel.org>
Subject: Re: [PATCH] x86: PM: Make APM idle driver initialize polling state
Message-ID: <20180206182617.GQ5453@intel.com>
References: <20180122162747.19103-1-ville.syrjala@linux.intel.com>
 <36158666.hf5grRdGNf@aspire.rjw.lan>
 <20180206163134.GO5453@intel.com>
 <1862424.1bTBpgPzTf@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1862424.1bTBpgPzTf@aspire.rjw.lan>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2018 at 07:02:58PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Update the APM driver overlooked by commit 1b39e3f813b4 (cpuidle: Make
> drivers initialize polling state) to initialize the polling state like
> the other cpuidle drivers modified by that commit to prevent cpuidle
> from crashing.
> 
> Fixes: 1b39e3f813b4 (cpuidle: Make drivers initialize polling state)
> Reported-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Tested-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

And maybe?

Cc: <stable@vger.kernel.org> # v4.14+

> ---
>  arch/x86/kernel/apm_32.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> Index: linux-pm/arch/x86/kernel/apm_32.c
> ===================================================================
> --- linux-pm.orig/arch/x86/kernel/apm_32.c
> +++ linux-pm/arch/x86/kernel/apm_32.c
> @@ -2389,6 +2389,7 @@ static int __init apm_init(void)
>  	if (HZ != 100)
>  		idle_period = (idle_period * HZ) / 100;
>  	if (idle_threshold < 100) {
> +		cpuidle_poll_state_init(&apm_idle_driver);
>  		if (!cpuidle_register_driver(&apm_idle_driver))
>  			if (cpuidle_register_device(&apm_cpuidle_device))
>  				cpuidle_unregister_driver(&apm_idle_driver);
> 

-- 
Ville Syrjälä
Intel OTC
