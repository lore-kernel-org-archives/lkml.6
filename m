Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753649AbeBSTAc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 14:00:32 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46987 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753439AbeBSTAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 14:00:31 -0500
X-Google-Smtp-Source: AH8x226/cTaJ8NTTGSeGHj19YTyoGwCwhzNR782N6w9HS/E4UiDi7L8wO57WnhQpEqtz95EzrRiGbA==
Subject: Re: [PATCH 1/2] ASoC: topology: Rename clock_gated to clock_cont in
 snd_soc_tplg_hw_config
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
References: <20180219060531.17276-1-k.marinushkin@gmail.com>
 <458b66ab-da0a-8063-6555-13fb152c83a4@sakamocchi.jp>
From: Kirill Marinushkin <k.marinushkin@gmail.com>
Message-ID: <5f4279ef-bbf5-6d3d-50ef-59004d3b6053@gmail.com>
Date: Mon, 19 Feb 2018 20:00:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <458b66ab-da0a-8063-6555-13fb152c83a4@sakamocchi.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/19/18 07:47, Takashi Sakamoto wrote:
> Hi,
>
> On Feb 19 2018 15:05, Kirill Marinushkin wrote:
>> In kernel `soc-dai.h`, DAI clock gating is defined as following:
>>
>> ~~~~
>> \#define SND_SOC_DAIFMT_CONT        (1 << 4) /* continuous clock */
>> \#define SND_SOC_DAIFMT_GATED        (0 << 4) /* clock is gated */
>> ~~~~
>>
>> Therefore, the corresponding field of struct snd_soc_tplg_hw_config should
>> be inverted compared to the current logic:
>>
>> clock_count = 1 => SND_SOC_DAIFMT_CONT
>> clock_count = 0 => SND_SOC_DAIFMT_GATED
>>
>> Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
>> Cc: Jaroslav Kysela <perex@perex.cz>
>> Cc: Takashi Iwai <tiwai@suse.com>
>> Cc: alsa-devel@alsa-project.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>   include/uapi/sound/asoc.h | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
>> index 69c37ecbff7e..10188850dede 100644
>> --- a/include/uapi/sound/asoc.h
>> +++ b/include/uapi/sound/asoc.h
>> @@ -312,7 +312,9 @@ struct snd_soc_tplg_hw_config {
>>       __le32 size;            /* in bytes of this structure */
>>       __le32 id;        /* unique ID - - used to match */
>>       __le32 fmt;        /* SND_SOC_DAI_FORMAT_ format value */
>> -    __u8 clock_gated;    /* 1 if clock can be gated to save power */
>> +    __u8 clock_cont;    /* 1 if clock is continuous, and can not be
>> +                 * gated to save power
>> +                 */
>>       __u8 invert_bclk;    /* 1 for inverted BCLK, 0 for normal */
>>       __u8 invert_fsync;    /* 1 for inverted frame clock, 0 for normal */
>>       __u8 bclk_master;    /* 1 for master of BCLK, 0 for slave */
>
> This structure was added at a commit 676c6b5208f7 ('ASoC: topology: ABI - Update physical DAI link configuration for version 5') in a development period for v4.10.
>
> This file is a part of UAPI, thus this structure has already been exposed to application developers. Any change can break userspace applications in a point of backward compatibility for this subsystem.
>
> It's better for you to investigate another solution for your two patches[1][2].
>
>
> [1] [alsa-devel] [PATCH 1/2] ASoC: topology: Rename clock_gated to clock_cont in snd_soc_tplg_hw_config
> http://mailman.alsa-project.org/pipermail/alsa-devel/2018-February/132258.html
> [2] [alsa-devel] [PATCH 2/2] ASoC: topology: Add missing clock gating parameter when parsing hw_configs
> http://mailman.alsa-project.org/pipermail/alsa-devel/2018-February/132259.html
>
>
> Regards
>
> Takashi Sakamoto

Hello Takashi Sakamoto,

I will propose a backwards-compatible solution as a PATCH v2.

Best Regards,
Kirill
