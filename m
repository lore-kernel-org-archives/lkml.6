Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9737AECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F01720661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pf2CbeED"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F01720661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389037AbeGTNlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:41:52 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:43320 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731833AbeGTNlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:41:51 -0400
Received: by mail-vk0-f67.google.com with SMTP id s17-v6so6008405vke.10;
        Fri, 20 Jul 2018 05:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=W9t2cC5tAd5Yfx+Hnvbc+Z3Drj5QRCvMXmBY/TglKIk=;
        b=pf2CbeEDvcfyvMvygzktoCWjQ1G8mA3Im/EZIkLiItF7Wm1Z0SEFnVIqsq+t5ziEah
         1i2aTqkczfPQWnC+fADzxmCAdTfLyNTe+4uzyaE7RO8oAVvO0eAZ5Ol4LrKnOpXh3csF
         9Cbzxgr7H5aJpRItrN65RNfM9//DJl8hRwZU8nXIzJweMH92cnuByrqdlryxzApoojPv
         1vQYZLKQXpiu6CkA8lC+1pxC6XFEQiNnCTAbLhgDtS5S8CXmGurLdHvO9UnATTpxbTyJ
         dL4OcI8/UDOGG2/mxVtRYb5IVqnHTBG2FWwri8TSCwOlI7wINW4xMO5FoTLTpkgvUUqd
         tkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=W9t2cC5tAd5Yfx+Hnvbc+Z3Drj5QRCvMXmBY/TglKIk=;
        b=qo1oZQ3ndQirJZuXUmaSgMy/MnLdgBM6Bq1LwQXoDsaikurSSpv3HuVrSdlwdHuTTs
         alLqVhx7naHaPMFkm3atqy6DsXNEYriTDMOGv37+WbHlZ3ekVPymy1Q9o28PceXGf7Hj
         9Bj65t+panmpv9Uh826NHknu7Y7U6ASONyV1nTqvcjE3Hy/S/H31TNAkSxEJcs9rVLUR
         5aI7i0fjOFiStgrpkuGC7J4Mg20LcZTh/UkWbSFWqAAJrhYxdliIK29iVdAg/vL/zEz3
         Lfs+yHunr5C7wK3f8NDzyUtLMqBtmYbQ3Dgk0nYrYtKLncoB6i/cLNcN91NEMOjKSLhr
         xKuQ==
X-Gm-Message-State: AOUpUlFmOIxQ4glfOMgUIR4L7bl4LBsarTI68ZPoZgJAs8RNAeAmKWsf
        kp1elVuLgtw2yUzX+KehcwHVvV+zSoStHQgZMvdP0MPx
X-Google-Smtp-Source: AAOMgpdoEvGQU2BOjg6Qd7cx9xE+0sZZJNkz0Io6m1vqjOazThpY3n2rZG7CdJ9wOzcgm0iDVb+Cjr/cmI2FkWIepT0=
X-Received: by 2002:a1f:844e:: with SMTP id g75-v6mr1148796vkd.16.1532091222899;
 Fri, 20 Jul 2018 05:53:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Fri, 20 Jul 2018 05:53:42
 -0700 (PDT)
In-Reply-To: <d03aec28-a33a-5a07-4305-246508185b2b@micronovasrl.com>
References: <20180718094006.105675-1-giulio.benetti@micronovasrl.com>
 <20180718094006.105675-3-giulio.benetti@micronovasrl.com> <CAHp75VcaALb8fYJExnZ=Ye=GcNHc3aPXgFihVK+rAu_a1A01Sg@mail.gmail.com>
 <30d6b568-b785-ae93-9f56-d0a8b7e82901@micronovasrl.com> <CAHp75VchXfm6J+PPcB8ekoXcDktsPUNok3KKBMFyyk9XV=AUyQ@mail.gmail.com>
 <d03aec28-a33a-5a07-4305-246508185b2b@micronovasrl.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 20 Jul 2018 15:53:42 +0300
Message-ID: <CAHp75VdSHdtJA5E=KvkUyij8CcgpyVO1b63-XBR7MnhVeWDpWA@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] rtc: ds1307: add frequency_test_enable sysfs
 attribute to check tick on m41txx
To:     Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 9:19 PM, Giulio Benetti
<giulio.benetti@micronovasrl.com> wrote:
> Hi Andy,
>
> Il 18/07/2018 18:26, Andy Shevchenko ha scritto:
>>
>> On Wed, Jul 18, 2018 at 5:06 PM, Giulio Benetti
>> <giulio.benetti@micronovasrl.com> wrote:
>>
>>>>> +       int ret;
>>>>> +
>>>>> +       ret = kstrtobool(buf, &freq_test_en);
>>>>> +       if (ret == -EINVAL) {
>>
>>
>>>> What kind of other error code you may expect and why they are not
>>>> considered as no error?
>>
>>
>>> According to documentation, kstrtobool can only fail with -EINVAL.
>>> See:
>>> https://elixir.bootlin.com/linux/v4.18-rc5/source/lib/kstrtox.c#L332
>>
>>
>> That's correct. So, what do you want to show by explicitly mentioned
>> an error code in the condition?
>>
>
> So you mean I should check for negative values instead of specific error,
> right?

Learn from the existing code.

As you found kstrtobool() returns either 0 (no error), or -EINVAL (the
only possible error code for now).
Checking ret for non-zero is enough.
Thus,

if (ret) {
 ...
 return ret;
}

should do a job.

-- 
With Best Regards,
Andy Shevchenko
