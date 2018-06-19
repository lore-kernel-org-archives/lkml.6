Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC79C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F1E20693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F1E20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030591AbeFSTLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 15:11:39 -0400
Received: from smtprelay0030.hostedemail.com ([216.40.44.30]:35663 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1030259AbeFSTLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 15:11:35 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id BF630837F242;
        Tue, 19 Jun 2018 19:11:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: size48_4751e7b48fd3c
X-Filterd-Recvd-Size: 4114
Received: from XPS-9350 (unknown [172.58.43.195])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Tue, 19 Jun 2018 19:11:29 +0000 (UTC)
Message-ID: <7547dfd4045a5acf23505887065bc228e65f2ff9.camel@perches.com>
Subject: Re: [PATCH] kvm: x86: mmu: Add cast to negated bitmasks in
 update_permission_bitmask()
From:   Joe Perches <joe@perches.com>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>, rkrcmar@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>, hpa@zytor.com,
        x86@kernel.org, kvm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 19 Jun 2018 12:11:27 -0700
In-Reply-To: <20180619183622.GB169030@google.com>
References: <CAKwvOd=n3CdFhL-cFueOEO7ahOoTY6zfvJApXimQ1tBF6XzSOA@mail.gmail.com>
         <d4f32707a89030733217b23b557b38504f0d83ca.camel@perches.com>
         <20180615182945.GN88063@google.com>
         <c852072704e82ac5342f344c5862d20ce5559c21.camel@perches.com>
         <CAKwvOdkv7D8b+apFXUdv_hwJDoWZtUJUTSF2BEzxbMzLVreG6g@mail.gmail.com>
         <ffe4b263-8a8d-c8ed-7ba1-ca55600ab273@redhat.com>
         <CAKwvOdnhPCDRFMhYiAr2kSCDWrL_gaY8c6XHJ96PupcN-wcDpQ@mail.gmail.com>
         <ad7a9addf043ee7fda8907eff9f83c9709b575dc.camel@perches.com>
         <d6a99e26-b100-715b-2615-b77259ec8397@redhat.com>
         <66b5e5c3ed82a5e1559419deb841c57bf0751fd3.camel@perches.com>
         <20180619183622.GB169030@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-19 at 11:36 -0700, Matthias Kaehlcke wrote:
> On Tue, Jun 19, 2018 at 11:07:47AM -0700, Joe Perches wrote:
> > On Tue, 2018-06-19 at 19:35 +0200, Paolo Bonzini wrote:
> > > On 19/06/2018 19:23, Joe Perches wrote:
> > > > On Tue, 2018-06-19 at 10:08 -0700, Nick Desaulniers wrote:
> > > > > On Tue, Jun 19, 2018 at 8:19 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
> > > > > > 
> > > > > > On 15/06/2018 20:45, Nick Desaulniers wrote:
> > > > > > > > 
> > > > > > > > > In any case I think it it preferable to fix the code over disabling
> > > > > > > > > the warning, unless the warning is bogus or there are just too many
> > > > > > > > > occurrences.
> > > > > > > > 
> > > > > > > > Maybe.
> > > > > > > 
> > > > > > > Spurious warning today, actual bug tomorrow?  I prefer to not to
> > > > > > > disable warnings wholesale.  They don't need to find actual bugs to be
> > > > > > > useful.  Flagging code that can be further specified does not hurt.
> > > > > > > Part of the effort to compile the kernel with different compilers is
> > > > > > > to add warning coverage, not remove it.  That said, there may be
> > > > > > > warnings that are never useful (or at least due to some invariant that
> > > > > > > only affects the kernel).  I cant think of any off the top of my head,
> > > > > > > but I'm also not sure this is one.
> > > > > > 
> > > > > > This one really makes the code uglier though, so I'm not really inclined
> > > > > > to applying the patch.
> > > > > 
> > > > > Note that of the three variables (w, u, x), only u is used later on.
> > > > > What about declaring them as negated with the cast, that way there's
> > > > > no cast in a ternary?
> > > > 
> > > > It'd be simpler to cast in the BYTE_MASK macro itself
> > > 
> > > I don't think that would work, as the ~ would be done on a zero-extended
> > > signed int.
> > 
> > True, but the whole concept is dubious.
> > The implicit casts are all over the place,
> > not just in the file.
> 
> Would that have been any different with the solution you proposed (if
> it worked)?
> 
> Apparently both gcc and clang limit the warning to the potentially
> more problematic case where a value with sign bit is promoted.

I think the warning is exactly equivalent to -Wsign-conversion
and we don't normally compile the kernel with that either.

Trying to allow a "make W=3" to be compiler warning message free
is also silly.

I think it's better to make the warning emitted only at a W=3
level instead.

