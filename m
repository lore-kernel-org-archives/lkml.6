Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,TVD_PH_BODY_ACCOUNTS_PRE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2790C43615
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 15:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9509121890
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 15:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9509121890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbeHQSqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 14:46:35 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36604 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbeHQSqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 14:46:34 -0400
Received: by mail-oi0-f67.google.com with SMTP id n21-v6so14725863oig.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 08:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PDc3dbjZ/o6jn/3e5JtXz3r3JdhYhDn8vuvR1esgOXs=;
        b=RuoMFlUA1rY+okrwluBqDcU7CjSSEJmwIoQWRYqjK32Pz0n3SwcAkHj7usSj76z9ZF
         g0CyGcHPztNrGUMrzF6hYNCmMLHsPBrXz+QsVfqXqbmuUXucezozW5TUyF88mj1OppEY
         WIdSZAucJW7QCBbyR//v/KUBmC5MFTfq2JFf3gz4cQvNGTnMTGC/Gktbw2OOfa14IQmh
         x1XkpudV9sEgbW9cZsEUL3//Z0CuRQyAWwek6HnE6+VFgsuUxWHEJ37k5FtLl3yQYNyF
         Abdu3gNmrWcfKzFDCjYWv2XalH2s6dbGzN4ONzLK0U8l3ANVkQeweTn4Lo2W7odtwlvb
         gB4w==
X-Gm-Message-State: AOUpUlFq9VOGvr4pnQ+C5ll2FBBwmZ8Oww7pI5AJYP1Ao8gUYtCUqhLW
        pz7lcHohf/W+4byqbloqTsIVBX029S5u4JklvJXgiw==
X-Google-Smtp-Source: AA+uWPw1k+HOwMh8xM2x60F5N9/TyBirdWkcgpAy489R8WWyFCMIr7JNgjMvsrgF881/UMhpOEQz3xWdC59vkGb99l4=
X-Received: by 2002:aca:ea05:: with SMTP id i5-v6mr2875609oih.60.1534520558631;
 Fri, 17 Aug 2018 08:42:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:1211:0:0:0:0:0 with HTTP; Fri, 17 Aug 2018 08:42:37
 -0700 (PDT)
In-Reply-To: <1534517883.3994.9.camel@HansenPartnership.com>
References: <1534464451.22442.1.camel@HansenPartnership.com>
 <1534435000.3166.9.camel@HansenPartnership.com> <1534432615.3166.5.camel@HansenPartnership.com>
 <CA+55aFzRHVXP4Ag4aygao1dTGaaMJZSOisHT2ks3_WP97kLLhQ@mail.gmail.com>
 <20180815100053.13609-1-yannik@sembritzki.me> <CA+55aFx2goMXj7rQg-qx-puiiWYJmkDMU1xniWEu6ikDBNgfdQ@mail.gmail.com>
 <654fbafb-69da-cd9a-b176-7b03401e71c5@sembritzki.me> <20180815174247.GB29541@redhat.com>
 <20180815185812.GC29541@redhat.com> <b2649b70-37b6-3929-a9d0-3d82033b2686@sembritzki.me>
 <20180815194932.GD29541@redhat.com> <20628.1534427487@warthog.procyon.org.uk>
 <30607.1534434597@warthog.procyon.org.uk> <18926.1534451480@warthog.procyon.org.uk>
 <28088.1534494293@warthog.procyon.org.uk> <1534517883.3994.9.camel@HansenPartnership.com>
From:   Justin Forbes <jforbes@redhat.com>
Date:   Fri, 17 Aug 2018 10:42:37 -0500
Message-ID: <CAFbkSA2qijHeycF7k4Bg0ePxdxj5nLX4CnXnbuqDzm6A0=2bUQ@mail.gmail.com>
Subject: Re: [PATCH] Fix kexec forbidding kernels signed with custom platform
 keys to boot
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vivek Goyal <vgoyal@redhat.com>, yannik@sembritzki.me,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 9:58 AM, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> On Fri, 2018-08-17 at 09:24 +0100, David Howells wrote:
>> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
>>
>> > > > As a step by step process, I agree.  However, I think we can
>> > > > automate it to the point where you install a package and it
>> > > > says "insert your yubikey" every time you upgrade the kernel
>> > >
>> > > That's a very bad idea.  You train people to unlock their private
>> > > key on request.  It can be abused like one of those emails that
>> > > tells you that your account has been suspended - just follow the
>> > > link and put in your password please.
>> >
>> > It's exactly the same process those of us who use yubikeys for gpg
>> > or ssh keys follow.  You insert your key, you activate the process
>> > that needs the key, it asks for you to confirm your key, you press
>> > the button and the operation gets performed.  Since it's what we as
>> > kernel developers do, I don't see why it's a bad idea for others.
>>
>> You've completely missed the point.
>>
>> You need to think from the PoV of an ordinary user.  Imagine the
>> system does an automatic upgrade and wants to upgrade the kernel.  It
>> pops up a dialogue box saying "please put in your yubikey and enter
>> your password here"[**].  It might do this on a regular basis - and
>> you can be sure that some users at least will become accustomed to
>> just doing this when their computer tells them too.  *That* is the
>> problem.
>
> I was assuming the kernel would get pinned, so when the system
> automatically updates it installs everything else but tells you you
> have to do the kernel manually.  Presumably installing the add your own
> key package would do this.
>
> The point I'm making isn't that everything will just magically work,
> it's that we can design a process for a user to update a distro kernel
> while installing their own key.  I'm sure you can imagine hundreds of
> bad processes that encourage wrong behaviour, but the realistic answer
> is we just wouldn't use them.
>
>
>> Now they follow a link to a dodgy website that causes some code to be
>> downloaded and run.  *It* now pops up a dialogue box that looks
>> exactly like the kernel installer's dialogue that says "please put in
>> your yubikey and enter your password here".  But now we've trained
>> those users to do this on demand...
>>
>> PEBKAC[*].
>>
>> [*] Note that I'm not trying to slight ordinary users here, it's more
>> a fact
>>     of psychology.  As a distribution, it's our responsibility to try
>> and
>>     protect them as best we can - and training them to unthinkingly
>> bypass the
>>     security mechanisms isn't in anyone's best interests.
>>
>> [**] Note also that I've never actually used a yubikey[***], so I'm
>> not sure
>>      whether it takes a password or has some other mechanism to
>> unlock the
>>      key.
>>
>> [***] We also don't want to require that someone buys and keeps track
>> of a
>>       yubikey to be able to use, say, the NVidia driver with
>> Fedora/RHEL.
>>       Using the TPM if installed would be preferable because it's
>> harder to
>>       lose.
>
> I'm perfectly happy to use the TPM as well, and to help design
> processes around it (although I think we'll need both yubikey and TPM).
>  I also have to confess whenever I say yubikey in the context of kernel
> processes I'm making the caveat that everyone else uses a yubikey but I
> use my TPM based keys.
>
>> We also don't necessarily want to encourage ordinary users to fiddle
>> with the system key databases unless they really know what they are
>> doing.  There've been cases where doing this has bricked a machine
>> because the BIOS is buggy. Now I will grant, since you'll probably
>> raise it if I don't;-), that this might be a good reason *for* having
>> our own third party signing key as we could then build the key into
>> our kernels.
>>
>> But if they use a yubikey, they have to get the public key from there
>> into the system key list or possibly the yubikey has to be accessed
>> by the bootloader. The same for the TPM.
>
> For security reasons, a Yubikey should only be connected when you need
> it to sign something.  The TPM you can assume is always available.
>
This is absolutely correct, the important word here being *should*.
The reality is, with weekly kernel updates and various uses of the
Yubikey, the average user is just going to leave it connected. We can
lay out best practices all we want, but it seems pretty obvious that
most users go with convenient or default.  I really wish we could
change that, but it is unlikely.  As a result, we have to make the
convenient or default path also fairly secure.

>> > > Further, you expose the unlocked key on a machine that might be
>> > > compromised.
>> >
>> > No it doesn't; the point about using a yubikey (or any other HSM
>> > type thing) is that the key is shielded inside the module so you
>> > get a signature back and the key can't be compromised even if the
>> > machine is.
>>
>> Yes, you do.  Note that I don't mean necessarily exposing the actual
>> key material, but you do have to make it available for use - which
>> means someone can then use it and there's a window in which it is
>> available for that use. If there wasn't, it would be useless.
>
> Right so it's the byzantine exploit window shared by all HSMs
> (interception between authorization and use).  We take that risk in our
> kernel development security model because we think it's reasonably low
> ... the same is true for this use case.
>
>> > > No, you can't.  You might *think* that it is, but the signature
>> > > you're checking is after the image has being fiddled with by the
>> > > key-adder
>> >
>> > Well, yes, you have to add a new signature to the combination.
>> > However, you can always verify that the hash without the added key
>> > is the hash of the Red Hat supplied bzImage.
>>
>> At what point would you do this?  You have to assume that your
>> userspace tools can be compromised unless they are also verified
>> (signature/IMA).  No, this needs to be done by the bootloader.
>
> ? THe kernel is verified by the signature over the whole, which is
> bzImage plus new key; that's all the security the system needs.  The
> only verification needed of the original RH bzImage is presumably for
> Red Hat to confirm support or some forensic diagnostic ... it's not a
> security relevant thing.
>
>> Sometimes I feel I've spent too much time talking to people about
>> security and their paranoia is rubbing off... ;-)
>
> When dealing with security people the trick is to separate reasonable
> from unreasonable paranoia ...
>
> James
>
