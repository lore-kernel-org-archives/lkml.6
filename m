Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528C9C1B0FD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E78C20652
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="YQDjo9KW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbfARVIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 16:08:15 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35866 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729502AbfARVIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 16:08:14 -0500
Received: by mail-oi1-f194.google.com with SMTP id x23so10073218oix.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 13:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=slVKCgtfR6RXPvhhk4waF03IbIKuP2Ae0m2u6xRYQ7w=;
        b=YQDjo9KWkk9z4g6Oxs/kvLIxE4b9hU/QhD3hO98AoaCw/9L2NPQ/LeE//ADqq3ABZB
         38JM5pUoZvEhTQzlPeX5GC4FRrH35MgogRZorwGSIEB6aMMpPQZBLpoubP6WhoZzkiV0
         LitaPt0J/xIZorQei9qN8QduTqB9Y9rquQhNbXvkhpoS+aXnqH0oNq+YNhLa+LerZYu6
         yNbnlDIJNfOSrmDr2kgG8SkNszyVzMeEyYlxVcfTZ7hjBCeUOtTN5xcOthQ089/uDGM+
         +v+H+wWlAFKZ2KvRByXCsvHyhjEDsT/AQkmm59DPE64cNr8Bk7EPeQ8ecQnQhRyw5zlq
         Np2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=slVKCgtfR6RXPvhhk4waF03IbIKuP2Ae0m2u6xRYQ7w=;
        b=RLetUpyIBW0JXPkHDM4CTN5+di/JkaRFAyfrVtQDsqzGaNMoD1Ym6KiHQ/9sMfMFH5
         Sy+S4U7lxNa+KfL4GWUogaTPAwAh5FfbobUvTI1TifcFAg4sz1diAwYHf3zo7PV15wyO
         PwIuNGpKpUMOK/ok5j0VrDqmY/RBCo0CHY6cc3ROOOzZzaRg7fwjhx6z1qJrRKd9Dwg1
         r3OP8Gj7vQr4g7cL9cVEz8hjc/KMNc+niqw2iys4TRgllPllwu9DxKLr/vrjhuIB7fQt
         CCk4kpmF3T+bjCST96UWJ/3oUsNo/Z4wE3oHQ7ZwjtKmHy2OFajunlpV4hG/xsvenV1o
         Qo1w==
X-Gm-Message-State: AJcUukcF+AEE1FR19esGSdTtme/IYDEjJhs8TNuyGb7ubQr6kfRVmh3E
        OVnFdCXqdBdAm9Hn6m7mAmiKTBUVqklhx7+aJ4znjg==
X-Google-Smtp-Source: ALg8bN7LPDKrLO5BrJepfCAq4JqcT975jSj4Uzn3q4n6m6JRvbAyxYGELFEPkHq2FWclOrJqWLbZtAet7ZT1Aj49/vU=
X-Received: by 2002:aca:d78b:: with SMTP id o133mr988461oig.232.1547845693575;
 Fri, 18 Jan 2019 13:08:13 -0800 (PST)
MIME-Version: 1.0
References: <20190116175804.30196-1-keith.busch@intel.com> <20190116175804.30196-6-keith.busch@intel.com>
 <CAJZ5v0jmkyrNBHzqHsOuWjLXF34tq83VnEhdBWrdFqxyiXC=cw@mail.gmail.com>
In-Reply-To: <CAJZ5v0jmkyrNBHzqHsOuWjLXF34tq83VnEhdBWrdFqxyiXC=cw@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 18 Jan 2019 13:08:02 -0800
Message-ID: <CAPcyv4gH0_e_NFJNOFH4XXarSs7+TOj4nT0r-D33ZGNCfqBdxg@mail.gmail.com>
Subject: Re: [PATCHv4 05/13] Documentation/ABI: Add new node sysfs attributes
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Keith Busch <keith.busch@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 3:41 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Jan 16, 2019 at 6:59 PM Keith Busch <keith.busch@intel.com> wrote:
> >
> > Add entries for memory initiator and target node class attributes.
> >
> > Signed-off-by: Keith Busch <keith.busch@intel.com>
>
> I would recommend combining this with the previous patch, as the way
> it is now I need to look at two patches at the time. :-)
>
> > ---
> >  Documentation/ABI/stable/sysfs-devices-node | 25 ++++++++++++++++++++++++-
> >  1 file changed, 24 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
> > index 3e90e1f3bf0a..a9c47b4b0eee 100644
> > --- a/Documentation/ABI/stable/sysfs-devices-node
> > +++ b/Documentation/ABI/stable/sysfs-devices-node
> > @@ -90,4 +90,27 @@ Date:                December 2009
> >  Contact:       Lee Schermerhorn <lee.schermerhorn@hp.com>
> >  Description:
> >                 The node's huge page size control/query attributes.
> > -               See Documentation/admin-guide/mm/hugetlbpage.rst
> > \ No newline at end of file
> > +               See Documentation/admin-guide/mm/hugetlbpage.rst
> > +
> > +What:          /sys/devices/system/node/nodeX/classY/
> > +Date:          December 2018
> > +Contact:       Keith Busch <keith.busch@intel.com>
> > +Description:
> > +               The node's relationship to other nodes for access class "Y".
> > +
> > +What:          /sys/devices/system/node/nodeX/classY/initiator_nodelist
> > +Date:          December 2018
> > +Contact:       Keith Busch <keith.busch@intel.com>
> > +Description:
> > +               The node list of memory initiators that have class "Y" access
> > +               to this node's memory. CPUs and other memory initiators in
> > +               nodes not in the list accessing this node's memory may have
> > +               different performance.
>
> This does not follow the general "one value per file" rule of sysfs (I
> know that there are other sysfs files with more than one value in
> them, but it is better to follow this rule as long as that makes
> sense).
>
> > +
> > +What:          /sys/devices/system/node/nodeX/classY/target_nodelist
> > +Date:          December 2018
> > +Contact:       Keith Busch <keith.busch@intel.com>
> > +Description:
> > +               The node list of memory targets that this initiator node has
> > +               class "Y" access. Memory accesses from this node to nodes not
> > +               in this list may have differet performance.
> > --
>
> Same here.
>
> And if you follow the recommendation given in the previous message
> (add "initiators" and "targets" subdirs under "classX"), you won't
> even need the two files above.

This recommendation is in conflict with Greg's feedback about kobject
usage. If these are just "vanity" subdirs I think it's better to have
a multi-value sysfs file. This "list" style is already commonplace for
the /sys/devices/system hierarchy.
