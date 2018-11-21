Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D520DC04EBB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E13D2146D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:44:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E13D2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbeKULQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 06:16:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:46822 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725950AbeKULQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 06:16:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 88522AE6E;
        Wed, 21 Nov 2018 00:44:43 +0000 (UTC)
Date:   Wed, 21 Nov 2018 01:44:41 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        stable@vger.kernel.org
Subject: Re: [Patch v6 12/16] x86/speculation: Add 'seccomp' Spectre v2 app
 to app protection mode
In-Reply-To: <fc2524a59454509f505e120b0b63d60efcadfc98.1542757030.git.tim.c.chen@linux.intel.com>
Message-ID: <nycvar.YFH.7.76.1811210142540.21108@cbobk.fhfr.pm>
References: <cover.1542757030.git.tim.c.chen@linux.intel.com> <fc2524a59454509f505e120b0b63d60efcadfc98.1542757030.git.tim.c.chen@linux.intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2018, Tim Chen wrote:

> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index d2255f7..89b193c 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4227,12 +4227,17 @@
>  				  and STIBP mitigations against Spectre V2 attacks.
>  				  If the CPU is not vulnerable, "off" is selected.
>  				  If the CPU is vulnerable, the default mitigation
> -				  is "prctl".
> +				  is architecture and Kconfig dependent. See below.
>  			prctl   - Enable mitigations per thread by restricting
>  				  indirect branch speculation via prctl.
>  				  Mitigation for a thread is not enabled by default to
>  				  avoid mitigation overhead. The state of
>  				  of the control is inherited on fork.
> +			seccomp - Same as "prctl" above, but all seccomp threads
> +				  will disable SSB unless they explicitly opt out.

As Dave already pointed out elsewhere -- the "SSB" here is probably a 
copy/paste error. It should read something along the lines of "... will 
restrict indirect branch speculation ..."

Thanks,

-- 
Jiri Kosina
SUSE Labs

