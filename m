Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 62372C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17F352086A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dK2S/Sf3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17F352086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935898AbeFMPzg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:55:36 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:53968 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935564AbeFMPze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:55:34 -0400
Received: by mail-it0-f68.google.com with SMTP id a195-v6so4364177itd.3;
        Wed, 13 Jun 2018 08:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lmo4ZDx4+BdZkZcc1NiV/cTKZ3SYfCddmCoQP68m95k=;
        b=dK2S/Sf3E+y+Q15FXwn+kC+zQrjVEf+fWO7JwUDiwaCqFq3OZTSzJCJOKTvzD0tRfz
         6LL6xSHHTX76rkvvXkVLAmykNrenmaC9y6PVSteGDwulZs79p7j71tHUPhSxPRhC7elE
         oZ/UH0NaSz9zGWqm6gd3dl8HY0ciCMvlizKR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lmo4ZDx4+BdZkZcc1NiV/cTKZ3SYfCddmCoQP68m95k=;
        b=BhedS8PiGA4d8VQwOJ0eg69fDnlUmKyw+PXppe85j1NMDvSU+swQiTJ8wMoyEIxqVI
         p7NypXUXnNx8m6y02stDV8hiOpxtwpx/IS5fI6bZPx/trsN14Ua/NxJ+mLmpyLbxb/Dd
         sbcTg3mu5lfJ6aFiHzXojhMy3pK/U1JRnVfQo6rN02FV2hRa25s0sL1/yNMf8+/6a9aM
         9t4jnBtBAtQoLizQWdWjST+81d5WMRE4I/n8kzOl8CqpPvmYK8T6cBYEXmIUG8ZwkWl9
         oVit+YBHvLy042iPA5xDfITkvfAQ9W7LSG+zQ1/Sk014frZNsLDrY62PPXmEnYUn6NB1
         TshA==
X-Gm-Message-State: APt69E3DbjWeqYoHv/aEnPGsI4LPGZiDPjZVJnlxmb+SLfiEnbl5C8Mj
        Bfybbg84lObB9X0jGEEUQag/rdCCmTtqcJamAEQ=
X-Google-Smtp-Source: ADUXVKJy/r74HS+zJW0X3MtA9qdPwzS264l0c1jXtMujQVMNqR3FYHWnY+vfsBb+/HKY+g1XeHYzv2HHHH6IV5RQ/qg=
X-Received: by 2002:a24:5b81:: with SMTP id g123-v6mr5041826itb.1.1528905333680;
 Wed, 13 Jun 2018 08:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNARDLbEhbJGrKY6HGwfxL8ebAMBDa_2A+s2QkzQGEKyFHQ@mail.gmail.com>
In-Reply-To: <CAK7LNARDLbEhbJGrKY6HGwfxL8ebAMBDa_2A+s2QkzQGEKyFHQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 Jun 2018 08:55:22 -0700
Message-ID: <CA+55aFyxY9f9_eGv3CvA0zwzo8K5WeNbNPDFuyhtCrzRyic85A@mail.gmail.com>
Subject: Re: [GIT PULL] Kbuild updates for 4.18 (2nd round)
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 7:47 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Please pull more Kbuild updates.

Pulled. However, I notice a few oddities.

This causes a non-clang build to have

    CLANG_VERSION=0

in the config file. Maybe that's intentional to simplify other
expressions (ie allow "depends on CLANG_VERSION > xyz" elsewhere), but
it does look a bit odd. It looks like GCC_VERSION does the same. But
wouldn't that work even if  it's undefined (I didn't check the Kconfig
language rules)?

So if it _wasn't_ intentional, maybe add a

        depends on CC_IX_xyz

to the 'xyz_VERSION' config options? That would seem to be a bit more
logical to me.

Also, we already had one bug in the compiler detection due to the grep
looking at the wrong lines earlier. Shouldn't we have some sanity
checking of the CC_IS_xyz things?

IOW, maybe we should error out if we see *both* CC_IS_GCC and
CC_IS_CLANG, but also if we see neither?

Other than those small nit-picks, I  really like how it's more
legible, in addition to this part:

 26 files changed, 173 insertions(+), 308 deletions(-)

Thanks,

          Linus
