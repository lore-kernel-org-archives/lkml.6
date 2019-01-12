Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D58C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 08:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD6C02177B
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 08:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547283204;
	bh=TOKpdeToMutH6nkQE9S2pS837KiuhQJLbwhYtJW/7i4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r/QYSuFaHD1jgRl5IebnEZW/Awg2hbwfzN5Er51K4e7UexPBgNZxG3YFqLIEdpqLm
	 NX84GS6qOHOLxdYgB3E+suOAjATxh3V6t4hJtb7OU1DiG5+r26i4gp9oHsxSRDyZAG
	 +jvRyLW1plSNWAyrCUSVaMfBlaw5zyws8U30mrkU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbfALIxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 03:53:24 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40469 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfALIxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 03:53:23 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so17595230wrt.7;
        Sat, 12 Jan 2019 00:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mixqIEbutU1pUp2sngMu3OOxiX4ZDBjrFIwUPLahwYs=;
        b=kN1v4nw7BYpfdIJvLe1VhoOLAUZmmsoEmUBZuV6fImp9JhLOVGNffsm7hQS98+q+2I
         PNA1hYTzn3WDOnlaRPC2q7mZ9DXPGr/tTv1GGvKP+1c93j5/Tn5YeUyGY2iXJYUA+4Ls
         X3luWALkrj4xyfRDiSH9BBMse3cPn2eSjZSb49Li25dHJJSsVy+LS9tXynPX9gEP/4JW
         VQ/6WY5fZjPxGpqgQUVoGgJ4+oS+7FDwFfAX6KJ3SRFXZlia12NfAt5e9HW2s+AzFqh2
         Ks2XtYnIOiPa62LJQ9+C93/NTc9gYBa8GGNZpy/fphWHVD2L/UGC20kSZ5BfhJgoDPc1
         MCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mixqIEbutU1pUp2sngMu3OOxiX4ZDBjrFIwUPLahwYs=;
        b=HJvT6NE/Tjz5OocI9LNJeCHPccIr9HmaEpkMldXVoHR0zwT4qrNBdmQEqb222bXpXS
         Q6W+0djoWjD7N2VUhjYwf4tfTlL04MEGxCcHZKVy8zSDSdEd5Xj0m4n03IZpvPiYWAnp
         I+fQc3A4AgK9kNYsV7ZJBr/BkwtduYhNDEmoVp+k9oZd6bjoCreI/k7dDYAIVEMtJfax
         5jCHk27q7tvw3SMs60TfwZrvn4UiIq1MDICpCFCCTQiQNsrCeryjkYMuzLTZMFOQ588H
         5EQruVR9Bk59aQ91dwH1C70aYCiNjUhxoiHdnUVrURkB0ioUUJZDfZTS//jxex0DN773
         Xu/Q==
X-Gm-Message-State: AJcUuke9fhEXqUz1yD+YfXxBU5lcD5ONvHQVxq8lIc5T5JzZGJy/qLEy
        M8nuN7fegsfCCJgtGE3w6mM=
X-Google-Smtp-Source: ALg8bN7bN3MgTL3eCJ3iBBOIugLrGT4QGvcRz6FCbLMaatFj7RtfndCrTtckBIiomwyTmz97lFB0nw==
X-Received: by 2002:a5d:470b:: with SMTP id y11mr16535095wrq.16.1547283201329;
        Sat, 12 Jan 2019 00:53:21 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id k19sm89153616wre.5.2019.01.12.00.53.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 12 Jan 2019 00:53:20 -0800 (PST)
Date:   Sat, 12 Jan 2019 09:53:18 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] EFI fix
Message-ID: <20190112085318.GA119110@gmail.com>
References: <20190111074614.GA68053@gmail.com>
 <CAKv+Gu8oY6VFeuH3T0FU452W-rKGGQk3top5kEbuP2aCxzJTCQ@mail.gmail.com>
 <CAHk-=wjNhQsT2h0M25dDELgaCfkWYBGx_5gQw=yEM10uTO4Ycw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjNhQsT2h0M25dDELgaCfkWYBGx_5gQw=yEM10uTO4Ycw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, Jan 11, 2019 at 6:22 AM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> >
> > I was hoping we could merge this patch (so we can backport it), but
> > resolve the conflict by dropping the kmemleak_ignore() again [..]
> 
> Well, we'd drop the new #include line also, since it would be
> pointless without the kmemleak_ignore().
> 
> End result: there would be nothing left. Better not to merge it at all.

Indeed!

> It's easy enough to backport, and just say "done differently upstream
> in commit 80424b02d42b ("efi: Reduce the amount of memblock
> reservations for persistent allocations").
> 
> The stable tree doesn't require that the *same* commits be upstream,
> it only requires that the fixes be upstream and Greg&al want a pointer
> to the upstream fix just so that they know they're not fixing
> something that might still be broken upstream.
> 
> See for example (just random googling)
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=37435f7e80ef9adc32a69013c18f135e3f434244
> 
> which shows that "fixed differently upstream" case and points to why.

Thanks - I'm dropping the commit from efi/urgent.

	Ingo
