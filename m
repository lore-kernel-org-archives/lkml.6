Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966342AbeBNBDl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 20:03:41 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:52498 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966224AbeBNBDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 20:03:39 -0500
X-Google-Smtp-Source: AH8x22771I6k4Cbk438Lp4NXpwr5BrPHHZ/JZvQnCCvmMj4Ei2mqjqHCeh9PfubmUGNIHCZOgnCskw==
Date: Tue, 13 Feb 2018 17:03:37 -0800 (PST)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Paolo Bonzini <pbonzini@redhat.com>
cc: Christian Borntraeger <borntraeger@de.ibm.com>,
        =?UTF-8?Q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [patch] kvm: suppress KVM_SET_GSI_ROUTING allocation failure
In-Reply-To: <f9754c98-9b8d-97b6-54cf-6d5e55143100@redhat.com>
Message-ID: <alpine.DEB.2.10.1802131702280.71590@chino.kir.corp.google.com>
References: <alpine.DEB.2.10.1802081334120.133173@chino.kir.corp.google.com> <47a55220-0006-6486-5a9d-1d1142efcc47@de.ibm.com> <f9754c98-9b8d-97b6-54cf-6d5e55143100@redhat.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Feb 2018, Paolo Bonzini wrote:

> >> The KVM_SET_GSI_ROUTING ioctl does a vmalloc() of
> >> sizeof(struct kvm_irq_routing_entry) multiplied by a user-supplied value.
> >> This can be up to 4096 entries on architectures such as arm64 and s390
> >> (and the upper bound may be increased on s390 eventually).
> >>
> >> This can produce a vmalloc allocation failure warning:
> >>
> > [...]
> >>  kvm_vm_ioctl+0x910/0x15e0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:4153
> > 
> >                                                                        ^^^^^
> > 
> >> @@ -3063,7 +3063,8 @@ static long kvm_vm_ioctl(struct file *filp,
> > 
> >       ^^^^^
> > 
> > 
> > Are you sure that you got the right vmalloc?
> 
> Nice catch!  But well, it's the only one in the whole file. :)
> 
> That seems very much like an old patch then.  I'm unqueuing it.
> 

It's not a catch at all, the fact that I saw this warning with an older 
kernel for KVM_SET_GSI_ROUTING doesn't mean that I can't patch it with an 
upstream kernel.  Would you prefer I remove the stack trace completely?
