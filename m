Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3462051-1519668962-3-16089886020641013078
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: from='iso-8859-1', plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519668961; b=Sx/hsGzWgo2MEBufSbpMmShBEx04MKmSbti5oKgaAEzpH4f
    R80bTdsBsM8D6yjFXr8qktlRgjcKwnhh9KYwvDQtmZThpC1IyMudaAeMDPYonQmb
    c9cNQjD+TYc4bGGt+qNg0aTQuiyY5apj9UIh+cu73Y00Iimg4RY3OvLQjAlm6Npn
    +rdK4/plDArx0z5ahU8T+8ZThdLZ0kXCNssVJ9zemHLscsn0QB4f+4RO+Zyqf1vs
    jUXuUKJlqugubieWqd1Q9Y+u9v81+UoumeqGpagEGQW/Ql3nR7IXIinxAGDLQciL
    PQ0YoEM5ydAEkxl5rKz73r7ZyAP4rgpClW/+giQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1519668961; bh=58k8gfq
    a3AFkHngLcRyeiGfm2+H5+C6XTX7Lwi/C5+8=; b=gLkVu/m0luxvg9QiZ7yTTOU
    SZ5enlDeglA3P6RXnivGakxA4YP+v/L2e1BdvhHAxmvVWWJAgGLjcnZYGmhqQO5W
    nI+0lPxsIsGqhNGw0K2l5tEdDYmkqN2K0yN1v7RkouXcWy8WLqth+l/uc909TYhj
    jMhAUuaKKzwVbQ6GdESkRU4MZtKMkhaLOt+1bZAi318t6GkdIuYPaK3Q83Jvbdco
    TYSQU4SZzzPH0farRcF+ZdMihcOpvqiIEnPM71k5TyIjJZxxk2IYJ0ONXSN5gQJw
    yMeddjf739JRCDbNvyc10co3GwWpAs+ktDcMfUv5j8qKBtDKjkFjpKEeXRp3aMQ=
    =
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=citrix.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=citrix.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=citrix.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=citrix.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751165AbeBZSP6 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 13:15:58 -0500
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:9166 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbeBZSP6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 13:15:58 -0500
X-IronPort-AV: E=Sophos;i="5.47,397,1515456000";
   d="scan'208";a="68626333"
Date: Mon, 26 Feb 2018 18:14:39 +0000
From: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To: Amit Shah <aams@amazon.com>
CC: <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, David Vrabel <david.vrabel@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Liu Shuo <shuo.a.liu@intel.com>,
        Anoob Soman <anoob.soman@citrix.com>
Subject: Re: [PATCH 2/2] xen: events: free irqs in error condition
Message-ID: <20180226181439.zbdtzbv7wifjst2l@MacBook-Pro-de-Roger.local>
References: <1519666595-41362-1-git-send-email-aams@amazon.com>
 <1519666595-41362-3-git-send-email-aams@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1519666595-41362-3-git-send-email-aams@amazon.com>
User-Agent: NeoMutt/20171215
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 26, 2018 at 05:36:35PM +0000, Amit Shah wrote:
> In case of errors in irq setup for MSI, free up the allocated irqs.
> 
> Fixes: 4892c9b4ada9f9 ("xen: add support for MSI message groups")
> Reported-by: Hooman Mirhadi <mirhadih@amazon.com>
> CC: <stable@vger.kernel.org>
> CC: Roger Pau Monné <roger.pau@citrix.com>
> CC: David Vrabel <david.vrabel@citrix.com>
> CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> CC: Eduardo Valentin <eduval@amazon.com>
> CC: Juergen Gross <jgross@suse.com>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: "K. Y. Srinivasan" <kys@microsoft.com>
> CC: Liu Shuo <shuo.a.liu@intel.com>
> CC: Anoob Soman <anoob.soman@citrix.com>
> Signed-off-by: Amit Shah <aams@amazon.com>
> ---
>  drivers/xen/events/events_base.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
> index b6b8b29..96aa575 100644
> --- a/drivers/xen/events/events_base.c
> +++ b/drivers/xen/events/events_base.c
> @@ -758,6 +758,7 @@ int xen_bind_pirq_msi_to_irq(struct pci_dev *dev, struct msi_desc *msidesc,
>  error_irq:
>  	for (; i >= 0; i--)
>  		__unbind_from_irq(irq + i);
> +	xen_free_irq(irq);

Hm, xen_free_irq calls irq_free_desc, which is irq_free_descs(irq, 1),
I think you will have to introduce a new free function:

xen_free_irqs(unsigned irq, unsigned int nr)

That calls irq_free_descs(irq, nr)

Thanks, Roger.
