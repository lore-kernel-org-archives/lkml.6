Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAE5C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4E120859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732624AbfAORJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:09:00 -0500
Received: from mga11.intel.com ([192.55.52.93]:14176 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728566AbfAORI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 12:08:59 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2019 09:08:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,481,1539673200"; 
   d="scan'208";a="126259501"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga002.jf.intel.com with ESMTP; 15 Jan 2019 09:08:58 -0800
Date:   Tue, 15 Jan 2019 10:07:42 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [PATCHv3 03/13] acpi/hmat: Parse and report heterogeneous memory
Message-ID: <20190115170741.GB27730@localhost.localdomain>
References: <20190109174341.19818-1-keith.busch@intel.com>
 <20190109174341.19818-4-keith.busch@intel.com>
 <CAJZ5v0jk7ML21zxGwf9GaGNK8tP1LAs6Rd9NTK5O9HbzYeyPLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jk7ML21zxGwf9GaGNK8tP1LAs6Rd9NTK5O9HbzYeyPLA@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 07:42:46AM -0800, Rafael J. Wysocki wrote:
> On Wed, Jan 9, 2019 at 6:47 PM Keith Busch <keith.busch@intel.com> wrote:
> >
> > Systems may provide different memory types and export this information
> > in the ACPI Heterogeneous Memory Attribute Table (HMAT). Parse these
> > tables provided by the platform and report the memory access and caching
> > attributes.
> >
> > Signed-off-by: Keith Busch <keith.busch@intel.com>
> 
> While this is generally fine by me, it's another piece of code going
> under drivers/acpi/ just because it happens to use ACPI to extract
> some information from the platform firmware.
> 
> Isn't there any better place for it?

I've tried to abstract the user visible parts outside any particular
firmware implementation, but HMAT parsing is an ACPI specific feature,
so I thought ACPI was a good home for this part. I'm open to suggestions
if there's a better place. Either under in another existing subsystem,
or create a new one under drivers/hmat/?
