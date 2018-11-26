Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CC1C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD13420663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUQR40TN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD13420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbeKZTmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:42:46 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46086 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeKZTmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:42:45 -0500
Received: by mail-ot1-f67.google.com with SMTP id w25so15804665otm.13;
        Mon, 26 Nov 2018 00:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YBE8JDKWe64UpAKVg40KcwrdB4QW4LFsUmDiwqia8a8=;
        b=mUQR40TNrhSdHD3RTQzPfBC/BqUeluqx0CWEgGeL8SPLoAfdl2HtWDA/abh4hPL590
         DFE5RkCY/SG3Q73m2TvswJA93H85KRnqrU9dFh05UBQPTuw8oE99NH5iqI86g/7ucPAL
         B+4qQx7c1cfo3iO4zKKN2oMajXzBs6SomLyOUsWoXT0ypvPeku6Jox8Sp+Ir7lfqtmGb
         qHzokpSraZoLH3u30HV2Rz6k26VOWWRER6S/GWCXyHIeqp02FRxEODgbEcr+D7aZm/ut
         +ejT5+qyQKNw5ABsNK46iD35ra9fMURr+uVpHbC0+Gv1Z9AkVXe+Z95d70vtAqV5ATFK
         s8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YBE8JDKWe64UpAKVg40KcwrdB4QW4LFsUmDiwqia8a8=;
        b=Qm6ijlVwAOzraVTrzzZLAFameDP2q7EmCGSO7ZCR/ZKAz//BtYdLN3kfGWb8KPYg0N
         5ydbnkO6JdF+TNWIqWY7jecmS1CRueI6o9q3sPl1h8qhOCNiZxInTcHb19rATn/59l6J
         K64D1D0+tIuoLbhEzmyRU4MrFVrx93KclcfwEtlxUMaMfUlmBflcLPq70eADhrqVTBNS
         l6wL5FOjnsQ+8oU4lLSxa/H89CvY7K3LlSyBtn3IIX8GOfG3/opPF8niBRbW7ijk9GsX
         CvFXAHJ0Hoi6k6S9qdaUNe2dD2VYR9/7dzLleA6M5iK5KvCRUQSbucyozphHqtQcxP6n
         bakw==
X-Gm-Message-State: AA+aEWasET57k2ABqgK9ZiFTRtJK69bUDHZNxcIZQucbXR+2q7MRCjRk
        GgqQusnTfCvulmptpdJSo1+qOx1F3Vho+e/JcJg=
X-Google-Smtp-Source: AFSGD/VohSyWB8fOyplNiBzw3s/YRDZfAYCNtMh9MaSzrXXrcXApu+uiOAQGpPvRKj2NDswiEZ/ReIS3fhuSxXviuDo=
X-Received: by 2002:a9d:42c:: with SMTP id 41mr15704933otc.41.1543222160321;
 Mon, 26 Nov 2018 00:49:20 -0800 (PST)
MIME-Version: 1.0
References: <20181123094413.1108-1-linux.amoon@gmail.com> <CGME20181123094508epcas5p4b7958b812bf0f64ca47006ced9fda279@epcas5p4.samsung.com>
 <20181123094413.1108-3-linux.amoon@gmail.com> <5BFBA2D1.8090409@samsung.com>
In-Reply-To: <5BFBA2D1.8090409@samsung.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Mon, 26 Nov 2018 14:19:07 +0530
Message-ID: <CANAwSgQv8e9geQCmnB7stH7GtQ__DmNDqReJaa_Au0hxvKij7w@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: dts: Add g3d bus nodes using VDD_INT for
 Exynos542x SoC
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Kukjin Kim <kgene@kernel.org>, linux-samsung-soc@vger.kernel.org,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On Mon, 26 Nov 2018 at 13:08, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>
> Hi Anand,
>
> CLK_DOUT_ACLK_G3D is the clock for GPU h/w and it requires the buck4_reg("vdd_g3d").
>
> bus_wcore uses the buck3_reg("vdd_int"). bus_wcore and bus_g3d don't share the
> same voltage line. It is wrong to make 'bus_g3d' as the child of 'bus_wcore'
> because of using the different regulator.
>
> CLK_DOUT_ACLK_G3D and buck4_reg should be controlled from MALI driver
> with DEVFREQ framework. Unfortunately, MALI driver is not posted to mainline.
>
>

Thanks for your clarification, I missed this point. mali gpu is linked
to buck4_reg
Next time I will ask for the expert how to proceed on some changes.

Best Regards
-Anand
