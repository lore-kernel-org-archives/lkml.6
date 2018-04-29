Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754410AbeD2VwE (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 17:52:04 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:41812 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754036AbeD2VwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 17:52:00 -0400
X-Google-Smtp-Source: AB8JxZpYD/DGPwoe5WhG3tjU0y+LV40dovGODa1AyRZi0v3MrfRBzSIRm5y914yRsr0yEe9r1nRmrKYky6dHRrBgPzk=
MIME-Version: 1.0
References: <1524741374-13523-1-git-send-email-Vijendar.Mukunda@amd.com> <1524741374-13523-9-git-send-email-Vijendar.Mukunda@amd.com>
In-Reply-To: <1524741374-13523-9-git-send-email-Vijendar.Mukunda@amd.com>
From: Daniel Kurtz <djkurtz@chromium.org>
Date: Sun, 29 Apr 2018 21:51:48 +0000
Message-ID: <CAGS+omB2=AhpbRZmF=q0_1LfOM5W8T-qEL5jF3KYmkjR0i5rVQ@mail.gmail.com>
Subject: Re: [PATCH 09/11] ASoC: AMD: Fix clocks in CZ DA7219 machine driver
To: Vijendar.Mukunda@amd.com
Cc: Akshu Agrawal <akshu.agrawal@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        perex@perex.cz, tiwai@suse.com,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alexander.deucher@amd.com, weiyongjun1@huawei.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 5:17 AM Vijendar Mukunda <Vijendar.Mukunda@amd.com>
wrote:

> From: Akshu Agrawal <akshu.agrawal@amd.com>

> System clock on the platform is 25Mhz and not 24Mhz.

> PLL_OUT for da7219 codec to use DA7219_PLL_FREQ_OUT_98304
> as it is for 48KHz SR.

> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

> ---
>   sound/soc/amd/acp-da7219-max98357a.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

> diff --git a/sound/soc/amd/acp-da7219-max98357a.c
b/sound/soc/amd/acp-da7219-max98357a.c
> index 6495eed..fa5ad5b 100644
> --- a/sound/soc/amd/acp-da7219-max98357a.c
> +++ b/sound/soc/amd/acp-da7219-max98357a.c
> @@ -39,8 +39,7 @@
>   #include "../codecs/da7219.h"
>   #include "../codecs/da7219-aad.h"

> -#define CZ_PLAT_CLK 24000000
> -#define MCLK_RATE 24576000
> +#define CZ_PLAT_CLK 25000000
>   #define DUAL_CHANNEL           2

>   static struct snd_soc_jack cz_jack;
> @@ -63,7 +62,7 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime
*rtd)
>          }

>          ret = snd_soc_dai_set_pll(codec_dai, 0, DA7219_SYSCLK_PLL,
> -                                 CZ_PLAT_CLK, MCLK_RATE);
> +                                 CZ_PLAT_CLK, DA7219_PLL_FREQ_OUT_98304);
>          if (ret < 0) {
>                  dev_err(rtd->dev, "can't set codec pll: %d\n", ret);
>                  return ret;
> --
> 2.7.4
