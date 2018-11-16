Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2713C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 19:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF322086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 19:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="cObWPwP6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DF322086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbeKQFel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 00:34:41 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41298 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725729AbeKQFek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 00:34:40 -0500
Received: by mail-ot1-f65.google.com with SMTP id u16so22019862otk.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 11:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FG/4Jjmvs2/E0bpWqVu0+m501zYz/K8dKJh/95r8ZbM=;
        b=cObWPwP6i6pcw8qcKqSt/tkpofMBGpbvtl2X5WYdagQSsbDZz6ZPIvDAIxLfMpkT7D
         TSg1x2MIONQtmLY3yELhgRBi+mvIccUnhKbc+hEIdpokScKfv0abVfNGpHqEJ0RxiAk8
         01KxUT8eBMQ42IvfKOqLasi8jGdbYMGoQeOotO+e7gGwAyQ5h2xWguExSHQTQz7BBrwA
         dZNd/OaSFfLg3O7cTRAkk/Ln+wXbX8k8pL75TiP2J4EMr/uBRL+P7Z1gfxp9nkcoQkfn
         OMeVDq+vwXTxx1vFT+5psMVW6zx6XY+cRojpmEKBTCGZMd50NWC1l9RQ6e8Zh1iiZ8CR
         M4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FG/4Jjmvs2/E0bpWqVu0+m501zYz/K8dKJh/95r8ZbM=;
        b=cyPY8UTSiR+Bg2tdTNSWPJdzhZVObsCoKWCP0/YlbIhn6PIELJEkBN4Quca8slEaDN
         VVThPYUjVmewphsvdp9KKmho1d959j1A/9yMViZrudEfe+PSoux2B5UI3GLz0dWpmMpm
         w59DguAqTytAraHZY7/MdmGc1rOx6NAb9PP1rSbDAFFu09RVxsvO1F5jHnQQYYg4ly1o
         NCJTRWu1TRQjaL/gR7W4+62tSW5xKPDnwIXRNWzzBYt215ELeeYFwJ4vRvjdqgZyjlY7
         6RFP8Q2KY9axolxnQ5LODjYw1fp8cMGBHm/vEvItKASjg67F+3B+Hd6Ay08wFx9fhlmG
         omYw==
X-Gm-Message-State: AGRZ1gLZrHA+mOjLcRxVihOPdxcqi7bP0/7TEdTVWF+oJFPcd3Jh4che
        h+Fyb2LrTj4iWp6mKQPy21+NSzGolbAAqfC21DQ+tw==
X-Google-Smtp-Source: AJdET5eipulPAPjGDn0LefThTBBuoSDKDXuPsUxc1IUPI7Ohr6F6OcUis64YLf3RBnqqjgAzXbc5dUO4Rgzzfnj/Oas=
X-Received: by 2002:a9d:f07:: with SMTP id 7mr6840010ott.353.1542396060967;
 Fri, 16 Nov 2018 11:21:00 -0800 (PST)
MIME-Version: 1.0
References: <154225759358.2499188.15268218778137905050.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154225761038.2499188.1270468803677883744.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20181115063040.11eaef93@silica.lan>
In-Reply-To: <20181115063040.11eaef93@silica.lan>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 16 Nov 2018 11:20:49 -0800
Message-ID: <CAPcyv4gySBHp=-xnwA7f10K2wDuqPAB2C8C=9uU0q_mXcnzxbw@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [RFC PATCH 3/3] libnvdimm, MAINTAINERS:
 Subsystem Profile
To:     mchehab+samsung@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Vishal L Verma <vishal.l.verma@intel.com>, zwisler@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 6:31 AM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
>
> Em Wed, 14 Nov 2018 20:53:30 -0800
> Dan Williams <dan.j.williams@intel.com> escreveu:
>
> > Document the basic policies of the libnvdimm subsystem and provide a
> > first example of a Subsystem Profile for others to duplicate and edit.
> >
> > Cc: Ross Zwisler <zwisler@kernel.org>
> > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  Documentation/nvdimm/subsystem-profile.rst |   86 ++++++++++++++++++++++++++++
> >  MAINTAINERS                                |    4 +
> >  2 files changed, 90 insertions(+)
> >  create mode 100644 Documentation/nvdimm/subsystem-profile.rst
> >
> > diff --git a/Documentation/nvdimm/subsystem-profile.rst b/Documentation/nvdimm/subsystem-profile.rst
> > new file mode 100644
> > index 000000000000..d3428be7528e
> > --- /dev/null
> > +++ b/Documentation/nvdimm/subsystem-profile.rst
>
> Hmm... would it make sense to add a pointer at maintainer/index.rst (or to some
> other .rst file) for those profiles too?
>
> > @@ -0,0 +1,86 @@
> > +LIBNVDIMM Subsystem Profile
> > +===========================
> > +
> > +Overview
> > +--------
>
> A minor nitpick here: I would add a blank line after each topic/subtopic.
>
> On some cases, Sphinx will do wrong without that blank line, and having
> some places with that extra line and others without it sounds unbalanced
> on my eyes ;-)
>
> > +So, you have recently become a maintainer of the LIBNVDIMM subsystem,
> > +condolences, it is a thankless job, here is the lay of the land. The git
>
> My understanding that the main focus of this document is to help people to
> submit patches to the subsystem.
>
> With that in mind, I would never start the doc talking only to maintainers,
> as developers will likely just stop reading it at the above paragraph.

Yes, I see this is confusing now. I'll fix up the Subsystem Profile
description text to be written with maintainers as the audience and
clarify that the per-subsystem instance is written with contributors
as the audience.

>
> > +tree, git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git/, is
> > +writable by all the individuals listed in LIBNVDIMM section of
> > +MAINTAINERS. Access is granted per the typical kernel.org account
> > +management policies. Two branches in that tree are regularly pulled into
> > +-next, libnvdimm-for-next, and libnvdimm-fixes. The submit rate of
> > +patches is low, usually enough for one person to handle. There is a
> > +patchwork instance at
> > +https://patchwork.kernel.org/project/linux-nvdimm/list/, and it
> > +historically is only used for ingesting patches and collecting
> > +ack/review tags, i.e. no expectation to update the patch state after it
> > +has been dispositioned, or merged.
> > +
> > +The most sensitive code area is the ACPI DSM (Device Specific Method)
> > +path. In addition to the general fragility of an ioctl() ABI the ACPI
> > +DSM scheme allows any vendor to implement any command without any prior
> > +review by the ACPI committee. For this reason the LIBNVDIMM system seeks
> > +to constrain the proliferation of vendor commands and at a minimum
> > +requires any command support to be publicly documented. Over time the
> > +submission rate of new vendor-specific commands is falling as more
> > +commands are defined with named methods in the official ACPI
> > +specification.
>
> As Jani pointed, all the above stuff is for maintainers, but several other
> stuff on this document are for developers. The best would likely to have
> two separate files.
>
> However, maintaining it on two separate files could be painful. Maybe
> we could have an specific section, at the end of the document, with
> maintainers-specific instructions.

Yes, good idea, will incorporate.
