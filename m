Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A04C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5FA21872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547169003;
	bh=44re3ioC46R04kd0jRgavTIfVGzneHy2eGIak4fexIM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QNRDEIwzEFZgsFzPrmhpKiOqZ6QF3yojr65Zv9bzeZBFCh8pJuFiAYTPNWxSfBe7f
	 lK+HP0N2FzSXh0Z5g3ciWhbV+4Mb/+3Fd0nmef5oo+1UKR+HCWdELelsDZO8oC2aTH
	 V8p8NeuE2K3HvJ3x9O+oP9UBnqzxW5mSgedYGTDc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbfAKBKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 20:10:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:45622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727682AbfAKBKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 20:10:02 -0500
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F051F2177E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 01:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547169001;
        bh=44re3ioC46R04kd0jRgavTIfVGzneHy2eGIak4fexIM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WCMFbsRfsvsxU2Kx8WCl9HeSXNd7gGMu8N+KZPpcgs+nnI0d81T3sUEdk0372T+Hp
         XWIUIoHVQWrQhN+V15xZKXieFcw8XAcU/cYEwHRue4JxNUtRZmkp+sa1OKdSvQLRCj
         tA7rYwUZrNGspZ6NJgrDhPPS90wbo9RWjzZJ67cI=
Received: by mail-wr1-f50.google.com with SMTP id t6so13395533wrr.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 17:10:00 -0800 (PST)
X-Gm-Message-State: AJcUukcNH0llvm75JCL7tRcya24ukHDBN/h3WwiNG3hcKdDELRGzeJaG
        rLhQHFFF7NMI9H+0YiW6XpIoRLi5C9n3Tn0UKlAyiw==
X-Google-Smtp-Source: ALg8bN4q1lgry3ZNwaD0S5aVtuFhhq91vTUSMC0mJXEkdVYIf1fas3y57LX/tzdrcBmejC03DeIuJ62xzcQkm2hfay8=
X-Received: by 2002:adf:f0c5:: with SMTP id x5mr10991838wro.77.1547168999346;
 Thu, 10 Jan 2019 17:09:59 -0800 (PST)
MIME-Version: 1.0
References: <20190103143227.9138-1-jlee@suse.com> <20190106181026.GA15256@amd>
 <20190107173743.GC4210@linux-l9pv.suse> <CALCETrWHjn_WN1WRc2pbFPB+H-ZL_1y=8dhhHoVqA53Q7Pj5vA@mail.gmail.com>
 <20190109163958.GG9503@linux-l9pv.suse> <CALCETrUprUNLci+tQ+P7PV3PvS4ruxz5jrGH3R_FDV4SFp3r9g@mail.gmail.com>
 <20190110151256.GN3599@linux-l9pv.suse>
In-Reply-To: <20190110151256.GN3599@linux-l9pv.suse>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 10 Jan 2019 17:09:46 -0800
X-Gmail-Original-Message-ID: <CALCETrU5qWzMSLxa28XHXBsg-gZwkxfzrqztTbBO+qcCYQbTMA@mail.gmail.com>
Message-ID: <CALCETrU5qWzMSLxa28XHXBsg-gZwkxfzrqztTbBO+qcCYQbTMA@mail.gmail.com>
Subject: Re: [PATCH 0/5 v2][RFC] Encryption and authentication for hibernate
 snapshot image
To:     joeyli <jlee@suse.com>, David Howells <dhowells@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        keyrings@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Ryan Chen <yu.chen.surf@gmail.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 7:13 AM joeyli <jlee@suse.com> wrote:
>
> On Wed, Jan 09, 2019 at 10:47:42AM -0800, Andy Lutomirski wrote:
> > On Wed, Jan 9, 2019 at 8:40 AM joeyli <jlee@suse.com> wrote:
> > >
> > > Hi Andy,
> > >
> > > Thanks for your review!
> > >
> > > On Tue, Jan 08, 2019 at 01:41:48PM -0800, Andy Lutomirski wrote:
> > > > > On Jan 7, 2019, at 9:37 AM, joeyli <jlee@suse.com> wrote:
> > > > >
> > > > > Hi Pavel,
> > > > >
> > > > > Thanks for your review!
> > > > >
> > > > >> On Sun, Jan 06, 2019 at 07:10:27PM +0100, Pavel Machek wrote:
> > > > >> Hi!
> > > > >>
> > > > >>> This patchset is the implementation of encryption and authentic=
ation
> > > > >>> for hibernate snapshot image. The image will be encrypted by AE=
S and
> > > > >>> authenticated by HMAC.
> > > > >>
> > > > >> Ok, so you encrypt.
> > > > >
> > > > > Yes, encryption and authentication.
> > > > >
> > > > >>> The hibernate function can be used to snapshot memory pages to =
an image,
> > > > >>> then kernel restores the image to memory space in a appropriate=
 time.
> > > > >>> There have secrets in snapshot image and cracker may modifies i=
t for
> > > > >>> hacking system. Encryption and authentication of snapshot image=
 can protect
> > > > >>> the system.
> > > > >>>
> > > > >>> Hibernate function requests the master key through key retentio=
n service.
> > > > >>> The snapshot master key can be a trusted key or a user defined =
key. The
> > > > >>> name of snapshot master key is fixed to "swsusp-kmk". User shou=
ld loads
> > > > >>> swsusp-kmk to kernel by keyctl tool before the hibernation resu=
me.
> > > > >>> e.g. The swsusp-kmk must be loaded before systemd-hibernate-res=
ume
> > > > >>
> > > > >> But if userspace has a key, encryption is useless against root.
> > > > >
> > > > > Yes, but this concern is not only for hibernation encryption. Thi=
s patch
> > > > > set does not provide solution against this concern.
> > > > >
> > > > > The purpose of this patch set is to encrypt and authenticate hibe=
rnate
> > > > > snapshot image in kernel space. It also requests key through keyr=
ing
> > > > > mechanism. Which means that we can easy to adapt to new key type =
from
> > > > > keyring in the future.
> > > > >
> > > > > Currently TPM trusted key or user defined key types are not again=
st
> > > > > root. Even using the TPM trusted key, it still can be unsealed by=
 root
> > > > > before the PCRs be capped (unless we capped PCRs in kernel).
> > > > >
> > > > > My solution for keeping the secret by kernel is the EFI secure ke=
y type:
> > > > >    https://lkml.org/lkml/2018/8/5/31
> > > > >
> > > > > But the EFI boot variable doesn't design for keeping secret, so W=
indows
> > > > > and OEM/ODM do not use boot variable to keep secret. So this idea=
 can
> > > > > not be accepted. We must think other key type against root.
> > > > >
> > > > >>> The TPM trusted key type is preferred to be the master key. But=
 user
> > > > >>> defined key can also be used for testing or when the platform d=
oesn't
> > > > >>> have TPM. User must be aware that the security of user key reli=
es on
> > > > >>> user space. If the root account be compromised, then the user k=
ey will
> > > > >>> easy to be grabbed.
> > > > >>
> > > > >> In the TPM case, does userland have access to the key?
> > > > >
> > > > > In the TPM case, userland can only touch the sealed key blob. So =
userland
> > > > > doesn't know the real secret. But it has risk that root unseals t=
he key
> > > > > before PCRs be capped.
> > > > >
> > > > >> Please explain your security goals.
> > > > >
> > > > > My security goals:
> > > > >
> > > > > - Encrypt and authicate hibernate snapshot image in kernel space.=
 Userspace
> > > > >  can only touch an encrypted and signed snapshot image.
> > > >
> > > > Signed?
> > > >
> > > > I=E2=80=99m not entirely convinced that the keyring mechanism is wh=
at you
> > > > want. ISTM that there are two goals here:
> > > >
> > > > a) Encryption: it should be as hard as can reasonably be arranged t=
o
> > > > extract secrets from a hibernation image.
> > > >
> > > > b) Authentication part 1: it should not be possible for someone in
> > > > possession of a turned-off machine to tamper with the hibernation
> > > > image such that the image, when booted, will leak its secrets. This
> > > > should protect against attackers who don=E2=80=99t know the encrypt=
ion key.
> > > >
> > > > c) Authentication part 2: it should be to verify, to the extent
> > > > practical, that the image came from the same machine and was really
> > > > created using hibernation.  Or maybe by the same user.
> > > >
> > > > For (a) and (b), using an AE mode where the key is protected in som=
e
> > > > reasonable way.  Joey, why are you using HMAC?  Please tell me you=
=E2=80=99re
> > > > at least doing encrypt-then-MAC.  But why not use a real AE mode li=
ke
> > > > AES-GCM?
> > >
> > > The reason for using HMAC is the history for development. My first pa=
tch
> > > set is only for hibernate authentication. Then I added encryption cod=
e on
> > > top of my authentication patches in last version.
> > >
> > > I am doing encrypt-then-MAC. My code ecrypts each page by AES then HM=
AC
> > > whole snapshot image. I feed encrypted data pages one by one to
> > > crypto_shash_update() API for calculating the hash for whole image.
> >
> > ...
> >
> > I think you should write down a clear description of the data format.
>
> Hibernation allocates free pages for building snapshot image. Those free
> pages are scattered in memory. So kernel marks those page numbers on a
> bitmap to locate them. Because this image buffer is discontinuous, so I
> use update mode hashing whole image.
>
> > A general problem with crypto is that the fact that it appears to work
> > doesn't mean it's secure at all, and it's very hard to follow the
> > code.  Especially in Linux using the crypto API -- code using the
> > crypto API tends to be mostly boilerplate.
> >
>
> hm... Do you mean that the implementation of HMAC in crypto cannot be
> trusted? I hope at least that I can trust the update mode for normal
> hash like SHA256 or SHA512?

No, I fully expect the crypto code to do what it says.  What I mean is
that you can easily create utterly broken things that involve crypto,
but they still work fine when you use then non-maliciously.

> > >
> > > Sorry for I didn't capture the meaning of "acceptable usage". The tru=
sted
> > > key already be unsealed by TPM when the key be enrolled by keyctl too=
l.
> > > So my code just extract the unsealed key data (the random number) for
> > > encryption.
> >
> > If someone creates a trusted key that is used for asymmetric crypto or
> > perhaps a trusted key that is intended to be used for, say, an HMAC
> > key, you should not also use it to derive hibernation keys.  This is
> > what I mean by "acceptable usage".
> >
>
> When keyring is producing encrypted key, the trusted key be used to
> derive the encrypt key and authenticate key to encrypt and hmac sign
> a encrypted key. So trusted key can be used in symmetric crypto.

Can it?

David, you actually understand the overall kernel keyring design.  Do
keys in the keyring have usage constraints?

But I think you need to take a big step back here.  We already have
kernel/power/user.c.  It seems to me that you can do a better job of
what you're trying to do with less code by using it.  Why do you need
new kernel code *at all* to accomplish your goals?
