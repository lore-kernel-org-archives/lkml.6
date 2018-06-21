Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20A1C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC4621A8A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AC4621A8A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754314AbeFUTLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 15:11:34 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:37488 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933509AbeFUTLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 15:11:30 -0400
Received: by mail-oi0-f66.google.com with SMTP id l22-v6so3950630oib.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 12:11:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RFDTUcSq8JuQ3uJv0IYqR45U0gi3vs3H3NWtakBbJTA=;
        b=tAcjwF01P+OGEROrA8swit1F/wBWlURTw7tuXl8i6dkh6LKB2X0F491B0N40Qh4xlZ
         L/4meHsk6bEt2ddPIC67TGX6FgxDj6kDw4+VKsBWnNUQbconTTv6LUZ0m3J/rDXbC1fL
         OVChlshP/TR+TNUfWh9Rwe2n8jl/6wKSJQsBivIZq6qEkuoQ2Ja8oys+fojqRJEwvon9
         h9T5XZVWEYSN/109q/pMBERQ7XnAqEObw5jOos1mS+2R5NMGTkS60hgDpZa8cP2zHao1
         S7vJsqxv0JyWS5lrzZCECq1WjWXdVTqmHV2CbpKX1tHl+nS4JDavxMXhy55O9URBQB0P
         Ozsg==
X-Gm-Message-State: APt69E3Fwj9+fT0zHw86mVOHar5nmlqzBcAEI5QxAFlfDKxQWLgZ4Nlw
        8AfKaa2XAoJ+ve1AhYCeyXy8tV4mzPzAdi7DeAjl8Q==
X-Google-Smtp-Source: ADUXVKImHWGJ6sKMy4oEK3+fulmJ6ycSIip6JeUt3+O33syLeAXd8Haqwy7PUilzZkXXzKhcuBKBgS6KMdVM2jJZF0c=
X-Received: by 2002:aca:4ad2:: with SMTP id x201-v6mr13614972oia.11.1529608289492;
 Thu, 21 Jun 2018 12:11:29 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrVp1ZhrxF5bQDSaZpLucS88tErejj5JC6Jb0fB5etWRbA@mail.gmail.com>
 <20180611115255.GC22164@hmswarspite.think-freely.org> <CALCETrX6SD0ThNzpjkbXd7CbNTguzqiQhWMomGK+tocx_DE9XQ@mail.gmail.com>
 <20180612174535.GE19168@hmswarspite.think-freely.org> <CALCETrV-4D-M2ap1EFHQiQerYf_XgwLmBAx5WMvcCUefOODjOA@mail.gmail.com>
 <CAOASepN9t3jF4ajfKLG_odTZddOvXjY_DqLQhRPWhJ-imtjkgg@mail.gmail.com>
 <e3f8e5b9-aa1e-20da-37ac-3c3caafa66bc@fortanix.com> <b5c81504-83cd-8150-ebe4-41355026590f@fortanix.com>
 <20180620210158.GA24328@linux.intel.com> <CAOASepN1AtgEhobJUVh=rcsQ_Qt8ujoEhnivV-29y=-AiyJwZQ@mail.gmail.com>
 <20180621152903.GB1324@hmswarspite.think-freely.org>
In-Reply-To: <20180621152903.GB1324@hmswarspite.think-freely.org>
From:   Nathaniel McCallum <npmccallum@redhat.com>
Date:   Thu, 21 Jun 2018 15:11:18 -0400
Message-ID: <CAOASepOPxte6aDHQB2dsd+VMPqWOuZZH4j8OKoqaHZ2cBsc38g@mail.gmail.com>
Subject: Re: [intel-sgx-kernel-dev] [PATCH v11 13/13] intel_sgx: in-kernel
 launch enclave
To:     Neil Horman <nhorman@redhat.com>
Cc:     sean.j.christopherson@intel.com, jethro@fortanix.com,
        luto@kernel.org, jarkko.sakkinen@linux.intel.com, x86@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, intel-sgx-kernel-dev@lists.01.org, hpa@zytor.com,
        dvhart@infradead.org, tglx@linutronix.de, andy@infradead.org,
        Peter Jones <pjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If this is acceptable for everyone, my hope is the following:

1. Intel would split the existing code into one of the following
schemas (I don't care which):
  A. three parts: UEFI module, FLC-only kernel driver and user-space
launch enclave
  B. two parts: UEFI module (including launch enclave) and FLC-only
kernel driver

2. Intel would release a reproducible build of the GPL UEFI module
sources signed with a SecureBoot trusted key and provide an
acceptable[0] binary redistribution license.

3. The kernel community would agree to merge the kernel driver given
the above criteria (and, obviously, acceptable kernel code).

The question of how to distribute the UEFI module and possible launch
enclave remains open. I see two options: independent distribution and
bundling it in linux-firmware. The former may be a better
technological fit since the UEFI module will likely need to be run
before the kernel (and the boot loader; and shim). However, the latter
has the benefit of already being a well-known entity to our downstream
distributors. I could go either way on this.

I know this plan is more work for everyone involved, but I think it
manages to actually maximize both security and freedom.

[0]: details here -
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/README#n19
On Thu, Jun 21, 2018 at 11:29 AM Neil Horman <nhorman@redhat.com> wrote:
>
> On Thu, Jun 21, 2018 at 08:32:25AM -0400, Nathaniel McCallum wrote:
> > On Wed, Jun 20, 2018 at 5:02 PM Sean Christopherson
> > <sean.j.christopherson@intel.com> wrote:
> > >
> > > On Wed, Jun 20, 2018 at 11:39:00AM -0700, Jethro Beekman wrote:
> > > > On 2018-06-20 11:16, Jethro Beekman wrote:
> > > > > > This last bit is also repeated in different words in Table 35-2 and
> > > > > > Section 42.2.2. The MSRs are *not writable* before the write-lock bit
> > > > > > itself is locked. Meaning the MSRs are either locked with Intel's key
> > > > > > hash, or not locked at all.
> > > >
> > > > Actually, this might be a documentation bug. I have some test hardware and I
> > > > was able to configure the MSRs in the BIOS and then read the MSRs after boot
> > > > like this:
> > > >
> > > > MSR 0x3a 0x0000000000040005
> > > > MSR 0x8c 0x20180620aaaaaaaa
> > > > MSR 0x8d 0x20180620bbbbbbbb
> > > > MSR 0x8e 0x20180620cccccccc
> > > > MSR 0x8f 0x20180620dddddddd
> > > >
> > > > Since this is not production hardware, it could also be a CPU bug of course.
> > > >
> > > > If it is indeed possible to configure AND lock the MSR values to non-Intel
> > > > values, I'm very much in favor of Nathaniels proposal to treat the launch
> > > > enclave like any other firmware blob.
> > >
> > > It's not a CPU or documentation bug (though the latter is arguable).
> > > SGX has an activation step that is triggered by doing a WRMSR(0x7a)
> > > with bit 0 set.  Until SGX is activated, the SGX related bits in
> > > IA32_FEATURE_CONTROL cannot be set, i.e. SGX can't be enabled.  But,
> > > the LE hash MSRs are fully writable prior to activation, e.g. to
> > > allow firmware to lock down the LE key with a non-Intel value.
> > >
> > > So yes, it's possible to lock the MSRs to a non-Intel value.  The
> > > obvious caveat is that whatever blob is used to write the MSRs would
> > > need be executed prior to activation.
> >
> > This implies that it should be possible to create MSR activation (and
> > an embedded launch enclave?) entirely as a UEFI module. The kernel
> > would still get to manage who has access to /dev/sgx and other
> > important non-cryptographic policy details. Users would still be able
> > to control the cryptographic policy details (via BIOS Secure Boot
> > configuration that exists today). Distributions could still control
> > cryptographic policy details via signing of the UEFI module with their
> > own Secure Boot key (or using something like shim). The UEFI module
> > (and possibly the external launch enclave) could be distributed via
> > linux-firmware.
> >
> > Andy/Neil, does this work for you?
> >
> I need some time to digest it.  Who in your mind is writing the UEFI module.  Is
> that the firmware vendor or IHV?
>
> Neil
>
> > > As for the SDM, it's a documentation... omission?  SGX activation
> > > is intentionally omitted from the SDM.  The intended usage model is
> > > that firmware will always do the activation (if it wants SGX enabled),
> > > i.e. post-firmware software will only ever "see" SGX as disabled or
> > > in the fully activated state, and so the SDM doesn't describe SGX
> > > behavior prior to activation.  I believe the activation process, or
> > > at least what is required from firmware, is documented in the BIOS
> > > writer's guide.
> > >
> > > > Jethro Beekman | Fortanix
> > > >
> > >
> > >
