Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752027AbeB1F71 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 00:59:27 -0500
Received: from mail-ot0-f171.google.com ([74.125.82.171]:38054 "EHLO
        mail-ot0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751631AbeB1F7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 00:59:25 -0500
X-Google-Smtp-Source: AG47ELtnZhOrcSS21UH6mHCYjtk6bwZPLw74EWiQhb2+IqRuySxZ4aeoPQJDI4TSshrF9wYoOBw8I6QuVV7f7a9SlW4=
MIME-Version: 1.0
In-Reply-To: <f9517b28-b782-d213-384a-b0811bf7e4fb@amd.com>
References: <1519788874-16561-1-git-send-email-wanpengli@tencent.com>
 <1519788874-16561-2-git-send-email-wanpengli@tencent.com> <f9517b28-b782-d213-384a-b0811bf7e4fb@amd.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Wed, 28 Feb 2018 13:59:24 +0800
Message-ID: <CANRm+Czs6FgLBEEaxbe926+_kGeP7UypABc7pggSic6wQu=s0Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] KVM: X86: Allow userspace to define the microcode version
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Liran Alon <liran.alon@oracle.com>, Nadav Amit <nadav.amit@gmail.com>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1S5xXSf029803

2018-02-28 13:55 GMT+08:00 Tom Lendacky <thomas.lendacky@amd.com>:
> On 2/27/2018 9:34 PM, Wanpeng Li wrote:
>> From: Wanpeng Li <wanpengli@tencent.com>
>>
>> Linux (among the others) has checks to make sure that certain features
>> aren't enabled on a certain family/model/stepping if the microcode version
>> isn't greater than or equal to a known good version.
>>
>> By exposing the real microcode version, we're preventing buggy guests that
>> don't check that they are running virtualized (i.e., they should trust the
>> hypervisor) from disabling features that are effectively not buggy.
>>
>> Suggested-by: Filippo Sironi <sironi@amazon.de>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Radim Krčmář <rkrcmar@redhat.com>
>> Cc: Liran Alon <liran.alon@oracle.com>
>> Cc: Nadav Amit <nadav.amit@gmail.com>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: Tom Lendacky <thomas.lendacky@amd.com>
>> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
>> ---
>> v4 -> v5:
>>  * microcode_version be u64 and initialized suitable, remote hte shifts
>> v3 -> v4:
>>  * add the shifts back
>> v2 -> v3:
>>  * remove the shifts
>>  * add the MSR_IA32_UCODE_REV version to the "feature MSRs"
>
> I think you lost this part from the patch series.  I don't see where you
> add MSR_IA32_UCODE_REV to the msr_based_features array.

I sent out a wrong version, will send again.

Regards,
Wanpeng Li
