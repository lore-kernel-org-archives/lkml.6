Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDF3C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 00:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCD3320893
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 00:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCkxaUvQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCD3320893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbeHWD6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 23:58:20 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38086 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbeHWD6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 23:58:20 -0400
Received: by mail-lj1-f195.google.com with SMTP id p6-v6so2787928ljc.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 17:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6925iiie6tuwwZJFL4Rn5JOI2tv4y6p3InezbfqJRHk=;
        b=JCkxaUvQwln0nGhaYjgL/au+TN8ozebCjrQt9cQIbR6iiRY/IPFxhw99TmeGXGMqaN
         +76qQtD1/A1TGhCxZaWk/O4MmWGqsqhrwVZt/5N5o5EcHiUqj4+bRFalkysRI0AuQTU8
         adiVG1jyOoEdH3KCr/8GYmfokQ2Czl9bOfIk7ZRYvj4Z9BVNLXs0vSs8SOZRW6cZk4ye
         l/5YSPvsDTmwC+9G83HgQrNVWUXF4tIEcd6oBJqCd61ycIElclJKRzldsNuX0a7Tbo1h
         Nl/9ZthyHaYM6ihbX6Ll7yfDDvk9mHG0yjk9HPpEK6C7855QsoAArHAsE7k4NDji2mBr
         qkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6925iiie6tuwwZJFL4Rn5JOI2tv4y6p3InezbfqJRHk=;
        b=kSDluCLMTRiFhYP9Ls8he1GaxDRrnC899OBsoBLL0nav3C5d0rviX5vaZXyo07j9zN
         Z6jkuv8hsqtYOXXZ/DDuguXuZR67BQHKinrSx2RbMQ6jd12neg84JRS9Vh2lW3LuR3Tm
         GZX84KHV7+3NQdjByFlQfjAnibtaJPFyZYniG5run/dhwtHK/UXEoVJwbyACSZ2oMU/i
         uDW44/LpyZLFEoRxLzqsjF0ph/6c5kq11a21YClGqMKx3NG6gTte3q2JZzP1N2rChpiL
         R6eqUvjHm899GXiPDnxsBSLLvUpSvGp4qgcmKrhrJsWrh6Rzc0Trm5RnJkTlZFPWAiYM
         13fA==
X-Gm-Message-State: APzg51Dj+AI8axRJVZBvcA9TECfGNoBxQl6gi7jOh9YlGrfPYYFK0Asi
        6+RXCo0Ainy6zuSoelZ4Pm0B1TBTkWmGzYRtDfA=
X-Google-Smtp-Source: ANB0Vda0+VdBmGJK//3quJd+960wWC2jSnfmz8McMZg1x9vxoYvWuQSPa8DczHNedtLjEomBg+sjRSSgpsNbX17jIBs=
X-Received: by 2002:a2e:1290:: with SMTP id 16-v6mr6334452ljs.94.1534984276375;
 Wed, 22 Aug 2018 17:31:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180823001519.20056-1-ryans.lee@maximintegrated.com>
In-Reply-To: <20180823001519.20056-1-ryans.lee@maximintegrated.com>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Wed, 22 Aug 2018 17:31:04 -0700
Message-ID: <CAKdAkRT-71tL7U1t_WMenh5kquppsZpiL=0bEyL4RLjj622zqw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: max98373: Added 10ms delay after amp software reset
To:     ryans.lee@maximintegrated.com
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        lkml <linux-kernel@vger.kernel.org>, ryan.lee.maxim@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 5:21 PM Ryan Lee <ryans.lee@maximintegrated.com> wrote:
>
> Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
> ---
>  Changes : Applied 10ms delay after amp software reset.
>            10ms guard time is required for stability.
>  sound/soc/codecs/max98373.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
> index 2764fae..6aaff03 100644
> --- a/sound/soc/codecs/max98373.c
> +++ b/sound/soc/codecs/max98373.c
> @@ -730,6 +730,7 @@ static int max98373_probe(struct snd_soc_component *component)
>         /* Software Reset */
>         regmap_write(max98373->regmap,
>                 MAX98373_R2000_SW_RESET, MAX98373_SOFT_RESET);
> +       mdelay(10);

Is it really necessary for the CPU to spin for 10msec here?
usleep_range() would be better solution.

>
>         /* IV default slot configuration */
>         regmap_write(max98373->regmap,
> @@ -818,6 +819,7 @@ static int max98373_resume(struct device *dev)
>
>         regmap_write(max98373->regmap,
>                 MAX98373_R2000_SW_RESET, MAX98373_SOFT_RESET);
> +       mdelay(10);
>         regcache_cache_only(max98373->regmap, false);
>         regcache_sync(max98373->regmap);
>         return 0;
> --
> 2.7.4
>

Thanks.

-- 
Dmitry
