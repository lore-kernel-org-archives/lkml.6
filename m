Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB17C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 20:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 262C4205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 20:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnoHmrS7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 262C4205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbeHaAEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 20:04:31 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39312 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbeHaAEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 20:04:30 -0400
Received: by mail-wm0-f67.google.com with SMTP id q8-v6so3216378wmq.4;
        Thu, 30 Aug 2018 13:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=j2ACXejv66YglOf8tR8lqUUYybuE/S70Ob9McmdUki4=;
        b=lnoHmrS7MUCtnPBJphiba75fXgzUn+nMEj8FSAX4KRJWS3F/WxDqq8SJ8dYR8JTaTN
         lfqUvov3iAeRPacdzY3a9HQZCO3YrNQeyIL0Grvuj2bPgUB0uieRKKHO0ewmSFXhsThw
         D+GUJ7TOG5BemdQcFIeDtUjZa9LDEMVQgKEXKUgmyLvaC8oJDNeUxS9jkjGiytInKv/M
         A7gAXQugZykG65DLwaE/cL+4/VGh6kVye4CuZLJ30VDAmXETfkuoHdwFdWH5GV/Ye0Qw
         5weZs25aH3wKzMGWDY6xOWOBMeLonG2JODRwVwMfXYC/nEr4UDlqE61TUF4eHvPBI8Qh
         gMRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j2ACXejv66YglOf8tR8lqUUYybuE/S70Ob9McmdUki4=;
        b=P9F9apAY09G8m7b0G4xv3YgHXQBtn9FJl2IYEXohAde8REtpNFpxqzv5YH7g6O/oP8
         Q73I5J9wkQWSVMTq3500bGgjlPIvzCzSK381fgI/NKzzSESk/WQuR5Nvgvtbhupow5Z/
         waM9avls+lvuxJD3Dlx66DWq//hUlePjL4Aotp/vvmRWXLwRKBIl1z9mbB4X+TjiIoGp
         a0v2XHtKjJT6mK+GA5ptqiuVy9vlZoHXQuoK8Ewjl/IDB0ZEWIFs7p0eX6/uN4MVOqFt
         uadVWjlWkbNHrqFitBcYijJNXSNv5yuvCuRimt6gS7dyK1YhqL/x48ba9utEUFQE0Pax
         G4CA==
X-Gm-Message-State: APzg51CkMY5hi1jZQ06duz6V3ZWphvvg9Wq4lqQrt/dgX5qOhgrp7p6a
        q0tTJP2aiQtJzvbwfR9AfB4=
X-Google-Smtp-Source: ANB0VdaE3oImk41tKl8dp76KSkBivjH1w4s4bLdb1hWFndO4UnrAk+ifM72Haw9Sw5NW0ru+8y8U0Q==
X-Received: by 2002:a1c:6486:: with SMTP id y128-v6mr2653925wmb.12.1535659239763;
        Thu, 30 Aug 2018 13:00:39 -0700 (PDT)
Received: from [192.168.2.67] (p578F0EE7.dip0.t-ipconnect.de. [87.143.14.231])
        by smtp.gmail.com with ESMTPSA id h184-v6sm1873579wmf.28.2018.08.30.13.00.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 13:00:39 -0700 (PDT)
Subject: Re: [linux-sunxi] [PATCH v3 21/30] iio: adc: sun4i-gpadc-iio: add
 support for H3 thermal sensor
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, linux@armlinux.org.uk,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, eugen.hristev@microchip.com,
        rdunlap@infradead.org, vilhelm.gray@gmail.com,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        geert+renesas@glider.be, lukas@wunner.de, icenowy@aosc.io,
        arnd@arndb.de, broonie@kernel.org, arnaud.pouliquen@st.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-22-embed3d@gmail.com>
 <20180830162734.uq65l6ox6uwrmulo@core>
From:   Philipp Rossak <embed3d@gmail.com>
Message-ID: <e919cbdd-a874-4b46-a505-9412d093f54a@gmail.com>
Date:   Thu, 30 Aug 2018 22:00:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180830162734.uq65l6ox6uwrmulo@core>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.08.2018 18:27, Ondřej Jirman wrote:
>> +static int sun8i_h3_calibrate(struct sun4i_gpadc_iio *info)
>> +{
>> +//	regmap_write(info->regmap, SUNXI_THS_CDATA_0_1,
>> +//			info->calibration_data[0]);
>> +//	regmap_write(info->regmap, SUNXI_THS_CDATA_2_3,
>> +//			info->calibration_data[1]);
> This should probably be implemented, or left out completely.
> 
> regards,
>    o.
> 
Thanks you are right!
This should be implemented! I will fix this in the next version!

Thanks,
Philipp
