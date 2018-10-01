Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F15EC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 11:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45A89208E7
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 11:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uaDXhubf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45A89208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbeJARlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 13:41:14 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:37236 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728921AbeJARlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 13:41:14 -0400
Received: by mail-it1-f196.google.com with SMTP id m9-v6so10775563ita.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 04:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FRU+e3GZ6rPTLFTUdljSFmt3K9UIzXla0MUUj/GVsyk=;
        b=uaDXhubfY+Q9zyVW7F/O8I2yrUsTVr3OAhFCKie6Jb3R82J0N+84nmoiAvX1+T8FlK
         ZIXYogBnmQYcmktfOxucuAiCiJUC+sU/qdhDIZnTZ3eGMR6YOsNJeN3UWj+uipmL9EzS
         BfmgDezXZoPS4VPDdzh8uA73v0kZGawHwcb7ke0y2eaBhYJGGfqbowymKLiJANlIdCzS
         PK54rLXV3Xp5dkj6g9X/+R5l00XkgrDEdkGXhyfhrv+CjOyWUtyLq7zT61XDSE2vX/Qs
         hrtZra5udLEmws287VjwRf+PhgqhEV8qrDKLw8G+ICUXl+/yID2DMDB16b8/c46K1tSv
         BCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FRU+e3GZ6rPTLFTUdljSFmt3K9UIzXla0MUUj/GVsyk=;
        b=kJzGPbr5ts0u45w3WINcuVjna/Sx5ESXjD+HlZHCd7vcAPDK/OZSt7waa3sLte1xe0
         qQbU8hdxBdqtJsJopoXZULn0AIx5H4RJ4AjgfDkEfMImYJpw0Zp1M8i4+fPPccLvn1Fp
         AHh6WAFW9KPQ4T9Mv6++vD5NTCikVMYcA2DFYADpT878bLfyGhjnc76ytzaKyb81onp1
         xfrha76rHAg454lCkVHs2Wvn0fyh3TcNiMqYSt/zNv4Rav++VZHWK7tjIH/HQ30g6wM3
         ANZo7Ov5XaRtBZ07X97vkGDRSQE635iyTe8c5LULeQl6fo4kfbiR4rUD0kH/qxnZC7mW
         7yYQ==
X-Gm-Message-State: ABuFfogQEND4Iurv0HSLwh5nQL6lb6q83P3FwZhAydylDW/hZ0yH2oj7
        JQZw1VJWaXZo5kUy4C2UqQIeze5nWfPNULFQreDuVBNPhpg=
X-Google-Smtp-Source: ACcGV60mma1/2fCvJUjgAK96UBgWLlM5LCH7aiwhyhK0Xxcp8iEBCTff/SEQbgN6LPSDEdRSPyhoicNT5UHutgy5GBs=
X-Received: by 2002:a24:3383:: with SMTP id k125-v6mr9024268itk.14.1538391839158;
 Mon, 01 Oct 2018 04:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAFULd4YdvwwhXWHqqPsGk5+TLG71ozgSscTZNsqmrm+Jzg941w@mail.gmail.com>
 <20181001102803.GA7269@zn.tnic>
In-Reply-To: <20181001102803.GA7269@zn.tnic>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Mon, 1 Oct 2018 13:03:47 +0200
Message-ID: <CAFULd4bEtskY+waRvp4kCt-pBmp=W9SQKVpnQ6fsYC=qaOb8Qg@mail.gmail.com>
Subject: Re: [PATCH resend] x86, asm: Use CC_SET()/CC_OUT() for __cmpxchg_double
To:     bp@alien8.de
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 12:28 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Sep 28, 2018 at 10:33:05AM +0200, Uros Bizjak wrote:
> > Remove open-coded uses of set instructions to use CC_SET()/CC_OUT()
> > for __cmpxchg_double.
> >
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > ---
> >  arch/x86/include/asm/cmpxchg.h | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/cmpxchg.h b/arch/x86/include/asm/cmpxchg.h
> > index a55d79b233d3..bfb85e5844ab 100644
> > --- a/arch/x86/include/asm/cmpxchg.h
> > +++ b/arch/x86/include/asm/cmpxchg.h
> > @@ -242,10 +242,12 @@ extern void __add_wrong_size(void)
> >         BUILD_BUG_ON(sizeof(*(p2)) != sizeof(long));                    \
> >         VM_BUG_ON((unsigned long)(p1) % (2 * sizeof(long)));            \
> >         VM_BUG_ON((unsigned long)((p1) + 1) != (unsigned long)(p2));    \
> > -       asm volatile(pfx "cmpxchg%c4b %2; sete %0"                      \
> > -                    : "=a" (__ret), "+d" (__old2),                     \
> > -                      "+m" (*(p1)), "+m" (*(p2))                       \
> > -                    : "i" (2 * sizeof(long)), "a" (__old1),            \
> > +       asm volatile(pfx "cmpxchg%c5b %1"                               \
> > +                    CC_SET(e)                                          \
> > +                    : CC_OUT(e) (__ret),                               \
> > +                      "+m" (*(p1)), "+m" (*(p2)),                      \
> > +                      "+a" (__old1), "+d" (__old2)                     \
> > +                    : "i" (2 * sizeof(long)),                          \
>
> To quote checkpatch:

Looks like gmail forward mangled whitespace. The original, archived at
Patchwork [1] passes checkpatch without problems.

[1] https://mail.google.com/mail/u/0/#inbox/LXphbRLrghxkrJptDWnbbJcrVBkBsRQgcnbtRLjbGSq

Uros.
