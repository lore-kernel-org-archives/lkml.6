Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE28C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D58E2083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:29:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D58E2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932632AbeFTQ3I (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 12:29:08 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:42307 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932591AbeFTQ3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 12:29:04 -0400
Received: by mail-ot0-f195.google.com with SMTP id 92-v6so174079otw.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 09:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IqxI4iL3IByiHK0CZrD1v/9RGOgXeVjkF/MyYeAPiMo=;
        b=DsMbVtczYs/+RL1F2FWy1LBirNvpg62Tp+y+9x9VZrGD61AmmWdshE0dO7MY++weih
         0TurVj1XNxrvb9s7ycWNgFOYlG7TUzFPyqGD4XxlmFUsNkI2glmEEvNwdjteXPihPrv0
         7Jx5kyievS0EzzGPwx+4nLEyaprJKqHgmiBzzlZUJRkV/PiLt2st70MU7++2BpizPgvM
         KjcH6FXhMjTSQO/JWR4SEQkCFARsdN5Y5jn8U9S4HUHfLzVuQWFWbJXugb6Fo9OqB3az
         CZ/v7t6B6wUFlSj98MAzx+4vY00dKA7+lmcZB6Cu5naJM6H448iByneSXIKLEOtUqhrt
         vVLA==
X-Gm-Message-State: APt69E3RgT/rTgsx2E/fepg8eDLgrrMN8hoEiCE2g+2/cLElH1VYCKlw
        i2oNT1vgw8hIwNCZWd9+csd0YLs6EsPd/nIgkLYeJg==
X-Google-Smtp-Source: ADUXVKJLNzNu5fAyVAVNoaasBdJ0tTcZciVWP/hfzNrtubVV9OY0Qoa+yX8bQ4RKzVK7+A85tz2JjizHc9XcHU5g10o=
X-Received: by 2002:a9d:3126:: with SMTP id e35-v6mr14569973otc.340.1529512143781;
 Wed, 20 Jun 2018 09:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
 <20180608171216.26521-14-jarkko.sakkinen@linux.intel.com> <CALCETrW3aZJMMm1GqgPm-cOD3p7JvKxLj7j85KJwfNW2iHTj4A@mail.gmail.com>
 <CALCETrVp1ZhrxF5bQDSaZpLucS88tErejj5JC6Jb0fB5etWRbA@mail.gmail.com>
 <20180611115255.GC22164@hmswarspite.think-freely.org> <CALCETrX6SD0ThNzpjkbXd7CbNTguzqiQhWMomGK+tocx_DE9XQ@mail.gmail.com>
 <20180612174535.GE19168@hmswarspite.think-freely.org> <CALCETrV-4D-M2ap1EFHQiQerYf_XgwLmBAx5WMvcCUefOODjOA@mail.gmail.com>
In-Reply-To: <CALCETrV-4D-M2ap1EFHQiQerYf_XgwLmBAx5WMvcCUefOODjOA@mail.gmail.com>
From:   Nathaniel McCallum <npmccallum@redhat.com>
Date:   Wed, 20 Jun 2018 12:28:52 -0400
Message-ID: <CAOASepN9t3jF4ajfKLG_odTZddOvXjY_DqLQhRPWhJ-imtjkgg@mail.gmail.com>
Subject: Re: [intel-sgx-kernel-dev] [PATCH v11 13/13] intel_sgx: in-kernel
 launch enclave
To:     luto@kernel.org
Cc:     Neil Horman <nhorman@redhat.com>, jarkko.sakkinen@linux.intel.com,
        x86@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        intel-sgx-kernel-dev@lists.01.org, hpa@zytor.com,
        dvhart@infradead.org, tglx@linutronix.de, andy@infradead.org,
        Peter Jones <pjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As I understand it, the current policy models under discussion look like this:

1. SGX w/o FLC (not being merged) looks like this:
  Intel CPU => (Intel signed) launch enclave => enclaves

2. SGX w/ FLC, looks like this:
  Intel CPU => kernel => launch enclave => enclaves

3. Andy is proposing this:
  Intel CPU => kernel => enclaves

This proposal is based on the fact that if the kernel can write to the
MSRs then a kernel compromise allows an attacker to run their own
launch enclave and therefore having an independent launch enclave adds
only complexity but not security.

Is it possible to restrict the ability of the kernel to change the
MSRs? For example, could a UEFI module manage the MSRs? Could the
launch enclave live entirely within that UEFI module?

4. I am suggesting this:
  Intel CPU => UEFI module => enclaves

Under this architecture, the kernel isn't involved in policy at all
and users get exactly the same freedoms they already have with Secure
Boot. Further, the launch enclave can be independently updated and
could be distributed in linux-firmware. The UEFI module can also be
shared across operating systems. If I want to have my own enclave
policy, then I can build the UEFI module myself, with my
modifications, and I can disable Secure Boot. Alternatively,
distributions that want to set their own policies can build their own
UEFI module and sign it with their vendor key.
On Mon, Jun 18, 2018 at 5:59 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Tue, Jun 12, 2018 at 10:45 AM Neil Horman <nhorman@redhat.com> wrote:
> >
> > On Mon, Jun 11, 2018 at 09:55:29PM -0700, Andy Lutomirski wrote:
> > > On Mon, Jun 11, 2018 at 4:52 AM Neil Horman <nhorman@redhat.com> wrote:
> > > >
> > > > On Sun, Jun 10, 2018 at 10:17:13PM -0700, Andy Lutomirski wrote:
> > > > > > On Jun 9, 2018, at 10:39 PM, Andy Lutomirski <luto@kernel.org> wrote:
> > > > > >
> > > > > > On Fri, Jun 8, 2018 at 10:32 AM Jarkko Sakkinen
> > > > > > <jarkko.sakkinen@linux.intel.com> wrote:
> > > > > >>
> > > > > >> The Launch Enclave (LE) generates cryptographic launch tokens for user
> > > > > >> enclaves. A launch token is used by EINIT to check whether the enclave
> > > > > >> is authorized to launch or not. By having its own launch enclave, Linux
> > > > > >> has full control of the enclave launch process.
> > > > > >>
> > > > > >> LE is wrapped into a user space proxy program that reads enclave
> > > > > >> signatures outputs launch tokens. The kernel-side glue code is
> > > > > >> implemented by using the user space helper framework.  The IPC between
> > > > > >> the LE proxy program and kernel is handled with an anonymous inode.
> > > > > >>
> > > > > >> The commit also adds enclave signing tool that is used by kbuild to
> > > > > >> measure and sign the launch enclave. CONFIG_INTEL_SGX_SIGNING_KEY points
> > > > > >> to a PEM-file for the 3072-bit RSA key that is used as the LE public key
> > > > > >> pair. The default location is:
> > > > > >>
> > > > > >>  drivers/platform/x86/intel_sgx/sgx_signing_key.pem
> > > > > >>
> > > > > >> If the default key does not exist kbuild will generate a random key and
> > > > > >> place it to this location. KBUILD_SGX_SIGN_PIN can be used to specify
> > > > > >> the passphrase for the LE public key.
> > > > > >
> > > > > > It seems to me that it might be more useful to just commit a key pair
> > > > > > into the kernel.  As far as I know, there is no security whatsoever
> > > > > > gained by keeping the private key private, so why not make
> > > > > > reproducible builds easier by simply fixing the key?
> > > > >
> > > > > Having thought about this some more, I think that you should
> > > > > completely remove support for specifying a key. Provide a fixed key
> > > > > pair, hard code the cache, and call it a day. If you make the key
> > > > > configurable, every vendor that has any vendor keys (Debian, Ubuntu,
> > > > > Fedora, Red Hat, SuSE, Clear Linux, etc) will see that config option
> > > > > and set up their own key pair for no gain whatsoever.  Instead, it'll
> > > > > give some illusion of security and it'll slow down operations in a VM
> > > > > guest due to swapping out the values of the MSRs.  And, if the code to
> > > > > support a locked MSR that just happens to have the right value stays
> > > > > in the kernel, then we'll risk having vendors actually ship one
> > > > > distro's public key hash, and that will seriously suck.
> > > > >
> > > > If you hard code the key pair however, doesn't that imply that anyone can sign a
> > > > user space binary as a launch enclave, and potentially gain control of the token
> > > > granting process?
> > >
> > > Yes and no.
> > >
> > > First of all, the kernel driver shouldn't be allowing user code to
> > > launch a launch enclave regardless of signature.  I haven't gotten far
> > > enough in reviewing the code to see whether that's the case, but if
> > > it's not, it should be fixed before it's merged.
> > >
> > Ok, I agree with you here.
> >
> > > But keep in mind that control of the token granting process is not the
> > > same thing as control over the right to launch an enclave.  On systems
> > > without the LE hash MSRs, Intel controls the token granting process
> > > and, barring some attack, an enclave that isn't blessed by Intel can't
> > > be launched.  Support for that model will not be merged into upstream
> > > Linux.  But on systems that have the LE hash MSRs and leave them
> > > unlocked, there is effectively no hardware-enforced launch control.
> > > Instead we have good old kernel policy.  If a user wants to launch an
> > > enclave, they need to get the kernel to launch the enclave, and the
> > > kernel needs to apply its policy.  The patch here (the in-kernel
> > > launch enclave) has a wide-open policy.
> > >
> >
> > Right, also agree here.  Systems without Flexible Launch Control are a
> > non-starter, we're only considering FLC systems here
> >
> > > So, as a practical matter, if every distro has their own LE key and
> > > keeps it totally safe, then a system that locks the MSRs to one
> > > distro's key makes it quite annoying to run another distro's intel_sgx
> > > driver, but there is no effect on the actual security of the system.
> > >
> > I agree that for systems that firmware-lock the msrs are annoying, but I would
> > think that IHV's would want to keep those msrs unlocked specifically to allow a
> > wide range of distributions to use this feature.
> >
> > As for benefits to security, I think there are some.  Namely, by leaving the
> > MSRS unlocked, A distribution can, rather than providing their own distirbution
> > key, pass the root of trust on to the end user.  I can easily envision a
> > downstream customer that wants to use SGX, and do so in such a way that they are
> > assured that their OS vendor doesn't have the ability to run an LE on their
> > system (at least not without the visual cue of specifying a different key hash
> > at the OS boot).
>
> Which achieves what, exactly?  The launch public key hash isn't the
> root of trust of anything except for a really awkward mechanism to
> limit the enclaves that get run.  If there is actual demand to limit
> enclaves that get run, let's do it correctly: add some code in the
> kernel that enforces a policy before launching an enclave.
>
> If the MSRs are unlocked, there is no stronger guarantee available
> even if you supply your own custom LE.  If the kernel is owned, the
> attacker can just change the MSRs.
>
> --Andy
