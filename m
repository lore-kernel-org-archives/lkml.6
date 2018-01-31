Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751586AbeAaTEh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 14:04:37 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:48581 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750742AbeAaTEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 14:04:35 -0500
Date: Wed, 31 Jan 2018 11:04:32 -0800
From: Darren Hart <dvhart@infradead.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        AceLan Kao <acelan.kao@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] platform/x86: intel-vbtn: Remove redundant
 inclusions
Message-ID: <20180131190432.GF8676@fury>
References: <20180131175407.18301-1-andriy.shevchenko@linux.intel.com>
 <20180131185051.GC8676@fury>
 <CAHp75VdFh06kL=4fpoKogyX6K08SyX1zkJOjzmVcGqUWFA+2Ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdFh06kL=4fpoKogyX6K08SyX1zkJOjzmVcGqUWFA+2Ew@mail.gmail.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 08:59:20PM +0200, Andy Shevchenko wrote:
> On Wed, Jan 31, 2018 at 8:50 PM, Darren Hart <dvhart@infradead.org> wrote:
> > On Wed, Jan 31, 2018 at 07:54:06PM +0200, Andy Shevchenko wrote:
> >> Some headers are not needed since the driver can be built as module.
> >> Remove them.
> >
> > Removing init because it's included by module.h, and removing acpi_bus.h
> > because it's included by acpi.h - but not because it can be built as a
> > module - right?  Just checking, the wording in the commit msg seemed odd
> > to me.
> 
> Correct. I'll rephrase this in place.
> 
> > These removals seem appropriate to me, but so we have it recorded here -
> > in general, including headers that you explicitly make use of is good
> > practice, and not depending on others to include them. But in this case,
> > the implicit includes are reasonable expectations as they are tightly
> > coupled with the parent include.
> 
> There are two classes of headers (at least?):
> - let say "user-visible" ones, which drivers usually include like you
> pointed above
> - low level ones, which in most cases are not supposed to be included directly
> 
> So, for first class I agree with you, and acpi_bus.h in this case can
> be considered as an example of second class.

Agreed, acpi_bus.h is tightly coupled with acpi.h. The practice I've
seen from others and want to discourage / avoid is including acpi.h and
then deleting ... say...  spinlock.h because somewhere somehow acpi.h
also pulls it in. They are not tightly coupled conceptually, so
spinlock.h should remain in the include list if the file uses spinlocks
directly. I think we're in violent agreement here :-)

-- 
Darren Hart
VMware Open Source Technology Center
