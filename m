Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2098C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BA2420861
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vBXzWE2t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BA2420861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbeIFQyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 12:54:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39723 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbeIFQyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 12:54:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id s14-v6so2187693wrw.6;
        Thu, 06 Sep 2018 05:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=87dUN+chB2+KcTGn3unqxyRyAqgYwx+Uln/JPGkcbrM=;
        b=vBXzWE2tX77aUfBdKKdBCvPW0H1arSRIIZpKOYCFbsTuUp1LOlL60tyq2Ea8yNCaFO
         gBhkRE9BtNbitv5cy/6KHlz0oOJy3EaTrB0lp47brCZcm5IcemA3YuAMSdaD2N4jT8Hz
         KHsZWCg4vvcPmd71nLhVBuQVtNtgOwmgiqz1qUtPsRRvjTEeahy6BjNnJz+rmd+cQxDP
         luWGydZeqznLEylMVjyhAtk6MDKX9JLUsm7W0Bh4U6FKzX9Onbx8WqTNC0b1li6+okcE
         xB1EX7s+L3alXaJbKQquqWY8MtORPwQH1UeNZnIZboJcPwyrMOnTybPn+i+L1w/5TeeD
         wfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=87dUN+chB2+KcTGn3unqxyRyAqgYwx+Uln/JPGkcbrM=;
        b=P420RFl5Fp4E5RBAFATqdBqglsWTUiAtNnAunr8jRtTD8V84ueLiaJFP4HxtsgFHlA
         Me1G2WRMW4uJE87uK84amxgDkznYMuwBmAyBH+n1EDKXtUZCA31vLX67+PLVoMrseTTO
         uo6NzRp9pQOFcbjLMA8nuXEboKE78SWz+k+pkYjJ46y1WW1931ANV7s2k13jfwXv/0tR
         8LCGV6rOxgL2nM/iFGyskjDZTy/SuR8oVB/LzlTADQ790nnx1375uJoM8F14GlwPFK0/
         MGh9dS5l+9nGAk5QFbbEEsioLGaUwuUPx+700Bkcs9dKkjwOIxrgHRsgWtU3eHA/24ib
         L9sw==
X-Gm-Message-State: APzg51BxCIRgVhAJIRgcvEi886EOAMwsEkfeiwPEXPYF5zYwXhkEAVNs
        cLyKfv6Nnz0SE5EywGdF9Q8=
X-Google-Smtp-Source: ANB0VdZ4tnWnW3UZh5+22PaEZfVkcH1REbakMJVejlqZBYgybE7Ur1bVXsrpLFQ6H0poIwj/jXacxQ==
X-Received: by 2002:adf:8367:: with SMTP id 94-v6mr2147620wrd.258.1536236329421;
        Thu, 06 Sep 2018 05:18:49 -0700 (PDT)
Received: from [10.104.24.89] (eduroam-nat3.rz.uni-ulm.de. [134.60.112.238])
        by smtp.gmail.com with ESMTPSA id a11-v6sm4292669wrr.81.2018.09.06.05.18.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 05:18:48 -0700 (PDT)
Subject: Re: [linux-sunxi] Re: [PATCH v3 27/30] ARM: dts: sun8i: h3: use
 calibration for ths
To:     icenowy@aosc.io, maxime.ripard@bootlin.com
Cc:     Emmanuel Vadot <manu@bidouilliste.com>, lee.jones@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        linux@armlinux.org.uk, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, eugen.hristev@microchip.com,
        rdunlap@infradead.org, vilhelm.gray@gmail.com,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        geert+renesas@glider.be, lukas@wunner.de, arnd@arndb.de,
        broonie@kernel.org, arnaud.pouliquen@st.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-28-embed3d@gmail.com>
 <20180904184623.e4386b8e6b657b1b25e90c09@bidouilliste.com>
 <55579dd6-625d-e71b-1482-4592dccac665@gmail.com>
 <20180906115114.inc6dhqhy47obo25@flea>
 <BEA89263-1186-432A-B274-228FAC21A798@aosc.io>
From:   Philipp Rossak <embed3d@gmail.com>
Message-ID: <d8825c55-60e0-16da-e122-22855c294bc4@gmail.com>
Date:   Thu, 6 Sep 2018 14:18:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <BEA89263-1186-432A-B274-228FAC21A798@aosc.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06.09.2018 14:04, Icenowy Zheng wrote:
> 
> 
> 于 2018年9月6日 GMT+08:00 下午7:51:15, Maxime Ripard <maxime.ripard@bootlin.com> 写到:
>> On Thu, Sep 06, 2018 at 01:47:47PM +0200, Philipp Rossak wrote:
>>> On 04.09.2018 18:46, Emmanuel Vadot wrote:
>>>>> +			/* Data cells */
>>>>> +			thermal_calibration: calib@234 {
>>>>> +				reg = <0x234 0x8>;
>>>>> +			};
>>>>    You are declaring 8 bytes of calibration data but to my knowledge
>> it's
>>>> only 2 bytes per sensor, so 2 bytes for H3.
>>>>    Am I missing something ?
>>>>
>>>>    Thanks,
>>>
>>> Emmanuel you are right, it is 2 bytes per Sensor and should be 2
>> bytes for
>>> H3, but the thermal calibration data field is on all chips 64 bit
>> wide - so
>>> 8 bytes. So I'm reading here the complete calibration data field.
>>
>> Having one cell per channel would make more sense I guess.
Ok I will change this.
> 
> I have mentioned that this is impossible because of wrong
> addressing caused by LE2BE in SID driver.
>
I know! But I would like to prepare patches for it, that they can be 
merged when this is fixed.

Philipp

