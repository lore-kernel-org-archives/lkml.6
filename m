Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F359C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 15:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C99425049
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 15:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNjvVBmX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C99425049
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752414AbeGAPYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 11:24:43 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:41488 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752275AbeGAPYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 11:24:40 -0400
Received: by mail-lf0-f65.google.com with SMTP id y127-v6so10122128lfc.8;
        Sun, 01 Jul 2018 08:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TNN/4pmE3Pkkju9Q1Iyqv+0LsPCLRaSkZaD/kV2/RIc=;
        b=TNjvVBmXUwPOOpUqS3uzSFGLjCetfzzMk5VR0jo+JDv2HzNBBqx6QV0K/MTWjqxVcX
         Xt/RuH15znn0Uys+w7VO7daCtHnqDkQizuSI2TZ0WFfFLdJxWuTBq/2FqEeKD9QzuRnl
         PzrzPtHtrTDDaHcbFhujfiZf/FAexjEGa9ktQTr3AskCfiHZ05UhoZGIGLoCOjiGb8GD
         YfNOYxw5kkibxr7OT55mcz5jdTt8qPGncAptEUSJ8bPEIFNIA9AG4Y29e/JGCGNuUQox
         WiaajnGyqeNDJtcnsWe7QL0Kn8l3SZr7Qa2s6Q/s1hMZ2wf7/X4ayYZhwH4EqPa4uh6x
         kj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TNN/4pmE3Pkkju9Q1Iyqv+0LsPCLRaSkZaD/kV2/RIc=;
        b=c+C3wJUq39+z0FqxW4tpPSt87QWmGvH8KrxGsTq3xiQh0PaO6f3vBOv3F0isPRM6hi
         EbVwQz5xXb9Zu1HRy8PYVt4Ta5SRAfOS+7bMwjSEVYIeBD7vzgr0N0tGchlrXvfZZhxL
         ZfE9Q+bFj+KCNBnP+DjlWHRji5bXsTgaV3qkLNsIxu6Eedzn6uqo/NBok4ySDLLu6AfJ
         X6dDWj77dSY6oijqFEvRArMZIDStnyftDlvx4WVDwIlfa6yBoZmZq0PDo2JEDit0xqAU
         7o8DMUocieTLtlrnllV5IWgzH/gaddkGRVEBw2FrgnMKZ+iZZ5Q5iu0wZQL1ODeNjyS0
         zrkQ==
X-Gm-Message-State: APt69E14d9M3jUeMAvMltOsX9E3N0Ml7slRGUPofb1P2QqGmJfZJn9dc
        3SjF4+Z65Zy/BywPDfQ45e1UkNXqpmmCKwqyTi0=
X-Google-Smtp-Source: AAOMgpdxei6DTQv5LPXkMmxt3fTmrSS1kiZqPf2ljc2k/ZT4g5jHgFrlrQjBDNbWt29A/EPBWuArug6L2bLwbRBPUqA=
X-Received: by 2002:a19:5418:: with SMTP id i24-v6mr10435882lfb.34.1530458678329;
 Sun, 01 Jul 2018 08:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180507213755.GA32406@avx2> <tip-51bad67ffbce0aaa44579f84ef5d05597054ec6a@git.kernel.org>
 <1529235613.4572.7.camel@gmx.de> <20180617120012.GB16877@zn.tnic>
 <1529242717.4472.3.camel@gmx.de> <1529244178.4674.1.camel@gmx.de>
 <20180617194747.GA21160@zn.tnic> <1529289279.31745.3.camel@gmx.de>
 <20180623103622.GA2760@zn.tnic> <20180701131941.2dqkzg7az25qpc6b@gondor.apana.org.au>
In-Reply-To: <20180701131941.2dqkzg7az25qpc6b@gondor.apana.org.au>
From:   =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= 
        <omosnacek+linux-crypto@gmail.com>
Date:   Sun, 1 Jul 2018 17:24:39 +0200
Message-ID: <CAAUqJDt+DyRj_Q1D05d0D7pJQYjCZas6uz8aZ0xsQVE=vSETxA@mail.gmail.com>
Subject: Re: [PATCH] x86/crypto: Add missing RETs
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     bp@alien8.de, linux-crypto@vger.kernel.org, efault@gmx.de,
        Alexey Dobriyan <adobriyan@gmail.com>,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, jpoimboe@redhat.com, luto@kernel.org,
        peterz@infradead.org, brgerst@gmail.com, hpa@zytor.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dvlasenk@redhat.com, h.peter.anvin@intel.com,
        linux-tip-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ne 1. 7. 2018 o 15:20 Herbert Xu <herbert@gondor.apana.org.au> nap=C3=ADsal=
(a):
>
> On Sat, Jun 23, 2018 at 12:36:22PM +0200, Borislav Petkov wrote:
> > Lemme send a proper patch now...
> >
> > ---
> > From: Borislav Petkov <bp@suse.de>
> > Date: Sun, 17 Jun 2018 13:57:42 +0200
> > Subject: [PATCH] x86/crypto: Add missing RETs
> >
> > Add explicit RETs to the tail calls of AEGIS and MORUS crypto algorithm=
s
> > otherwise they run into INT3 padding due to
> >
> >   51bad67ffbce ("x86/asm: Pad assembly functions with INT3 instructions=
")
> >
> > leading to spurious debug exceptions.
> >
> > Mike Galbraith <efault@gmx.de> took care of all the remaining callsites=
.
> >
> > Signed-off-by: Borislav Petkov <bp@suse.de>
>
> Patch applied.  Thanks.

Hi Herbert,

I can see you applied this patch to your cryptodev-2.6 tree (which I
believe is for the next release). Shouldn't this go into the
crypto-2.6 tree so it gets into 4.18-rcX? I'm not sure, but it seems
to me that it qualifies as a (potentially serious?) bug fix.

Also, I think you accidentally extracted the wrong part of the e-mail
as the commit message...

Thanks,

Ondrej
