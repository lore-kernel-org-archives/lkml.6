Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753355AbeBJAXU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 19:23:20 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:48915 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753300AbeBJAXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 19:23:19 -0500
X-IronPort-AV: E=Sophos;i="5.46,486,1511827200";
   d="scan'208";a="594229654"
Subject: Re: [PATCH 3/3] X86/nVMX: Update the MSR_BITMAP field with the L02
 MSR BITMAP
To: Jim Mattson <jmattson@google.com>
CC: KarimAllah Ahmed <karahmed@amazon.de>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <1518130410-6583-1-git-send-email-karahmed@amazon.de>
 <1518130410-6583-3-git-send-email-karahmed@amazon.de>
 <CALMp9eThOMGTru3hnuupJ_m4jPA7Hf=5=8ZJ4ygmC50vsDmngw@mail.gmail.com>
 <8d50836c-4eee-15ef-da20-212559105594@amazon.com>
 <CALMp9eSTWpRnXbxHA83UrMpwBsUMPJqNKe84DiGFPrwUgrYBVQ@mail.gmail.com>
From: KarimAllah Ahmed <karahmed@amazon.com>
Message-ID: <bd9abcc7-0540-16ec-6b77-785450a98a7a@amazon.com>
Date: Sat, 10 Feb 2018 01:22:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CALMp9eSTWpRnXbxHA83UrMpwBsUMPJqNKe84DiGFPrwUgrYBVQ@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [10.43.160.27]
X-ClientProxiedBy: EX13D17UWC001.ant.amazon.com (10.43.162.188) To
 EX13D01EUB003.ant.amazon.com (10.43.166.248)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1A0NPxn027383

On 02/10/2018 12:57 AM, Jim Mattson wrote:
> On Fri, Feb 9, 2018 at 3:41 PM, KarimAllah Ahmed <karahmed@amazon.com> wrote:
> 
>> I assume you are referring to this:
>>
>> https://patchwork.kernel.org/patch/10194819/
>>
>> .. which is now:
>>
>> commit 904e14fb7cb9 ("KVM: VMX: make MSR bitmaps per-VCPU")
>>
>> right?
>>
>> If this is the case, then I do not see where the MSR_BITMAP is being
>> updated here. In fact, would not this be the commit that actually broke
>> it?
> 
> I'm referring to
> <1517938181-15317-6-git-send-email-dwmw@amazon.co.uk>, which has:
> 
> @@ -10043,6 +9954,9 @@ static void prepare_vmcs02(struct kvm_vcpu
> *vcpu, struct vmcs12 *vmcs12)
>          if (kvm_has_tsc_control)
>                  decache_tsc_multiplier(vmx);
> 
> +       if (cpu_has_vmx_msr_bitmap())
> +               vmcs_write64(MSR_BITMAP, __pa(vmx->nested.vmcs02.msr_bitmap));
> +
>          if (enable_vpid) {
>                  /*
>                   * There is no direct mapping between vpid02 and vpid12, the
> 

Ooops, My bad! I must have ingested and old version of this commit that
did not have this hunk! Now actually looking at the upstream commit and
the backports from David, it is indeed there.

Sorry for the noise, please ignore this patch :)
Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
