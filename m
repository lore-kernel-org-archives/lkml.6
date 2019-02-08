Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CF0C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3383020844
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfBHNAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:00:05 -0500
Received: from mga11.intel.com ([192.55.52.93]:18865 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbfBHNAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:00:05 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2019 05:00:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,347,1544515200"; 
   d="scan'208";a="113385144"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga007.jf.intel.com with ESMTP; 08 Feb 2019 04:59:59 -0800
Received: from andy by smile with local (Exim 4.92-RC5)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1gs5l8-0006GX-Ss; Fri, 08 Feb 2019 14:59:58 +0200
Date:   Fri, 8 Feb 2019 14:59:58 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] mfd: intel-lpss: Move linux/pm.h to the local header
Message-ID: <20190208125958.GN9224@smile.fi.intel.com>
References: <20190124180328.76533-1-andriy.shevchenko@linux.intel.com>
 <20190201092545.GH783@dell>
 <CAHp75VdUuRCPLw4kVu5583TLm5E2otw3rPMQsiz6Bh_1o4NVig@mail.gmail.com>
 <20190201150817.GB4973@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201150817.GB4973@dell>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 03:08:17PM +0000, Lee Jones wrote:
> On Fri, 01 Feb 2019, Andy Shevchenko wrote:
> > On Fri, Feb 1, 2019 at 11:50 AM Lee Jones <lee.jones@linaro.org> wrote:
> > > On Thu, 24 Jan 2019, Andy Shevchenko wrote:
> > >
> > > > We now using a common macro for PM operations in Intel LPSS driver,
> > > > and, since that macro relies on the definition and macro from linux/pm.h
> > > > header file, it's logical to include it directly in intel-lpss.h.
> > > > Otherwise it's a bit fragile and requires a proper ordering
> > > > of header inclusion in C files.
> > >
> > > I don't agree with this.  File which use various headers should
> > > explicitly include them.  Inheriting header files is non-optimal.
> > >
> > 
> > intel-lpss.h _is_ using pm.h.
> > I don't see a contradiction here.
> 
> Then it should be including in there *also*.

Why?

intel-lpss-*.c are not direct users of this header.

> My point is that if drivers/mfd/intel-lpss-{acpi,pci}.c use the header
> file, it should include it explicitly.

They are using it indirectly.

As far as I know we don't, for example, include "asm/*.h" to each of our C-file
because they are in _indirect_ use of.

-- 
With Best Regards,
Andy Shevchenko


