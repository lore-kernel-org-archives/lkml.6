Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D8FC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB59D20665
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IY8xSVKB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfAISbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:31:08 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45369 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbfAISbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:31:07 -0500
Received: by mail-lj1-f194.google.com with SMTP id s5-v6so7328926ljd.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 10:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ce/DODD26yFEvlMGuasUOyI+VFOgUCm+7GsCPyVgRv4=;
        b=IY8xSVKBxUihEieMmiVeZWlluuxX+wotnXcvpzcCJW3eo+hdTOHWSsR5o5pDJCjBJk
         zPf/Mo9wlkwaAk1Pp8GgB91IMTBD1/17RbQ0tNVp/pLSlIEkaN5PAeS0715SXGIaTeNl
         1OHEzC1fC1LYVzESSkOwI9KWg09cg9PZa7uH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ce/DODD26yFEvlMGuasUOyI+VFOgUCm+7GsCPyVgRv4=;
        b=MMIBA31P0qAjSDuWfg+7Po6PvB+EOUXXEWsqbPMWEYtbbRgSAUun+nNX6oI5lgZssf
         ijCovcgl6z0MIJWObW6isg1zFO3+EqS8XDRfjEgrqNACVfNYyrvGoB8TEHveXSbC7RcN
         P5ymvfAe70rLxc78Qt4crmZ8tZRjMMPkwOwZzRUgjMjudrsiTQz/cT3uQrlgCBJUktgo
         LVKwqGc32ZbYjS+Cl00WU3ccuekhOzwPR6hb0BB+fFfS9nRMdns1aLhQT7tr61JqqcOj
         M8/DPFTtZNzwZ0g0GxHBjQ29pL+OAEUg+ndNPyunGkxYvN0wkdqzwrRZ5GiwKXUAXgw/
         fH2Q==
X-Gm-Message-State: AJcUukcEzVY5tJX7SAiicevYVUYLUdTEpgUhDpEh414gDPPFZXUBF7Sd
        0+wRa7yzDR3a3PuZpR2rUkSom6mS0L2VQJay1zeu6Q==
X-Google-Smtp-Source: ALg8bN4jIAccrE+Ui7PhA4BsjD7tt+eW6OjQ7jBZdVPqs7ct/u0Ni8dEYUBnmp98bWowikeVQrE1VRw11OmNeCaQhlg=
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr4088776ljj.9.1547058665214;
 Wed, 09 Jan 2019 10:31:05 -0800 (PST)
MIME-Version: 1.0
References: <1547042198-17601-1-git-send-email-lollivier@baylibre.com>
In-Reply-To: <1547042198-17601-1-git-send-email-lollivier@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 9 Jan 2019 19:30:52 +0100
Message-ID: <CACRpkdbhVB7-Y9EBhBC6GAxqFt8zujS2QJ4CzGDJnDMDjj2Ptg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: meson: Fix mmc cd-gpio polarity
To:     Loys Ollivier <lollivier@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Kevin Hilman <khilman@baylibre.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ollivier!

On Wed, Jan 9, 2019 at 2:56 PM Loys Ollivier <lollivier@baylibre.com> wrote:

> Commit 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
> changed the behavior of "cd-inverted" to follow the device tree bindings
> specification.
> Lines specifying "cd-inverted" are now "acitve high".
>
> Fix the SD card for meson by setting the cd-gpio as "active low" according
> to the boards specifications.
>
> Fixes: 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
>
> v2: fix more occurences, also in other meson boards.

This is a good change in itself since it gets rid of some occasions
of the dreaded "cd-inverted" property. I think Martin Blumenstingl
already sent patches like these though (I might be confused).

But we should keep the old device trees working as well.
Can you test if Martins patch:
https://marc.info/?l=linux-mmc&m=154637189021211&w=2

Also makes your boards work?

Yours,
Linus Walleij
