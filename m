Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EF4C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 09:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D369D20671
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 09:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D369D20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbeKQUDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 15:03:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:35462 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725927AbeKQUDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 15:03:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7A783AD14;
        Sat, 17 Nov 2018 09:47:23 +0000 (UTC)
Date:   Sat, 17 Nov 2018 10:47:22 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
cc:     Thomas Gleixner <tglx@linutronix.de>,
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
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [Patch v5 11/16] x86/speculation: Add Spectre v2 app to app
 protection modes
In-Reply-To: <ca5dd01c12789d3f75ab1b73bfcac3bdaea93dd6.1542418937.git.tim.c.chen@linux.intel.com>
Message-ID: <nycvar.YFH.7.76.1811171044510.21108@cbobk.fhfr.pm>
References: <cover.1542418936.git.tim.c.chen@linux.intel.com> <ca5dd01c12789d3f75ab1b73bfcac3bdaea93dd6.1542418937.git.tim.c.chen@linux.intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Nov 2018, Tim Chen wrote:

> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 81d1d5a..9c306e3 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4215,6 +4215,26 @@
>  			Not specifying this option is equivalent to
>  			spectre_v2=auto.
>  
> +	spectre_v2_app2app=
> +			[X86] Control mitigation of Spectre variant 2
> +		        application to application (indirect branch speculation)
> +			vulnerability.
> +
> +			off    - Unconditionally disable mitigations
> +			lite   - Protect tasks which have requested restricted
> +				 indirect branch speculation via the
> +				 PR_SET_SPECULATION_CTRL prctl(). 

Don't we also want to do the same for SECCOMP processess, analogically how 
we do it for SSBD?

Thanks,

-- 
Jiri Kosina
SUSE Labs

