Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032147AbeBNXrw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 18:47:52 -0500
Received: from mga14.intel.com ([192.55.52.115]:1073 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031901AbeBNXru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 18:47:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,515,1511856000";
   d="scan'208";a="27995167"
Message-ID: <1518652069.3239.4.camel@linux.intel.com>
Subject: Re: [PATCH] platform/x86: intel_turbo_max_3: Remove restriction for
 HWP platforms
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arjan@linux.intel.com
Date: Wed, 14 Feb 2018 15:47:49 -0800
In-Reply-To: <CAHp75VdUnw0NjcNDKzFp-hZWho4A8RV=9Xthz-foZ6wTaT+Ftg@mail.gmail.com>
References: <20180212195047.23671-1-srinivas.pandruvada@linux.intel.com>
         <CAHp75VdUnw0NjcNDKzFp-hZWho4A8RV=9Xthz-foZ6wTaT+Ftg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-2.fc25) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-02-14 at 21:29 +0200, Andy Shevchenko wrote:
> On Mon, Feb 12, 2018 at 9:50 PM, Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > On systems supporting HWP (Hardware P-States) mode, we expected to
> > enumerate core priority via ACPI-CPPC tables. Unfortunately
> > deployment of
> > TURBO 3.0 didn't use this method to show core priority. So users
> > are not
> > able to utilize this feature in HWP mode.
> > 
> > So remove the loading restriction of this driver for HWP enabled
> > systems.
> > Even if there are some systems, which are providing the core
> > priority via
> > ACPI CPPC, this shouldn't cause any conflict as the source of
> > priority
> > definition is same.
> > 
> 
> Pushed to my review and testing queue, thanks!
> 
> P.S. Should it go to stable?
I want to avoid stable kernel for now.

Thanks,
Srinivas

> 
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel
> > .com>
> > Reported-and-tested-and-reviewed-by: Arjan van de Ven <arjan@linux.
> > intel.com>
> > ---
> >  drivers/platform/x86/intel_turbo_max_3.c | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/drivers/platform/x86/intel_turbo_max_3.c
> > b/drivers/platform/x86/intel_turbo_max_3.c
> > index d4ea01805879..a6d5aa0c3c47 100644
> > --- a/drivers/platform/x86/intel_turbo_max_3.c
> > +++ b/drivers/platform/x86/intel_turbo_max_3.c
> > @@ -138,9 +138,6 @@ static int __init itmt_legacy_init(void)
> >         if (!id)
> >                 return -ENODEV;
> > 
> > -       if (boot_cpu_has(X86_FEATURE_HWP))
> > -               return -ENODEV;
> > -
> >         ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
> >                                 "platform/x86/turbo_max_3:online",
> >                                 itmt_legacy_cpu_online, NULL);
> > --
> > 2.13.6
> > 
> 
> 
> 
