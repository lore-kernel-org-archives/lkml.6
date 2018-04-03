Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754698AbeDCA5d (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 20:57:33 -0400
Received: from mga17.intel.com ([192.55.52.151]:59136 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754604AbeDCA5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 20:57:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,398,1517904000";
   d="scan'208";a="38889920"
Subject: Re: [PATCH v3 0/2] ASoC: topology: Improve parsing hw_configs
To: Kirill Marinushkin <k.marinushkin@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>,
        Mark Brown <broonie@kernel.org>, Pan Xiuli <xiuli.pan@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20180327205632.3677-1-k.marinushkin@gmail.com>
 <17f0767a-2dea-92dd-a88e-a3f3e670d0d2@gmail.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <461bbabf-7c36-1361-8f66-5abbe3c7f4d8@linux.intel.com>
Date: Mon, 2 Apr 2018 19:57:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <17f0767a-2dea-92dd-a88e-a3f3e670d0d2@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/02/2018 04:17 PM, Kirill Marinushkin wrote:
> Hello Pierre-Louis,
>
> I explicitly clarified with Takashi: to have this patch series merged, we need a
> tag "Reviewed-by" from you.
I am fine with the changes, but maybe while we are at it, we should 
clarify what mclk_direction means?

     __u8 mclk_direction;    /* 0 for input, 1 for output */

This is really awful and might benefit for additional clarity using 
codec-centric conventions.

We also had a discussion internally and can't figure out why the strings 
are different from the fields in the structure, I feel it'd be simpler 
to align config and code to avoid issues but keep existing notation for 
backwards compatibility, e.g.

if (strcmp(id, "mclk_freq") == 0) || strcmp(id, "mclk_rate") == 0) {
         if (snd_config_get_string(n, &val) < 0)
                 return -EINVAL;

             hw_cfg->mclk_rate = atoi(val);
             continue;
}
>
> Patches [2] and [5]:
> You already tested them. May I put a tag "Reviewed-by" with your name into them?
>
> Patches [3] and [6]:
> Those are new for you; I added them to this patch series, because they are
> logically similar to [2] and [5].
> Could you please review these patches?
>
> Best Regards,
> Kirill
>
> [1] [PATCH v3 0/2] ASoC: topology: Improve parsing hw_configs
> [2] [PATCH v3 1/2] ASoC: topology: Fix bclk and fsync inversion in set_link_hw_format()
> [3] [PATCH v3 2/2] ASoC: topology: Add missing clock gating parameter when parsing hw_configs
> [4] [PATCH, alsa-lib, v3 0/2] alsa-lib: ASoC: topology: Improve parsing hw_configs
> [5] [PATCH, alsa-lib, v3 1/2] ASoC: topology: Fix bclk and fsync inversion in set_link_hw_format()
> [6] [PATCH, alsa-lib, v3 2/2] ASoC: topology: Add missing clock gating parameter when parsing hw_configs
>
>
> On 03/27/18 22:56, Kirill Marinushkin wrote:
>> Hello Jaroslav, Takashi, Mark,
>>
>> This patch series is a resend of [1] and [2], rebased on top of the latest
>> head. It was logical to resend them together.
>>
>> It includes 2 patches for linux + 2 patches for alsa-lib.
>>
>> Please have a look.
>>
>> Best Regards,
>> Kirill
>>
>> [1] https://patchwork.kernel.org/patch/10250485/
>> [2] https://patchwork.kernel.org/patch/10230611/
>>
>> Kirill Marinushkin (2):
>>    ASoC: topology: Fix bclk and fsync inversion in set_link_hw_format()
>>    ASoC: topology: Add missing clock gating parameter when parsing
>>      hw_configs
>>
>>   include/uapi/sound/asoc.h | 23 ++++++++++++++++++++---
>>   sound/soc/soc-topology.c  | 19 ++++++++++++++-----
>>   2 files changed, 34 insertions(+), 8 deletions(-)
>>
