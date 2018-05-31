Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754850AbeEaM1A (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 08:27:00 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8234 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754197AbeEaM06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 08:26:58 -0400
Subject: Re: [PATCH v2 00/21] use match_string() helper
To: <linux-kernel@vger.kernel.org>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
CC: <andy.shevchenko@gmail.com>, Mark Brown <broonie@kernel.org>
From: Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <838ab31a-7fcf-8a36-8fd4-c5385086c631@huawei.com>
Date: Thu, 31 May 2018 20:23:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.40]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Mark

On 2018/5/31 19:11, Yisheng Xie wrote:
> Andy introduce helper function match_string() which can be used to return
> the index of array for a matching string. so we can use it in many places
> instead of open coded variant.
> 
> I just try to make this API be used more commonly, sorry if this makes
> too much big patchset.
> 
> v2:
>  - Remove the Patches which Andy already sent out, or maintainer already
>    picked up.
>  - Add Reviewed-by or Acked-by tags for some patchs.
>  - Add some new patches[19-21].
> 
> Yisheng Xie (21):
>   usb: phy: use match_string() helper
>   mfd: omap-usb-host: use match_string() helper
>   Staging: gdm724x: use match_string() helper
>   cxgb4: use match_string() helper
>   hp100: use match_string() helper
>   iwlwifi: mvm: use match_string() helper
>   bus: fsl-mc: use match_string() helper
>   clk: bcm2835: use match_string() helper
>   clk: use match_string() helper
>   cpufreq: intel_pstate: use match_string() helper
>   drm/nouveau: use match_string() helper
>   drm: i2c: ch7006: use match_string() helper
>   ima: use match_string() helper
>   sched/debug: use match_string() helper
>   ALSA: oxygen: use match_string() helper
>   ASoC: max98088: use match_string() helper
>   ASoC: max98095: use match_string() helper
>   ASoC: dapm: use match_string() helper
>   bcache: use match_string() helper
>   powerpc/xmon: use match_string() helper
>   sparc64: use match_string() helper
> 
>  arch/powerpc/xmon/xmon.c                         | 23 +++++++++---------
>  arch/sparc/kernel/setup_64.c                     |  7 +++---
>  drivers/bus/fsl-mc/fsl-mc-allocator.c            | 24 ++++--------------
>  drivers/clk/bcm/clk-bcm2835.c                    | 13 +++++-----
>  drivers/clk/clk.c                                |  8 ++----
>  drivers/cpufreq/intel_pstate.c                   | 15 +++++-------
>  drivers/gpu/drm/i2c/ch7006_drv.c                 | 13 ++++------
>  drivers/gpu/drm/nouveau/dispnv04/tvnv17.c        | 13 ++++------
>  drivers/md/bcache/util.c                         |  9 ++-----
>  drivers/mfd/omap-usb-host.c                      | 24 ++----------------
>  drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c   | 14 +++--------
>  drivers/net/ethernet/hp/hp100.c                  |  9 +------
>  drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c | 13 +++-------
>  drivers/staging/gdm724x/gdm_tty.c                | 18 ++++----------
>  drivers/usb/phy/of.c                             | 10 ++++----
>  kernel/sched/debug.c                             | 31 ++++++++++++------------
>  security/integrity/ima/ima_main.c                | 11 +++------
>  sound/pci/oxygen/oxygen_mixer.c                  | 14 +++++------
>  sound/soc/codecs/max98088.c                      | 13 ++++------
>  sound/soc/codecs/max98095.c                      | 13 ++++------
>  sound/soc/soc-dapm.c                             | 18 ++++++--------
>  21 files changed, 109 insertions(+), 204 deletions(-)
> 
