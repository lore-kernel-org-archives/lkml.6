Return-Path: <luto@kernel.org>
X-Google-Smtp-Source: AB8JxZrr2pqI/qqtO6T4XpI+EK052CiHoJA1ZVr/Al6P5CzIGTTzBLksnWP2XObDTBrtBffVKFLR
ARC-Seal: i=1; a=rsa-sha256; t=1525386919; cv=none;
        d=google.com; s=arc-20160816;
        b=Vy6CBRGGSGJTJn2Zsy0Yz+mXkWg+r/7arcafLrScJzYqn23LDR1v1MfzIR+JlvW/9L
         fFDJur/JBpTcTePTW+fummP5PlPQhGIu1bZ1UF8YdayPDZUpu9oIZvvYh4K9391dqoi+
         1ebMuNWB3fwaMtGGVwu+kc6OP6S9Pt4bo5NJXPf3KwCt3Oew3wm/E3R03SbY21xcjbAu
         liM7cwK8SbkUOcvaJ1KcSnBceWCiuMjIq2qZC6DL46GVPlOaICw4o7kCpZdzRuBLsIYg
         uO6UV7eErjiHUjAB+OrjCii4jAdjyJk5bKdVZS2HkSOnXPAXmDitykuRBFzSRnh1bE3d
         y/sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=c0NdqqaXkkuQU5i1TY2kfitFQtV++r6BSbqh+k1qgzc=;
        b=pK5PTHCQ0zoRDHFAWnrTssK/3QYR/xOQHWJCbba5izXqWiEkyFfdWmcV8GhOwXcHnz
         RGdeidQSSzudx7BRKJr6Aq0dMRgnBGCOqT27/FcUJXjGcpmUe2DAjA9Trj1KEClS7m1B
         UHzgSVd+66zT9WwDyZJzvt9RDz1su6r5kcgm6Z7X4pemiJCSompJ5C2ekLJw68G0xIfx
         ynw77jm8luTDYLUR94sUra/bGA5mkJxxJ9nXd43r/UoZrtNZC6Xr9NTaQT8KZXFfr25Q
         wy3ml0e08FKq8MDJ2GKN+qVVUfOJ5Pk/4vdUGhx+YBdKw4I+NwinHeELNRoJiOVDT9km
         aWfw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=DRJHv6HQ;
       spf=pass (google.com: domain of luto@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=luto@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=DRJHv6HQ;
       spf=pass (google.com: domain of luto@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=luto@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
MIME-Version: 1.0
References: <20180429093558.5411-1-hdegoede@redhat.com> <20180429093558.5411-3-hdegoede@redhat.com>
 <CALCETrXDrcxyESajDZs3L7sAAfDXXc_CUzy5nUZxLPxaTHZ80g@mail.gmail.com>
 <59023265-bfca-fe5d-e047-4c69404a0dd1@redhat.com> <20180503223126.GE27853@wotan.suse.de>
In-Reply-To: <20180503223126.GE27853@wotan.suse.de>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 03 May 2018 22:35:07 +0000
X-Gmail-Original-Message-ID: <CALCETrXRVMhjdepkkhSKtV4s1A4uhVe_ANetbgTtwcM9jf_5YQ@mail.gmail.com>
Message-ID: <CALCETrXRVMhjdepkkhSKtV4s1A4uhVe_ANetbgTtwcM9jf_5YQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] efi: Add embedded peripheral firmware support
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Andrew Lutomirski <luto@kernel.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>, Greg KH <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Peter Jones <pjones@redhat.com>, dave@bewaar.me, Will Deacon <will.deacon@arm.com>,
	Matt Fleming <matt@codeblueprint.co.uk>, David Howells <dhowells@redhat.com>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>, Josh Triplett <josh@joshtriplett.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Martin Fuzzey <mfuzzey@parkeon.com>,
	Kalle Valo <kvalo@codeaurora.org>, Arend Van Spriel <arend.vanspriel@broadcom.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, Nicolas Broeking <nbroeking@me.com>,
	Bjorn Andersson <bjorn.andersson@linaro.org>, duwe@suse.de,
	Kees Cook <keescook@chromium.org>, X86 ML <x86@kernel.org>,
	linux-efi <linux-efi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	LSM List <linux-security-module@vger.kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599072709046551146?=
X-GMAIL-MSGID: =?utf-8?q?1599484114615687532?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 3, 2018 at 3:31 PM Luis R. Rodriguez <mcgrof@kernel.org> wrote:

> On Wed, May 02, 2018 at 04:49:53PM +0200, Hans de Goede wrote:
> > Hi,
> >
> > On 05/01/2018 09:29 PM, Andy Lutomirski wrote:
> > > On Sun, Apr 29, 2018 at 2:36 AM Hans de Goede <hdegoede@redhat.com>
wrote:
> > > > +The EFI embedded-fw code works by scanning all
EFI_BOOT_SERVICES_CODE
> > > memory
> > > > +segments for an eight byte sequence matching prefix, if the prefix
is
> > > found it
> > > > +then does a crc32 over length bytes and if that matches makes a
copy of
> > > length
> > > > +bytes and adds that to its list with found firmwares.
> > > > +
> > >
> > > Eww, gross.  Is there really no better way to do this?
> >
> > I'm afraid not.
> >
> > >  Is the issue that
> > > the EFI code does not intend to pass the firmware to the OS but that
it has
> > > a copy for its own purposes and that Linux is just going to hijack
EFI's
> > > copy?  If so, that's brilliant and terrible at the same time.
> >
> > Yes that is exactly the issue / what it happening here.
> >
> > >
> > > > +       for (i = 0; i < size; i += 8) {
> > > > +               if (*((u64 *)(mem + i)) != *((u64 *)desc->prefix))
> > > > +                       continue;
> > > > +
> > > > +               /* Seed with ~0, invert to match crc32 userspace
utility
> > > */
> > > > +               crc = ~crc32(~0, mem + i, desc->length);
> > > > +               if (crc == desc->crc)
> > > > +                       break;
> > > > +       }
> > >
> > > I hate to play the security card, but this stinks a bit.  The kernel
> > > obviously needs to trust the EFI boot services code since the EFI boot
> > > services code is free to modify the kernel image.  But your patch is
not
> > > actually getting this firmware blob from the boot services code via
any
> > > defined interface -- you're literally snarfing up the blob from a
range of
> > > memory.  I fully expect there to be any number of ways for
untrustworthy
> > > entities to inject malicious blobs into this memory range on quite a
few
> > > implementations.  For example, there are probably unauthenticated EFI
> > > variables and even parts of USB sticks and such that get read into
boot
> > > services memory, and I see no reason at all to expect that nothing in
the
> > > so-called "boot services code" range is actually just plain old boot
> > > services *heap*.
> > >
> > > Fortunately, given your design, this is very easy to fix.  Just
replace
> > > CRC32 with SHA-256 or similar.  If you find the crypto api too ugly
for
> > > this purpose, I have patches that only need a small amount of dusting
off
> > > to give an entirely reasonable SHA-256 API in the kernel.
> >
> > My main reason for going with crc32 is that the scanning happens before
> > the kernel is fully up and running (it happens just before the
rest_init()
> > call in start_kernel() (from init/main.c) I'm open to using the
> > crypto api, but I was not sure if that is ready for use at that time.

> Not being sure is different than being certain. As Andy noted, if that
does
> not work please poke Andy about the SHA-256 API he has which would enable
> its use in kernel.

Nah, don't use the cryptoapi for this.  You'll probably regret it for any
number of reasons.  My code is here:

https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=crypto/sha256_bpf&id=e9e12f056f2abed50a30b762db9185799f5864e6

and its two parents.  It needs a little bit of dusting and it needs
checking that all combinations of modular and non-modular builds work.  Ard
probably has further comments.


> Right now this is just a crazy hack for *2* drivers. Its a lot of hacks
for
> just that, so no need to rush this in just yet. It seems unclear if we're
> all happy with this yet as well.

Fair enough.
