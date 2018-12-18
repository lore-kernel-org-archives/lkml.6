Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B686C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253A6217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbeLRNPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:15:07 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45318 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbeLRNPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:15:06 -0500
Received: by mail-lj1-f194.google.com with SMTP id s5-v6so14137700ljd.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 05:15:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=c0aO4TC4hRD2MKEoawW2zSdR3EGaesWs8rMApU6dZRI=;
        b=m0pxCWXnfmFZmu48M5GjOPz4GVkXCcYYmsVxmezWCzqR99VfM1SOSHCet3kcB9zLGV
         ovyXLQuWtZM8Xhfb8rTiR9l9DuhdPeI+4nMVW+fUzNqIwJGbJgGPBG2TtsOLb8BSrJL+
         Z3R5feKRw6TIouPPrSvtznJolVyOHN8sh3CzCTSveCdl2hsyKce3VQ9GOYftoTtGDB5C
         slHZCMr8wm4TnBy7W1BacM2pwIYF+dK8hWWfAj8VgXPmb4CkplcnqNiK9GpyIA8UXoKP
         UWt5bWb8jtnXEOPqqvjTi010xj9PZimXntzmX41oAwrldOt21WMkxya9NU8vltk3GxYO
         Ijmg==
X-Gm-Message-State: AA+aEWbqUmOM1Rqpi94T5w99TV2JSx9m7rPJ3o/qIlCsbUy5T61PECex
        HRnESf9AT9pFGLz3jEzVKuM1tzwv
X-Google-Smtp-Source: AFSGD/VkwF6OzwbgO4GicfMC0V/Dcz9gCfekrAcz7pehAGccDQ7NOdrrRQWmSGZ5TXLrKCOaHpBYhA==
X-Received: by 2002:a2e:9556:: with SMTP id t22-v6mr11006698ljh.36.1545138904546;
        Tue, 18 Dec 2018 05:15:04 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id c19sm3169013lfg.86.2018.12.18.05.15.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 05:15:04 -0800 (PST)
Date:   Tue, 18 Dec 2018 15:15:01 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     mazziesaccount@gmail.com, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>, ldewangan@nvidia.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regmap: regmap-irq: Remove default irq type setting from
 core
Message-ID: <20181218131501.GF2477@localhost.localdomain>
References: <20181218105813.GA6957@localhost.localdomain>
 <CAMRc=MexeOcqNgMr1Vq=T1NTeizP20fj3vx3EwxQNv20Cc6bAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MexeOcqNgMr1Vq=T1NTeizP20fj3vx3EwxQNv20Cc6bAw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 02:08:41PM +0100, Bartosz Golaszewski wrote:
> wt., 18 gru 2018 o 11:58 Matti Vaittinen
> <matti.vaittinen@fi.rohmeurope.com> napisał(a):
> >
> > The common code should not set IRQ type. Read HW defaults to the
> > cache at startup instead of forcing type to EDGE_BOTH. If
> > default setting is needed this should be done via normal
> > mechanisms or by chip specific code if normal mechanisms are not
> > suitable for some reason. Common regmap-irq code should not have
> > defaults hard-coded but keep the HW/boot defaults untouched.
> >
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > ---
> > I was not able to test this change as I have no max77620 which seems to
> > be the only user of regmap-irq type-setting in tree as of now.
> >
> 
> Works with my work-in-progress max77650 driver that uses the new
> type_in_mask flag.
> 
> Tested-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Thanks a bunch for testing Bartosz :) Highly appreciated!

-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
