Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DATE_IN_PAST_03_06,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B884C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 16:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594E921983
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 16:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GoTBDeuV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388656AbeLVQtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 11:49:00 -0500
Received: from mail-it1-f182.google.com ([209.85.166.182]:38913 "EHLO
        mail-it1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388472AbeLVQs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 11:48:59 -0500
Received: by mail-it1-f182.google.com with SMTP id a6so10786789itl.4
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 08:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8mYjANv7GVYCBDYsRw8rbQFm+hW45EYmp5yGocBUZsM=;
        b=GoTBDeuVI1a4P6MdlH41YfI99X9KZas5XvmNoeWQXKJuSOClBc0QmM33k4KzomYxsp
         etid5ZQIMhqyJU0+79W+McALe1MPrSUO+y+jXbosmv+1fGbr1EqpYHGCHxThBcn8nHwk
         AaLqTxtXSXk0GHIz3MxunpNS8WAd5Yzpo1TIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8mYjANv7GVYCBDYsRw8rbQFm+hW45EYmp5yGocBUZsM=;
        b=n+3RWUPkUfL9kJOtQtgoJaEwy4NwAIfijcS0UOzsBSO6/c8aKUkvd77kZvk+1BzIAA
         Z4bma7zrGdmTrP16N3sRwaBwKkBtr12z0mgPzFKtrGi4sWE8/iTkMUkOBGKM8uUbtQJr
         QhMpBvxmswNymDvRMA/YICzojH16YGfbnkf6GwtiN0vRQHwQ1wcIVODRHnm5zaRi4+l+
         4pkHlHuZyznCOfnUrGXWCG+R1Y/aKIVicIEh9JBg3QYEczWo1uqNivM6qpwoYmE2HVP1
         kyQ6EpG3R/go5yGYJqZZEHSCUrsg3QHKCyCpJoyHe4EirGTyvY+djtAEFbucxgCcz88Q
         87qA==
X-Gm-Message-State: AA+aEWYthX/oV9v7rN+5K6uzKuVUJ366mRDCHGLn1L7bcFb/9/FwNSKH
        vpJV3YRSJ3p8v++Uu+uFmlQElSzAQTW7tRMQNRyt3Ebk
X-Google-Smtp-Source: AFSGD/V8NdOkDhMnaHWsfB6t1PNkHHswEIQeLkFNRjzS9fquv5Wvns84XxO9bcM4RIDslxyoxSuDTFQYXb17C8U6Ehk=
X-Received: by 2002:a24:edc4:: with SMTP id r187mr4707698ith.158.1545476878839;
 Sat, 22 Dec 2018 03:07:58 -0800 (PST)
MIME-Version: 1.0
References: <20181129171230.18699-6-ard.biesheuvel@linaro.org>
 <tip-08cfb38f3ef49cfd1bba11a00401451606477d80@git.kernel.org>
 <FFF73D592F13FD46B8700F0A279B802F48604575@ORSMSX114.amr.corp.intel.com>
 <CAKv+Gu_vTHFxpKRu_CxKP-GdNdgdFKr7fi87VkNur0sqGQNVDw@mail.gmail.com>
 <FFF73D592F13FD46B8700F0A279B802F486045CA@ORSMSX114.amr.corp.intel.com>
 <CAKv+Gu9iJinkP-buhmzRyB91_HcJ-tDwT3YHeHGFo4Bsiv7O_Q@mail.gmail.com>
 <FFF73D592F13FD46B8700F0A279B802F486046A9@ORSMSX114.amr.corp.intel.com>
 <CAKv+Gu99VdPero0yrXiaByURyp1idYE948Qi4j1eqY0ENCrF5A@mail.gmail.com>
 <20181221171308.GJ1325@zn.tnic> <CAKv+Gu91YsuK2QmWStPe84v8L7XD9x4cduTYgUjj3TPRfQckfw@mail.gmail.com>
 <20181221192928.GM1325@zn.tnic>
In-Reply-To: <20181221192928.GM1325@zn.tnic>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 22 Dec 2018 12:07:48 +0100
Message-ID: <CAKv+Gu-v+nBh2yK0uXbuwwnpEnpG8bk4ufSMXygMOdOd2XSTYw@mail.gmail.com>
Subject: Re: [tip:efi/core] x86/efi: Unmap EFI boot services code/data regions
 from efi_pgd
To:     Borislav Petkov <bp@alien8.de>
Cc:     Matt Fleming <matt@codeblueprint.co.uk>,
        "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "eric.snowberg@oracle.com" <eric.snowberg@oracle.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "arend.vanspriel@broadcom.com" <arend.vanspriel@broadcom.com>,
        "julien.thierry@arm.com" <julien.thierry@arm.com>,
        "bhsharma@redhat.com" <bhsharma@redhat.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "joe@perches.com" <joe@perches.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "natechancellor@gmail.com" <natechancellor@gmail.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sedat.dilek@gmail.com" <sedat.dilek@gmail.com>,
        "zhuyifei1999@gmail.com" <zhuyifei1999@gmail.com>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Dec 2018 at 20:29, Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Dec 21, 2018 at 06:26:23PM +0100, Ard Biesheuvel wrote:
> > On Fri, 21 Dec 2018 at 18:13, Borislav Petkov <bp@alien8.de> wrote:
> > >
> > > On Fri, Dec 21, 2018 at 06:02:29PM +0100, Ard Biesheuvel wrote:
> > > > As far as I can tell, the SGI x86 UV platforms still rely on this, so
> > > > we're stuck with it for the foreseeable future.
> > >
> > > What happened with the old apple laptops which couldn't handle high
> > > virtual mappings and needed 1:1? We don't care anymore?
> > >
> >
> > If that is the case (I wouldn't know) then yes, there is a second
> > reason why we need to keep this code.
>
> Fleming knows details and he's on CC, lemme "pull" him up into To: :-)
>

IIUC the 1:1 mapping and the 'old' mapping are two different things,
and the new mapping also contains a 1:1 mapping of the boot services
regions, at least until SetVirtualAddressMap() returns.
