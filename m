Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934171AbeCSXNF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 19:13:05 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34747 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933619AbeCSXNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 19:13:02 -0400
X-Google-Smtp-Source: AG47ELtoX67ZpI/Er3LGPDutHEAFMEt+0wdwta+08zMc+zTU97VUpMv2l3NsObKjNOx8z494ce+Ehr8SNG6vUtT7AKo=
MIME-Version: 1.0
References: <20180309121549.630-1-harry.pan@intel.com> <20180309121549.630-3-harry.pan@intel.com>
 <cfac6f03-7700-dfe3-d1e6-9bf7f5a1d9c6@google.com>
In-Reply-To: <cfac6f03-7700-dfe3-d1e6-9bf7f5a1d9c6@google.com>
From: Puthikorn Voravootivat <puthik@google.com>
Date: Mon, 19 Mar 2018 23:12:45 +0000
Message-ID: <CANCcNXe-_orzk1-83=aSpbajfjFSznU4bo=8RVmL1bELeeaozw@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf/x86/intel: Enable C-state residency events for
 Cannon Lake
To: Benson Leung <bleung@google.com>
Cc: harry.pan@intel.com, linux-kernel@vger.kernel.org, gs0622@gmail.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        Kan.liang@intel.com, bleung@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 4:09 PM Benson Leung <bleung@google.com> wrote:

> Hi Harry,

> On 03/09/2018 04:15 AM, Harry Pan wrote:
> > Cannon Lake supports C1/C3/C6/C7, PC2/PC3/PC6/PC7/PC8/PC9/PC10
> > state residency counters, this patch enables those counters.
> >
> > The MSR information is based on Intel Software Developers' Manual,
> > Vol. 4, Order No. 335592.
> >
> > Signed-off-by: Harry Pan <harry.pan@intel.com>

> Reviewed-by: Benson Leung <bleung@chromium.org>

Tested-by: Puthikorn Voravootivat <puthik@chromium.org>

> > ---
> >  arch/x86/events/intel/cstate.c | 44
+++++++++++++++++++++++++++++-------------
> >  1 file changed, 31 insertions(+), 13 deletions(-)
> >
> > diff --git a/arch/x86/events/intel/cstate.c
b/arch/x86/events/intel/cstate.c
> > index 72db0664a53d..9aca448bb8e6 100644
> > --- a/arch/x86/events/intel/cstate.c
> > +++ b/arch/x86/events/intel/cstate.c
> > @@ -40,50 +40,51 @@
> >   * Model specific counters:
> >   *   MSR_CORE_C1_RES: CORE C1 Residency Counter
> >   *                    perf code: 0x00
> > - *                    Available model: SLM,AMT,GLM
> > + *                    Available model: SLM,AMT,GLM,CNL
> >   *                    Scope: Core (each processor core has a MSR)
> >   *   MSR_CORE_C3_RESIDENCY: CORE C3 Residency Counter
> >   *                          perf code: 0x01
> > - *                          Available model:
NHM,WSM,SNB,IVB,HSW,BDW,SKL,GLM
> > + *                          Available model:
NHM,WSM,SNB,IVB,HSW,BDW,SKL,GLM,
> > +                                             CNL
> >   *                          Scope: Core
> >   *   MSR_CORE_C6_RESIDENCY: CORE C6 Residency Counter
> >   *                          perf code: 0x02
> > - *                          Available model:
SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW
> > - *                                           SKL,KNL,GLM
> > + *                          Available model:
SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
> > + *                                           SKL,KNL,GLM,CNL
> >   *                          Scope: Core
> >   *   MSR_CORE_C7_RESIDENCY: CORE C7 Residency Counter
> >   *                          perf code: 0x03
> > - *                          Available model: SNB,IVB,HSW,BDW,SKL
> > + *                          Available model: SNB,IVB,HSW,BDW,SKL,CNL
> >   *                          Scope: Core
> >   *   MSR_PKG_C2_RESIDENCY:  Package C2 Residency Counter.
> >   *                          perf code: 0x00
> > - *                          Available model:
SNB,IVB,HSW,BDW,SKL,KNL,GLM
> > + *                          Available model:
SNB,IVB,HSW,BDW,SKL,KNL,GLM,CNL
> >   *                          Scope: Package (physical package)
> >   *   MSR_PKG_C3_RESIDENCY:  Package C3 Residency Counter.
> >   *                          perf code: 0x01
> > - *                          Available model:
NHM,WSM,SNB,IVB,HSW,BDW,SKL,KNL
> > - *                                           GLM
> > + *                          Available model:
NHM,WSM,SNB,IVB,HSW,BDW,SKL,KNL,
> > + *                                           GLM,CNL
> >   *                          Scope: Package (physical package)
> >   *   MSR_PKG_C6_RESIDENCY:  Package C6 Residency Counter.
> >   *                          perf code: 0x02
> >   *                          Available model:
SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW
> > - *                                           SKL,KNL,GLM
> > + *                                           SKL,KNL,GLM,CNL
> >   *                          Scope: Package (physical package)
> >   *   MSR_PKG_C7_RESIDENCY:  Package C7 Residency Counter.
> >   *                          perf code: 0x03
> > - *                          Available model:
NHM,WSM,SNB,IVB,HSW,BDW,SKL
> > + *                          Available model:
NHM,WSM,SNB,IVB,HSW,BDW,SKL,CNL
> >   *                          Scope: Package (physical package)
> >   *   MSR_PKG_C8_RESIDENCY:  Package C8 Residency Counter.
> >   *                          perf code: 0x04
> > - *                          Available model: HSW ULT only
> > + *                          Available model: HSW ULT,CNL
> >   *                          Scope: Package (physical package)
> >   *   MSR_PKG_C9_RESIDENCY:  Package C9 Residency Counter.
> >   *                          perf code: 0x05
> > - *                          Available model: HSW ULT only
> > + *                          Available model: HSW ULT,CNL
> >   *                          Scope: Package (physical package)
> >   *   MSR_PKG_C10_RESIDENCY: Package C10 Residency Counter.
> >   *                          perf code: 0x06
> > - *                          Available model: HSW ULT, GLM
> > + *                          Available model: HSW ULT,GLM,CNL
> >   *                          Scope: Package (physical package)
> >   *
> >   */
> > @@ -486,6 +487,21 @@ static const struct cstate_model hswult_cstates
__initconst = {
> >                                 BIT(PERF_CSTATE_PKG_C10_RES),
> >  };
> >
> > +static const struct cstate_model cnl_cstates __initconst = {
> > +     .core_events            = BIT(PERF_CSTATE_CORE_C1_RES) |
> > +                               BIT(PERF_CSTATE_CORE_C3_RES) |
> > +                               BIT(PERF_CSTATE_CORE_C6_RES) |
> > +                               BIT(PERF_CSTATE_CORE_C7_RES),
> > +
> > +     .pkg_events             = BIT(PERF_CSTATE_PKG_C2_RES) |
> > +                               BIT(PERF_CSTATE_PKG_C3_RES) |
> > +                               BIT(PERF_CSTATE_PKG_C6_RES) |
> > +                               BIT(PERF_CSTATE_PKG_C7_RES) |
> > +                               BIT(PERF_CSTATE_PKG_C8_RES) |
> > +                               BIT(PERF_CSTATE_PKG_C9_RES) |
> > +                               BIT(PERF_CSTATE_PKG_C10_RES),
> > +};
> > +
> >  static const struct cstate_model slm_cstates __initconst = {
> >       .core_events            = BIT(PERF_CSTATE_CORE_C1_RES) |
> >                                 BIT(PERF_CSTATE_CORE_C6_RES),
> > @@ -557,6 +573,8 @@ static const struct x86_cpu_id
intel_cstates_match[] __initconst = {
> >       X86_CSTATES_MODEL(INTEL_FAM6_KABYLAKE_MOBILE,  snb_cstates),
> >       X86_CSTATES_MODEL(INTEL_FAM6_KABYLAKE_DESKTOP, snb_cstates),
> >
> > +     X86_CSTATES_MODEL(INTEL_FAM6_CANNONLAKE_MOBILE, cnl_cstates),
> > +
> >       X86_CSTATES_MODEL(INTEL_FAM6_XEON_PHI_KNL, knl_cstates),
> >       X86_CSTATES_MODEL(INTEL_FAM6_XEON_PHI_KNM, knl_cstates),
> >
> >

> Thank you!
> --
> Benson Leung
> Staff Software Engineer
> Chrome OS Kernel
> Google Inc.
> bleung@google.com
> Chromium OS Project
> bleung@chromium.org
