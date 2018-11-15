Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822D1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453BB22506
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 453BB22506
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388793AbeKPA7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 19:59:22 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:43147 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388685AbeKPA7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 19:59:21 -0500
X-IronPort-AV: E=Sophos;i="5.56,236,1539640800"; 
   d="scan'208";a="355851228"
Received: from unknown (HELO hadrien) ([64.114.255.114])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2018 15:51:09 +0100
Date:   Thu, 15 Nov 2018 06:51:07 -0800 (PST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
cc:     Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        ksummit-discuss@lists.linuxfoundation.org,
        linux-nvdimm@lists.01.org, Vishal Verma <vishal.l.verma@intel.com>,
        linux-kernel@vger.kernel.org, Ross Zwisler <zwisler@kernel.org>
Subject: Re: [Ksummit-discuss] [RFC PATCH 3/3] libnvdimm, MAINTAINERS:
 Subsystem Profile
In-Reply-To: <20181115063040.11eaef93@silica.lan>
Message-ID: <alpine.DEB.2.21.1811150649470.2371@hadrien>
References: <154225759358.2499188.15268218778137905050.stgit@dwillia2-desk3.amr.corp.intel.com> <154225761038.2499188.1270468803677883744.stgit@dwillia2-desk3.amr.corp.intel.com> <20181115063040.11eaef93@silica.lan>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-510466758-1542293471=:2371"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-510466758-1542293471=:2371
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Thu, 15 Nov 2018, Mauro Carvalho Chehab wrote:

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

This seems like a good idea.  New maintainers will probably be directed to
this document by existing maintainers, so they will already have some
context.  On the other hand, developers may interact with it on their own,
so it is good that they know immediately that they are in the right place.

julia

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
>
> > +
> > +LIBNVDIMM sits at the intersection of device-drivers, the block-layer,
> > +core memory-management, and filesystems. Be sure to re-route memory
> > +management patches to the -mm tree, and otherwise pull-in fs-devel for
> > +patches that touch anything related to DAX.
>
> This is for developers, so it sounds OK!
>
> > +
> > +Core
> > +----
> > +F: drivers/nvdimm/\*_devs.c
> > +F: drivers/acpi/nfit/\*.[ch]
> > +
> > +
> > +Patches or Pull requests
> > +------------------------
> > +Patches only
> > +
> > +
> > +Last day for new feature submissions
> > +------------------------------------
> > +Before -rc5
> > +
> > +
> > +Last day to merge features
> > +--------------------------
> > +End of last -rc
> > +
> > +
> > +Non-author Ack / Review Tags Required
> > +-------------------------------------
> > +Required
> > +
> > +
> > +Test Suite
> > +----------
> > +Run ‘make check’ from https://github.com/pmem/ndctl
> > +
> > +
> > +Trusted Reviewers
> > +-----------------
> > +Johannes Thumshirn
> > +Toshi Kani
> > +Jeff Moyer
> > +Robert Elliott
>
> See my other email commenting about that.
>
> > +
> > +
> > +Resubmit Cadence
> > +----------------
> > +8 business days
> > +
> > +
> > +Time Zone / Office Hours
> > +------------------------
> > +8:00am to 5:00pm Pacific Time Zone
> > +
> > +
> > +Checkpatch / Style cleanups
> > +---------------------------
> > +Standalone style-cleanups are welcome.
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index bb4a83a7684d..ba2beedd4605 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -8439,6 +8439,7 @@ M:	Dan Williams <dan.j.williams@intel.com>
> >  M:	Vishal Verma <vishal.l.verma@intel.com>
> >  M:	Dave Jiang <dave.jiang@intel.com>
> >  L:	linux-nvdimm@lists.01.org
> > +P:	Documentation/nvdimm/subsystem-profile.rst
> >  Q:	https://patchwork.kernel.org/project/linux-nvdimm/list/
> >  S:	Supported
> >  F:	drivers/nvdimm/blk.c
> > @@ -8450,6 +8451,7 @@ M:	Dan Williams <dan.j.williams@intel.com>
> >  M:	Ross Zwisler <zwisler@kernel.org>
> >  M:	Dave Jiang <dave.jiang@intel.com>
> >  L:	linux-nvdimm@lists.01.org
> > +P:	Documentation/nvdimm/subsystem-profile.rst
> >  Q:	https://patchwork.kernel.org/project/linux-nvdimm/list/
> >  S:	Supported
> >  F:	drivers/nvdimm/btt*
> > @@ -8460,6 +8462,7 @@ M:	Dan Williams <dan.j.williams@intel.com>
> >  M:	Vishal Verma <vishal.l.verma@intel.com>
> >  M:	Dave Jiang <dave.jiang@intel.com>
> >  L:	linux-nvdimm@lists.01.org
> > +P:	Documentation/nvdimm/subsystem-profile.rst
> >  Q:	https://patchwork.kernel.org/project/linux-nvdimm/list/
> >  S:	Supported
> >  F:	drivers/nvdimm/pmem*
> > @@ -8478,6 +8481,7 @@ M:	Ross Zwisler <zwisler@kernel.org>
> >  M:	Vishal Verma <vishal.l.verma@intel.com>
> >  M:	Dave Jiang <dave.jiang@intel.com>
> >  L:	linux-nvdimm@lists.01.org
> > +P:	Documentation/nvdimm/subsystem-profile.rst
> >  Q:	https://patchwork.kernel.org/project/linux-nvdimm/list/
> >  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git
> >  S:	Supported
> >
> > _______________________________________________
> > Ksummit-discuss mailing list
> > Ksummit-discuss@lists.linuxfoundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
>
>
>
>
> Cheers,
> Mauro
> _______________________________________________
> Ksummit-discuss mailing list
> Ksummit-discuss@lists.linuxfoundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
>
--8323329-510466758-1542293471=:2371--
