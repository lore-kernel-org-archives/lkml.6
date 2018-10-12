Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8A0C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E5FF2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E5FF2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbeJLTsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 15:48:04 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:51501 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728213AbeJLTsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 15:48:03 -0400
Received: from [192.168.178.69] ([109.104.38.145]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mg6JS-1fjqvk0bbK-00hhsQ; Fri, 12 Oct 2018 14:15:06 +0200
Received: from [192.168.178.69] ([109.104.38.145]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mg6JS-1fjqvk0bbK-00hhsQ; Fri, 12 Oct 2018 14:15:06 +0200
Subject: Re: [PATCH v2 0/2] pwm: sysfs: fix exporting PWM channel
To:     Thierry Reding <thierry.reding@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     gottfried.haider@gmail.com, michal.vokac@ysoft.com,
        loic.pallardy@st.com, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, hsweeten@visionengravers.com,
        broonie@kernel.org, linux-rpi-kernel@lists.infradead.org,
        gohai@sukzessiv.net, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
References: <1538400237-28766-1-git-send-email-fabrice.gasnier@st.com>
 <20181012115500.GD31561@ulmo>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <ad0206b8-2cda-a147-1b71-8e2eced06e61@i2se.com>
Date:   Fri, 12 Oct 2018 14:15:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181012115500.GD31561@ulmo>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:7wJgy4vCMZKB/8pS790zVm5spTTpr9MIqkxKYW8OENCVqgw/pnT
 98A2GnMTUu1aF36RzOLa1n/coZzWS9L2oS8hehnPI+jliLAbt/+peZRrQ0qkciPW+MSeuTC
 GCeZ2NNi/+/Rv4iVARs5rNZ5gFc+1OIS1eL/FJjLgOstrZDqMpcJVDXA132hz6idYjunTOC
 5868KtprJ5nXtuWPTUCwg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BoSUh/s3x18=:zorMfPo7D8vWIYgwGLUy/i
 cgITKB0jFl1rM0+clDV8Gw42L+aC1+K74MsGmww9Grs7Xy03iHD3kfWD+Zx8NtzN+WlK9JM/j
 AtIdVQUJoIyCOYV3dffFMLkynZta++HafX3w6XRCtu6CXz7pLcMTzDw7vDwT0kHjXs7XOGZxi
 YDdi3lPIPmteTRWPLGyouXqJSw/v/ObMKB2Ar4+YLj88WnBBf3Yp/dkBbUVVn3ONapoDTJuq7
 CtvYDuyJf+tNdcuEJZnUy7Cnom9LQdo4nvHJjAyTrtatFujy++RDT/lNhrWsxLYYc3fsuyKLM
 KqffqDRnioHYeSaV1uKBPnmtVxfLMKfkcwnV+3WvgJaa3q2hA/I2XYdDWUu+WEM5AzY8Q8GTQ
 m5KTH6hGaxIzQSAQsuCeTwZfOov4IOKyhX+HxVaG/avLTZZmtqnOObIEOozkl5J/8t+F0YIy+
 coK5QA5+NhRb0Ru+iXkoMW4ng9BtQIMN6YzjUTz9ZYCi85bp2J1oBcChkao3LB3oZTHq8ow9d
 NeJKi0HzHy12qNuXWxsqFOW9PNfxRcnaSo0PnNUp/3Q+53QSm5Mly61sjjRyXG/GYZKYqd6Z3
 NSMwL+muA7Ud36dTFr2ftGNVCaV5A+1kwpWQ2KC/NG63wccTiyPhp59wSL9QMExZ2glK6asPj
 9wAbvTOEo0uaSCHhW8BEFD5s9nxr4/s57WPub+jpMQODoZM450nVnMckwQ5norDfCUZU4ZCmM
 QrcT868SGFZhfSpr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 12.10.2018 um 13:55 schrieb Thierry Reding:
> On Mon, Oct 01, 2018 at 03:23:55PM +0200, Fabrice Gasnier wrote:
>> Since commit 7e5d1fd75c3d ("pwm: Set class for exported channels in sysfs")
>> - it's not possible to export more than one PWM channel
>> - ABI has changed, as a side effect. It may cause bad behavior as pwmchip
>>   attributes are wrongly added to pwm channels and report wrong values.
>> See [1] and [2].
>>
>> One purpose of the original patch is to send uevents to udev, when exporting a
>> PWM channel through the sysfs. This series:
>> - Reverts the original patch.
>> - Proposes a new way to send notifications to be used by udev rules.
>>
>> - With this series:
>> $ echo 0 > /sys/class/pwm/pwmchip0/export
>> $ ls /sys/class/pwm
>> pwmchip0 pwmchip4
>>
>> $ ls /sys/class/pwm/pwmchip0/pwm0/
>> capture     enable      polarity    uevent
>> duty_cycle  period      power
>>
>> - Without this series:
>> $ echo 0 > /sys/class/pwm/pwmchip0/export
>> $ ls /sys/class/pwm
>> pwm0 pwmchip0 pwmchip4
>>
>> $ ls /sys/class/pwm/pwmchip0/pwm0/
>> capture     duty_cycle  export      period      power       uevent
>> device      enable      npwm        polarity    subsystem   unexport
>>
>> - Backtrace when exporting a 2nd channel (0) on a separate pwmchip device:
>> $ echo 0 > /sys/class/pwm/pwmchip4/export
>> [   95.286558] sysfs: cannot create duplicate filename '/class/pwm/pwm0'
>> [   95.293630] CPU: 0 PID: 54 Comm: sh Not tainted 4.19.0-rc6-00013-g00b49b0 #151
>> [   95.301344] Hardware name: STM32 (Device Tree Support)
>> [   95.306833] [<0000c155>] (unwind_backtrace) from [<0000b273>] (show_stack+0xb/0xc)
>> [   95.315136] [<0000b273>] (show_stack) from [<00092455>] (sysfs_warn_dup+0x31/0x48)
>> [   95.323247] [<00092455>] (sysfs_warn_dup) from [<00092635>] (sysfs_do_create_link_sd+0x75/0x88)
>> [   95.332539] [<00092635>] (sysfs_do_create_link_sd) from [<00125823>] (device_add+0x133/0x3b0)
>> [   95.341694] [<00125823>] (device_add) from [<001059ed>] (export_store+0xb5/0x12c)
>> [   95.349761] [<001059ed>] (export_store) from [<00091911>] (kernfs_fop_write+0x87/0xda)
>> [   95.358150] [<00091911>] (kernfs_fop_write) from [<0005beb1>] (__vfs_write+0x1d/0xe0)
>> [   95.366295] [<0005beb1>] (__vfs_write) from [<0005bfe7>] (vfs_write+0x4f/0x7c)
>> [   95.374053] [<0005bfe7>] (vfs_write) from [<0005c0bf>] (ksys_write+0x33/0x70)
>> [   95.381708] [<0005c0bf>] (ksys_write) from [<00009001>] (ret_fast_syscall+0x1/0x58)
>> [   95.389682] Exception stack(0x01bcffa8 to 0x01bcfff0)
>> [   95.394946] ffa0:                   00000000 00c4883c 00000001 00c4e590 00000002 00000004
>> [   95.403639] ffc0: 00000000 00c4883c 00c4cbe8 00000004 00000002 00000020 00000000 00c4d008
>> [   95.412223] ffe0: 00c29151 00c4cbe8 00c17833 00c13c0c
>> -sh: write error: File exists
>>
>> [1] https://lkml.org/lkml/2018/9/25/713
>> [2] https://lkml.org/lkml/2018/9/25/447
>>
>> ---
>> Changes in v2:
>> - update revert commit message
>> - new patch 2/2 to propose uevent notification (change) on pwmchip
>>
>> Fabrice Gasnier (2):
>>   Revert "pwm: Set class for exported channels in sysfs"
>>   pwm: send a uevent on the pwmchip device upon channel sysfs (un)export
>>
>>  drivers/pwm/sysfs.c | 12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
> Both patches applied, thanks. What do you think would be the importance
> of getting this into stable kernels? We can't get one of the patches in
> without the other, so they'd both have to be backported. The second one
> is still fairly small, so would qualify for stable, I think.
I think the revert patch should go to stable, because it fixes a regression.

Thanks
>
> However, given that it's taken a long time for somebody to notice this,
> I'm not sure if this is something that people care about too much in the
> stable kernels.
>
> Thierry
