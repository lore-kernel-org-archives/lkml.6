Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D494BC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 08:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7784B21525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 08:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WZCyqQ8a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7784B21525
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731388AbeITOWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 10:22:16 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35959 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeITOWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 10:22:16 -0400
Received: by mail-io1-f67.google.com with SMTP id q5-v6so6750424iop.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 01:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=rzJiNLWHOCrBj8W0kDSSC6EolcogxAS7Qdfxbo53SxI=;
        b=WZCyqQ8aqIF9VhH7bCSzdqKzdePiRjdE6P/xyvExygzMhfAW0rVtc2M3F1WbrF70Db
         OX8LWZcRI/zkHj7wZFXNl9lznGV10rYj0J41wWtDMq3X6qrbemxL8vIvQpO5YEtpU//i
         bI6Uj1MYQ2Em4WiDQMatLVHJhhcSXo42JOCwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=rzJiNLWHOCrBj8W0kDSSC6EolcogxAS7Qdfxbo53SxI=;
        b=djm/H7NswR9RXS37uhLo1se17O2rQyD2qWFDhmgOuHpIR3mfUwi6qHFtw/M/VZZsKm
         y3cI5S6L8TxVZ0lYFYrooV7UBDNWIOYBpj1yqD7XDBsSr/v9wzCRKVvtUanfWmkBvFlM
         vCJRUgtM++544c4vhbdaVK2nGYZvoKPKZwWna+y4mbcrKUuM1I8FFJcJKCUJMoAqNzsj
         2d5rp1SmcgNQTa61zfi9/iITegTMc7+HFB8+IaoEdlC+8LYBa16W+CF8bcoNIEBXiQHN
         KO0kspgv1U4Y4yQsEJVuFoDDccdGpaeQkkKhavZpfXzKDkpd1aWrObeOFJ+BJIC2Bt4/
         yEFw==
X-Gm-Message-State: ABuFfohH4mxU9lW0edFewgOLSvsoeMm8WkFhL7xYfEdO8wgUUF64Vd92
        bnNEMkxpaf28pJAZdscdwb1GEF2mo90r/px/Ncc2bQ==
X-Google-Smtp-Source: ANB0VdZlDKE99W+1t5i9VcOh2mPYcQPC88D05Vu/C7/yRwn41BqzSkqu67G3yRp6wWXvUyuDytRnGdKn8nBPaTr1/+w=
X-Received: by 2002:a6b:b242:: with SMTP id b63-v6mr7724854iof.172.1537432795213;
 Thu, 20 Sep 2018 01:39:55 -0700 (PDT)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <20180913031011.17376-1-dou_liyang@163.com> <alpine.DEB.2.21.1809131135540.1473@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1809131135540.1473@nanos.tec.linutronix.de>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQGvGgMD28WSn01TP3Q+HMY40wYaWwJRtWcwpSvYmlA=
Date:   Thu, 20 Sep 2018 14:09:53 +0530
Message-ID: <e725ccd00a98bb4b4541315017a16584@mail.gmail.com>
Subject: RE: [RFC PATCH] irq/affinity: Mark the pre/post vectors as regular interrupts
To:     Thomas Gleixner <tglx@linutronix.de>,
        Dou Liyang <dou_liyang@163.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>, ming.lei@redhat.com,
        Christoph Hellwig <hch@lst.de>, douly.fnst@cn.fujitsu.com,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This is the wrong direction as it does not allow to do initial affinity
> assignement for the non-managed interrupts on allocation time. And
that's
> what Kashyap and Sumit are looking for.
>
> The trivial fix for the possible breakage when irq_default_affinity !=
> cpu_possible_mask is to set the affinity for the pre/post vectors to
> cpu_possible_mask and be done with it.
>
> One other thing I noticed while staring at that is the fact, that the
PCI
> code does not care about the return value of irq_create_affinity_masks()
at
> all. It just proceeds if masks is NULL as if the stuff was requested
with
> the affinity descriptor pointer being NULL. I don't think that's a
> brilliant idea because the drivers might rely on the interrupt being
> managed, but it might be a non-issue and just result in bad locality.
>
> Christoph?
>
> So back to the problem at hand. We need to change the affinity
management
> scheme in a way which lets us differentiate between managed and
> unmanaged
> interrupts, so it allows to automatically assign (initial) affinity to
all
> of them.
>
> Right now everything is bound to the cpumasks array, which does not
allow
> to convey more information. So we need to come up with something
> different.
>
> Something like the below (does not compile and is just for reference)
> should do the trick. I'm not sure whether we want to convey the
information
> (masks and bitmap) in a single data structure or not, but that's an
> implementation detail.


Dou -  Do you want me to test your patch or shall I wait for next version
?

>
> Thanks,
>
> 	tglx
>
> 8<---------
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -535,15 +535,16 @@ static struct msi_desc *
>  msi_setup_entry(struct pci_dev *dev, int nvec, const struct
irq_affinity *affd)
>  {
>  	struct cpumask *masks = NULL;
> +	unsigned long managed = 0;
>  	struct msi_desc *entry;
>  	u16 control;
>
>  	if (affd)
> -		masks = irq_create_affinity_masks(nvec, affd);
> +		masks = irq_create_affinity_masks(nvec, affd, &managed);
>
>
>  	/* MSI Entry Initialization */
> -	entry = alloc_msi_entry(&dev->dev, nvec, masks);
> +	entry = alloc_msi_entry(&dev->dev, nvec, masks, managed);
>  	if (!entry)
>  		goto out;
>
> @@ -672,15 +673,22 @@ static int msix_setup_entries(struct pci
>  			      struct msix_entry *entries, int nvec,
>  			      const struct irq_affinity *affd)
>  {
> +	/*
> +	 * MSIX_MAX_VECTORS = 2048, i.e. 256 bytes. Might need runtime
> +	 * allocation. OTOH, are 2048 vectors realistic?
> +	 */
> +	DECLARE_BITMAP(managed, MSIX_MAX_VECTORS);
>  	struct cpumask *curmsk, *masks = NULL;
>  	struct msi_desc *entry;
>  	int ret, i;
>
>  	if (affd)
> -		masks = irq_create_affinity_masks(nvec, affd);
> +		masks = irq_create_affinity_masks(nvec, affd, managed);
>
>  	for (i = 0, curmsk = masks; i < nvec; i++) {
> -		entry = alloc_msi_entry(&dev->dev, 1, curmsk);
> +		unsigned long m = test_bit(i, managed) ? 1 : 0;
> +
> +		entry = alloc_msi_entry(&dev->dev, 1, curmsk, m);
>  		if (!entry) {
>  			if (!i)
>  				iounmap(base);
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -27,7 +27,8 @@
>   * and the affinity masks from @affinity are copied.
>   */
>  struct msi_desc *
> -alloc_msi_entry(struct device *dev, int nvec, const struct cpumask
*affinity)
> +alloc_msi_entry(struct device *dev, int nvec, const struct cpumask
*affinity,
> +		unsigned long managed)
>  {
>  	struct msi_desc *desc;
>
> @@ -38,6 +39,7 @@ alloc_msi_entry(struct device *dev, int
>  	INIT_LIST_HEAD(&desc->list);
>  	desc->dev = dev;
>  	desc->nvec_used = nvec;
> +	desc->managed = managed;
>  	if (affinity) {
>  		desc->affinity = kmemdup(affinity,
>  			nvec * sizeof(*desc->affinity), GFP_KERNEL);
> @@ -416,7 +418,7 @@ int msi_domain_alloc_irqs(struct irq_dom
>
>  		virq = __irq_domain_alloc_irqs(domain, -1,
desc->nvec_used,
>  					       dev_to_node(dev), &arg,
false,
> -					       desc->affinity);
> +					       desc->affinity,
desc->managed);
>  		if (virq < 0) {
>  			ret = -ENOSPC;
>  			if (ops->handle_error)
