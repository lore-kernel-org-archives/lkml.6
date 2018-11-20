Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA14C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31940208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cELDhoDD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31940208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732606AbeKTLQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 06:16:24 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:40633 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731494AbeKTLQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 06:16:23 -0500
Received: by mail-it1-f195.google.com with SMTP id h193so994331ita.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 16:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l9+YSuM6UE2y8SOWMO109RCI1uqCgiPFYIIJ37dx7XY=;
        b=cELDhoDDueUKGmZrJaB1zjp/6L0TbPth01OXheubUfE1bCeEqcZluxtLMjt0BeEqnY
         cihN/F8mA6MwhkmZNE6nWBQDFyuLl50sDiTqiRKeDtP6oglyCLqpP1Uq1v3uFgDqcZPh
         KbcqOSABRlSs7pOf/l+usOPo2sj9emmu0RXiBTVjzf6WsKp4k5wdtI32sNigiPyQt85X
         VDrG4kfViW5N4G53rXujmDdgmg2Kbcbx52GD97X/CFDvvHVN6jCY1uEzLLaD9eRT271c
         t47PJER34W9WS+xkEBg2g8PhMWOF6KYO5oJ2CStUD240t+gdycqMk9UN2f/AvbLPsNBH
         401g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l9+YSuM6UE2y8SOWMO109RCI1uqCgiPFYIIJ37dx7XY=;
        b=LfQhZgJRTIy/swGfkWUGfYbu5ClwTxKDxI6WgaxoF50esSfkm32ABHskK1yJeCIt8L
         tBFTSyvniscjiTkFdR9MY3hOlzc+1Y3s/ULMQE18NWgdmaMe4enWmOww+iLxS0l4N+sW
         9XLdARD5/U+Fc/Phg3I48cZnwnDo/wTFk6nPwRdH+JhS2D6X5BOFug2HF4xVD0XltO/4
         iBK8iGuxE4KRhMxu0uYCINhe/gXMJmEZuBFNcQC6ZX9zzmws28eTZt13HTk81iH5h0J9
         AJ0tflzsDh/peiG6WSKSagbKwzQBgsQEhCP2VwYv99q0zb2OCeOQ0JDfX6jE6FzEPK6G
         wGuw==
X-Gm-Message-State: AGRZ1gKcnLhS7xRKp0nvS8Yq7HVSe8BDe1wX8Xomcn6VzyCeqQEYjI3Q
        uIgcwF3f+2142fxqu+1voYl1MVOCo9R/0ibKcX4=
X-Google-Smtp-Source: AJdET5cKZs9TKQpZJZaFve4Ey1d5QCp4HmMszt2AYVS/oWzrt/58E1BlenvgsJugLp6cO5UdrRjigFdl7aVb2sOdS2Q=
X-Received: by 2002:a02:9d27:: with SMTP id n36mr21013532jak.30.1542675000666;
 Mon, 19 Nov 2018 16:50:00 -0800 (PST)
MIME-Version: 1.0
References: <20181119154334.18265-1-tiny.windzz@gmail.com> <c9c572ed-05a1-cec9-97e9-2b66cb58afcc@intel.com>
In-Reply-To: <c9c572ed-05a1-cec9-97e9-2b66cb58afcc@intel.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Tue, 20 Nov 2018 08:49:13 +0800
Message-ID: <CAEExFWun3LL8++PMvFzfuufXTK79BgS8-KS+gs=sR-icLnJDag@mail.gmail.com>
Subject: Re: [PATCH] x86/mm/dump_pagetables: Change to use DEFINE_SHOW_ATTRIBUTE
 macro
To:     dave.hansen@intel.com
Cc:     Kees Cook <keescook@chromium.org>, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dava:

How about just change the ptdump_fops and ptdump_open?

Yours,
    Yangtao
On Tue, Nov 20, 2018 at 1:06 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 11/19/18 7:43 AM, Yangtao Li wrote:
> > -static const struct file_operations ptdump_curusr_fops = {
> > -     .owner          = THIS_MODULE,
> > -     .open           = ptdump_open_curusr,
> > -     .read           = seq_read,
> > -     .llseek         = seq_lseek,
> > -     .release        = single_release,
> > -};
> > +DEFINE_SHOW_ATTRIBUTE(ptdump_curusr);
>
> FWIW, I rather dislike this conversion and the DEFINE_SHOW_ATTRIBUTE()
> approach in general.  It makes it basically impossible to go from
> ptdump_curusr to ptdump_open_curusr without opening up the macro and
> reverse-engineering it.
>
> My test is that for these macros to be sane, I need to be able to find
> "ptdump_open_curusr" by grepping for "ptdump_curusr".  This fails the test.
>
> I don't think saving a few lines of code is worth the obfuscation.
