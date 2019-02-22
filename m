Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C798C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7356320657
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbfBVSs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:48:29 -0500
Received: from mga11.intel.com ([192.55.52.93]:30607 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbfBVSs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:48:29 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Feb 2019 10:48:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,400,1544515200"; 
   d="scan'208";a="124469968"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga007.fm.intel.com with ESMTP; 22 Feb 2019 10:48:28 -0800
Date:   Fri, 22 Feb 2019 11:48:31 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCHv6 07/10] acpi/hmat: Register processor domain to its
 memory
Message-ID: <20190222184831.GF10237@localhost.localdomain>
References: <20190214171017.9362-1-keith.busch@intel.com>
 <20190214171017.9362-8-keith.busch@intel.com>
 <CAJZ5v0gjv0DZvYMTPBLnUmMtu8=g0zFd4x-cpP11Kzv+6XCwUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gjv0DZvYMTPBLnUmMtu8=g0zFd4x-cpP11Kzv+6XCwUw@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 11:02:01PM +0100, Rafael J. Wysocki wrote:
> On Thu, Feb 14, 2019 at 6:10 PM Keith Busch <keith.busch@intel.com> wrote:
> >  config ACPI_HMAT
> >         bool "ACPI Heterogeneous Memory Attribute Table Support"
> >         depends on ACPI_NUMA
> > +       select HMEM_REPORTING
> 
> If you want to do this here, I'm not sure that defining HMEM_REPORTING
> as a user-selectable option is a good idea.  In particular, I don't
> really think that setting ACPI_HMAT without it makes a lot of sense.
> Apart from this, the patch looks reasonable to me.

I'm trying to implement based on the feedback, but I'm a little confused.

As I have it at the moment, HMEM_REPORTING is not user-prompted, so
another option needs to turn it on. I have ACPI_HMAT do that here.

So when you say it's a bad idea to make HMEM_REPORTING user selectable,
isn't it already not user selectable?

If I do it the other way around, that's going to make HMEM_REPORTING
complicated if a non-ACPI implementation wants to report HMEM
properties.
