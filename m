Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38001C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA2C223FDB
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="goRWwKPC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA2C223FDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753609AbeGFIWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 04:22:24 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:37039 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753069AbeGFIWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 04:22:21 -0400
Received: by mail-oi0-f67.google.com with SMTP id k81-v6so21970820oib.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 01:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lyOwhsmwryIaNKN6jRKTwyxahbdswOoQt2qUx3Rf6/c=;
        b=goRWwKPCtWWmdbda/dkOW07AnB8zajmNlVE5E6MGgFmb+0jcTomGV2Y8XxeqxoMFv/
         njshPzE2+SRcNJXFoffAxJzq3WqeayRLhD2K+OaM+Q0LURw5toRXEqzYaPQb8mHP6ONX
         DSCyZWrkcktygAIOK45LqqjWV1KM4TDkxvUtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lyOwhsmwryIaNKN6jRKTwyxahbdswOoQt2qUx3Rf6/c=;
        b=q0MUXRqiwgB3HgIPaNfpq4ho/Ai/6D63A5/Dg13iqrh5YBg/lHm4/S9j6npspLbiaw
         rYiy1ni/fKiCPCo0wNyD3A9eyuIOTi7CU2EYbSwQBBIWK9KigjzJPSqbC9g/hIOEb4ck
         VZhmtUCJclG7z+SSm4ulvfISUCa0UyySUlmROSvbcjcCsTaNGf1GFp1kQrLosJiO+u5i
         a1SXTOkJajWKhGE3lWbwc8rs2drZsaJMzyA2PcN2iLuaVGeHrhu+9S+tIr+ymGCF624W
         r3CZ3m2e6bsh5MufJ/ZQkIOBFsJ9Y2UsTRjxgOsLUpf0hVUb+GDPkAJ0uwtC3drTbK4D
         CdIw==
X-Gm-Message-State: APt69E2a6VNL3HMsZ8sg9cUiQ0jaWsOcN75poWKSFuTK/n6bg7vkr371
        EFC7pIaybuPk8uD+1Ut/kTZjXO0Zi0I8CxZhKwJ6mw==
X-Google-Smtp-Source: AAOMgpfcgVLN2PboQBZHdghBNQuCW6XaUbvMumnIm3eNT5KNOo0RVDhIaXK6VYMvAZFC6KcCR98NLtZdTyVur9zIbr0=
X-Received: by 2002:aca:b954:: with SMTP id j81-v6mr11258565oif.356.1530865341118;
 Fri, 06 Jul 2018 01:22:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:192d:0:0:0:0:0 with HTTP; Fri, 6 Jul 2018 01:22:20 -0700 (PDT)
In-Reply-To: <e1c4deef-ba3a-6454-a0cf-b05c144c58b5@st.com>
References: <1530271342-5532-1-git-send-email-yannick.fertre@st.com> <e1c4deef-ba3a-6454-a0cf-b05c144c58b5@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Fri, 6 Jul 2018 10:22:20 +0200
Message-ID: <CA+M3ks6WLzhJduct8qy3qFLxH2z9PLSvrXNs5Y5NhM2jt2LQEQ@mail.gmail.com>
Subject: Re: [PATCH] drm/stm: ltdc: filter mode pixel clock vs pad constraint
To:     Philippe CORNU <philippe.cornu@st.com>
Cc:     Yannick FERTRE <yannick.fertre@st.com>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-03 13:01 GMT+02:00 Philippe CORNU <philippe.cornu@st.com>:
> Hi Yannick,
>
> On 06/29/2018 01:22 PM, Yannick Fertre wrote:
>> Filter the requested mode pixel clock frequency according
>> to the pad maximum supported frequency.
>>
>> Signed-off-by: Yannick Fertre <yannick.fertre@st.com>

Applied on drm-misc-next.
Thansk,
Benjamin

>> ---
>>   drivers/gpu/drm/stm/ltdc.c | 16 ++++++++++++----
>>   drivers/gpu/drm/stm/ltdc.h |  1 +
>>   2 files changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
>> index 00e3262..96d20c2 100644
>> --- a/drivers/gpu/drm/stm/ltdc.c
>> +++ b/drivers/gpu/drm/stm/ltdc.c
>> @@ -491,6 +491,14 @@ static void ltdc_crtc_atomic_disable(struct drm_crtc *crtc,
>>       int target_max = target + CLK_TOLERANCE_HZ;
>>       int result;
>>
>> +     result = clk_round_rate(ldev->pixel_clk, target);
>> +
>> +     DRM_DEBUG_DRIVER("clk rate target %d, available %d\n", target, result);
>> +
>> +     /* Filter modes according to the max frequency supported by the pads */
>> +     if (result > ldev->caps.pad_max_freq_hz)
>> +             return MODE_CLOCK_HIGH;
>> +
>>       /*
>>        * Accept all "preferred" modes:
>>        * - this is important for panels because panel clock tolerances are
>> @@ -502,10 +510,6 @@ static void ltdc_crtc_atomic_disable(struct drm_crtc *crtc,
>>       if (mode->type & DRM_MODE_TYPE_PREFERRED)
>>               return MODE_OK;
>>
>> -     result = clk_round_rate(ldev->pixel_clk, target);
>> -
>> -     DRM_DEBUG_DRIVER("clk rate target %d, available %d\n", target, result);
>> -
>>       /*
>>        * Filter modes according to the clock value, particularly useful for
>>        * hdmi modes that require precise pixel clocks.
>> @@ -1039,11 +1043,15 @@ static int ltdc_get_caps(struct drm_device *ddev)
>>                * does not work on 2nd layer.
>>                */
>>               ldev->caps.non_alpha_only_l1 = true;
>> +             ldev->caps.pad_max_freq_hz = 90000000;
>> +             if (ldev->caps.hw_version == HWVER_10200)
>> +                     ldev->caps.pad_max_freq_hz = 65000000;
>>               break;
>>       case HWVER_20101:
>>               ldev->caps.reg_ofs = REG_OFS_4;
>>               ldev->caps.pix_fmt_hw = ltdc_pix_fmt_a1;
>>               ldev->caps.non_alpha_only_l1 = false;
>> +             ldev->caps.pad_max_freq_hz = 150000000;
>>               break;
>>       default:
>>               return -ENODEV;
>> diff --git a/drivers/gpu/drm/stm/ltdc.h b/drivers/gpu/drm/stm/ltdc.h
>> index c14e4db..0294d38 100644
>> --- a/drivers/gpu/drm/stm/ltdc.h
>> +++ b/drivers/gpu/drm/stm/ltdc.h
>> @@ -20,6 +20,7 @@ struct ltdc_caps {
>>       u32 bus_width;          /* bus width (32 or 64 bits) */
>>       const u32 *pix_fmt_hw;  /* supported pixel formats */
>>       bool non_alpha_only_l1; /* non-native no-alpha formats on layer 1 */
>> +     int pad_max_freq_hz;    /* max frequency supported by pad */
>
> Thank you for your patch,
>
> Reviewed-by: Philippe Cornu <philippe.cornu@st.com>
> Tested-by: Philippe Cornu <philippe.cornu@st.com>
>
> Philippe :-)
>
>>   };
>>
>>   #define LTDC_MAX_LAYER      4
>>
