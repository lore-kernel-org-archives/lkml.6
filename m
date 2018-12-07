Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AF2C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C5DC20838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="OyaEqc9r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C5DC20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbeLGXeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 18:34:13 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35900 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbeLGXeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 18:34:12 -0500
Received: by mail-wm1-f65.google.com with SMTP id a18so6055428wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 15:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gxymz6Nr3+iGhNBx9iWU3Z6j+UHaoTAXjZ89bKtXPeE=;
        b=OyaEqc9rpaEVk6cc64niqkqfP4XEG5D3brZWHl5OlbbBYNvm21VuSWbvkLwr4PA6sf
         zoYYqdkBQkzX9vpV+Lc4jBTK9CXjftrCsznhpoqplvwkINiNa1MyMoinl9+fFTzVcNMg
         ZS6lt9zRzB6H3aFtxGsBqeRML6NTyEHBhwgJNvNAN6+tKv1zJc+6bu22NXOAogC3FwIG
         tZXU84j5VXkKIuxqKePaeYhaKQ0RDBEkwmsYyFXNK5pAqo3cBxQeakMiMbi2kYfcXPNL
         Ty4XMeE1/WaJAi3e444J8R//H9SlI4qQN8oFtAVOEymgeMV/BNod3xw67LmzmGzfkbGR
         Xz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gxymz6Nr3+iGhNBx9iWU3Z6j+UHaoTAXjZ89bKtXPeE=;
        b=AbqX4xZfhvzovq5Acg1wwweVdm99duQJhfxxeTRkGTkorC3CcmsWKccTZylTwJbd6F
         q3cMM1GRm9/xJ/EasBpUSoWeVGls5V0WSUvzqdBUkeiomX8pX10PeU0JZkQ2Q4X67ItY
         kaQeqrhvGcytiTmtihTy0MVD1oq6gRCj7xD06R5u5p2C/G54FylABouTQjQS45IH2d2f
         05GRczrM+2Ru0riAPXJocTSolze7hdp2cwf8Nlk6QInDbd4Zu7qcyvszBWS0BActQT89
         9i+33Abmljf3Vlcdd8Ow5t0KK8XgPJmYXGn9t/z3CXHKqgFMVDU4kLmqcReix6tmxUHZ
         A7fg==
X-Gm-Message-State: AA+aEWZUTr/TM4yM8RzB4Il5aR6h6OPVzASErP92E3cxS81AT81PzIZ8
        PTRebCI3ToHYi/YT6WfNWFxPD0+XTO4iPVpRxgro/Q==
X-Google-Smtp-Source: AFSGD/UKR/I8BgxUpKyTmIR131dtGfqxxnF/+sWrj3L7oZbaXSRwDunEGOcqiFJDg+qYXwnLTiegdj5PNizywlTbfkE=
X-Received: by 2002:a7b:ce17:: with SMTP id m23mr4053076wmc.74.1544225649529;
 Fri, 07 Dec 2018 15:34:09 -0800 (PST)
MIME-Version: 1.0
References: <20181206221922.31012-1-sean.j.christopherson@intel.com>
 <20181206221922.31012-5-sean.j.christopherson@intel.com> <CALCETrXRJ645=08fyeoMQ949fLB1TvhsgERFVx5mAHdViEjq8Q@mail.gmail.com>
 <20181207165145.GB10404@linux.intel.com> <CALCETrVkEW82PzQZhJ5iS849DLY1gbd8YjH5F7P1J7hgjkjiOQ@mail.gmail.com>
 <20181207190257.GC10404@linux.intel.com> <EFA99261-BE93-49DA-9A8F-E6FD28069AFC@amacapital.net>
 <20181207200935.GE10404@linux.intel.com> <4CEB5945-9562-40FA-8CCA-A1675D55B001@amacapital.net>
 <20181207212649.GG10404@linux.intel.com>
In-Reply-To: <20181207212649.GG10404@linux.intel.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Fri, 7 Dec 2018 15:33:57 -0800
Message-ID: <CALCETrVBR+2HjTqX=W4r9GOq69Xg36v4gmCKqK0wUjzAqBJnrw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/4] x86/vdso: Add __vdso_sgx_enter_enclave() to
 wrap SGX enclave transitions
To:     "Christopherson, Sean J" <sean.j.christopherson@intel.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-sgx@vger.kernel.org, haitao.huang@linux.intel.com,
        Jethro Beekman <jethro@fortanix.com>,
        "Dr. Greg Wettstein" <greg@enjellic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 7, 2018 at 1:26 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Fri, Dec 07, 2018 at 12:16:59PM -0800, Andy Lutomirski wrote:
> >
> >
> > > On Dec 7, 2018, at 12:09 PM, Sean Christopherson <sean.j.christophers=
on@intel.com> wrote:
> > >
> > >> On Fri, Dec 07, 2018 at 11:23:10AM -0800, Andy Lutomirski wrote:
> > >>
> > >> Ah, I see. You=E2=80=99re saying that, if the non-enclave stare is c=
orrupted such
> > >> that RIP  is okay and RSP still points somewhere reasonable but the =
return
> > >> address is garbage, then we can at least get to the fault handler an=
d print
> > >> something?
> > >
> > > Yep.  Even for something more subtle like GPR corruption it could dum=
p the
> > > entire call stack before attempting to return back up.
> > >
> > >> This only works if the fault handler pointer itself is okay, though,=
 which
> > >> somewhat limits the usefulness, given that its pointer is quite like=
ly to
> > >> be on the stack very close to the return address.
> > >
> > > Yeah, it's not a silver bullet by any means, but it does seem useful =
for at
> > > least some scenarios.  Even exploding when invoking the handler inste=
ad of
> > > at a random point might prove useful, e.g. "calling my exit handler e=
xploded,
> > > maybe my enclave corrupted the stack!".
> >
> > Here=E2=80=99s another idea: calculate some little hash or other checks=
um of
> > RSP, RBP, and perhaps a couple words on the stack, and do:
>
> Corrupting RSP and RBP as opposed to the stack memory seems much less
> likely since the enclave would have to poke into the save state area.
> And as much as I dislike the practice of intentionally manipulating
> SSA.RSP, preventing the user from doing something because we're "helping"
> doesn't seem right.
>
> > call __vdso_enclave_corrupted_state
> >
> > If you get a mismatch after return. That function could be:
> >
> > call __vdso_enclave_corrupted_state:
> >   ud2
> >
> > And now the debug trace makes it very clear what happened.
> >
> > This may or may not be worth the effort.
>
> Running a checksum on the stack for every exit doesn't seem like it'd
> be worth the effort, especially since this type of bug should be quite
> rare, at least in production environments.
>
> If we want to pursue the checksum idea I think the easiest approach
> would be to combine it with an exit_handler and do a simple check on
> the handler.  It'd be minimal overhead in the fast path and would flag
> cases where invoking exit_handle() would explode, while deferring all
> other checks to the user.

How about this variant?

#define MAGIC 0xaaaabbbbccccddddul
#define RETADDR_HASH ((unsigned long)__builtin_return_address(0) ^ MAGIC)

void foo(void)
{
    volatile unsigned long hash =3D RETADDR_HASH;

    /* placeholder for your actual code */
    asm volatile ("nop");

    if (hash !=3D RETADDR_HASH)
        asm volatile ("ud2");
}

But I have a real argument for dropping exit_handler: in this new age
of Spectre, the indirect call is a retpoline, and it's therefore quite
slow.  So I'm not saying NAK, but I do think it's unnecessary.

I don't suppose you've spent a bunch of time programming in the
continuation-passing style? :)
