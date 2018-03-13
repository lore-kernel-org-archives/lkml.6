Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752783AbeCMOMu convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 10:12:50 -0400
Received: from mail.tricorecenter.de ([217.6.246.34]:43937 "EHLO
        root.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752604AbeCMOMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 10:12:48 -0400
Subject: Re: [PATCH v2 1/2] mfd: rk808: Change DEV_OFF to DEV_OFF_RST for
 rk818 shutdown
To: Joseph Chen <chenjh@rock-chips.com>, Lee Jones <lee.jones@linaro.org>
Cc: zyw@rock-chips.com, zhangqing@rock-chips.com,
        linux-kernel@vger.kernel.org, w.egorov@phytec.de
References: <1520442110-28420-1-git-send-email-d.schultz@phytec.de>
 <20180312140946.quqbfvjourjwjaju@dell>
 <040f2e2d-680d-8da3-75df-78da16cc46ba@rock-chips.com>
From: Daniel Schultz <d.schultz@phytec.de>
Message-ID: <eb547d50-0dfb-765a-7f1c-8dd367ea0fde@phytec.de>
Date: Tue, 13 Mar 2018 15:14:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <040f2e2d-680d-8da3-75df-78da16cc46ba@rock-chips.com>
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 13.03.2018 15:12:46,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 13.03.2018 15:12:46
X-TNEFEvaluated: 1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03/13/2018 03:44 AM, Joseph Chen wrote:
> Hi, Lee and Daniel：
> 
>      I am really sorry for reply so late,  I don't realize that Daniel's 
> emails ended up in my junk mail file.
> 
> 
> 在 2018/3/12 22:09, Lee Jones 写道:
>> Rockchip guys,
>>
>> I'd really appreciate your input on these two patches please.
>>
>> Please provide Reviewed-by/Tested-by tags.
>>
>> On Wed, 07 Mar 2018, Daniel Schultz wrote:
>>> After running "poweroff", the PMIC restarts the SoC instead of shutting
>>> it down.
>>>
>>> It seems like the description for those two register bits is swapped.
>>> After changing from DEV_OFF to DEV_OFF_RST, the system can poweroff
>>> correctly.
>>>
>>> Signed-off-by: Daniel Schultz<d.schultz@phytec.de>
>>> ---
>>> Changes:
>>> 	v2: Re-submit with recipients from Rockchip.
>>>
>>>   drivers/mfd/rk808.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
>>> index 216fbf6..d138721 100644
>>> --- a/drivers/mfd/rk808.c
>>> +++ b/drivers/mfd/rk808.c
>>> @@ -418,7 +418,7 @@ static void rk818_device_shutdown(void)
>>>   
>>>   	ret = regmap_update_bits(rk808->regmap,
>>>   				 RK818_DEVCTRL_REG,
>>> -				 DEV_OFF, DEV_OFF);
>>> +				 DEV_OFF_RST, DEV_OFF_RST);
>>>   	if (ret)
>>>   		dev_err(&rk808_i2c_client->dev, "power off error!\n");
>>>   }
> 
> I think there maybe something wrong makes your machine restart after 
> "poweroff".
>      (1) Is your machine attaching charger when you run "poweroff"? 
> RK818 is hardware designed to auto power on when it detects voltage on 
> input pins(8,9);

That's the point! Both pins are driven high... thank you!

We will check how we can handle this on our hardware. For now, I will 
recall this patch.

-- 
Mit freundlichen Grüßen,
With best regards,
   Daniel Schultz

>      (2) If restart, you can dump ON_SOURCE(address: 0xAE) and 
> OFF_SOURCE(address: 0xAF) in rk808.c probe() to know  last power off 
> reason and currently power on reason;
> 
> -- 
> Best Regards
> ----------------------------------------------------------------------------
> 陈健洪 (Joseph Chen)
> E-mail：chenjh@rock-chips.com
> 福州瑞芯微电子股份有限公司
> Fuzhou Rockchip Electronics Co.Ltd
> 福建省福州市铜盘路软件大道89号软件园A区21号楼 (350003)
> No. 21 Building, A District, No.89,software Boulevard Fuzhou,Fujian,PRC
> TEL：0591-83991906/07-8573
> 
