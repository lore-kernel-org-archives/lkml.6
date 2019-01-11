Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B4BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCFC420874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CaLw15AT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732870AbfAKRsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 12:48:03 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33454 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbfAKRsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 12:48:03 -0500
Received: by mail-lf1-f68.google.com with SMTP id i26so11413167lfc.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 09:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MQmEgznUgmWyIkicRqil1pfYDby2QDt5WSafEsS+s2A=;
        b=CaLw15ATXveclchAkZYbUYJAmo7Wesh26sGlCcjteYiQUar4dSe5lDC9qbvKRTSH/0
         fEZTjjB6dgNNrScNlzWfZbOjc6YFrvEhmVLB7BNdqjHIQq6Cz4OgEdXvmYbaLcDgnsdY
         jAw3IuaVVt+gi416XYf91katQYIcKg5MUavfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MQmEgznUgmWyIkicRqil1pfYDby2QDt5WSafEsS+s2A=;
        b=ubvYTPVCi74ujYf3dkfFaDf3xNgbRXqJeOrL1WJKuRigIqh0oa3xs7w7kBThh3J1cT
         dlIXz00ttGmkAr3Ei0F2QtisSEratHRjpJWQ5wU1VnDyh4sNNoWlNfTZ/QjqSugZSGBP
         SrmbDKRevEosJ00ALfpnsS8ymlr7nVncO86NZdhucozVCO1yzlkm/IQ8tPTyEt5s322r
         bfDhLeRa1SL8zz8hIn2bCTXBQcGJdJT/R/57qWbbEyOIZAueSw5H7EsA/B7GXzgCVXzY
         TeTiK2fgT/zeIx57xhARZAA6wpF6zyBWLFzyVnD3Y1p6ygMebxJn6xvLDuUM8xGLMXzG
         GAIQ==
X-Gm-Message-State: AJcUukdRVS9jhSkRD1V2h1h1JZOmPTGnF1ylyZnkFJTMn32mGm1qe2I7
        PreFV35w+yeV9oP0ThIXRXIDQ9e/mWI=
X-Google-Smtp-Source: ALg8bN6j5dmFWlPY5v2tmZ0Dk4dNFZjFcCOshulNSieCSTjPPIwxCs1oX4IjVzbGXbBmDceIGWXr7A==
X-Received: by 2002:ac2:4116:: with SMTP id b22mr9109204lfi.19.1547228879726;
        Fri, 11 Jan 2019 09:47:59 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id m10-v6sm15962191ljj.34.2019.01.11.09.47.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 09:47:58 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id a8so11383245lfk.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 09:47:58 -0800 (PST)
X-Received: by 2002:a19:7006:: with SMTP id h6mr9091800lfc.147.1547228878074;
 Fri, 11 Jan 2019 09:47:58 -0800 (PST)
MIME-Version: 1.0
References: <20190111074614.GA68053@gmail.com>
In-Reply-To: <20190111074614.GA68053@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Jan 2019 09:47:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=whU4L4qzCmKhGGSthCGWkSSVFiP-0v16fpZTUzWgp39hg@mail.gmail.com>
Message-ID: <CAHk-=whU4L4qzCmKhGGSthCGWkSSVFiP-0v16fpZTUzWgp39hg@mail.gmail.com>
Subject: Re: [GIT PULL] EFI fix
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 11:46 PM Ingo Molnar <mingo@kernel.org> wrote:
>
> A single fix that adds an annotation to resolve a kmemleak false
> positive.

This one is apparently obviated by commit 80424b02d42b ("efi: Reduce
the amount of memblock reservations for persistent allocations")

               Linus
