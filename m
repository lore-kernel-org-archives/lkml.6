Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB22C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF7E21479
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550590953;
	bh=7TGnISBusvDYkgr1hwBsqJI95F4Lbg07Qwk2yydOnr0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mPndHGt/Sefdv20rLO/KneprOKOzJ72gkAA4uIZ3m58P6puednrhQ8/VaEjA+BCag
	 n9rgI3XiuN4fYezpYkyF3IqZy74cLDL6sv4zeHAeRFyrnfbtZMMI4XzDoDHPytDtnx
	 aF+Zr/KKayEiJzzmZWL2rvJan1WuK7cE8jJfqcRA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbfBSPmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 10:42:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:43880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbfBSPmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 10:42:32 -0500
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0A06217D7;
        Tue, 19 Feb 2019 15:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550590951;
        bh=7TGnISBusvDYkgr1hwBsqJI95F4Lbg07Qwk2yydOnr0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JyrfAJUKO2b2IBr2guXMYfjuC+lH1OOPqK51Uv3liPQwvX/KtHRp8Tzumc4clUbkF
         pUJGz64zdXXdVsbTfo6pZ+mKW+ljMBAr9uopIHr5Y8yCA2cNlyKWJiGdEMFOAZVAwN
         SzYxLmH9lbWdWMalfCn9DRyrbh6d6QvfVq9JiLAM=
Received: by mail-lj1-f178.google.com with SMTP id s5-v6so17765989ljd.12;
        Tue, 19 Feb 2019 07:42:30 -0800 (PST)
X-Gm-Message-State: AHQUAuabsmWN0O3wWFCXl4Qc0LpLZOqPjIuN0bFGcwpmW3z5oe/4V3Gg
        ovQytvLKPMx5qgkc7q1No/TdELpPo8nvARgZQYg=
X-Google-Smtp-Source: AHgI3IY3Zg2ylgwrD3pSC5BN+9tssWP2OGQHzVmciUiAVSFyDPf8aYNT98r+nTrVArsoiSxlX8COvfc5nH8dyTgkd3o=
X-Received: by 2002:a2e:890b:: with SMTP id d11-v6mr19291148lji.113.1550590949112;
 Tue, 19 Feb 2019 07:42:29 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190219152015epcas2p455d8fc3fa012de0f1e857b0b2c88f773@epcas2p4.samsung.com>
 <20190219151941.9795-1-s.nawrocki@samsung.com> <20190219151941.9795-2-s.nawrocki@samsung.com>
In-Reply-To: <20190219151941.9795-2-s.nawrocki@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 19 Feb 2019 16:42:17 +0100
X-Gmail-Original-Message-ID: <CAJKOXPfnOTvNQmx-ayYLXzJ9ViAv=m5rpzvLnOmaXWZLuMJ-Uw@mail.gmail.com>
Message-ID: <CAJKOXPfnOTvNQmx-ayYLXzJ9ViAv=m5rpzvLnOmaXWZLuMJ-Uw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ASoC: samsung: i2s: Fix multiple "IIS multi"
 devices initialization
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, sbkim73@samsung.com,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        alsa-devel@alsa-project.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Feb 2019 at 16:20, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>
> On some SoCs (e.g. Exynos5433) there are multiple "IIS multi audio
> interfaces" and the driver will try to register there multiple times
> same platform device for the secondary FIFO, which of course fails
> miserably.  To fix this we derive the secondary platform device name
> from the primary device name. The secondary device name will now
> be <primary_dev_name>-sec instead of fixed "samsung-i2s-sec".
>
> The fixed platform_device_id table entry is removed as the secondary
> device name is now dynamic and device/driver matching is done through
> driver_override.
>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes since v1:
>  - fixed pdev->driver_override assignment,
>  - ensure there is no need to release any resources claimed
>    in i2s_create_secondary_device() function when that function fails.
> ---
>  sound/soc/samsung/i2s.c    | 50 +++++++++++++++++++++++++-------------
>  sound/soc/samsung/odroid.c |  2 +-
>  2 files changed, 34 insertions(+), 18 deletions(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
