Return-Path: <mka@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1522718791; cv=none;
        d=google.com; s=arc-20160816;
        b=mAsqIZGhNz2X72w5YTXlS2Vb3FZkibTJIrt2py0OG0apnaGgdYeVOQIIwLmrIACioJ
         PX/Vi9reR6CKDQ1buYrof/uV231FX3jVT4oXYdrmwPdJxW+TX3l4PISxR0ixHiM/uEOq
         RUjNP2B2ci2fffHiO87NONZCswM5Nvr3grfHTMC+GjStSigPNv8ZvgI0+yQMCRrGPhnb
         twQAjwPSU8Z03xUCtWcp7L++Dn48PByTyI+NTMP6yFxT/4t/kLpImbA+C0X6cxNumnLR
         EIETQIR7U3gFv1cu2a9fwggXlkN82bYHNNcDfqGdpASIKuZDZKXedMd3sSZ6EnuFZEof
         n6/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=n/ltH/G5hb4xq8Fo9Th2PFFSsg6L4+mVy3JKlZb6SHk=;
        b=qbkCrp2d4l2tVQ9QQ2qHkgyFxL09ngBSeNj+AVrlWI3LHWgZNYO14o/hogxYEcfYm+
         xemLSO7sOaW2vV8Hit0k3d1fFTDv4D0/9eJbPchkwGH4z2vIim2l02IY2/nA7mb7EmOK
         mGdMZsnhKxJa8nuMZ+EkeklZcQLXTRx6FUV1C2hWn4Jb5fRyQea5wpkf689O5KDAxv9+
         ySnR3ZOVtv5FwkMwwMhtIzLFNDzxEKSp2LN/uFR+IFCTST7B02H7QlZnuSqffawnrzoQ
         GvCeSP3xS2QmoWZgDHz6m9LHF1F/cEgTYnaKNKILSmd5ADHabo55cvYiBKLWNtX8Uy29
         eAwQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=ZBzX0jCA;
       spf=pass (google.com: domain of mka@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=mka@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=ZBzX0jCA;
       spf=pass (google.com: domain of mka@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=mka@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx49VAhsJtKFexRmBTnuwZ6kUM2RUe+F87D+gLA52eYEzPJOQkiLhTXVXgStpwvLW7H7n/8SCzw==
Date: Mon, 2 Apr 2018 18:26:29 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Y Knight <jyknight@google.com>,
	Chandler Carruth <chandlerc@google.com>,
	Stephen Hines <srhines@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Kees Cook <keescook@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [GIT PULL] x86/build changes for v4.17
Message-ID: <20180403012629.GD87376@google.com>
References: <20180402095033.nfzcrmxvpm46dhbl@gmail.com>
 <CA+55aFzV8L-uv9706ryJ2mP9VGBuzqFVPu1cgYY+sZAtDAroqg@mail.gmail.com>
 <20180402223821.GC87376@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180402223821.GC87376@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1596675801568391777?=
X-GMAIL-MSGID: =?utf-8?q?1596686378693808151?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

El Mon, Apr 02, 2018 at 03:38:21PM -0700 Matthias Kaehlcke ha dit:

> El Mon, Apr 02, 2018 at 02:44:48PM -0700 Linus Torvalds ha dit:
> 
> > On Mon, Apr 2, 2018 at 2:50 AM, Ingo Molnar <mingo@kernel.org> wrote:
> > >
> > > The biggest change is the forcing of asm-goto support on x86, which effectively
> > > increases the GCC minimum supported version to gcc-4.5 (on x86).
> > 
> > So my biggest worry isn't gcc-4.5 (anybody who hasn't updated deserves
> > to be forced, or can stay with old kernels).
> > 
> > No, my biggest worry is clang. What's the status there?
> 
> I know there is work in progress for asm-goto in clang, but I don't
> know the details or an ETA. Some folks in cc might have more
> information.

Forwarding Chandler Carruth's words:

"A number of folks from both Kernel and LLVM communities are looking at
how to implement asm-goto in Clang in a way that should both work for
the compiler and for the Kernel. So there is progress here, it isn't
just everyone sitting around and waiting. Having more time to finish
it would be appreciated as it isn't easy to implement."

> > I've pulled this, and honestly, the disaster with
> > -fmerge-all-constants makes me think that clang isn't that good a
> > compiler choice anyway, but it's sad if this undoes a lot of clang
> > work just because of the worries about Spectre and mis-speculated
> > branches.
> 
> It would indeed be very unfortunate to loose clang support again, now
> that it just got added after years of joint efforts from different
> people. And this wasn't exclusively kernel work, in my experience over
> the past year the LLVM community was very open to adopt/implement
> changes needed to build the kernel without ugly hacks. It's still not
> a perfect world, but I think LLVM folks deserve some credit.
> 
> Couldn't we just raise the minimum gcc version without enforcing
> asm-goto for clang (yet)? This would give almost everybody the desired
> extra protection, and give clang some slack to implement asm goto.
