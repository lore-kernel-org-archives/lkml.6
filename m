Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753892AbeDTGKP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 02:10:15 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:38851 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753822AbeDTGKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 02:10:13 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID w3K68Xun003768, This message is accepted by code: ctloc85258
From: Bard Liao <bardliao@realtek.com>
To: Colin King <colin.king@canonical.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][next] ASoC: rt5668: fix incorrect 'and' operator
Thread-Topic: [PATCH][next] ASoC: rt5668: fix incorrect 'and' operator
Thread-Index: AQHT1+uK5+if6SCSTEejMftGJP6rM6QJK98g
Date: Fri, 20 Apr 2018 06:08:29 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D7027C9E45@RTITMBSV02.realtek.com.tw>
References: <20180419143431.13173-1-colin.king@canonical.com>
In-Reply-To: <20180419143431.13173-1-colin.king@canonical.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.102.104]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3K6AJrY030520

> -----Original Message-----
> From: Colin King [mailto:colin.king@canonical.com]
> Sent: Thursday, April 19, 2018 10:35 PM
> To: Bard Liao; Oder Chiou; Liam Girdwood; Mark Brown; Jaroslav Kysela;
> Takashi Iwai; alsa-devel@alsa-project.org
> Cc: kernel-janitors@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH][next] ASoC: rt5668: fix incorrect 'and' operator
> 
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently logical and is being used instead of bitwise and. Fix this.
> 
> Detected by CoverityScan, CID#1468008 ("Logical vs bitwise operator")
> 
> Fixes: d59fb2856223 ("ASoC: rt5668: add rt5668B codec driver")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-By: Bard Liao <bardliao@realtek.com>

> ---
>  sound/soc/codecs/rt5668.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/rt5668.c b/sound/soc/codecs/rt5668.c
> index 52a343f96eb2..3c19d03f2446 100644
> --- a/sound/soc/codecs/rt5668.c
> +++ b/sound/soc/codecs/rt5668.c
> @@ -1194,7 +1194,7 @@ static int set_filter_clk(struct snd_soc_dapm_widget
> *w,
>  	int ref, val, reg, idx = -EINVAL;
>  	static const int div[] = {1, 2, 3, 4, 6, 8, 12, 16, 24, 32, 48};
> 
> -	val = snd_soc_component_read32(component, RT5668_GPIO_CTRL_1)
> &&
> +	val = snd_soc_component_read32(component, RT5668_GPIO_CTRL_1) &
>  		RT5668_GP4_PIN_MASK;
>  	if (w->shift == RT5668_PWR_ADC_S1F_BIT &&
>  		val == RT5668_GP4_PIN_ADCDAT2)
> --
> 2.17.0
> 
> 
> ------Please consider the environment before printing this e-mail.
