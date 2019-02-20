Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD31C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 21:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E852086C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 21:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jq7Tdnd4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfBTVe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 16:34:26 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42926 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfBTVe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 16:34:26 -0500
Received: by mail-lj1-f193.google.com with SMTP id d14so10960254ljl.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 13:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3trbI8pAyfyHzm4QX6NgBRXhMXkjLI8j9cMt8yTmi+M=;
        b=jq7Tdnd4m3X9x5SUZ0T/TEu6ABRUb59lEXFH/1kuBTq3cQxouFxhyW/pDh6bg+tvnO
         dzd8D7Hp/VmXKMFsFgpfQoXrN2gExICQfP/Hyhc2Twu2pvaVr0hFmJBbTBSa7v+xkajY
         YJCDREDI8w74zKvg/WDga5MV2bbWQCxURFbtDh2bodA4LNvmUcphYEA3r60bzms4Izul
         fyxo8J2f4RQUgBTVV+QrwD3LAsYnvV0OCXuqQHWA9EbXkTTlA567Slg7eJks9KRRjM/W
         wiXCans4OzCL8jHHQ5VfnhKLFhLf4/LrKlO6OcMIvJ7QJ7UzfxRGj5Cu0547wg6sKW6d
         KbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3trbI8pAyfyHzm4QX6NgBRXhMXkjLI8j9cMt8yTmi+M=;
        b=XMFkrSkg0JPxYfeYlLJx29kT13jX+VY5wnN7Kmyp1LdHjFIfgpMl859KZX5Rzb904H
         wfWAv61R+5TkNpbPO5I7zg4bVeWiAaT/w2zc+I4Eduxx24sauwkDvSzGc/0GB5DVtxpB
         zphDlZTVG72vvFcb6uvGWuqcJurp1M1op6twk53GLT7Lz8G7bTE15TJJ86NB9RTgtSd6
         9vulnKNj/vlAKAKox7UmKySgZOG58Gv+husjm4ktQwB1+sZ3nJTaD83aRbITRwL+6iww
         e+b15ONEXtMKmmif/3lRZVgb5tcZKjvMhF86CnGP8CtdS8OIBEpHO44hX7todEB03EiW
         t9gg==
X-Gm-Message-State: AHQUAuZXd2NKsZP+GHMIPU8RQWUXjeD1pB/kzfS1Ph/7745AwV/264Ds
        KAIeY6kufx0k/AbXDSnezrUnDF6GwIqz3BKzwPGFvQ==
X-Google-Smtp-Source: AHgI3IYUQVYYPAeW/b+YZmg8aSTJs3bhifhEMCeMkjdtYMeq/s1iVXCBN/CL20r3RavThtC0TPy9Djm2wznxcVrMtto=
X-Received: by 2002:a2e:90cd:: with SMTP id o13mr12521636ljg.153.1550698464069;
 Wed, 20 Feb 2019 13:34:24 -0800 (PST)
MIME-Version: 1.0
References: <cover.1550671256.git.hns@goldelico.com> <a1fcef308d9193cac33cda2420b6df5000cfc9c7.1550671256.git.hns@goldelico.com>
 <20190220161017.35f2f3a4@archlinux> <49606C25-608D-4F77-8038-E2C7A11B861D@goldelico.com>
In-Reply-To: <49606C25-608D-4F77-8038-E2C7A11B861D@goldelico.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 20 Feb 2019 22:34:11 +0100
Message-ID: <CACRpkdbSsOcem+_JZNXvjC9KA-F-+O40aAnLUq0CcrO25YCQuQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] iio: document bindings for mounting matrices
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Song Qiang <songqiang1304521@gmail.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Sebastian Reichel <sre@kernel.org>,
        Samu Onkalo <samu.onkalo@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 5:18 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:
> > Am 20.02.2019 um 17:10 schrieb Jonathan Cameron <jic23@kernel.org>:
> > On Wed, 20 Feb 2019 15:00:48 +0100
> > "H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> > Hmm. I looked back and seems there were still some outstanding questions
> > on this last time around.
> >
> > https://lore.kernel.org/linux-iio/a6d866f2-ee20-282b-def0-f65de2177aee@kernel.org/
> >
> > Particularly hard as ever to define the magnetic planes when near the
> > magnetic poles when in 3D.
> >
> > That needs cleaning up ideally before we apply this.

I agree. I guess I ran out of steam somewhere when I had to
look around for my linear algebra textbooks and course notes
and I could not find them :D

> Agreed. I already placed my proposal for improvement on top of that,
> but I did not try to solve the magnetic planes issue.
>
> Maybe Linus could squeeze the patches and edit a new one that solves
> all issues.

Oh I trust you 100% to do the right thing with this, just edit it and
sign it off a second time. Whatever becomes the author is not
something I care much about either, whatever makes sense
to you.

Yours,
Linus Walleij
