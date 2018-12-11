Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A65C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA8C20855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AmenClFQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA8C20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbeLKRyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 12:54:02 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39791 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbeLKRyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 12:54:01 -0500
Received: by mail-pl1-f195.google.com with SMTP id 101so7264828pld.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 09:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fnCYDLd8JaIeqhRy1AB47UYKu5VVnuK62IDyTPBKCYc=;
        b=AmenClFQciiWHcFYAUMPMExHowU9pDeOKYFOQESQ1dpJ7xgnjKss21680iKdCN9I1a
         r7YTiQqRF0Cd2YsDSbaQuxqm7rUfZO3MYRyMOdnqB6rmCukaY+N2BwmEn74SgFhaQH0P
         yesasQU7UZe+HbjJ+lL1PKZ0thucFQTd1d1I0PYE8jvIX26BVd8T5cwei2HlqlUuRyCI
         huq4+BhEEv25WwrnMjZcQYHAV3B4IPKqL7a51Tsi2krTK1VhGKOgMqR4erc/sjaEt/3+
         eZvz6o8+Nc2EcxhOk4LNxQikdonvpDIFRk2GZ24AVp9cy/Dpmf+RwleU0rnj3OzfJy1l
         TfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fnCYDLd8JaIeqhRy1AB47UYKu5VVnuK62IDyTPBKCYc=;
        b=E2jfstoObAiFm/+jV3BaW6F28c56bIq5NfOHy0xULm7laiyqCILDEUkXtOZI7E6kMQ
         Xwds6MdnyWwEtLG4t0bqPIKyJhz615V75TKW7SctrLdma+vdcjGyiW52lcKJHt+36D4m
         OabCHRdkbcZvASmox8AVxsnkQf2kSC4Bw2IbsGqRsHd0bFcHX1e5QzxrCs8khGvgvoJV
         r03P+inY4alqr2CMoK7bMdemLazl8riCZEkjPeXcaEVWdUHXBxSunWToqqRKnkz7zZip
         pvnWHAgy92yMXZZIErqv89zrHMjHzWyd8yA2SlNpiBZiD73BqNeBm0YwJKFIvtwg5O6c
         0I1w==
X-Gm-Message-State: AA+aEWbtnZ2h376s46iWibzbjBITSYInNZE0UvRPLC3W3uXNSvoBCMQ2
        KtVf7RXoXwTQ75qLHP+AHipsaFjTsNynRtUTrhZTETdP
X-Google-Smtp-Source: AFSGD/U1Bmds0zhCEJUG8fJRwU7ZPSS/lwTExtHfLrkz4K0VY3FoM/L6UxoVCAn+/vJSW3bQM1zqCDqH8hqLw0QgzCk=
X-Received: by 2002:a17:902:820d:: with SMTP id x13mr17407605pln.229.1544550840960;
 Tue, 11 Dec 2018 09:54:00 -0800 (PST)
MIME-Version: 1.0
References: <20181206191231.192355-1-ndesaulniers@google.com>
 <tip-f4313ba52f9caccfda6a55f991c84aba6726b88f@git.kernel.org>
 <CAKwvOdmBNvpjiYDdP88c9TZHzqbf-GTcQqPdft+LgJXC+W26Dw@mail.gmail.com>
 <5480353.C3TqP6Wb6x@blindfold> <20181211174658.GN27375@zn.tnic>
In-Reply-To: <20181211174658.GN27375@zn.tnic>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 11 Dec 2018 09:53:49 -0800
Message-ID: <CAKwvOdnkqbxTYudCWH+Q_nuGbpKp8w3_3zHpxe29nirKKPrpsQ@mail.gmail.com>
Subject: Re: [tip:x86/build] x86/um/vdso: Drop implicit common-page-size
 linker flag
To:     bp@alien8.de
Cc:     richard@nod.at, Masahiro Yamada <yamada.masahiro@socionext.com>,
        mingo@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        x86@kernel.org, hpa@zytor.com, jdike@addtoit.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, bp@suse.de,
        linux-tip-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 9:47 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Dec 11, 2018 at 06:43:39PM +0100, Richard Weinberger wrote:
> > https://lore.kernel.org/lkml/1633144.08IGjMOzBB@blindfold/
> >
> > Maybe google started to hate my mailserver (again).
>
> You probably need DKIM fun. It is most likely marked as spam in his
> mbox.

Indeed it was.  I'm forced to use Gmail's clients for this work
account and all that implies (no plain text responses when mobile).
Man do I miss Thunderbird properly threading responses clearly by use
of indentation.  Gmail literally did not show any responses even in
search for my patch (even from someone on the to/cc list!).  Maybe I
can file a bug about this internally...
-- 
Thanks,
~Nick Desaulniers
