Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1279864-1521017382-2-12104718319567804400
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521017381; b=CM/t9VU4dDAnz7NFQFBG25Jv9ofuNSQYRCDhOC1yyXYCLGM
    Wy3sjroZD2+eQg35POsTv1KG8dRg4pUtY1y3PxCHA71mIMgn1Mr21ykEdBJt7FXz
    1/3noW67s8jQQM262I2yS5sOQEmCLhbjGrzXTdkgXSKw8aLky3awnCfp6PTBFIDV
    OLHJ1TqAWJZlu1uBOyvwzhSZbqhPoI4Iisoufsd+MYhgHkkTixero/xqCe6qvuv8
    nm9lbl6FmnJZXWf0No7/w54+yOZW2R+aro+21yCiR4aHgCK7UO7UG1Lc03aNZa3+
    yaZc0aEp08GJqm3a0y4KMUCLS7QtMrLpoJlENBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:date:from:to:cc:subject
    :references:in-reply-to:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521017381; bh=A0JWoWLBilB/ENjtfXD/2noNhgc0s8zvKL+k+rTaP4Y=; b=Y
    JVizzk9HNgyEf1iNGtRNWbUAA8IDyeVm3k6zTkVwYfD9UMeYzy85bAHyRvm8/QO5
    PgMXnnizqS3Vro8AOok3WHWDV5EseKX34Dx8lKhwdpOWBMfYfNPd8gu0xC7bBDbv
    emsiHlYPhcerH3DAXcQdE1JlthDR8DKFYV8/XpIqP+mPHn5NvzL1HXyfxxwWn+vc
    OmvcNVI/h5tRH5OFMYNautWb5/cyLZiETLe2Cz8bGc+TnxWoWTUHiq1Ufwm58cMP
    VuWYrr0Cc6L9e/ZpZ8M2btiHIxfTa7UeHOs4OqPg20PinXzjoZU0ppnpy1P8CwlW
    zcFUIQEZ0YyzBc0mFEKDw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-90 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-90 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752915AbeCNIs5 convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Wed, 14 Mar 2018 04:48:57 -0400
Received: from prv-mh.provo.novell.com ([137.65.248.74]:53745 "EHLO
        prv-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753418AbeCNIsz (ORCPT
        <rfc822;groupwise-stable@vger.kernel.org:7:2>);
        Wed, 14 Mar 2018 04:48:55 -0400
Message-Id: <5AA8F00302000078001B15EE@prv-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date: Wed, 14 Mar 2018 02:48:51 -0600
From: "Jan Beulich" <JBeulich@suse.com>
To: "Juergen Gross" <jgross@suse.com>
Cc: <x86@kernel.org>, <tglx@linutronix.de>,
        <xen-devel@lists.xenproject.org>, <boris.ostrovsky@oracle.com>,
        <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, <hpa@zytor.com>
Subject: Re: [PATCH] x86/xen: zero MSR_IA32_SPEC_CTRL before suspend
References: <20180226140818.4849-1-jgross@suse.com>
In-Reply-To: <20180226140818.4849-1-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

>>> On 26.02.18 at 15:08, <jgross@suse.com> wrote:
> @@ -35,6 +40,9 @@ void xen_arch_post_suspend(int cancelled)
>  
>  static void xen_vcpu_notify_restore(void *data)
>  {
> +	if (xen_pv_domain() && boot_cpu_has(X86_FEATURE_SPEC_CTRL))
> +		wrmsrl(MSR_IA32_SPEC_CTRL, this_cpu_read(spec_ctrl));
> +
>  	/* Boot processor notified via generic timekeeping_resume() */
>  	if (smp_processor_id() == 0)
>  		return;
> @@ -44,7 +52,15 @@ static void xen_vcpu_notify_restore(void *data)
>  
>  static void xen_vcpu_notify_suspend(void *data)
>  {
> +	u64 tmp;
> +
>  	tick_suspend_local();
> +
> +	if (xen_pv_domain() && boot_cpu_has(X86_FEATURE_SPEC_CTRL)) {
> +		rdmsrl(MSR_IA32_SPEC_CTRL, tmp);
> +		this_cpu_write(spec_ctrl, tmp);
> +		wrmsrl(MSR_IA32_SPEC_CTRL, 0);
> +	}
>  }

While investigating ways how to do something similar on our old,
non-pvops kernels I've started wondering if this solution is actually
correct in all cases. Of course discussing this is complicated by the
fact that the change there might be a conflict with hasn't landed
in Linus'es tree yet (see e.g.
https://patchwork.kernel.org/patch/10153843/ for an upstream
submission; I haven't been able to find any discussion on that
patch or why it isn't upstream yet), but we have it in our various
branches. The potential problem I'm seeing is with the clearing
and re-setting of SPEC_CTRL around CPUs going idle. While the
active CPU could have preemption disabled (if that isn't the case
already), the passive CPUs are - afaict - neither under full control
of drivers/xen/manage.c:do_suspend() nor excluded yet from
any further scheduling activity. Hence with code like this (taken
from one of our branches)

static void mwait_idle(void)
{
	if (!current_set_polling_and_test()) {
		trace_cpu_idle_rcuidle(1, smp_processor_id());
		if (this_cpu_has(X86_BUG_CLFLUSH_MONITOR)) {
			smp_mb(); /* quirk */
			clflush((void *)&current_thread_info()->flags);
			smp_mb(); /* quirk */
		}

		x86_disable_ibrs();

		__monitor((void *)&current_thread_info()->flags, 0, 0);
		if (!need_resched())
			__sti_mwait(0, 0);
		else
			local_irq_enable();

		x86_enable_ibrs();
		...

the MSR might get set to non-zero again after having been
cleared by the code your patch adds. I therefore think that the
only race free solution would be to do the clearing from
stop-machine context. But maybe I'm overlooking something.

Jan
