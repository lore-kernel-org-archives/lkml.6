Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752409AbeBICHo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 21:07:44 -0500
Received: from smtp-proxy004.phy.lolipop.jp ([157.7.104.45]:53944 "EHLO
        smtp-proxy004.phy.lolipop.jp" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752172AbeBICHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 21:07:43 -0500
Subject: Re: [PATCH] ASoC: Intel: Skylake: make function skl_clk_round_rate
 static
To: Colin King <colin.king@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Sriram Periyasamy <sriramx.periyasamy@intel.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>,
        alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180208143530.11450-1-colin.king@canonical.com>
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Message-ID: <88ad9256-5c68-1e36-dd72-eba8ecba66e7@sakamocchi.jp>
Date: Fri, 9 Feb 2018 11:07:41 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180208143530.11450-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Feb 8 2018 23:35, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The function skl_clk_round_rate is local to the source and does not
> need to be in global scope, so make it static.
> 
> Cleans up sparse warning:
> sound/soc/intel/skylake/skl-ssp-clk.c:250:6: warning: symbol
> 'skl_clk_round_rate' was not declared. Should it be static?
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   sound/soc/intel/skylake/skl-ssp-clk.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

> diff --git a/sound/soc/intel/skylake/skl-ssp-clk.c b/sound/soc/intel/skylake/skl-ssp-clk.c
> index 7fbddf5e3b00..cda1b5fa7436 100644
> --- a/sound/soc/intel/skylake/skl-ssp-clk.c
> +++ b/sound/soc/intel/skylake/skl-ssp-clk.c
> @@ -247,8 +247,8 @@ static unsigned long skl_clk_recalc_rate(struct clk_hw *hw,
>   }
>   
>   /* Not supported by clk driver. Implemented to satisfy clk fw */
> -long skl_clk_round_rate(struct clk_hw *hw, unsigned long rate,
> -				unsigned long *parent_rate)
> +static long skl_clk_round_rate(struct clk_hw *hw, unsigned long rate,
> +			       unsigned long *parent_rate)
>   {
>   	return rate;
>   }


Thanks

Takashi Sakamoto
