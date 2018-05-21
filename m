Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753349AbeEUW1D (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 18:27:03 -0400
Received: from smtp-proxy003.phy.lolipop.jp ([157.7.104.44]:56159 "EHLO
        smtp-proxy003.phy.lolipop.jp" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752870AbeEUW06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 18:26:58 -0400
Subject: Re: [alsa-devel] [PATCH 29/33] ALSA: oxfw: use match_string() helper
To: Yisheng Xie <xieyisheng1@huawei.com>, linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>,
        Takashi Iwai <tiwai@suse.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
 <1526903890-35761-30-git-send-email-xieyisheng1@huawei.com>
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Message-ID: <fc6c89ab-a8e7-72f8-3cd6-308f21e77995@sakamocchi.jp>
Date: Tue, 22 May 2018 07:26:53 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1526903890-35761-30-git-send-email-xieyisheng1@huawei.com>
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
> Cc: alsa-devel@alsa-project.org
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---
>   sound/firewire/oxfw/oxfw.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

For my information, use_match_string() helper was firstly introduced to
v4.6 kernel by a commit 56b060814e2d ('lib/string: introduce 
match_string() helper').

> diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
> index 413ab63..1e5b2c8 100644
> --- a/sound/firewire/oxfw/oxfw.c
> +++ b/sound/firewire/oxfw/oxfw.c
> @@ -49,7 +49,6 @@ static bool detect_loud_models(struct fw_unit *unit)
>   		"Tapco LINK.firewire 4x6",
>   		"U.420"};
>   	char model[32];
> -	unsigned int i;
>   	int err;
>   
>   	err = fw_csr_string(unit->directory, CSR_MODEL,
> @@ -57,12 +56,7 @@ static bool detect_loud_models(struct fw_unit *unit)
>   	if (err < 0)
>   		return false;
>   
> -	for (i = 0; i < ARRAY_SIZE(models); i++) {
> -		if (strcmp(models[i], model) == 0)
> -			break;
> -	}
> -
> -	return (i < ARRAY_SIZE(models));
> +	return match_string(models, ARRAY_SIZE(models), model) >= 0;
>   }
>   
>   static int name_card(struct snd_oxfw *oxfw)

Thanks

Takashi Sakamoto
