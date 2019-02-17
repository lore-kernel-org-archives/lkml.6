Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EC4C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 21:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7221F217F5
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 21:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Koh5fs3J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfBQVZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 16:25:56 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39067 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbfBQVZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 16:25:56 -0500
Received: by mail-lf1-f68.google.com with SMTP id m11so10818715lfc.6
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 13:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3V4H033g6yROYK+yb2GpiGU5Rs5ypBfWJQgoDHKMY4o=;
        b=Koh5fs3JxgCkxRnvpBZGfYvpYRJHnF5rHQ248aLnqSUz7GNubkqOQUegHDHGzByZs/
         aUpuxaBEMBvh6purC6QdNu/IoZiQOiaAFlWQizx/gX9upQZ3uKT277xZcwzVdmoImOKH
         upB+eboUkSH3HOa0nbHNVq7zS6RnUk3GHInr7a5R8Z4dKVPNhRM4+l5x93yXIK+i/Wh8
         id4g2z19pfDQ+WuEe/zDj3WeCKTn8a8vAE2t+EoYo13K7Yy+87Kl5EPEbKnfysjXHueD
         e33aNCchPQwCwnBm5cUuQnOwSvEwzo/QzapL3cx6hirT7y9tnkTQuLH4HC+WtE001QT9
         rLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3V4H033g6yROYK+yb2GpiGU5Rs5ypBfWJQgoDHKMY4o=;
        b=p2x/45iL4y9PUVGQdly0vu1jyrrbOAJoidsTE2A7IYJPmguxRKUPErDe7gu1rLYkUW
         oKOvE0tZwY4DwaQMd4Tzfyzf7kj41tv1LWKnbgtY1DaXhtx7WnJvt/pHI+UIvZ92jFoZ
         nsy2jxE90b+6EnUdcRnaSmSr5yOSTzS88K3xoDYtanL/3yFWxQh/RLOor2+Q0kspNUXj
         AWoGiHyZuKBc+YSo0d6KIyOvetZFfhogQRY/gHYc6Bffb16qVdZl07vlnBw2tTBijuQa
         6aUXL+nZ44JWdi0R+2Xgosprg/QzFeYFKcrUQcyUUZV/McuMrE0ugWdQNq+7gEaoBZsH
         fqWg==
X-Gm-Message-State: AHQUAuYGRgSoyDxT4e0eV10/PUTGXMh3K8dChWL5opTstTmpDb3JA9yk
        jIyi1NL5HNWRnRaNtobep9TazjmaAyRgqhdJnaGnPg==
X-Google-Smtp-Source: AHgI3IYKr2MHouqah0JphRYs07mMUOjgG2gC0kpUDGDrTIE/doMGzfpSXD0mDzCGSI4FjlNumVvIaYlk1CB6q2m4/8g=
X-Received: by 2002:ac2:4343:: with SMTP id o3mr10707056lfl.129.1550438754083;
 Sun, 17 Feb 2019 13:25:54 -0800 (PST)
MIME-Version: 1.0
References: <20190214220338.7241bdc5@canb.auug.org.au> <CAFBinCCTbn0zMQqTzk2RvELCRBX1=Vf1QuY54Kp+BKc+sOmKHQ@mail.gmail.com>
In-Reply-To: <CAFBinCCTbn0zMQqTzk2RvELCRBX1=Vf1QuY54Kp+BKc+sOmKHQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 17 Feb 2019 22:25:42 +0100
Message-ID: <CACRpkdbUKzpKnozHpH8Gz6S41S-qxQS0DJrqTEwycqG3pz+OnQ@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the pinctrl tree
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 12:55 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
> Hi Stephen, Hi Linus,
>
> On Thu, Feb 14, 2019 at 12:03 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi Linus,
> >
> > In commit
> >
> >   a5a0bbca16cd ("pinctrl: meson: meson8b: fix the sdxc_a data 1..3 pins")
> >
> > Fixes tag
> >
> >   Fixes: 0fefcb6 ("pinctrl: Add support for Meson8b")
> >
> > has these problem(s):
> >
> >   - SHA1 should be at least 12 digits long
> >     Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
> >     or later) just making sure it is not set (or set to "auto").
> this is my fault - sorry about that.
>
> Linus, do you want me to re-send the patch or do you want to change
> the referenced SHA1 to 0fefcb6876d0d6 ?
> I'm fine either way, please let me know what's easiest for you.

I fixed it up, no big deal.

Thanks Stephen, Martin!
Linus Walleij
