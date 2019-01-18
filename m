Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB834C1B0F7
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 20:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B839F20883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 20:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbfARUoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 15:44:03 -0500
Received: from mga14.intel.com ([192.55.52.115]:41566 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729471AbfARUoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 15:44:02 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jan 2019 12:44:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,492,1539673200"; 
   d="scan'208";a="128950048"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga001.jf.intel.com with ESMTP; 18 Jan 2019 12:44:01 -0800
Date:   Fri, 18 Jan 2019 13:42:51 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCHv4 05/13] Documentation/ABI: Add new node sysfs attributes
Message-ID: <20190118204251.GI31543@localhost.localdomain>
References: <20190116175804.30196-1-keith.busch@intel.com>
 <20190116175804.30196-6-keith.busch@intel.com>
 <CAJZ5v0jmkyrNBHzqHsOuWjLXF34tq83VnEhdBWrdFqxyiXC=cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jmkyrNBHzqHsOuWjLXF34tq83VnEhdBWrdFqxyiXC=cw@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 12:41:19PM +0100, Rafael J. Wysocki wrote:
> On Wed, Jan 16, 2019 at 6:59 PM Keith Busch <keith.busch@intel.com> wrote:
> >
> > Add entries for memory initiator and target node class attributes.
> >
> > Signed-off-by: Keith Busch <keith.busch@intel.com>
> 
> I would recommend combining this with the previous patch, as the way
> it is now I need to look at two patches at the time. :-)

Will do.
 
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

I think it actually does make sense to use "%*pbl" format here. The
type we're displaying is a bit array, so this is one value for that
attribute. There are many precedents for disapling bit arrays this
way. The existing node attributes that we're appending to show cpu
lists, and the top loevel shows node lists for "possible", "online",
"has_memory", "has_cpu". This new attribute should fit well with
exisiting similar attributes from this subsystem.
 
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

I think that makes sense, I'll take try out this suggestion.
 
> And, of course, the symlinks part needs to be documented as well.  I
> guess you can follow the
> Documentation/ABI/testing/sysfs-devices-power_resources_D0 with that.
