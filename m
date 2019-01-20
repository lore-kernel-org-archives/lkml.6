Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F5EC26641
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 17:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A13B12133F
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 17:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="S6NDO72O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfATRe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 12:34:29 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43551 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfATRe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 12:34:29 -0500
Received: by mail-ot1-f65.google.com with SMTP id a11so18637869otr.10
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jan 2019 09:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pcnoj7pa45Wz3+JzXxb/xUbfSIWH8Dej4RIwdQGQb6s=;
        b=S6NDO72OPUN3A5+D1rHhmZHFU6Zuty3wP9LxltLb6mV6RrznCHle0tiDM6s3sRCXem
         oAhAyf5ahyJ2Wttzf0DHEqV5FXM9ifqaUL/i7L8JuZ2M12rTCOfxSocTbqxCwLKj0hqc
         FCcC74Yqk08fovkC3fvnjUqZC6HkrIlwX8/vISY0YQfZB4xWUVxPdZowxyMk8WViqyMw
         juCeHBWf4uoA9ynFq3oit0U3d4uXYTQp9HutylG1lHruSR0OXaPWoXZ5hnr+wUpP8ojX
         d3Fg3MapeVyTdnuOYfv73EaGg+8shJnNaLjLruYoULWZR2HnzNkN9g0rb0d6boa0nFrK
         +mVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pcnoj7pa45Wz3+JzXxb/xUbfSIWH8Dej4RIwdQGQb6s=;
        b=eiDkXedz2nqOrOaXkl+KXf/SlOLHdvn/80PgxKhgTPzrg9A538zjTp8piU2mdl8BMj
         1HPQ25rzDXidAFXSk7riPsrDMDbHbPME8UVacT6QjVQkCaZ2JvCfYhI/Qoert309LsGm
         ExtVPj/IclrX7gqfvTl/6PCXYzGE0YpwtI2BFjh+zfmBbyct+7B57jOJC0/KB7Asvuu5
         xHqyateY5h4vEhLj967qU8q+8GQUSaD8hk3QoVMdYPcSa7QS1uSpO5VvwoVPZ0/A5cI3
         A5s3bxSipeofQAE8fw0FUGIC+cKDEZdCsfgGq5ehp1HVAU+I87oIfI8LquGVOKl+HuAt
         sQBQ==
X-Gm-Message-State: AJcUukfMWNRkSfJp+rxrIAOzwSljhUy4Hr1fJtLfCV3DkBpElISK13uM
        IOk82KRkRQKxkz9F80MZWnLFVA0w0JlimxClQL0UMw==
X-Google-Smtp-Source: ALg8bN7lyoY4YbEf9/ZxGU7iIIWTy95kqXBvK018ZjMmjIrKH0YC9xaDWwQxalw8Ge35mFK1H1BMIqvAIYCUew5PaA0=
X-Received: by 2002:a9d:3a0a:: with SMTP id j10mr16883888otc.229.1548005667969;
 Sun, 20 Jan 2019 09:34:27 -0800 (PST)
MIME-Version: 1.0
References: <20190116175804.30196-1-keith.busch@intel.com> <20190116175804.30196-6-keith.busch@intel.com>
 <CAJZ5v0jmkyrNBHzqHsOuWjLXF34tq83VnEhdBWrdFqxyiXC=cw@mail.gmail.com>
 <CAPcyv4gH0_e_NFJNOFH4XXarSs7+TOj4nT0r-D33ZGNCfqBdxg@mail.gmail.com>
 <20190119090129.GC10836@kroah.com> <CAPcyv4jijnkW6E=0gpT3-qy5uOgTV-D7AN+CAu7mmdrRKGHvFg@mail.gmail.com>
 <CAJZ5v0hS8Mb-BZuzztTt9D0Rd0TPzMcod48Ev-8HCZg07BP6fw@mail.gmail.com>
In-Reply-To: <CAJZ5v0hS8Mb-BZuzztTt9D0Rd0TPzMcod48Ev-8HCZg07BP6fw@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 20 Jan 2019 09:34:15 -0800
Message-ID: <CAPcyv4jsOQZxdk4TENFwanqgmqEJhGegbzrkN6q8EEsTu=UNGA@mail.gmail.com>
Subject: Re: [PATCHv4 05/13] Documentation/ABI: Add new node sysfs attributes
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keith Busch <keith.busch@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 20, 2019 at 8:20 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Sat, Jan 19, 2019 at 5:56 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Sat, Jan 19, 2019 at 1:01 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Fri, Jan 18, 2019 at 01:08:02PM -0800, Dan Williams wrote:
> > > > On Thu, Jan 17, 2019 at 3:41 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > >
> > > > > On Wed, Jan 16, 2019 at 6:59 PM Keith Busch <keith.busch@intel.com> wrote:
> > > > > >
> > > > > > Add entries for memory initiator and target node class attributes.
> > > > > >
> > > > > > Signed-off-by: Keith Busch <keith.busch@intel.com>
> > > > >
> > > > > I would recommend combining this with the previous patch, as the way
> > > > > it is now I need to look at two patches at the time. :-)
> > > > >
> > > > > > ---
> > > > > >  Documentation/ABI/stable/sysfs-devices-node | 25 ++++++++++++++++++++++++-
> > > > > >  1 file changed, 24 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
> > > > > > index 3e90e1f3bf0a..a9c47b4b0eee 100644
> > > > > > --- a/Documentation/ABI/stable/sysfs-devices-node
> > > > > > +++ b/Documentation/ABI/stable/sysfs-devices-node
> > > > > > @@ -90,4 +90,27 @@ Date:                December 2009
> > > > > >  Contact:       Lee Schermerhorn <lee.schermerhorn@hp.com>
> > > > > >  Description:
> > > > > >                 The node's huge page size control/query attributes.
> > > > > > -               See Documentation/admin-guide/mm/hugetlbpage.rst
> > > > > > \ No newline at end of file
> > > > > > +               See Documentation/admin-guide/mm/hugetlbpage.rst
> > > > > > +
> > > > > > +What:          /sys/devices/system/node/nodeX/classY/
> > > > > > +Date:          December 2018
> > > > > > +Contact:       Keith Busch <keith.busch@intel.com>
> > > > > > +Description:
> > > > > > +               The node's relationship to other nodes for access class "Y".
> > > > > > +
> > > > > > +What:          /sys/devices/system/node/nodeX/classY/initiator_nodelist
> > > > > > +Date:          December 2018
> > > > > > +Contact:       Keith Busch <keith.busch@intel.com>
> > > > > > +Description:
> > > > > > +               The node list of memory initiators that have class "Y" access
> > > > > > +               to this node's memory. CPUs and other memory initiators in
> > > > > > +               nodes not in the list accessing this node's memory may have
> > > > > > +               different performance.
> > > > >
> > > > > This does not follow the general "one value per file" rule of sysfs (I
> > > > > know that there are other sysfs files with more than one value in
> > > > > them, but it is better to follow this rule as long as that makes
> > > > > sense).
> > > > >
> > > > > > +
> > > > > > +What:          /sys/devices/system/node/nodeX/classY/target_nodelist
> > > > > > +Date:          December 2018
> > > > > > +Contact:       Keith Busch <keith.busch@intel.com>
> > > > > > +Description:
> > > > > > +               The node list of memory targets that this initiator node has
> > > > > > +               class "Y" access. Memory accesses from this node to nodes not
> > > > > > +               in this list may have differet performance.
> > > > > > --
> > > > >
> > > > > Same here.
> > > > >
> > > > > And if you follow the recommendation given in the previous message
> > > > > (add "initiators" and "targets" subdirs under "classX"), you won't
> > > > > even need the two files above.
> > > >
> > > > This recommendation is in conflict with Greg's feedback about kobject
> > > > usage. If these are just "vanity" subdirs I think it's better to have
> > > > a multi-value sysfs file. This "list" style is already commonplace for
> > > > the /sys/devices/system hierarchy.
> > >
> > > If you do a subdirectory "correctly" (i.e. a name for an attribute
> > > group), that's fine.  Just do not ever create a kobject just for a
> > > subdir, that will mess up userspace.
> > >
> > > And I hate the "multi-value" sysfs files, where at all possible, please
> > > do not copy past bad mistakes there.  If you can make them individual
> > > files, please do that, it makes it easier to maintain and code the
> > > kernel for.
> >
> > I agree in general about multi-value sysfs, but in this case we're
> > talking about a mask. Masks are a single value. That said I can get on
> > board with calling what 'cpulist' does a design mistake (human
> > readable mask), but otherwise switching to one file per item in the
> > mask is a mess for userspace to consume.
>
> Can you please refer to my response to Keith?

Ah, ok I missed the patch4 comments and was reading this one in
isolation... which also bolsters your comment about squashing these
two patches together.

> If you have "initiators" and "targets" under "classX" and a list of
> symlinks in each of them, I don't see any kind of a mess here.

In this instance, I think having symlinks at all is "messy" vs just
having a mask. Yes, you're right, if we have the proposed symlinks
from patch4 there is no need for these _nodelist attributes, and those
symlinks would be better under "initiator" and "target" directories.
However, I'm arguing going the other way, just have the 2 mask
attributes and no symlinks. The HMAT erodes the concept of "numa
nodes" typically being a single digit number space per platform. Given
increasing numbers of memory target types and initiator devices its
going to be cumbersome to have userspace walk multiple symlinks vs
just reading a mask and opening the canonical path for a node
directly.

This is also part of the rationale for only emitting one "class"
(initiator / target performance profile) by default. There's an N-to-N
initiator-target description in the HMAT. When / if we decide emit
more classes the more work userspace would need to do to convert
directory structures back into data.
