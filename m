Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365C4C476E8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D0F20779
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8D0F20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732371AbeGLQoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 12:44:14 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:58592 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbeGLQoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 12:44:13 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fdeXS-0000xP-85; Thu, 12 Jul 2018 10:33:54 -0600
Received: from [97.119.167.31] (helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fdeXC-0002Up-Ke; Thu, 12 Jul 2018 10:33:53 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Adrian Reber <adrian@lisas.de>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrei Vagin <avagin@virtuozzo.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Containers <containers@lists.linux-foundation.org>
References: <20180712130733.11510-1-adrian@lisas.de>
Date:   Thu, 12 Jul 2018 11:33:33 -0500
In-Reply-To: <20180712130733.11510-1-adrian@lisas.de> (Adrian Reber's message
        of "Thu, 12 Jul 2018 15:07:33 +0200")
Message-ID: <87sh4o5s82.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fdeXC-0002Up-Ke;;;mid=<87sh4o5s82.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+RrdsEYD0dNVbV3bOFafMRw6K0p8+gwbA=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] kconfig: remove EXPERT from CHECKPOINT_RESTORE
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Adrian Reber <adrian@lisas.de> writes:

> The CHECKPOINT_RESTORE configuration option was introduced in 2012 and
> combined with EXPERT. CHECKPOINT_RESTORE is already enabled in many
> distribution kernels and also part of the defconfigs of various
> architectures.
>
> To make it easier for distributions to enable CHECKPOINT_RESTORE this
> removes EXPERT and moves the configuration option out of the EXPERT
> block.

I think we should change the help text at the same time, to match
our improve understanding of the situation.

Does anyone remember why this option was added at all?
Why this option was placed under expert?

What is the value of disabling this functionality ever?

Is there any reason why we don't just delete CONFIG_CHECKPOINT_RESTORE
entirely?

Certainly we are at a point where distro's are enabling this so hiding
it behind CONFIG_EXPERT with a default of N seems inapparopriate.

The only thing I can imagine might be sensible is changing the default
to Y and leaving it behind CONFIG_EXPERT.

I want to know what is the point of maintaining all of the complexity of
the ifdefs.  If no one can come up with a reason I say let's just remove
CONFIG_CHECKPOINT_RESTORE entirely.

Eric


> Signed-off-by: Adrian Reber <adrian@lisas.de>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Pavel Emelyanov <xemul@virtuozzo.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Andrei Vagin <avagin@virtuozzo.com>
> Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
> ---
>  init/Kconfig | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/init/Kconfig b/init/Kconfig
> index 041f3a022122..9c529c763326 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -932,6 +932,18 @@ config NET_NS
>  
>  endif # NAMESPACES
>  
> +config CHECKPOINT_RESTORE
> +	bool "Checkpoint/restore support"
> +	select PROC_CHILDREN
> +	default n
> +	help
> +	  Enables additional kernel features in a sake of checkpoint/restore.
> +	  In particular it adds auxiliary prctl codes to setup process text,
> +	  data and heap segment sizes, and a few additional /proc filesystem
> +	  entries.
> +
> +	  If unsure, say N here.
> +
>  config SCHED_AUTOGROUP
>  	bool "Automatic process group scheduling"
>  	select CGROUPS
> @@ -1348,18 +1360,6 @@ config MEMBARRIER
>  
>  	  If unsure, say Y.
>  
> -config CHECKPOINT_RESTORE
> -	bool "Checkpoint/restore support" if EXPERT
> -	select PROC_CHILDREN
> -	default n
> -	help
> -	  Enables additional kernel features in a sake of checkpoint/restore.
> -	  In particular it adds auxiliary prctl codes to setup process text,
> -	  data and heap segment sizes, and a few additional /proc filesystem
> -	  entries.
> -
> -	  If unsure, say N here.
> -
>  config KALLSYMS
>  	 bool "Load all symbols for debugging/ksymoops" if EXPERT
>  	 default y
