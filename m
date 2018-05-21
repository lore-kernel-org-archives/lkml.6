Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752766AbeEUWb1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 18:31:27 -0400
Received: from smtp-proxy002.phy.lolipop.jp ([157.7.104.43]:45067 "EHLO
        smtp-proxy002.phy.lolipop.jp" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750993AbeEUWbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 18:31:24 -0400
Subject: Re: [PATCH 28/33] ALSA: dice use match_string() helper
To: Yisheng Xie <xieyisheng1@huawei.com>, linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>,
        Takashi Iwai <tiwai@suse.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
 <1526903890-35761-29-git-send-email-xieyisheng1@huawei.com>
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Message-ID: <856cff99-0350-368e-f6c9-d632839e6c33@sakamocchi.jp>
Date: Tue, 22 May 2018 07:31:23 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1526903890-35761-29-git-send-email-xieyisheng1@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On May 21 2018 20:58, Yisheng Xie wrote:
> match_string() returns the index of an array for a matching string,
> which can be used intead of open coded variant.
> 
> Cc: Clemens Ladisch <clemens@ladisch.de>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> Cc: alsa-devel@alsa-project.org
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---
>   sound/firewire/dice/dice.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)

I'm welcome to this change, while in the latest subsystem tree for v4.18
the 'force_to_pcm_support()' local function was removed by my patch[1].
Your patch can be abandon.

> diff --git a/sound/firewire/dice/dice.c b/sound/firewire/dice/dice.c
> index 96bb01b..0639074 100644
> --- a/sound/firewire/dice/dice.c
> +++ b/sound/firewire/dice/dice.c
> @@ -35,19 +35,13 @@ static bool force_two_pcm_support(struct fw_unit *unit)
>   		"SAFFIRE_PRO_40_1",
>   	};
>   	char model[32];
> -	unsigned int i;
>   	int err;
>   
>   	err = fw_csr_string(unit->directory, CSR_MODEL, model, sizeof(model));
>   	if (err < 0)
>   		return false;
>   
> -	for (i = 0; i < ARRAY_SIZE(models); i++) {
> -		if (strcmp(models[i], model) == 0)
> -			break;
> -	}
> -
> -	return i < ARRAY_SIZE(models);
> +	return match_string(models, ARRAY_SIZE(models), model) >= 0;
>   }
>   
>   static int check_dice_category(struct fw_unit *unit)

[1] ALSA: dice: remove local frag of force_two_pcms
https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/commit/?h=for-next&id=9c367c01d3d5


Thanks

Takashi Sakamoto
