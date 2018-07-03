Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0EFC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F076F21C66
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e/ZK9jIP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F076F21C66
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933929AbeGCRD7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:03:59 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39892 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753190AbeGCRDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:03:55 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w63GxPcC158541;
        Tue, 3 Jul 2018 17:03:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=4eCBX+Jn+Ff5msoe8oYyhcO22shH6ipt5j8oOa36NvY=;
 b=e/ZK9jIPez7h8hRRiOQclkcLUqxyFiyLJrjTXqX/u5Wye3kt+K7ftFIy23e9cQS0BmT3
 ihuzVUXi8vsjoE16H+fP203xSSojfamEPqeAWu+GTB/nd8ykfsj8mFe2p304seDYMg3N
 P8Mw7rhP90sRvEe9hS0/bY0lKODexwTNza6QqQ5FDHmSKcs0TWBBLuPEAOwjy3OlW7m8
 zkXYyAPvVxGgGPvczM/kPClAzli1ZoEqig4BKpK1xgxu6CIothYunmiiJScKb3yzLbSq
 NLJ0fMkNbgQhn2mGMV9OYQvmnKx8gPQB8LoxOosbivYYgi1Ld/TAmE2tsAExTLvgyHm/ Bw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2jx19ssg0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jul 2018 17:03:53 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w63H3qTu018133
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Jul 2018 17:03:52 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w63H3qVW019151;
        Tue, 3 Jul 2018 17:03:52 GMT
Received: from mail-oi0-f53.google.com (/209.85.218.53)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Jul 2018 10:03:52 -0700
Received: by mail-oi0-f53.google.com with SMTP id 13-v6so5267495ois.1;
        Tue, 03 Jul 2018 10:03:51 -0700 (PDT)
X-Gm-Message-State: APt69E2kwvSaZzQhwI3sSLgHSLdp9m3xvfY+025pY41XAJH+hCEzc4OR
        4hP1R6aaNr0qW4MWujJBOa0lOrldNlDChYv8Ado=
X-Google-Smtp-Source: AAOMgpcDhUgcSyn2VZRgZ9PsahvUaBzsru5GPlPTIXCAagsrLluJcjVMcexmAQ0XE9U6TLI147r/2V+oStPFva9G4Ew=
X-Received: by 2002:aca:e089:: with SMTP id x131-v6mr15589978oig.221.1530637431343;
 Tue, 03 Jul 2018 10:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
 <1530600642-25090-3-git-send-email-kernelfans@gmail.com> <CAHp75VfEVT7cMOQD71dBkwzuQhZQ8YGik+TWSnf9=pkiUxJO6A@mail.gmail.com>
In-Reply-To: <CAHp75VfEVT7cMOQD71dBkwzuQhZQ8YGik+TWSnf9=pkiUxJO6A@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Tue, 3 Jul 2018 13:03:15 -0400
X-Gmail-Original-Message-ID: <CAGM2reaSOKwuYbwKA9yxSHyCh3FCPpaZ-SUu8u+=DQBmDfKA2Q@mail.gmail.com>
Message-ID: <CAGM2reaSOKwuYbwKA9yxSHyCh3FCPpaZ-SUu8u+=DQBmDfKA2Q@mail.gmail.com>
Subject: Re: [PATCHv3 2/4] drivers/base: utilize device tree info to shutdown devices
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     kernelfans@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        gregkh@linuxfoundation.org, rafael.j.wysocki@intel.com,
        grygorii.strashko@ti.com, hch@infradead.org, helgaas@kernel.org,
        dyoung@redhat.com, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8943 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807030193
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Andy for the heads up. I might need to rebase my work
(http://lkml.kernel.org/r/20180629182541.6735-1-pasha.tatashin@oracle.com)
based on this change. But, it is possible it is going to be harder to
parallelize based on device tree. I will need to think about it.

Pavel

On Tue, Jul 3, 2018 at 6:59 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> I think Pavel would be interested to see this as well (he is doing
> some parallel device shutdown stuff)
>
> On Tue, Jul 3, 2018 at 9:50 AM, Pingfan Liu <kernelfans@gmail.com> wrote:
> > commit 52cdbdd49853 ("driver core: correct device's shutdown order")
> > places an assumption of supplier<-consumer order on the process of probe.
> > But it turns out to break down the parent <- child order in some scene.
> > E.g in pci, a bridge is enabled by pci core, and behind it, the devices
> > have been probed. Then comes the bridge's module, which enables extra
> > feature(such as hotplug) on this bridge. This will break the
> > parent<-children order and cause failure when "kexec -e" in some scenario.
> >
> > The detailed description of the scenario:
> > An IBM Power9 machine on which, two drivers portdrv_pci and shpchp(a mod)
> > match the PCI_CLASS_BRIDGE_PCI, but neither of them success to probe due
> > to some issue. For this case, the bridge is moved after its children in
> > devices_kset. Then, when "kexec -e", a ata-disk behind the bridge can not
> > write back buffer in flight due to the former shutdown of the bridge which
> > clears the BusMaster bit.
> >
> > It is a little hard to impose both "parent<-child" and "supplier<-consumer"
> > order on devices_kset. Take the following scene:
> > step0: before a consumer's probing, (note child_a is supplier of consumer_a)
> >   [ consumer-X, child_a, ...., child_z] [... consumer_a, ..., consumer_z, ...] supplier-X
> >                                          ^^^^^^^^^^ affected range ^^^^^^^^^^
> > step1: when probing, moving consumer-X after supplier-X
> >   [ child_a, ...., child_z] [.... consumer_a, ..., consumer_z, ...] supplier-X, consumer-X
> > step2: the children of consumer-X should be re-ordered to maintain the seq
> >   [... consumer_a, ..., consumer_z, ....] supplier-X  [consumer-X, child_a, ...., child_z]
> > step3: the consumer_a should be re-ordered to maintain the seq
> >   [... consumer_z, ...] supplier-X [ consumer-X, child_a, consumer_a ..., child_z]
> >
> > It requires two nested recursion to drain out all out-of-order item in
> > "affected range". To avoid such complicated code, this patch suggests
> > to utilize the info in device tree, instead of using the order of
> > devices_kset during shutdown. It iterates the device tree, and firstly
> > shutdown a device's children and consumers. After this patch, the buggy
> > commit is hollow and left to clean.
> >
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Cc: Bjorn Helgaas <helgaas@kernel.org>
> > Cc: Dave Young <dyoung@redhat.com>
> > Cc: linux-pci@vger.kernel.org
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > ---
> >  drivers/base/core.c    | 48 +++++++++++++++++++++++++++++++++++++++++++-----
> >  include/linux/device.h |  1 +
> >  2 files changed, 44 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index a48868f..684b994 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -1446,6 +1446,7 @@ void device_initialize(struct device *dev)
> >         INIT_LIST_HEAD(&dev->links.consumers);
> >         INIT_LIST_HEAD(&dev->links.suppliers);
> >         dev->links.status = DL_DEV_NO_DRIVER;
> > +       dev->shutdown = false;
> >  }
> >  EXPORT_SYMBOL_GPL(device_initialize);
> >
> > @@ -2811,7 +2812,6 @@ static void __device_shutdown(struct device *dev)
> >          * lock is to be held
> >          */
> >         parent = get_device(dev->parent);
> > -       get_device(dev);
> >         /*
> >          * Make sure the device is off the kset list, in the
> >          * event that dev->*->shutdown() doesn't remove it.
> > @@ -2842,23 +2842,60 @@ static void __device_shutdown(struct device *dev)
> >                         dev_info(dev, "shutdown\n");
> >                 dev->driver->shutdown(dev);
> >         }
> > -
> > +       dev->shutdown = true;
> >         device_unlock(dev);
> >         if (parent)
> >                 device_unlock(parent);
> >
> > -       put_device(dev);
> >         put_device(parent);
> >         spin_lock(&devices_kset->list_lock);
> >  }
> >
> > +/* shutdown dev's children and consumer firstly, then itself */
> > +static int device_for_each_child_shutdown(struct device *dev)
> > +{
> > +       struct klist_iter i;
> > +       struct device *child;
> > +       struct device_link *link;
> > +
> > +       /* already shutdown, then skip this sub tree */
> > +       if (dev->shutdown)
> > +               return 0;
> > +
> > +       if (!dev->p)
> > +               goto check_consumers;
> > +
> > +       /* there is breakage of lock in __device_shutdown(), and the redundant
> > +        * ref++ on srcu protected consumer is harmless since shutdown is not
> > +        * hot path.
> > +        */
> > +       get_device(dev);
> > +
> > +       klist_iter_init(&dev->p->klist_children, &i);
> > +       while ((child = next_device(&i)))
> > +               device_for_each_child_shutdown(child);
> > +       klist_iter_exit(&i);
> > +
> > +check_consumers:
> > +       list_for_each_entry_rcu(link, &dev->links.consumers, s_node) {
> > +               if (!link->consumer->shutdown)
> > +                       device_for_each_child_shutdown(link->consumer);
> > +       }
> > +
> > +       __device_shutdown(dev);
> > +       put_device(dev);
> > +       return 0;
> > +}
> > +
> >  /**
> >   * device_shutdown - call ->shutdown() on each device to shutdown.
> >   */
> >  void device_shutdown(void)
> >  {
> >         struct device *dev;
> > +       int idx;
> >
> > +       idx = device_links_read_lock();
> >         spin_lock(&devices_kset->list_lock);
> >         /*
> >          * Walk the devices list backward, shutting down each in turn.
> > @@ -2866,11 +2903,12 @@ void device_shutdown(void)
> >          * devices offline, even as the system is shutting down.
> >          */
> >         while (!list_empty(&devices_kset->list)) {
> > -               dev = list_entry(devices_kset->list.prev, struct device,
> > +               dev = list_entry(devices_kset->list.next, struct device,
> >                                 kobj.entry);
> > -               __device_shutdown(dev);
> > +               device_for_each_child_shutdown(dev);
> >         }
> >         spin_unlock(&devices_kset->list_lock);
> > +       device_links_read_unlock(idx);
> >  }
> >
> >  /*
> > diff --git a/include/linux/device.h b/include/linux/device.h
> > index 055a69d..8a0f784 100644
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -1003,6 +1003,7 @@ struct device {
> >         bool                    offline:1;
> >         bool                    of_node_reused:1;
> >         bool                    dma_32bit_limit:1;
> > +       bool                    shutdown:1; /* one direction: false->true */
> >  };
> >
> >  static inline struct device *kobj_to_dev(struct kobject *kobj)
> > --
> > 2.7.4
> >
>
>
>
> --
> With Best Regards,
> Andy Shevchenko
