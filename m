Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B94EECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB3D320871
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GolFZH5t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB3D320871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbeGPNbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 09:31:16 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:37839 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728734AbeGPNbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 09:31:16 -0400
Received: by mail-it0-f53.google.com with SMTP id p17-v6so21179753itc.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 06:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iMnw6wD8ayCsAY3s5wGqnXZGrWKraHxbSHUhkbBz+84=;
        b=GolFZH5tXgGG0T7e5HLJwkEAGeRswobtJMimBgLxkvWDVWFMwwGb/a6UAC/qtaavEM
         DkghDLoeJ+ZC8XxwfoTVHJMfAiXC3BzP9uYFm/sdUCmoCKiYnvrqzBlnuRXR1bVR56JZ
         Q/ZaFFgRaUvcmw267VUn1MlYKltWf4v2jgzoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iMnw6wD8ayCsAY3s5wGqnXZGrWKraHxbSHUhkbBz+84=;
        b=gTVfVA6dUOkKYOGruoqz9ztiDKr2nKVJ0Rs3ZpdpE5scHrGytYf9+uwrjA516tZ0V/
         90Y3ve8wH7vVNAhbzzmtRh4X/ES6235gbD0BDjqo55Ai4wL0N5xsfL2XIbD5k0H719NI
         t3cVY3FWWwa+7U4UT9Yz7vu+ef0dEYFVRtjVAKeY3P5sNJBRkPXtEYjnIL6dCLRYE8Q4
         9e0HON44Qv2eFOwtRr3zw3G6a4KU98CCI/KiW5ZwrA+Ekvg9dBBI9/DNYn39rouDTtQL
         vOaZlRQ+YDDY8+v0W6xdljXhvocag9obksMr9RU3U7kpYH7JlwWlu+HVk6GntCNK8lRb
         fTZg==
X-Gm-Message-State: AOUpUlH611eTBSWOM0s6tJeoffOE25mMuaU8PDCFoWUo0S2oJr6DQSoF
        Ru5OqIYIeB5Sjd87bbrJgOYpHubWianx1trjgy3CRKoH
X-Google-Smtp-Source: AAOMgpeZSLed5oJhhJ6ItOGV54ucex/54lLuA5uD1pCjxH3R11kHQNnAdVGdzyu4xVNIgRAmh9ZA+TI/Fah313BuCmk=
X-Received: by 2002:a24:2c49:: with SMTP id i70-v6mr12760439iti.135.1531746234147;
 Mon, 16 Jul 2018 06:03:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180716081018.21bfe495@canb.auug.org.au> <CACRpkdZ5BA1wn=TPn4yWkwWd3pAKh9wuMHd9woBF=+6+L1jtFA@mail.gmail.com>
 <CAMuHMdVRfEcxo0SVW7VkmE-1bjsESKeL9nRk41W32_2V6rpA-A@mail.gmail.com>
In-Reply-To: <CAMuHMdVRfEcxo0SVW7VkmE-1bjsESKeL9nRk41W32_2V6rpA-A@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 16 Jul 2018 15:03:42 +0200
Message-ID: <CACRpkdbC6Z6NY2LAki2cwyGs4ohokWoXYBBR+gAx4DPU0S-YsA@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commits in the pinctrl tree
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 9:59 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> The previous issue was a missing commit from the _author_, not committer.
> As you rebased the branch, _you_ are now the committer, not me anymore.
> So now your SoBs must be present, too.

Yeah I figured. Sorry.

> As I already told you I had fixed up the author SoB, and updated the tag,
> just drop the above commits, pull sh-pfc-for-v4.19-tag1 again, and be done
> with it ;-)

But it's no fun if I can't do all mistakes myself! ;)

Yours,
Linus Walleij
