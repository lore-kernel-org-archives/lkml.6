Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64991C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B07A2084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="lREnOr2A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389020AbfAKT4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 14:56:00 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36942 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729938AbfAKT4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 14:56:00 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5so7212796plr.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 11:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=OEko4Q1k2V9fZxblUwJN/ehB2KPRXcsUj+UxLIJ/99E=;
        b=lREnOr2Ab7Kk0yTYlqBE4YoNQuckrSl/N1T7ZYdoiFR8nIrOc5ApkvV3G4eTPNrOdw
         uSj15PfeBjfHhUSAtIAorUyKZuqAO+zw/2CYIE8C1vDGOhR+Q4qSl0RPqc3fm1eAyzN1
         6O/s6BKzHyPPuT0PDA1QAbLYOl2/eoY0qN5Fv9pXO0DaRRnd9Ucb5ThU7+M9/cH6ri0s
         omlTZ6o3vAw37lLxsBheXZbVEc6RTZ/Z2M86lVmk+pmDPYibEEBWvuuHPF8l4z7O48Y/
         mIvsE0TWTzuZz3UrqUZWJ6uZyeoklRaUswl90hxYN0UHG/Pq2xzXhjEdI0Ra20BzG5c0
         0kpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=OEko4Q1k2V9fZxblUwJN/ehB2KPRXcsUj+UxLIJ/99E=;
        b=rFkkhodD8ckRoNTYWKgXbxVcXW60tYocJhC8qMfstwmIUxxQue8k9rQSiyzH66v2+K
         Z/A5RzcaQ8YcI5hV4CZkL4DP/XVbzEcbZ1Cu7P5vyue1withGAEdmdyzlrrEyRb+StDh
         MHp5k/BFvzrQ/odqbJZzMzqAsQNomeZZo4RN++g3MHcfYGs1KlMWf7RwkYCsv6f9iA3P
         irqE28kf52ksFuEUXHTmFhB7UW/ev2rMQ/EQV/VmJ/WJ2FtYUd6gwOgT9EvZak7oApbS
         rmHxkE1MQ7hMhhK67GHOMuzn5FrdjH1sWqCIi3d9zdxksqcvf9+F/S8tZCMwJ7KPpsEv
         0G9Q==
X-Gm-Message-State: AJcUukcXJ/w0+cyO3hTJDAZYvaMYE5UF+fEbQt+F4Qm6SEV8ZUB9FxZA
        8jceLYRqAhDYLOK885zLSLA2Yg==
X-Google-Smtp-Source: ALg8bN5L/trq5QYIz/32j0sWyti7NW7gpTBlSWdiqFsYW+rU55NoRqzkkchPuRExl5FjqljMxD/VJQ==
X-Received: by 2002:a17:902:9047:: with SMTP id w7mr16117360plz.270.1547236558983;
        Fri, 11 Jan 2019 11:55:58 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id c7sm110659515pfa.24.2019.01.11.11.55.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 11:55:58 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Loys Ollivier <lollivier@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH v3] arm64: dts: meson: Fix mmc cd-gpios polarity
In-Reply-To: <CAFBinCDM4BTx0Ude-M=O6B2bXPE9EdfD=VxZfFzR9Dc=yT+xWQ@mail.gmail.com>
References: <1547134822-18498-1-git-send-email-lollivier@baylibre.com> <CAFBinCDM4BTx0Ude-M=O6B2bXPE9EdfD=VxZfFzR9Dc=yT+xWQ@mail.gmail.com>
Date:   Fri, 11 Jan 2019 11:55:57 -0800
Message-ID: <7hy37rm0j6.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> Hi,
>
> some nit-picks as well as my Tested-by (in case it's not too late) below.
> thank you for taking care of this!
>
> On Thu, Jan 10, 2019 at 4:40 PM Loys Ollivier <lollivier@baylibre.com> wrote:
>>
>> Commit 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
>> changed the behavior of "cd-inverted" to follow the device tree bindings
>> specification.
>> Lines specifying "cd-inverted" are now "active high".
> this depends on the polarity from the cd-gpios property. above commit
> caused cd-inverted to be applied twice (effectively making it a
> no-op). thus "cd-inverted" only means "active high" if cd-gpios also
> sets GPIO_ACTIVE_HIGH. if the polarity in cd-gpios is GPIO_ACTIVE_LOW
> together with "cd-inverted" then the GPIO will be treated as active
> low.
>
>> Fix the SD card for meson by setting the cd-gpios as "active low" according
>> to the boards specifications.
> not only switching to GPIO_ACTIVE_LOW, also dropping "cd-inverted"
>
>> Fixes: 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
> in my patches for the 32-bit boards I used the commit which added SD
> card support to the board for the Fixes tag. however, I'm fine with
> this as well (I just wanted to point out that there's a small
> difference in our commits).
>
>> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
> on my Khadas VIM(1), using Kevin's v5.0/fixes branch:
> Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

I can add this tested-by tag in my v5.0/fixes branch for now, and can
replace it with a follow up if Loys can update the changelog with your
suggestions/clarifications.

Thanks,

Kevin
