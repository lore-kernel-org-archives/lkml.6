Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E514CC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A5521726
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="X6m78ckl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730517AbfAXUDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:03:21 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34830 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730989AbfAXUDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 15:03:18 -0500
Received: by mail-lf1-f65.google.com with SMTP id e26so5268288lfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 12:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PfqTHN3YmhRgDrvyEQJ5X3boW0v/WOCD02H3ToPreLU=;
        b=X6m78cklmPt7mtk+ZNfr65Q0r6YAVDMguHsX9lTqOoms+drnuAYdQpgyvy3DXQJ6uN
         kPZ9Vu559QynAj2QPl3orkZCa99iJEQDqsDhtAQzPg8PfKEFF5yt68N2/6ADZAgu9kgB
         UGo4R1aRoPa3TZGDtfRk29GBPKTYH+BBdpizs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PfqTHN3YmhRgDrvyEQJ5X3boW0v/WOCD02H3ToPreLU=;
        b=Th4wHvF8IhUe2HCvm0CYjyv5jP4P9ommDiHtVAJYnWVWLAAoC73CmaskL5SVxUffPk
         8nIuTH6+JbGoKGwCoZUddXlfyCe11KKpa/951JLvIywNm969WEca10G5P4UFT4DI3NLv
         eTCaM5AkADJsQtGpZRh/Juv1L6O7q4rH1mDoDoXsTn6zwbuQWD0ORaFmsyDRDBdFc6EU
         XLgxbnxlldljKQxletVYQ5/Gc16TBOs1KXWdKKOuzrMv8GgF8m1ulXbEpwOr26MAHHOD
         bEU77VT7UI33tiwTX9uX+aOVaikEM3I5rtZwevuW64RlE0HLIU/i9qa54mEjaKv7SkDM
         Gczg==
X-Gm-Message-State: AJcUukdTnUsNKgYOhq0tC+Z3HwrSKj5N2DKQCbQ9kggSOLF1kx3QVUDg
        Qk9ALjw8PGcm+Zztt/pX5qp1FRI2Ffn8oQ==
X-Google-Smtp-Source: ALg8bN5QKhzDWi+eN+jFq3ssHyD1OQ4LJ/x8dDmip9xMeOSIfnw2o7YdtzFnTo4BG82xUA0P6qyRrw==
X-Received: by 2002:ac2:4343:: with SMTP id o3mr5700988lfl.129.1548360195517;
        Thu, 24 Jan 2019 12:03:15 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id q2sm1143350lfa.63.2019.01.24.12.03.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 12:03:14 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id k15-v6so6359007ljc.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 12:03:14 -0800 (PST)
X-Received: by 2002:a2e:8045:: with SMTP id p5-v6mr6437511ljg.87.1548360193785;
 Thu, 24 Jan 2019 12:03:13 -0800 (PST)
MIME-Version: 1.0
References: <20190124185852.19423-1-Florian.LaRoche@googlemail.com>
In-Reply-To: <20190124185852.19423-1-Florian.LaRoche@googlemail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 25 Jan 2019 09:02:57 +1300
X-Gmail-Original-Message-ID: <CAHk-=wi8v7YOxR2Zxb+=z5DwQ99EWumu4ED8d8S4XgVrc=28rg@mail.gmail.com>
Message-ID: <CAHk-=wi8v7YOxR2Zxb+=z5DwQ99EWumu4ED8d8S4XgVrc=28rg@mail.gmail.com>
Subject: Re: int_sqrt() adjustments
To:     Florian La Roche <florian.laroche@googlemail.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Crt Mori <cmo@melexis.com>, Joe Perches <joe@perches.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 7:58 AM Florian La Roche
<florian.laroche@googlemail.com> wrote:
>
> __fls() is returning an unsigned long, but fls() and fls64() are
> both returning a (signed) int.
> As we need a signed int as right operand of "<<" (as Linus pointed out),

It's not that the "signed" part is all that important, it's that using
another type is unnecessary and maybe misleading, when just the
default plain regular integer constant works right.

So I think this:

> -       m = 1UL << (__fls(x) & ~1UL);
> +       m = 1UL << ((fls(x) - 1) & ~1);
..
> -       m = 1ULL << ((fls64(x) - 1) & ~1ULL);
> +       m = 1ULL << ((fls64(x) - 1) & ~1);

is all good and simplifies the code to not have suffixes that don't
really matter or help.

Thanks,

            Linus
