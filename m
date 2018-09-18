Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD95C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 575E62146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VFrzM0hA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 575E62146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbeISBhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 21:37:31 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:55047 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729549AbeISBhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 21:37:31 -0400
Received: by mail-it0-f65.google.com with SMTP id f14-v6so5098034ita.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 13:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bhm9ZF+DkgAGvPq0b8EK3vvIsdYQL+ONcDwXCxlKmt4=;
        b=VFrzM0hABwrx86JqYkF8PQvjXUQxCiyMb9xHGx4sGUkTtqMp5owQPSVkULUgayxwBQ
         2fAhiADObq7ujV5IF2VWWEt8FVtXC+YXaoZ4YEx0dObubGC+M4qTloSv0Fugz6im/epL
         MFnu6jyaTi/1j5Bo29l/GmnP6xL8l52VVVtQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bhm9ZF+DkgAGvPq0b8EK3vvIsdYQL+ONcDwXCxlKmt4=;
        b=FSTFNSAWL3TcrlKBF1S0ZVCdf2GgMIVXVe7lYlGnTBmrXfDZSZgtN6o1lf6+KmHgk/
         +tg+6JQ9xCxA0dQuUmZb53hnXDjP3hbGGCdyBWuUjAvvU8KZn9Y1vmLIIoSk8xoP+qT3
         YM2kGAy+6Hf8yWpjZWPWrXZzH3zlYD/sqoV2Z9JAbeg2iIhRhOzO4E5oSx2Fhk5RXCOV
         0VTuQH31cwRTamr5babCYhKtvM81qDYFme+aPhHhGGRFXhOJnM2yQFzu6++jbPpn4CTC
         bW7jbiU08zZ0MOTFXWz+O4SK82PKha5k5InMoRm0Po/QDebLO6aMS6m9VYh4NQ/a+MO3
         xS6g==
X-Gm-Message-State: APzg51DGghdN9TRe5DhX8sTAV0bLxAnp1zx34HERZglXwrbpsG+S7KIY
        40qpGGK3wyEWSjQiYFStIoaZULeQKx4YPo14GUbRxQ==
X-Google-Smtp-Source: ANB0VdYO+tFnCBRuwdahr4QE8ElRJYlOdZ6gx0hg35CyrkC7ULDZEkHTQ08Eh1CGrqSzHu/b2jCoepA9iNpOkL+S2cM=
X-Received: by 2002:a02:5916:: with SMTP id p22-v6mr27630660jab.113.1537301001528;
 Tue, 18 Sep 2018 13:03:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536404280.git.sean.wang@mediatek.com> <3d957d32b5b0f67548f63ae4ba7176dba9e61faa.1536404280.git.sean.wang@mediatek.com>
In-Reply-To: <3d957d32b5b0f67548f63ae4ba7176dba9e61faa.1536404280.git.sean.wang@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 Sep 2018 13:03:08 -0700
Message-ID: <CACRpkdYp8PFVgdc1=mtaNk5oxEh4om+5T-BwGh_TN2OkA2sYKg@mail.gmail.com>
Subject: Re: [PATCH v2 20/22] pintcrl: mediatek: add pull tweaks for I2C
 related pins on MT8183
To:     Sean Wang <sean.wang@mediatek.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 8, 2018 at 4:07 AM <sean.wang@mediatek.com> wrote:

> From: Zhiyong Tao <zhiyong.tao@mediatek.com>
>
> This patch provides the advanced pull for I2C used pins on MT8183.
>
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Patch applied.

Yours,
Linus Walleij
