Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC31C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 14:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E1E20815
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 14:20:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52E1E20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbeKSAks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 19:40:48 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34449 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbeKSAks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 19:40:48 -0500
Received: by mail-ed1-f66.google.com with SMTP id b3so536089ede.1;
        Sun, 18 Nov 2018 06:20:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V0vwQn3mOpSsiGa5iCKbiRHG24e01BXBY+R788r7BPY=;
        b=TCWD98J0MU0wlUEhea6eWPUDRyf69QVA2bHJmjgTNhPh//1xtvWAkPGp36tv74wern
         GfJmu2Lmw2e1zd/qWk3dmSY7dKsHDqzhzeoZiX+PEeksVoXcwS+yFa1GGM49FQ/Tel0W
         IVdvpyNaQtl0DXXfpeqtPfs6E51ALFg5+ZPUsPq17PDhJw8uFr+egx9YxLTq1IUp+Ynu
         BSlDTj74jsdG8si54i8phkepQAd+tRUIONPeFDPX4jTeI6DEZw/buNIU35LOzle0lGj7
         7Q4xmaYYrmTWmX8frOJpTMZBzHg2w1VQEunPBOrb/xHrbiKBZBdQaWOWsAP6GlhnqZDf
         L2LA==
X-Gm-Message-State: AGRZ1gI6aFmtbybtCrmxIcNjEfwCSEyst+C3hG0M4qNa2z+MMGcS7Apy
        cgldfFpJe5L3XwYdYvRLSh0k7qD7
X-Google-Smtp-Source: AJdET5eMiVAhHOWv/PJo5DKd28HQV/VGoqXDE59BikTy/y8E0UP+zakt4sNwEVIoAoEveTiJWar6CQ==
X-Received: by 2002:a50:8881:: with SMTP id d1-v6mr16046567edd.156.1542550820090;
        Sun, 18 Nov 2018 06:20:20 -0800 (PST)
Received: from kozik-lap ([178.38.103.27])
        by smtp.googlemail.com with ESMTPSA id b49sm7435631edb.73.2018.11.18.06.20.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 18 Nov 2018 06:20:19 -0800 (PST)
Date:   Sun, 18 Nov 2018 15:20:17 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, arm@kernel.org,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] ARM64: dts: exynos: Add all CPUs in cooling maps
Message-ID: <20181118142017.GB11419@kozik-lap>
References: <cover.1542362530.git.viresh.kumar@linaro.org>
 <74e23257aece9ceef48b1c1cf6c9bafcce3c6fbd.1542362530.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <74e23257aece9ceef48b1c1cf6c9bafcce3c6fbd.1542362530.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 03:34:25PM +0530, Viresh Kumar wrote:
> Each CPU can (and does) participate in cooling down the system but the
> DT only captures a handful of them, normally CPU0, in the cooling maps.
> Things work by chance currently as under normal circumstances its the
> first CPU of each cluster which is used by the operating systems to
> probe the cooling devices. But as soon as this CPU ordering changes and
> any other CPU is used to bring up the cooling device, we will start
> seeing failures.
> 
> Also the DT is rather incomplete when we list only one CPU in the
> cooling maps, as the hardware doesn't have any such limitations.
> 
> Update cooling maps to include all devices affected by individual trip
> points.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  .../arm64/boot/dts/exynos/exynos5433-tmu.dtsi | 36 ++++++++++++-------

Thanks, applied.

Best regards,
Krzysztof

