Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751515AbeBWJFS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 04:05:18 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:37751 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751276AbeBWJFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 04:05:17 -0500
X-Google-Smtp-Source: AG47ELv/MmJji9e1LF7yGm/v2ZSmrP14WXc25L/LimPXEfMGrFFswVXSoSt30ek6avVb4ZIi7/xjlsp3t+IX82r7LPQ=
MIME-Version: 1.0
In-Reply-To: <e5ed9897-869f-87e8-0369-8a2dbe7c9b5a@st.com>
References: <20180131080508.14356-1-benjamin.gaignard@linaro.org> <e5ed9897-869f-87e8-0369-8a2dbe7c9b5a@st.com>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Fri, 23 Feb 2018 10:05:15 +0100
Message-ID: <CA+M3ks4UYUA-2auOWF1iRcP8QB3sMb0+B6-nk1NUn29R1T_35Q@mail.gmail.com>
Subject: Re: [PATCH v2] drm/stm: check pitch and size calculations even if !CONFIG_MMU
To: Philippe CORNU <philippe.cornu@st.com>
Cc: Yannick FERTRE <yannick.fertre@st.com>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        "laurent.pinchart@ideasonboard.com"
        <laurent.pinchart@ideasonboard.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-23 9:33 GMT+01:00 Philippe CORNU <philippe.cornu@st.com>:
> Hi Benjamin,
>
> On 01/31/2018 09:05 AM, Benjamin Gaignard wrote:
>> In all cases we have to check pitch and size calculations to speed up
>> data transfer.
>>
>> Fixes: 21f815bf773c ("drm/stm: drv: Improve data transfers")
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
>> ---
>>   drivers/gpu/drm/stm/drv.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
>> index 8bc7e8418b8d..9ab00a87f7cc 100644
>> --- a/drivers/gpu/drm/stm/drv.c
>> +++ b/drivers/gpu/drm/stm/drv.c
>> @@ -35,7 +35,6 @@ static int stm_gem_cma_dumb_create(struct drm_file *file,
>>                                  struct drm_device *dev,
>>                                  struct drm_mode_create_dumb *args)
>>   {
>> -#ifdef CONFIG_MMU
>>       unsigned int min_pitch = DIV_ROUND_UP(args->width * args->bpp, 8);
>>
>>       /*
>> @@ -44,7 +43,6 @@ static int stm_gem_cma_dumb_create(struct drm_file *file,
>>        */
>>       args->pitch = roundup(min_pitch, 128);
>>       args->height = roundup(args->height, 4);
>> -#endif
>
> Reviewed-by: Philippe Cornu <philippe.cornu@st.com>

Applied on drm-misc-next.

Regards,
Benjamin

>
> Many thanks,
> Philippe :-)
>
>>
>>       return drm_gem_cma_dumb_create_internal(file, dev, args);
>>   }
>>
