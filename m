Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753311AbeBEQXy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 11:23:54 -0500
Received: from mga04.intel.com ([192.55.52.120]:24776 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753063AbeBEQXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 11:23:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,465,1511856000";
   d="scan'208";a="198749455"
Message-ID: <1517847823.22495.41.camel@linux.intel.com>
Subject: Re: [PATCH v1 1/2] platform/x86: intel-vbtn: Remove redundant
 inclusions
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Platform Driver <platform-driver-x86@vger.kernel.org>,
        AceLan Kao <acelan.kao@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Mon, 05 Feb 2018 18:23:43 +0200
In-Reply-To: <20180131190432.GF8676@fury>
References: <20180131175407.18301-1-andriy.shevchenko@linux.intel.com>
         <20180131185051.GC8676@fury>
         <CAHp75VdFh06kL=4fpoKogyX6K08SyX1zkJOjzmVcGqUWFA+2Ew@mail.gmail.com>
         <20180131190432.GF8676@fury>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.3-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-01-31 at 11:04 -0800, Darren Hart wrote:
> On Wed, Jan 31, 2018 at 08:59:20PM +0200, Andy Shevchenko wrote:
> > On Wed, Jan 31, 2018 at 8:50 PM, Darren Hart <dvhart@infradead.org>
> > wrote:
> > > On Wed, Jan 31, 2018 at 07:54:06PM +0200, Andy Shevchenko wrote:
> > > > Some headers are not needed since the driver can be built as
> > > > module.
> > > > Remove them.
> > > 
> > > Removing init because it's included by module.h, and removing
> > > acpi_bus.h
> > > because it's included by acpi.h - but not because it can be built
> > > as a
> > > module - right?  Just checking, the wording in the commit msg
> > > seemed odd
> > > to me.
> > 
> > Correct. I'll rephrase this in place.


My gosh, I forgot to do this and can't rebase anymore. Sorry.

> > > These removals seem appropriate to me, but so we have it recorded
> > > here -
> > > in general, including headers that you explicitly make use of is
> > > good
> > > practice, and not depending on others to include them. But in this
> > > case,
> > > the implicit includes are reasonable expectations as they are
> > > tightly
> > > coupled with the parent include.
> > 
> > There are two classes of headers (at least?):
> > - let say "user-visible" ones, which drivers usually include like
> > you
> > pointed above
> > - low level ones, which in most cases are not supposed to be
> > included directly
> > 
> > So, for first class I agree with you, and acpi_bus.h in this case
> > can
> > be considered as an example of second class.
> 
> Agreed, acpi_bus.h is tightly coupled with acpi.h. The practice I've
> seen from others and want to discourage / avoid is including acpi.h
> and
> then deleting ... say...  spinlock.h because somewhere somehow acpi.h
> also pulls it in. They are not tightly coupled conceptually, so
> spinlock.h should remain in the include list if the file uses
> spinlocks
> directly. I think we're in violent agreement here :-)

It's a problem of header organization I think. AFAIK Plan 9 has an idea
that each header is independent, and each C module has to include
headers in appropriate order. (Always trade off between flexibility and
strict hierarchy).

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
