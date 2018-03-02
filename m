Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427285AbeCBRAc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 12:00:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:42206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423560AbeCBRAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 12:00:31 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60527214EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 2 Mar 2018 12:00:26 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v2 2/2] ARM: ftrace: Add MODULE_PLTS support
Message-ID: <20180302120026.52f34ad2@vmware.local.home>
In-Reply-To: <20180301164343.5794-3-alexander.sverdlin@nokia.com>
References: <20180301164343.5794-1-alexander.sverdlin@nokia.com>
        <20180301164343.5794-3-alexander.sverdlin@nokia.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  1 Mar 2018 17:43:43 +0100
Alexander Sverdlin <alexander.sverdlin@nokia.com> wrote:

> diff --git a/arch/arm/include/asm/ftrace.h b/arch/arm/include/asm/ftrace.h
> index 9e842ff..3e663f9 100644
> --- a/arch/arm/include/asm/ftrace.h
> +++ b/arch/arm/include/asm/ftrace.h
> @@ -19,6 +19,7 @@ struct dyn_arch_ftrace {
>  #ifdef CONFIG_OLD_MCOUNT
>  	bool	old_mcount;
>  #endif

I think you want to add:

#ifdef CONFIG_ARM_MODULE_PLTS
> +	struct module *mod;
#endif

This will add more memory overhead, and we don't want to add that if it
is not needed.

-- Steve
