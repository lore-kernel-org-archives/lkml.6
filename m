Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CA7C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D642F21A0B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzrZvrWv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D642F21A0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbeHFNuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 09:50:15 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53234 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbeHFNuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 09:50:15 -0400
Received: by mail-wm0-f65.google.com with SMTP id o11-v6so13418263wmh.2;
        Mon, 06 Aug 2018 04:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=odNFYi0NM9qsX/68kIHEhg8FIW1uqOjvQCghCSvHhIs=;
        b=fzrZvrWvad6GXaRo7PMTTLS0gRcpVXbTt+sZ6ucQQMplkDYF4haAZ09o5+AnjQeVbi
         KSnA9Mntc5ox+cDCW3qEMvYDJadoOwVjNix5Qvj8wqNINwikILF4XiT7ly0+0Yvrn0RN
         DtoGk/lKrx1vEgRBvNSTyMXJlYpgcvlf4Qp4d29yhzMePkpVGrZgdHsGLvED4vS1fDyq
         lsKNsl6iUMXp7aa0A1KhcKEKgsoiLSYjAPDxgpbMsRUDKOlDmGAtGgiGgTgQKO9Uhbvl
         ELQAVF3lpli3iPZ3BFIGzSZLj3yElMwz2rfza0LMzMPsilEDkaAdOK0ETuf1sHbgMJxA
         zmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=odNFYi0NM9qsX/68kIHEhg8FIW1uqOjvQCghCSvHhIs=;
        b=RGZwIgCl77I6hllQqxzmzCWjOTE4RzjsGZJZ/Bec/IjV67LPkonFWFSIEI6iFNv8Q/
         kvcscsju6SfCVh0Uhr5YmvTh7jWjfJQ2p86EncVgjuy4mUZkb145VFD0SUA5DYfERIep
         iSD9JDHJehiUb11EUyQlcuImzEMhHjHkbfwq/fuCM+HWRPIyfLFitBYMZPB/3XHfF6QC
         77XnNShHaC6EFHwlQG8J8D0fqA+4mUdUZiFoUjIBi6VPV6lv1Jt7faOod0oJ3H4GD804
         Lc2QfO/t4kxvWjWoFQjpx1ADFpnQy9UwkKS4o+v2BNwl/DVGicQGzxs6ZFwB2FX8Q13N
         re2A==
X-Gm-Message-State: AOUpUlEx6BnNTFIJ/heDap9lA8Ku45RptOypxx4opfNOmX+yIHc3taw/
        KOE9Zze/l1AWwofm6BspL6T8K5mp
X-Google-Smtp-Source: AAOMgpeP+MRDhnJBxY7lK+9MI4JeNPd56pKt9SwxGNn2Y3dBKb2nkQ6XC81Km4b47Zv//xC8kWThWg==
X-Received: by 2002:a1c:1d2:: with SMTP id 201-v6mr10934610wmb.4.1533555692868;
        Mon, 06 Aug 2018 04:41:32 -0700 (PDT)
Received: from [192.168.1.18] (dnm114.neoplus.adsl.tpnet.pl. [83.24.94.114])
        by smtp.gmail.com with ESMTPSA id j8-v6sm17671413wrp.11.2018.08.06.04.41.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 04:41:31 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] leds: core: Introduce LED pattern trigger
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>, rteysseyre@gmail.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <c43374283744539702023053c896efe3c73b7833.1533441631.git.baolin.wang@linaro.org>
 <3d7e8701-d92b-9f51-befa-a585b5957488@gmail.com>
 <CAMz4kuLSBLReVSo4zXf8b64kwCmRt2PS=JkeD2wJO41X-WmBQQ@mail.gmail.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <b7407dc4-73b3-f819-2c44-03ed65999e32@gmail.com>
Date:   Mon, 6 Aug 2018 13:41:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAMz4kuLSBLReVSo4zXf8b64kwCmRt2PS=JkeD2wJO41X-WmBQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolin,

On 08/06/2018 03:53 AM, Baolin Wang wrote:
> Hi Jacek,
[...]
>>> +++ b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
>>> @@ -0,0 +1,21 @@
>>> +What:                /sys/class/leds/<led>/pattern
>>> +Date:                August 2018
>>> +KernelVersion:       4.19
>>> +Description:
>>> +             Specify a pattern for the LED, for LED hardware that support
>>> +             altering the brightness as a function of time.
>>> +
>>> +             The pattern is given by a series of tuples, of brightness and
>>> +             duration (ms). The LED is expected to traverse the series and
>>> +             each brightness value for the specified duration. Duration of
>>> +             0 means brightness should immediately change to new value.
>>> +
>>> +             The format of the pattern values should be:
>>> +             "brightness_1 duration_1 brightness_2 duration_2 brightness_3
>>> +             duration_3 ...".
>>> +
>>> +What:                /sys/class/leds/<led>/repeat
>>> +Date:                August 2018
>>> +KernelVersion:       4.19
>>> +Description:
>>> +             Specify a pattern repeat number. 0 means repeat indefinitely.
>>
>> In current implementation this file on read returns the number
>> of remaining repeat intervals. I'd add that to this description.
> 
> I saw Pavel's comments that he did not suggest do this. So I will keep
> the original description?

Yes, please report always the original value.

[...]
>>> +static ssize_t pattern_trig_store_repeat(struct device *dev,
>>> +                                      struct device_attribute *attr,
>>> +                                      const char *buf, size_t count)
>>> +{
>>> +     struct led_classdev *led_cdev = dev_get_drvdata(dev);
>>> +     struct pattern_trig_data *data = led_cdev->trigger_data;
>>> +     unsigned long res;
>>> +     int err;
>>> +
>>> +     err = kstrtoul(buf, 10, &res);
>>> +     if (err)
>>> +             return err;
>>> +
>>> +     if (!led_cdev->pattern_set)
>>> +             del_timer_sync(&data->timer);
>>
>> Is there a reason for not having this check under mutex?
> 
> We will hold the mutex in pattern_trig_timer_function(), so if we do
> del_timer_sync() under the mutex protection, we may meet dead-lock
> issue. Moreover, the del_timer_sync() will make sure deactivating one
> timer is safe.

Ack.

-- 
Best regards,
Jacek Anaszewski
