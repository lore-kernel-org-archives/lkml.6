Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E73C41518
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 090F92085A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbfAVQhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 11:37:54 -0500
Received: from mga18.intel.com ([134.134.136.126]:39738 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729360AbfAVQhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 11:37:53 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2019 08:37:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,507,1539673200"; 
   d="scan'208";a="111771908"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga008.jf.intel.com with ESMTP; 22 Jan 2019 08:37:52 -0800
Date:   Tue, 22 Jan 2019 09:36:50 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv4 05/13] Documentation/ABI: Add new node sysfs attributes
Message-ID: <20190122163650.GD1477@localhost.localdomain>
References: <20190116175804.30196-1-keith.busch@intel.com>
 <20190116175804.30196-6-keith.busch@intel.com>
 <CAJZ5v0jmkyrNBHzqHsOuWjLXF34tq83VnEhdBWrdFqxyiXC=cw@mail.gmail.com>
 <CAPcyv4gH0_e_NFJNOFH4XXarSs7+TOj4nT0r-D33ZGNCfqBdxg@mail.gmail.com>
 <20190119090129.GC10836@kroah.com>
 <CAJZ5v0jxuLPUvwr-hYstgC-7BKDwqkJpep94rnnUFvFhKG4W3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jxuLPUvwr-hYstgC-7BKDwqkJpep94rnnUFvFhKG4W3g@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 20, 2019 at 05:16:05PM +0100, Rafael J. Wysocki wrote:
> On Sat, Jan 19, 2019 at 10:01 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > If you do a subdirectory "correctly" (i.e. a name for an attribute
> > group), that's fine.
> 
> Yes, that's what I was thinking about: along the lines of the "power"
> group under device kobjects.

We can't append symlinks to an attribute group, though. I'd need to create
a lot of struct devices just to get the desired directory hiearchy. And
then each of those "devices" will have their own "power" group, which
really doesn't make any sense for what we're trying to show. Is that
really the right way to do this, or something else I'm missing?
