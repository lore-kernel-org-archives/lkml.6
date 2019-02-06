Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28463C282CC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 23:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE6C218E0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 23:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfBFXK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 18:10:26 -0500
Received: from mga03.intel.com ([134.134.136.65]:11649 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbfBFXKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 18:10:25 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2019 15:10:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,342,1544515200"; 
   d="scan'208";a="273061511"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga004.jf.intel.com with ESMTP; 06 Feb 2019 15:10:23 -0800
Date:   Wed, 6 Feb 2019 16:09:53 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCHv5 04/10] node: Link memory nodes to their compute nodes
Message-ID: <20190206230953.GB30221@localhost.localdomain>
References: <20190124230724.10022-1-keith.busch@intel.com>
 <20190124230724.10022-5-keith.busch@intel.com>
 <CAJZ5v0jE_gRT5WgpQYwZQmx6N5G+axymbSySb2Nk8Q0OGeNt9A@mail.gmail.com>
 <20190205145227.GG17950@kroah.com>
 <CAJZ5v0g4ouD+9YYPSkoN7CRLTXYymeCaVkYNzm6Q6gGdNgJbuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g4ouD+9YYPSkoN7CRLTXYymeCaVkYNzm6Q6gGdNgJbuQ@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 04:17:09PM +0100, Rafael J. Wysocki wrote:
> <gregkh@linuxfoundation.org> wrote:
> >
> > When you use a "raw" kobject then userspace tools do not see the devices
> > and attributes in libraries like udev.
> 
> And why would they need it in this particular case?
> 
> > So unless userspace does not care about this at all,
> 
> Which I think is the case here, isn't it?
> 
> > you should use a 'struct device' where ever
> > possible.  The memory "savings" usually just isn't worth it unless you
> > have a _lot_ of objects being created here.
> >
> > Who is going to use all of this new information?
> 
> Somebody who wants to know how the memory in the system is laid out AFAICS.

Yes, this is for user space to make informed decisions about where it
wants to allocate/relocate hot and cold data with respect to particular
compute domains. So user space should care about these attributes,
and they won't always be static when memory hotplug support for these
attributes is added.

Does that change anything, or still recommending kobject? I don't have a
strong opinion either way and have both options coded and ready to
submit new version once I know which direction is most acceptable.
