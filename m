Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A645C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14FA22077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="d+d+j8Mb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14FA22077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbeIEOGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:06:13 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:37408 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbeIEOGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:06:13 -0400
Received: by mail-it0-f68.google.com with SMTP id h20-v6so8629390itf.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 02:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9UqD1vzaTMww2Vd9w7y1sx05M2N303KeFe9xwg9OxMw=;
        b=d+d+j8MbtgTEKntaV/ILYkB89Ahd7qnL3Kc/zuUQufc028h1hDC453AsJGuAb3UUZU
         YsCqldzJfu4V1/6i4W6TAE6mnUbcxhl1pvEOwQfjYi+Zg+4UqhRGDIhtotxjK2eec2d2
         zzQMaMl1N6a+gSS8vfiuW1klLpnnut2KWSKmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9UqD1vzaTMww2Vd9w7y1sx05M2N303KeFe9xwg9OxMw=;
        b=VT0Got6gkXGS20fV5xibazjQHYbXUlsxRAzHyvgrhoIweZB4p08JczhZhTfe7Ggyoz
         L34FHSCv0WTh+Y+ccTfUh0cUeJHvv/MOhEz46UXnF2eHRrfCI1+pejy3tiurp0rNDHFv
         RKwqmG/SMTP+iB9g2tphRozX5fSaeZ2purS9Op7NZ1A44cLTBW8K8eST0CjUad6Ezu8j
         bLxc+m+IA+20ZKSXQjwxROqUOf85NdOgT8jqXNzL0vNzbreNQgi3vzNp72VwREFokVVb
         HZbWGP66QMx5GbB5n6ZZBoJzAZkyBc5C9XWoA88AhA/FsXklC3BcJpAvXS7rsQxI14S5
         1CQA==
X-Gm-Message-State: APzg51CBN9ZbXUoAliq976yX5CF75ttSHKypIQiFScdqmBBNtHygwhgG
        dqVVzcSfohEOi6z+5N7CDwbs+k5jYv5plBmbGDz0og==
X-Google-Smtp-Source: ANB0Vdbqb+UYjnOiq1l2gzeMXdrjbsBcQ1wB6CZfAgU8HarRayto02epCgnZaOWMd1/XHslfyTVrovfhIJIw9IJ5CAo=
X-Received: by 2002:a02:6c45:: with SMTP id w66-v6mr26143992jab.87.1536140210579;
 Wed, 05 Sep 2018 02:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180830144151.13417-1-marek.behun@nic.cz> <20180830164743.63c6e27d@nic.cz>
In-Reply-To: <20180830164743.63c6e27d@nic.cz>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 5 Sep 2018 11:36:39 +0200
Message-ID: <CACRpkda8iVV6-J14L95cioJEL2eGSra9uNbPL19F6N7ijnjZiA@mail.gmail.com>
Subject: Re: [PATCH mfd+gpio] Request (Linus Walleij + Lee Jones)
To:     marek.behun@nic.cz
Cc:     Lee Jones <lee.jones@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 4:48 PM Marek Behun <marek.behun@nic.cz> wrote:

> Hi Linus and Lee,
> these two patches touch two different subsystems (mfd + gpio) and
> should be applyied one after another (the gpio part is dependant on the
> mfd part).
> The patches are based on mfd-next-4.19. I can send another copy based
> on gpio/devel.
> Could you two, Linus and Lee, work together on applying these patches?
> I don't know how this is usually solved...

If they need to go into the same merge window this is usually solved
by me ACKing the GPIO patches and Lee applying all of it to
the MFD tree then providing an immutable git branch to me if
I need the same changes in my tree.

Yours,
Linus Walleij
