Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233EDECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 01:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF09C20835
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 01:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fVABnPEQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF09C20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732983AbeGOCUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 22:20:36 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:43203 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731966AbeGOCUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 22:20:36 -0400
Received: by mail-io0-f193.google.com with SMTP id y10-v6so19793959ioa.10;
        Sat, 14 Jul 2018 18:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V1IqOWrjJGvRbGVeVRRzOiXoJB5jKbrdPR0NkiNm4SY=;
        b=fVABnPEQVmRfAN9WLJK4kUmsVkp/bEF34mUU9nw6TgIJtxbZpvQRx4LFXdB24mA0/4
         zOlMNPVgDtF73OylkIZ3bFgVwY7eCA+L1bpnxxoP9Nz+DQWnc+CSnz0wxFVsboD6VATC
         n09s05IWqL4oKEFSQ4M3MNZBCwQfz4RZjNEYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V1IqOWrjJGvRbGVeVRRzOiXoJB5jKbrdPR0NkiNm4SY=;
        b=rdf3i7vV7/k6A3MEukCjQy5ZlO1H3dmOihexOucTIDAdjAMJmOVlgUR5CmhMqLG+pL
         lrYPOqf1SYKS56RatT4pY6oRrifDlayBgyHfPwfLdoMIVOzs9KYJKMoGALurWA5acebp
         vHAqpmXJ0xvj6LFR1k+IlOiSibLeDp3rJ4rhi2wCdwM61JNrIEM67XnoilgVx+5UnU3a
         ly6ymgjOpI0+sEfYSHy335NPa2CNE9EFgznhr53NOimxFZxjV5AJpE+OZjXEH86nBaxI
         ArO3jKAPBCWKNOkkCo0Dhr3TndSVIUmlTzKRmvXzhKtls6QJh8dCYherM8e/od5bcm6O
         8uiA==
X-Gm-Message-State: AOUpUlFfBnGgyOhlJeNo7yi/shi/i0ziCXrgSiZRgBcfzZ7mSqzPGn5T
        IYAZvV2OPBShMHU+LVETX890PA/JH4W6LkD8I5c=
X-Google-Smtp-Source: AAOMgpddJDgBn2kvbG5eXc6pFmBd6TyjDPjmavCRktZUlbCr3AFM216nzmyl/rncM9EfflSCfKWvfxQ+7Tyzl23igqA=
X-Received: by 2002:a6b:274f:: with SMTP id n76-v6mr37167522ion.259.1531619969515;
 Sat, 14 Jul 2018 18:59:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180705161709.17028-1-bart.vanassche@wdc.com>
 <CAGXu5jJJLh+oMcZ94nkrwCvyJzk6MzOATvt66WC-rHfxGTJh0Q@mail.gmail.com> <CA+55aFzYEnZR2GZLR-DwpONjMNYGYoDy+6AWLCVNayWiaZuqoA@mail.gmail.com>
In-Reply-To: <CA+55aFzYEnZR2GZLR-DwpONjMNYGYoDy+6AWLCVNayWiaZuqoA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 14 Jul 2018 18:59:18 -0700
Message-ID: <CA+55aFynusYJ8OCS_jnQhOEEjrfVhYV5PLxi_XF8ritsWEcP0A@mail.gmail.com>
Subject: Re: [PATCH] kernel.h: Avoid that sparse complains about using sizeof(void)
To:     Kees Cook <keescook@chromium.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Bart Van Assche <bart.vanassche@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Uecker, Martin" <Martin.Uecker@med.uni-goettingen.de>,
        Ingo Molnar <mingo@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oh,
 and I meant to cc Luc on that email, but then forgot. So here he is cc'd now.

            Linus

On Sat, Jul 14, 2018 at 6:57 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Honestly, I'd like to just encourage people to get the sparse update
> from Luc Van Oostenryck instead.
>
> For a while there it looked like Chris Li would just pull from Luc,
> and we'd have timely releases, but that really doesn't seem to have
> ended up happening after all. So right now it's probably just best to
> get Luc's tree instead from
>
>     https://github.com/lucvoo/sparse-dev
>
> which also ends up fixing a lot of other issues.
>
>                 Linus
