Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AEBC6787D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 21:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC1032086D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 21:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hy9d1lVR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC1032086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbeJHEJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 00:09:12 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37883 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725755AbeJHEJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 00:09:12 -0400
Received: by mail-io1-f65.google.com with SMTP id m16-v6so10224460ioj.4
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 14:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6XOnNMz6WKdBl2hVQIOtmzPk/aLTsYy+ZRh5Lk6cJHk=;
        b=hy9d1lVREMaExInWfY+RkIKe+CFy2uwPXIEXhVQC9AxgMNu8vW/1Uc8UheRhBgwJRM
         PTd2FWU7PqBA+WQfq9bTIWcbv6zYWt0LcxeLNd7Xnab1Z0HyVLQpTaChRGgfeW4zn7jj
         9mgvblvEqoP8EdYrcwvsM2DRnO9lWgxJgHZAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6XOnNMz6WKdBl2hVQIOtmzPk/aLTsYy+ZRh5Lk6cJHk=;
        b=FcrkRSd2iFkUBqXZeyw94voDmbH1MHb9WIfTqWndr1FgXsodnmMjemtR7upsVHJjHF
         PRgZlgXDbI7JfjullSAT9jThSIZKkv2M2k57qIcpjsByyo5Fv3mXWFi275Ja2FjoudNB
         2x+kEwTrMeILTADlCsEvQ70oG9ghMqpLkrT1z30DDxz049NzJ9upC6FIL0eicOh3orI+
         thJ35GWld9wMNKZZxCtzOjALVzjb2QiXL1KY67dvTee+BJB2hL+G9pkL5QmQQbhU7j49
         qsMGnW2HcJNhgv8mCSQm8XQkfzuuopTvyvy+KrJ7As1pev8CA4OV8OtCqxm9DlU3HxB9
         fkVw==
X-Gm-Message-State: ABuFfohrbocS4hMf6/cLA2le3QlRdxrZbeff+EwURE1KXwW2hi9QtB7B
        PopIf4tZg6GykRiHDh4eY1N3ZAQqlQAvg8bH4MHoTA==
X-Google-Smtp-Source: ACcGV606rHUg40b7b5BZRTGggS80w7K1aEyZLey3aKcl9I8hGbjehnhEXPWp9CuoetwaNOVaFzSn6UTwAw31l9zXfxM=
X-Received: by 2002:a6b:4006:: with SMTP id k6-v6mr12802118ioa.277.1538946040925;
 Sun, 07 Oct 2018 14:00:40 -0700 (PDT)
MIME-Version: 1.0
References: <20181004090654.32233-1-linus.walleij@linaro.org>
 <20181004105031.GD6412@sirena.org.uk> <CACRpkdZZHYSRXktPLHKRc4Afsegn4q3rOmcPMhXh5chC1jH-JQ@mail.gmail.com>
 <20181004135427.GE6412@sirena.org.uk> <CAL_Jsq+Dpv1NohnMaLEV3ZMdHYBwMZMaFtftc8z9X1wORCCT3A@mail.gmail.com>
In-Reply-To: <CAL_Jsq+Dpv1NohnMaLEV3ZMdHYBwMZMaFtftc8z9X1wORCCT3A@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 7 Oct 2018 23:00:28 +0200
Message-ID: <CACRpkdaqOQ7Dj1pf7ZQ0qgpEsu_pJng6gLoYOYs6kc_e=U6b=w@mail.gmail.com>
Subject: Re: [PATCH] regulator: fixed: Use more standard GPIO binding
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 5, 2018 at 10:17 PM Rob Herring <robh@kernel.org> wrote:

> BTW, 'enable-active-high' is also a bit strange as that should just be
> encoded into 'enable-gpio' flags. We should really deprecate that.

I have been struggling with this (and similar flags in other subsystems)
and the current plan is to contain them in current state, but push them
into the gpiolib-of.c to get it out of the respective subsystem.

The problem is that is "enable-active-high" is negative: if it is NOT
present the line is assumes to active low, which is NOT the case
for normal GPIOs (flag zero means active high).

Therefore the binding becomes ambigous: if the "enable-active-high"
is NOT present, and the gpio flag says it is active high, right
now it should result in active low behavior, and we have no way
of telling if a certain device tree want modern semantics instead,
specifying active high in the flag.

Hmmm...

We COULD enforce normal behaviour on a NEW property
"enable-gpios" though.

Let me think about that. That should be a clean migration path.

Yours,
Linus Walleij
