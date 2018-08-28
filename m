Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D61C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 03:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4626208B4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 03:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bwg11hbf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4626208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbeH1HJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 03:09:58 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:44589 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbeH1HJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 03:09:57 -0400
Received: by mail-oi0-f68.google.com with SMTP id l82-v6so253198oih.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 20:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ie//tSW3fDEFPFVtJjiXB1Lff2qCUANoHt8PUElmxJI=;
        b=bwg11hbfKGhmbEyKFkV1JKSO9WHzihWQeoEM7nPLfxlqXq1UvpG6ThEtzoEIJ9eE5U
         Y/+bYtXyWG98PwXOQ8lok6fzTMwtFG/9EsbbCqtJ45vfH6LSX2izu3FLjCN8GXe9HEYj
         OM+j2gXVy5sQ+8N92ueEHT/2InDXD99QkLGuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ie//tSW3fDEFPFVtJjiXB1Lff2qCUANoHt8PUElmxJI=;
        b=bLbLqiY3q3AayWOzbhnBkmyXLZz5Os2E2M+6nHi2ZH/aT1MpmEwFyg0f+fQou0FIOR
         1Oi8TP471abjDdqE+ilJK9cnaWp//5Ix2h+AIDxfOidzc0FdLJ2dyYUxq7hPy1lF8DZN
         9cpJxYPXo++rNR7u4cUL2b99GtUJJyjNerjVLMivYDZfZcJjo5nZihdENMln8tSJ5uQi
         N1IlEAIF4KrYJZbOAO3xEssY/WaM5EWpQjUbS4mLtKMRpU5i+eIak5ICBZQe9nC1wRPr
         f5a5R1yOzlNhoA77ceBS6hvMCWRB7SFTBw2S6itqkvNYhxbqn/9oBFgGAwahpGWTXFjC
         TsRQ==
X-Gm-Message-State: APzg51DBGHGG4uGo+FjYAKNQVwl8mqhy4Kykp2mR3XPyz9K8mRDEgzDy
        4j9wIsimApEAE00XO+CwNRddWRm7vAq77iBwttFxOA==
X-Google-Smtp-Source: ANB0VdY94g73Hj5Socz/GPsv2cvfv9TSDF113qYbgshBH/M89IM7Hm72lEjKduzHOeYV7nWPEvmHFfMpvza91jrtkwo=
X-Received: by 2002:aca:50cf:: with SMTP id e198-v6mr1370437oib.332.1535426426229;
 Mon, 27 Aug 2018 20:20:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:29:0:0:0:0:0 with HTTP; Mon, 27 Aug 2018 20:20:25 -0700 (PDT)
In-Reply-To: <20180825094357.6425ab4a@archlinux>
References: <4a7e33457617e6f0f7c9627fe20ddd3039e4fe82.1535103920.git.baolin.wang@linaro.org>
 <cc6b76c5d660818d3ff7833ea5be4f32ed960f54.1535103920.git.baolin.wang@linaro.org>
 <20180825094357.6425ab4a@archlinux>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 28 Aug 2018 11:20:25 +0800
Message-ID: <CAMz4kuKdw9EiZ2txKuPJrHt1oeKv7ye6P8GjS=KXuaJYWRs4eQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: sc27xx: Add ADC scale calibration
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        freeman.liu@spreadtrum.com, Mark Brown <broonie@kernel.org>,
        DTML <devicetree@vger.kernel.org>, linux-iio@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On 25 August 2018 at 16:43, Jonathan Cameron <jic23@kernel.org> wrote:
> On Fri, 24 Aug 2018 17:53:16 +0800
> Baolin Wang <baolin.wang@linaro.org> wrote:
>
>> This patch adds support to read calibration values from the eFuse
>> controller to calibrate the ADC channel scales, which can make ADC
>> sample data more accurate.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> This looks good to me.  I'll leave it for now though given open questions
> on patch 1 and to allow others time to comment on this if they wish -
> particularly as it includes a binding addition.

Thanks for your reviewing. But after more testing, we found one issue
when reading calibration data from efuse, which is not always 4 bytes
(sizeof(u32)). So I will change to use nvmem_cell_read() instead of
nvmem_cell_read_u32() in next version.

-- 
Baolin Wang
Best Regards
