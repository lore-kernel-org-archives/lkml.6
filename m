Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9095C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 930462081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wmbqrhab"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 930462081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbeJaBpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 21:45:23 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:54644 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbeJaBpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 21:45:23 -0400
Received: by mail-it1-f195.google.com with SMTP id d6so8962850itl.4;
        Tue, 30 Oct 2018 09:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xbJZ0jBQRAT1UWNJTqYZCeGU/7QDoqBNuoSoR3iB0OQ=;
        b=WmbqrhabceHBp4QLjP0T6XkAWJ0IZ8la+kDj8ZvX1CCK5oSRlcbYC9pOEQ8xtvd7kE
         HYtE8WkpfIdQnZOEcBoLXZlWJD/3bQRs4xMyG3dgl+rSaNjYeBQKq9fJVD4bzlOG2nJc
         68TRxLw2EGPjhzBXl3M0seMzJfaFZz7Nmi3O5AzMoWG7pTM51vPABbQdLIu61DUSRSVV
         gDGCqUHNWqfC7wtXVLHc3TqEdPkVV19SE+u+Ap3su+Edh4GcYVNQ4Hzwx59HuQ6lx7J+
         irNlX3lql5vA9gdVeMH4forGbdhHp/ZIS6zH8bKGO5WhEyzHd+SQeACEte9sUaIBwQeK
         m0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xbJZ0jBQRAT1UWNJTqYZCeGU/7QDoqBNuoSoR3iB0OQ=;
        b=CaTPeOPbmn2/H/znh5MVPEnef4Mge/qnN6tSLnZD5tL8zS80j68KXvaQYlquetg4B4
         XjB7mSjNBrnmf76XVw7fmEWm4zsLRHBhHPW7AGFaWJNleRLJvBWGYPE0vPaXIklnaKbW
         GeVrpJHESlS04Ja1h6Il82T65UF+gHQA6Yz+M7QELcatX01crAd+MFGDjpT8z9VibKCI
         4qZxOP/OZA8ncHPKjHIhZ9YfB8ivMhjU40eqBXHM+BOejZYdeEGgIso48MUKq8fmuvbJ
         mcc7wxJpAvs+3ENXWJLSJI4fSElHqFYUnK55BUWW75QOFMA2ayxII12UrPLz/OZSR5L4
         Ez+A==
X-Gm-Message-State: AGRZ1gJQBgb61Ng9Gjj+QqI6sjf66iDtZKABSnBWcuU6W8YCWx85d0SQ
        ilQyUE3v+Es9iy2a+zFPNyZm7c4VoIxbvFITKaE=
X-Google-Smtp-Source: AJdET5dTOI31dORLHX6nLPycN+e6U3P91g9jty0cXL0rT2RHqB5c0fpscozinN6Fb8cISz4raj36vkL99dwtJdbcITk=
X-Received: by 2002:a24:59c1:: with SMTP id p184-v6mr1986241itb.93.1540918267830;
 Tue, 30 Oct 2018 09:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20181026151223.16810-1-ahmedsoliman0x666@gmail.com> <20181029064640.GE128403@gmail.com>
In-Reply-To: <20181029064640.GE128403@gmail.com>
From:   Ahmed Soliman <ahmedsoliman0x666@gmail.com>
Date:   Tue, 30 Oct 2018 18:49:35 +0200
Message-ID: <CAAGnT3atejrUi6ypZPiDCtMVUP6vx51sKkc2yeQg0SF8-kra8w@mail.gmail.com>
Subject: Re: [PATCH V5 0/5] KVM: X86: Introducing ROE Protection Kernel Hardening
To:     mingo@kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        nathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?6rmA7J246rK4?= <ovich00@gmail.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        nigel.edwards@hpe.com, Boris Lukashev <blukashev@sempervictus.com>,
        Hossam Hassan <7ossam9063@gmail.com>,
        Ahmed Lotfy <A7med.lotfey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Oct 2018 at 08:46, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ahmed Abd El Mawgood <ahmedsoliman0x666@gmail.com> wrote:
>
> > This is the 5th version which is 4th version with minor fixes. ROE is a
> > hypercall that enables host operating system to restrict guest's access to its
> > own memory. This will provide a hardening mechanism that can be used to stop
> > rootkits from manipulating kernel static data structures and code. Once a memory
> > region is protected the guest kernel can't even request undoing the protection.
> >
> > Memory protected by ROE should be non-swapable because even if the ROE protected
> > page got swapped out, It won't be possible to write anything in its place.
> >
> > ROE hypercall should be capable of either protecting a whole memory frame or
> > parts of it. With these two, it should be possible for guest kernel to protect
> > its memory and all the page table entries for that memory inside the page table.
> > I am still not sure whether this should be part of ROE job or the guest's job.
> >
> >
> > The reason why it would be better to implement this from inside kvm: instead of
> > (host) user space is the need to access SPTEs to modify the permissions, while
> > mprotect() from user space can work in theory. It will become a big performance
> > hit to vmexit and switch to user space mode on each fault, on the other hand,
> > having the permission handled by EPT should make some remarkable performance
> > gain.
> >
> > Our model assumes that an attacker got full root access to a running guest and
> > his goal is to manipulate kernel code/data (hook syscalls, overwrite IDT ..etc).
> >
> > There is future work in progress to also put some sort of protection on the page
> > table register CR3 and other critical registers that can be intercepted by KVM.
> > This way it won't be possible for an attacker to manipulate any part of the
> > guests page table.
>
> BTW., transparent detection and trapping of attacks would also be nice:
> if ROE is active and something running on the guest still attempts to
> change the pagetables, the guest should be frozen and a syslog warning on
> the hypervisor side should be printed?

I was thinking about logging ROE violations to host's kernel logs too
and I will have it in the next
version of the patch set, but I am not sure if we should really freeze
the guest once a violation
happens, I wanted to completely isolate the mechanism from the policy.
In the current implementation,
the policy followed  is left to users pace host process using kvm. It
will be notified about a Memory IO
error in the guest, and the guest will be waiting for the host to take
actions (vmexit). Of course the
simplest action shall be "do nothing", so the writing operation will
fail but the guest continues to run, or it
can freeze the guest, or maybe do something advanced like cloning the
vm and disconnecting network
interface from the cloned vm, then enable the write operation and keep
track of what is going on somehow.
Because of the many varieties of possible reactions, we decided to
keep the them out of KVM and just let the
user space process decide how should the situation be handled.

> Also, the feature should probably be 'default y' to help spread it on the
> distro side. It's opt-in functionality from the guest side anyway, so
> there's no real cost on the host side other than some minor resident
> memory.

Noted, I will have it `default y` in the next patches set.

Thanks,
Ahmed
