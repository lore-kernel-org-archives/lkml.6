Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF299C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADB7820868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CKiVHeuZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADB7820868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbeK3C6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 21:58:07 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39404 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729152AbeK3C6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 21:58:06 -0500
Received: by mail-lj1-f194.google.com with SMTP id t9-v6so2177383ljh.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 07:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=da3AppwzXGPvOD3ftUCJ9KY8Z3DJWPfM0kVqOzkBmmk=;
        b=CKiVHeuZii+/DHBhJ7fahs/4hx8T+rhECFvCHTGGzzgqBVN/CLajirpLra6kdwxNG2
         M41BeDci91V2zADwPzcBGCxIofw9UKp9KaARUpyY7KrCWi7wCl9rS+fqCaaIkBl7VhcW
         LnJ3va3jbWFj0iGPN/16lK+wEJSNOFXJmmCGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=da3AppwzXGPvOD3ftUCJ9KY8Z3DJWPfM0kVqOzkBmmk=;
        b=UuQjYCRMR8Ai1+dYTmTJeJUcSGRUnPs0WAtsFdb8hIODJnnFsU3uf0LSI0kZ5B+tni
         ho4nl9wQkgETc0B1SBHUXgcFkcn9ioDv6i7gMr0lJBzOGfMTpq6MgB1C+tSuAVI9MNhA
         cBOBAXGiRULI0gERrgInR0aJMY2MdS8HMIyOVvhkGrLkPyyXuDwg6RJcZrp1Bs4ZsCaS
         HSw57wIWSSRoKlWhrI60cm5lfKkAOhbOGDPrZH/FNHTBoU1jBUrtRcsxmT4zU1zoeMde
         YzC35n2X5bnyHPEWrgiBIh776re0vjGKGPsXwSTvXJaRG9dkSxr4B9pds5byTnFWykZm
         /iYA==
X-Gm-Message-State: AA+aEWZB1GHLtDYHb6bEQj1mzPlZHlie+g6YEaISg8n6rJG9jlk7UBE2
        8M68/94MA2Ok6tm2rSJ1ZU4087jG3GydAJFveuybyQ==
X-Google-Smtp-Source: AFSGD/XrFZMyYNHZmdRmb265t4XoQZce67hb3u+8l/OsUj2oEFxIwQUuzDJv0uEEEU/gsMMULwUW0LLZyx37ZqpPVp4=
X-Received: by 2002:a2e:29d7:: with SMTP id p84-v6mr1478583ljp.12.1543506736812;
 Thu, 29 Nov 2018 07:52:16 -0800 (PST)
MIME-Version: 1.0
References: <20181128104350.31902-1-linus.walleij@linaro.org> <20181128152238.GV16508@imbe.wolfsonmicro.main>
In-Reply-To: <20181128152238.GV16508@imbe.wolfsonmicro.main>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 29 Nov 2018 16:52:04 +0100
Message-ID: <CACRpkdbDWztKxjT4p8mfVSZRauPNOn4PBd9yjxHD1oYGecor1A@mail.gmail.com>
Subject: Re: [PATCH 00/10] Regulator ena_gpiod fixups
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 4:22 PM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:

> It looks like the patches are assuming the regulator core,
> doesn't free the GPIO on an error, however that is not true in
> all cases. If only a single regulator has requested the GPIO then
> all the error paths after the call to regulator_ena_gpio_request
> in regulator_register will free the GPIO.

I guess part of it is that I should make sure not to gpiod_put()
if the [devm_]regulator_register() fails, I will go over the
series with that in mind!

Essentially the semantic is that the  [devm_]regulator_register()
call will immediately take ownership of the descriptor
and place it in the regulator core.

I'll check!

> Although this is not the
> case if more than one regulator has requested the GPIO.

This should be fine since the regulator core refcounts it,
when all the other regulators drops it, gpiod_put() will be
called as the refcount goes down to 0.

Yours,
Linus Walleij
