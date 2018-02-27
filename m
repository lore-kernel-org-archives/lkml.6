Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-983322-1519719259-2-16917848751535844625
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: from='iso-8859-1', plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519719259; b=qoisCPHt0r2dsrCagQBKjRXtXWcDOB2mKeHQwuhE45f1Ne9
    Fqv2ZyEcqfmqptXSw/LsQgewjksxobOhAWcUCgNnYotHjA5n4NxcOqEqxVhouox6
    bbPgPEvw23CUa3jWj98eiVcQtH03vdAl0UIQykWjxEnBdjgOFoD3owvr79UK2EOH
    2UzALvILJSksYka/AWdA24cx23M4Pa9SLJ9Fo3ygeneEHPr9YtJbwwBWHo3SywVN
    XGgs9h2t5M9LGgA1NOCa/aiU2f7aojWL+K5iZHo8vIYYXXFRzS5B9rUx7sF4oe6X
    he/tWnLdLswEnTTFVSHuPLzNkB5vEaBK8OF3RUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1519719259; bh=Iyu52z6
    0GEo0dctRQmaLP89R9ZWcT/w+WWr9+hEIR98=; b=dPeEjCVw4npoEjQYUZsPxD5
    HYtyTqcXS3/y7KAB5ZsJOJsKvjQ3Y9mr82QoHFf29VDEoC4Hz4hGM/pe7wrsJHqG
    PHdSukWL6DfHI5BsNVvRhUPymJkSxVS2FOPVhTh5d7YybY8RB3nNJMTPbjeGVNN5
    yK2ht70dIe/Sy5Ion8xykuTcnZHgpBCxWeYUnZifgU+MRdVcTTak1TZas2JYhPL9
    VB28uiJgs2UF0ia+0taYw3wNswA/Zw5IcKBi2z1W7Qdca6Jb9FSq8wd1eh8jlcw+
    /HbSUhOc1oetM0B7WcPU6Td0e3yQGDi9QYJDFuipxFhqrGZXUQsinOw5AuqPaSg=
    =
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=citrix.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=citrix.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=citrix.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=citrix.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751974AbeB0IOQ (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 03:14:16 -0500
Received: from smtp.eu.citrix.com ([185.25.65.24]:4975 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751949AbeB0IOQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 03:14:16 -0500
X-IronPort-AV: E=Sophos;i="5.47,400,1515456000";
   d="scan'208";a="68664509"
Date: Tue, 27 Feb 2018 08:14:21 +0000
From: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To: "Shah, Amit" <aams@amazon.de>
CC: "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "Valentin, Eduardo" <eduval@lab126.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "shuo.a.liu@intel.com" <shuo.a.liu@intel.com>,
        "anoob.soman@citrix.com" <anoob.soman@citrix.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 2/2] xen: events: free irqs in error condition
Message-ID: <20180227081421.i2x3vcw6imrreshv@MacBook-Pro-de-Roger.local>
References: <1519666595-41362-1-git-send-email-aams@amazon.com>
 <1519666595-41362-3-git-send-email-aams@amazon.com>
 <20180226181439.zbdtzbv7wifjst2l@MacBook-Pro-de-Roger.local>
 <1519671423.4965.11.camel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1519671423.4965.11.camel@amazon.com>
User-Agent: NeoMutt/20171215
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 26, 2018 at 06:57:03PM +0000, Shah, Amit wrote:
> 
> On Mo, 2018-02-26 at 18:14 +0000, Roger Pau Monné wrote:
> > On Mon, Feb 26, 2018 at 05:36:35PM +0000, Amit Shah wrote:
> > > 
> > > In case of errors in irq setup for MSI, free up the allocated irqs.
> > > 
> > > Fixes: 4892c9b4ada9f9 ("xen: add support for MSI message groups")
> > > Reported-by: Hooman Mirhadi <mirhadih@amazon.com>
> > > CC: <stable@vger.kernel.org>
> > > CC: Roger Pau Monné <roger.pau@citrix.com>
> > > CC: David Vrabel <david.vrabel@citrix.com>
> > > CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> > > CC: Eduardo Valentin <eduval@amazon.com>
> > > CC: Juergen Gross <jgross@suse.com>
> > > CC: Thomas Gleixner <tglx@linutronix.de>
> > > CC: "K. Y. Srinivasan" <kys@microsoft.com>
> > > CC: Liu Shuo <shuo.a.liu@intel.com>
> > > CC: Anoob Soman <anoob.soman@citrix.com>
> > > Signed-off-by: Amit Shah <aams@amazon.com>
> > > ---
> > >  drivers/xen/events/events_base.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/xen/events/events_base.c
> > > b/drivers/xen/events/events_base.c
> > > index b6b8b29..96aa575 100644
> > > --- a/drivers/xen/events/events_base.c
> > > +++ b/drivers/xen/events/events_base.c
> > > @@ -758,6 +758,7 @@ int xen_bind_pirq_msi_to_irq(struct pci_dev
> > > *dev, struct msi_desc *msidesc,
> > >  error_irq:
> > >  	for (; i >= 0; i--)
> > >  		__unbind_from_irq(irq + i);
> > > +	xen_free_irq(irq);
> > Hm, xen_free_irq calls irq_free_desc, which is irq_free_descs(irq,
> > 1),
> 
> Er...  right.
> 
> > I think you will have to introduce a new free function:
> > 
> > xen_free_irqs(unsigned irq, unsigned int nr)
> > 
> > That calls irq_free_descs(irq, nr)
> 
> Actually, xen_free_irq() is already done in __unbind_from_irq(), so
> this patch is actually wrong and not needed.

You still need to free unbound IRQs, AFAICT you could fix the issue
with a single patch, like:

while (nvec--) {
	if (nvec >= i)
		xen_free_irq(irq + i);
	else
		__unbind_from_irq(irq + i);
}

Roger.
