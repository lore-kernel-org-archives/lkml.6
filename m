Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33BCC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63DDB214FE
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OG8jmaxH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63DDB214FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbeIZWRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:17:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39006 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbeIZWRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Q8nj6Cz6qYjqMbSyswMYR+TkejBFwd3zGhfhneJ7gKk=; b=OG8jmaxHJTAn33+MPYqCXltHZ
        BDEqhf1njkQ9uDI6VYHTud8lgM5Pf5xuhBQMHOLHHboKZZ+6EfqjwnvuQaorvyRvhlgrRViiApIbE
        0dk+NTqdot1HZvkQP38c0waInHYUnrS26FwiR3hMo7XF45u3SdckoBxhhFeML9/bHCN4bcT2C080d
        kIGR7x9ffoBiuVwgirV4nfgShs2VodXudbs3WAog9zmf9WKOQQf5hRbooJ99QAJtzeq64Lxj4hujx
        D+R4M8hdbPrdLb6uvngskzTNK8hEVgBDGe8GUTfzgfTj96l5vnHCJzUPIO9/vkoeEFcDP1b4OgvaI
        sJ6bwaHNQ==;
Received: from 177.43.23.201.dynamic.adsl.gvt.net.br ([177.43.23.201] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g5CHz-0005Aq-B2; Wed, 26 Sep 2018 16:04:07 +0000
Date:   Wed, 26 Sep 2018 13:03:40 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Justin Ernst <justin.ernst@hpe.com>, russ.anderson@hpe.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aristeu Rozanski Filho <arozansk@redhat.com>
Subject: Re: [PATCH] Raise maximum number of memory controllers
Message-ID: <20180926130340.6b22918b@coco.lan>
In-Reply-To: <20180926152752.GG5584@zn.tnic>
References: <20180925143449.284634-1-justin.ernst@hpe.com>
        <20180925152659.GE23986@zn.tnic>
        <20180925175023.GA16725@agluck-desk>
        <20180925180458.GG23986@zn.tnic>
        <20180926093510.GA5584@zn.tnic>
        <20180926152752.GG5584@zn.tnic>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 26 Sep 2018 17:27:52 +0200
Borislav Petkov <bp@alien8.de> escreveu:

> On Wed, Sep 26, 2018 at 11:35:11AM +0200, Borislav Petkov wrote:
> > * or Greg coming and saying, you're using bus_type all wrong and you
> > shouldn't and you should remove it completely! :-)  
> 
> Yap, and so he did! :-)
> 
> It looks like we can remove the whole per-MC bus thing, see below. 

I guess this is/was needed to create things like this:

	lrwxrwxrwx 1 root root 0 set 26 05:24 /sys/bus/edac/devices/mc -> ../../../devices/system/edac/mc

(I don't test this logic for a while).

> Patch
> seems to work here and grepping sysfs hierarchy before and after:
> 
> find /sys/ | grep -i edac > ...
> 
> doesn't show any differences.
> 
> Tony, I'd appreciate running this on one of your big boxes to check
> nothing is missing in sysfs...

There are a few EDAC drivers for old server chipsets that create
error report mechanisms for PCI bus controllers. I don't remember
the specifics anymore. I *suspect* those are the drivers that
do such usage:

	$ git grep -l edac_pci_add_device
	drivers/edac/amd8111_edac.c
	drivers/edac/amd8131_edac.c
	drivers/edac/edac_pci.c
	drivers/edac/edac_pci.h
	drivers/edac/mpc85xx_edac.c
	drivers/edac/mv64x60_edac.c
	drivers/edac/octeon_edac-pci.c

None of them use Intel chipsets.

Last time I tried to test it (more than 5 years ago), it was
hard to find such systems at the labs I had access on that time.

Anyway, as this is a more unusual usage of EDAC API, it could be
worth to double-check if this patch won't break it, maybe doing
some test on such machines before/after this patch in order to 
verify that this won't cause regressions there.

In thesis, it shouldn't affect, as the changes are happening at
edac_mc*.c, but I won't doubt that it might have a hidden dependency
somewhere.

> 
> Thx.
> 
> ---
>  drivers/edac/edac_mc.c       |  9 +--------
>  drivers/edac/edac_mc_sysfs.c | 30 ++----------------------------
>  include/linux/edac.h         |  6 ------
>  3 files changed, 3 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> index 7d3edd713932..13594ffadcb3 100644
> --- a/drivers/edac/edac_mc.c
> +++ b/drivers/edac/edac_mc.c
> @@ -55,8 +55,6 @@ static LIST_HEAD(mc_devices);
>   */
>  static const char *edac_mc_owner;
>  
> -static struct bus_type mc_bus[EDAC_MAX_MCS];
> -
>  int edac_get_report_status(void)
>  {
>  	return edac_report;
> @@ -716,11 +714,6 @@ int edac_mc_add_mc_with_groups(struct mem_ctl_info *mci,
>  	int ret = -EINVAL;
>  	edac_dbg(0, "\n");
>  
> -	if (mci->mc_idx >= EDAC_MAX_MCS) {
> -		pr_warn_once("Too many memory controllers: %d\n", mci->mc_idx);
> -		return -ENODEV;
> -	}
> -
>  #ifdef CONFIG_EDAC_DEBUG
>  	if (edac_debug_level >= 3)
>  		edac_mc_dump_mci(mci);
> @@ -760,7 +753,7 @@ int edac_mc_add_mc_with_groups(struct mem_ctl_info *mci,
>  	/* set load time so that error rate can be tracked */
>  	mci->start_time = jiffies;
>  
> -	mci->bus = &mc_bus[mci->mc_idx];
> +	mci->bus = edac_get_sysfs_subsys();
>  
>  	if (edac_create_sysfs_mci_device(mci, groups)) {
>  		edac_mc_printk(mci, KERN_WARNING,
> diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
> index 20374b8248f0..2ca2012f2857 100644
> --- a/drivers/edac/edac_mc_sysfs.c
> +++ b/drivers/edac/edac_mc_sysfs.c
> @@ -914,27 +914,8 @@ static const struct device_type mci_attr_type = {
>  int edac_create_sysfs_mci_device(struct mem_ctl_info *mci,
>  				 const struct attribute_group **groups)
>  {
> -	char *name;
>  	int i, err;
>  
> -	/*
> -	 * The memory controller needs its own bus, in order to avoid
> -	 * namespace conflicts at /sys/bus/edac.
> -	 */
> -	name = kasprintf(GFP_KERNEL, "mc%d", mci->mc_idx);
> -	if (!name)
> -		return -ENOMEM;
> -
> -	mci->bus->name = name;
> -
> -	edac_dbg(0, "creating bus %s\n", mci->bus->name);
> -
> -	err = bus_register(mci->bus);
> -	if (err < 0) {
> -		kfree(name);
> -		return err;
> -	}
> -
>  	/* get the /sys/devices/system/edac subsys reference */
>  	mci->dev.type = &mci_attr_type;
>  	device_initialize(&mci->dev);
> @@ -950,7 +931,7 @@ int edac_create_sysfs_mci_device(struct mem_ctl_info *mci,
>  	err = device_add(&mci->dev);
>  	if (err < 0) {
>  		edac_dbg(1, "failure: create device %s\n", dev_name(&mci->dev));
> -		goto fail_unregister_bus;
> +		goto out;
>  	}
>  
>  	/*
> @@ -998,10 +979,8 @@ int edac_create_sysfs_mci_device(struct mem_ctl_info *mci,
>  		device_unregister(&dimm->dev);
>  	}
>  	device_unregister(&mci->dev);
> -fail_unregister_bus:
> -	bus_unregister(mci->bus);
> -	kfree(name);
>  
> +out:
>  	return err;
>  }
>  
> @@ -1032,13 +1011,8 @@ void edac_remove_sysfs_mci_device(struct mem_ctl_info *mci)
>  
>  void edac_unregister_sysfs(struct mem_ctl_info *mci)
>  {
> -	struct bus_type *bus = mci->bus;
> -	const char *name = mci->bus->name;
> -
>  	edac_dbg(1, "Unregistering device %s\n", dev_name(&mci->dev));
>  	device_unregister(&mci->dev);
> -	bus_unregister(bus);
> -	kfree(name);
>  }
>  
>  static void mc_attr_release(struct device *dev)
> diff --git a/include/linux/edac.h b/include/linux/edac.h
> index a45ce1f84bfc..dd8d006f1837 100644
> --- a/include/linux/edac.h
> +++ b/include/linux/edac.h
> @@ -668,10 +668,4 @@ struct mem_ctl_info {
>  	bool fake_inject_ue;
>  	u16 fake_inject_count;
>  };
> -
> -/*
> - * Maximum number of memory controllers in the coherent fabric.
> - */
> -#define EDAC_MAX_MCS	16
> -
>  #endif



Thanks,
Mauro
