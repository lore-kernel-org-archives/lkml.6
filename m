Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B244BC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7A021916
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549613679;
	bh=xL0KCDNUiJduuCEaNXLRVFjWNZf+NkNqmsXdvoSK/iA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vzDffAihpbsIdGdgSBY8d71VYpCrPfDY3FeB8sSl1roDxWPmLmJs3icPQjsFQ48Iq
	 ywhh0wnbA98TfKrNmcgNWhrRxs8BF/hbHpUnpjIf11QwD1JtVZ+SW9p68zslU8L5VB
	 ABqOB35/mkk43zkfDwQe4kA/grI2GuUfKsnIJ7jw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfBHIOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 03:14:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:53312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727166AbfBHIOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 03:14:37 -0500
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E54B421920;
        Fri,  8 Feb 2019 08:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549613676;
        bh=xL0KCDNUiJduuCEaNXLRVFjWNZf+NkNqmsXdvoSK/iA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rQHVF7X1duZ28gHc0ImOStTlxfQVScm08VOpsL/V+NNdrlhMgmQxCwLX5b7PBS/fG
         Sem2DDvpYbDQ7yzQfZAjkGEPRSMUnFmwctwV4EpciVrDpHwJzQLdTDxig96QgSj8Ip
         neBaqpPPUBjTla71dH95LKNBXluAEc05v1gQMM1k=
Received: by mail-lj1-f179.google.com with SMTP id t9-v6so2223190ljh.6;
        Fri, 08 Feb 2019 00:14:35 -0800 (PST)
X-Gm-Message-State: AHQUAuZDW82v7galOJw2SWYek1S1238zJlILe+uMi/psGP1scgOvQzss
        sYhmI19CgRr/bllsMHknQf096TbO4UZrPRkHq28=
X-Google-Smtp-Source: AHgI3Ia6/zOcIsnEFzNo2uCfZM+RMVESEyuhPk6eG8hwJpMSyzK2JtZmdYs9URL6G2FlnZYU36Rp91XupL082i8Nmpk=
X-Received: by 2002:a2e:7615:: with SMTP id r21-v6mr8595853ljc.131.1549613673936;
 Fri, 08 Feb 2019 00:14:33 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190201164721eucas1p286976bab0cc9e06c2cf74a0eaa20144e@eucas1p2.samsung.com>
 <1549039612-28905-1-git-send-email-l.luba@partner.samsung.com> <1549039612-28905-7-git-send-email-l.luba@partner.samsung.com>
In-Reply-To: <1549039612-28905-7-git-send-email-l.luba@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 8 Feb 2019 09:14:22 +0100
X-Gmail-Original-Message-ID: <CAJKOXPd07M_qAMtkRE8u6JFAj-f7iPEmwanWfmLkpG5Osi8mSg@mail.gmail.com>
Message-ID: <CAJKOXPd07M_qAMtkRE8u6JFAj-f7iPEmwanWfmLkpG5Osi8mSg@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] DT: arm: exynos: add DMC device for exynos5422
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Feb 2019 at 17:47, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> Add description of Dynamic Memory Controller and PPMU counters.
> They are used by exynos5422-dmc driver.
>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  arch/arm/boot/dts/exynos5420.dtsi             | 78 +++++++++++++++++++++++++++
>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 22 ++++++++
>  2 files changed, 100 insertions(+)

Looks good for me. I will take it after bindings get accepted. It is
getting late in the cycle so it might end up in subsequent merge
window.

The subject prefix should be "ARM: dts: exynos:". If you are going to
send v5, please fix it. Otherwise there is no problem and I can change
it while applying.

Best regards,
Krzysztof
