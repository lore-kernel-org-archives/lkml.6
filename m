Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C592C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B9D520657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547725297;
	bh=gx53DduPk2JfBCo6Dxdzn96H4LgZ4kZdsMWUS21VjG0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2nrCLGRd+uJ7k/XyzPi6qr7pLR99PWcDi4PRWzT8dqcYyT/vBNldPQwGzYaXUeAxO
	 nhMFLFCBBS0zqkLi5Rqz5zYeYrJeYTwPfHGHTcdcLL1fFpSLFAJv8Wl+pkRoKxDy+h
	 qjquklkXH3lEdTNZXFAbNjhIQzmVHgEoO5aFOxns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbfAQLle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 06:41:34 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45598 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728989AbfAQLlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 06:41:31 -0500
Received: by mail-oi1-f195.google.com with SMTP id y1so5867778oie.12;
        Thu, 17 Jan 2019 03:41:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xN4v/rkGke6+i/Qav13HjBnLjQRjemEO+ltzcFe4AUo=;
        b=OSmAy/59dBI1bgyDBmrL49iAIfQ1EgS1FNlNmFd/5YUSjNE8TOguv+QJ8HOtJcpZHV
         XPKAMkLP4EJeUKJShVJZxgiqeQnYxjaNaOHwCwnKKJACTUUehp2an1Rj6ZtxsvkHTexD
         XvSd1cBuXXJdoaBraGvwmh9yyzInr3fcpvGSOKcIZ8QkuzOJiXZ+ort4fbqOeDokLN8r
         Kyn7+7BT4Tlr3ordMswayigm0YdEv3ECyv8rW3BYqfpf9nzgVLC6uG0ty30Ya02FA76x
         ISAkh1/V+9qKYLzkVZ2kvXJ4LRwB+CvxZgg/uxMzt+DCXIlSIAx4+ABGaDq543eVqda9
         Rq9A==
X-Gm-Message-State: AJcUukeu9S1UbiLsLmrei3Z7JKQmV/j6QdbN+555lnxXQ8OPJ+ySyjMq
        veTvsvhNG8ZZuhUwt8ry4p/YqWfMex724yggujc=
X-Google-Smtp-Source: ALg8bN4UQ/rpbV5cQBNhkg5p54E3HSCP5F7ElF7yDnIxmZsPlC6FJ4Q4g1QsWewezmj4aYuAijHbgKpTACnKXjBAfL4=
X-Received: by 2002:aca:b642:: with SMTP id g63mr5392264oif.195.1547725290609;
 Thu, 17 Jan 2019 03:41:30 -0800 (PST)
MIME-Version: 1.0
References: <20190116175804.30196-1-keith.busch@intel.com> <20190116175804.30196-6-keith.busch@intel.com>
In-Reply-To: <20190116175804.30196-6-keith.busch@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Jan 2019 12:41:19 +0100
Message-ID: <CAJZ5v0jmkyrNBHzqHsOuWjLXF34tq83VnEhdBWrdFqxyiXC=cw@mail.gmail.com>
Subject: Re: [PATCHv4 05/13] Documentation/ABI: Add new node sysfs attributes
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
> Add entries for memory initiator and target node class attributes.
>
> Signed-off-by: Keith Busch <keith.busch@intel.com>

I would recommend combining this with the previous patch, as the way
it is now I need to look at two patches at the time. :-)

> ---
>  Documentation/ABI/stable/sysfs-devices-node | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
> index 3e90e1f3bf0a..a9c47b4b0eee 100644
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
> +What:          /sys/devices/system/node/nodeX/classY/
> +Date:          December 2018
> +Contact:       Keith Busch <keith.busch@intel.com>
> +Description:
> +               The node's relationship to other nodes for access class "Y".
> +
> +What:          /sys/devices/system/node/nodeX/classY/initiator_nodelist
> +Date:          December 2018
> +Contact:       Keith Busch <keith.busch@intel.com>
> +Description:
> +               The node list of memory initiators that have class "Y" access
> +               to this node's memory. CPUs and other memory initiators in
> +               nodes not in the list accessing this node's memory may have
> +               different performance.

This does not follow the general "one value per file" rule of sysfs (I
know that there are other sysfs files with more than one value in
them, but it is better to follow this rule as long as that makes
sense).

> +
> +What:          /sys/devices/system/node/nodeX/classY/target_nodelist
> +Date:          December 2018
> +Contact:       Keith Busch <keith.busch@intel.com>
> +Description:
> +               The node list of memory targets that this initiator node has
> +               class "Y" access. Memory accesses from this node to nodes not
> +               in this list may have differet performance.
> --

Same here.

And if you follow the recommendation given in the previous message
(add "initiators" and "targets" subdirs under "classX"), you won't
even need the two files above.

And, of course, the symlinks part needs to be documented as well.  I
guess you can follow the
Documentation/ABI/testing/sysfs-devices-power_resources_D0 with that.
