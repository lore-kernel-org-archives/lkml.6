Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E7CC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52908208B9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTzv+BWY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52908208B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbeH1LsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 07:48:20 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36830 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbeH1LsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 07:48:20 -0400
Received: by mail-qk0-f195.google.com with SMTP id 93-v6so406683qks.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 00:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VFzwNzsLDil4DGpjWRi84YshKkihGNFcKxuwlM//rRw=;
        b=nTzv+BWYjAjcR1eUYH+cF1IzoaFpENUsAQq+oHHhBUbD6C+0m6pKSVIIZ4OL9OhWMy
         ioyUwE1dK1JzqkwUYuSenKYizk79/cklJLcUz5Oa6sT5WLyDbZs4ZNW9hmANycToXhPD
         HlB7qsQsd0uF9cqipvQMlXo69KsSCLmVPvgd8fuyqaT6EzSpgrx6CoQ2mXroJO8KnGpU
         YoSLxLNvBKPIPS9DUn3ZrlId6ui7wAjOrHrTFDu4bQnAmXmsV9r7HEtjkob6/P2j0kO5
         4ff9MlkgiXPOF7La4qcM94Kq9t/Hr8X7uzWSaUQMFPPS67Y0SfynFOCSP3P0sZih9k1U
         h2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VFzwNzsLDil4DGpjWRi84YshKkihGNFcKxuwlM//rRw=;
        b=bSQY7qzmVS0IUilR3Ltmgn5dAUeclFlbvQBtmG9df9RcumT2WBQvzNlhPuazKAF5BL
         hmaYpj5rt7KECjkeT3wql5qRUu8AiuQm+dbiJjdJvujlGLr3yItCv+Joa3INmxli9j/6
         5unRuLfI7IC5kYPDzh1sLiWjkwc12/0xS/D35Kv7YDxLgZBu2+KMsp03RhwbHlwwvAVg
         zdSfpq96dl8BuRY7BoY3RT/ibcuJbXYasJOkFneOYiP+H+OPIyxPFcCnxZXCrwfADSvm
         gqvdLVVnEr9K7a0m3vHYVAnryfoF5Tf6Ujdnt3IQ+tO9iygkz6QUlSNvT2VLRaC8Inkz
         VO6g==
X-Gm-Message-State: APzg51CIXgweTP9u7OS1yzLTyyps64XXYkFO0uD62r/QAqmpwRMDhdkT
        2zATA732cnQ/2H6H6VD8YHMrXykaHlruZ8i0K6A=
X-Google-Smtp-Source: ANB0VdYeOEMXdLBtHeiOxMQPee5IKGIrvHoTn32lyCH2Rk5++f0Q/aGeG/N6OMFHrHvLQzmJtoEUUeTBm6/ARY/I3Nw=
X-Received: by 2002:a37:6e01:: with SMTP id j1-v6mr401311qkc.70.1535443074826;
 Tue, 28 Aug 2018 00:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180828015252.28511-1-robh@kernel.org> <20180828015252.28511-51-robh@kernel.org>
In-Reply-To: <20180828015252.28511-51-robh@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 28 Aug 2018 10:57:43 +0300
Message-ID: <CAHp75Vd2B47bMHOuDtFcRUbbMXekgxsG+WP5kj-E1Z_K09=C4w@mail.gmail.com>
Subject: Re: [PATCH] ASoC: Convert to using %pOFn instead of device_node.name
To:     Rob Herring <robh@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>, olivier.moysan@st.com,
        arnaud.pouliquen@st.com,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT" 
        <linuxppc-dev@lists.ozlabs.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 4:57 AM Rob Herring <robh@kernel.org> wrote:

> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.

> +       snprintf((char *)dai->platform_name, DAI_NAME_SIZE, "%llx.%pOFn",
> +                (unsigned long long) res.start, dma_channel_np);

I understand that is not the part of the change, but wouldn't be good
to replace that ugly casting with proper specifier as well?
I mean
%pa ... &res.start

> +                       dev_err(&pdev->dev, "%pOFn sync own reference\n",
> +                               np);

One line?

-- 
With Best Regards,
Andy Shevchenko
