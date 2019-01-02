Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD26BC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 19:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02F4218CD
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 19:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tlV96abm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbfABTTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 14:19:46 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:33183 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfABTTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 14:19:46 -0500
Received: by mail-it1-f196.google.com with SMTP id m8so39472006itk.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 11:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oWnPKF16oOcS7VJ9naJp0a5/SJGD58NVsZXbQban15w=;
        b=tlV96abmWRzrI18a3IiPR51fBa5C4eirFSxnuApnYa6IIVkxmI/DZstKF0eoEmfgy9
         49fcVa0SuC6zeGNAShwqyYlO+5H9+wmR1i0Kg16wzeOl1GVOXcmHzIs1SnwkaajVymdJ
         BZb3aL8Kv53VjBDp56U/PP1Yv2VCE3FiPiY5K5j4kgvgRwdo94cKs7qF5R7O2ll9iJFw
         eME2hvXyWQvme1zzihMBK0p0tr9N+TBLJ4waVjJhpki0FXxdEvoMiGrFssvZsoRTubHX
         8hRKyLLwHWODmelPtEjFcOH8KtN1o0PAeEZPQC6rWbWaTRHDkscWHiBIrDnqGOlWSTsz
         oZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oWnPKF16oOcS7VJ9naJp0a5/SJGD58NVsZXbQban15w=;
        b=H3cey4S3FnXamXKTc/F+5zN1U7W8VhaVwbzSJyU68FYDDXfK4NzYES9IrAK6Z8lNXc
         RUk2pY5Dv6+A/y6isr2sHFnXyYZTfFPe4C/ZgIY3JBQZC15GdB701LrQ/FtGHdstHUEE
         M7qUYTPt4DCJfNMHAPOP1/lSsCYOdOgTrVk8fyf8a3kt/PFny1nEu4nngIZciNNWiqey
         LiiMU4cIG98DHdnhq43POkHrJzPVzUmMJUVng80Aog5HvEvNqu4WwgEmUxXB2O6twx2g
         PrE6pwlcK2MuS3+4FlAx6HOJfm45mNHzaORSsyDyCb/w2BEYKDsCG1UpQk3Cmmj2UJZq
         OWiw==
X-Gm-Message-State: AA+aEWarn6LBLyX8lGIfClT3OudA6VtLG3LSdZKvmQSJSwfJ0KMdqsUC
        Ox4rGWLs5A1xUQXoacQ+9k0uDqADw7MgBvUpN8qiVA==
X-Google-Smtp-Source: AFSGD/V5C09B9YliR/4DZRagHxsnKT81UTsUWFd2HSvPqO3hBhKmJNIpW4X8fnqWyWPVZR3YX2mKbbawksMYKdHLGf4=
X-Received: by 2002:a02:ac8c:: with SMTP id x12mr27486427jan.72.1546456785167;
 Wed, 02 Jan 2019 11:19:45 -0800 (PST)
MIME-Version: 1.0
References: <20181226081532.30698-1-weijiang.yang@intel.com>
 <20181226081532.30698-6-weijiang.yang@intel.com> <20190102182446.GC7460@linux.intel.com>
In-Reply-To: <20190102182446.GC7460@linux.intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 2 Jan 2019 11:19:34 -0800
Message-ID: <CALMp9eS3F5siy-VhKwEiP+J3m3AeQ3WjvEkVPvvWZ-WMrqQYsw@mail.gmail.com>
Subject: Re: [PATCH v1 5/8] kvm:x86 Enable MSR_IA32_XSS bit 11 and 12 for CET xsaves/xrstors.
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Yang Weijiang <weijiang.yang@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>, yu-cheng.yu@intel.com,
        yi.z.zhang@intel.com, hjl.tools@gmail.com,
        Zhang Yi Z <yi.z.zhang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 2, 2019 at 10:24 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Wed, Dec 26, 2018 at 04:15:29PM +0800, Yang Weijiang wrote:
> > For kvm Guest OS, right now, only bit 11(user mode CET) and bit 12
> > (supervisor CET) are supported in XSS MSR, if other bits are being set,
> > the write to XSS will be skipped.
> >
> > Signed-off-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
> > Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> > ---
> >  arch/x86/kvm/vmx.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> > index fa2db6248404..5739ab393b90 100644
> > --- a/arch/x86/kvm/vmx.c
> > +++ b/arch/x86/kvm/vmx.c
> > @@ -47,6 +47,7 @@
> >  #include <asm/virtext.h>
> >  #include <asm/mce.h>
> >  #include <asm/fpu/internal.h>
> > +#include <asm/fpu/types.h>
> >  #include <asm/perf_event.h>
> >  #include <asm/debugreg.h>
> >  #include <asm/kexec.h>
> > @@ -4323,12 +4324,16 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> >       case MSR_IA32_XSS:
> >               if (!vmx_xsaves_supported())
> >                       return 1;
> > +
> >               /*
> > -              * The only supported bit as of Skylake is bit 8, but
> > -              * it is not supported on KVM.
> > +              * Right now, only support XSS_CET_U[bit 11] and
> > +              * XSS_CET_S[bit 12] in MSR_IA32_XSS.
> >                */
> > -             if (data != 0)
> > +
> > +             if (data & ~(XFEATURE_MASK_SHSTK_USER
> > +                          | XFEATURE_MASK_SHSTK_KERNEL))
>
> New lines are usually after the operator, e.g.:
>
>         if (data & ~(XFEATURE_MASK_SHSTK_USER |
>                      XFEATURE_MASK_SHSTK_KERNEL))
>
> And doesn't this flow need to check that the bits are actually supported?
Supported on the host and in the guest.
