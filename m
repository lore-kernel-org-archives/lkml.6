Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756328AbeDXKZW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 06:25:22 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:45959 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753223AbeDXKZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 06:25:18 -0400
X-Google-Smtp-Source: AIpwx4+CQEmn244LemG6+RbLkTxERWVRsJB0do7zuwVn/KJMPOBDdrO9ZIGsVIvWJWZLRXQTGkqoRVreR/BVURN7/fE=
MIME-Version: 1.0
In-Reply-To: <20180423085242.3140416-1-arnd@arndb.de>
References: <20180423085242.3140416-1-arnd@arndb.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 24 Apr 2018 12:25:17 +0200
X-Google-Sender-Auth: 5ITZQW29lJqquM1E3HKWkZSGIYo
Message-ID: <CAMuHMdXtGx3SUxehRRN=uarw8H7Za-zjNkTigibnTxXxEbMW2w@mail.gmail.com>
Subject: Re: [PATCH] m68k: use read_persistent_clock64 consistently
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-m68k <linux-m68k@vger.kernel.org>,
        Stan Johnson <userm57@yahoo.com>,
        Finn Thain <fthain@telegraphics.com.au>, Sam Creasey <sammy@sammy.net>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 10:52 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> We have two ways of getting the current time from a platform at boot
> or during suspend: either using read_persistent_clock() or the rtc
> class operation. We never need both, so I'm hiding the
> read_persistent_clock variant when the generic RTC is enabled.
>
> Since read_persistent_clock() and mktime() are deprecated because of
> the y2038 overflow of time_t, we should use the time64_t based
> replacements here.
>
> Finally, the dependency on CONFIG_ARCH_USES_GETTIMEOFFSET looks
> completely bogus in this case, so let's remove that. It was
> added in commit b13b3f51ff7b ("m68k: fix inclusion of
> arch_gettimeoffset for non-MMU 68k classic CPU types") to deal
> with arch_gettimeoffset(), which has since been removed from
> this file and is unrelated to the RTC functions.
>
> The rtc accessors are only used by classic machines, while
> coldfire uses proper RTC drivers, so we can put the old
> ifdef back around both functions.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, applied and queued for v4.18 with Baolin's Rb.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
