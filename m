Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFBEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB7920851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547737788;
	bh=1wwhNqpbIoelxAXUIdnvkR4vL8CxPrr+WqeT/Ep4+OY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kma8/HNe8oOph0qLcr4HdIJbj8KC8zRCBXCe95IYWosnBy+EjgAgnQdnPigzjIaoo
	 BzzuyoZUys+XcbErcbUJ+FUEVEw+fyWiPCwfIW7lJaf7TbNA36HsVFHBOLSIXuCpVb
	 6xhTP2Yjmt4UinXYeqxspsw6V+gD2+13ZAT9GF6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbfAQPJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 10:09:46 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:33616 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbfAQPJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 10:09:44 -0500
Received: by mail-oi1-f180.google.com with SMTP id c206so6422293oib.0;
        Thu, 17 Jan 2019 07:09:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MXqGV/xla3Lhq8q8Yrhbnz5xbjK0BhIgvFY3XkA7gnc=;
        b=XLV1jH2HvIaMyVnV70wgnDItn4mOE8d+N/V9zjQiaZ5Cnm6RfSkXPvrNYjn7wJQcnd
         W1poE9gMl7pIF7vPNk813mQQmHBfiIt4wEGUSQmGIzfEYl7szZi5iGU8ke8bLv5DfjXr
         AwsIJdVFME1cz2IGmsdnMex5hPvIPrcSpKUpvMumqYuLXFS3QtJ8Z1vf+HvNEMwxfqM9
         waTOG272dxGewNHXfVIpii1OeN9jvj66DBdSwEEwemlb1SKJVSfggQzQQO8mPhTUBMDX
         l+mtBxd7h9uR3shvXccIvgR6ibHB9v0wmXmoqv8TgOqWWfHUWiyS+wQkDAMAaP090f9S
         qliQ==
X-Gm-Message-State: AJcUukd3or7NZiNbhmt2gO5oIdRKvQ9MYEEVnKUQ2hrtG+fyk/Xryy9u
        a37qstQhiatIQ32IYLE1WzPeAQ/leegZzz5/74o=
X-Google-Smtp-Source: ALg8bN5iFWUYbgDOG/UTcz6q3HXMcrxIhKQkd494ya5hnftBkGkju87jPfTZfqvKeR58HAGoYm8AZcuaQtrdZXuxqho=
X-Received: by 2002:a54:4d01:: with SMTP id v1mr638235oix.246.1547737783643;
 Thu, 17 Jan 2019 07:09:43 -0800 (PST)
MIME-Version: 1.0
References: <20190116175804.30196-1-keith.busch@intel.com> <20190116175804.30196-9-keith.busch@intel.com>
In-Reply-To: <20190116175804.30196-9-keith.busch@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Jan 2019 16:09:32 +0100
Message-ID: <CAJZ5v0iV8qt3_1BP_4fPN77CC7yLXT4QMW=q+jWdts+e5rf8dg@mail.gmail.com>
Subject: Re: [PATCHv4 08/13] Documentation/ABI: Add node performance attributes
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
> Add descriptions for memory class initiator performance access attributes.

Again, I would combine this with the previous patch.

> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  Documentation/ABI/stable/sysfs-devices-node | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
> index a9c47b4b0eee..2217557f29d3 100644
> --- a/Documentation/ABI/stable/sysfs-devices-node
> +++ b/Documentation/ABI/stable/sysfs-devices-node
> @@ -114,3 +114,31 @@ Description:
>                 The node list of memory targets that this initiator node has
>                 class "Y" access. Memory accesses from this node to nodes not
>                 in this list may have differet performance.
> +
> +What:          /sys/devices/system/node/nodeX/classY/read_bandwidth
> +Date:          December 2018
> +Contact:       Keith Busch <keith.busch@intel.com>
> +Description:
> +               This node's read bandwidth in MB/s available to memory
> +               initiators in nodes found in this class's initiators_nodelist.
> +
> +What:          /sys/devices/system/node/nodeX/classY/read_latency
> +Date:          December 2018
> +Contact:       Keith Busch <keith.busch@intel.com>
> +Description:
> +               This node's read latency in nanoseconds available to memory
> +               initiators in nodes found in this class's initiators_nodelist.

I'm not sure if the term "read latency" is sufficient here.  Is this
the latency between sending a request and getting a response or
between sending the request and when the data actually becomes
available?

Moreover, is it the worst-case latency or the average latency?

> +
> +What:          /sys/devices/system/node/nodeX/classY/write_bandwidth
> +Date:          December 2018
> +Contact:       Keith Busch <keith.busch@intel.com>
> +Description:
> +               This node's write bandwidth in MB/s available to memory
> +               initiators in nodes found in this class's initiators_nodelist.
> +
> +What:          /sys/devices/system/node/nodeX/classY/write_latency
> +Date:          December 2018
> +Contact:       Keith Busch <keith.busch@intel.com>
> +Description:
> +               This node's write latency in nanoseconds available to memory
> +               initiators in nodes found in this class's initiators_nodelist.
> --

Same questions as for the read latency apply here.
