Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 581F8C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF8121784
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e7uUBG9j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFF8121784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbeHCTDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 15:03:52 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:36849 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbeHCTDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 15:03:51 -0400
Received: by mail-it0-f65.google.com with SMTP id p81-v6so9361709itp.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 10:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jnZjAZpGM+EqB/jC83RaCGYOnxP4JpUwUp2uqPdbL3E=;
        b=e7uUBG9jlN/la9bBU7biG7htk/0hZVYvp9hHjSpugwjDepDgMQbXsbdQMMpGizfe7l
         Bb6xvUzof2oGRysvfGZt8jaG5pDaJIH11AqRLq9LIrH2BY4kdT9qEkEr4x4pgoE6aL4w
         vVwYpZsXomMApoLhGV/pcI9F9bjDwsmKOzVWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jnZjAZpGM+EqB/jC83RaCGYOnxP4JpUwUp2uqPdbL3E=;
        b=RXT41tgSnfNIc+eR1TzmWbFOEcxT9MfegqqIkBuRdKwVVm5bIQIfCjO8xgBK4+nfBa
         mfOXoz1trGfn0bQo7lInNsoht/un2jFke5tpMipzpJD9yGpJMxneT7e2F3qzslLxYw/C
         3CeUxNZEbcnqhgRU15MTisih6QTiGuUTXCUM41/tZuoimDf3LJiy5tnDAob250sneSgh
         O5tcd8q5i+AtJ3RvZm/6FRlff0gX0B5uE1HoLMkWA2Q457+aXALPpJRUjk7zq1lahm3q
         m7KejnNQVyhWeDMfBzK8FmzpcyuuQaxf4G6Ojdmg3fFw/n0qizIUIUg1d273mC6KlpN5
         XdIQ==
X-Gm-Message-State: AOUpUlE0GKxESfqRra8NCpBYuOIIt31tiIb81IsXfYVgBbWveenqrCXF
        5yCiAm+4uFs0e/OauuNczHsGv6rsf3KSzwTcv5koWw==
X-Google-Smtp-Source: AAOMgpf/CaPOV6UmCsbgpP3m45UilNCCoe6GolqF6zm3PER3hcOEgFk1juMlujlQ3RYx50PpEqp7inIIUc7euNX09DE=
X-Received: by 2002:a02:2505:: with SMTP id g5-v6mr4176148jag.112.1533316002084;
 Fri, 03 Aug 2018 10:06:42 -0700 (PDT)
MIME-Version: 1.0
References: <1533117623-27856-1-git-send-email-narmstrong@baylibre.com> <1533117848-28194-1-git-send-email-narmstrong@baylibre.com>
In-Reply-To: <1533117848-28194-1-git-send-email-narmstrong@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 3 Aug 2018 19:06:30 +0200
Message-ID: <CACRpkdbpe4RjCa6MnC=hvEEHJq8SAq5UAzuVKRU_rTxx_hRyDA@mail.gmail.com>
Subject: Re: [PATCH 1/5] meson_sm: add TEST_N pin direction call
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 12:04 PM Neil Armstrong <narmstrong@baylibre.com> wrote:

> The Amlogic Meson GX and AXG has a Secure Monitor call to change the
> TEST_N pin gpio direction, add it in the supported call list.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Looks fine to me, could we have Carlo's review on this patch?

Yours,
Linus Walleij
