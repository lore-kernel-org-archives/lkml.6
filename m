Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0610EC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E0224B09
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fX3DLdkx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1E0224B09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753544AbeGCOER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 10:04:17 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36345 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753341AbeGCOEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 10:04:15 -0400
Received: by mail-yw0-f196.google.com with SMTP id t198-v6so726404ywc.3;
        Tue, 03 Jul 2018 07:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=45uBaUnt869Tydr6zwIywCxz+wGkAgyT3wZSrUUEn1g=;
        b=fX3DLdkxWzvP1TYvIEAALMpavPQLKDDH3E7uzX+Eygn1yi94E7ck4xu69OedXpYY8o
         258eXLHfP6Bk0kHPOwIWXhXD4RySrkHK1BxIGGjH7Rj5HF5GoUxjqLoOhuKyxNRus27B
         3kDrHDVGJ2ObvwUe62RICVL5Vl5z5FXkLITCnDYgkHVvs130KD3YleyFEpmNXXTmuT7F
         Fjxb+jVOoC3GMtlr2eqeSQgcjdf3bq0bgAW5HRh0nVP4STYCIAHHFeSv8caGo4gdEy9q
         +bTudjAU5+FmQL6ivzMHncIVU+wS+TFSusm+KLQ8gB6tYWE2lW9ZLspgf02sKCAI6H2Q
         18AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=45uBaUnt869Tydr6zwIywCxz+wGkAgyT3wZSrUUEn1g=;
        b=twmKOHRoKiUCdEQ3O3qxd80yLIy/3X2XXcRb+2Wy//YMi3gXVFH+FMaCsgvoXf7F8J
         lgLjQTYVgXqeDw3WSEVCOBRz5FsrtyF3h//5dxlyk0N0AwKy2FvJbHTQEeZLdQDfayzf
         8ZA0cywgATHfsF96CukbzQ3t8UHpuId0B6LWK8rfgWQt34zIJ+Cqa9/TAVTY0icwhGNJ
         9ZbmN2ZiOW9g+k32VXNCA8V/ID2Z944KtwTDlMLieicoyccI98BrHBDjHJxBgRmpe15u
         UULhcesrFWENUiKlx3tVSzjD2E2M4nKzMkVh913N7VO/YuHTwKwJWuldpT1k2ipnOQRy
         +UXQ==
X-Gm-Message-State: APt69E2v5sRuXcHHbKNugCWzbc/BzPNqcLQtG5MkwoB8y5ABmjPEiRhv
        rGEzQsxWS3kkrgmrwWw34yQ=
X-Google-Smtp-Source: AAOMgpeJLjn189W7Y3BTP8iBgnOl4jDTjRJMTJla5AKtIuSqF30pRIrKoB0mW2ULg2gBk5WSTyZgrQ==
X-Received: by 2002:a81:810:: with SMTP id 16-v6mr14495811ywi.389.1530626653771;
        Tue, 03 Jul 2018 07:04:13 -0700 (PDT)
Received: from sophia ([72.188.97.40])
        by smtp.gmail.com with ESMTPSA id g83-v6sm373663ywa.106.2018.07.03.07.04.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 07:04:13 -0700 (PDT)
Date:   Tue, 3 Jul 2018 10:04:06 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     gregkh@linuxfoundation.org, jic23@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        fabrice.gasnier@st.com, benjamin.gaignard@st.com,
        robh+dt@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mark.rutland@arm.com
Subject: Re: [v7, 02/10] counter: Documentation: Add Generic Counter sysfs
 documentation
Message-ID: <20180703140406.GA14958@sophia>
References: <27299151c2c7c57e70c49b4f7b794839d00cd750.1529607879.git.vilhelm.gray@gmail.com>
 <2c7ae044-c09b-3d51-bd16-3ecf35154024@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2c7ae044-c09b-3d51-bd16-3ecf35154024@lechnology.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 02:11:35PM -0500, David Lechner wrote:
>On 06/21/2018 04:07 PM, William Breathitt Gray wrote:
>> +What:		/sys/bus/counter/devices/counterX/countY/count_mode
>> +KernelVersion:	4.19
>> +Contact:	linux-iio@vger.kernel.org
>> +Description:
>> +		Count mode for channel Y. The ceiling and floor values for
>> +		Count Y are used by the count mode where required. The following
>> +		count modes are available:
>> +
>> +		Normal:
>> +			Counting is continuous in either direction.
>> +
>> +		Range Limit:
>> +			An upper or lower limit is set, mimicking limit switches
>> +			in the mechanical counterpart. The upper limit is set to
>> +			the Count Y ceiling value, while the lower limit is set
>> +			to the Count Y floor value. The counter freezes at
>> +			count = ceiling when counting up, and at count = floor
>> +			when counting down. At either of these limits, the
>> +			counting is resumed only when the count direction is
>> +			reversed.
>> +
>> +		Non-Recycle:
>> +			The counter is disabled whenever a counter overflow or
>> +			underflow takes place. The counter is re-enabled when a
>> +			new count value is loaded to the counter via a preset
>> +			operation or direct write.
>> +
>> +		Modulo-N:
>> +			A count value boundary is set between the Count Y floor
>> +			value and the Count Y ceiling value. The counter is
>> +			reset to the Cunt Y floor value at count = ceiling when
>> +			counting up, while the counter is set to the Count Y
>> +			ceiling value at count = floor when counting down; the
>> +			counter does not freeze at the boundary points, but
>> +			counts continuously throughout.
>> +
>
>This might be a bit misleading since the values returned are all lower case,
>e.g. "rising edge", whereas they are listed here in Title Case.

Fair point, the options explicitly listed in the documentation should
match how they appear on the system. I'll make sure to consolidate these
and the others you mentioned in the next revision.

>> +What:		/sys/bus/counter/devices/counterX/countY/preset
>> +KernelVersion:	4.19
>> +Contact:	linux-iio@vger.kernel.org
>> +Description:
>> +		If the counter device supports preset registers -- registers
>> +		used to load counter channels to a set count upon device-defined
>> +		preset operation trigger events -- the preset count for channel
>> +		Y is provided by this attribute.
>
>Should this be presetZ in case a device has more than one preset?

I suppose it could be possible for a device to feature more than one
preset register for a count. However, in those cases a simple numbering
scheme such as presetZ would be ambigious: which preset register is
evaluated at which point?

I suspect in these kind of devices the preset registers are designated
specific triggers; for example, perhaps preset0 is evaluated when the
count reaches a ceiling, while preset1 is evaluated when a count reaches
a floor. In those sort of cases, it may be better to be more explicit
and define them as preset_ceiling and preset_floor (or something
similar) to make their behavior and use more apparent.

Alternatively, if the multiple presets are configurable, then there may
be value with a presetZ scheme if we have a respective presetZ_op
attribute (or similar) to expose the preset operation trigger condition
to the user. I haven't personally encountered devices like this, but I
can see it as possible, so we can consider this design once we try to
add support for a device that requires it.

>> +What:		/sys/bus/counter/devices/counterX/signalY/signal
>> +KernelVersion:	4.19
>> +Contact:	linux-iio@vger.kernel.org
>> +Description:
>> +		Signal data of Signal Y represented as a string.
>
>I guess the actual value returned depends on the type of signal? Would we
>need /sys/bus/counter/devices/counterX/signalY/type to indicate this so we
>know how to interpret the value?

I'm not sure how useful such an attribute would be. If we're using some
sort of generic utility to list out counter device information, then it
can print out the signal data directly because it's reported as a
character string. On the other hand, if the utility is specific for your
particular device, it should already know the format of the signal data
to parse at the very least from the respective documentation.

I don't believe adding this attribute would be technically difficult,
but I would hold off on adding it until we see a situation that requires
it (perhaps a device with multiple signal sources of different types for
example).

William Breathitt Gray
