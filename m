Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752186AbeEPBNO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 21:13:14 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:32796 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751402AbeEPBNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 21:13:13 -0400
X-Google-Smtp-Source: AB8JxZrhyu97iCIYxTblMNIi1BywbZToupPz0VbLj8lxzbT5jffZ/2j7B/xldNjcTV8/HFov0dorQJ+7KNCICdZaX08=
MIME-Version: 1.0
In-Reply-To: <CALMp9eT5aD0tjdTzTABo5a0aEtB52bZ7_-PCTF35Tikf8Q-vDg@mail.gmail.com>
References: <1523943962-25415-1-git-send-email-wanpengli@tencent.com>
 <1523943962-25415-3-git-send-email-wanpengli@tencent.com> <20180511154246.GH27459@char.us.oracle.com>
 <20180511154359.GC26700@char.us.oracle.com> <CALMp9eT5aD0tjdTzTABo5a0aEtB52bZ7_-PCTF35Tikf8Q-vDg@mail.gmail.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Wed, 16 May 2018 09:13:12 +0800
Message-ID: <CANRm+CxnSyenkV5ORjWkgtSG0uKvh0-hLRtvS-HPsZ3=PbCGvA@mail.gmail.com>
Subject: Re: [PATCH 2/3] KVM: X86: Allow userspace to disable ioport intercept
To: Jim Mattson <jmattson@google.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Tim Shearer <tshearer@advaoptical.com>,
        Liran Alon <liran.alon@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4G1DJDT007790

2018-05-16 5:56 GMT+08:00 Jim Mattson <jmattson@google.com>:
> I'd prefer to let the kvm module have the final say as to whether or
> not to allow userspace to do this.

I have an IRC discussion with Paolo, it seems that he didn't like the
original idea of the patchset.

Regards,
Wanpeng Li

>
> On Fri, May 11, 2018 at 8:43 AM, Konrad Rzeszutek Wilk
> <konrad.wilk@oracle.com> wrote:
>> On Fri, May 11, 2018 at 11:42:46AM -0400, Konrad Rzeszutek Wilk wrote:
>>> On Mon, Apr 16, 2018 at 10:46:01PM -0700, Wanpeng Li wrote:
>>> > From: Wanpeng Li <wanpengli@tencent.com>
>>> >
>>> > Allow to disable ioport intercept by userspace.
>>> >
>>> > Cc: Paolo Bonzini <pbonzini@redhat.com>
>>> > Cc: Radim Krčmář <rkrcmar@redhat.com>
>>> > Cc: Tim Shearer <tshearer@advaoptical.com>
>>> > Cc: Liran Alon <liran.alon@oracle.com>
>>> > Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
>>> > ---
>>> >  Documentation/virtual/kvm/api.txt | 11 +++++++++++
>>> >  arch/x86/include/asm/kvm_host.h   |  2 ++
>>> >  arch/x86/kvm/x86.c                |  5 +++++
>>> >  include/uapi/linux/kvm.h          |  1 +
>>> >  4 files changed, 19 insertions(+)
>>> >
>>> > diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
>>> > index 1c7958b..3d0488e 100644
>>> > --- a/Documentation/virtual/kvm/api.txt
>>> > +++ b/Documentation/virtual/kvm/api.txt
>>> > @@ -4378,6 +4378,17 @@ all such vmexits.
>>> >
>>> >  Do not enable KVM_FEATURE_PV_UNHALT if you disable HLT exits.
>>> >
>>> > +7.14 KVM_CAP_IOPORT_DISABLE_INTERCEPT
>>> > +
>>> > +Architectures: x86
>>
>> And to be exact: Intel only..
