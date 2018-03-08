Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750996AbeCHUP3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 15:15:29 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:32899 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750880AbeCHUP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 15:15:27 -0500
X-Google-Smtp-Source: AG47ELu76jMHqCe2Krws6UtBL7wZza6zqnKhnXX7SjrlEkHLGTcH0ELFfGbLXIM5Q3N6MFibN/uwDA==
Subject: Re: [PATCH] ASoC: cygnus: remove redundant assignment to pointer
 'res'
To: Colin King <colin.king@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Lori Hikichi <lori.hikichi@broadcom.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180308133249.22032-1-colin.king@canonical.com>
From: Scott Branden <scott.branden@broadcom.com>
Message-ID: <576fbe04-bef0-171d-a1eb-40c6cbb2874e@broadcom.com>
Date: Thu, 8 Mar 2018 12:15:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180308133249.22032-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good.


On 18-03-08 05:32 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> The pointer res is being initialized with a value that is never read
> and re-assigned immediately after, hence the initialization is redundant
> and can be removed.
>
> Cleans up clang warning:
> sound/soc/bcm/cygnus-ssp.c:1284:19: warning: Value stored to 'res'
> during its initialization is never read
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Scott Branden <scott.branden@broadcom.com>
> ---
>   sound/soc/bcm/cygnus-ssp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/bcm/cygnus-ssp.c b/sound/soc/bcm/cygnus-ssp.c
> index abafadc0b534..b733f1446353 100644
> --- a/sound/soc/bcm/cygnus-ssp.c
> +++ b/sound/soc/bcm/cygnus-ssp.c
> @@ -1281,7 +1281,7 @@ static int cygnus_ssp_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct device_node *child_node;
> -	struct resource *res = pdev->resource;
> +	struct resource *res;
>   	struct cygnus_audio *cygaud;
>   	int err = -EINVAL;
>   	int node_count;
