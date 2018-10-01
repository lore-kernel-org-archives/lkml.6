Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D28C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 11:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE462089D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 11:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euh19YVj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CE462089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbeJASR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 14:17:58 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:36261 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729237AbeJASR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 14:17:58 -0400
Received: by mail-it1-f196.google.com with SMTP id c85-v6so10913698itd.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 04:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O/rJJAibFx6Zu3l+YJrcuCIE1eyBNVFPSOImG3ZA1iw=;
        b=euh19YVjl2FClfsiD1JEldMjHijANSerx1ZUQPz6jETXr3v7GG0eZp4g5AIq9ER4CF
         5EMYJJZoCLO87G63QT8i80+tXQcw4MpFR5jhZoeZJzbFcbZv8h1A4HGMuozJaZDbEvfa
         KplncoLFoyWccqV0VG4DLsNSMmuXYNfjlkuiaFJYJ66z8XaHDjv6fQhadY92IzTfp/KS
         VnsBgbByjO4CUvPop+nIYFhwKiqz43aytz7QUYkQUB4jbiCNGLcdvz/mOn3IQXazKoLa
         KpISgtlompkPxUOF454VX9ZYdaUoMfayWfxPKE2+7RtYvVrLwPqr1fMpR3nXmK4yr+eP
         sPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O/rJJAibFx6Zu3l+YJrcuCIE1eyBNVFPSOImG3ZA1iw=;
        b=jltHonwA+u9yVIvHgHIEz8JZdRO4gz3uNwDXbmEyEgH/Z6aavTMOlJB1Vw/XCDUclj
         NeCXci548d9C3fyvzBDvaHvE/vZnEdE3A7/Aw7eSHHYZyAzOJC5Lr1/azgfSvgrXxDev
         7kwz4SxC8HnS6T2O4Lo/4g8aidxvYyAc4OsrFUGClwMJYtqotenHoV5gEp+l+Sj83W0E
         AYw4ImW0z8iACAlfy3+zwm0SsStBU54C6N7OeNI9GP27KzBJmd1i1EZDGnW5uzQCL9lV
         4CxqClvKvawPig24FQ+9z9uodd8e0XAWk/QgYrJ98iEu6Mom2Tz7MylkBbRJtlFJnPaF
         vjNg==
X-Gm-Message-State: ABuFfoiwdQDN8TUciohQnzJU1iwKK3TIOKevlwMC2kzoFwii4rAB0H6l
        bqDWX4GWpDVLFGs5VkSi6/nsfsKixFVfIR2Q72U=
X-Google-Smtp-Source: ACcGV61zSW9peBx8YAaeq6sBaaUSeSkwSmi4W+rBhsH+8Dl2SRJI7fkRRHotChxOyvAy2YrOTF4ZaCQdx6EYiRSlIOc=
X-Received: by 2002:a24:3383:: with SMTP id k125-v6mr9112466itk.14.1538394035293;
 Mon, 01 Oct 2018 04:40:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAFULd4YdvwwhXWHqqPsGk5+TLG71ozgSscTZNsqmrm+Jzg941w@mail.gmail.com>
 <20181001102803.GA7269@zn.tnic> <CAFULd4bEtskY+waRvp4kCt-pBmp=W9SQKVpnQ6fsYC=qaOb8Qg@mail.gmail.com>
 <20181001113551.GB7269@zn.tnic>
In-Reply-To: <20181001113551.GB7269@zn.tnic>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Mon, 1 Oct 2018 13:40:24 +0200
Message-ID: <CAFULd4YCCAXV8zjXr_rQ6mnAyLsY8Sywmimf+fWt77B4Wgangg@mail.gmail.com>
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

On Mon, Oct 1, 2018 at 1:35 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Oct 01, 2018 at 01:03:47PM +0200, Uros Bizjak wrote:
> > Looks like gmail forward mangled whitespace. The original, archived at
> > Patchwork [1] passes checkpatch without problems.
> >
> > [1] https://mail.google.com/mail/u/0/#inbox/LXphbRLrghxkrJptDWnbbJcrVBkBsRQgcnbtRLjbGSq
>
> This is a gmail link *into* your inbox?!?!

I don't know how I managed to copy and paste the wrong link :( Here is
the correct one:

https://lore.kernel.org/patchwork/patch/975764/

Uros.
Uros.
