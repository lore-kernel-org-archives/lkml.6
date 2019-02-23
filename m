Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD832C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8586420684
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WB2ISXs7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbfBWNtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 08:49:39 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34778 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfBWNtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 08:49:39 -0500
Received: by mail-ot1-f65.google.com with SMTP id 98so4311726oty.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Feb 2019 05:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iZZakDu9hyOqK8hRWEKSEsLDrqvPzSeiJJ+1UaxV8jA=;
        b=WB2ISXs7Y94/hcwyLpwakIYbddW4QjAEdYeTy2e53bIsIZnslnepSOivwTw/8+DAxV
         7thO5hf9DzW0797GlbEIqxN2TRTm+d3907POGB7UfS3M1bkYtnsSBTaxAO+r2OzWnjiG
         DJgJvb5omsI9QrwNKN9G9+MbFTdLOmpr0qG9jR2dZeKrgGYcETwj3VtcQXOFGYglGHY3
         DtdsPM3gQIcnIgaTrBaLpf/2te8c7dAgDx6JkAFnlWvq8L4FOQ+aWOP1Qog8YsmdhzF7
         a0uSPrb006eGHXV//17rChdM7XjcXnhnL0K6Ekcw3r8gaofQu80hDT1GdehplJHlqc+J
         8Cow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iZZakDu9hyOqK8hRWEKSEsLDrqvPzSeiJJ+1UaxV8jA=;
        b=ASquQZbhDp8QcwLypf/IWmA6Yt80INMH+yfQ5pQjfgh3p3rkrkHDBG1yPG2ifPKtJf
         GTDjDNClFaZfEea5JjNQ41urUYX7G/dYDk4hJ2lvFtVOsBsz4C7TqqToH3v9zgNfm9XP
         qOvTQcyGRq9CFAXe2si3/wLKHpIJOLIUGfEFZA/NBm3lGGpmiWrZ5S06ObyeMSaLhoAd
         l4EuN/MQ4ibT043XlcFjtDBa2b07ldHjvb2S+eCjRVjGUjOCe0Hf71IFzG2h+NQ815k1
         ci4s/p9OPkpkgfGnOhTTU5up5GaYHj16I8dbGJdBndmdpyHZLSYoXtCxfY2j/PPRc+rs
         gU+g==
X-Gm-Message-State: AHQUAuYFqIgbRg9nI3Jn/1kAjgzIQ8uCrke4g5AZgSPk4Wq7S3mRPbhd
        4hMYS5unYZOlIZS6cTK0DNS4ReyPG78FK6fwjq8=
X-Google-Smtp-Source: AHgI3IajCwXp5fSnoPl4W4Q5+DBXPq8184+8maQNEL0KaLIBw+g9z0Ol+2YtKUO+8saKN0YsWu7LBvPwRluiBtZ4SdE=
X-Received: by 2002:a05:6830:1255:: with SMTP id s21mr6012932otp.18.1550929778642;
 Sat, 23 Feb 2019 05:49:38 -0800 (PST)
MIME-Version: 1.0
References: <20190221153550.1932-1-TheSven73@gmail.com>
In-Reply-To: <20190221153550.1932-1-TheSven73@gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Sat, 23 Feb 2019 08:49:27 -0500
Message-ID: <CAGngYiXx9_iaeRJdfT2O=PPUaWJOr=pbWBgOfTmP8EcRU+MGvg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: remove unsupported formats in i2s master mode
To:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>
Cc:     alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 10:35 AM Sven Van Asbroeck <thesven73@gmail.com> wrote:
>
> Fix by constraining the frame bits in i2s master mode
> to 32 * channels. This will filter out those formats
> that the ssi cannot support.
>

Russell King (ARM Linux) informs me that this is not correct, and that
the problem
should be approached differently.

Please remove from consideration if you hadn't done so already.
Thanks :)
