Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751541AbeBSOAK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 09:00:10 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55928 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750978AbeBSOAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 09:00:09 -0500
X-Google-Smtp-Source: AH8x227D3SO8rkEklTL+0mzHLwBQNAKekbmYoDV+QOp84SFHL5JJ4oqP7+akXcqq58MUV76EB7Rvfg==
Subject: Re: [PATCH 1/9] ASoC: Intel: sst: Fix error-code check in
 sst_pause_stream()
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180218220146.22485-1-hdegoede@redhat.com>
 <20180218220146.22485-2-hdegoede@redhat.com>
 <CAHp75VeANVAbjq69x2k3mEkodhzWctQ58EVOz90CjgnS5K+UTQ@mail.gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <f7f6b692-365d-a406-8d6d-f6422ac656f8@redhat.com>
Date: Mon, 19 Feb 2018 15:00:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VeANVAbjq69x2k3mEkodhzWctQ58EVOz90CjgnS5K+UTQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19-02-18 14:47, Andy Shevchenko wrote:
> On Mon, Feb 19, 2018 at 12:01 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> The value returned by sst_prepare_and_post_msg() is a negated SST_ERR_*
>> value, so we must check for -SST_ERR_INVALID_STREAM_ID. Note that
>> sst_pause_resume() already has the correct check.
>>
> 
> Should it have Fixes tag?

According to git blame this goes back to the original commit introducing
the file, so I don't think that that is helpful.

Regards,

Hans



> 
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   sound/soc/intel/atom/sst/sst_stream.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/intel/atom/sst/sst_stream.c b/sound/soc/intel/atom/sst/sst_stream.c
>> index 7ee6aeb7e0af..b082b0922a7a 100644
>> --- a/sound/soc/intel/atom/sst/sst_stream.c
>> +++ b/sound/soc/intel/atom/sst/sst_stream.c
>> @@ -253,7 +253,7 @@ int sst_pause_stream(struct intel_sst_drv *sst_drv_ctx, int str_id)
>>                  if (retval == 0) {
>>                          str_info->prev = str_info->status;
>>                          str_info->status = STREAM_PAUSED;
>> -               } else if (retval == SST_ERR_INVALID_STREAM_ID) {
>> +               } else if (retval == -SST_ERR_INVALID_STREAM_ID) {
>>                          retval = -EINVAL;
>>                          mutex_lock(&sst_drv_ctx->sst_lock);
>>                          sst_clean_stream(str_info);
>> --
>> 2.14.3
>>
> 
> 
> 
