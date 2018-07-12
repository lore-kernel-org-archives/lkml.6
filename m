Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478AEC476E5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E684E20883
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j+YZioOY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E684E20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbeGLQgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 12:36:03 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:38688 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbeGLQgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 12:36:02 -0400
Received: by mail-oi0-f66.google.com with SMTP id v8-v6so56901128oie.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 09:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LiNiRxfqiEcD/6U+Ix5RXDcWy+3wHNAtbCOcI2W0So4=;
        b=j+YZioOY7N3jFPnl7f+35PecUFLFnyoGWm+fyqCTKw9dTp6gnJMoVFflEodQVNIPMw
         iWhYfvNMLjhTu44JhfPf0eCi/nwt0qZsqrUg7z+b3w/cpg2YlAVmXwfal44DPPwGspac
         EW/rCQvO4L0Q/IDeh0JSI59NNwK0dalWmzOvAJylduVQK0AR+YmSAG83+TW/hNTXoA5Y
         YWS8LsVK5wW1yD2WoWz1HL5y6q9c6j0rr6PpSbFlK/puD0itG+6zxbKp6lXCJB9W1lc1
         jZiE4gcs798H88asNmw/HFmkO5cVnVNbD4fmxUIhtymv5ISfjmZx+WbbiaDiTjoc8KCV
         Kr2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LiNiRxfqiEcD/6U+Ix5RXDcWy+3wHNAtbCOcI2W0So4=;
        b=A70nub7sA9lXGpNjXeM+yx6xCQ6atnmT/FbMvVsuqP6oVuoVR3o6iJ16MqdbztOa+e
         iJcPVcj9NQZtITF/wVB4RxPT3Obr6WkInUkMEoM9vD95Te7AlmL1aKc4EC3m+pskOFob
         Pewt4jO2nyUcxPB+t+5CG8E0mC1Ejjqq9HuutlS98oLhXsFIlOIEzS8DOYDLXAnzmQSB
         Y72BZTBfZxjXTa2JXG9jCZGWJo9FkXjX7N1XyMYDA5MB1KR07zedZhejWNJUB3QxcX3n
         HNc0vmL6rH7YzZP6DhqEIzIJrfssmwzmrnsV8XAkoTwY/izZARJAi8J5rwqS9HbcRUOT
         E8YA==
X-Gm-Message-State: AOUpUlG4CFHD/h4J0oLmkDil7SNtr+q5MDaoogrW4l3KvWH3KjHK9JiA
        mTfGa+58S0NUI8F44UeLhC+IGJTIgXsKkX6jFrYvcQ==
X-Google-Smtp-Source: AAOMgpdW/LbBm0xbc61T3cUhEARLwx59OiaLt6HoGpJL26ht6in+lYW+UszSajMFPp5zktUqil4Pu+BtGtPACQXPkiw=
X-Received: by 2002:aca:c585:: with SMTP id v127-v6mr3319662oif.348.1531412746618;
 Thu, 12 Jul 2018 09:25:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:3404:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 09:25:46
 -0700 (PDT)
In-Reply-To: <20180712113505.23354-1-vkuznets@redhat.com>
References: <20180712113505.23354-1-vkuznets@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 12 Jul 2018 09:25:46 -0700
Message-ID: <CALMp9eRabYJ0Q==pok9R0eDUXtdPa2iv83GWPcM-xw3ZFGq4Ww@mail.gmail.com>
Subject: Re: [PATCH] x86/kvm/nVMX: set exit_qualification correctly when
 nested_vmx_load_msr() fails
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Wanpeng Li <kernellwp@gmail.com>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This looks similar to my "[PATCH] kvm: nVMX: Restore exit qual for
VM-entry failure due to MSR loading"

On Thu, Jul 12, 2018 at 4:35 AM, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> Commit e79f245ddec1 ("X86/KVM: Properly update 'tsc_offset' to represent
> the running guest") introduced a regression in enter_vmx_non_root_mode():
> when nested_vmx_load_msr() fails exit_qualification needs to point to the
> entry number we failed to validate. Intel's SDM states:
>
> "VM-entry failure due to MSR loading. The exit qualification is loaded to
> indicate which entry in the VM-entry MSR-load area caused the problem (1
> for the first entry, 2 for the second, etc.)."
>
> Fixes: e79f245ddec1 ("X86/KVM: Properly update 'tsc_offset' to represent the running guest")
> Reported-by: Wanpeng Li <kernellwp@gmail.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/vmx.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 65968649b365..be468c822892 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -11720,8 +11720,10 @@ static int enter_vmx_non_root_mode(struct kvm_vcpu *vcpu)
>         msr_entry_idx = nested_vmx_load_msr(vcpu,
>                                             vmcs12->vm_entry_msr_load_addr,
>                                             vmcs12->vm_entry_msr_load_count);
> -       if (msr_entry_idx)
> +       if (msr_entry_idx) {
> +               exit_qual = msr_entry_idx;
>                 goto fail;
> +       }
>
>         /*
>          * Note no nested_vmx_succeed or nested_vmx_fail here. At this point
> --
> 2.14.4
>
