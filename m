Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6869BC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC192075E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vLfTbwtD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AC192075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753082AbeGCK7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 06:59:03 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:37259 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752401AbeGCK7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 06:59:00 -0400
Received: by mail-vk0-f66.google.com with SMTP id h22-v6so829771vke.4;
        Tue, 03 Jul 2018 03:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CR188H0uSTcuLSd1bmpHfnqwKw/qjaMunPuExTNnzU8=;
        b=vLfTbwtDtAwKR3BSoTwQVLWwkcrje9mCv7xwrtvasfrDkSyFCtoohp3JeqYhlwkXic
         TFpflsCLo3lUX7J0kfReWbSJkAzeK5rzqX693AInlcR5Fho5uY7xYNpaoeHCv4fBL2wN
         ylF1sV1PfLJTWz/8dIh8G+octFMS+hYrq3vz2q4DUX+Pps35jEWKd8ZhBTHofrlna/qY
         T5th6cyqkeCMVJP5T9XslkJNcsXR+YWe7UPklvNoKmoAt8bf3HYEkv+BZTOAjiLGf7GB
         Pp8Nu+7h3rwokwWYU3nexLT3h4qYOqeUg4xOKoFWu5QC0zR23ILU1rnUV9HLl+76McF9
         xRMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CR188H0uSTcuLSd1bmpHfnqwKw/qjaMunPuExTNnzU8=;
        b=PMnxWeZpmocUU4jD4+uN5lANCF0plcvRHia2GKfQEy4IkSfqaXr5Ks7SNaY3VULfYl
         ATue7SDL686Ad66h5T4d9VbHZvKoMw/wx13E2+b933+AE378pupFI5RcrOUQaRhS6/bR
         upFg7w4PLyXDVk0CBIZlDore4yK23jzgcDMl+nPqnCkiJjA8hKn6XVH3GhqeJP3yjX84
         khoUYAalFtdCGij8PjjdFENnR2+Rqv4wKauyb1oJW9FBKo7quN0v9YT1wBZL9WsebKSO
         vXBmYp39QZGBYLeiUnTFf9pTfnR+OWU7tkZp9NfEknGSdOr6huoONVepet2xhQSOscAv
         qGgw==
X-Gm-Message-State: APt69E2kSPflbB7rWDi9Zj/hQMu7lzf8oYD6d4AG6D5JXa9tT6+y/5U/
        yz8r4Ue2prftETueu9UVF5khqthwuzdMbCo4FR0=
X-Google-Smtp-Source: AAOMgpfO/R1UuEkiihXY5KV1l61a3EadL2FGkWT75fgsfINFy5VNSGUO4VJUmNw0KdR+JOTW39Hkw5TdwnwuA+pT2yk=
X-Received: by 2002:a1f:6742:: with SMTP id m2-v6mr2576675vki.129.1530615538971;
 Tue, 03 Jul 2018 03:58:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 03:58:58 -0700 (PDT)
In-Reply-To: <1530600642-25090-3-git-send-email-kernelfans@gmail.com>
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com> <1530600642-25090-3-git-send-email-kernelfans@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 3 Jul 2018 13:58:58 +0300
Message-ID: <CAHp75VfEVT7cMOQD71dBkwzuQhZQ8YGik+TWSnf9=pkiUxJO6A@mail.gmail.com>
Subject: Re: [PATCHv3 2/4] drivers/base: utilize device tree info to shutdown devices
To:     Pingfan Liu <kernelfans@gmail.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
        "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT" 
        <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think Pavel would be interested to see this as well (he is doing
some parallel device shutdown stuff)

On Tue, Jul 3, 2018 at 9:50 AM, Pingfan Liu <kernelfans@gmail.com> wrote:
> commit 52cdbdd49853 ("driver core: correct device's shutdown order")
> places an assumption of supplier<-consumer order on the process of probe.
> But it turns out to break down the parent <- child order in some scene.
> E.g in pci, a bridge is enabled by pci core, and behind it, the devices
> have been probed. Then comes the bridge's module, which enables extra
> feature(such as hotplug) on this bridge. This will break the
> parent<-children order and cause failure when "kexec -e" in some scenario.
>
> The detailed description of the scenario:
> An IBM Power9 machine on which, two drivers portdrv_pci and shpchp(a mod)
> match the PCI_CLASS_BRIDGE_PCI, but neither of them success to probe due
> to some issue. For this case, the bridge is moved after its children in
> devices_kset. Then, when "kexec -e", a ata-disk behind the bridge can not
> write back buffer in flight due to the former shutdown of the bridge which
> clears the BusMaster bit.
>
> It is a little hard to impose both "parent<-child" and "supplier<-consumer"
> order on devices_kset. Take the following scene:
> step0: before a consumer's probing, (note child_a is supplier of consumer_a)
>   [ consumer-X, child_a, ...., child_z] [... consumer_a, ..., consumer_z, ...] supplier-X
>                                          ^^^^^^^^^^ affected range ^^^^^^^^^^
> step1: when probing, moving consumer-X after supplier-X
>   [ child_a, ...., child_z] [.... consumer_a, ..., consumer_z, ...] supplier-X, consumer-X
> step2: the children of consumer-X should be re-ordered to maintain the seq
>   [... consumer_a, ..., consumer_z, ....] supplier-X  [consumer-X, child_a, ...., child_z]
> step3: the consumer_a should be re-ordered to maintain the seq
>   [... consumer_z, ...] supplier-X [ consumer-X, child_a, consumer_a ..., child_z]
>
> It requires two nested recursion to drain out all out-of-order item in
> "affected range". To avoid such complicated code, this patch suggests
> to utilize the info in device tree, instead of using the order of
> devices_kset during shutdown. It iterates the device tree, and firstly
> shutdown a device's children and consumers. After this patch, the buggy
> commit is hollow and left to clean.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> ---
>  drivers/base/core.c    | 48 +++++++++++++++++++++++++++++++++++++++++++-----
>  include/linux/device.h |  1 +
>  2 files changed, 44 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index a48868f..684b994 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1446,6 +1446,7 @@ void device_initialize(struct device *dev)
>         INIT_LIST_HEAD(&dev->links.consumers);
>         INIT_LIST_HEAD(&dev->links.suppliers);
>         dev->links.status = DL_DEV_NO_DRIVER;
> +       dev->shutdown = false;
>  }
>  EXPORT_SYMBOL_GPL(device_initialize);
>
> @@ -2811,7 +2812,6 @@ static void __device_shutdown(struct device *dev)
>          * lock is to be held
>          */
>         parent = get_device(dev->parent);
> -       get_device(dev);
>         /*
>          * Make sure the device is off the kset list, in the
>          * event that dev->*->shutdown() doesn't remove it.
> @@ -2842,23 +2842,60 @@ static void __device_shutdown(struct device *dev)
>                         dev_info(dev, "shutdown\n");
>                 dev->driver->shutdown(dev);
>         }
> -
> +       dev->shutdown = true;
>         device_unlock(dev);
>         if (parent)
>                 device_unlock(parent);
>
> -       put_device(dev);
>         put_device(parent);
>         spin_lock(&devices_kset->list_lock);
>  }
>
> +/* shutdown dev's children and consumer firstly, then itself */
> +static int device_for_each_child_shutdown(struct device *dev)
> +{
> +       struct klist_iter i;
> +       struct device *child;
> +       struct device_link *link;
> +
> +       /* already shutdown, then skip this sub tree */
> +       if (dev->shutdown)
> +               return 0;
> +
> +       if (!dev->p)
> +               goto check_consumers;
> +
> +       /* there is breakage of lock in __device_shutdown(), and the redundant
> +        * ref++ on srcu protected consumer is harmless since shutdown is not
> +        * hot path.
> +        */
> +       get_device(dev);
> +
> +       klist_iter_init(&dev->p->klist_children, &i);
> +       while ((child = next_device(&i)))
> +               device_for_each_child_shutdown(child);
> +       klist_iter_exit(&i);
> +
> +check_consumers:
> +       list_for_each_entry_rcu(link, &dev->links.consumers, s_node) {
> +               if (!link->consumer->shutdown)
> +                       device_for_each_child_shutdown(link->consumer);
> +       }
> +
> +       __device_shutdown(dev);
> +       put_device(dev);
> +       return 0;
> +}
> +
>  /**
>   * device_shutdown - call ->shutdown() on each device to shutdown.
>   */
>  void device_shutdown(void)
>  {
>         struct device *dev;
> +       int idx;
>
> +       idx = device_links_read_lock();
>         spin_lock(&devices_kset->list_lock);
>         /*
>          * Walk the devices list backward, shutting down each in turn.
> @@ -2866,11 +2903,12 @@ void device_shutdown(void)
>          * devices offline, even as the system is shutting down.
>          */
>         while (!list_empty(&devices_kset->list)) {
> -               dev = list_entry(devices_kset->list.prev, struct device,
> +               dev = list_entry(devices_kset->list.next, struct device,
>                                 kobj.entry);
> -               __device_shutdown(dev);
> +               device_for_each_child_shutdown(dev);
>         }
>         spin_unlock(&devices_kset->list_lock);
> +       device_links_read_unlock(idx);
>  }
>
>  /*
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 055a69d..8a0f784 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -1003,6 +1003,7 @@ struct device {
>         bool                    offline:1;
>         bool                    of_node_reused:1;
>         bool                    dma_32bit_limit:1;
> +       bool                    shutdown:1; /* one direction: false->true */
>  };
>
>  static inline struct device *kobj_to_dev(struct kobject *kobj)
> --
> 2.7.4
>



-- 
With Best Regards,
Andy Shevchenko
