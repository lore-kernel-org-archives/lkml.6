Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820D6C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 22:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E89B214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 22:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546988068;
	bh=NvnqUoU7GQoUtzti/SECPxKN/zJMy7RNxrC1smn7wuo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ClphsOAf1y6hZCfnQForB7YcvtcilPh3CyJ41efzWaw6U6JwtqqvlC/FslnlVnBm9
	 +LtwjgLWHDaezILdAF8mmPCyuE4cKwbKiTjEl9cjtFo6tMyvt/qcaThF7E19oV/Vx4
	 PEJ2+5WgpKMGs633HJQ33G/O76moCGjdO54Jm7FA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbfAHWy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 17:54:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:45576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728348AbfAHWy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 17:54:26 -0500
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E1E7218AF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jan 2019 22:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546988065;
        bh=NvnqUoU7GQoUtzti/SECPxKN/zJMy7RNxrC1smn7wuo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V32W80jWKdBWuOamkTVWXO+AnsFYfhIlaWyrIocmOolyBDT3LZVcLhKRZpSsEXgu6
         YkUh5GZQdtEt607W9ykMS0vMxIbXdY+nSVmw1g7/i2VkHSDpkW84hQbh/B/IkFT8GD
         FC5EQvDO66Xx3vGublmpJpC3Zzt0muCBPlqoTpyk=
Received: by mail-wr1-f42.google.com with SMTP id t6so5713272wrr.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 14:54:25 -0800 (PST)
X-Gm-Message-State: AJcUukdmOlTUZ9v2/JwwkJicG0WctzQD0Cb8FrTmaYEnX4V/nNyo336H
        Y5U9iZI1Ef9H/BsWSCRRILSeUO4poq6C+/dCUFK5CQ==
X-Google-Smtp-Source: ALg8bN6VZreit8qM/R1pOv2/qkZQ8jwXuSp8U893lvRHD0kTsH66VeWi/m+Y9AHzjOgVlNtgT26KeF2o/0gJoIvEubw=
X-Received: by 2002:adf:8323:: with SMTP id 32mr2737350wrd.176.1546988063578;
 Tue, 08 Jan 2019 14:54:23 -0800 (PST)
MIME-Version: 1.0
References: <20181214215729.4221-1-sean.j.christopherson@intel.com>
 <7706b2aa71312e1f0009958bcab24e1e9d8d1237.camel@linux.intel.com>
 <598cd050-f0b5-d18c-96a0-915f02525e3e@fortanix.com> <20181219091148.GA5121@linux.intel.com>
 <613c6814-4e71-38e5-444a-545f0e286df8@fortanix.com> <20181219144515.GA30909@linux.intel.com>
 <CALCETrW_8LnitFamYUU7POHFOJFxLO7ESFUdS=aeG_SOvHVPkw@mail.gmail.com>
 <20181221162825.GB26865@linux.intel.com> <105F7BF4D0229846AF094488D65A0989355A45B6@PGSMSX112.gar.corp.intel.com>
 <20190108220946.GA30462@linux.intel.com>
In-Reply-To: <20190108220946.GA30462@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 8 Jan 2019 14:54:11 -0800
X-Gmail-Original-Message-ID: <CALCETrU7Zb8L8eTYZg3bAB1Gfw1orUfeQmXjVy1_R-kfBeweVA@mail.gmail.com>
Message-ID: <CALCETrU7Zb8L8eTYZg3bAB1Gfw1orUfeQmXjVy1_R-kfBeweVA@mail.gmail.com>
Subject: Re: x86/sgx: uapi change proposal
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     "Huang, Kai" <kai.huang@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jethro Beekman <jethro@fortanix.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Haitao Huang <haitao.huang@linux.intel.com>,
        "Dr . Greg Wettstein" <greg@enjellic.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 2:09 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Tue, Jan 08, 2019 at 11:27:11AM -0800, Huang, Kai wrote:
> > > >
> > > > Can one of you explain why SGX_ENCLAVE_CREATE is better than just
> > > > opening a new instance of /dev/sgx for each encalve?
> > >
> > > Directly associating /dev/sgx with an enclave means /dev/sgx can't be used
> > > to provide ioctl()'s for other SGX-related needs, e.g. to mmap() raw EPC and
> > > expose it a VM.  Proposed layout in the link below.  I'll also respond to
> > > Jarkko's question about exposing EPC through /dev/sgx instead of having
> > > KVM allocate it on behalf of the VM.
> > >
> > > https://lkml.kernel.org/r/20181218185349.GC30082@linux.intel.com
> >
> > Hi Sean,
> >
> > Sorry for replying to old email. But IMHO it is not a must that Qemu
> > needs to open some /dev/sgx and allocate/mmap EPC for guest's virtual
> > EPC slot, instead, KVM could create private slot, which is not visible
> > to Qemu, for virtual EPC, and KVM could call core-SGX EPC allocation
> > API directly.
>
> That's possible, but it has several downsides.
>
>   - Duplicates a lot of code in KVM for managing memory regions.
>   - Artificially restricts userspace to a single EPC region, unless
>     even more code is duplicated to handle multiple private regions.
>   - Requires additional ioctls() or capabilities to probe EPC support
>   - Does not fit with Qemu/KVM's memory model, e.g. all other types of
>     memory are exposed to a guest through KVM_SET_USER_MEMORY_REGION.
>   - Prevents userspace from debugging a guest's enclave.  I'm not saying
>     this is a likely scenario, but I also don't think we should preclude
>     it without good reason.
>   - KVM is now responsible for managing the lifecycle of EPC, e.g. what
>     happens if an EPC cgroup limit is lowered on a running VM and
>     KVM can't gracefully reclaim EPC?  The userspace hypervisor should
>     ultimately decide how to handle such an event.
>   - SGX logic is split between SGX and KVM, e.g. VA page management for
>     oversubscription will likely be common to SGX and KVM.  From a long
>     term maintenance perspective, this means that changes to the EPC
>     management could potentially need to be Acked by KVM, and vice versa.
>
> > I am not sure what's the good of allowing userspace to alloc/mmap a
> > raw EPC region? Userspace is not allowed to touch EPC anyway, expect
> > enclave code.
> >
> > To me KVM creates private EPC slot is cleaner than exposing /dev/sgx/epc
> > and allowing userspace to map some raw EPC region.
>
> Cleaner in the sense that it's faster to get basic support up and running
> since there are fewer touchpoints, but there are long term ramifications
> to cramming EPC management in KVM.
>
> And at this point I'm not stating any absolutes, e.g. how EPC will be
> handled by KVM.  What I'm pushing for is to not eliminate the possibility
> of having the SGX subsystem own all EPC management, e.g. don't tie
> /dev/sgx to a single enclave.

I haven't gone and re-read all the relevant SDM bits, so I'll just
ask: what, if anything, are the actual semantics of mapping "raw EPC"
like this?  You can't actually do anything with the mapping from user
mode unless you actually get an enclave created and initialized in it
and have it mapped at the correct linear address, right?  I still
think you have the right idea, but it is a bit unusual.

I do think it makes sense to have QEMU delegate the various ENCLS
operations (especially EINIT) to the regular SGX interface, which will
mean that VM guests will have exactly the same access controls applied
as regular user programs, which is probably what we want.  If so,
there will need to be a way to get INITTOKEN privilege for the purpose
of running non-Linux OSes in the VM, which isn't the end of the world.
We might still want the actual ioctl to do EINIT using an actual
explicit token to be somehow restricted in a way that strongly
discourages its use by anything other than a hypervisor.  Or I suppose
we could just straight-up ignore the guest-provided init token.

--Andy

P.S. Is Intel ever going to consider a way to make guests get their
own set of keys that are different from the host's keys and other
guests' keys?
