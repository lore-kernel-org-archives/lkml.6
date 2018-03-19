Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970700AbeCSTAV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 15:00:21 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43154 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S970143AbeCSS3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 14:29:01 -0400
Subject: Re: [RESEND PATCH v5 1/5] pwm-backlight: enable/disable the PWM
 before/after LCD enable toggle.
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Heiko Stuebner <heiko@sntech.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Richard Purdie <rpurdie@rpsys.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
References: <20180216174034.15936-1-enric.balletbo@collabora.com>
 <20180319165829.GB22770@ulmo>
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <a2ea8b01-1182-7c80-60a2-4b4e0d8141ab@collabora.com>
Date: Mon, 19 Mar 2018 19:28:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180319165829.GB22770@ulmo>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,

Thanks for your ack.

On 19/03/18 17:58, Thierry Reding wrote:
> On Fri, Feb 16, 2018 at 06:40:30PM +0100, Enric Balletbo i Serra wrote:
>> Before this patch the enable signal was set before the PWM signal and
>> vice-versa on power off. This sequence is wrong, at least, it is on
>> the different panels datasheets that I checked, so I inverted the sequence
>> to follow the specs.
>>
>> For reference the following panels have the mentioned sequence:
>>   - N133HSE-EA1 (Innolux)
>>   - N116BGE (Innolux)
>>   - N156BGE-L21 (Innolux)
>>   - B101EAN0 (Auo)
>>   - B101AW03 (Auo)
>>   - LTN101NT05 (Samsung)
>>   - CLAA101WA01A (Chunghwa)
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
>> Acked-by: Jingoo Han <jingoohan1@gmail.com>
>> ---
>> Changes since v4:
>>  - Rebase on top of mainline.
>>  - Add the acks from Daniel Thompson and Jingoo Han.
>> Changes since v3:
>>  - List the part numbers for the panel checked (Daniel Thompson)
>> Changes since v2:
>>  - Add this as a separate patch (Thierry Reding)
>> Changes since v1:
>>  - None
>>
>>  drivers/video/backlight/pwm_bl.c | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> I'm surprised that panels even care about this. Do you see actual
> breakage if these are the other way around?
> 

At least the B116XTN02 requires enable first the PWM, wait 10ms and then BL_EN
to avoid garbage. I did not observe the issue on other panels but the datasheets
I checked specifies this sequence as correct.

> Anyway, this seems to me as legit as the other way around, so:
> 
> Acked-by: Thierry Reding <thierry.reding@gmail.com>
> 
