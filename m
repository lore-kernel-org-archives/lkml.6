Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDE9C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F742086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HU7TZO2X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F742086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbeJPXEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 19:04:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727180AbeJPXEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 19:04:11 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 789252089E;
        Tue, 16 Oct 2018 15:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539702796;
        bh=Opwcj4xd9/EDDJll25PGE5qm/OpY3qbhs0oRCFlkv8g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HU7TZO2X+LzN/2G4M1sImthJpJGu7n6to1S2hafGq9MwBNYyUhzzFv7KVRy7khH0K
         rx9n9IlbmwSvfUjmh4pNcWlp1t6rwfxVdhACu5WX9oMaj5+iZGTp0M8sBcNLP30TBf
         KMVzyAfvCbkfwBfoyXduPkc6hkZQjqQIZInJ+kk0=
Received: by mail-wm1-f44.google.com with SMTP id 206-v6so22844861wmb.5;
        Tue, 16 Oct 2018 08:13:16 -0700 (PDT)
X-Gm-Message-State: ABuFfojoCQ/Tlp/jU/OuJbeqrJ8QCLm+HH6xgi2PqM1IlpJDoEQzc2Qg
        jPpPMgGq/AeUPUe9sUe+kZAJUSWtT/VC+pbRrVw=
X-Google-Smtp-Source: ACcGV61vHNaUteW84b9vLlHpV65O1QdEQFx8BqIHbxDvbUyBCK0uu8Hv45X0NNW7A+E3bq7McoBtSSfadcUpcM6TB2A=
X-Received: by 2002:a1c:a015:: with SMTP id j21-v6mr18197456wme.78.1539702794893;
 Tue, 16 Oct 2018 08:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20181016145651eucas1p1ea84684e37e67b4161548e6cff489cb8@eucas1p1.samsung.com>
 <1539701782-26852-1-git-send-email-l.luba@partner.samsung.com> <20181016145651eucas1p1ea84684e37e67b4161548e6cff489cb8~eHqPK-tM31616816168eucas1p1y@eucas1p1.samsung.com>
In-Reply-To: <20181016145651eucas1p1ea84684e37e67b4161548e6cff489cb8~eHqPK-tM31616816168eucas1p1y@eucas1p1.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 16 Oct 2018 17:13:03 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdKoxB3aN+1y48WD9Gv2P6KvSFSiD6aCk+PimBooE3YWg@mail.gmail.com>
Message-ID: <CAJKOXPdKoxB3aN+1y48WD9Gv2P6KvSFSiD6aCk+PimBooE3YWg@mail.gmail.com>
Subject: Re: [PATCH 09/11] DT: arm: exynos: add support for thermal trip irq-mode
To:     l.luba@partner.samsung.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2018 at 16:56, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> This patch adds support for new flash which indicates
> that trip point triggers irq when temperature is met.
> Exynos5433 supports 8 trip point which will trigger irq.

Exynos5420? 4 trip points?

BTW, I just noted that you skipped samsung-soc mailing list.

DTS patches always should go through arm-soc so in case of Exynos -
linux-samsung-soc mailing list. The list should be also CC-ed if you
touch other Exynos or Samsung related code and get_maintainers.pl
always point it. Because you skipped it, some people might miss your
patches and definitely Patchwork which I am using won't see them
(https://patchwork.kernel.org/project/linux-samsung-soc/list/).

Best regards,
Krzysztof
