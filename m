Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B81C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B66205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547740839;
	bh=WgXeZ90IT68Tu4DHnaGsOWO3227RVXMiaL59JvcDd1M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZekkFjcFjfZSm0mmbhasN7r112TX+NSsV40vMuWbVAkNadYZZ/QUkUsXMGWwWEyXv
	 h6lIuUesUSV8NrYXOR1e9mVgqoTt9+RnoVXzfdYnCJjl0pYb28UHtHJeJAePcjsn7w
	 5SbB0hkkcfhtxMPFOOXeG3jOKuKcK0cNQqRr7fEw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbfAQQAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:00:36 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:45018 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727632AbfAQQAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:00:36 -0500
Received: by mail-oi1-f173.google.com with SMTP id m6so6505965oig.11;
        Thu, 17 Jan 2019 08:00:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rdu7kyWzYlUBD6Mskt8hw39fAw2nqx6mvnISETdM2jg=;
        b=PFlU4GNvgZXSu27KkjWfyL+vW0RB4PydewIfgVe0fFehnieIRQ1xaOqH5fKNO/r9PP
         P2r3aMc0Vp5RkmRZ6RvRAKoXJbBRc/xIXrxVHbdmdJcRgAw9oAu8GRKh8l6IeK/RVIFX
         vopD5oo1b5fsWvKeEXobjctTZuGTdGZCYMalDWr72pQWih7srgfyFQ/CDwXUibmEE8rd
         UjfciaDv2dCml2oYXgSy7UArODMFGPqc/tnWnCZK0UmviA4s3oABF9QTL9/xK7UwYbqP
         DIg+qHkmeOiUmjD6/aYPinbrsIy3SaZBS3Xwt6/g217876JPjSGMd5oRO/PmrwPikmDR
         BSsA==
X-Gm-Message-State: AJcUukf3XRF+doBS0C25uLDINO4+y3NAbu47ltdMIprhcr2WITaGA8xM
        QPXni6TMuGCnh8yqvf/EY9zPMBYcewNPnBsIkIo=
X-Google-Smtp-Source: ALg8bN5rxl9TkrG3mdMdexpWwg9jwTp3PTSfBUUlka/v5e8S62QOftTBtAbd9WNCisJH459t4ro18K14jCgIKQGCk00=
X-Received: by 2002:aca:368a:: with SMTP id d132mr1877295oia.193.1547740834934;
 Thu, 17 Jan 2019 08:00:34 -0800 (PST)
MIME-Version: 1.0
References: <20190116175804.30196-1-keith.busch@intel.com> <20190116175804.30196-11-keith.busch@intel.com>
In-Reply-To: <20190116175804.30196-11-keith.busch@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Jan 2019 17:00:23 +0100
Message-ID: <CAJZ5v0ieQGgaL4jrCFxx-NydTwqP=oaPP4O0RnG-FCKMKF-1bQ@mail.gmail.com>
Subject: Re: [PATCHv4 10/13] node: Add memory caching attributes
To:     Keith Busch <keith.busch@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 6:59 PM Keith Busch <keith.busch@intel.com> wrote:
>
> System memory may have side caches to help improve access speed to
> frequently requested address ranges. While the system provided cache is
> transparent to the software accessing these memory ranges, applications
> can optimize their own access based on cache attributes.
>
> Provide a new API for the kernel to register these memory side caches
> under the memory node that provides it.
>
> The new sysfs representation is modeled from the existing cpu cacheinfo
> attributes, as seen from /sys/devices/system/cpu/cpuX/side_cache/.
> Unlike CPU cacheinfo, though, the node cache level is reported from
> the view of the memory. A higher number is nearer to the CPU, while
> lower levels are closer to the backing memory. Also unlike CPU cache,
> it is assumed the system will handle flushing any dirty cached memory
> to the last level on a power failure if the range is persistent memory.
>
> The attributes we export are the cache size, the line size, associativity,
> and write back policy.
>
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/base/node.c  | 142 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/node.h |  39 ++++++++++++++
>  2 files changed, 181 insertions(+)
>
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 1e909f61e8b1..7ff3ed566d7d 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -191,6 +191,146 @@ void node_set_perf_attrs(unsigned int nid, struct node_hmem_attrs *hmem_attrs,
>                 pr_info("failed to add performance attribute group to node %d\n",
>                         nid);
>  }
> +
> +struct node_cache_info {
> +       struct device dev;
> +       struct list_head node;
> +       struct node_cache_attrs cache_attrs;
> +};
> +#define to_cache_info(device) container_of(device, struct node_cache_info, dev)
> +
> +#define CACHE_ATTR(name, fmt)                                          \
> +static ssize_t name##_show(struct device *dev,                         \
> +                          struct device_attribute *attr,               \
> +                          char *buf)                                   \
> +{                                                                      \
> +       return sprintf(buf, fmt "\n", to_cache_info(dev)->cache_attrs.name);\
> +}                                                                      \
> +DEVICE_ATTR_RO(name);
> +
> +CACHE_ATTR(size, "%llu")
> +CACHE_ATTR(level, "%u")
> +CACHE_ATTR(line_size, "%u")
> +CACHE_ATTR(associativity, "%u")
> +CACHE_ATTR(write_policy, "%u")
> +
> +static struct attribute *cache_attrs[] = {
> +       &dev_attr_level.attr,
> +       &dev_attr_associativity.attr,
> +       &dev_attr_size.attr,
> +       &dev_attr_line_size.attr,
> +       &dev_attr_write_policy.attr,
> +       NULL,
> +};
> +ATTRIBUTE_GROUPS(cache);
> +
> +static void node_cache_release(struct device *dev)
> +{
> +       kfree(dev);
> +}
> +
> +static void node_cacheinfo_release(struct device *dev)
> +{
> +       struct node_cache_info *info = to_cache_info(dev);
> +       kfree(info);
> +}
> +
> +static void node_init_cache_dev(struct node *node)
> +{
> +       struct device *dev;
> +
> +       dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> +       if (!dev)
> +               return;
> +
> +       dev->parent = &node->dev;
> +       dev->release = node_cache_release;
> +       if (dev_set_name(dev, "side_cache"))
> +               goto free_dev;
> +
> +       if (device_register(dev))
> +               goto free_name;
> +
> +       pm_runtime_no_callbacks(dev);
> +       node->cache_dev = dev;
> +       return;

I would add an empty line here.

> +free_name:
> +       kfree_const(dev->kobj.name);
> +free_dev:
> +       kfree(dev);
> +}
> +
> +void node_add_cache(unsigned int nid, struct node_cache_attrs *cache_attrs)
> +{
> +       struct node_cache_info *info;
> +       struct device *dev;
> +       struct node *node;
> +
> +       if (!node_online(nid) || !node_devices[nid])
> +               return;
> +
> +       node = node_devices[nid];
> +       list_for_each_entry(info, &node->cache_attrs, node) {
> +               if (info->cache_attrs.level == cache_attrs->level) {
> +                       dev_warn(&node->dev,
> +                               "attempt to add duplicate cache level:%d\n",
> +                               cache_attrs->level);

I'd suggest using dev_dbg() for this and I'm not even sure if printing
the message is worth the effort.

Firmware will probably give you duplicates and users cannot do much
about fixing that anyway.

> +                       return;
> +               }
> +       }
> +
> +       if (!node->cache_dev)
> +               node_init_cache_dev(node);
> +       if (!node->cache_dev)
> +               return;
> +
> +       info = kzalloc(sizeof(*info), GFP_KERNEL);
> +       if (!info)
> +               return;
> +
> +       dev = &info->dev;
> +       dev->parent = node->cache_dev;
> +       dev->release = node_cacheinfo_release;
> +       dev->groups = cache_groups;
> +       if (dev_set_name(dev, "index%d", cache_attrs->level))
> +               goto free_cache;
> +
> +       info->cache_attrs = *cache_attrs;
> +       if (device_register(dev)) {
> +               dev_warn(&node->dev, "failed to add cache level:%d\n",
> +                        cache_attrs->level);
> +               goto free_name;
> +       }
> +       pm_runtime_no_callbacks(dev);
> +       list_add_tail(&info->node, &node->cache_attrs);
> +       return;

Again, I'd add an empty line here.

> +free_name:
> +       kfree_const(dev->kobj.name);
> +free_cache:
> +       kfree(info);
> +}
> +
> +static void node_remove_caches(struct node *node)
> +{
> +       struct node_cache_info *info, *next;
> +
> +       if (!node->cache_dev)
> +               return;
> +
> +       list_for_each_entry_safe(info, next, &node->cache_attrs, node) {
> +               list_del(&info->node);
> +               device_unregister(&info->dev);
> +       }
> +       device_unregister(node->cache_dev);
> +}
> +
> +static void node_init_caches(unsigned int nid)
> +{
> +       INIT_LIST_HEAD(&node_devices[nid]->cache_attrs);
> +}
> +#else
> +static void node_init_caches(unsigned int nid) { }
> +static void node_remove_caches(struct node *node) { }
>  #endif
>
>  #define K(x) ((x) << (PAGE_SHIFT - 10))
> @@ -475,6 +615,7 @@ void unregister_node(struct node *node)
>  {
>         hugetlb_unregister_node(node);          /* no-op, if memoryless node */
>         node_remove_classes(node);
> +       node_remove_caches(node);
>         device_unregister(&node->dev);
>  }
>
> @@ -755,6 +896,7 @@ int __register_one_node(int nid)
>         INIT_LIST_HEAD(&node_devices[nid]->class_list);
>         /* initialize work queue for memory hot plug */
>         init_node_hugetlb_work(nid);
> +       node_init_caches(nid);
>
>         return error;
>  }
> diff --git a/include/linux/node.h b/include/linux/node.h
> index e22940a593c2..8cdf2b2808e4 100644
> --- a/include/linux/node.h
> +++ b/include/linux/node.h
> @@ -37,12 +37,47 @@ struct node_hmem_attrs {
>  };
>  void node_set_perf_attrs(unsigned int nid, struct node_hmem_attrs *hmem_attrs,
>                          unsigned class);
> +
> +enum cache_associativity {
> +       NODE_CACHE_DIRECT_MAP,
> +       NODE_CACHE_INDEXED,
> +       NODE_CACHE_OTHER,
> +};
> +
> +enum cache_write_policy {
> +       NODE_CACHE_WRITE_BACK,
> +       NODE_CACHE_WRITE_THROUGH,
> +       NODE_CACHE_WRITE_OTHER,
> +};
> +
> +/**
> + * struct node_cache_attrs - system memory caching attributes
> + *
> + * @associativity:     The ways memory blocks may be placed in cache
> + * @write_policy:      Write back or write through policy
> + * @size:              Total size of cache in bytes
> + * @line_size:         Number of bytes fetched on a cache miss
> + * @level:             Represents the cache hierarchy level
> + */
> +struct node_cache_attrs {
> +       enum cache_associativity associativity;
> +       enum cache_write_policy write_policy;
> +       u64 size;
> +       u16 line_size;
> +       u8  level;
> +};
> +void node_add_cache(unsigned int nid, struct node_cache_attrs *cache_attrs);
>  #else
>  static inline void node_set_perf_attrs(unsigned int nid,
>                                        struct node_hmem_attrs *hmem_attrs,
>                                        unsigned class)
>  {
>  }
> +
> +static inline void node_add_cache(unsigned int nid,
> +                                 struct node_cache_attrs *cache_attrs)
> +{
> +}

And does this really build with CONFIG_HMEM_REPORTING unset?

>  #endif
>
>  struct node {
> @@ -51,6 +86,10 @@ struct node {
>  #if defined(CONFIG_MEMORY_HOTPLUG_SPARSE) && defined(CONFIG_HUGETLBFS)
>         struct work_struct      node_work;
>  #endif
> +#ifdef CONFIG_HMEM_REPORTING
> +       struct list_head cache_attrs;
> +       struct device *cache_dev;
> +#endif
>  };
>
>  struct memory_block;
> --
