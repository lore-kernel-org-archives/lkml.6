Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751448AbeBSGf0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 01:35:26 -0500
Received: from smtp-proxy002.phy.lolipop.jp ([157.7.104.43]:51135 "EHLO
        smtp-proxy002.phy.lolipop.jp" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750988AbeBSGfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 01:35:25 -0500
Subject: Re: [PATCH] ASoC: Intel: Skylake: Fix compiler warning
 -Wmaybe-uninitialized
To: Kirill Marinushkin <k.marinushkin@gmail.com>,
        linux-kernel@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>,
        Guneshwor Singh <guneshwor.o.singh@intel.com>,
        Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Harsha Priya N <harshapriya.n@intel.com>,
        Mark Brown <broonie@kernel.org>, Naveen Manohar <naveen.m@intel.com>
References: <20180219060229.17215-1-k.marinushkin@gmail.com>
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Message-ID: <f4eab116-caeb-0490-cea1-09452803f845@sakamocchi.jp>
Date: Mon, 19 Feb 2018 15:35:23 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180219060229.17215-1-k.marinushkin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Feb 19 2018 15:02, Kirill Marinushkin wrote:
> Configuration:
> 
> SND_SOC_INTEL_SKYLAKE=y
> PM_SLEEP=y
> 
> Warning message:
> 
> sound/soc/intel/skylake/skl.c: In function 'skl_resume':
> sound/soc/intel/skylake/skl.c:326:6: warning: 'ret' may be used
> uninitialized in this function [-Wmaybe-uninitialized]
>    int ret;
>        ^~~
> 
> Fixes: 4557c305d4fc ("ASoC: Intel: Skylake: Add support for active suspend")
> Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Guneshwor Singh <guneshwor.o.singh@intel.com>
> Cc: Naveen Manohar <naveen.m@intel.com>
> Cc: Harsha Priya N <harshapriya.n@intel.com>
> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Cc: alsa-devel@alsa-project.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   sound/soc/intel/skylake/skl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
> index 31d8634e8aa1..273a9ab75489 100644
> --- a/sound/soc/intel/skylake/skl.c
> +++ b/sound/soc/intel/skylake/skl.c
> @@ -323,7 +323,7 @@ static int skl_resume(struct device *dev)
>   	struct skl *skl  = ebus_to_skl(ebus);
>   	struct hdac_bus *bus = ebus_to_hbus(ebus);
>   	struct hdac_ext_link *hlink = NULL;
> -	int ret;
> +	int ret = 0;
>   
>   	/* Turned OFF in HDMI codec driver after codec reconfiguration */
>   	if (IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI)) {

At current HEAD (ea954fbc35e6) in 'topic/intel' branch[1] of Mark's 
tree, this issue was already fixed by Arnd Bergmann Nov 2017 by his 
commit cc20c4df1627 ('ASoC: intel: initialize return value properly')[2].


[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/log/?h=topic/intel
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?h=topic/intel&id=cc20c4df1627

Regards

Takashi Sakamoto
