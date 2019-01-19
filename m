Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4938C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 16:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD7E2086D
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 16:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="VMAuENoz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbfASQ4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 11:56:16 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35806 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728537AbfASQ4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 11:56:15 -0500
Received: by mail-ot1-f66.google.com with SMTP id 81so17221067otj.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 08:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nSqLnpETBLGsJ2UvGu+7zWAcLpmYNR5gRP5L1Qg9cEA=;
        b=VMAuENozNQB0jiQ3Z8uHfWBcQ2wRKuBQcOhGjMNT6J7bMCdaJOJbDTwCqPDOoVrPuG
         rtoPNOFXQQDwIxXWK+kJsMBc7UFMNkLYYvkAzs+Ylw2eK8g09q/cJn2NCvj6SEv1wY3P
         Gzwd4Zc0uaE+5IzfOJ/eDF39S4kSN3dwdlguJJkpSBhHfB30PYvoSYvEqHXMB67Kg/xc
         wdiAfOhP4bwo1U+I30o0q8I3KZf8o6LNWSrJUB4rEEGCjTI+a4xdn24oPeZ9Ly6k2Mu7
         JnKCTfTUkLiVjfXupXdu6Fh2qbk7QsrycL1C4un+Q9W78xIpt5rD00j/Somgi5HtvTqh
         rNwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nSqLnpETBLGsJ2UvGu+7zWAcLpmYNR5gRP5L1Qg9cEA=;
        b=rCM2eJh96MbxaH+oFPaZoECo3Ik619dJzEKQYYLqVUynIHDJR9gpYC9tIadtPFH/hj
         IBJ4CsrtHY301xbkvCWNcogOop4IS+g3CC4+YiklgdtkzVwc3VeVzeBfOCdTCYPdVjw2
         UqdC9v/IiN3O4IQ6kcoErJCcTmwHsCf8OVRBR7rbpKWUkhDyKwYvPobsH4HCj1VaR+da
         jAlxnhXWr9f4llXriGEndEwg91motIfZIOFlBftscKavqJ1Lj/Dib+FVH/biSkzYMRBr
         3Lus+rJY75sUow25qpJa99ICm1wWYTRT7hvZKIFJ5GoE/GdfIqX5D5SAW+7L1zJ4MOiD
         YJvA==
X-Gm-Message-State: AJcUukdH74eK+VSZ2xEcAJW4Jt0ickn5cADVv2uKoVi04w0EN+9QGnCn
        VRS2+YDHq71KvhMPXiNIxjODZ14e2Q1E+OpXEhPDvA==
X-Google-Smtp-Source: ALg8bN5FNXNsu5fcBlk9edmXb8qlxYVHuZJL0prgv+a2N4OMV/QK3cX1rQFzLaefYgHREEVqOSOoFj1HD7xSlRHLT40=
X-Received: by 2002:a9d:3a0a:: with SMTP id j10mr14458057otc.229.1547916974345;
 Sat, 19 Jan 2019 08:56:14 -0800 (PST)
MIME-Version: 1.0
References: <20190116175804.30196-1-keith.busch@intel.com> <20190116175804.30196-6-keith.busch@intel.com>
 <CAJZ5v0jmkyrNBHzqHsOuWjLXF34tq83VnEhdBWrdFqxyiXC=cw@mail.gmail.com>
 <CAPcyv4gH0_e_NFJNOFH4XXarSs7+TOj4nT0r-D33ZGNCfqBdxg@mail.gmail.com> <20190119090129.GC10836@kroah.com>
In-Reply-To: <20190119090129.GC10836@kroah.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 19 Jan 2019 08:56:02 -0800
Message-ID: <CAPcyv4jijnkW6E=0gpT3-qy5uOgTV-D7AN+CAu7mmdrRKGHvFg@mail.gmail.com>
Subject: Re: [PATCHv4 05/13] Documentation/ABI: Add new node sysfs attributes
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Sat, Jan 19, 2019 at 1:01 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Jan 18, 2019 at 01:08:02PM -0800, Dan Williams wrote:
> > On Thu, Jan 17, 2019 at 3:41 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Wed, Jan 16, 2019 at 6:59 PM Keith Busch <keith.busch@intel.com> wrote:
> > > >
> > > > Add entries for memory initiator and target node class attributes.
> > > >
> > > > Signed-off-by: Keith Busch <keith.busch@intel.com>
> > >
> > > I would recommend combining this with the previous patch, as the way
> > > it is now I need to look at two patches at the time. :-)
> > >
> > > > ---
> > > >  Documentation/ABI/stable/sysfs-devices-node | 25 ++++++++++++++++++++++++-
> > > >  1 file changed, 24 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
> > > > index 3e90e1f3bf0a..a9c47b4b0eee 100644
> > > > --- a/Documentation/ABI/stable/sysfs-devices-node
> > > > +++ b/Documentation/ABI/stable/sysfs-devices-node
> > > > @@ -90,4 +90,27 @@ Date:                December 2009
> > > >  Contact:       Lee Schermerhorn <lee.schermerhorn@hp.com>
> > > >  Description:
> > > >                 The node's huge page size control/query attributes.
> > > > -               See Documentation/admin-guide/mm/hugetlbpage.rst
> > > > \ No newline at end of file
> > > > +               See Documentation/admin-guide/mm/hugetlbpage.rst
> > > > +
> > > > +What:          /sys/devices/system/node/nodeX/classY/
> > > > +Date:          December 2018
> > > > +Contact:       Keith Busch <keith.busch@intel.com>
> > > > +Description:
> > > > +               The node's relationship to other nodes for access class "Y".
> > > > +
> > > > +What:          /sys/devices/system/node/nodeX/classY/initiator_nodelist
> > > > +Date:          December 2018
> > > > +Contact:       Keith Busch <keith.busch@intel.com>
> > > > +Description:
> > > > +               The node list of memory initiators that have class "Y" access
> > > > +               to this node's memory. CPUs and other memory initiators in
> > > > +               nodes not in the list accessing this node's memory may have
> > > > +               different performance.
> > >
> > > This does not follow the general "one value per file" rule of sysfs (I
> > > know that there are other sysfs files with more than one value in
> > > them, but it is better to follow this rule as long as that makes
> > > sense).
> > >
> > > > +
> > > > +What:          /sys/devices/system/node/nodeX/classY/target_nodelist
> > > > +Date:          December 2018
> > > > +Contact:       Keith Busch <keith.busch@intel.com>
> > > > +Description:
> > > > +               The node list of memory targets that this initiator node has
> > > > +               class "Y" access. Memory accesses from this node to nodes not
> > > > +               in this list may have differet performance.
> > > > --
> > >
> > > Same here.
> > >
> > > And if you follow the recommendation given in the previous message
> > > (add "initiators" and "targets" subdirs under "classX"), you won't
> > > even need the two files above.
> >
> > This recommendation is in conflict with Greg's feedback about kobject
> > usage. If these are just "vanity" subdirs I think it's better to have
> > a multi-value sysfs file. This "list" style is already commonplace for
> > the /sys/devices/system hierarchy.
>
> If you do a subdirectory "correctly" (i.e. a name for an attribute
> group), that's fine.  Just do not ever create a kobject just for a
> subdir, that will mess up userspace.
>
> And I hate the "multi-value" sysfs files, where at all possible, please
> do not copy past bad mistakes there.  If you can make them individual
> files, please do that, it makes it easier to maintain and code the
> kernel for.

I agree in general about multi-value sysfs, but in this case we're
talking about a mask. Masks are a single value. That said I can get on
board with calling what 'cpulist' does a design mistake (human
readable mask), but otherwise switching to one file per item in the
mask is a mess for userspace to consume.
