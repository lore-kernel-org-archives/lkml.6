Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2755DC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C133820837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C133820837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933754AbeFUMcm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 08:32:42 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:45136 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933675AbeFUMci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 08:32:38 -0400
Received: by mail-oi0-f67.google.com with SMTP id 188-v6so2725747oid.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 05:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ry/ot02F4lh2u4YOC2oVa9Z1CH8DiebNfrfiM1eyzM=;
        b=LrVreY+Jm7uHdFmBWDTAcWxDWfRylOPXZq+gs8iZg4n49T+/JReZC+HFoS8w8+UgTv
         0OSbAXTPyM92RI4YgrbR+Naia73HMtd0vTKW7Av4LwtvlZLabzZnVQSbsKnDJUwOs/Cf
         q0RV+9mn5FOauYo7s7iNpuhSw64Eicbn0BDo8kVaq5WYYfadnY2KqT9xCFIF7hELV8wi
         wUWsUtazCYWX0Y9I43V6QApvZUgySptrMjaA0OWDMGWxSxNqfOGmf5VXg2sDvBXtm+pB
         jS/S6DFIX5HjC0PTqowRzAWHUpGOk2frIy2n7Lhu//rP/8OL58oG4T4xci+JyJ38/Hcf
         V/fQ==
X-Gm-Message-State: APt69E2P3KvLPaNFHoJ1KSxf8vzio+zxWkY3nvhbrRIThJmjUs/x/Td/
        0uwCQcL0j7dx3bByd8OScgLbOggNuN6Y0aXQMOa4tA==
X-Google-Smtp-Source: ADUXVKI6efhJvoopKsfFfaiqKMpOQSu60jvBJ3l5Uh0j4m8B3uI4O+RwgOHvHIpHVI8HrjhGMYGiy/lEmZBhx2Rsb7I=
X-Received: by 2002:aca:e7c8:: with SMTP id e191-v6mr13712162oih.202.1529584357604;
 Thu, 21 Jun 2018 05:32:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180608171216.26521-14-jarkko.sakkinen@linux.intel.com>
 <CALCETrW3aZJMMm1GqgPm-cOD3p7JvKxLj7j85KJwfNW2iHTj4A@mail.gmail.com>
 <CALCETrVp1ZhrxF5bQDSaZpLucS88tErejj5JC6Jb0fB5etWRbA@mail.gmail.com>
 <20180611115255.GC22164@hmswarspite.think-freely.org> <CALCETrX6SD0ThNzpjkbXd7CbNTguzqiQhWMomGK+tocx_DE9XQ@mail.gmail.com>
 <20180612174535.GE19168@hmswarspite.think-freely.org> <CALCETrV-4D-M2ap1EFHQiQerYf_XgwLmBAx5WMvcCUefOODjOA@mail.gmail.com>
 <CAOASepN9t3jF4ajfKLG_odTZddOvXjY_DqLQhRPWhJ-imtjkgg@mail.gmail.com>
 <e3f8e5b9-aa1e-20da-37ac-3c3caafa66bc@fortanix.com> <b5c81504-83cd-8150-ebe4-41355026590f@fortanix.com>
 <20180620210158.GA24328@linux.intel.com>
In-Reply-To: <20180620210158.GA24328@linux.intel.com>
From:   Nathaniel McCallum <npmccallum@redhat.com>
Date:   Thu, 21 Jun 2018 08:32:25 -0400
Message-ID: <CAOASepN1AtgEhobJUVh=rcsQ_Qt8ujoEhnivV-29y=-AiyJwZQ@mail.gmail.com>
Subject: Re: [intel-sgx-kernel-dev] [PATCH v11 13/13] intel_sgx: in-kernel
 launch enclave
To:     sean.j.christopherson@intel.com
Cc:     jethro@fortanix.com, luto@kernel.org,
        Neil Horman <nhorman@redhat.com>,
        jarkko.sakkinen@linux.intel.com, x86@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, intel-sgx-kernel-dev@lists.01.org, hpa@zytor.com,
        dvhart@infradead.org, tglx@linutronix.de, andy@infradead.org,
        Peter Jones <pjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 5:02 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Wed, Jun 20, 2018 at 11:39:00AM -0700, Jethro Beekman wrote:
> > On 2018-06-20 11:16, Jethro Beekman wrote:
> > > > This last bit is also repeated in different words in Table 35-2 and
> > > > Section 42.2.2. The MSRs are *not writable* before the write-lock bit
> > > > itself is locked. Meaning the MSRs are either locked with Intel's key
> > > > hash, or not locked at all.
> >
> > Actually, this might be a documentation bug. I have some test hardware and I
> > was able to configure the MSRs in the BIOS and then read the MSRs after boot
> > like this:
> >
> > MSR 0x3a 0x0000000000040005
> > MSR 0x8c 0x20180620aaaaaaaa
> > MSR 0x8d 0x20180620bbbbbbbb
> > MSR 0x8e 0x20180620cccccccc
> > MSR 0x8f 0x20180620dddddddd
> >
> > Since this is not production hardware, it could also be a CPU bug of course.
> >
> > If it is indeed possible to configure AND lock the MSR values to non-Intel
> > values, I'm very much in favor of Nathaniels proposal to treat the launch
> > enclave like any other firmware blob.
>
> It's not a CPU or documentation bug (though the latter is arguable).
> SGX has an activation step that is triggered by doing a WRMSR(0x7a)
> with bit 0 set.  Until SGX is activated, the SGX related bits in
> IA32_FEATURE_CONTROL cannot be set, i.e. SGX can't be enabled.  But,
> the LE hash MSRs are fully writable prior to activation, e.g. to
> allow firmware to lock down the LE key with a non-Intel value.
>
> So yes, it's possible to lock the MSRs to a non-Intel value.  The
> obvious caveat is that whatever blob is used to write the MSRs would
> need be executed prior to activation.

This implies that it should be possible to create MSR activation (and
an embedded launch enclave?) entirely as a UEFI module. The kernel
would still get to manage who has access to /dev/sgx and other
important non-cryptographic policy details. Users would still be able
to control the cryptographic policy details (via BIOS Secure Boot
configuration that exists today). Distributions could still control
cryptographic policy details via signing of the UEFI module with their
own Secure Boot key (or using something like shim). The UEFI module
(and possibly the external launch enclave) could be distributed via
linux-firmware.

Andy/Neil, does this work for you?

> As for the SDM, it's a documentation... omission?  SGX activation
> is intentionally omitted from the SDM.  The intended usage model is
> that firmware will always do the activation (if it wants SGX enabled),
> i.e. post-firmware software will only ever "see" SGX as disabled or
> in the fully activated state, and so the SDM doesn't describe SGX
> behavior prior to activation.  I believe the activation process, or
> at least what is required from firmware, is documented in the BIOS
> writer's guide.
>
> > Jethro Beekman | Fortanix
> >
>
>
