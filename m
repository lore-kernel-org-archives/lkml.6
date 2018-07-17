Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41860ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83572064D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erJA2e0d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E83572064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731390AbeGQUe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:34:28 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35667 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729759AbeGQUe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:34:26 -0400
Received: by mail-oi0-f66.google.com with SMTP id i12-v6so4382762oik.2;
        Tue, 17 Jul 2018 13:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PdFqzeKnl+jEZ36TA4EJdrBTqj/gBPaMaQJatqi5fb0=;
        b=erJA2e0dw6zbTbvSOa5hWYUUFab/DoJLXboTpKM7PoIIf+0SQQ9sepzjiN2pWKl+YZ
         ZhZBBaeJNtgDXhQx/fMfyWBp7ruZmj1ra/B6p/Gjk5F1dr6Uws9vSQyIHgSpDhg44axL
         sthbiPGAqbRo+M44eQBOJqoSvMpohGulxbST/x9hqHbbABTIuPHWHHTmh+QSQKMLzgZa
         t71Lb6RmzYVhRTsa5iwsArFkBQ6LFtWvtGgR+eAjH2su03SznwrBznyvsMmbK0UgmnPX
         gGPKUlfC6N0ON9VRsof8oh2+IeMCsNB6+L+SeSg4tziz/x6fISY4aQ6Gd/6xDDmU4FvV
         JzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PdFqzeKnl+jEZ36TA4EJdrBTqj/gBPaMaQJatqi5fb0=;
        b=a4qCar2FhQsKZLcHcxHd4g1+s6oOF3Dw+Nb+YuDAJKGOxnzm5zA6C0Zdn1WRhBmzsl
         P0hVIHqJILgyXcMdf8yFlyw0ZFtSt1xdF3qFcDTikMlBbCR91Yty2HNAJdQyE2MpKKRY
         +bYjjnJoOZPeaF5wPsSVm3QCPZFrdzRTVijTC4aIE/uIBcS1FJoavlN6hsqmNgojNd0R
         uz9aYU3/6kadCUYcjxY/fs5It8+k8gzBL21MhW1HNsL0mtN+zAtVzQN+rbjqOD+Ote3S
         V16d3+/PdOToTX/aBkRTW0Cs56S/7uoMthisGuhzFdoNQzLd2gy0sRkWGNAv/JJj5dtO
         IyxA==
X-Gm-Message-State: AOUpUlHz4tCRA4u2BKUA5dWBxlwN3FHcFekFKcqjpYM1fLUz3yKJNuIE
        OcVKafGFfCSSVEO07N9oos8HB3NWvZh6Sbh4L34=
X-Google-Smtp-Source: AAOMgpcEtJ8g/6ByJYYFS0qMQRqfKFlxiajwv/DBP9DKaaN0t7jvDB1zIr/6U2iFfa90814Ead4YT2FNzRZJpOG18lI=
X-Received: by 2002:aca:4ec6:: with SMTP id c189-v6mr3397840oib.186.1531857614627;
 Tue, 17 Jul 2018 13:00:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:5b33:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 12:59:53
 -0700 (PDT)
In-Reply-To: <CAJKOXPe_omjhLMfMScTeXG2k908WT4MesMK5obpA0ejBs=vrfg@mail.gmail.com>
References: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com>
 <1531822342-4293-3-git-send-email-linux.amoon@gmail.com> <CAJKOXPe_omjhLMfMScTeXG2k908WT4MesMK5obpA0ejBs=vrfg@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 18 Jul 2018 01:29:53 +0530
Message-ID: <CANAwSgTx=vYcQ4zrcBQ=GpQ9gXJ+26T7zCF-_zLAh8SxVmcv=A@mail.gmail.com>
Subject: Re: [PATCH 3/5] thermal: exynos: increase the number of trips for exynos542x
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 17 July 2018 at 17:55, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 17 July 2018 at 12:12, Anand Moon <linux.amoon@gmail.com> wrote:
>> increase the number of trips to support more polling modes,
>> changes help supress following warning.
>>
>> [    4.231731] thermal thermal_zone0: failed to read out thermal zone (-22)
>> [    4.237190] exynos-tmu 10060000.tmu: More trip points than supported by this TMU.
>> [    4.244661] exynos-tmu 10060000.tmu: 2 trip points should be configured in polling mode.
>> [    4.254821] thermal thermal_zone1: failed to read out thermal zone (-22)
>> [    4.260370] exynos-tmu 10064000.tmu: More trip points than supported by this TMU.
>> [    4.267631] exynos-tmu 10064000.tmu: 2 trip points should be configured in polling mode.
>> [    4.277551] thermal thermal_zone2: failed to read out thermal zone (-22)
>> [    4.283090] exynos-tmu 10068000.tmu: More trip points than supported by this TMU.
>> [    4.290438] exynos-tmu 10068000.tmu: 2 trip points should be configured in polling mode.
>> [    4.300280] thermal thermal_zone3: failed to read out thermal zone (-22)
>> [    4.305711] exynos-tmu 1006c000.tmu: More trip points than supported by this TMU.
>> [    4.313171] exynos-tmu 1006c000.tmu: 2 trip points should be configured in polling mode.
>> [    4.323002] thermal thermal_zone4: failed to read out thermal zone (-22)
>>
>> CC: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>
> NAK
>
> Exynos5420/5422/5800 has 4 trip points (understood as in current driver design).
>

Ok no issue.

Best Regards
-Anand
