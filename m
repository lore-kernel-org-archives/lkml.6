Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891CAC32789
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 01:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3901B2081B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 01:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pepR9Vwr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3901B2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbeKEKgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 05:36:41 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39201 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbeKEKgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 05:36:40 -0500
Received: by mail-pl1-f195.google.com with SMTP id b5-v6so3587933pla.6;
        Sun, 04 Nov 2018 17:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=5KghXi7XvX/PGjpxfXiYt2wIzYJp9RxABcdJi1NgBKc=;
        b=pepR9VwrOzT+Q2q4DEcI4LomdG+YXM/tnBJLzGkKM8jG+h6AQN3hPUWxj5BzYlkLVi
         2FlBjg686Tr5h2sTO1zH0agOMAZ3/jEtkMfOqxQJsAfHyS9IGuLeGkZneYd45nLOda/5
         f2tvAvqzNFXzyDxpdoH7tV/su9bPNwgIs1wSRa0efT26BLO27XcvOTqowGRsPifTtv6x
         IimWr3hKJRvkLCcdTo3VtVccGLnHU77+ev/G5ZxJWS6oLmpyBLdtYXGrZiNEU0hORqmg
         if99kJlPqe+jz+UdSR0WHPHd2hNV9AfwKlV6e7cqf6jJGsoqK/LW5XVGsFHw+zPn3lP6
         Qlog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5KghXi7XvX/PGjpxfXiYt2wIzYJp9RxABcdJi1NgBKc=;
        b=MHEucYZ19ikZiHUUvYNCrkQy1Xr5hh+w1voxIroKdoKjT9R5pAD1m5rNGrTbGWNTHk
         yLMCN8zt9kdOiP813K0/C44cdjn/+8Io4cB6w6LbKhQ+1zTTaj/i2Z+vuuHw5ScJ2Uh+
         DbPEyv2aNejHedR87OT196AdF1Ptn3+9peyqtEF0ls1pTGwGORfETVpjRgVrNpoQMEHp
         TrDmwlICGehzoN9QfbxcXDwSKZn5HwsS3aub1aOWzo4r4yN+z/N7Egpx1WVvNQeKh1n9
         /7ghs7e6mipuZ1uacEPkK669S0OYrFLxtEzT17nw1oeytwQ4hxogh/3x+lGtsBiJIzHj
         45UQ==
X-Gm-Message-State: AGRZ1gILaE4+pX+mJyK6l3uutHtYisvlHW+zJa6kJVMjiEEJozWH8RAa
        aFCsEKUe/UXHFSCJsMJOpmCJoaBC
X-Google-Smtp-Source: AJdET5feVlo/Ck2ItBM5vpr1B0vz03/8ntVE7mQBVd6537ES7BdmRrvXnw6mVMLmIbaRyCGxp4GhqQ==
X-Received: by 2002:a17:902:9a04:: with SMTP id v4-v6mr19746027plp.247.1541380775878;
        Sun, 04 Nov 2018 17:19:35 -0800 (PST)
Received: from [0.0.0.0] (97.64.17.87.16clouds.com. [97.64.17.87])
        by smtp.gmail.com with ESMTPSA id n65-v6sm14275537pfi.185.2018.11.04.17.19.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Nov 2018 17:19:34 -0800 (PST)
Subject: Re: [PATCH v5 3/3] iio: magnetometer: Add driver support for PNI
 RM3100
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com, preid@electromag.com.au,
        himanshujha199640@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20181102074209.12620-1-songqiang1304521@gmail.com>
 <20181102074209.12620-4-songqiang1304521@gmail.com>
 <20181103171900.601537e3@archlinux>
From:   Song Qiang <songqiang1304521@gmail.com>
Message-ID: <716779d7-4fcc-9914-cf73-0b852902c9bd@gmail.com>
Date:   Mon, 5 Nov 2018 09:19:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181103171900.601537e3@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/11/4 上午1:19, Jonathan Cameron wrote:
> On Fri,  2 Nov 2018 15:42:09 +0800
> Song Qiang <songqiang1304521@gmail.com> wrote:
>
>
...
>> +int rm3100_common_probe(struct device *dev, struct regmap *regmap, int irq)
>> +{
>> +	struct iio_dev *indio_dev;
>> +	struct rm3100_data *data;
>> +	unsigned int tmp;
>> +	int ret;
>> +
>> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	data = iio_priv(indio_dev);
>> +	data->regmap = regmap;
>> +
>> +	mutex_init(&data->lock);
>> +
>> +	indio_dev->dev.parent = dev;
>> +	indio_dev->name = "rm3100";
>> +	indio_dev->info = &rm3100_info;
>> +	indio_dev->channels = rm3100_channels;
>> +	indio_dev->num_channels = ARRAY_SIZE(rm3100_channels);
>> +	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED;
>> +	indio_dev->currentmode = INDIO_DIRECT_MODE;
> Huh. That's an interesting one... Looks like a bug in the core to me that
> somehow has never bitten us as no driver has ever done anything other
> than explicitly match against other modes.  No one sets currentmode
> directly so we should be good just putting this in the core as long
> as a device supports direct mode.  I'll look at that when I get a moment.
>
Hi Jonathan,

Last patch series I submit had 'case 0' for threaded function of interrupt 
handler. That's just because of this. I greped INDIO_DIRECT_MODE in iio folder, 
and found out that the iio core only set the driver mode to INDIO_DIRECT_MODE 
when it leaves buffer mode. Originally I thought when I call 
'iio_claim_direct_mode()' the currentmode should be set to INDIO_DIRECT_MODE.

This problem would lead to a potential bug if someone installed the device and 
use single-shot mode before any buffered read(I met this).

Though it seems like not many drivers use the same architecture I'm using, they 
don't need to check current mode, I'll look into more drivers.

st_sensors_core.c:589 seems like to choose to treat this as it's a 
bi-conditional situation with 'if it's in INDIO_BUFFER_TRIGGERED mode, if it's 
not, no matter what value it is, it's in INDIO_DIRECT_MODE.'


yours,

Song Qiang

...
