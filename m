Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21DCC7113D
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 16:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE5352087B
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 16:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548001215;
	bh=QAWH+9ixaeGOiazvqImEpq5irr32gvi3HlSBLDH2VlE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xzpISrRX4apIoPO0m18vsdrNS/5qS3kZYe4hQwJT6NuLQwnEi8hE8rB/dJQu9X5mF
	 zWk6Lvrh9WTQ/wpOWAGgQ1IDLerdIZM4ug/90dLqileG3gOZ7pn/LduwGKU6a3zmPU
	 y/Hn3cgoz5M9EZZfxFI+cEaF7uP5gDS6fM3RMGsU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfATQUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 11:20:13 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40995 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfATQUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 11:20:13 -0500
Received: by mail-oi1-f195.google.com with SMTP id j21so12713405oii.8;
        Sun, 20 Jan 2019 08:20:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=87E/+3zx0weqSrGfJzPSvhyyNU7cB2w5xkBG7edYcBc=;
        b=Xp6RWUM/qEW1agM5oAWgBluWop5L0cxTNnICH330MHT8g0k4D7TKPmfw6+5LEHkzaY
         MgVvIHPZ9MMdIxpXy8IONhqic0GVMQqDny16dGQ3MLwf/pyQZ9O4sGaIHL3Zy52kRIPo
         RN1BPztShIE7e9tu27wlG9ixwUBqHIouyhaLHPINT6cMjVi9N8pm8Ha73xg/sXkIOx7D
         yeh1B3qOtXYfokoswr4/79romb5wEmAVsgbIEYd+J2gcZxgFFAI4SksC04OF2a6cJY0g
         dS6ZMC8hvmHH+yrzH+Tq1hzStAgVL8putvNS/t9UehhNXuaak7ncEjUcpypk0jucOja8
         YJbA==
X-Gm-Message-State: AJcUukfA0xvH5MGC8FLOi9kuirB6EgQb7fx+gtTKphOeDDB/ks1Y794/
        Je/betTFViLpLthrOSsaJjqXhpRpiw86mpIwlEkzKQ==
X-Google-Smtp-Source: ALg8bN5NqABJ18wP8P6IhKoam3VQS7fk8Gs/RE1Yj7JHEHhV4UN+uNm+x//910014kfRV+Ut4sCX8NiXUchri5bNe+M=
X-Received: by 2002:aca:e715:: with SMTP id e21mr3625067oih.76.1548001212260;
 Sun, 20 Jan 2019 08:20:12 -0800 (PST)
MIME-Version: 1.0
References: <20190116175804.30196-1-keith.busch@intel.com> <20190116175804.30196-6-keith.busch@intel.com>
 <CAJZ5v0jmkyrNBHzqHsOuWjLXF34tq83VnEhdBWrdFqxyiXC=cw@mail.gmail.com>
 <CAPcyv4gH0_e_NFJNOFH4XXarSs7+TOj4nT0r-D33ZGNCfqBdxg@mail.gmail.com>
 <20190119090129.GC10836@kroah.com> <CAPcyv4jijnkW6E=0gpT3-qy5uOgTV-D7AN+CAu7mmdrRKGHvFg@mail.gmail.com>
In-Reply-To: <CAPcyv4jijnkW6E=0gpT3-qy5uOgTV-D7AN+CAu7mmdrRKGHvFg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 20 Jan 2019 17:19:56 +0100
Message-ID: <CAJZ5v0hS8Mb-BZuzztTt9D0Rd0TPzMcod48Ev-8HCZg07BP6fw@mail.gmail.com>
Subject: Re: [PATCHv4 05/13] Documentation/ABI: Add new node sysfs attributes
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Sat, Jan 19, 2019 at 5:56 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Sat, Jan 19, 2019 at 1:01 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Jan 18, 2019 at 01:08:02PM -0800, Dan Williams wrote:
> > > On Thu, Jan 17, 2019 at 3:41 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > >
> > > > On Wed, Jan 16, 2019 at 6:59 PM Keith Busch <keith.busch@intel.com> wrote:
> > > > >
> > > > > Add entries for memory initiator and target node class attributes.
> > > > >
> > > > > Signed-off-by: Keith Busch <keith.busch@intel.com>
> > > >
> > > > I would recommend combining this with the previous patch, as the way
> > > > it is now I need to look at two patches at the time. :-)
> > > >
> > > > > ---
> > > > >  Documentation/ABI/stable/sysfs-devices-node | 25 ++++++++++++++++++++++++-
> > > > >  1 file changed, 24 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
> > > > > index 3e90e1f3bf0a..a9c47b4b0eee 100644
> > > > > --- a/Documentation/ABI/stable/sysfs-devices-node
> > > > > +++ b/Documentation/ABI/stable/sysfs-devices-node
> > > > > @@ -90,4 +90,27 @@ Date:                December 2009
> > > > >  Contact:       Lee Schermerhorn <lee.schermerhorn@hp.com>
> > > > >  Description:
> > > > >                 The node's huge page size control/query attributes.
> > > > > -               See Documentation/admin-guide/mm/hugetlbpage.rst
> > > > > \ No newline at end of file
> > > > > +               See Documentation/admin-guide/mm/hugetlbpage.rst
> > > > > +
> > > > > +What:          /sys/devices/system/node/nodeX/classY/
> > > > > +Date:          December 2018
> > > > > +Contact:       Keith Busch <keith.busch@intel.com>
> > > > > +Description:
> > > > > +               The node's relationship to other nodes for access class "Y".
> > > > > +
> > > > > +What:          /sys/devices/system/node/nodeX/classY/initiator_nodelist
> > > > > +Date:          December 2018
> > > > > +Contact:       Keith Busch <keith.busch@intel.com>
> > > > > +Description:
> > > > > +               The node list of memory initiators that have class "Y" access
> > > > > +               to this node's memory. CPUs and other memory initiators in
> > > > > +               nodes not in the list accessing this node's memory may have
> > > > > +               different performance.
> > > >
> > > > This does not follow the general "one value per file" rule of sysfs (I
> > > > know that there are other sysfs files with more than one value in
> > > > them, but it is better to follow this rule as long as that makes
> > > > sense).
> > > >
> > > > > +
> > > > > +What:          /sys/devices/system/node/nodeX/classY/target_nodelist
> > > > > +Date:          December 2018
> > > > > +Contact:       Keith Busch <keith.busch@intel.com>
> > > > > +Description:
> > > > > +               The node list of memory targets that this initiator node has
> > > > > +               class "Y" access. Memory accesses from this node to nodes not
> > > > > +               in this list may have differet performance.
> > > > > --
> > > >
> > > > Same here.
> > > >
> > > > And if you follow the recommendation given in the previous message
> > > > (add "initiators" and "targets" subdirs under "classX"), you won't
> > > > even need the two files above.
> > >
> > > This recommendation is in conflict with Greg's feedback about kobject
> > > usage. If these are just "vanity" subdirs I think it's better to have
> > > a multi-value sysfs file. This "list" style is already commonplace for
> > > the /sys/devices/system hierarchy.
> >
> > If you do a subdirectory "correctly" (i.e. a name for an attribute
> > group), that's fine.  Just do not ever create a kobject just for a
> > subdir, that will mess up userspace.
> >
> > And I hate the "multi-value" sysfs files, where at all possible, please
> > do not copy past bad mistakes there.  If you can make them individual
> > files, please do that, it makes it easier to maintain and code the
> > kernel for.
>
> I agree in general about multi-value sysfs, but in this case we're
> talking about a mask. Masks are a single value. That said I can get on
> board with calling what 'cpulist' does a design mistake (human
> readable mask), but otherwise switching to one file per item in the
> mask is a mess for userspace to consume.

Can you please refer to my response to Keith?

If you have "initiators" and "targets" under "classX" and a list of
symlinks in each of them, I don't see any kind of a mess here.
