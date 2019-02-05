Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91812C282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61829217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549379843;
	bh=YD49vjK9ZLlA0B+wyxGeT8i527JGfY8h8L9hCTA8IlU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lLakUoz64X7drMZdKC0FF1JJiVs0Kc2cwkBh+W/aMBaP2wrszxSFmqKoeQnJStYMh
	 /E986thKWP6p9S8FKIcZe1sAx85Pg6ahNZCDv7zbZRQm6jNiW5XSsf4I173hjA9a6I
	 z4O1ZMeFsEdrwy8gB3RBRyNsfwu2NZpK6ZIV88Wk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbfBEPRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:17:21 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45897 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729174AbfBEPRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:17:21 -0500
Received: by mail-ot1-f67.google.com with SMTP id 32so6155949ota.12;
        Tue, 05 Feb 2019 07:17:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VFbGRb5xknWLloF/iUFH3qR3GQTul32AhZ77ruSeqok=;
        b=VdPu/NlFBN967LG1RO1jQiR+jO2aG6sQ/IidxiPnILRDhx7vRUum22m23FZjBLeF5Q
         74bSb+8eKBadWAmGim0+izoEc3ij8h0NEBJ41So/AwlqGMnYvNdvuaJynFa2BImsVMcO
         vJb75atbTjx27yWDCMqjip8m9NRc8TKMpCDMC4npa2K9TOUWy3DVR6O19VBx2xwZND6f
         M9WVFjDGYvJ7qX5t1nrBO/jo80IQYINnArEPXAqbsyZeuCZXNHFiThaVWmFStrlzdxRe
         aL6BvkWNg+jPsMa6jkPnoJQECUD1U1BPT3JiegGJYu+mDP7gK3/ul9MHw1Kb352KovjS
         3VvA==
X-Gm-Message-State: AHQUAuZqHQAK6pnPvrCUF2Wn1CvpS2dwFAWvE27pfhTRuezpmFKOR0ZN
        dXBH4uMyY7N5v8CRMhUD7xpX6vex/VqlpT/MAQY=
X-Google-Smtp-Source: AHgI3IbBRrmwxI7rinu6UFIu6OFS1uAu7sh4Uro2X/OU7M0jdyY20EdvJCHRbVh2D22zfsNV273Xh1WPVvxgxWx3nxg=
X-Received: by 2002:a9d:588c:: with SMTP id x12mr2964645otg.139.1549379840370;
 Tue, 05 Feb 2019 07:17:20 -0800 (PST)
MIME-Version: 1.0
References: <20190124230724.10022-1-keith.busch@intel.com> <20190124230724.10022-5-keith.busch@intel.com>
 <CAJZ5v0jE_gRT5WgpQYwZQmx6N5G+axymbSySb2Nk8Q0OGeNt9A@mail.gmail.com> <20190205145227.GG17950@kroah.com>
In-Reply-To: <20190205145227.GG17950@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Feb 2019 16:17:09 +0100
Message-ID: <CAJZ5v0g4ouD+9YYPSkoN7CRLTXYymeCaVkYNzm6Q6gGdNgJbuQ@mail.gmail.com>
Subject: Re: [PATCHv5 04/10] node: Link memory nodes to their compute nodes
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 5, 2019 at 3:52 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Feb 05, 2019 at 01:33:27PM +0100, Rafael J. Wysocki wrote:
> > > +/**
> > > + * struct node_access_nodes - Access class device to hold user visible
> > > + *                           relationships to other nodes.
> > > + * @dev:       Device for this memory access class
> > > + * @list_node: List element in the node's access list
> > > + * @access:    The access class rank
> > > + */
> > > +struct node_access_nodes {
> > > +       struct device           dev;
> >
> > I'm not sure if the entire struct device is needed here.
> >
> > It looks like what you need is the kobject part of it only and you can
> > use a kobject directly here:
> >
> > struct kobject        kobj;
> >
> > Then, you can register that under the node's kobject using
> > kobject_init_and_add() and you can create attr groups under a kobject
> > using sysfs_create_groups(), which is exactly what device_add_groups()
> > does.
> >
> > That would allow you to avoid allocating extra memory to hold the
> > entire device structure and the extra empty "power" subdirectory added
> > by device registration would not be there.
>
> When you use a "raw" kobject then userspace tools do not see the devices
> and attributes in libraries like udev.

And why would they need it in this particular case?

> So unless userspace does not care about this at all,

Which I think is the case here, isn't it?

> you should use a 'struct device' where ever
> possible.  The memory "savings" usually just isn't worth it unless you
> have a _lot_ of objects being created here.
>
> Who is going to use all of this new information?

Somebody who wants to know how the memory in the system is laid out AFAICS.
