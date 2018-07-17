Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A30ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC1020C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESQnhNSC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EC1020C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731408AbeGQMxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:53:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731314AbeGQMxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:53:23 -0400
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com [74.125.82.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF3AE2146E;
        Tue, 17 Jul 2018 12:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531830059;
        bh=xmXtyF9eQMvbP7iyzNNmVto0syQn1/2JCrYVijzkh0U=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=ESQnhNSCY9SF4t3UWqtr4U52yZM12r/iqsFdNiZTgGZAf6VClzYwsx3UQwv9jPKH9
         VRCuyP+oGQIZK4zLDiEAptmc+IUffnxncO4AIaw4zXeQ8ROmBqIL5eAkKymX9hCF1H
         fgcoUqYJDrrh2SUCV4mcv2BdTVmn1bQudkywLMBc=
Received: by mail-wm0-f54.google.com with SMTP id s14-v6so1318139wmc.1;
        Tue, 17 Jul 2018 05:20:58 -0700 (PDT)
X-Gm-Message-State: AOUpUlH2Rna+Dm7ykDpmogrGqDJyiCpKu1fJchExZoytpgkyv7gg50TG
        5WhueYWss3CBLbK5sciAfkSm5agE967MMu9/bWU=
X-Google-Smtp-Source: AAOMgpdfnmdCLspzg3qXe3Yy8eBVKyShq7ToqHW11XnnmlPtQ7R9T96qfxJHHdGcbJUzvHNClzqsilRBzbuuDhZpgFQ=
X-Received: by 2002:a1c:c14:: with SMTP id 20-v6mr1283856wmm.117.1531830057316;
 Tue, 17 Jul 2018 05:20:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9141:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 05:20:56
 -0700 (PDT)
In-Reply-To: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com>
References: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 17 Jul 2018 14:20:56 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdP78VFQgSQ9z9WsgYY_YhEKPUt=0MOra6Pz6smQeiNGg@mail.gmail.com>
Message-ID: <CAJKOXPdP78VFQgSQ9z9WsgYY_YhEKPUt=0MOra6Pz6smQeiNGg@mail.gmail.com>
Subject: Re: [PATCH 1/5] thermal: exynos: enable core tmu clk on exynos platform
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

Thanks for patch.

On 17 July 2018 at 12:12, Anand Moon <linux.amoon@gmail.com> wrote:
> clk_summary do not show tmu_apbif clk enable, so replace
> the clk_prepare with clk_prepare_enables to enable tmu clk.

This is not valid reason to do a change. What is clk_summary does not
really matter. Your change has negative impact on power consumption as
the clock stays enabled all the time. This is not what we want... so
please explain it more - why you need the clock to be enabled all the
time? What is broken (clk_summary is not broken in this case)?

> simplify the enable of tmu_triminfo_apbif clk, also fixed
> the order of goto error for failed cases.

This has to be split into separate change.

Best regards,
Krzysztof
