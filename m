Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3418ECDE44
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 22:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7370A208E7
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 22:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oeAyHVME"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7370A208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbeJGFMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 01:12:40 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37876 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbeJGFMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 01:12:40 -0400
Received: by mail-lj1-f195.google.com with SMTP id 63-v6so14636904ljs.4;
        Sat, 06 Oct 2018 15:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O9ubuTJ+BdQkBiU+88c9WhHTKa2r66Wnf2HZtLsa4FM=;
        b=oeAyHVMEFKk4VcJAHnLoXmA2RlGMztpNiTXljP/KBqIFHNmdYH9PGmr3odWYUNoFij
         3lSSSE/JZP7wPeQP723f4joybOf7YpTZ3wkA1o+50WgFjxWLjOtq4+ke64taISulhv+G
         QnO/UipMkncJ6xWk06DgjDLdYsDmRqnQPCdiDwoGmhXHFudrSLxoitnU6PhkbRW1uPap
         lrIbl8HXcM/8pdPczPQd4iGreYCFIqFd2OpPbrwl4NOJiqZwaYYrZdaIMuIVuiSwm6GA
         IkFMxOnP4XpO73nPwTSVfEJF8iGfaNnXpAe2XFC2ksUWOT7rnPcye7VKiJD8jgwU9WsO
         vCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O9ubuTJ+BdQkBiU+88c9WhHTKa2r66Wnf2HZtLsa4FM=;
        b=qk/3K/Dk5AZVgke6DBhZzQNvKt/ujoIaGkUQr3XLQJJmZ5wWB2HhrRVDsXhH1U5jRI
         agj+ffWkX8+MTx/mh4oveKY+sDZMMGEtAcFzULzp34tXcoIp12PScgbhgAxr2UL0j+Bs
         SscbNtFGIydTZb+7OAbb6k5D3WhppkK4eOEJQm7xNcbCvkKy6jXF5CYS6ZTIDsBxDPcM
         nJZ/9k/9G2B7Dum6LVGJCsf9w4n38jBssgD39lavSaBeluLxajlcT8BRB78s2/PGtQ43
         5cKZ834Pdmf9BCd5sp5RMxO5dSRnWtw93Af9LrJvOSwIOep+NFxNRIwCjQhPhSa4L+v+
         OGBQ==
X-Gm-Message-State: ABuFfoh+7qKq0Wv5P0xxeMBoK6e057q5lzk2zQMbR/UekVTtH1l4lbIb
        OO3642/5AQWOteJBslsh0uWsmu69ihSUmmy+Bma/Yu9ggt8=
X-Google-Smtp-Source: ACcGV60JSosfVv1CFdfl+0QRUPp0xnYyV+wkiQTOtIq+fB1aZCKqVJJkYpQuXCsTVt3ZYzFgRmNGWxFGsmVxJYmVUls=
X-Received: by 2002:a2e:9615:: with SMTP id v21-v6mr10641327ljh.150.1538863661544;
 Sat, 06 Oct 2018 15:07:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180921142234.16882-1-kieran.bingham+renesas@ideasonboard.com>
 <20181005083313.2088252-1-arnd@arndb.de> <CANiq72mHDxe9-+pFf+dDuYXRz5YeyRYi6RW65tyo9-ENNngsCw@mail.gmail.com>
 <CAK7LNAT5h+Rku7DbD+kHGv7Kgk8FfuX4wwL_pwNOLSJbqw99MA@mail.gmail.com>
In-Reply-To: <CAK7LNAT5h+Rku7DbD+kHGv7Kgk8FfuX4wwL_pwNOLSJbqw99MA@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 7 Oct 2018 00:07:30 +0200
Message-ID: <CANiq72m4rES74-GQXQw7uTdY8ku1154u1U6J+xoOfwrWkyu1MA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: fix kernel/bounds.c 'W=1' warning
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-renesas-soc@vger.kernel.org,
        kieran.bingham+renesas@ideasonboard.com, stable@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On Sat, Oct 6, 2018 at 11:59 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Sun, Oct 7, 2018 at 6:18 AM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > I think marking the function as static __used should do the trick and
> > would be less confusing.
>
> I tried __used, but I still see the warning.

It has to be static __used, not only __used! :-)

Cheers,
Miguel
