Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752207AbeBHQkm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 11:40:42 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58610 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751544AbeBHQkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 11:40:40 -0500
Subject: Re: [PATCH] KVM: nVMX: Fix CR4 after VMLAUNCH/VMRESUME failure
To: Jim Mattson <jmattson@google.com>, Wanpeng Li <kernellwp@gmail.com>
Cc: kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Radim Krcmar <rkrcmar@redhat.com>
References: <1517828686-29070-1-git-send-email-wanpengli@tencent.com>
 <CALMp9eQNB+2KLAR2Tv+By2oTthRLvAQMmJiEs61kFNrZDct3_g@mail.gmail.com>
 <CALMp9eSXvMmRj15q26_=VpJhYfUL_gHP-ce4h9bCv0N55JtT1w@mail.gmail.com>
 <CANRm+Cx_KVftOfeGWjqn_1P=j8R-NsNcH7w+pA9gCouM_4FDRw@mail.gmail.com>
 <CALMp9eRHzmU3Kfr0cxhy2Hrr-RybnjrsKHByoV27TdYffuuC3w@mail.gmail.com>
 <CANRm+CyqV6s6etBAveNTG2WjfMZrfuuN+HpF9Ub1ex=JjyA1yw@mail.gmail.com>
 <CALMp9eQ+wJyxQfru1j8i6CmBzvsYEPrK2wx94JFZ0M3rWSV0+g@mail.gmail.com>
 <CANRm+Cx9vBGNgk0Gfc=tNVR49hxwexD7U-NmtBadXy0AadA1fg@mail.gmail.com>
 <CALMp9eR0gaYuYbxKs6oWFJj+ciCtHtU+pnF4pLHmbdf2wnUuPw@mail.gmail.com>
 <CALMp9eT30t6J0jWsOrpWdUikFaVSTSW7RDGGYB1R17ZEiJAP9Q@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ad78ef46-7471-c095-0dd9-a5d5fbe85698@redhat.com>
Date: Thu, 8 Feb 2018 17:40:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CALMp9eT30t6J0jWsOrpWdUikFaVSTSW7RDGGYB1R17ZEiJAP9Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2018 16:54, Jim Mattson wrote:
> On Thu, Feb 8, 2018 at 7:29 AM, Jim Mattson <jmattson@google.com> wrote:
>> Similarly, the correct L1 CR4 value should be in vmcs01's CR4
>> read shadow field.
> Sorry; that's wrong. L1's CR4 value has to be reconstructed from the
> vmcs01 guest CR4 field and CR4 shadow field using the cr4 guest/host
> mask. But there is no way to get it from any field(s) in vmcs12.

Now that we have the prepare_vmcs02_full/prepare_vmcs02 split, we
probably should do more checks in there, and not rely on the processor
anymore.

Paolo
