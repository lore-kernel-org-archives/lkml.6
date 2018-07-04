Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0C7C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7BA52098B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHpKE5EZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7BA52098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934493AbeGDJQR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:16:17 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:36609 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932479AbeGDJQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:16:13 -0400
Received: by mail-vk0-f67.google.com with SMTP id y9-v6so2718082vky.3;
        Wed, 04 Jul 2018 02:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XRZLEx+pVO3Pg28ut2GyDmKa4DRYCv1pXbSDDMaSYME=;
        b=EHpKE5EZcdlsmwe822NToBuhKXQVEZqOIIIretlmpA4hkRIA3VIMoe9SUKY6RubP+r
         bniw6U5ly26PvqMSfHPNpQI3REWqBYlKg2WdUbnDxOf13q437oqIR8eoYQunZRvhCQD0
         VSG6+I3dkWPxa0U8r4Ur7qRgn6D+QYtYuVfTq6byqfsy5wO628MxYKq8LFMMMlEzCCbm
         81C0fDBCutOfEyTn6wmzdhOGnHqEaK9sk987zvcTZp9DI/JgOrxw0jaUKEVt7xxaUdgu
         lkDvTrv7uePsqDQxCMX2IKCbg6JQNkjfQbyAaNboUYjbmOPvs+qfi1WKM6pgXWqDtQtA
         vZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XRZLEx+pVO3Pg28ut2GyDmKa4DRYCv1pXbSDDMaSYME=;
        b=d3RAKRciERDp4WYh6Ur3vJsfwdu6UeGhsRG/PtU/hyDRomS2xHSafzKl7370DWrCo7
         rA74H5ldWx528EEM/a6U+YRE5I92kipsGfSCyAJ3q5/QnvrBKJmYX+abm84TAQRYXcQy
         YwqHNhvt5CoIl/2B5Vv2sX2kjR5FgyOh5huXjRfkZ6YN+aFwx0Kb+pS1Rn2ulNTzk04q
         X8q+JAlY3A46+dnXJj1Tq+osgC0m3ePmEh+CCToS6k8GvJDkVGLuYMQWQAX90gNsYoHR
         xlEULlqVWe0kxcxq6VV/CIg+wyUgW9q7etAXF+MIBQAmgI76cGWCLKZoGIMSB8DLSQuV
         KJng==
X-Gm-Message-State: APt69E1yUz4hb4/UyZm2bFsI8DBAIrlEhHCoq6brQBzw4CvfQsHpTv4e
        sEHwAWQVJTYf7DVdFMRqwb3m4r89ZiEV4HmQVBE=
X-Google-Smtp-Source: AAOMgpcgNEuEi+guF3D8qk4ruLrwyNdGRgISr21irtDCFkbZzILnDAro0AJNGSwnHcu3Yb+iGoC3VZL8zCWX7vwEe0I=
X-Received: by 2002:a1f:6dc4:: with SMTP id i187-v6mr600599vkc.131.1530695773073;
 Wed, 04 Jul 2018 02:16:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 02:16:12 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1807041100360.7891@fox.voss.local>
References: <cover.1530599660.git.nikolaus.voss@loewensteinmedical.de>
 <82c6f53cfa03f9bc7c0adfc423ae65fc986a1d25.1530599660.git.nikolaus.voss@loewensteinmedical.de>
 <CAHp75Vd5f7Xj51ZKoxOWibrx4Bkh-HxkMwjKmEeumZm=WV2ksQ@mail.gmail.com>
 <alpine.DEB.2.20.1807040728490.6169@fox.voss.local> <CAHp75VdkeVEuJtcGB4unoSJqRh2r+_7aGJ+BPKO2ABriVQigvQ@mail.gmail.com>
 <alpine.DEB.2.20.1807041100360.7891@fox.voss.local>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 Jul 2018 12:16:12 +0300
Message-ID: <CAHp75VdxtfkrV0bT=4yeYcSUFncTvjBfVC1haOUPpdOaOohmLg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] IIO: st_accel_i2c.c: Use probe_new() instead of probe()
To:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nv@vosn.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 12:09 PM, Nikolaus Voss
<nikolaus.voss@loewensteinmedical.de> wrote:
> On Wed, 4 Jul 2018, Andy Shevchenko wrote:
>>
>> On Wed, Jul 4, 2018 at 9:37 AM, Nikolaus Voss
>> <nikolaus.voss@loewensteinmedical.de> wrote:
>>>
>>> On Wed, 4 Jul 2018, Andy Shevchenko wrote:
>>>>
>>>>
>>>> On Tue, Jul 3, 2018 at 9:06 AM, Nikolaus Voss
>>>> <nikolaus.voss@loewensteinmedical.de> wrote:
>>>>>
>>>>>
>>>>> struct i2c_device_id argument of probe() is not used, so use
>>>>> probe_new()
>>>>> instead.
>>>>>
>>>>
>>>> This makes...
>>>>
>>>>>  MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
>>>>
>>>>
>>>>
>>>> ...this table obsolete IIUC. At least that's what I did when switched
>>>> to ->probe_new() in some drivers.
>>>>
>>>> If I'm mistaken (again? :-) ) I would hear from someone to point me
>>>> how it can be used after a switch.
>>>
>>>
>>>
>>> It is still used by the i2c-core in i2c_device_match() if DT and ACPI
>>> matching fails.
>>
>>
>>> And it is used to create the corresponding modaliases for
>>> driver loading.
>>
>>
>> My question is "How?!"
>> I don't really see any points to match against it after switching to
>> ->probe_new().
>>
>> Could you point me to the code path in i2c (or OF?) core for that?
>
>
> As written above in i2c-core-base.c: i2c_device_match() ->
> i2c_match_id(driver->id_table,...
>
> This is used for driver matching before probe() or probe_new() of the device
> driver can be called. probe_new() actually is a function signature change
> only.

Okay, IIUC we got a match. What should we do with it? The table is not
used in ->probe_new() (in i2c core), so, you can't say which line
matched there.

-- 
With Best Regards,
Andy Shevchenko
