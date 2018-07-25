Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA820C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9932B20833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUij6k8Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9932B20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbeGYRk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 13:40:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:51338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728637AbeGYRk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 13:40:26 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B071E20833;
        Wed, 25 Jul 2018 16:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532536082;
        bh=CIIX1n2+1g0A3LoQtG27vmHtx6ES+fmiYWMBFT/PMt4=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=lUij6k8Q3sG2yMvjbvXTyl1nB+lyhCZcbmLPJsDo5nnTAvojjPwVHGGxVIaups5In
         qaBr0I+ax8KYnSBNr0i3YPBnqrKq53kHJrX1hqwwULlTUKVMsLAjMRLERHJ67HCGag
         /JWGiImidOQkgJpaVF8KHcadh+7kB2dUaUpOZmAk=
Received: by mail-wr1-f47.google.com with SMTP id g6-v6so8022575wrp.0;
        Wed, 25 Jul 2018 09:28:01 -0700 (PDT)
X-Gm-Message-State: AOUpUlGbhX2FaIL+mKs902lMxYLMJhaBBfjIJ47drpDmMzALIo3fiGj8
        LxsiHl5bWIJgiLFCPEhlb6CMjSE0dbDkYFAer1I=
X-Google-Smtp-Source: AAOMgpecVLP4siHNTkew5P+TsHZ2dBpdqQgzn6wcFmqoaANsHTuOXUHwz65pHoKJYAdsqm1kAUdt/C5AbC2Ut1tmCs0=
X-Received: by 2002:a5d:4452:: with SMTP id x18-v6mr15845794wrr.227.1532536080237;
 Wed, 25 Jul 2018 09:28:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9141:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 09:27:59
 -0700 (PDT)
In-Reply-To: <2385592.z8yee4uxt4@amdc3058>
References: <CGME20180718200318epcas3p16aed6c1725d6c1e63ea6b1ad209c5756@epcas3p1.samsung.com>
 <2442216.oppRSGRAaL@amdc3058> <20180724200312.xs6u4nvhjckukkig@kozik-lap> <2385592.z8yee4uxt4@amdc3058>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 25 Jul 2018 18:27:59 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfTBE-tW81tocCfObb-pAwNmDjjv-BY6kHNkEuazm0pAA@mail.gmail.com>
Message-ID: <CAJKOXPfTBE-tW81tocCfObb-pAwNmDjjv-BY6kHNkEuazm0pAA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: thermal: samsung: Add SPDX license identifier
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 July 2018 at 16:43, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> On Tuesday, July 24, 2018 10:03:12 PM Krzysztof Kozlowski wrote:
>> On Tue, Jul 24, 2018 at 06:46:35PM +0200, Bartlomiej Zolnierkiewicz wrote:
>> >
>> > Hi,
>> >
>> > On Wednesday, July 18, 2018 10:02:50 PM Krzysztof Kozlowski wrote:
>> > > Replace GPL license statement with SPDX license identifier (GPL-2.0+).
>> > >
>> > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>> > > ---
>> > >  include/dt-bindings/thermal/thermal_exynos.h | 12 +-----------
>> > >  1 file changed, 1 insertion(+), 11 deletions(-)
>> > >
>> > > diff --git a/include/dt-bindings/thermal/thermal_exynos.h b/include/dt-bindings/thermal/thermal_exynos.h
>> > > index 0646500bca69..642e4e7f4084 100644
>> > > --- a/include/dt-bindings/thermal/thermal_exynos.h
>> > > +++ b/include/dt-bindings/thermal/thermal_exynos.h
>> > > @@ -1,19 +1,9 @@
>> > > +/* SPDX-License-Identifier: GPL-2.0+ */
>> >
>> > This code should be GPL-2.0 only, original license statement is most
>> > likely result of using wrong file as the source of copy-paste. So I
>> > would like to have the license fixed first before doing conversion to
>> > SPDX.
>>
>> If you think that's the case, then it makes sense and please go ahead.
>> As fair as I remember this required signed-off from all contributors...
>> so probably just Lukasz and Eduardo?
>
> git blame shows just Lukasz so his Ack should be enough.
>
> I'm also fine with doing it in one patch like i.e. in commit a80ea4cb944e
> ("pata_bk3710: clarify license version and use SPDX header"), if you are
> also fine with it could you please re-spin the patch (+Cc: Lukasz)?

I do not have interest in changing the license, I do not want to deal
with possible legal issues so I'll skip it.

I am fine however with abandoning this patch if you or someone else
sends license change + SPDX.

Best regards,
Krzysztof
