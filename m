Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85A5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 990972054F
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547717911;
	bh=ktnFYXF3udP+BMt40IDLvLZABaekxj8J9R4Q5GUblHU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Xvr4t9winjQ8kDdbRk8vgtyJIrNa5wmSbcDyn82Gc+kBiH1tYdAFzP6vaCRndcEG9
	 Bv8nfQwicvLxXfhRn4iDHFaGbrcyMpvNpN314P8JxRmiGjLLOCTlfTWWUOB6/Jmlxd
	 D7tuT/OOdL9RzPQ5cK3SMW7SyBfwlLSTRgfwDwAw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbfAQJi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 04:38:29 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42923 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbfAQJi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 04:38:29 -0500
Received: by mail-oi1-f193.google.com with SMTP id w13so5627009oiw.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 01:38:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/gInlzjPeyIwUAFsDrzcBzQl9dmDt9Ymxm0GUypD2aw=;
        b=l/1XLURVfh07L/mOR37b7uMbORiZqOw3+B6+RXd7bH+BgEOoi2cAK3CZ78snO2UpRi
         u6ZQuoctDEj4QvDVxVC6W8A2PLlc9BrIDJBV4EDELD6M4OiBtn7fMaz/6RIAEfEu6llG
         yRDo+Ha/lTYJjUJ/7v2ltxkjGUHt/kPJ45GSfduCFiLkKAqouG1cLp8lKn4Cbh9/iZ6v
         HE9U79a99B9YWSq8ABotXyHq9QxP8kuAemN70twjM0Pb/9gRYxA8gqrxtaXMDcYGVMAK
         IzndGcWUkuQOzrm6VO4GJJj5mfQx5tYwi1muBT9YyJjHRPv/bcX1X91pBi05TZ1wsftm
         OD9Q==
X-Gm-Message-State: AJcUukd9dqj/w8SvrSm6/JsfWz6FfSy4aAwf+ivMIzCisKSR0FnRoBDf
        qHVFQ7EiN5N31XQ/nlZg3kV6jNtfnipaoF2LYj12Rip1
X-Google-Smtp-Source: ALg8bN5XQ34Fnb7fBvDywlVB+/Jh1nQLIc7uSddv4NVTw9u/aG+q52Cw/R5hOJfrLWNktmuIBAg7s8NYz88AAuzS6Bo=
X-Received: by 2002:aca:3d42:: with SMTP id k63mr7474546oia.95.1547717907411;
 Thu, 17 Jan 2019 01:38:27 -0800 (PST)
MIME-Version: 1.0
References: <20190117055719.6161-1-richardw.yang@linux.intel.com>
In-Reply-To: <20190117055719.6161-1-richardw.yang@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Jan 2019 10:38:13 +0100
Message-ID: <CAJZ5v0iskuHq=h6+_kFJ7QPQ3W3goQjPX1x5LdGe6xu312Q8Ag@mail.gmail.com>
Subject: Re: [PATCH] driver core: move device->knode_class to device_private
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 6:57 AM Wei Yang <richardw.yang@linux.intel.com> wrote:
>
> As the description of struct device_private says, it stores data which
> is private to driver core. And it already has similar fields like:
> knode_parent, knode_driver, knode_driver and knode_bus. This look it is
> more proper to put knode_class together with those fields to make it
> private to driver core.
>
> This patch move device->knode_class to device_private to make it comply
> with code convention.
>
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

As a rule, I'm not a big fan of changes like this, because the only
reason for doing it seems to be aesthetics and it may be problematic
for people doing various types of backports, live patching etc, but
this particular one makes sense to me.

> ---
>  drivers/base/base.h    |  4 ++++
>  drivers/base/class.c   | 12 ++++++++----
>  drivers/base/core.c    |  4 ++--
>  include/linux/device.h |  1 -
>  4 files changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index 7a419a7a6235..37329a668935 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -60,6 +60,7 @@ struct driver_private {
>   * @knode_parent - node in sibling list
>   * @knode_driver - node in driver list
>   * @knode_bus - node in bus list
> + * @knode_class - node in class list
>   * @deferred_probe - entry in deferred_probe_list which is used to retry the
>   *     binding of drivers which were unable to get all the resources needed by
>   *     the device; typically because it depends on another driver getting
> @@ -74,6 +75,7 @@ struct device_private {
>         struct klist_node knode_parent;
>         struct klist_node knode_driver;
>         struct klist_node knode_bus;
> +       struct klist_node knode_class;
>         struct list_head deferred_probe;
>         struct device *device;
>  };
> @@ -83,6 +85,8 @@ struct device_private {
>         container_of(obj, struct device_private, knode_driver)
>  #define to_device_private_bus(obj)     \
>         container_of(obj, struct device_private, knode_bus)
> +#define to_device_private_class(obj)   \
> +       container_of(obj, struct device_private, knode_class)
>
>  /* initialisation functions */
>  extern int devices_init(void);
> diff --git a/drivers/base/class.c b/drivers/base/class.c
> index 54def4e02f00..df7fde599407 100644
> --- a/drivers/base/class.c
> +++ b/drivers/base/class.c
> @@ -119,14 +119,16 @@ static void class_put(struct class *cls)
>
>  static void klist_class_dev_get(struct klist_node *n)
>  {
> -       struct device *dev = container_of(n, struct device, knode_class);
> +       struct device_private *p = to_device_private_class(n);
> +       struct device *dev = p->device;

the

p = to_device_private_class(n)
dev = p->device

pattern is repeated below for at least a couple of times.

Care to add a static helper for this to reduce the code duplication somewhat?

>
>         get_device(dev);
>  }
>
>  static void klist_class_dev_put(struct klist_node *n)
>  {
> -       struct device *dev = container_of(n, struct device, knode_class);
> +       struct device_private *p = to_device_private_class(n);
> +       struct device *dev = p->device;
>
>         put_device(dev);
>  }
> @@ -277,7 +279,7 @@ void class_dev_iter_init(struct class_dev_iter *iter, struct class *class,
>         struct klist_node *start_knode = NULL;
>
>         if (start)
> -               start_knode = &start->knode_class;
> +               start_knode = &start->p->knode_class;
>         klist_iter_init_node(&class->p->klist_devices, &iter->ki, start_knode);
>         iter->type = type;
>  }
> @@ -298,13 +300,15 @@ EXPORT_SYMBOL_GPL(class_dev_iter_init);
>  struct device *class_dev_iter_next(struct class_dev_iter *iter)
>  {
>         struct klist_node *knode;
> +       struct device_private *p;
>         struct device *dev;
>
>         while (1) {
>                 knode = klist_next(&iter->ki);
>                 if (!knode)
>                         return NULL;
> -               dev = container_of(knode, struct device, knode_class);
> +               p = to_device_private_class(knode);
> +               dev = p->device;
>                 if (!iter->type || iter->type == dev->type)
>                         return dev;
>         }
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 04bbcd779e11..a624d27d11c0 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1932,7 +1932,7 @@ int device_add(struct device *dev)
>         if (dev->class) {
>                 mutex_lock(&dev->class->p->mutex);
>                 /* tie the class to the device */
> -               klist_add_tail(&dev->knode_class,
> +               klist_add_tail(&dev->p->knode_class,
>                                &dev->class->p->klist_devices);
>
>                 /* notify any interfaces that the device is here */
> @@ -2069,7 +2069,7 @@ void device_del(struct device *dev)
>                         if (class_intf->remove_dev)
>                                 class_intf->remove_dev(dev, class_intf);
>                 /* remove the device from the class list */
> -               klist_del(&dev->knode_class);
> +               klist_del(&dev->p->knode_class);
>                 mutex_unlock(&dev->class->p->mutex);
>         }
>         device_remove_file(dev, &dev_attr_uevent);
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 1b25c7a43f4c..040e97669f94 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -1035,7 +1035,6 @@ struct device {
>         spinlock_t              devres_lock;
>         struct list_head        devres_head;
>
> -       struct klist_node       knode_class;
>         struct class            *class;
>         const struct attribute_group **groups;  /* optional groups */
>
> --
> 2.19.1
>
