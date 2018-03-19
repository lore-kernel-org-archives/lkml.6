Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933999AbeCSXLS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 19:11:18 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:44596 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933619AbeCSXLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 19:11:16 -0400
X-Google-Smtp-Source: AG47ELvV99yJ4QzW2YwAZn60bza1CfFJ1JFfUm9NxfwrAFHWcwJN6WpatP3HfWsnRQPUV/UW/yqBqG7DZVQTz+yCQ0A=
MIME-Version: 1.0
References: <20180309121549.630-1-harry.pan@intel.com> <20180309121549.630-2-harry.pan@intel.com>
 <a8bee7c7-8d09-f37a-9d12-b3a8a68a9b37@google.com>
In-Reply-To: <a8bee7c7-8d09-f37a-9d12-b3a8a68a9b37@google.com>
From: Puthikorn Voravootivat <puthik@google.com>
Date: Mon, 19 Mar 2018 23:11:00 +0000
Message-ID: <CANCcNXdVRi7JnvXhFAzMPZwUm9qFJYCNNj4f_YrsMzuShyhjdg@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf/x86/intel: Add Cannon Lake support of RAPL profiling
To: harry.pan@intel.com
Cc: linux-kernel@vger.kernel.org, gs0622@gmail.com, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        kan.liang@linux.intel.com, vincent.weaver@maine.edu,
        peterz@infradead.org, colin.king@canonical.com, bleung@chromium.org,
        Benson Leung <bleung@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 4:05 PM Benson Leung <bleung@google.com> wrote:

> Hi Harry,

> On 03/09/2018 04:15 AM, Harry Pan wrote:
> > This patch enables RAPL counters (energy consumption counters)
> > support for Cannon Lake processors.
> >
> > ESU and power domains refer to Intel Software Developers' Manual,
> > Vol. 4, Order No. 335592.
> >
> > Usage example:
> >
> > $ perf list
> > $ perf stat -a -e power/energy-cores/,power/energy-pkg/ sleep 10
> >
> > Signed-off-by: Harry Pan <harry.pan@intel.com>

> Reviewed-by: Benson Leung <bleung@chromium.org>

Tested-by: Puthikorn Voravootivat <puthik@chromium.org>


> > ---
> >  arch/x86/events/intel/rapl.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/intel/rapl.c
> > index a2efb490f743..32f3e9423e99 100644
> > --- a/arch/x86/events/intel/rapl.c
> > +++ b/arch/x86/events/intel/rapl.c
> > @@ -774,6 +774,8 @@ static const struct x86_cpu_id rapl_cpu_match[]
__initconst = {
> >       X86_RAPL_MODEL_MATCH(INTEL_FAM6_KABYLAKE_MOBILE,  skl_rapl_init),
> >       X86_RAPL_MODEL_MATCH(INTEL_FAM6_KABYLAKE_DESKTOP, skl_rapl_init),
> >
> > +     X86_RAPL_MODEL_MATCH(INTEL_FAM6_CANNONLAKE_MOBILE,
  skl_rapl_init),
> > +
> >       X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_GOLDMONT, hsw_rapl_init),
> >       X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_DENVERTON, hsw_rapl_init),
> >
> >

> Thanks,
> --
> Benson Leung
> Staff Software Engineer
> Chrome OS Kernel
> Google Inc.
> bleung@google.com
> Chromium OS Project
> bleung@chromium.org
