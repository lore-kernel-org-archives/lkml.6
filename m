Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755352AbeDWM7T (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 08:59:19 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37012 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754874AbeDWM7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 08:59:14 -0400
Date: Mon, 23 Apr 2018 14:58:49 +0200
From: Borislav Petkov <bp@alien8.de>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>,
        Wanpeng Li <kernellwp@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
        kvm <kvm@vger.kernel.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH] KVM: X86: Allow userspace to define the microcode version
Message-ID: <20180423125849.GD22238@pd.tnic>
References: <20180226121509.GE4377@pd.tnic>
 <24cd527d-5287-f0be-ffe8-eab341bf1d94@redhat.com>
 <3866d359-0ef8-6a99-6254-84890be62b93@redhat.com>
 <20180226122205.GG4377@pd.tnic>
 <fb705c01-9bdd-9924-00c6-70d8ee940fb4@redhat.com>
 <CANRm+CyyL2jjjn7nZtLJvP+t1pN9ndAGhijmbX4LJh15=O+dvQ@mail.gmail.com>
 <20180417202417.GA29865@localhost.localdomain>
 <CANRm+CwA22VmpA5cfQg8mF_Xke_hXtP+_ui5xU+LV8v0JNj=3Q@mail.gmail.com>
 <20180418090329.GJ29865@localhost.localdomain>
 <de059c45-d706-ff70-9063-92ac0a807e26@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <de059c45-d706-ff70-9063-92ac0a807e26@redhat.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 12:36:37PM +0200, Paolo Bonzini wrote:
> On 18/04/2018 11:03, Eduardo Habkost wrote:
> >>> QEMU setting ucode_rev automatically using the host value when
> >>> using "-cpu host" (with no need for explicit ucode_rev option)
> >>> makes sense to me.
> >> QEMU can't get the host value by rdmsr MSR_IA32_UCODE_REV directly
> >> since rdmsr will #GP when ring !=0, any idea?
> > By looking at kvm_get_msr_feature(), it looks like
> > ioctl(system_fd, KVM_GET_MSRS) would return the host MSR value
> > for us.
> 
> Yes, that's exactly what it was introduced for (together with other MSRs
> including VMX capabilities).

Can't qemu do:

grep microcode /proc/cpuinfo | awk '{ print $3 }' | head -n 1

?

:)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
