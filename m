Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED21C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A998620863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZI6hAjL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A998620863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935295AbeFROsz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 10:48:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:49460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934674AbeFROsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 10:48:54 -0400
Received: from mail-io0-f176.google.com (mail-io0-f176.google.com [209.85.223.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90744208E0;
        Mon, 18 Jun 2018 14:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529333333;
        bh=IdpB9pbAd6YpbJ6jAgx2JZoljKxYox+glG3obiIUmlI=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=HZI6hAjLLq61mkyXhYw/1hjLiDjn5ia9n2ImmDO/sOeIyXAHgvHUyxZeTAhehO2hE
         bbXI2D1h9q0BZ0pkBUN/ikCORasMsiE5BFmnDdry7xbzQTSi9uXRIfWj2rXDayplR9
         uI8l3sd6/7IBEDu97yR1hw/RXsoJUHMPEgTQ/9GA=
Received: by mail-io0-f176.google.com with SMTP id d22-v6so17021671iof.13;
        Mon, 18 Jun 2018 07:48:53 -0700 (PDT)
X-Gm-Message-State: APt69E11XURiQNx809RmeETRQbIYpqa+C5/fFDXNJ6maTwdKhRiI66Dr
        dmlWesGPq2CWFNaERxMuuWikSISRAD5O3+moWQ==
X-Google-Smtp-Source: ADUXVKIg+mYipVHYfppCV89sMMhyWoKaCBfV5WlAKJrvHMC0ECp6XM/yO62BDzv7UFnKC5splK9QiVo+mxOHM1X+aXw=
X-Received: by 2002:a6b:bd47:: with SMTP id n68-v6mr10926662iof.111.1529333332858;
 Mon, 18 Jun 2018 07:48:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:6403:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 07:48:32
 -0700 (PDT)
In-Reply-To: <20180618123932.GA28476@centauri.lan>
References: <20180614111138.8923-1-niklas.cassel@linaro.org>
 <20180614111138.8923-6-niklas.cassel@linaro.org> <20180618110642.GA6928@sirena.org.uk>
 <20180618123932.GA28476@centauri.lan>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 18 Jun 2018 08:48:32 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJQ0GbFtnpP9-YCEcVKHDdHbT5hshZGvNDQw=u5ZANdvg@mail.gmail.com>
Message-ID: <CAL_JsqJQ0GbFtnpP9-YCEcVKHDdHbT5hshZGvNDQw=u5ZANdvg@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] ASoC: qdsp6: Add depends on OF
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 6:39 AM, Niklas Cassel <niklas.cassel@linaro.org> wrote:
> On Mon, Jun 18, 2018 at 12:06:42PM +0100, Mark Brown wrote:
>> On Thu, Jun 14, 2018 at 01:11:36PM +0200, Niklas Cassel wrote:
>> > of_platform_device_destroy is only defined when building
>> > with CONFIG_OF=y. Add a depends on OF.
>>
>> Is it sensible that of_platform_device_destroy() is only defined when
>> building with CONFIG_OF=y?
>
> I'm redirecting that question to the device tree maintainers.
>
> There are a few of_* functions in include/linux/of_platform.h
> that are only defined when CONFIG_OF=y:
>
> of_platform_device_create()
> of_platform_device_destroy()
> of_platform_bus_probe()
> of_device_alloc()
>
> Rob, Frank, do you want me to create static inline dummy versions of these?

No, because generally you should not be using these functions
directly. Yes, there are some users, but if you look at the tree,
there are few or isolated (PowerPC) users. Using
of_platform_populate/of_platform_depopulate is preferred.

Rob
