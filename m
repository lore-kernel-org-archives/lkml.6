Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657B3C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 23:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 330A5218AF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 23:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549496907;
	bh=Jb/sRI1XK8Vd07XB4TbRfHmOgfXNSZmLO2iLDDCIgr0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pf+A9E8IvMXVixSJcfoVE9FFRNQuF0nDVBgKVyO67HixbQtwTKrUruDjo2xN+Fui6
	 oZtBQ6a94oO9W7cjCoWz18t/In3WsZG7XhqrkyfMDC0Xkd8kq4JLlfz9dopRfn/j1I
	 f4bZJyP9cMMNc4hX4lEUxL1/a2JKWgIVIQ7VlJ1g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfBFXsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 18:48:25 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37140 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbfBFXsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 18:48:25 -0500
Received: by mail-ot1-f68.google.com with SMTP id s13so15257385otq.4;
        Wed, 06 Feb 2019 15:48:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2km3dMyZpRUU5hnOZjk3ra+UsEl0QjP4uRCEE8dLVpA=;
        b=aiZAt8Ho0m4MD5zZLLh8kcKSA8T7ZdwhsYP/ig5YObJazOXjZLskBrK5mvtCVbq4hU
         LsaVB/VYrN8h6lmsKGkumN7UBCx78KgD+qAZCEipAEWFBrJRzVj9Yt8mOLkyvgyGbG06
         kqYaWBk2OR9g1jPFysxLZ/3WJdCtIQfLAYW7ILAHlMQELQqzJTs0xFRYWyxcPNdE4hYi
         MJOBd0Fb4Uow0I4TNfeKnD+hGLxHtz8+qhLKgCpz7WBqDXmvdtu6sdtXVIVNlQZI2dJ/
         QE+PxYQIN8evhhwe64BKyCSQrCE6+MFZ72PhRWnG2dMV9dXcTTqP8YxnIP8JyoCxvNBa
         I/qg==
X-Gm-Message-State: AHQUAub6VNSoXocXtabF2Exg0Yw8LhNpMWy90mRGT75PQi51Y5ZiR39m
        Fz69ZAW9UjxM/ewypV4Kdm326PcU101xraCydouppfAO
X-Google-Smtp-Source: AHgI3IZpEk2CWNtYPQQ7KqZEikUauiX+EFdFnS71/6BMSENFy4IR4l4ddI99XqMvH80bYuTgwAvnu48+7Fk1yZ21Y3Q=
X-Received: by 2002:aca:f08b:: with SMTP id o133mr988016oih.32.1549496904026;
 Wed, 06 Feb 2019 15:48:24 -0800 (PST)
MIME-Version: 1.0
References: <20190124230724.10022-1-keith.busch@intel.com> <20190124230724.10022-5-keith.busch@intel.com>
 <CAJZ5v0jE_gRT5WgpQYwZQmx6N5G+axymbSySb2Nk8Q0OGeNt9A@mail.gmail.com>
 <20190205145227.GG17950@kroah.com> <CAJZ5v0g4ouD+9YYPSkoN7CRLTXYymeCaVkYNzm6Q6gGdNgJbuQ@mail.gmail.com>
 <20190206230953.GB30221@localhost.localdomain>
In-Reply-To: <20190206230953.GB30221@localhost.localdomain>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 7 Feb 2019 00:48:12 +0100
Message-ID: <CAJZ5v0hHCVTui70g0Dcn8GEWOBTW1HCTi=3RXLPRHL_p2U62Dg@mail.gmail.com>
Subject: Re: [PATCHv5 04/10] node: Link memory nodes to their compute nodes
To:     Keith Busch <keith.busch@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Thu, Feb 7, 2019 at 12:10 AM Keith Busch <keith.busch@intel.com> wrote:
>
> On Tue, Feb 05, 2019 at 04:17:09PM +0100, Rafael J. Wysocki wrote:
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > When you use a "raw" kobject then userspace tools do not see the devices
> > > and attributes in libraries like udev.
> >
> > And why would they need it in this particular case?
> >
> > > So unless userspace does not care about this at all,
> >
> > Which I think is the case here, isn't it?
> >
> > > you should use a 'struct device' where ever
> > > possible.  The memory "savings" usually just isn't worth it unless you
> > > have a _lot_ of objects being created here.
> > >
> > > Who is going to use all of this new information?
> >
> > Somebody who wants to know how the memory in the system is laid out AFAICS.
>
> Yes, this is for user space to make informed decisions about where it
> wants to allocate/relocate hot and cold data with respect to particular
> compute domains. So user space should care about these attributes,
> and they won't always be static when memory hotplug support for these
> attributes is added.
>
> Does that change anything, or still recommending kobject? I don't have a
> strong opinion either way and have both options coded and ready to
> submit new version once I know which direction is most acceptable.

If you want to make dynamic changes to the sysfs directories under
this object, uevents generated by device registration and
unregstration may be useful.  However, they only trigger automatically
when you register and unregister, so presumably you'd need to do that
every time for the changes to trigger an update in user space.  Also,
whoever is interested in this data would need to listen to the uevents
to get notified.

OTOH, you can call kobject_uevent() for the "raw" kobjects too.

Anyway, if Greg really prefers struct device to be used here, that's
fine by me, but since the uevents in question are going to be part of
your user space I/F then, it may be good to take that into
consideration. :-)

After all, you need to know how you want the I/F to work.
