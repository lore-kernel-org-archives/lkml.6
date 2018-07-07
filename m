Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D89BC6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 04:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5A552244A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 04:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwY7/0dP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5A552244A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750807AbeGGECn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 00:02:43 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:33379 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750715AbeGGECl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 00:02:41 -0400
Received: by mail-it0-f68.google.com with SMTP id y124-v6so6851955itc.0;
        Fri, 06 Jul 2018 21:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=75D92zqczJNEd5N4nCG8kDG/STC5Z50twaeQzjSvQEs=;
        b=ZwY7/0dPVgELanq3oEcHMaz2M1/2GOHLdJbwgoTPZjvx76lCg0jwABcwOixRfQBJbS
         jGSq/Rvk368S8pK/WQDqkDOsBgofHCOinxxbtXW26/lSKFyOdyXmUtJg0BXgT0hQLfiC
         +UNakdyYRHsszSZgEkzQLGduv0HVTj8dtLyojnyhDv4x6X6aSklJ7PxnEpf3HfNbNmwz
         uWZ5MJgxOqq8JfydVoDnSy7CP2JE+9GVKQkThyC1O9nB8SUSJi/bI5+DIfEuUT3b5Nqj
         S6VU8Tntl+zmgsViHcVHF/eW1EM2mnIdGoZqDyWDdrd75CZ5Eb0+EFubA+km6JrOuchl
         1dnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=75D92zqczJNEd5N4nCG8kDG/STC5Z50twaeQzjSvQEs=;
        b=K5rvNUNH6ENODia/CC0q5EpLMoq8W65/k2OB4CImvFdu4wcKO/8CIaIP86myuZgrID
         B9O2fAObG9EzH+GEZTboIEYk89B00RtAUfqcSPdnKT90EjyiHfgAAqOOQzsN5iu4XAGn
         yxUi+mrJ1QKzK052SKvooLrkFyA/vaLgbMnxL8aM1zxYNSQ6Ae+G9TugXnxMFyf5B8gT
         D1HVmqsi9kmgbktZg00PgvnH2WEsU0WfAB9+GynXODVLJv7LHUEL1L2lSXsjAzrNTDIL
         zsYRjS9vP17UlR+aEzLFbLdOQygc5SMYhdzOMqeyvOL1/tUEtiHDfI+tdEim5M+8BoC1
         DrBg==
X-Gm-Message-State: APt69E0BlIEeCqh9t8FpT0D2Ad2+/ZjBWFyB2zsSfmgjDOfH8XKKOZlk
        W7rYVFKRNimfVEDojkkSt0vZEJC7bitz1+8Di9zGqRg=
X-Google-Smtp-Source: AAOMgpeoP4dg/zVL8X1jMHFycyue1WxxST+FZgg/eGqls+jZVJe9W0jkqXns6m/5uJ55LA9lRBGMWZ05nmTunUMYKVc=
X-Received: by 2002:a24:1fce:: with SMTP id d197-v6mr9538603itd.52.1530936160704;
 Fri, 06 Jul 2018 21:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
 <2108146.dv4EAOf6IP@aspire.rjw.lan> <CAFgQCTsGC8NH+5kXYD7vykJeUsaAzCAjgxSP-R0EqA3YvgsY0w@mail.gmail.com>
 <2067910.hkxRV6zLYm@aspire.rjw.lan>
In-Reply-To: <2067910.hkxRV6zLYm@aspire.rjw.lan>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Sat, 7 Jul 2018 12:02:28 +0800
Message-ID: <CAFgQCTtJ29OZqnRnDyPF3PZTN71j8zbyGwwsGdQZRruU4W7E4w@mail.gmail.com>
Subject: Re: [PATCHv3 2/4] drivers/base: utilize device tree info to shutdown devices
To:     rjw@rjwysocki.net
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 5:54 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Friday, July 6, 2018 5:02:15 AM CEST Pingfan Liu wrote:
> > On Thu, Jul 5, 2018 at 6:13 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > On Tuesday, July 3, 2018 8:50:40 AM CEST Pingfan Liu wrote:
> > > > commit 52cdbdd49853 ("driver core: correct device's shutdown order")
> > > > places an assumption of supplier<-consumer order on the process of probe.
> > > > But it turns out to break down the parent <- child order in some scene.
> > > > E.g in pci, a bridge is enabled by pci core, and behind it, the devices
> > > > have been probed. Then comes the bridge's module, which enables extra
> > > > feature(such as hotplug) on this bridge. This will break the
> > > > parent<-children order and cause failure when "kexec -e" in some scenario.
> > > >
> > > > The detailed description of the scenario:
> > > > An IBM Power9 machine on which, two drivers portdrv_pci and shpchp(a mod)
> > > > match the PCI_CLASS_BRIDGE_PCI, but neither of them success to probe due
> > > > to some issue. For this case, the bridge is moved after its children in
> > > > devices_kset. Then, when "kexec -e", a ata-disk behind the bridge can not
> > > > write back buffer in flight due to the former shutdown of the bridge which
> > > > clears the BusMaster bit.
> > > >
> > > > It is a little hard to impose both "parent<-child" and "supplier<-consumer"
> > > > order on devices_kset. Take the following scene:
> > > > step0: before a consumer's probing, (note child_a is supplier of consumer_a)
> > > >   [ consumer-X, child_a, ...., child_z] [... consumer_a, ..., consumer_z, ...] supplier-X
> > > >                                          ^^^^^^^^^^ affected range ^^^^^^^^^^
> > > > step1: when probing, moving consumer-X after supplier-X
> > > >   [ child_a, ...., child_z] [.... consumer_a, ..., consumer_z, ...] supplier-X, consumer-X
> > > > step2: the children of consumer-X should be re-ordered to maintain the seq
> > > >   [... consumer_a, ..., consumer_z, ....] supplier-X  [consumer-X, child_a, ...., child_z]
> > > > step3: the consumer_a should be re-ordered to maintain the seq
> > > >   [... consumer_z, ...] supplier-X [ consumer-X, child_a, consumer_a ..., child_z]
> > > >
> > > > It requires two nested recursion to drain out all out-of-order item in
> > > > "affected range". To avoid such complicated code, this patch suggests
> > > > to utilize the info in device tree, instead of using the order of
> > > > devices_kset during shutdown. It iterates the device tree, and firstly
> > > > shutdown a device's children and consumers. After this patch, the buggy
> > > > commit is hollow and left to clean.
> > > >
> > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> > > > Cc: Christoph Hellwig <hch@infradead.org>
> > > > Cc: Bjorn Helgaas <helgaas@kernel.org>
> > > > Cc: Dave Young <dyoung@redhat.com>
> > > > Cc: linux-pci@vger.kernel.org
> > > > Cc: linuxppc-dev@lists.ozlabs.org
> > > > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > > > ---
> > > >  drivers/base/core.c    | 48 +++++++++++++++++++++++++++++++++++++++++++-----
> > > >  include/linux/device.h |  1 +
> > > >  2 files changed, 44 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > > index a48868f..684b994 100644
> > > > --- a/drivers/base/core.c
> > > > +++ b/drivers/base/core.c
> > > > @@ -1446,6 +1446,7 @@ void device_initialize(struct device *dev)
> > > >       INIT_LIST_HEAD(&dev->links.consumers);
> > > >       INIT_LIST_HEAD(&dev->links.suppliers);
> > > >       dev->links.status = DL_DEV_NO_DRIVER;
> > > > +     dev->shutdown = false;
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(device_initialize);
> > > >
> > > > @@ -2811,7 +2812,6 @@ static void __device_shutdown(struct device *dev)
> > > >        * lock is to be held
> > > >        */
> > > >       parent = get_device(dev->parent);
> > > > -     get_device(dev);
> > >
> > > Why is the get_/put_device() not needed any more?
> > >
> > They are moved upper layer into device_for_each_child_shutdown().
> > Since there is lock breakage in __device_shutdown(), resorting to
> > ref++ to protect the ancestor.  And I think the
> > get_device(dev->parent) can be deleted either.
>
> Wouldn't that break USB?
>
Sorry, I can not figure out. Is USB not modeled up-to-down? This
recursion can handle the up-to-down ref issue automatically, due to
the nature of device tree. Any hints? Thanks.

> > > >       /*
> > > >        * Make sure the device is off the kset list, in the
> > > >        * event that dev->*->shutdown() doesn't remove it.
> > > > @@ -2842,23 +2842,60 @@ static void __device_shutdown(struct device *dev)
> > > >                       dev_info(dev, "shutdown\n");
> > > >               dev->driver->shutdown(dev);
> > > >       }
> > > > -
> > > > +     dev->shutdown = true;
> > > >       device_unlock(dev);
> > > >       if (parent)
> > > >               device_unlock(parent);
> > > >
> > > > -     put_device(dev);
> > > >       put_device(parent);
> > > >       spin_lock(&devices_kset->list_lock);
> > > >  }
> > > >
> > > > +/* shutdown dev's children and consumer firstly, then itself */
> > > > +static int device_for_each_child_shutdown(struct device *dev)
> > >
> > > Confusing name.
> > >
> > > What about device_shutdown_subordinate()?
> > >
> > Fine. My understanding of words is not exact.
> >
> > > > +{
> > > > +     struct klist_iter i;
> > > > +     struct device *child;
> > > > +     struct device_link *link;
> > > > +
> > > > +     /* already shutdown, then skip this sub tree */
> > > > +     if (dev->shutdown)
> > > > +             return 0;
> > > > +
> > > > +     if (!dev->p)
> > > > +             goto check_consumers;
> > > > +
> > > > +     /* there is breakage of lock in __device_shutdown(), and the redundant
> > > > +      * ref++ on srcu protected consumer is harmless since shutdown is not
> > > > +      * hot path.
> > > > +      */
> > > > +     get_device(dev);
> > > > +
> > > > +     klist_iter_init(&dev->p->klist_children, &i);
> > > > +     while ((child = next_device(&i)))
> > > > +             device_for_each_child_shutdown(child);
> > >
> > > Why don't you use device_for_each_child() here?
> > >
> > OK, I will try use it.
>
> Well, hold on.
>
> > > > +     klist_iter_exit(&i);
> > > > +
> > > > +check_consumers:
> > > > +     list_for_each_entry_rcu(link, &dev->links.consumers, s_node) {
> > > > +             if (!link->consumer->shutdown)
> > > > +                     device_for_each_child_shutdown(link->consumer);
> > > > +     }
> > > > +
> > > > +     __device_shutdown(dev);
> > > > +     put_device(dev);
> > >
> > > Possible reference counter imbalance AFAICS.
> > >
> > Yes, get_device() should be ahead of "if (!dev->p)". Is anything  else I miss?
>
> Yes, that's it.
>
> > > > +     return 0;
> > > > +}
> > >
> > > Well, instead of doing this dance, we might as well walk dpm_list here as it
> > > is in the right order.
> > >
> > Sorry, do you mean that using the same way to manage the dpm_list?
>
> No, I mean to use dpm_list instead of devices_kset for shutdown.
>
> They should be in the same order anyway if all is correct.
>
Yes, the dpm_list and devices_kset contains the same info. But can we
make the shutdown as the first step, it is more simple and easy to
verify on different ARCH. Then hunting for the solution of pm.

> > > Of course, that would require dpm_list to be available for CONFIG_PM unset,
> > > but it may be a better approach long term.
> > >
> > > > +
> > > >  /**
> > > >   * device_shutdown - call ->shutdown() on each device to shutdown.
> > > >   */
> > > >  void device_shutdown(void)
> > > >  {
> > > >       struct device *dev;
> > > > +     int idx;
> > > >
> > > > +     idx = device_links_read_lock();
> > > >       spin_lock(&devices_kset->list_lock);
> > > >       /*
> > > >        * Walk the devices list backward, shutting down each in turn.
> > > > @@ -2866,11 +2903,12 @@ void device_shutdown(void)
> > > >        * devices offline, even as the system is shutting down.
> > > >        */
> > > >       while (!list_empty(&devices_kset->list)) {
> > > > -             dev = list_entry(devices_kset->list.prev, struct device,
> > > > +             dev = list_entry(devices_kset->list.next, struct device,
> > > >                               kobj.entry);
> > > > -             __device_shutdown(dev);
> > > > +             device_for_each_child_shutdown(dev);
> > > >       }
> > > >       spin_unlock(&devices_kset->list_lock);
> > > > +     device_links_read_unlock(idx);
> > > >  }
> > > >
> > > >  /*
> > > > diff --git a/include/linux/device.h b/include/linux/device.h
> > > > index 055a69d..8a0f784 100644
> > > > --- a/include/linux/device.h
> > > > +++ b/include/linux/device.h
> > > > @@ -1003,6 +1003,7 @@ struct device {
> > > >       bool                    offline:1;
> > > >       bool                    of_node_reused:1;
> > > >       bool                    dma_32bit_limit:1;
> > > > +     bool                    shutdown:1; /* one direction: false->true */
> > > >  };
> > > >
> > > >  static inline struct device *kobj_to_dev(struct kobject *kobj)
> > > >
> > >
> > > If the device_kset_move_last() in really_probe() is the only problem,
> > > I'd rather try to fix that one in the first place.
> > >
> > > Why is it needed?
> > >
> > I had tried, but it turns out not easy to archive. The code is
> > https://patchwork.kernel.org/patch/10485195/. And I make a detailed
> > description of the algorithm in this patch's commit log. To be more
> > detailed, we face the potential out of order issue in really_probe()
> > like : 0th. [ consumer-X, child_a, ...., child_z] [... consumer_a,
> > ..., consumer_z, ...] supplier-X //(note child_a is supplier of
> > consumer_a).  To address all the potential out of order item in the
> > affected section [... consumer_a, ..., consumer_z, ...],  it will
> > incur two nested recursions.  1st, moving  consumer-X and its
> > descendants after supplier-X,  2nd, moving consumer_a after child_a,
> > 3rd. the 2nd step may pose the same situation of 0th.  Besides the two
> > interleaved recursion,  the breakage of spin lock requires more effort
> > to protect the item from disappearing in linked-list  (which I did not
> > implement in the https://patchwork.kernel.org/patch/10485195/). Hence
> > I turn to this cheap method.
>
> So I think that we simply need to drop the devices_kset_move_last() call
> from really_probe() as it is plain incorrect and the use case for it is
> questionable at best.
>
See the reply on different mail, I think there is other issue with the
current solution besides really_probe->devices_kset_move_last

Thanks,
Pingfan
