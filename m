Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3F1C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F33B2175E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TX/eSVQJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F33B2175E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389639AbeHGSy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 14:54:57 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:45905 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730869AbeHGSy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 14:54:57 -0400
Received: by mail-yb0-f194.google.com with SMTP id h127-v6so6828566ybg.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 09:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jqeryaE7yhathlSy2pE1qOu1bKxRPLnyVAvAxqC5MCY=;
        b=TX/eSVQJVUcouFStdX4mjFjeo2rfjK++YrcsQV7kn2euJ5QJ0TSwjbQKPi+Bgh6bWi
         oHF66oHwPr3XjbDkXfFxiW6HuU/5GBvAs7+clApeGc8MHXAjiAY0XOB3qD2r6YrrhNdO
         z0n2oFpflogSuGJ7lSnrqy9VwTZo7EC7kYQi2+9XetV2kasbvYyCdmcluKg2KNOg1eJJ
         lV12s6X8pnNmiGvXMz/j2YkfXIorEJKHqa+E5eGoirx2Ax+1dKPiUrWXjN4aysTI3VJB
         kYKXT/izUKNc+sB26vSDQEG9PLIXS+rCGxz9jpup5iAOf6SJdv6GsC+klCOsXUSP6xUT
         B8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jqeryaE7yhathlSy2pE1qOu1bKxRPLnyVAvAxqC5MCY=;
        b=imRV0Ne/HjkIlZGuMz9M6kwA8whLxzHI0FBXm3pZ6lkVDwdRx6SHOnv3hvUWCaUYga
         IUlHpKoauqq64tfvmryVu6tgthvKYTjAACaIG5YQME00j04aIeLdYtoOksUW3mIaLOxi
         aO8Kn0dTX1uLfK6y4RXcEflmG7Mm2TJislGvnjjFBva3zPeOQCj0oW7qVUdqMYrQJCTP
         bikq7OCWrHtMIebEx3kd+9m/evx3fw6RJUNc9Yk6EPUU04KyEr2A1LhEf8vOckE5NQfw
         NU3qEGQjnh8x3NpIwjdxUhjikDr7d6cWdAIL8sh19WdzIgGUeCEsBGCCFu7ViLoelGZp
         6f9A==
X-Gm-Message-State: AOUpUlGP8plfaJ3RH4qVI5rvisR5i1BXmxbfZTkK4ecsLbqWwNAmdPW8
        XinYVOLCaBb0UwkGD2jfayRixSe76vt/l5JM90c21g==
X-Google-Smtp-Source: AAOMgpcOoJqlPy1P5cylPMSlejkD/TYI0zhVMAA0AOpsBqyo/ZnyeGfdB0e8PSscjNAH7hqn1rh39uCYikqH29fUwxw=
X-Received: by 2002:a25:b191:: with SMTP id h17-v6mr10541616ybj.79.1533659989644;
 Tue, 07 Aug 2018 09:39:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180807162234.205212-1-mka@chromium.org>
In-Reply-To: <20180807162234.205212-1-mka@chromium.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Tue, 7 Aug 2018 09:39:38 -0700
Message-ID: <CABXOdTcpoGLc+STUZY-tVBqqn5BrBH1vEb6B+bt6MspLHUXeGQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: rt5677: Remove bogus device id from rt5677_of_match
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     bardliao@realtek.com, oder_chiou@realtek.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 7, 2018 at 9:22 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> The initializer of rt5677_of_match contains a bogus device id
> (enum type) for the 'type' field (char []). Remove it.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  sound/soc/codecs/rt5677.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
> index 8a0181a2db08..7dab53b35cbf 100644
> --- a/sound/soc/codecs/rt5677.c
> +++ b/sound/soc/codecs/rt5677.c
> @@ -5007,7 +5007,7 @@ static const struct regmap_config rt5677_regmap = {
>  };
>
>  static const struct of_device_id rt5677_of_match[] = {
> -       { .compatible = "realtek,rt5677", RT5677 },
> +       { .compatible = "realtek,rt5677", },

Is that indeed not used, or should it be the following ?
                        ...  , .data = RT5677 },

Thanks,
Guenter

>         { }
>  };
>  MODULE_DEVICE_TABLE(of, rt5677_of_match);
> --
> 2.18.0.597.ga71716f1ad-goog
>
