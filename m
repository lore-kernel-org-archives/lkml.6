Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05E1C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757702089C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfaeQBI2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 757702089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733110AbeGZR5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 13:57:34 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:45817 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731856AbeGZR5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 13:57:34 -0400
Received: by mail-qk0-f193.google.com with SMTP id c192-v6so1406009qkg.12;
        Thu, 26 Jul 2018 09:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LExaAXame6VhGEtR2Z5YySSR6kkFeF/Os8H2+YQpJ6g=;
        b=WfaeQBI21cmg3XWkS9SyCnRR7LoZnnvcz5pbAR7+iTYjW1UiROn0WjA5PhlIo/2JWI
         62Sio9kLc7Ya2UuH3MHJSMJP25Bi9UWyg8BuFziKvSIoV8tTA7TIht/jpO/J3TOSTdI6
         dVnos8yrL9G0oRGg5VowFL9shI1CBkt+g1j6rVeSjF1atrmzrM5eMN/4yQ7KieYcLnq0
         PXh5FXnfDzoP7VL9jBusW3NW4mMbpj244j7qxyhYI9M73ITBR7r6L6pvyYJN1pl2vVFt
         itE9xQ3qvl5yrrR4LzN8vxSVRHBp6tNqHROOezbnJEh95yBQNZVDrALL07ol5jS1bGMc
         bNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LExaAXame6VhGEtR2Z5YySSR6kkFeF/Os8H2+YQpJ6g=;
        b=EEP/ACJ4AlJvrnn6UOROkT/mJrcGCRw9w9zBMiVocck7KwLm8mc0ePtdmW2Hv9//Xs
         omnDvpERn2bvDBuPqubp4ReMsj+bnwtcvLomUWK0Crh6i2AsMZE/flIdc/JxeLYewhng
         3odnaHvTiNEp1jYWJFzDq92h1r3bc7MIBkeW+2Cr8qryvRLQ9gk77lffh/G9I0iimxvS
         /K9XbpC76DL7sihh+d4VpQTQN8Gvlld/TH47EgFppojANHPqwKusJsSAtUWfUMG/jiYI
         IwoZFvCqIBitjNFUp4l3dlxYCXf50ZFwdTDcr0hvWo088cOd5OLcqhXR1TFr3U6RKG90
         kkbQ==
X-Gm-Message-State: AOUpUlFNctS9PczH/UUr7BomTNTdK2YfEikthConmPMWptpTtouZMuSh
        rK5vFaSyav0G1S1JHlbE1pSvcQnNRkE=
X-Google-Smtp-Source: AAOMgpd6CU6uK4bKrWlnRb3fybmd3f39YSrCIwOIBVj6yyAsMPLT2Fl1uVcwj3FXkY8ersGrHvswVA==
X-Received: by 2002:a37:bbc1:: with SMTP id l184-v6mr2403933qkf.111.1532623195915;
        Thu, 26 Jul 2018 09:39:55 -0700 (PDT)
Received: from [192.168.44.96] (42.sub-174-226-17.myvzw.com. [174.226.17.42])
        by smtp.gmail.com with ESMTPSA id h51-v6sm1520436qte.17.2018.07.26.09.39.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 09:39:55 -0700 (PDT)
Subject: Re: [PATCH 3/3] mmc: tegra: prevent ACMD23 on Tegra 3
To:     Stefan Agner <stefan@agner.ch>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        marcel.ziswiler@toradex.com, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra-owner@vger.kernel.org
References: <20180712073904.4705-1-stefan@agner.ch>
 <20180712073904.4705-3-stefan@agner.ch>
 <430c718d-9ede-d47a-44c0-b8e47e297720@gmail.com>
 <1553c44e99b96a813af129d1c4169222@agner.ch>
 <553f9ed6-8f7c-775b-d731-fd9732f74b07@gmail.com>
 <7edc8c666dbbc0743221c86286ff583a@agner.ch>
From:   Peter Geis <pgwipeout@gmail.com>
Message-ID: <12ae1da9-cd09-b15d-9a81-461ca9cc06d7@gmail.com>
Date:   Thu, 26 Jul 2018 12:39:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <7edc8c666dbbc0743221c86286ff583a@agner.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> I finally got around to testing this on the Ouya (Tegra 3).
>>>
>>> Thanks for testing!
>>>
>>>>
>>>> I found that the "Got command interrupt 0x00010000 even though no
>>>> command operation was in progress." error occurred when the interface
>>>> is unstable.
>>>> I've had a lot of problems with sdmmc4 stability on the Ouya above 34
>>>> Mhz, probably due to the fact that they are using the internal cmd and
>>>> clock pull-up resistors, against the TRM's instruction.
>>>> At 39Mhz, I saw the error this patch corrects.
>>>> With the patch, the error went away, but the interface is still
>>>> unstable under load.
>>>
>>> How does this instability manifest exactly?
>>>
>>
>> At the very edge of stability, you see write errors under heavy load.
>> As clock rate increases, the write errors occur more frequently.
>> At a certain point, you start getting read errors.
>> Following that you get constant io errors during card probing.
>> Eventually the emmc will fail to initialize, with errors 87 or 110.
> 
> What mode are you running at actually? E.g. what is the ios file saying?
> cat /sys/kernel/debug/mmcX/ios

This is the best functionality I've been able to get prior to the patches:
root@ouya:~# cat /sys/kernel/debug/mmc0/ios
clock:          30000000 Hz
actual clock:   29142858 Hz
vdd:            21 (3.3 ~ 3.4 V)
bus mode:       2 (push-pull)
chip select:    0 (don't care)
power mode:     2 (on)
bus width:      3 (8 bits)
timing spec:    9 (mmc HS200)
signal voltage: 1 (1.80 V)
driver type:    0 (driver type B)

Now I am trying DDR, but even with the patches I'm not able to remain 
stable above 17Mhz (34Mhz clock).

I've also tried just straight mmc-hs mode, but even that makes no 
difference.

> 
>>
>> I've been tweaking the pull up/down values to try and improve the
>> stability, but without access to anything but the TRM it's a lot of
>> trial and error.
>>
> 
> Hm, maybe Marcel's recent fixes in our device tree are helpful?
> https://lkml.org/lkml/2018/7/22/165
> 
> Also make sure to have a complete pinmux such that alternative pins for
> sdmmc4 are *not* muxed as sdmmc4.

That was my first issue, which was preventing sdmmc4 from working at all.
Just double checked all of the spare function pins, they are all 
assigned elsewhere.

> 
>>>>
>>>> Lowering down to 32Mhz, without the patch there are no errors.
>>>
>>> So the patch does not make it less stable right?
>>>
>>
>> No, it did not affect stability.
>> Although I'd conduct some performance testing to check for degradation.
>> Of course I'm nowhere near the limits of the controller, so it is
>> doubtful I'd see a hit.
> 
> Ok, and this is with the complete patchset applied correct?
> 
> Btw, what device tree are you using? Ouya is not upstream as far as I
> can tell?

Indeed, I have the full patchset.

Ouya is an old android game console that I've been working on getting 
mainline working on.
I've written most of the device tree, with contributions from Matt Merhar.
It's almost bit for bit a cardhu dev board, but with everything not 
necessary to function removed.
They cut a lot of corners with the board design.
Last stable kernel was 3.2, but it ran fine at 52mhz, mind you it 
reported it was running mode 5.

To get this speed, I have the pins all driven down at 4, and up at 24.
Default is 2 down and 18 up from driver init.
The pin pull ups are exactly as the original kernel, all pins pulled up 
except reset, which is pulled down.

> 
> --
> Stefan
> 
>>
>>> --
>>> Stefan
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
