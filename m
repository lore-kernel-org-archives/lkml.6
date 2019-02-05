Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397C1C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD6E20844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549370023;
	bh=tzTulM0201ZfgiUjnsZO0UcI/s3V0bFtFBS2SpB4doI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UQK4emaEwEnu+X+zF8x8eZJaCR904jW8OwGR7VIS09++LW5G9525yg3SBHRlge692
	 uq8uzTS3k9aEIer8khQk0xlJqNSF0+7xwGKBxMeTMBrzfcfQYGUWIqhMxsYa+sETdE
	 8wKZSUYRDzs6aUOUa3mjU33R5rR3hhzAwXaKlxVs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbfBEMdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 07:33:40 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34070 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfBEMdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 07:33:40 -0500
Received: by mail-ot1-f65.google.com with SMTP id t5so5420821otk.1;
        Tue, 05 Feb 2019 04:33:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eVrCyOOX4Q8m/xrzM46I1JOcym+IuQeWWMfSDki7Qig=;
        b=LZ+07+xLaZPMYXBCD17cwpJLucOD8vc2Qe8+MewFOJfvibJQukMwaYA4ra9HYK+1hG
         vAX9YPGMTFFrsu6x4+tX/ePns3xokdH5x37/6yIA0vwyUFuHt9s31g2Iwh/F5mphStcq
         /gwQcrfr0VkaIgN0nGBIU7/2Z+vji3Hlxd4l2OqdHJSTdkiL59rMmUEjvPtKTPTbJ0g6
         kqO7uVpQ3JMU2kCjoLhnRgS8SbG5roEbBtwapJ1ZDChk33HsVPJalBA2Sfvs6KkXwE5I
         0nLUXHPa0+5E2QEHBslYrA7s+2MPf6zj3Iuch+J12MvmFEpiwRTt0gN2J+ufi1CdGwV3
         zbCA==
X-Gm-Message-State: AHQUAua/PuXZ42haymQgAbLpiMQLQueh2i2sdi0+HXh8IDDWOPhfylvD
        F0rj8zb750qg98ATGwTxBlBplz4vyV3ZdMOlinI=
X-Google-Smtp-Source: AHgI3IYCwcYKxGHdjA4ZbtdNSvSA3Rhy71UX5Xe+VSg/3jqY88xImlg7ycMF6LOpcL7FrZWbhKUYevjf/Ey6eW7qoGI=
X-Received: by 2002:a9d:63c1:: with SMTP id e1mr2334981otl.119.1549370019045;
 Tue, 05 Feb 2019 04:33:39 -0800 (PST)
MIME-Version: 1.0
References: <20190124230724.10022-1-keith.busch@intel.com> <20190124230724.10022-5-keith.busch@intel.com>
In-Reply-To: <20190124230724.10022-5-keith.busch@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Feb 2019 13:33:27 +0100
Message-ID: <CAJZ5v0jE_gRT5WgpQYwZQmx6N5G+axymbSySb2Nk8Q0OGeNt9A@mail.gmail.com>
Subject: Re: [PATCHv5 04/10] node: Link memory nodes to their compute nodes
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

On Fri, Jan 25, 2019 at 12:08 AM Keith Busch <keith.busch@intel.com> wrote:
>
> Systems may be constructed with various specialized nodes. Some nodes
> may provide memory, some provide compute devices that access and use
> that memory, and others may provide both. Nodes that provide memory are
> referred to as memory targets, and nodes that can initiate memory access
> are referred to as memory initiators.
>
> Memory targets will often have varying access characteristics from
> different initiators, and platforms may have ways to express those
> relationships. In preparation for these systems, provide interfaces for
> the kernel to export the memory relationship among different nodes memory
> targets and their initiators with symlinks to each other.
>
> If a system provides access locality for each initiator-target pair, nodes
> may be grouped into ranked access classes relative to other nodes. The
> new interface allows a subsystem to register relationships of varying
> classes if available and desired to be exported.
>
> A memory initiator may have multiple memory targets in the same access
> class. The target memory's initiators in a given class indicate the
> nodes access characteristics share the same performance relative to other
> linked initiator nodes. Each target within an initiator's access class,
> though, do not necessarily perform the same as each other.
>
> A memory target node may have multiple memory initiators. All linked
> initiators in a target's class have the same access characteristics to
> that target.
>
> The following example show the nodes' new sysfs hierarchy for a memory
> target node 'Y' with access class 0 from initiator node 'X':
>
>   # symlinks -v /sys/devices/system/node/nodeX/access0/
>   relative: /sys/devices/system/node/nodeX/access0/targets/nodeY -> ../../nodeY
>
>   # symlinks -v /sys/devices/system/node/nodeY/access0/
>   relative: /sys/devices/system/node/nodeY/access0/initiators/nodeX -> ../../nodeX
>
> The new attributes are added to the sysfs stable documentation.
>
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  Documentation/ABI/stable/sysfs-devices-node |  25 ++++-
>  drivers/base/node.c                         | 142 +++++++++++++++++++++++++++-
>  include/linux/node.h                        |   7 +-
>  3 files changed, 171 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
> index 3e90e1f3bf0a..fb843222a281 100644
> --- a/Documentation/ABI/stable/sysfs-devices-node
> +++ b/Documentation/ABI/stable/sysfs-devices-node
> @@ -90,4 +90,27 @@ Date:                December 2009
>  Contact:       Lee Schermerhorn <lee.schermerhorn@hp.com>
>  Description:
>                 The node's huge page size control/query attributes.
> -               See Documentation/admin-guide/mm/hugetlbpage.rst
> \ No newline at end of file
> +               See Documentation/admin-guide/mm/hugetlbpage.rst
> +
> +What:          /sys/devices/system/node/nodeX/accessY/
> +Date:          December 2018
> +Contact:       Keith Busch <keith.busch@intel.com>
> +Description:
> +               The node's relationship to other nodes for access class "Y".
> +
> +What:          /sys/devices/system/node/nodeX/accessY/initiators/
> +Date:          December 2018
> +Contact:       Keith Busch <keith.busch@intel.com>
> +Description:
> +               The directory containing symlinks to memory initiator
> +               nodes that have class "Y" access to this target node's
> +               memory. CPUs and other memory initiators in nodes not in
> +               the list accessing this node's memory may have different
> +               performance.
> +
> +What:          /sys/devices/system/node/nodeX/classY/targets/
> +Date:          December 2018
> +Contact:       Keith Busch <keith.busch@intel.com>
> +Description:
> +               The directory containing symlinks to memory targets that
> +               this initiator node has class "Y" access.
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 86d6cd92ce3d..6f4097680580 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -17,6 +17,7 @@
>  #include <linux/nodemask.h>
>  #include <linux/cpu.h>
>  #include <linux/device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/swap.h>
>  #include <linux/slab.h>
>
> @@ -59,6 +60,94 @@ static inline ssize_t node_read_cpulist(struct device *dev,
>  static DEVICE_ATTR(cpumap,  S_IRUGO, node_read_cpumask, NULL);
>  static DEVICE_ATTR(cpulist, S_IRUGO, node_read_cpulist, NULL);
>
> +/**
> + * struct node_access_nodes - Access class device to hold user visible
> + *                           relationships to other nodes.
> + * @dev:       Device for this memory access class
> + * @list_node: List element in the node's access list
> + * @access:    The access class rank
> + */
> +struct node_access_nodes {
> +       struct device           dev;

I'm not sure if the entire struct device is needed here.

It looks like what you need is the kobject part of it only and you can
use a kobject directly here:

struct kobject        kobj;

Then, you can register that under the node's kobject using
kobject_init_and_add() and you can create attr groups under a kobject
using sysfs_create_groups(), which is exactly what device_add_groups()
does.

That would allow you to avoid allocating extra memory to hold the
entire device structure and the extra empty "power" subdirectory added
by device registration would not be there.

> +       struct list_head        list_node;
> +       unsigned                access;
> +};

Apart from the above, the patch looks good to me.
