Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F92CECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97B32146E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hpaMHe1V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B97B32146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbeINWGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 18:06:48 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:42325 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbeINWGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 18:06:48 -0400
Received: by mail-oi0-f65.google.com with SMTP id v198-v6so13405996oif.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 09:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ilr2q8gsRL97oD/8UWuzGREmzMYzmekj1/LBaOxEU1s=;
        b=hpaMHe1V72SWg2ox8c2T0SNKj/2LZ1oJXXdwMMg9Bye4u/3Ieu+bXwPufKDnBF3rg2
         LfcLzuRsS8LmrY+6ilqp/PLMklzzv6ce/NvnaCuEykJHXANVic2bEwQvoVRdWrzM9/ox
         Npu7rcthh91fV4p9qJkhCCMsgCGN1Ph1SUCwk9ilNwwURtd+mDw4s/zLyIYKU4Zv8uSF
         mQG8KRzbzafrhlv788MoCtzF5Q4ae4e+6cYCL3Rfjk7Rs4d4F6dgB92De8yHT3ZaQYmF
         LPoq6IpTzbs87xG+/UPoN9PJuHqqVijimb4xAtzh+IY3Qpvzb7yrNIgJqIZKa9jnJiPs
         f3eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ilr2q8gsRL97oD/8UWuzGREmzMYzmekj1/LBaOxEU1s=;
        b=G0GLqWeyF1pRuFcnaFVM9YJQfJXVtwcFQAgbIxWEGOwBpGjMWW3Edvy1Po0/uf+M2W
         Axb6yPx4OO9VHyuemtRY6/RGUFS+aROpwf/7tBztaCgz6TcEhvBNmOQuWXhKD9kY2ks+
         qgVdRqOdOXZj5iJSlpMxhQsChOSHRS8jBMuFgog+mQDoVfwMClLsGCHangcIH7WzxGRL
         2aODx/uaXDNGKS1NvnAioSGWR4ufx7+ntnWWkW22Kgc9UR9FjNbJsiUHmy+hgH1y+pEo
         RZhptn4lbrzsMbcSffVhRAhn0lU6nITAEGqXgNEYqN0iZrjSavPDFXEdWME1/yXQR7PD
         hUOA==
X-Gm-Message-State: APzg51Br0FrLDnPHuoi+utF2YAY2He3OhjUviFUzGIPBTPdwqbDnkpcc
        QgRFmwNF+sTLE1rRcMVlguQPId+OmUF4UVN5SHJ1xA==
X-Google-Smtp-Source: ANB0Vda39oJ1i5/SaGo7RPlAtB5iXaCLBSWtaQDqA5+vlp9ElyI3A6Pj5RFnX3Domxz0nubdihwbBaCI5AahjCg/kf0=
X-Received: by 2002:aca:c2c1:: with SMTP id s184-v6mr9783441oif.117.1536943888673;
 Fri, 14 Sep 2018 09:51:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:2aea:0:0:0:0:0 with HTTP; Fri, 14 Sep 2018 09:51:28
 -0700 (PDT)
In-Reply-To: <87o9d08qnn.fsf@vitty.brq.redhat.com>
References: <20180913170522.24876-1-vkuznets@redhat.com> <20180913170522.24876-10-vkuznets@redhat.com>
 <CALMp9eTTK67npZLjpCYA=6EPpvF8nZZq7fH=e7NQRhDYXZ=UNQ@mail.gmail.com> <87o9d08qnn.fsf@vitty.brq.redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 14 Sep 2018 09:51:28 -0700
Message-ID: <CALMp9eTO7j1HGuzX=Br8mL4Z1zan4iFKEUmi1YEPwBm3-ZWLOw@mail.gmail.com>
Subject: Re: [PATCH v5 09/12] x86/kvm/nVMX: allow bare VMXON state migration
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Liran Alon <liran.alon@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 12:49 AM, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> Jim Mattson <jmattson@google.com> writes:
>
>> On Thu, Sep 13, 2018 at 10:05 AM, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>> It is perfectly valid for a guest to do VMXON and not do VMPTRLD. This
>>> state needs to be preserved on migration.
>>>
>>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>>> ---
>>>  arch/x86/kvm/vmx.c | 15 ++++++++-------
>>>  1 file changed, 8 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
>>> index d3297fadf7ed..25a25fff8dd9 100644
>>> --- a/arch/x86/kvm/vmx.c
>>> +++ b/arch/x86/kvm/vmx.c
>>> @@ -14482,13 +14482,6 @@ static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
>>>         if (!page_address_valid(vcpu, kvm_state->vmx.vmxon_pa))
>>>                 return -EINVAL;
>>>
>>> -       if (kvm_state->size < sizeof(kvm_state) + sizeof(*vmcs12))
>>> -               return -EINVAL;
>>> -
>>> -       if (kvm_state->vmx.vmcs_pa == kvm_state->vmx.vmxon_pa ||
>>> -           !page_address_valid(vcpu, kvm_state->vmx.vmcs_pa))
>>> -               return -EINVAL;
>>> -
>>>         if ((kvm_state->vmx.smm.flags & KVM_STATE_NESTED_SMM_GUEST_MODE) &&
>>>             (kvm_state->flags & KVM_STATE_NESTED_GUEST_MODE))
>>>                 return -EINVAL;
>>> @@ -14510,6 +14503,14 @@ static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
>>>         if (ret)
>>>                 return ret;
>>>
>>> +       /* Empty 'VMXON' state is permitted */
>>> +       if (kvm_state->size < sizeof(kvm_state) + sizeof(*vmcs12))
>>> +               return 0;
>>
>> In the original version of this code, the early exit is:
>>
>> if (kvm_state.vmcs_pa == -1ull)
>>         return 0;
>
> Time to restore the status quo :-)
>
> In any case this early exit should be done after enter_vmx_operation()
> as even without a valid VMCS we need to preserve VMXON state (e.g. Linux
> with loaded KVM but without any guests running).

Yes. That's also the way it was originally.
