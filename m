Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD06C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 499CE222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UIcKCeXo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733311AbfBMOWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:22:53 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:51060 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731306AbfBMOWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 09:22:52 -0500
Received: by mail-it1-f196.google.com with SMTP id z7so6389469iti.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 06:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dt7EwH0wU09rDKGwwGbMfe6lUinGuQ6f5KcIUgyhw2I=;
        b=UIcKCeXofzBdpiYSM9ja7ySRDYK8fSkp1w+zKIzJZLIQ+6olx1c6Fu/zN3abTTgYVL
         CaYyBJQQjQWI0r65B4siobcgvxpmzcbbK3jYxnvQ3LtW+15pNQJMzAH2AqTCVfB0GQbu
         5mfDAP0SA2EnuBfLkzVTFlRoILy7dITaSFKdYk5xTdCrir0CAOfvARRmynI04IMz497O
         xrKGcusnwDEKXas0NPYY0fXRMmJqTqHzlGLWuFYYou9+mGA+sEADpoC2vbXgR6I9RBNU
         4bH/FnKD6FsUNSODArdHKQmYx3KKy0EdRLpOy7Mo1Qi6EoqhMBHNAm03gt6kymP1lMXW
         1vxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dt7EwH0wU09rDKGwwGbMfe6lUinGuQ6f5KcIUgyhw2I=;
        b=N5tF8tN+5K43py9wwNcrIqUAmrmy1S8Qu7dzPpWzAU2YpzeLYwp4gaqQTCvsDTR4CV
         jSBXe382V75L2WtawPRhn/nOOh3P0E2dcGUytOb2XPARFfLxr88wmbyC9SZ5DOG9UPDf
         jmqxp52na+yqypNtAtOPv9LeujREaOekBcBRzt2bLkrsnRZDJngfyeF2XXGI3vgNfNXa
         fyfDXtuaQFAaRc1uv+hfg3Gi3v5slMZyugSxY/oLvxBAFWqX2xCwURkgopcYA55Lb8Ut
         waxrY83auGwiFgo5goveMG8sE9p8kONIJFillUKgLVNcUKqvB0O3AVfqHqoMWL6YdPDr
         ZRrA==
X-Gm-Message-State: AHQUAubhGpIwYZA/6dLw+gJDAhawoIxE1X3WQZ0b9PjLOjNwIYumjnQq
        xS8PsbI9SbQYGmz5x/VKSzVKMLY+qfgB2kuw3+qO8Q==
X-Google-Smtp-Source: AHgI3IYUXUKGYLV9RnyjFdJCe+Vo7bGCAVXGmU3HPf1eDouLaYHxhTgqb+JCrlQfMuNb8gtZ1dgrplshSv+EUSqU3EA=
X-Received: by 2002:a5e:d609:: with SMTP id w9mr430409iom.170.1550067771719;
 Wed, 13 Feb 2019 06:22:51 -0800 (PST)
MIME-Version: 1.0
References: <20190211143052.3128-1-bsz@semihalf.com> <20190211143052.3128-5-bsz@semihalf.com>
 <20190213112640.GI7087@linux.intel.com> <CABLO=+ne=dfrMiqmmxV_xOPt7QKiwSgnmokgod6ZMn4PZeahvg@mail.gmail.com>
In-Reply-To: <CABLO=+ne=dfrMiqmmxV_xOPt7QKiwSgnmokgod6ZMn4PZeahvg@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 13 Feb 2019 15:22:39 +0100
Message-ID: <CAKv+Gu9_AgkDO5+Us0=WyqKKiV3m-Ajdqx3-NyqqN+kazuPXxw@mail.gmail.com>
Subject: Re: [PATCH 4/5] efi/libstub/tpm: Retrieve TPM event log in 2.0 format
To:     Bartosz Szczepanek <bsz@semihalf.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        peterhuewe@gmx.de,
        =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Marcin Wojtas <mw@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2019 at 15:21, Bartosz Szczepanek <bsz@semihalf.com> wrote:
>
> On Wed, Feb 13, 2019 at 12:26 PM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> > Collides with Matthew's changes. I want to land those change first
> > because they are almost production ready.
> >
> > Maybe you should consider reviewing those changes to make sure that
> > they make sense to you so that you can build these on top of after
> > these have landed.
>
> Yeah, I think so. Actually, I wasn't aware of Matthew's efforts, as it
> didn't appear on linux-efi mailing list. (On bad, I haven't checked
> linux-integrity.)
>
> At this point, I think it makes more sense to limit this patchset to
> 5/5 patch, which makes TPM event log initialized on ARM platforms.
> Patches 1-4 introduce nothing more than Matthew already did, maybe
> except putting calc_tpm2_event_size to a library instead of making it
> inline. This function has already grown a bit so it may be a better
> approach, but that's nothing to affect functionality.
>
> I'll pull Matthew changes to my tree to confirm operation on ARM
> platforms, if that works fine the only thing to merge would be 5/5 +
> optionally the library change, if we reach agreement on that.
>

Sounds good, and yes, it would be good to cc patches that affect the
EFI subsystem to linux-efi as well.
