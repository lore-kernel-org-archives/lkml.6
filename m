Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881F0C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4232220855
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PnNoc9Ic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4232220855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbeIHALD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 20:11:03 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:56205 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeIHALD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 20:11:03 -0400
Received: by mail-it0-f66.google.com with SMTP id d10-v6so22040051itj.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 12:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7grtWJf3vQi4tLEkAvNvFqDRZa/5m64d3+8Vy/udT1c=;
        b=PnNoc9Icuohsk4q3p8Pygi0SEoM5XS3Cxs9STx7x+nYXypR+Y5oXeb1Vb8BO5BDprU
         29y+3qbxDm4eRGjHqCgpbS5ojUYVBeDr8cyZVORFh0UyaxK1u4Tdi8NZ0CAMnz8rs56K
         6Natb8M1r6TC2WMb2w7mv9tT0DD6SftOux/8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7grtWJf3vQi4tLEkAvNvFqDRZa/5m64d3+8Vy/udT1c=;
        b=AEuc4WM5TKL2J25RSF8+LzeVfpGVR1F49MgP+SVjInff9oSbnsI4jVTtPU3EVMiH/s
         zMR1vUBFClIzpWF2UXvkz7fOgj0YUnZ6e7VIQxEOAVS5luea336hS5cgNZO/l92tedtZ
         1HwO+9fO9kuB8oWZqUaVzpHBVlOtq/dz9rTRLPlOIwHYHweoD+GwVTLWLStcPpDUDRLf
         IEG8KU5k/1krti5rmu8ktPdYg16ntH6FvtRbVPgDsBkIL7UMSjgZioRt8EbrkKlVFIfk
         wW86S3KZIe6E/uyiv0hy54yY/6wJJCf5rGfPQ8xcqTVh0hzvjZq1NBGmfUo2v/+X8SgE
         jHlg==
X-Gm-Message-State: APzg51CSiM98T94RnyggfKm8XnmL4c5YmEyH4T06hScMD5GpRajP4SSx
        Eavg/hrlD+QJoNx2ZruUNmzAumDYbbUm4+/FkUoR2g==
X-Google-Smtp-Source: ANB0VdadtV0FUCLG4KeAXPDJMhgVmEB0SQ2tbSX1FQzuoagUUihQijhrQYKML2+7h2GFafuLa30trlLdZwyLO4AX6Kc=
X-Received: by 2002:a24:b611:: with SMTP id g17-v6mr8855284itf.98.1536348520215;
 Fri, 07 Sep 2018 12:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <20180907002728.112770-1-grundler@chromium.org>
 <20180907121128.GH17459@sirena.org.uk> <CANEJEGv0A8LO1znHToYOkddzr_JmHpogvYewVrMpK+ZB6SJX5w@mail.gmail.com>
 <20180907175620.GL17459@sirena.org.uk>
In-Reply-To: <20180907175620.GL17459@sirena.org.uk>
From:   Grant Grundler <grundler@chromium.org>
Date:   Fri, 7 Sep 2018 12:28:28 -0700
Message-ID: <CANEJEGteyDV2pWjC=z_btexMOcYnRER8ScqVTYqxZQO6DOsNTQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: max98373: usleep_range() needs include/delay.h
To:     broonie@kernel.org
Cc:     Grant Grundler <grundler@chromium.org>,
        ryans.lee@maximintegrated.com, lgirdwood@gmail.com,
        kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 7, 2018 at 10:56 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Sep 07, 2018 at 10:52:24AM -0700, Grant Grundler wrote:
> > On Fri, Sep 7, 2018 at 5:11 AM Mark Brown <broonie@kernel.org> wrote:
>
> > > Note that this isn't causing a warning upstream, presumably due to an
> > > implicit inclusion that isn't present in the v4.4 kernel that you appear
> > > to be using, or gets missed due to config differences.
>
> > Ok. Is this just an observation or are these reasons to not accept the
> > change?
>
> An observation, you should already have a mail about it being applied.

Ah ok! Thanks for pointing that out (and for reviewing/accepting the patch).

cheers,
grant
