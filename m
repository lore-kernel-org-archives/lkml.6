Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753309AbeBTRZy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 12:25:54 -0500
Received: from mga12.intel.com ([192.55.52.136]:53072 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753129AbeBTRZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 12:25:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,540,1511856000";
   d="scan'208";a="31460968"
Message-ID: <1519147549.10722.2.camel@linux.intel.com>
Subject: Re: [PATCH v4 1/2] ACPI / x86: boot: Not all platforms require
 acpi_reduced_hw_init()
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Tue, 20 Feb 2018 19:25:49 +0200
In-Reply-To: <CAJZ5v0jAvkcNgieaRjnAss+vqg+=+STp8-ASqjVAh_KxP+swOQ@mail.gmail.com>
References: <20180220160358.68832-1-andriy.shevchenko@linux.intel.com>
         <CAJZ5v0jAvkcNgieaRjnAss+vqg+=+STp8-ASqjVAh_KxP+swOQ@mail.gmail.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-02-20 at 17:27 +0100, Rafael J. Wysocki wrote:
> On Tue, Feb 20, 2018 at 5:03 PM, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > Some platforms might take care of legacy devices on theirs own. Due
> > to this,
> > export acpi_reduced_hw_init() and put it into struct x86_init_acpi.
> 
> IMO this completely doesn't explain what really happens here.
> 
> You basically want to provide your own versions of
> x86_init.timers.timer_init, x86_init.irqs.pre_vector_init and
> legacy_pic on some HW-reduced platforms AFAICS, so you make it
> possible for the platform to provide its own variant of
> acpi_reduced_hw_init().

In this particular case only timers matter, though in general you are
right.

> I would say something like this:
> 
> "Some ACPI hawdware-reduced platforms need to initialize certain
> devices defined by the ACPI hardware specification even though in
> principle those devices should not be present in an ACPI
> hawdware-reduced platform.  To allow that to happen, make it possible
> to override the generic x86_init callbacks and provide a custom
> legacy_pic value, add a new ->reduced_hw_early_init() callback to
> struct x86_init_acpi and make acpi_reduced_hw_init() use it."

Thanks for review! I will use your suggestions in the next version.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
