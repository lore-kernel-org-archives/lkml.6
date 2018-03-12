Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbeCLPmr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 11:42:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:34598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751758AbeCLPmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 11:42:45 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4F9221799
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AG47ELvLzpvFuvmJ5tce0vxsZ8XUuty804eJWp4QvA/GPFUr0iogSRzTh+Wd4INCUD+Y76VFgQhqoiWjbg9WxL52Zl4=
MIME-Version: 1.0
In-Reply-To: <20180312140300.6166-4-vkuznets@redhat.com>
References: <20180312140300.6166-1-vkuznets@redhat.com> <20180312140300.6166-4-vkuznets@redhat.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Mon, 12 Mar 2018 15:42:23 +0000
X-Gmail-Original-Message-ID: <CALCETrUnKsNh8mbe-F=i8ZpcbbH8hDo4WmDPdmF9vEGLYk75+w@mail.gmail.com>
Message-ID: <CALCETrUnKsNh8mbe-F=i8ZpcbbH8hDo4WmDPdmF9vEGLYk75+w@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86/kvm/vmx: avoid expensive rdmsr for MSR_GS_BASE
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm list <kvm@vger.kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 2:03 PM, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> vmx_save_host_state() is only called from kvm_arch_vcpu_ioctl_run() so
> the context is pretty well defined and as we're past 'swapgs' MSR_GS_BASE
> should contain kernel's GS base which we point to irq_stack_union.
>
> Add new kernelmode_gs_base() API, irq_stack_union needs to be exported
> as KVM can be build as module.
>

Acked-by: Andy Lutomirski <luto@kernel.org>
