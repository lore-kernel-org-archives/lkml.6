Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A02C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617C62089F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NqPfNnZG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 617C62089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388791AbeG0SiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:38:23 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34890 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730981AbeG0SiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:38:22 -0400
Received: by mail-oi0-f68.google.com with SMTP id i12-v6so10348403oik.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 10:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jEYPYKu2RwkB0dqhukBEw9icv/DcUCmbko88pvTWLrA=;
        b=NqPfNnZGnFfHnI2oeRWs4OGK6X5IrPNYpcijbfKmb70dOCL8D4C3w95zFRmWqWSbxF
         3bBs6n1VuLqgSUmYTsn7MQO4OS7E5kFDoPsz0EDiiE9T6b04Vl+J4xnZjxW00HpgPgch
         mEE8PevJ8nFJm3JcMee+EU7AIz5t0eTCX4YBio43RxKFfDrLK2cry1NcesYjxxFJwJxd
         J3wok3wVKPg9Aw0SE0qxN1YSDaXqvjHMmOqXNhM7Llwjfspdma9+ynlp8d31Elvyyit3
         snr5/c3N56z0NOGA2nZRIUJQUxkMGuk904dzhxKsfDFgOg3IOnPJOUDEDPdZUYyk2I+q
         kQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jEYPYKu2RwkB0dqhukBEw9icv/DcUCmbko88pvTWLrA=;
        b=jrwAYsjf5OKKL0Jlj0zAEvNMULtao8XyeglstMrgfE0YNzVt5U52RHo0EUOYQq0yf6
         8VSceGWK5AfStnKNADqRyq7CDydUsl+wpTzg2Nq1yk8Gjs4h0N26CgalJM55GpU5n8PI
         3TO8WSUC2yKg/GF6lMIONM4uBDd2+ewsRMBSpuYvugPFsuyqIeJjGnlVLIWoLr8yuwfR
         GN6hgL4fhJXC3WfzlMkcphB+kjn3K9+bPb9CI4y0MdvsJrpv1VrrSa27gEgd64aDcRpj
         1xJtPOnpPXhs/NCH+mULSgmw8uHwJToJURFnzWyhC4Ci7RjXLKibR7s/tQeuYm00X7wZ
         +PXw==
X-Gm-Message-State: AOUpUlE55lZl0YJEJG1oFvX0txAGKCMj+n9tDa3r+IekSoOIYlYJEkwY
        8R4ySICNe+eMPycfJnuhfaQyQGV79UNWj05ueHAYoQ==
X-Google-Smtp-Source: AAOMgpfU1Bks7gIC8IWFIZh+0i7OfuCdpUOLkn5RDhoDSXLuUhfdpk9mNa60kAaFHJ6zKG2BsFJ7fFxIeh4iNkhQ+hQ=
X-Received: by 2002:aca:ec46:: with SMTP id k67-v6mr7870233oih.81.1532711733016;
 Fri, 27 Jul 2018 10:15:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:3404:0:0:0:0:0 with HTTP; Fri, 27 Jul 2018 10:15:32
 -0700 (PDT)
In-Reply-To: <20170208080917.24320-9-khuey@kylehuey.com>
References: <20170208080917.24320-1-khuey@kylehuey.com> <20170208080917.24320-9-khuey@kylehuey.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 27 Jul 2018 10:15:32 -0700
Message-ID: <CALMp9eQfrbhZ-K8H3RTa75+OJggMyD+Ly_Ch0bTpazQQ7XbPEw@mail.gmail.com>
Subject: Re: [PATCH v14 8/9] KVM: x86: virtualize cpuid faulting
To:     Kyle Huey <me@kylehuey.com>
Cc:     "Robert O'Callahan" <robert@ocallahan.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
        David Matlack <dmatlack@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andi Kleen <andi@firstfloor.org>,
        LKML <linux-kernel@vger.kernel.org>,
        user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kvm list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 8, 2017 at 12:09 AM, Kyle Huey <me@kylehuey.com> wrote:
> Hardware support for faulting on the cpuid instruction is not required to
> emulate it, because cpuid triggers a VM exit anyways. KVM handles the relevant
> MSRs (MSR_PLATFORM_INFO and MSR_MISC_FEATURES_ENABLE) and upon a
> cpuid-induced VM exit checks the cpuid faulting state and the CPL.
> kvm_require_cpl is even kind enough to inject the GP fault for us.
>
> Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> Reviewed-by: David Matlack <dmatlack@google.com>

I have a couple of concerns about portions of this patch:

1) There are some backward compatibility issues:
  A) Suppose we have an old userspace that doesn't know it needs to
zero MSR_PLATFORM_INFO to preserve existing behavior (to the extent
possible). If a VM starts on a new kernel it could set the bit in
MSR_MISC_FEATURES_ENABLES that enables CPUID faulting. On
live-migration to an old kernel, that bit would be lost.
  B) With either an old userspace or a new userspace, as a VM migrates
between old and new kernels, the behavior of RDMSR with ECX set to
either MSR_PLATFORM_INFO or MSR_MISC_FEATURES_ENABLES will vary
depending on which kernel the VM is currently running on.
  Ideally, I think this new functionality should be guarded by a KVM
capability that has to be enabled from userspace.

2) This doesn't really play well with volume 3 of the SDM, section
18.7.3, where Intel instructs developers to use
MSR_PLATFORM_INFO[15:8] to determine the TSC frequency for a variety
of microarchitectures. When reads of this MSR raised #GP, it was
pretty clear that one couldn't get the TSC frequency that way, but I
don't think many consumers would specifically check for a 0 in that
field when the RDMSR succeeds. If a guest hypervisor used that value
in the computation of the TSC scaling factor for a VMCS12, for
example, it might be surprised to get a #DE.
