Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48642C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED86020836
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cV+SAWwT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED86020836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936925AbeFRUxn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 16:53:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:56034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935090AbeFRUxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 16:53:41 -0400
Received: from mail-io0-f180.google.com (mail-io0-f180.google.com [209.85.223.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8BA820863;
        Mon, 18 Jun 2018 20:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529355220;
        bh=Y9pM/Wyw8WtAfW454AQnDmn1yh0JtPQgpp948bnw8s0=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=cV+SAWwTtGL8huvBeHdTCjHmyjpgeRhnMNwe3wazO1boia+wsTLKddgZ78LCyGilf
         BWd/qkf5sU4PwjFkluCKEGpavZXzsZ0dc59jZ18q172M3x4pswdsLR6zooGyLJkUFv
         6xsSvW1j2sQi5htbvuZiVvCnwlLlgjR2KLrjF8K0=
Received: by mail-io0-f180.google.com with SMTP id u4-v6so18123478iof.2;
        Mon, 18 Jun 2018 13:53:40 -0700 (PDT)
X-Gm-Message-State: APt69E1Q7E/zaI0dgIEMi9CH5YKkg45HQZJM+sYkFCqjOLML3p5M9YFM
        ZzWUX3WW/LUc5jnxeXI6iELil8F+BTnOOxBF0A==
X-Google-Smtp-Source: ADUXVKIiVblwRi3mtPim67kYgwm5VvnJ+kmbjpv+IbHGpW6QI9GNnm8gNU1AF1hlIXDQtEq6evrzWJVdekKAywEWTqo=
X-Received: by 2002:a5e:9407:: with SMTP id q7-v6mr11805031ioj.268.1529355220201;
 Mon, 18 Jun 2018 13:53:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:6403:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 13:53:19
 -0700 (PDT)
In-Reply-To: <20180618200848.GA32482@centauri.lan>
References: <20180614111138.8923-1-niklas.cassel@linaro.org>
 <20180614111138.8923-6-niklas.cassel@linaro.org> <20180618110642.GA6928@sirena.org.uk>
 <20180618123932.GA28476@centauri.lan> <CAL_JsqJQ0GbFtnpP9-YCEcVKHDdHbT5hshZGvNDQw=u5ZANdvg@mail.gmail.com>
 <20180618200848.GA32482@centauri.lan>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 18 Jun 2018 14:53:19 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJti8JzQ7mVQ6Y2zaWD_Q5R9bK4XVh3mJPohXh4sgSQwQ@mail.gmail.com>
Message-ID: <CAL_JsqJti8JzQ7mVQ6Y2zaWD_Q5R9bK4XVh3mJPohXh4sgSQwQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] ASoC: qdsp6: Add depends on OF
To:     Niklas Cassel <niklas.cassel@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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

On Mon, Jun 18, 2018 at 2:08 PM, Niklas Cassel <niklas.cassel@linaro.org> wrote:
> On Mon, Jun 18, 2018 at 08:48:32AM -0600, Rob Herring wrote:
>> On Mon, Jun 18, 2018 at 6:39 AM, Niklas Cassel <niklas.cassel@linaro.org> wrote:
>> > On Mon, Jun 18, 2018 at 12:06:42PM +0100, Mark Brown wrote:
>> >> On Thu, Jun 14, 2018 at 01:11:36PM +0200, Niklas Cassel wrote:
>> >> > of_platform_device_destroy is only defined when building
>> >> > with CONFIG_OF=y. Add a depends on OF.
>> >>
>> >> Is it sensible that of_platform_device_destroy() is only defined when
>> >> building with CONFIG_OF=y?
>> >
>> > I'm redirecting that question to the device tree maintainers.
>> >
>> > There are a few of_* functions in include/linux/of_platform.h
>> > that are only defined when CONFIG_OF=y:
>> >
>> > of_platform_device_create()
>> > of_platform_device_destroy()
>> > of_platform_bus_probe()
>> > of_device_alloc()
>> >
>> > Rob, Frank, do you want me to create static inline dummy versions of these?
>>
>> No, because generally you should not be using these functions
>> directly. Yes, there are some users, but if you look at the tree,
>> there are few or isolated (PowerPC) users. Using
>> of_platform_populate/of_platform_depopulate is preferred.
>
> of_platform_device_destroy() is also used by sound/soc/qcom/qdsp6/*
> which is why I suggested this patch:
> https://marc.info/?l=alsa-devel&m=152932497413567
> that adds "depends on OF" for SND_SOC_QDSP6 in sound/soc/qcom/Kconfig.
>
> Or do you think that a better solution would be to modify
> sound/soc/qcom/qdsp6/* so that it instead uses
> of_platform_populate()/of_platform_depopulate()?

Yes, that is preferred. However, that won't work here because the
child nodes don't have compatible strings. Maybe we should add them as
this all just went in. That would also allow DT based module
autoloading to work (which I don't think would currently). Really, as
is, of_platform_device_create isn't needed here and you could just use
platform_device_register_simple instead. The child driver would have
to get the DT node pointer from the parent device instead.

But if you want to add empty functions for just
of_platform_device_{create,destroy}, I guess that is fine.

Rob
