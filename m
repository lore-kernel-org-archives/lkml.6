Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2858053-1518874444-2-1175781530320379090
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518874444; b=O7yT9ZU2H+NJBZqW5ICoVY+Z0lD0Sk8Q+Ad/mKF32L/MEYj
    031EIwMnQGq+2BwAQ46HhOgF2JuNQQkmGHFeQN6/0PUA9MHKzU5Iv4SjWdKi6Ond
    37B2xAzIcMoWlkvcpyFaaJBz6E2F+IEVzPFa6r300SoJzCoSOu2qDgLBraEY+rac
    eDVSQAYjw8tjHpAuAva625zk6fwEQj1I+FKPfaTCk8vlFgCpjp/v6lvj8IhrZzkI
    FLdcjLP0CE0WzV5Q6XF5qvLJ9M1rFQWQTfk3U+HLyvmdKnrGKHycVHCKF3r1J/wo
    zmieJ0zHkxjcVqko8rOaiL/E3WOgnURGzaZTAWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=arctest; t=1518874444; bh=wwNPhkeCGY9RTKIpB4l1Is6U9JVAjxAgCWb
    ok/kwuuk=; b=rJiGT7UMi+6qp5cOA9r/MpJr7Y8xR8Ju9qAE9b9Bw9G91CClGpW
    4p83/vbw/FpnFrd+K4bZETkkixwAQZYR6L+dQ2tr5+YtiJGQtJOekccqUc3qJnwS
    WiO2Syo90FPhLTJlpC3BiXVMVls8bty+eKUOgAfBmZAfSlnZJbIpkf9cDxZeM/gs
    as4EVCkoPyM+cRFn/ZyCU/FPzexk8PWcRZ1tSEzEbmnqFPhxc8tNiqVnaO430Gog
    C0l+iYX9UJ5kcitIZ8JTKU0uUvm35ZMnUetQ4Bhl8MaMAhen5TGTtx/Fh2CczXUf
    aktSA0nQgYGqENp401Ghh3JYmaWh+ya4FAQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linutronix.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linutronix.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751011AbeBQNeC (ORCPT <rfc822;greg@kroah.com>);
        Sat, 17 Feb 2018 08:34:02 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:57819 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750977AbeBQNeB (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 17 Feb 2018 08:34:01 -0500
Date: Sat, 17 Feb 2018 14:34:06 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH 4.4 33/53] x86/apic/vector: Fix off by one in error
 path
In-Reply-To: <1518814661.3422.42.camel@codethink.co.uk>
Message-ID: <alpine.DEB.2.21.1802171433390.2087@nanos.tec.linutronix.de>
References: <20180122083910.299610926@linuxfoundation.org>  <20180122083911.776154720@linuxfoundation.org> <1518814661.3422.42.camel@codethink.co.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-110430160-1518874447=:2087"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-110430160-1518874447=:2087
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 16 Feb 2018, Ben Hutchings wrote:
> On Mon, 2018-01-22 at 09:40 +0100, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Thomas Gleixner <tglx@linutronix.de>
> > 
> > commit 45d55e7bac4028af93f5fa324e69958a0b868e96 upstream.
> > 
> > Keith reported the following warning:
> > 
> > WARNING: CPU: 28 PID: 1420 at kernel/irq/matrix.c:222 irq_matrix_remove_managed+0x10f/0x120
> >   x86_vector_free_irqs+0xa1/0x180
> >   x86_vector_alloc_irqs+0x1e4/0x3a0
> >   msi_domain_alloc+0x62/0x130
> > 
> > The reason for this is that if the vector allocation fails the error
> > handling code tries to free the failed vector as well, which causes the
> > above imbalance warning to trigger.
> > 
> > Adjust the error path to handle this correctly.
> > 
> > Fixes: b5dc8e6c21e7 ("x86/irq: Use hierarchical irqdomain to manage CPU interrupt vectors")
> > Reported-by: Keith Busch <keith.busch@intel.com>
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Tested-by: Keith Busch <keith.busch@intel.com>
> > Cc: stable@vger.kernel.org
> > Link: https://lkml.kernel.org/r/alpine.DEB.2.20.1801161217300.1823@nanos
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > ---
> >  arch/x86/kernel/apic/vector.c |    7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > --- a/arch/x86/kernel/apic/vector.c
> > +++ b/arch/x86/kernel/apic/vector.c
> > @@ -359,14 +359,17 @@ static int x86_vector_alloc_irqs(struct
> >  		irq_data->chip_data = data;
> >  		irq_data->hwirq = virq + i;
> >  		err = assign_irq_vector_policy(virq + i, node, data, info);
> > -		if (err)
> > +		if (err) {
> > +			irq_data->chip_data = NULL;
> > +			free_apic_chip_data(data);
> >  			goto error;
> 
> This doesn't look quite right for 4.4.y (or any stable branch before
> 4.15.y).  When virq is a legacy IRQ this function doesn't allocate
> "data" and shouldn't free it.

Bah. I'm a moron. Lemme look at that.

--8323329-110430160-1518874447=:2087--
