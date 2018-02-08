Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752215AbeBHPyK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 10:54:10 -0500
Received: from mail-io0-f172.google.com ([209.85.223.172]:40362 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750961AbeBHPyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 10:54:08 -0500
X-Google-Smtp-Source: AH8x226Z5/R5pF0QjMZAsw+k9ufCNKuB69oPu19ec1+cpaNF8kbts0s18Ny4Hc5EPerh4iASGH6m+G1M9ZL0s9yBMWo=
MIME-Version: 1.0
In-Reply-To: <CALMp9eR0gaYuYbxKs6oWFJj+ciCtHtU+pnF4pLHmbdf2wnUuPw@mail.gmail.com>
References: <1517828686-29070-1-git-send-email-wanpengli@tencent.com>
 <CALMp9eQNB+2KLAR2Tv+By2oTthRLvAQMmJiEs61kFNrZDct3_g@mail.gmail.com>
 <CALMp9eSXvMmRj15q26_=VpJhYfUL_gHP-ce4h9bCv0N55JtT1w@mail.gmail.com>
 <CANRm+Cx_KVftOfeGWjqn_1P=j8R-NsNcH7w+pA9gCouM_4FDRw@mail.gmail.com>
 <CALMp9eRHzmU3Kfr0cxhy2Hrr-RybnjrsKHByoV27TdYffuuC3w@mail.gmail.com>
 <CANRm+CyqV6s6etBAveNTG2WjfMZrfuuN+HpF9Ub1ex=JjyA1yw@mail.gmail.com>
 <CALMp9eQ+wJyxQfru1j8i6CmBzvsYEPrK2wx94JFZ0M3rWSV0+g@mail.gmail.com>
 <CANRm+Cx9vBGNgk0Gfc=tNVR49hxwexD7U-NmtBadXy0AadA1fg@mail.gmail.com> <CALMp9eR0gaYuYbxKs6oWFJj+ciCtHtU+pnF4pLHmbdf2wnUuPw@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 8 Feb 2018 07:54:07 -0800
Message-ID: <CALMp9eT30t6J0jWsOrpWdUikFaVSTSW7RDGGYB1R17ZEiJAP9Q@mail.gmail.com>
Subject: Re: [PATCH] KVM: nVMX: Fix CR4 after VMLAUNCH/VMRESUME failure
To: Wanpeng Li <kernellwp@gmail.com>
Cc: kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Radim Krcmar <rkrcmar@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 8, 2018 at 7:29 AM, Jim Mattson <jmattson@google.com> wrote:
> Similarly, the correct L1 CR4 value should be in vmcs01's CR4
> read shadow field.

Sorry; that's wrong. L1's CR4 value has to be reconstructed from the
vmcs01 guest CR4 field and CR4 shadow field using the cr4 guest/host
mask. But there is no way to get it from any field(s) in vmcs12.
