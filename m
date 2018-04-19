Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751995AbeDSNOl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 09:14:41 -0400
Received: from regular1.263xmail.com ([211.150.99.141]:41960 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750858AbeDSNOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 09:14:40 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-IP-DOMAINF: 1
X-RL-SENDER: hjc@rock-chips.com
X-FST-TO: sandy.huang@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: hjc@rock-chips.com
X-UNIQUE-TAG: <c0da8029cdf7d7428ff0bb90f8e62c1d>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH] drm/rockchip: vop: fixup linebuffer mode calc error
To: Heiko Stuebner <heiko@sntech.de>
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1523960108-190541-1-git-send-email-hjc@rock-chips.com>
 <2475172.s4GHAT5PDW@phil>
From: Sandy Huang <hjc@rock-chips.com>
Message-ID: <10983760-1c4a-d4e2-be63-7684d87fc4b1@rock-chips.com>
Date: Thu, 19 Apr 2018 21:14:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <2475172.s4GHAT5PDW@phil>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2018/4/17 19:14, Heiko Stuebner Ð´µÀ:
> Hi Sandy,
> 
> Am Dienstag, 17. April 2018, 12:15:07 CEST schrieb Sandy Huang:
>> When video width is bigger than 3840 the linebuffer mode
>> should be LB_YUV_3840X5.
> 
> Can you explain that a bit better?
> 
> I.e. when looking at the code, the very first check is width > 2560.
> 
> So it seems your change targets some YUV mode with width > 3840
> which should be mentioned in the commit message, so people like
> me don't scratch their head in confusion ;-)
> 
> Similarly that check is actually width > 1280 to set LB_YUV_3840X5,
> so I guess you're actually wanting any YUV mode bigger than
> 1280px should use LB_YUV_3840X5?
> 
> 
> Heiko
> 

Thanks heiko,
I will make more description for this path at next version.

>> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
>> ---
>>   drivers/gpu/drm/rockchip/rockchip_drm_vop.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
>> index 56bbd2e..3e7501b 100644
>> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
>> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
>> @@ -332,7 +332,7 @@ static inline int scl_vop_cal_lb_mode(int width, bool is_yuv)
>>   
>>   	if (width > 2560)
>>   		lb_mode = LB_RGB_3840X2;
>> -	else if (width > 1920)
>> +	else if (!is_yuv && width > 1920)
>>   		lb_mode = LB_RGB_2560X4;
>>   	else if (!is_yuv)
>>   		lb_mode = LB_RGB_1920X5;
>>
> 
> 
> 
> 
> 
