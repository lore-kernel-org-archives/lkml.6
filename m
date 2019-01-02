Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C51C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 12:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C5E2171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 12:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="EWZgWqUt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729884AbfABMqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 07:46:24 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43635 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729848AbfABMqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 07:46:24 -0500
Received: by mail-ed1-f66.google.com with SMTP id f9so26036065eds.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 04:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=jWYtroL2CqhWj6bXnI5dboJDLzbLdRv4JwKj7ZxvKBI=;
        b=EWZgWqUtrGjNF7V2Uaoq2Toh3HSQZtuH8v+mrbrrv88fL4qd9hLjNur0qJW5BYm1o0
         VKH45G7l2He5rD52tcDoHVyPK9ieYxS0z3ajyUYhUKXne60HWjGlaNBWMSEzRHKf3vBt
         f5+5sHM0CwQErIh7ArJYjEnFn7m/DnhPAAOkVtX0Gj8pjdFWl3vQS61XbIrdye8ThOfy
         O9mJFPTvt92nA45j5ZrCM/C+y00lGo7lRgeKK2BWbTR4Mda/MLtMR+HGJgWOCLQLg4uu
         elT5r36XfdZ7s9q2PBNF18d/e7G9Y6Jty4p1xFg4k4IyXtGetzod64OeTObL5bWtD/cO
         X07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=jWYtroL2CqhWj6bXnI5dboJDLzbLdRv4JwKj7ZxvKBI=;
        b=MQSR+dS7tlcMjXvLvu2/zVqO7uz5chROphCBBYSe+M9Be42tbOeovuNushCb5TpeRY
         m9bwOS2qElR7/RpZ/fe9Ft8xizL0FAgHFUWbKz4GWfsilCYnsujGddM262ZhCppq0Q8z
         ZmM76wktY5cp8QTV40lwpJmGhkMY32QU7+J0cU+BUPf63SoWmTX34WEMxPTfuQ9xeP0/
         36saMS6DcXfdDNE/l48oQxvNkisLC6VMUkLlW93Hbd2X/HtsMcnnUoLo8vwOhhYjc29D
         ZPmyLrY3l1U/UNJG0uJJNb64jVFb91XFsIceqiWcChv1rdf6fa9WCVQOb8IqIPEXSizH
         LjXg==
X-Gm-Message-State: AA+aEWZ2B+hkRwyxKu3v7dCFIq3XnilUqPnUSomMEe5f1XLjS1SFy2fj
        9ns+K5a8ma0BewbfGp5SOwmBag==
X-Google-Smtp-Source: AFSGD/Vy3OSJ6pNRR/l9vqY9gzNvkFb97nE2PnjrcFzwVI2kDcHK5ftCvqgRHizHGNI+pSaAOzrQiQ==
X-Received: by 2002:a50:f5f4:: with SMTP id x49mr40057079edm.26.1546433181585;
        Wed, 02 Jan 2019 04:46:21 -0800 (PST)
Received: from boomer.baylibre.com (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e35sm21881660eda.13.2019.01.02.04.46.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Jan 2019 04:46:20 -0800 (PST)
Message-ID: <db2580c8740ca202d02f37ef567be0e273eca6d7.camel@baylibre.com>
Subject: Re: [PATCH 0/4] mmc: meson-gx: chained descriptor fixup and
 improvements
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 02 Jan 2019 13:46:19 +0100
In-Reply-To: <CAFBinCCUO6ihxNWDup5ZVKWBc8+oiW_-j8OUxRhb+tjpGsUBkg@mail.gmail.com>
References: <20181206151828.24417-1-jbrunet@baylibre.com>
         <CAFBinCCUO6ihxNWDup5ZVKWBc8+oiW_-j8OUxRhb+tjpGsUBkg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-12-22 at 18:28 +0100, Martin Blumenstingl wrote:
> Hi Jerome,
> 
> On Thu, Dec 6, 2018 at 4:18 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
> > The goal of the patchset was mainly to address the following warning:
> > 
> > WARNING: CPU: 0 PID: 0 at /usr/src/kernel/drivers/mmc/host/meson-gx-
> > mmc.c:1025 meson_mmc_irq+0xc0/0x1e0
> > Modules linked in: crc32_ce crct10dif_ce ipv6 overlay
> > CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         4.19.1 #1
> > Hardware name: Some A113 Board (DT)
> > pstate: 40000085 (nZcv daIf -PAN -UAO)
> > pc : meson_mmc_irq+0xc0/0x1e0
> > lr : __handle_irq_event_percpu+0x70/0x180
> > sp : ffff000008003980
> > x29: ffff000008003980 x28: 0000000000000000
> > [...]
> > x1 : ffff80001a71bd40 x0 : 0000000000000000
> > Call trace:
> >  meson_mmc_irq+0xc0/0x1e0
> >  __handle_irq_event_percpu+0x70/0x180
> >  handle_irq_event_percpu+0x34/0x88
> >  handle_irq_event+0x48/0x78
> >  handle_fasteoi_irq+0xa0/0x180
> >  generic_handle_irq+0x24/0x38
> >  __handle_domain_irq+0x5c/0xb8
> >  gic_handle_irq+0x58/0xa8
> > 
> > This happens when using the chained descriptor mode. If there is an
> > error, we call mmc_request_done(), loosing any reference to the cmd. It
> > turns out that the chained descriptor does really stops when we do so, at
> > least not completly. Most of the time, it can be seen with this harmless
> > warning because the descriptor will raise another unexpected IRQ. On rare
> > occasion, it will completly break the MMC.
> > 
> > This is mostly adressed by patch #1.
> > With this fixed, I took (yet) another look at the ultra-high speed modes
> > and the tuning.
> > 
> > I came up with new settings in patch 3 and 4. I've tested them on eMMC,
> > sdcard and sdio on the following platforms:
> >  * gxbb p200
> >  * gxl p230, libretech (eMMC only), kvim.
> >  * axg s400
> > 
> > So far, these new settings seems to be working great but I think it
> > would be nice if others could test this and provide their feedback.
> > This why  patch 3 and 4 are RFT tagged.
> > 
> > Jerome Brunet (4):
> >   mmc: meson-gx: make sure the descriptor is stopped on errors
> >   mmc: meson-gx: remove useless lock
> >   mmc: meson-gx: align default phase on soc vendor tree
> >   mmc: meson-gx: add signal resampling
> I gave all four patches a go on my Khadas VIM2 Basic (16GB eMMC).
> regardless of whether I have your patch applied or not: eMMC
> sporadically fails tuning (if I reboot the board a few times it starts
> to work)
> [    4.172686] mmc1: tuning execution failed: -5
> [    4.182535] mmc1: error -5 whilst initialising MMC card

Damn ...

This particular device is set to use hs400 ATM. Could you try with hs200 only
? (removing mmc-hs400-1_8v from meson-gxm-khadas-vim2.dts) 

I might be wrong but I think tuning is supposed to be done with hs200, before
activating DDR mode to switch to hs400. In theory, removing hs400 should not
change anything (so I expect the tuning to still fail) but it is worth
checking.

> 
> I'm not sure if this issue is specific to my Khadas VIM2 so this is
> *not* a nack for your patches.

I'll check if I can get my hands on this device.

When cooking this series, I tried another trick which was cycling on the
resampling delays (see ADJUST_ADJ_DELAY_MASK). At the time, I could not see
any significant improvement while doing it, so I dropped it.

If possible. could you check if any particular value in this field, between 0
and 5, makes things any better ?

Alternatively, if you find another combination of phase for the mmc_clk and
tx_clk that works better for this device, feel free to let me know. Maybe we
can work something out.

Cheers

> 
> 
> Regards
> Martin


