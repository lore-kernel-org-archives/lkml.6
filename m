Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	TVD_PH_BODY_ACCOUNTS_PRE,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23345C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 00:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFFC620C0D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 00:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="eG+h1K3r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFFC620C0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbeHQDIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 23:08:40 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:48164 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726134AbeHQDIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 23:08:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1F3418EE171;
        Thu, 16 Aug 2018 17:07:33 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gD4jaibPaSAj; Thu, 16 Aug 2018 17:07:32 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 414B68EE092;
        Thu, 16 Aug 2018 17:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1534464452;
        bh=GA3f4TpRGp7oaXUKBNTvx4n/V9XfBRuMxQDcDNC7NAU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=eG+h1K3rPk5mCtTl4mrBcoIHsGTnnacWy6BedTYo7mseh7/Zw7dREXmuJuRKrcb3W
         zZMHElgehMWWZHXvxw274RSSL2OZEACEBFIYLj0Lc5ivugseSig8z14w+pYdsFZubh
         ihZFtUyoMz/a860qPIFYPmQbcQIHi0Ke2sLnEjso=
Message-ID: <1534464451.22442.1.camel@HansenPartnership.com>
Subject: Re: [PATCH] Fix kexec forbidding kernels signed with custom
 platform keys to boot
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vivek Goyal <vgoyal@redhat.com>, yannik@sembritzki.me,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Justin Forbes <jforbes@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>
Date:   Thu, 16 Aug 2018 17:07:31 -0700
In-Reply-To: <18926.1534451480@warthog.procyon.org.uk>
References: <1534435000.3166.9.camel@HansenPartnership.com>
         <1534432615.3166.5.camel@HansenPartnership.com>
         <CA+55aFzRHVXP4Ag4aygao1dTGaaMJZSOisHT2ks3_WP97kLLhQ@mail.gmail.com>
         <20180815100053.13609-1-yannik@sembritzki.me>
         <CA+55aFx2goMXj7rQg-qx-puiiWYJmkDMU1xniWEu6ikDBNgfdQ@mail.gmail.com>
         <654fbafb-69da-cd9a-b176-7b03401e71c5@sembritzki.me>
         <20180815174247.GB29541@redhat.com> <20180815185812.GC29541@redhat.com>
         <b2649b70-37b6-3929-a9d0-3d82033b2686@sembritzki.me>
         <20180815194932.GD29541@redhat.com>
         <20628.1534427487@warthog.procyon.org.uk>
         <30607.1534434597@warthog.procyon.org.uk>
         <18926.1534451480@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-16 at 21:31 +0100, David Howells wrote:
> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> 
> > As a step by step process, I agree.  However, I think we can
> > automate it to the point where you install a package and it says
> > "insert your yubikey" every time you upgrade the kernel
> 
> That's a very bad idea.  You train people to unlock their private key
> on request.  It can be abused like one of those emails that tells you
> that your account has been suspended - just follow the link and put
> in your password please.

It's exactly the same process those of us who use yubikeys for gpg or
ssh keys follow.  You insert your key, you activate the process that
needs the key, it asks for you to confirm your key, you press the
button and the operation gets performed.  Since it's what we as kernel
developers do, I don't see why it's a bad idea for others.

> Further, you expose the unlocked key on a machine that might be
> compromised.

No it doesn't; the point about using a yubikey (or any other HSM type
thing) is that the key is shielded inside the module so you get a
signature back and the key can't be compromised even if the machine is.

> > Mehmet's patches don't require building a new kernel.  They merely
> > require the added key be linked into the Red Hat built bzImage and
> > then the resulting blob be signed.  You can still identify that the
> > original bzImage is the Red Hat one.
> 
> No, you can't.  You might *think* that it is, but the signature
> you're checking is after the image has being fiddled with by the key-
> adder

Well, yes, you have to add a new signature to the combination. 
However, you can always verify that the hash without the added key is
the hash of the Red Hat supplied bzImage.

>  - and that means there's a window in which someone else can fiddle
> with the image too.

That window exists in any HSM system (including the kernel.org
yubikeys): if you can intercept my sending the authorization and hash
to be signed to the HSM, you can substitute your own hash and get back
a genuine signature over your bogus hash.  However, actually achieving
this requires a very sophisticated multi-layered attack.  I really
think if this is the level of attack you worry about then you probably
would use more sophisticated security than a yubikey.

> Mehmet's patches make sense from the reproducible kernel build PoV,
> but don't actually help with the security so much since they're
> replacing, say, a RH generated key with one you've generated locally,
> likely on the box that you don't necessarily trust.

That's why you'd use a yubikey or TPM to guard this key.  OK, I admit,
that's why I'd use one ... it's possible some users will use a simple
password protected key file and get hacked as a result.

> The bootloader would need to check the kernel image with the keys and
> the image with the keys stripped off.  And if you're doing that, it
> doesn't make sense to modify the kernel image, but rather load the
> keys separately, possibly by an initrd=-like option on the bootloader
> or in your initrd.

The reason it makes sense to add the key and resign the image is
because that's the part that's verified by secure boot, so the secure
boot system verifies and protects your added key.  The initrd is a bit
of a hole in our secure boot system because it's not signed and it can
be used to compromise the system.  However, if someone were to fix
that, absolutely you could pass the key in from a verified initrd.  I'm
also happy to add that mechanism now and hope that one day this
security hole gets plugged ...

> > > That's the problem is right there.  AIUI, we *don't* want to set
> > > up a third party signing process.  As I said, it potentially
> > > comes with lawyers attached.
> > 
> > Right so generate a business pressure to overcome the legal one.
> 
> No.  We *really* don't want to do this, and the legal reasons are
> minor ones like people suing us for GPL infringement[*] or because we
> said no.

So now you're telling me it's actually not a legal problem it's a
business process problem ... 

> The primary reason is that we aren't willing to just rubber stamp any
> old kernel module.  The signature is, in effect, a
> certification.  We'd be putting our name to something and we would
> want to be absolutely sure we know what it does, review all the
> sources and have thoroughly tested it internally - and we'd have to
> be willing to support it to some extent.  That takes a lot of
> resources - and also requires the module vendor to be willing to open
> up their sources to us.

OK, so I agree, depending on the level of assurance you want to give in
the signature that it's an effort.  However, the fact that Red Hat is
unwilling to undertake the effort yet still wants to claim security
based on module signatures means your only available policy is that
third party modules aren't allowed at all.  

What's wrong with simply telling users who want to get around this that
they have to build their own kernel?  Red Hat is definitely off the
hook in that case as well.  I know it's hard but surely you want to
deter customers from doing it.

> We also don't want to sign the keys of third party vendors because
> then we give away a certain degree of control over whatever they do
> with that, though we would have the option of blacklisting it - after
> the fact.

This would precisely mirror the reason why I don't trust the UEFI ODM
keys.

James


> [*] I've had people demand the transient private keys for Fedora
> kernels under
>     the GPL.  They didn't seem to like the answer that I couldn't
> give them
>     those keys because no one had them anymore; they seemed to think
> that this
>     in some way violated their rights under the GPL.


