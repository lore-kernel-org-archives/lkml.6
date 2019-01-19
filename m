Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EE1C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 09:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 086D72086D
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 09:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547888497;
	bh=6zgR7fa0U/P64hIkHedHMQoG4dqHI2TAlhjgQKiXG24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CTPbW0ImlhzEvcsFBf2aNdPPvhex8SNEXbkpd4I7gVslRrG7AaOZxQnRWsaw735pA
	 f3WCnhGBCNLyLxEqnNS0lbH9STQy+ACirrD/pXwvmHP8X+iB6PYpat69CsG/jkJTR/
	 fLI/+g6HSBrzdaUH0VRHGc7vFdkV9JTMzeDgBIh8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbfASJBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 04:01:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:52958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727733AbfASJBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 04:01:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DD8D2086D;
        Sat, 19 Jan 2019 09:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547888493;
        bh=6zgR7fa0U/P64hIkHedHMQoG4dqHI2TAlhjgQKiXG24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UiZ27jdac9oepbHvgd6MTRNKXsjc+7+IxIZST2JWTC9CoR6ubmuebt2EeRfMkuqp1
         G9ECAP8ftdykF2IdwA1FTYY1UUtnJ4IuVBEO0skOfxMlndK9etbiiIARti+SCctVVq
         BIM4CDPF26HRP4mYkw7ZoNt3yWuP33meTpprDxU0=
Date:   Sat, 19 Jan 2019 10:01:29 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv4 05/13] Documentation/ABI: Add new node sysfs attributes
Message-ID: <20190119090129.GC10836@kroah.com>
References: <20190116175804.30196-1-keith.busch@intel.com>
 <20190116175804.30196-6-keith.busch@intel.com>
 <CAJZ5v0jmkyrNBHzqHsOuWjLXF34tq83VnEhdBWrdFqxyiXC=cw@mail.gmail.com>
 <CAPcyv4gH0_e_NFJNOFH4XXarSs7+TOj4nT0r-D33ZGNCfqBdxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gH0_e_NFJNOFH4XXarSs7+TOj4nT0r-D33ZGNCfqBdxg@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 01:08:02PM -0800, Dan Williams wrote:
> On Thu, Jan 17, 2019 at 3:41 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Wed, Jan 16, 2019 at 6:59 PM Keith Busch <keith.busch@intel.com> wrote:
> > >
> > > Add entries for memory initiator and target node class attributes.
> > >
> > > Signed-off-by: Keith Busch <keith.busch@intel.com>
> >
> > I would recommend combining this with the previous patch, as the way
> > it is now I need to look at two patches at the time. :-)
> >
> > > ---
> > >  Documentation/ABI/stable/sysfs-devices-node | 25 ++++++++++++++++++++++++-
> > >  1 file changed, 24 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
> > > index 3e90e1f3bf0a..a9c47b4b0eee 100644
> > > --- a/Documentation/ABI/stable/sysfs-devices-node
> > > +++ b/Documentation/ABI/stable/sysfs-devices-node
> > > @@ -90,4 +90,27 @@ Date:                December 2009
> > >  Contact:       Lee Schermerhorn <lee.schermerhorn@hp.com>
> > >  Description:
> > >                 The node's huge page size control/query attributes.
> > > -               See Documentation/admin-guide/mm/hugetlbpage.rst
> > > \ No newline at end of file
> > > +               See Documentation/admin-guide/mm/hugetlbpage.rst
> > > +
> > > +What:          /sys/devices/system/node/nodeX/classY/
> > > +Date:          December 2018
> > > +Contact:       Keith Busch <keith.busch@intel.com>
> > > +Description:
> > > +               The node's relationship to other nodes for access class "Y".
> > > +
> > > +What:          /sys/devices/system/node/nodeX/classY/initiator_nodelist
> > > +Date:          December 2018
> > > +Contact:       Keith Busch <keith.busch@intel.com>
> > > +Description:
> > > +               The node list of memory initiators that have class "Y" access
> > > +               to this node's memory. CPUs and other memory initiators in
> > > +               nodes not in the list accessing this node's memory may have
> > > +               different performance.
> >
> > This does not follow the general "one value per file" rule of sysfs (I
> > know that there are other sysfs files with more than one value in
> > them, but it is better to follow this rule as long as that makes
> > sense).
> >
> > > +
> > > +What:          /sys/devices/system/node/nodeX/classY/target_nodelist
> > > +Date:          December 2018
> > > +Contact:       Keith Busch <keith.busch@intel.com>
> > > +Description:
> > > +               The node list of memory targets that this initiator node has
> > > +               class "Y" access. Memory accesses from this node to nodes not
> > > +               in this list may have differet performance.
> > > --
> >
> > Same here.
> >
> > And if you follow the recommendation given in the previous message
> > (add "initiators" and "targets" subdirs under "classX"), you won't
> > even need the two files above.
> 
> This recommendation is in conflict with Greg's feedback about kobject
> usage. If these are just "vanity" subdirs I think it's better to have
> a multi-value sysfs file. This "list" style is already commonplace for
> the /sys/devices/system hierarchy.

If you do a subdirectory "correctly" (i.e. a name for an attribute
group), that's fine.  Just do not ever create a kobject just for a
subdir, that will mess up userspace.

And I hate the "multi-value" sysfs files, where at all possible, please
do not copy past bad mistakes there.  If you can make them individual
files, please do that, it makes it easier to maintain and code the
kernel for.

thanks,

greg k-h
