Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BCBC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 21:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAD39214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 21:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MWzcD5dp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbeLZVCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 16:02:03 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33689 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727568AbeLZVCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 16:02:03 -0500
Received: by mail-lf1-f68.google.com with SMTP id i26so11535149lfc.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 13:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PFLjViSYXY2D3WVmuTQ+tl/WLX+R8ZsUSb6iaIjjyq4=;
        b=MWzcD5dp3N6jOH9+VuO/SSm+BXrGGCF0rtzOFRucYMhlyXn4ddXCmIAgrROJ6lhpaD
         FJeNjARXu8yfZQv+RdzetoPNbeyYw/akYEt94gxvom3VRGhrm0KjTWwkDzDLfl4ftQxY
         7z+yDd0MWLKRXpeyBIq2Ic2P2/hJONSIHo8K0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PFLjViSYXY2D3WVmuTQ+tl/WLX+R8ZsUSb6iaIjjyq4=;
        b=Wd5WlanqYWqKyhKcWhbkCkRrg8z58j1KrprYufwIojdLs4tIPC08YMebdubEqW12Fa
         7I6Q33jHASv/s7krMDakeT7QyI/AM9NQXJxz3xFeJACNjMGj7ScQ66/X5Bq1Ucjdcdkk
         5Wn8cGAuwvSBk+7/i9xRh6uywbnZRc5EdxC1Zwm6rCgh0VMKSbONpxPD7h7j/nHDONVi
         r5Hh5aJIzpDRgGCoyrjA6sKvRmiS4DczDjzWP1f5PbM4Ou4QzdEuXond6iXDwgsuXXrZ
         T3U8e7+jLYfWF9YyyueyFIabZ+tlpfrSswttKTXmIrO6dF2bhec4Pb4KEAuC/dfxqgdt
         ehrg==
X-Gm-Message-State: AA+aEWbl0NBbKsxpuO5PKcQxNImqLVV09Q5xy3GwR5OqShdLbgxUtUgc
        qebJelemWhe8gmmjZA3KW6CG0uCVtnQ=
X-Google-Smtp-Source: AFSGD/XzyLnigp3q/Ue+LqoPqH8MG67I27iZinYLmTo+wLxZs6lEgAEjQ4C96i3ieX3Vtl169aH+dw==
X-Received: by 2002:a19:5601:: with SMTP id k1mr9132109lfb.99.1545858120391;
        Wed, 26 Dec 2018 13:02:00 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id f1sm7310072lfm.22.2018.12.26.13.01.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Dec 2018 13:01:59 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id e26so11520731lfc.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 13:01:59 -0800 (PST)
X-Received: by 2002:a19:7006:: with SMTP id h6mr6785495lfc.147.1545858118621;
 Wed, 26 Dec 2018 13:01:58 -0800 (PST)
MIME-Version: 1.0
References: <20181223124859.GA26860@zn.tnic> <CAHk-=wiX_6f+7DUaG-x2cQHctjtSHdMrtAeixitOQkbswq2scA@mail.gmail.com>
 <20181226205616.GA4557@zn.tnic>
In-Reply-To: <20181226205616.GA4557@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 26 Dec 2018 13:01:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgqiSG_TgdDgiCAGHq2d9-o-XSkB5P=QR=qypCD9KvUiQ@mail.gmail.com>
Message-ID: <CAHk-=wgqiSG_TgdDgiCAGHq2d9-o-XSkB5P=QR=qypCD9KvUiQ@mail.gmail.com>
Subject: Re: [GIT PULL] x86/cache updates for 4.21
To:     Borislav Petkov <bp@suse.de>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2018 at 12:56 PM Borislav Petkov <bp@suse.de> wrote:
>
> The intent is, AFAIU, to keep at least the user interface in the resctrl
> fs the same as on x86 so that there's no unnecessary user confusion. And
> from peeking at that patchset a bit, it looks like we'll need a generic
>
> CONFIG_RESCTRL
>
> which should enable the arch-agnostic piece in fs/ and then
> the arch-specific counterpart which we'll probably put behind
> CONFIG_X86_RESCTRL and CONFIG_ARM64_RESCTRL, respectively.
>
> I guess I can send you a patch renaming the x86 config option to
> X86_RESCTRL and the ARM64 side will fall into place when ready. And
> it'll extract the generic bits into that separate generic config option.
>
> Thoughts?

That sounds mostly good to me. Except I still think that
"CONFIG_RESCTRL" is too generic, because it's really not about
resources in general, it's literally about specific CPU resources.

So I'd prefer to call the option for the generic code
"CONFIG_CPU_RESCTRL", which is then selected by the arch option (ie
CONFIG_{X86,ARM64}_RESCTRL).

Anyway, this is mostly bikeshedding, but naming is fairly important.
But not time-critical at this point,

                 Linus
