Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFE7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F8721841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="bqaaOx3s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390304AbfAKTq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 14:46:59 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34596 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731874AbfAKTq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 14:46:58 -0500
Received: by mail-ot1-f65.google.com with SMTP id t5so14180444otk.1;
        Fri, 11 Jan 2019 11:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EwTgfDXrGBWBRBGzaiJXo8VHk0775DRmtyXsq02SAvM=;
        b=bqaaOx3sssmsTrQ3h7GuQyKeOcWKYkpbOSjvxdKeUQ1DJnlQ4qHQ/9A4ILpe1W5rQv
         E8GTyW759XNnfbcfdJhmUFGhLD+LPw8vkttUxQfCCLP4iuTZPuv1H7o+nr0ilGw4zgSB
         bufGrBdMn7rx3pl+wJiC8weSNEiEyZAxh8TfodqjZWaYyPmaVL8QBOghJLlBm4F9GWNo
         fQhDfnnNQgHa76oPSsX1ov3+wo9xqm7UMQwFQ53+IcUnhD5dcIklXdXPGOqBdVp9IEGX
         kEwru6EZqygU0npbrl5AE8vT+p9tmX12AnuPl5mwDiWLtSpLxlB/7bWhZ/Mf1FosKDRY
         ftbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EwTgfDXrGBWBRBGzaiJXo8VHk0775DRmtyXsq02SAvM=;
        b=lxoql4nUVXdhnZ1xIL52KCBBVAm1fZI5EV2r9c2+wa57uCm/eacXTATkI+FP7GzXS3
         GkX3xRznOFRpF1zyWhZoooZTBVwBijL8KBolQTXtagVa81r0ZYF1VsjQk4R0+l+sesDK
         bjo58kp8S9n1boHcU6HXLyvROw5QVrLU3ptpNYNGjYNIUIdU6D4lyw8LgL7C1XaF8/zJ
         KtlfmwQ3P/jumv01+5xvMt2UTbKJvdLPKdsYvIc8Aghnm7RPHK4d5jWUBe5U7iAeKWnW
         4B+YIlom4RQIpH4Mc+/pWF1EvlrT5LYt0NruT5Wvjc2nunc/NUnRphBxJq8ZIWEYQjLA
         xtqw==
X-Gm-Message-State: AJcUukdzHxTK2jLpyzQY81MuSLESJbFUhDooWmDPFOEfxk4vO/YA3cO3
        1j/rNsSakaQV5VGNrwNWj04A1UeeSowV5+arQVI=
X-Google-Smtp-Source: ALg8bN5f4HT8rVu0DCXSn8Hw4Osm2eSQ9//ixSJf68In5OGFFe5oVpm2OYQ+jKTrNLv4mr9Dpt9hbraZ+jo0dkayi14=
X-Received: by 2002:a9d:7749:: with SMTP id t9mr11061364otl.342.1547236017328;
 Fri, 11 Jan 2019 11:46:57 -0800 (PST)
MIME-Version: 1.0
References: <1547134822-18498-1-git-send-email-lollivier@baylibre.com>
In-Reply-To: <1547134822-18498-1-git-send-email-lollivier@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 11 Jan 2019 20:46:46 +0100
Message-ID: <CAFBinCDM4BTx0Ude-M=O6B2bXPE9EdfD=VxZfFzR9Dc=yT+xWQ@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: dts: meson: Fix mmc cd-gpios polarity
To:     Loys Ollivier <lollivier@baylibre.com>
Cc:     devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

some nit-picks as well as my Tested-by (in case it's not too late) below.
thank you for taking care of this!

On Thu, Jan 10, 2019 at 4:40 PM Loys Ollivier <lollivier@baylibre.com> wrote:
>
> Commit 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
> changed the behavior of "cd-inverted" to follow the device tree bindings
> specification.
> Lines specifying "cd-inverted" are now "active high".
this depends on the polarity from the cd-gpios property. above commit
caused cd-inverted to be applied twice (effectively making it a
no-op). thus "cd-inverted" only means "active high" if cd-gpios also
sets GPIO_ACTIVE_HIGH. if the polarity in cd-gpios is GPIO_ACTIVE_LOW
together with "cd-inverted" then the GPIO will be treated as active
low.

> Fix the SD card for meson by setting the cd-gpios as "active low" according
> to the boards specifications.
not only switching to GPIO_ACTIVE_LOW, also dropping "cd-inverted"

> Fixes: 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
in my patches for the 32-bit boards I used the commit which added SD
card support to the board for the Fixes tag. however, I'm fine with
this as well (I just wanted to point out that there's a small
difference in our commits).

> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
on my Khadas VIM(1), using Kevin's v5.0/fixes branch:
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


Regards
Martin
