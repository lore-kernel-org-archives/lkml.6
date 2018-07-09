Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911C3C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3408F20881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U/gQSb9i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3408F20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932687AbeGIMNi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:13:38 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36993 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932567AbeGIMNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:13:36 -0400
Received: by mail-oi0-f65.google.com with SMTP id k81-v6so35414153oib.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 05:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vp01Dn7IkA+rRCW9mdGDqGDjNK0TNscm9zcD3y07lFI=;
        b=U/gQSb9iO1fN0fZKJnBj1vLPldpAg/7M66fgebKstnX5tOfTqVvJOP/fOFu6pt+LHV
         XRj2ebyk4RZWzTBLXH1KIsBUHRt6rTW7HIw7VbgosaSFnNZC72GoOEiEuQO+RSyzQeVR
         LA+mJ6AHAsEdm6JiFJFAM7uZ5FVqaZh4ideHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vp01Dn7IkA+rRCW9mdGDqGDjNK0TNscm9zcD3y07lFI=;
        b=oQqo6GOofHOb0BLDEeS0mUpZnCkh6EGCwDJhhPh43vXRUxYTAAa9OlrynS2ugpwNjx
         cbP5QbQQuca9qmdRPWlWJtM2dlce/osNdWH7cph+TTSUjGaKUukZZ4emZ9NZ+E7GfucV
         EN/LYPqbc7q6+4MTw1A89l7KfIqUHt+Z5ToGczzPK1qHfQIyNaDJZOO7oc6EVL0EvENq
         5jxq5Q+cp8zAHsYJkLTL2SRtGKaz8zkKjZU3huIP6nfkoHz0g3/dnxH5BbfeS82YvAbr
         p61V3+huoBQPfngpqo3YYtsMHvmDBMJ5CkAAkl6xUTk+PBZIBqVsyvAAy5Q/1QPwfNhP
         LnVA==
X-Gm-Message-State: APt69E3kPkxa9cfrxAwCo/ifTC3py1wU4Jefb6QrOavicvVLqwkBXRFB
        XdYxDiTCkZ1N+Ac6K3HAWdQs3mtAV+/azdBXukacIA==
X-Google-Smtp-Source: AAOMgpdnp7WRuAkKQvtwUtdj1UYkpKfZOstzuGZbq8xD0bnUzlElOtDhOQzz+litEgxQHvKNvatr626M3GrHQTou9Uc=
X-Received: by 2002:aca:b954:: with SMTP id j81-v6mr24731113oif.356.1531138416141;
 Mon, 09 Jul 2018 05:13:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:192d:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 05:13:35 -0700 (PDT)
In-Reply-To: <20180709111753eucas1p1f32e66fb2f7ea3216097cd72a132355d~-rzycA5Rg0378203782eucas1p1C@eucas1p1.samsung.com>
References: <CGME20180709111753eucas1p1f32e66fb2f7ea3216097cd72a132355d@eucas1p1.samsung.com>
 <E1fb8Ti-00026e-NU@debutante> <20180709111753eucas1p1f32e66fb2f7ea3216097cd72a132355d~-rzycA5Rg0378203782eucas1p1C@eucas1p1.samsung.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Mon, 9 Jul 2018 14:13:35 +0200
Message-ID: <CA+M3ks5ieu_6=rsfdp9QQuLJbbwJj2if26m_STF0QJJBD-6XKQ@mail.gmail.com>
Subject: Re: Applied "regulator: core: Link consumer with regulator driver" to
 the regulator tree
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Mark Brown <broonie@kernel.org>, pascal paillet <p.paillet@st.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        rafael.j.wysocki@intel.co
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Rafael

2018-07-09 13:17 GMT+02:00 Marek Szyprowski <m.szyprowski@samsung.com>:
> Dear All,
>
> On 2018-07-05 19:55, Mark Brown wrote:
>> The patch
>>
>>     regulator: core: Link consumer with regulator driver
>>
>> has been applied to the regulator tree at
>>
>>     https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.gi=
t
>>
>> All being well this means that it will be integrated into the linux-next
>> tree (usually sometime in the next 24 hours) and sent to Linus during
>> the next merge window (or sooner if it is a bug fix), however if
>> problems are discovered then the patch may be dropped or reverted.
>>
>> You may get further e-mails resulting from automated or manual testing
>> and review of the tree, please engage with people reporting problems and
>> send followup patches addressing any issues that are reported if needed.
>>
>> If any updates are required or you are submitting further changes they
>> should be sent as incremental updates against current git, existing
>> patches will not be replaced.
>>
>> Please add any relevant lists and maintainers to the CCs when replying
>> to this mail.
>>
>> Thanks,
>> Mark
>>
>> >From ed1ae2dd9f242c7a36e8e39100f6a7f6bcdfdd89 Mon Sep 17 00:00:00 2001
>> From: pascal paillet <p.paillet@st.com>
>> Date: Thu, 5 Jul 2018 14:25:56 +0000
>> Subject: [PATCH] regulator: core: Link consumer with regulator driver
>>
>> Add a device link between the consumer and the driver so that
>> the consumer is not suspended before the driver. The goal is to avoid
>> implementing suspend_late ops in regulator drivers.
>>
>> Signed-off-by: pascal paillet <p.paillet@st.com>
>> Signed-off-by: Mark Brown <broonie@kernel.org>
>
> This patch triggers the following warning on several Exynos SoC based
> boards:
>
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 1 at drivers/base/core.c:108
> device_is_dependent+0xa4/0xb4
> Modules linked in:
> CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.18.0-rc3-next-20180706 #112
> Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> [<c0113200>] (unwind_backtrace) from [<c010edd0>] (show_stack+0x10/0x14)
> [<c010edd0>] (show_stack) from [<c0a4b6e8>] (dump_stack+0x98/0xc4)
> [<c0a4b6e8>] (dump_stack) from [<c0127b90>] (__warn+0x10c/0x124)
> [<c0127b90>] (__warn) from [<c0127cbc>] (warn_slowpath_null+0x40/0x48)
> [<c0127cbc>] (warn_slowpath_null) from [<c0580464>]
> (device_is_dependent+0xa4/0xb4)
> [<c0580464>] (device_is_dependent) from [<c058037c>]
> (device_for_each_child+0x50/0x94)
> [<c058037c>] (device_for_each_child) from [<c05803e0>]
> (device_is_dependent+0x20/0xb4)
> [<c05803e0>] (device_is_dependent) from [<c0581bcc>]
> (device_link_add+0x70/0x2a8)
> [<c0581bcc>] (device_link_add) from [<c04e4134>] (_regulator_get+0xbc/0x2=
70)
> [<c04e4134>] (_regulator_get) from [<c04e4350>]
> (regulator_bulk_get+0x60/0xcc)
> [<c04e4350>] (regulator_bulk_get) from [<c05b4e40>]
> (wm8994_i2c_probe+0x334/0x8ec)
> [<c05b4e40>] (wm8994_i2c_probe) from [<c06d8d98>]
> (i2c_device_probe+0x240/0x2b8)
> [<c06d8d98>] (i2c_device_probe) from [<c05857d8>]
> (driver_probe_device+0x2dc/0x4ac)
> [<c05857d8>] (driver_probe_device) from [<c0585ad0>]
> (__driver_attach+0x128/0x144)
> [<c0585ad0>] (__driver_attach) from [<c0583668>]
> (bus_for_each_dev+0x68/0xb4)
> [<c0583668>] (bus_for_each_dev) from [<c0584968>]
> (bus_add_driver+0x1a8/0x268)
> [<c0584968>] (bus_add_driver) from [<c0586c48>] (driver_register+0x78/0x1=
0c)
> [<c0586c48>] (driver_register) from [<c06d9ca4>]
> (i2c_register_driver+0x3c/0xa8)
> [<c06d9ca4>] (i2c_register_driver) from [<c0103188>]
> (do_one_initcall+0x8c/0x4b0)
> [<c0103188>] (do_one_initcall) from [<c0f01268>]
> (kernel_init_freeable+0x3e4/0x570)
> [<c0f01268>] (kernel_init_freeable) from [<c0a6503c>]
> (kernel_init+0x8/0x10c)
> [<c0a6503c>] (kernel_init) from [<c01010b4>] (ret_from_fork+0x14/0x20)
> Exception stack(0xee8c9fb0 to 0xee8c9ff8)
> ...
> ---[ end trace 4ed89cca1d70ea82 ]---
>
> The above stack comes from Exynos5250 Arndale board
> (arch/arm/boot/dts/exynos5250-arndale.dts), where wm8994 codec tries to g=
et
> regulator, which is provided by its parent mfd device. Similar issue can =
be
> observed on Exynos4412-based Trats2 and Exynos5433 TM2(e) boards.
>
> It looks that some more checks have to be done before adding a link betwe=
en
> regulator consumer and regulator driver, because it is not that uncommon
> that
> regulator consumer shares the parent device with regulator provider.
>

Each time device_is_dependent() will return 1 we have a warn_on.
It is strange since returning 1 is well documented on function description.
I don't know if we can safely remove the warn_on or if their is a good
reason to keep it.
Rafael what do you think about that ?

>> ---
>>   drivers/regulator/core.c | 18 ++++++++++++++++--
>>   1 file changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
>> index da9b0fed8330..bb1324f93143 100644
>> --- a/drivers/regulator/core.c
>> +++ b/drivers/regulator/core.c
>> @@ -1740,6 +1740,8 @@ struct regulator *_regulator_get(struct device *de=
v, const char *id,
>>                       rdev->use_count =3D 0;
>>       }
>>
>> +     device_link_add(dev, &rdev->dev, DL_FLAG_STATELESS);
>> +
>>       return regulator;
>>   }
>>
>> @@ -1829,9 +1831,21 @@ static void _regulator_put(struct regulator *regu=
lator)
>>
>>       debugfs_remove_recursive(regulator->debugfs);
>>
>> -     /* remove any sysfs entries */
>> -     if (regulator->dev)
>> +     if (regulator->dev) {
>> +             int count =3D 0;
>> +             struct regulator *r;
>> +
>> +             list_for_each_entry(r, &rdev->consumer_list, list)
>> +                     if (r->dev =3D=3D regulator->dev)
>> +                             count++;
>> +
>> +             if (count =3D=3D 1)
>> +                     device_link_remove(regulator->dev, &rdev->dev);
>> +
>> +             /* remove any sysfs entries */
>>               sysfs_remove_link(&rdev->dev.kobj, regulator->supply_name)=
;
>> +     }
>> +
>>       regulator_lock(rdev);
>>       list_del(&regulator->list);
>>
>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>



--=20
Benjamin Gaignard

Graphic Study Group

Linaro.org =E2=94=82 Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
