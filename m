Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB393C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F68020652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:55:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F68020652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967312AbeFSVzQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 17:55:16 -0400
Received: from smtprelay0226.hostedemail.com ([216.40.44.226]:33145 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755466AbeFSVzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:55:09 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 6C589837F24C;
        Tue, 19 Jun 2018 21:55:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: quiet96_2c9ff3dede142
X-Filterd-Recvd-Size: 2447
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Tue, 19 Jun 2018 21:55:06 +0000 (UTC)
Message-ID: <951ccf2a257fb8f8827f88e1c17ce64d23173e94.camel@perches.com>
Subject: Re: [PATCH] kvm: x86: mmu: Add cast to negated bitmasks in
 update_permission_bitmask()
From:   Joe Perches <joe@perches.com>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>, rkrcmar@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>, hpa@zytor.com,
        x86@kernel.org, kvm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 19 Jun 2018 14:55:05 -0700
In-Reply-To: <20180619211019.GE169030@google.com>
References: <20180615182945.GN88063@google.com>
         <c852072704e82ac5342f344c5862d20ce5559c21.camel@perches.com>
         <CAKwvOdkv7D8b+apFXUdv_hwJDoWZtUJUTSF2BEzxbMzLVreG6g@mail.gmail.com>
         <ffe4b263-8a8d-c8ed-7ba1-ca55600ab273@redhat.com>
         <CAKwvOdnhPCDRFMhYiAr2kSCDWrL_gaY8c6XHJ96PupcN-wcDpQ@mail.gmail.com>
         <ad7a9addf043ee7fda8907eff9f83c9709b575dc.camel@perches.com>
         <d6a99e26-b100-715b-2615-b77259ec8397@redhat.com>
         <66b5e5c3ed82a5e1559419deb841c57bf0751fd3.camel@perches.com>
         <20180619183622.GB169030@google.com>
         <7547dfd4045a5acf23505887065bc228e65f2ff9.camel@perches.com>
         <20180619211019.GE169030@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-19 at 14:10 -0700, Matthias Kaehlcke wrote:
> On Tue, Jun 19, 2018 at 12:11:27PM -0700, Joe Perches wrote:
> > -Wconstant-conversion is only issued when a *constant value* is assigned to
> an incompatible type.
> 
> > Trying to allow a "make W=3" to be compiler warning message free
> > is also silly.
> > 
> > I think it's better to make the warning emitted only at a W=3
> > level instead.
> 
> Another difference with -Wsign-conversion is that enabling it would
> probably result in thousands of warnings. Do you have evidence that
> there is a significant number of spurious -Wconstant-conversion
> warnings?

Not my issue really.  You're advocating for
making the code more complex/ugly for a condition
where the result is identical.

Do you have evidence this is the only location in
an allyesconfig compilation?

