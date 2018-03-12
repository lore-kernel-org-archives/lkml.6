Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932332AbeCLU3o (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 16:29:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48932 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932171AbeCLU3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 16:29:43 -0400
Date: Mon, 12 Mar 2018 13:29:39 -0700
From: Darren Hart <dvhart@infradead.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Platform Driver <platform-driver-x86@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] platform/x86: dell_smbios: Resolve dependency error on
 ACPI_WMI
Message-ID: <20180312202939.GB88572@localhost.localdomain>
References: <7eb3f317a876a6255aeb0abfd0137894ef8b5166.1520727789.git.dvhart@infradead.org>
 <CAHp75VeYDiv3gR77xjmj1QitmtTyNykXXFJtYyEFL95sgo1L9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VeYDiv3gR77xjmj1QitmtTyNykXXFJtYyEFL95sgo1L9A@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 11:23:20AM +0200, Andy Shevchenko wrote:
> On Sun, Mar 11, 2018 at 2:28 AM, Darren Hart <dvhart@infradead.org> wrote:
> > Similarly to DCDBAS for DELL_SMBIOS_SMM, if DELL_SMBIOS_WMI is enabled,
> > DELL_SMBIOS becomes dependent on ACPI_WMI. Update the depends line to
> > prevent a configuration where DELL_SMBIOS=y and either backend
> > dependency =m. Update the comment accordingly.
> 
> > +# The DELL_SMBIOS driver depends on ACPI_WMI and/or DCDBAS if those
> > +# backends are selected. The "depends" line prevents a configuration
> > +# where DELL_SMBIOS=y while either of those dependencies =m.
> >  #
> >  config DELL_SMBIOS
> >         tristate "Dell SMBIOS driver"
> > -       depends on DCDBAS || DCDBAS=n
> > +       depends on (DCDBAS || DCDBAS=n) && (ACPI_WMI || ACPI_WMI=n)
> 
> A nit: Perhaps separate depends on line for those two?

Agreed, resending v2, will run through testing, and send to Linus by EOD
tomorrow.

-- 
Darren Hart
VMware Open Source Technology Center
