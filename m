Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2055499-1519753196-2-14673378048512249202
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519753195; b=B9eXkH7Ng0k/LhJrObmFvdBqjWAUW0ZpYbu1/KQgLaclj0w
    kvR/zTT+JKHJdCeFOcoSzcz8BjSNdi/aME2lJNOhOfThm4RJDUMfaFbwhJEWSkdQ
    ffxkqHUln8fGSRQCUfQrUeI6oDwJZhxT2KxwgNBBg+xUBFQe6Hw/JH9Q0AD9xnPJ
    a1QoHGnU/SK6DPMb+RqqY3wrdsJI7ibPOWYGlX2D2tvTLKljbJoM7DmNL5AK7vLR
    0Xi199BymRZGrncl4Y4k4VFJ9f9kwb5iJ2/SuPBU4PVUT3qvlDg/k64d2zY81K/S
    iG47VaYy4yBWTorsvA8JQd7W8k4+5GWZCJGYhmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519753195; bh=SrVxWykRMJvrNgXLkv+fmSMHgU69aYsRRBiGlqXhpJI=; b=e
    kBnjBqAAxf1q8on6L+yhqY8yYUz1JprmYluPs+rC0noFTFCMKAy/aOo+IJVtKczQ
    dBaP1R7Ni7HO3GC5TvlK+X4TJFcjmARMIW55eiByPtc41yUWp8h7jnzgfd8Zlcjt
    CHDrLUWUmselljZIDjdmoWYwPZsOULW6VTyE+h0r6sgeKj+i2nKzxalr09nqbX94
    qXfw+cTEiqB9QDA4HV+99k0B5nZI4/IY36ZQFHBnZDamLvj3jsP8Pn6+UqLylk1p
    DdPyNWZx/w0MuuVPsVcIgqOqcjy6eIlVPZ7C99WSQn9wEVOs1HXAIV8xjP/XuW/R
    M+Xc6KqXuK/peMTJP2OIg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=s-opensource.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=s-opensource.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=s-opensource.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=s-opensource.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751721AbeB0Rjn (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 12:39:43 -0500
Received: from osg.samsung.com ([64.30.133.232]:63077 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751518AbeB0Rjl (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 27 Feb 2018 12:39:41 -0500
Date: Tue, 27 Feb 2018 14:39:34 -0300
From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org
Subject: Re: [RFC PATCH] usb: hcd: complete URBs in threaded-IRQ context
 instead of tasklet
Message-ID: <20180227143934.2aa847ac@vento.lan>
In-Reply-To: <20180216170450.yl5owfphuvltstnt@breakpoint.cc>
References: <20180216170450.yl5owfphuvltstnt@breakpoint.cc>
Organization: Samsung
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Sebastian,

Em Fri, 16 Feb 2018 18:04:50 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> escreveu:

> I've been going over Frederic's softirq patches and it seems that there
> were two problems. One was network related, the other was Mauro's USB
> dvb-[stc] device which was not able to stream properly over time.
> 
> Here is an attempt to let the URB complete in the threaded handler
> instead of going to the tasklet. In case the system is SMP then the
> patch [0] would be required in order to have the IRQ and its thread on
> the same CPU.
> 
> Mauro, would you mind giving it a shot?

Sorry for taking some time to test it, has been busy those days...

Anyway, I tested it today. Didn't work. It keep losing data.

Regards,

> 
> [0] genirq: Let irq thread follow the effective hard irq affinity
>     https://git.kernel.org/tip/cbf8699996a6e7f2f674b3a2a4cef9f666ff613e
> 
> ---
> 
> The urb->complete callback was initially invoked in IRQ context after
> the HCD dropped its lock because the callback could re-queue the URB
> again. Later this completion was deferred to the tasklet allowing the
> HCD hold the lock. Also the BH handler can be interrupted by the IRQ
> handler adding more "completed" requests to its queue.
> While this batching is good in general, the softirq defers its doing for
> short period of time if it is running constantly without a break. This
> breaks some use cases where constant USB throughput is required.
> As an alternative approach to tasklet handling, I defer the URB
> completion to the HCD's threaded handler. There are two lists for
> "high-prio" proccessing and lower priority (to mimic current behaviour).
> The URBs in the high-priority list are always preffered over the URBs
> in the low-priority list.
> The URBs from the root-hub never create an interrupt so I currently
> process them in a workqueue (I'm not sure if an URB-enqueue in the
> completion handler would break something).
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/usb/core/hcd.c  | 131 ++++++++++++++++++++++++++++++++----------------
>  include/linux/usb/hcd.h |  14 +++---
>  2 files changed, 95 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index fc32391a34d5..8d6dd4d3cbe7 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -1775,33 +1775,75 @@ static void __usb_hcd_giveback_urb(struct urb *urb)
>  	usb_put_urb(urb);
>  }
>  
> -static void usb_giveback_urb_bh(unsigned long param)
> +static void usb_hcd_rh_gb_urb(struct work_struct *work)
>  {
> -	struct giveback_urb_bh *bh = (struct giveback_urb_bh *)param;
> -	struct list_head local_list;
> +	struct giveback_urb	*bh = container_of(work, struct giveback_urb,
> +						   rh_compl);
> +	struct list_head	urb_list;
>  
>  	spin_lock_irq(&bh->lock);
> -	bh->running = true;
> - restart:
> -	list_replace_init(&bh->head, &local_list);
> +	list_replace_init(&bh->rh_head, &urb_list);
>  	spin_unlock_irq(&bh->lock);
>  
> -	while (!list_empty(&local_list)) {
> +	while (!list_empty(&urb_list)) {
>  		struct urb *urb;
>  
> -		urb = list_entry(local_list.next, struct urb, urb_list);
> +		urb = list_first_entry(&urb_list, struct urb, urb_list);
>  		list_del_init(&urb->urb_list);
> -		bh->completing_ep = urb->ep;
>  		__usb_hcd_giveback_urb(urb);
> -		bh->completing_ep = NULL;
> +	}
> +}
> +
> +
> +#define URB_PRIO_HIGH	0
> +#define URB_PRIO_LOW	1
> +
> +static irqreturn_t usb_hcd_gb_urb(int irq, void *__hcd)
> +{
> +	struct usb_hcd		*hcd = __hcd;
> +	struct giveback_urb	*bh = &hcd->gb_urb;
> +	struct list_head	urb_list[2];
> +	int			i;
> +
> +	INIT_LIST_HEAD(&urb_list[URB_PRIO_HIGH]);
> +	INIT_LIST_HEAD(&urb_list[URB_PRIO_LOW]);
> +
> +	spin_lock_irq(&bh->lock);
> + restart:
> +	list_splice_tail_init(&bh->prio_hi_head, &urb_list[URB_PRIO_HIGH]);
> +	list_splice_tail_init(&bh->prio_lo_head, &urb_list[URB_PRIO_LOW]);
> +	spin_unlock_irq(&bh->lock);
> +
> +	for (i = 0; i < ARRAY_SIZE(urb_list); i++) {
> +		while (!list_empty(&urb_list[i])) {
> +			struct urb *urb;
> +
> +			urb = list_first_entry(&urb_list[i],
> +					       struct urb, urb_list);
> +			list_del_init(&urb->urb_list);
> +			if (i == URB_PRIO_HIGH)
> +				bh->completing_ep = urb->ep;
> +
> +			__usb_hcd_giveback_urb(urb);
> +
> +			if (i == URB_PRIO_HIGH)
> +				bh->completing_ep = NULL;
> +
> +			if (i == URB_PRIO_LOW &&
> +			    !list_empty_careful(&urb_list[URB_PRIO_HIGH])) {
> +				spin_lock_irq(&bh->lock);
> +				goto restart;
> +			}
> +		}
>  	}
>  
>  	/* check if there are new URBs to giveback */
>  	spin_lock_irq(&bh->lock);
> -	if (!list_empty(&bh->head))
> +	if (!list_empty(&bh->prio_hi_head) ||
> +	    !list_empty(&bh->prio_lo_head))
>  		goto restart;
> -	bh->running = false;
>  	spin_unlock_irq(&bh->lock);
> +	return IRQ_HANDLED;
>  }
>  
>  /**
> @@ -1823,37 +1865,32 @@ static void usb_giveback_urb_bh(unsigned long param)
>   */
>  void usb_hcd_giveback_urb(struct usb_hcd *hcd, struct urb *urb, int status)
>  {
> -	struct giveback_urb_bh *bh;
> -	bool running, high_prio_bh;
> +	struct giveback_urb	*bh = &hcd->gb_urb;
> +	struct list_head	*lh;
>  
>  	/* pass status to tasklet via unlinked */
>  	if (likely(!urb->unlinked))
>  		urb->unlinked = status;
>  
> -	if (!hcd_giveback_urb_in_bh(hcd) && !is_root_hub(urb->dev)) {
> +	if (is_root_hub(urb->dev)) {
> +		spin_lock(&bh->lock);
> +		list_add_tail(&urb->urb_list, &bh->rh_head);
> +		spin_unlock(&bh->lock);
> +		queue_work(system_highpri_wq, &bh->rh_compl);
> +		return;
> +	}
> +	if (!hcd_giveback_urb_in_bh(hcd)) {
>  		__usb_hcd_giveback_urb(urb);
>  		return;
>  	}
>  
> -	if (usb_pipeisoc(urb->pipe) || usb_pipeint(urb->pipe)) {
> -		bh = &hcd->high_prio_bh;
> -		high_prio_bh = true;
> -	} else {
> -		bh = &hcd->low_prio_bh;
> -		high_prio_bh = false;
> -	}
> -
> -	spin_lock(&bh->lock);
> -	list_add_tail(&urb->urb_list, &bh->head);
> -	running = bh->running;
> -	spin_unlock(&bh->lock);
> -
> -	if (running)
> -		;
> -	else if (high_prio_bh)
> -		tasklet_hi_schedule(&bh->bh);
> +	if (usb_pipeisoc(urb->pipe) || usb_pipeint(urb->pipe))
> +		lh = &bh->prio_hi_head;
>  	else
> -		tasklet_schedule(&bh->bh);
> +		lh = &bh->prio_lo_head;
> +	spin_lock(&bh->lock);
> +	list_add_tail(&urb->urb_list, lh);
> +	spin_unlock(&bh->lock);
>  }
>  EXPORT_SYMBOL_GPL(usb_hcd_giveback_urb);
>  
> @@ -2436,9 +2473,17 @@ irqreturn_t usb_hcd_irq (int irq, void *__hcd)
>  		rc = IRQ_NONE;
>  	else if (hcd->driver->irq(hcd) == IRQ_NONE)
>  		rc = IRQ_NONE;
> -	else
> -		rc = IRQ_HANDLED;
> +	else {
> +		struct giveback_urb	*bh = &hcd->gb_urb;
>  
> +		spin_lock(&bh->lock);
> +		if (!list_empty(&bh->prio_hi_head) ||
> +		    !list_empty(&bh->prio_lo_head))
> +			rc = IRQ_WAKE_THREAD;
> +		else
> +			rc = IRQ_HANDLED;
> +		spin_unlock(&bh->lock);
> +	}
>  	return rc;
>  }
>  EXPORT_SYMBOL_GPL(usb_hcd_irq);
> @@ -2492,12 +2537,13 @@ EXPORT_SYMBOL_GPL (usb_hc_died);
>  
>  /*-------------------------------------------------------------------------*/
>  
> -static void init_giveback_urb_bh(struct giveback_urb_bh *bh)
> +static void init_giveback_urb(struct giveback_urb *bh)
>  {
> -
>  	spin_lock_init(&bh->lock);
> -	INIT_LIST_HEAD(&bh->head);
> -	tasklet_init(&bh->bh, usb_giveback_urb_bh, (unsigned long)bh);
> +	INIT_LIST_HEAD(&bh->prio_lo_head);
> +	INIT_LIST_HEAD(&bh->prio_hi_head);
> +	INIT_LIST_HEAD(&bh->rh_head);
> +	INIT_WORK(&bh->rh_compl, usb_hcd_rh_gb_urb);
>  }
>  
>  struct usb_hcd *__usb_create_hcd(const struct hc_driver *driver,
> @@ -2672,7 +2718,8 @@ static int usb_hcd_request_irqs(struct usb_hcd *hcd,
>  
>  		snprintf(hcd->irq_descr, sizeof(hcd->irq_descr), "%s:usb%d",
>  				hcd->driver->description, hcd->self.busnum);
> -		retval = request_irq(irqnum, &usb_hcd_irq, irqflags,
> +		retval = request_threaded_irq(irqnum, usb_hcd_irq,
> +					      usb_hcd_gb_urb, irqflags,
>  				hcd->irq_descr, hcd);
>  		if (retval != 0) {
>  			dev_err(hcd->self.controller,
> @@ -2863,9 +2910,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
>  			&& device_can_wakeup(&hcd->self.root_hub->dev))
>  		dev_dbg(hcd->self.controller, "supports USB remote wakeup\n");
>  
> -	/* initialize tasklets */
> -	init_giveback_urb_bh(&hcd->high_prio_bh);
> -	init_giveback_urb_bh(&hcd->low_prio_bh);
> +	init_giveback_urb(&hcd->gb_urb);
>  
>  	/* enable irqs just before we start the controller,
>  	 * if the BIOS provides legacy PCI irqs.
> diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
> index 176900528822..12573515acb6 100644
> --- a/include/linux/usb/hcd.h
> +++ b/include/linux/usb/hcd.h
> @@ -64,11 +64,12 @@
>  
>  /*-------------------------------------------------------------------------*/
>  
> -struct giveback_urb_bh {
> -	bool running;
> +struct giveback_urb {
>  	spinlock_t lock;
> -	struct list_head  head;
> -	struct tasklet_struct bh;
> +	struct list_head	prio_lo_head;
> +	struct list_head	prio_hi_head;
> +	struct list_head	rh_head;
> +	struct work_struct	rh_compl;
>  	struct usb_host_endpoint *completing_ep;
>  };
>  
> @@ -169,8 +170,7 @@ struct usb_hcd {
>  	resource_size_t		rsrc_len;	/* memory/io resource length */
>  	unsigned		power_budget;	/* in mA, 0 = no limit */
>  
> -	struct giveback_urb_bh  high_prio_bh;
> -	struct giveback_urb_bh  low_prio_bh;
> +	struct giveback_urb	gb_urb;
>  
>  	/* bandwidth_mutex should be taken before adding or removing
>  	 * any new bus bandwidth constraints:
> @@ -410,7 +410,7 @@ static inline int hcd_giveback_urb_in_bh(struct usb_hcd *hcd)
>  static inline bool hcd_periodic_completion_in_progress(struct usb_hcd *hcd,
>  		struct usb_host_endpoint *ep)
>  {
> -	return hcd->high_prio_bh.completing_ep == ep;
> +	return hcd->gb_urb.completing_ep == ep;
>  }
>  
>  extern int usb_hcd_link_urb_to_ep(struct usb_hcd *hcd, struct urb *urb);



Thanks,
Mauro
