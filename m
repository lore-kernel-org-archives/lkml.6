Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F62FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50DA620865
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o5ssb48h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50DA620865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392666AbeKVSVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 13:21:40 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42589 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730074AbeKVSVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 13:21:40 -0500
Received: by mail-wr1-f66.google.com with SMTP id q18so8177505wrx.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 23:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OO4QWO4GCaDeVR4ARqHJykh+lhmA/ST5CIgOVXWeyiY=;
        b=o5ssb48hlnsEQiefh5/cTJ1URgzUYyE5PFCs3zHiLbJkGgMvZB922L/Lw4TrYtedRA
         0AwtVcaNdIzYIAQeJIc7BbCbAPnwH9wL9KtT9/8WIeWeD/jugIuzsr9xI9bHCTJRYby/
         pfapY2iO1Gn31VCg73XzqRN55qa8nyWtJN6L8JG10OU7xk3TsBcPQhlkJwDKl0C9Nyqo
         MQ8njeW9x35FkM2aBmcnFOCaXKpEpb+727ZmytWBnPSRo0tQOJBYA0PsnQNgU5F4D5YU
         c7+RV3pvNwvXC/zpHWMIjmDOAKJckAf+jZr5wEfevXqz4gr438AtiRJ2e5jXFDGNO/Mf
         ieWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OO4QWO4GCaDeVR4ARqHJykh+lhmA/ST5CIgOVXWeyiY=;
        b=ZeqWp8MtOLPoWaz+v1Yny5VtJzkFDCKm42Q+Ds1+gy+jW4sc9iBHI+ubBmHVWcxA/3
         E5zRjQc8RCPvEXtOd8e68GRjzRILw1zJxVu7m+GIWqAXGGpBAPYphhmIZtDJN2z4sLZ5
         ltT1dUXvLa3O/PM7+wc6hYX4gxTVUaoNPCcB3JW+OiYJZJpZcMdvndTj9WUgd+Bc9PtR
         zh6deYhtoyObi3iaMmjijRIY7XGYBZ/2PnhYC81o53JvXHU6LhdWX0sIAB+cojygrxWD
         CHI4RHFgatJHkv4F0U0D/kAkB4BV+rMoMRBV4TG4P61UaY7fiUXnRXZlIEwUCwqWphNx
         RMjQ==
X-Gm-Message-State: AA+aEWbAHP1fLBm1pXTnTduLzepeXMZmW771u53/4OSu31HBhHdOG4V1
        TmAenlApBU5AXoUoaWR7Xqw=
X-Google-Smtp-Source: AFSGD/XQmWqaQZsvpUWrrmYl1xKsfE2pmQxA7+uPStDeUXwmDV9zELwVtAzc1geHn3JZP/HdUu2NBA==
X-Received: by 2002:adf:a357:: with SMTP id d23mr8912976wrb.195.1542872605390;
        Wed, 21 Nov 2018 23:43:25 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id a4-v6sm43847097wrr.71.2018.11.21.23.43.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 23:43:24 -0800 (PST)
Date:   Thu, 22 Nov 2018 08:43:22 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
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
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch 20/24] x86/speculation: Split out TIF update
Message-ID: <20181122074322.GE41788@gmail.com>
References: <20181121201430.559770965@linutronix.de>
 <20181121201724.227260385@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121201724.227260385@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> The update of the TIF_SSBD flag and the conditional speculation control MSR
> update is done in the ssb_prctl_set() function directly. The upcoming prctl
> support for controlling indirect branch speculation via STIBP needs the
> same mechanism.
> 
> Split the code out and make it reusable.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/kernel/cpu/bugs.c |   31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)
> 
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -703,10 +703,25 @@ static void ssb_select_mitigation(void)
>  #undef pr_fmt
>  #define pr_fmt(fmt)     "Speculation prctl: " fmt
>  
> -static int ssb_prctl_set(struct task_struct *task, unsigned long ctrl)
> +static void task_update_spec_tif(struct task_struct *tsk, int tifbit, bool on)
>  {
>  	bool update;
>  
> +	if (on)
> +		update = !test_and_set_tsk_thread_flag(tsk, tifbit);
> +	else
> +		update = test_and_clear_tsk_thread_flag(tsk, tifbit);
> +
> +	/*
> +	 * If being set on non-current task, delay setting the CPU
> +	 * mitigation until it is scheduled next.
> +	 */
> +	if (tsk == current && update)
> +		speculation_ctrl_update_current();

Had to read this twice, because the comment and the code are both correct 
but deal with the inverse case. This might have helped:

	/*
	 * Immediately update the speculation MSRs on the current task,
	 * but for non-current tasks delay setting the CPU mitigation 
	 * until it is scheduled next.
	 */
	if (tsk == current && update)
		speculation_ctrl_update_current();

But can the target task ever be non-current here? I don't think so: the 
two callers are prctl and seccomp, and both are passing in the current 
task pointer.

If so then it would be nice to rename all these task variable names from 
'task' to 'curr' or such, to make this property apparent.

Then we can also remove the condition and the comment, and update 
unconditionally, and maybe add:

	WARN_ON_ONCE(curr != current);

... or so?

Thanks,

	Ingo
