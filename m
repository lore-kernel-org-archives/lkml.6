Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1024438-1518814667-2-12032166150313600207
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518814667; b=pALJ9VgJr+4KOLWHXHhJ9D010A8+AyftWREQ3vWdm3B/w32
    L4u4WuLWc7ySbsi3fYoZGX9DSTFy31m9bLFynJJ+YJLgw8wEvvoXvaoytdLqVLln
    yXPoyFTIs+4qz7or4yA9OZXEbcj5qU26NwJuJr6r/aS8w0intjyR6Iuh8L/2ubk+
    YBRsFknWmR0F47ytOHfD5P2Bl+D0EsC1bmxRD4Go3ujUsNAR0XLnE6m2XSPhdJFT
    CiZYNQ9DrujjjaoIa5cSWlNpF4KRiW1OFV7R2io9gtsh9yqGD7LPwwn3EWOnABvV
    haNMuKQDMnp9ddMEP8v3XbHkhiZUXO0E6puQIjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518814667; bh=FUlJBM5gq+nBuntWZ/wA8vBu5CGpyBLZ9ZaDH0kurHA=; b=t
    CQgBSVfUZW3IbJUkP+WLpTObvHEyIi5Wdwd0XRoMCJo6t8W+05wi2McmdduyKZH9
    iRHOCfxEQHUQH9vgXUXp6yI+PTrtkQN3dndiK6ib51WC4IJJQiLIL87c8HqzHkjz
    bAFOOkyGhqY1ihxJsqXs1ycBssshbmUHqVJGBhaE6TrMhbYu6/G3Uo3dJmLPr/uo
    MrYd+JHZZK1zuLEOTCq/lvBEj6z596g4HUJyJf9kBjsOgLQcyLYg5RBmHyHogIdA
    Oto/LZpTU/IOitdLmxrVsXIQrbgtaA1NAkE8ddalkPhio0APtRsuvwwmpEEI5HGH
    F7HkUxn94AUgNzx8otp0g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750723AbeBPU5p (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 15:57:45 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:48135 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbeBPU5o (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Feb 2018 15:57:44 -0500
Message-ID: <1518814661.3422.42.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 33/53] x86/apic/vector: Fix off by one in error path
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org, Keith Busch <keith.busch@intel.com>
Date: Fri, 16 Feb 2018 20:57:41 +0000
In-Reply-To: <20180122083911.776154720@linuxfoundation.org>
References: <20180122083910.299610926@linuxfoundation.org>
         <20180122083911.776154720@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2018-01-22 at 09:40 +0100, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> commit 45d55e7bac4028af93f5fa324e69958a0b868e96 upstream.
> 
> Keith reported the following warning:
> 
> WARNING: CPU: 28 PID: 1420 at kernel/irq/matrix.c:222 irq_matrix_remove_managed+0x10f/0x120
>   x86_vector_free_irqs+0xa1/0x180
>   x86_vector_alloc_irqs+0x1e4/0x3a0
>   msi_domain_alloc+0x62/0x130
> 
> The reason for this is that if the vector allocation fails the error
> handling code tries to free the failed vector as well, which causes the
> above imbalance warning to trigger.
> 
> Adjust the error path to handle this correctly.
> 
> Fixes: b5dc8e6c21e7 ("x86/irq: Use hierarchical irqdomain to manage CPU interrupt vectors")
> Reported-by: Keith Busch <keith.busch@intel.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Keith Busch <keith.busch@intel.com>
> Cc: stable@vger.kernel.org
> Link: https://lkml.kernel.org/r/alpine.DEB.2.20.1801161217300.1823@nanos
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> ---
>  arch/x86/kernel/apic/vector.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> --- a/arch/x86/kernel/apic/vector.c
> +++ b/arch/x86/kernel/apic/vector.c
> @@ -359,14 +359,17 @@ static int x86_vector_alloc_irqs(struct
>  		irq_data->chip_data = data;
>  		irq_data->hwirq = virq + i;
>  		err = assign_irq_vector_policy(virq + i, node, data, info);
> -		if (err)
> +		if (err) {
> +			irq_data->chip_data = NULL;
> +			free_apic_chip_data(data);
>  			goto error;

This doesn't look quite right for 4.4.y (or any stable branch before
4.15.y).  When virq is a legacy IRQ this function doesn't allocate
"data" and shouldn't free it.

Ben.

> +		}
>  	}
>  
>  	return 0;
>  
>  error:
> -	x86_vector_free_irqs(domain, virq, i + 1);
> +	x86_vector_free_irqs(domain, virq, i);
>  	return err;
>  }
>  
> 
> 
> 
-- 
Ben Hutchings
Software Developer, Codethink Ltd.
