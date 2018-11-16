Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E9EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 07:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0475C208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 07:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QeVE8NIZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0475C208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389139AbeKPR35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 12:29:57 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35337 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbeKPR34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 12:29:56 -0500
Received: by mail-ed1-f68.google.com with SMTP id x30so14058689edx.2;
        Thu, 15 Nov 2018 23:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PynQtPsQitcPlrcDRkdValWohZuUwASdVdmRFgVW5lU=;
        b=QeVE8NIZWCa7eI+rCTllC+iH7kin36hXlmxzYlgFS7CvMQFmY+rgtBEufOT0BWXnoG
         RwKU7mKI4aZsbJ7ijuNxC05Eh3QbSs2+cS3Pi4qR2bKZZwFZqIuSZrnAfLDkrmKe4KG9
         5jIvnPPOCLmwSeEbyN/A+BlZVSwSCbgNHQm89n9z0qN21C9nRRLuMwgiIjps4A/l54Kz
         GFTnzbHXD5DQkZ/q9ypTaGail4GeZJiQ02840TOdw6vgTL9F+Q3RLtFXCyk8DJHyWp4+
         CPRCrrSN7NeY7DUP1qOzRcKnpjDjpY4nw5gHs8rGRx5+CKiUGiiGTzS1T7YPd+zIyC8C
         +9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PynQtPsQitcPlrcDRkdValWohZuUwASdVdmRFgVW5lU=;
        b=uUEicWIk1CIurLsBH66YhyjhXYiLnPCUAlU8g+jwVddjYoOfgoVYqHfTQfJc2WNwP1
         /47xH7JKy2WWPXGOoi9dbHovvmOwQ27273FImsJ9jrAXHqvrqUClLy77sKaYhlFJ9Di8
         9VmSI5xLDpZQDHPA4citH+ZsHNXVhsRjPrHl1d3x3W0OelzFNAPJP3FiPYOparlqubfV
         pHNXnkQV5d/vH4pAwlSxYd8zioEGVm2ogLPCC1EyRbKkMq1KkIilxWURbgS2gSjUMptG
         kKslYKTENKZPTdMJXnzqlumyhSmyP3dfNNb3c39+RC7Q96rN4QbQEGCWhfzcJuSdfzbt
         hkRw==
X-Gm-Message-State: AGRZ1gLJWZEaSO6VyTH5zDfwsEVJ0jhJJFp5cqThG77cUl5anAly8yuy
        n4h31DjSWWjBZg1PwG3cxVT40E+38FQsORdcWhs=
X-Google-Smtp-Source: AJdET5cK1j1VohuO7/EIt3xz87BH7Tp6nhDJ63ctbhNGhvXKjisJ/RWY0YsQq26R3Zjei4lmNRjP67/IUMh9+PPYBcQ=
X-Received: by 2002:a17:906:2da9:: with SMTP id g9-v6mr7717103eji.67.1542352725649;
 Thu, 15 Nov 2018 23:18:45 -0800 (PST)
MIME-Version: 1.0
References: <20181115181324.26784-1-srinivas.kandagatla@linaro.org> <20181115181324.26784-2-srinivas.kandagatla@linaro.org>
In-Reply-To: <20181115181324.26784-2-srinivas.kandagatla@linaro.org>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Fri, 16 Nov 2018 09:18:34 +0200
Message-ID: <CAEnQRZBGQX7C2=fUr-6et6Wh=fOgX3nB=eFYG959XiuDMqbaKg@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v3 1/5] ALSA: soc-compress: add support to snd_compr_set_runtime_buffer()
To:     srinivas.kandagatla@linaro.org
Cc:     Mark Brown <broonie@kernel.org>, vkoul@kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        bgoswami@codeaurora.org, Takashi Iwai <tiwai@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, rohitkr@codeaurora.org,
        srini@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

One minor comment:

<snip>

>         struct snd_compr_ops *ops;
> +       struct snd_dma_buffer *dma_buffer_p;

I don't think it is necessary to encode the type inside the name variable
So, dma_buffer would sounds better to me then dma_buffer_p;

>         void *buffer;

It is also consistent with this ^

<snip>
> +static inline void snd_compr_set_runtime_buffer(
> +                                       struct snd_compr_stream *substream,
> +                                       struct snd_dma_buffer *bufp)

Also buf instead of bufp here.

thanks,
Daniel.
