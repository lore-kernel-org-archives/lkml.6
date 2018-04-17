Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752696AbeDQIj6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 04:39:58 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:37857 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752609AbeDQIjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 04:39:55 -0400
X-Google-Smtp-Source: AIpwx48UJcWye3KweDSy54Cm0PafRipfxFutOnSNgifYFAKLTEMuIDQujyi/j+2jFRr5GQ3zUZyIVmiOtNGSWsNcs7Q=
MIME-Version: 1.0
In-Reply-To: <20180221193941.12005.34137.stgit@tlendack-t1.amdoffice.net>
References: <20180221193941.12005.34137.stgit@tlendack-t1.amdoffice.net>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Tue, 17 Apr 2018 16:39:54 +0800
Message-ID: <CANRm+CzHgLsOar4ZJSn_cyOauH5b99zP=O34MM+f9t5Xe9i+fg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] KVM: MSR-based features
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joro@8bytes.org>,
        Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-22 3:39 GMT+08:00 Tom Lendacky <thomas.lendacky@amd.com>:
> The following series implements support within KVM for MSR-based features.
> The first patch creates the MSR-based feature framework used to retrieve
> the available MSR-based features.  The second patch makes use of the
> framework to allow a guest to determine if the LFENCE instruction is
> serializing on AMD processors.

Is there a qemu patch for LFENCE instruction?

Regards,
Wanpeng Li

>
> This series is based on the master branch of the KVM git tree.
>
> https://git.kernel.org/pub/scm/virt/kvm/kvm.git
>
> ---
>
> Changes from v2:
> - Moved back to initializing the MSR-based feature list in kvm_init_msr_list()
>   (based on the kvm_x86_ops callback return code)
> - Removed the definition of KVM_GET_MSR and switched back to using KVM_GET_MSRS
> - Consolidated the documentation to group the ioctl usage and describe the usage
>   specific to the version of the ioctl used.
>
> Tom Lendacky (2):
>       KVM: x86: Add a framework for supporting MSR-based features
>       KVM: SVM: Add MSR-based feature support for serializing LFENCE
>
>
>  Documentation/virtual/kvm/api.txt |   29 +++++++++++----
>  arch/x86/include/asm/kvm_host.h   |    2 +
>  arch/x86/kvm/svm.c                |   43 ++++++++++++++++++++++
>  arch/x86/kvm/x86.c                |   72 +++++++++++++++++++++++++++++++++++--
>  include/uapi/linux/kvm.h          |    1 +
>  5 files changed, 136 insertions(+), 11 deletions(-)
>
> --
> Tom Lendacky
