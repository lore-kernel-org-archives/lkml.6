Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F11CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB1B320855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547805999;
	bh=fHu+FdRCrwGokvR9MpNcl67V/HZ5A95FpaDxHSDemFM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=TKDg/Qk57kCCXAkLlBkiRXqXgGzPAP1kqkwua9VCFHlNmdSzCwc5G3Tzwvo2anFTF
	 mtv+mr17w8SO4q/PNfkiH8vPPbJX12MjeCtnFFAJlbzUhj+iw7fXGmwF0EJj7P3+N9
	 KGGaXtGFjOVUJVvYO7nvV+DREHQcPmA9d5fHoFHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbfARKGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:06:37 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39313 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfARKGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 05:06:37 -0500
Received: by mail-oi1-f196.google.com with SMTP id i6so8551698oia.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 02:06:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qjSsv1H165uHCWRa88bMMW0DHBNTYFspTFebZSHgK4s=;
        b=Excv/ANm3lXKBIVbPdbPxmCeouFrQ8x21uHF4UJcVT68lH/iUtYQbkFOqZyXwCOIa+
         3+tnW4E3uRIzKL+LS/5pQ4McvEVVSBziuiQgqaCa3E8kVWij41MGuQpcxmR4uaSBupBt
         pXQwKZhgvdVdSGcRhYZ4jIJep2n3CbvxPG06eMH8r6fDdA9y+lWyMwHvv8H/xXsSv1Ww
         bE1pg8+diLrJIAhj+kD0IqQPRieATuVYM+A0TOrltinWPfSWToNlm98tPpnIdI1rvJNL
         MaMdpQHIDMeBmorT2nxqQXUBMy8UHJ0chiiUXUC4znvJfdY95nnxRyf4ZgVq4gQbl03s
         tcww==
X-Gm-Message-State: AJcUukcacbY60nP080ubG/26q9JNbqLnA+eSPY6pu4l/bRQ/2MxQEEMV
        wUpBCodGqwLtqiwXYnsxeH69XWU++5dSBgx48FO6zQ==
X-Google-Smtp-Source: ALg8bN5nw+tIST+Akju15kyeMq/0E3gOsJvAhmn5vjGMZt7pG51OEFhTAIdnBqTOM7QZdKmMpM+p6P1/H/YZNypu1t8=
X-Received: by 2002:aca:e715:: with SMTP id e21mr205026oih.76.1547805995871;
 Fri, 18 Jan 2019 02:06:35 -0800 (PST)
MIME-Version: 1.0
References: <20190117055719.6161-1-richardw.yang@linux.intel.com> <20190118023459.9972-1-richardw.yang@linux.intel.com>
In-Reply-To: <20190118023459.9972-1-richardw.yang@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 18 Jan 2019 11:06:23 +0100
Message-ID: <CAJZ5v0i2z33wxxZkxrECe7yjuxE9EkhWi4g-sZB7Vv8jmnw+gQ@mail.gmail.com>
Subject: Re: [PATCH v2] driver core: move device->knode_class to device_private
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 3:35 AM Wei Yang <richardw.yang@linux.intel.com> wrote:
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
>
> ---
> v2: add a helper to get dev from klist_class

Looks better now.

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/base/base.h    |  4 ++++
>  drivers/base/class.c   | 14 ++++++++++----
>  drivers/base/core.c    |  4 ++--
>  include/linux/device.h |  1 -
>  4 files changed, 16 insertions(+), 7 deletions(-)
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
> index 54def4e02f00..d8a6a5864c2e 100644
> --- a/drivers/base/class.c
> +++ b/drivers/base/class.c
> @@ -117,16 +117,22 @@ static void class_put(struct class *cls)
>                 kset_put(&cls->p->subsys);
>  }
>
> +static struct device *klist_class_to_dev(struct klist_node *n)
> +{
> +       struct device_private *p = to_device_private_class(n);
> +       return p->device;
> +}
> +
>  static void klist_class_dev_get(struct klist_node *n)
>  {
> -       struct device *dev = container_of(n, struct device, knode_class);
> +       struct device *dev = klist_class_to_dev(n);
>
>         get_device(dev);
>  }
>
>  static void klist_class_dev_put(struct klist_node *n)
>  {
> -       struct device *dev = container_of(n, struct device, knode_class);
> +       struct device *dev = klist_class_to_dev(n);
>
>         put_device(dev);
>  }
> @@ -277,7 +283,7 @@ void class_dev_iter_init(struct class_dev_iter *iter, struct class *class,
>         struct klist_node *start_knode = NULL;
>
>         if (start)
> -               start_knode = &start->knode_class;
> +               start_knode = &start->p->knode_class;
>         klist_iter_init_node(&class->p->klist_devices, &iter->ki, start_knode);
>         iter->type = type;
>  }
> @@ -304,7 +310,7 @@ struct device *class_dev_iter_next(struct class_dev_iter *iter)
>                 knode = klist_next(&iter->ki);
>                 if (!knode)
>                         return NULL;
> -               dev = container_of(knode, struct device, knode_class);
> +               dev = klist_class_to_dev(knode);
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
