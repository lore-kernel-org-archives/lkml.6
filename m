Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6641FC7113D
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 16:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F0C2087B
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 16:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548000985;
	bh=Uqj6SlkCSAzeeMeNDPs6OiJ95DQO1F2asoX1TcZVPkE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0oFgBcVm0oxsJu48mHIMY9Iavk/Zdt57gKhk3IZZaONd0awhhA51v38IK7n9A1ylX
	 DiXulzWf10HQm6jSK9N4iPIwAX16bMj9Tryle53jY3PHKTVTJaqN/B4kty5UbsW1ac
	 xt3YFI0aQ8769BH78oWvQfIHWTFOD6KLSeGfuw+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfATQQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 11:16:23 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38542 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfATQQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 11:16:23 -0500
Received: by mail-oi1-f195.google.com with SMTP id a77so12717088oii.5;
        Sun, 20 Jan 2019 08:16:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vqq8xMl7K0vAPz7n9VQCf5cdbFyZR4ZOXMYdzAlyKWw=;
        b=h0B2PeiYlgbiRsjdtVgKx0jr0VtdZlWmscwqXhuttv6ZSewbBuXgK1vw0C9hrdIjX+
         HJor+MXEKAnRzcQ6RafmHpswvjIvuOCeJSLC8/wqPFqQ7WL6+R+iMKW4jEOad138u98j
         bKUEmp/cZvVfg+Cen6ht0jTO1KUHhJdg8U5OhsuVkfY6oDlcE/7WvmjMO9RdkhPKh8QZ
         zBW6n8Czl5XjaS5xkOt7ABmi13UB4xoyEvP8+rhJGO3E+0/gFQMHhIlM2P7e3+2XoIt3
         te5aeQjOklWPV3sC/eg76ZJp8o9/8TZ3wm6pjnazAGeVFCz8luEy+2s/zggxXhYCqUIg
         f2UA==
X-Gm-Message-State: AJcUukeYxhNLhGW0Gnxo1y77ksrz4kccE9uhT2ppwX0dO8gVRYe8tCvO
        ftwNo3nwcvBLg9BAQpFOEj9Gg6p8B3Ac/ceJOfU=
X-Google-Smtp-Source: ALg8bN7VrgUhjumeH8KZNgH0lP3U5pjPHxVHl07vfY246EtGTaBwoElTJbCp2NHeWQX88AoBHdGVHOZ1lVdDkhq38ow=
X-Received: by 2002:aca:6c8b:: with SMTP id h133mr3561880oic.33.1548000981959;
 Sun, 20 Jan 2019 08:16:21 -0800 (PST)
MIME-Version: 1.0
References: <20190116175804.30196-1-keith.busch@intel.com> <20190116175804.30196-6-keith.busch@intel.com>
 <CAJZ5v0jmkyrNBHzqHsOuWjLXF34tq83VnEhdBWrdFqxyiXC=cw@mail.gmail.com>
 <CAPcyv4gH0_e_NFJNOFH4XXarSs7+TOj4nT0r-D33ZGNCfqBdxg@mail.gmail.com> <20190119090129.GC10836@kroah.com>
In-Reply-To: <20190119090129.GC10836@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 20 Jan 2019 17:16:05 +0100
Message-ID: <CAJZ5v0jxuLPUvwr-hYstgC-7BKDwqkJpep94rnnUFvFhKG4W3g@mail.gmail.com>
Subject: Re: [PATCHv4 05/13] Documentation/ABI: Add new node sysfs attributes
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
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

On Sat, Jan 19, 2019 at 10:01 AM Greg Kroah-Hartman
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
> group), that's fine.

Yes, that's what I was thinking about: along the lines of the "power"
group under device kobjects.

Cheers,
Rafael
