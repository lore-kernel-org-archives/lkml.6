Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F63C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 914A020652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pvysZ3u5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 914A020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbeIFQW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 12:22:56 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54462 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbeIFQW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 12:22:56 -0400
Received: by mail-wm0-f66.google.com with SMTP id c14-v6so11100047wmb.4;
        Thu, 06 Sep 2018 04:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nAXoHLjxSkW9b41N+P7ocYi0sbOqGw8pXmYLuJIwuY4=;
        b=pvysZ3u5pipw3UjY+vx0ku8L7bXv4I0UiVtyRzcY0mIFgL7EAodzLWaPY8H3MaoG8Y
         roGSAjbIvLNkd2iG55xm/tOVFR154O9HLjuN3SYccxVnvYWVzr1amoy5/9LPnhkkYlOy
         GhqEmnz5Nkx/kMfLloFF94d9ZpmvyO6sQt5ZbEhAmNuGzWsFHu88lI2R/rUt5pdTx7qn
         g9pwzDqWkXudTcs242QKuSnvV64D1b7J0d5MaZf+d1/LN8PkbDvKpE3fhXb5fHSo12Ux
         fphcVA7cq2G/5pVyvaDGqNyLgavL2nsv+PoI5IFOE53OsOlHOEsmppAQP5s61yHOpOZE
         Z58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nAXoHLjxSkW9b41N+P7ocYi0sbOqGw8pXmYLuJIwuY4=;
        b=LvniUrE5VBpWcd7od5bhq1uSVAqCE5E0EEQYh19SxOTF6g8i31mBUS4SkWLVuY3qUa
         ENByPdFuqewJC08EQmjhqia5RydFA83uzlIssXlvJz3crj6tiuXFQb+DojQNRgPVrcjU
         vZ46O8jNo6ntFQE0Rqt+hHfU7wW6/Ncn7wF16DDvDTP3x4fq+fEFiAPooiokFy6EAc8/
         lFD/9ygunNMbjJffvbEtrjSgllGTHMtVSX/hiIIObjpqGgxEagEN0qGc1g5Zrg2Ec+ch
         XsXoQBPTQzsyrXDB5SXc03NdHo3mpBzgTIbQ9lEnMfCNGPQ9h0xnQK2e6EBCxSy6knYi
         +Pgw==
X-Gm-Message-State: APzg51AW8z8baJdtfu07MfbaotR6adeqRHxAJC0cHD9ch4a9stRtM1SE
        v3tXUFZh2ehV6tfyz3F/4Vo=
X-Google-Smtp-Source: ANB0VdZI9RTQJ5SDduXL1U6E0aw4qpxqEzuQQhtFHGpXx66sD8FAqjSoSnUY3Sfti/vEol+yDGoxMw==
X-Received: by 2002:a1c:e289:: with SMTP id z131-v6mr1908376wmg.32.1536234468880;
        Thu, 06 Sep 2018 04:47:48 -0700 (PDT)
Received: from [10.104.24.89] (eduroam-nat3.rz.uni-ulm.de. [134.60.112.238])
        by smtp.gmail.com with ESMTPSA id m8-v6sm2962514wrn.72.2018.09.06.04.47.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 04:47:48 -0700 (PDT)
Subject: Re: [PATCH v3 27/30] ARM: dts: sun8i: h3: use calibration for ths
To:     Emmanuel Vadot <manu@bidouilliste.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, linux@armlinux.org.uk,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, eugen.hristev@microchip.com,
        rdunlap@infradead.org, vilhelm.gray@gmail.com,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        geert+renesas@glider.be, lukas@wunner.de, icenowy@aosc.io,
        arnd@arndb.de, broonie@kernel.org, arnaud.pouliquen@st.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-28-embed3d@gmail.com>
 <20180904184623.e4386b8e6b657b1b25e90c09@bidouilliste.com>
From:   Philipp Rossak <embed3d@gmail.com>
Message-ID: <55579dd6-625d-e71b-1482-4592dccac665@gmail.com>
Date:   Thu, 6 Sep 2018 13:47:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180904184623.e4386b8e6b657b1b25e90c09@bidouilliste.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.09.2018 18:46, Emmanuel Vadot wrote:
>> +			/* Data cells */
>> +			thermal_calibration: calib@234 {
>> +				reg = <0x234 0x8>;
>> +			};
>   You are declaring 8 bytes of calibration data but to my knowledge it's
> only 2 bytes per sensor, so 2 bytes for H3.
>   Am I missing something ?
> 
>   Thanks,

Emmanuel you are right, it is 2 bytes per Sensor and should be 2 bytes 
for H3, but the thermal calibration data field is on all chips 64 bit 
wide - so 8 bytes. So I'm reading here the complete calibration data field.

Philipp
