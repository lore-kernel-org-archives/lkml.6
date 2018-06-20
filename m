Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE59C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D3320020
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0D3320020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754639AbeFTSoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 14:44:10 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35945 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754018AbeFTSoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 14:44:07 -0400
Received: by mail-wm0-f65.google.com with SMTP id v131-v6so1314985wma.1;
        Wed, 20 Jun 2018 11:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rpholrbbYXltyFhYdoTZcNlouuvMACYCHfXUWo6Bk/s=;
        b=rUrqHvG7tWgdxFww/rPx/nIlR6tZVARDK83CtirIdMd+VNClIwBgwx/JtmaSJnZXjg
         TAOIPHj7y16I2XER+ovQtqrD8Hp+067Z4/hAhoWL5DoZipVq5F74WWO9/oMa1LSa/f8g
         WRfbGsvZAkEXqV77m2ix1qT9YWs0vepwKk63hgnoS0j/9Gx+l8W2JO3XrsnEY+QuwmAA
         idv3KpK0OUdsPDz2dMYi/INQRqh0LAtvLATBE4Pqx81x3rk3Fn59PW3uIIlqD4N2NbmA
         xvlcLKq0i0SbTPmBtXNn6FPpm7SJirzam7tvU45ADrxgWv41DAJdBPwYG/2yq23tumxi
         9x7w==
X-Gm-Message-State: APt69E2aMxj3dvY6+KzvcCBSDEDsdwA0MKaveqDWaptUiO2qPtHVw7mg
        wKEZ/4pXjjVBuZqNWJy6Y7I=
X-Google-Smtp-Source: ADUXVKIO+n9lRDW/Ve7YeoIKXTrDqMwhAnbCe+xNkr5XiUU4oZnqNyNhcjTWKBrSd0I7kWibPR+JHg==
X-Received: by 2002:a50:a106:: with SMTP id 6-v6mr19418489edj.12.1529520246291;
        Wed, 20 Jun 2018 11:44:06 -0700 (PDT)
Received: from kozik-lap (adsl-84-227-236-43.adslplus.ch. [84.227.236.43])
        by smtp.googlemail.com with ESMTPSA id g30-v6sm1536466edb.5.2018.06.20.11.44.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 11:44:05 -0700 (PDT)
Date:   Wed, 20 Jun 2018 20:44:03 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     arm@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        ionela.voinescu@arm.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        chris.redpath@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/15] arm: dts: exynos: Add missing cooling device
 properties for CPUs
Message-ID: <20180620184403.u6tdqc2zvyslospe@kozik-lap>
References: <cover.1527244200.git.viresh.kumar@linaro.org>
 <cfd8de4b2ad1cfd7b0f1a0706c0b6b918e1ebffc.1527244201.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cfd8de4b2ad1cfd7b0f1a0706c0b6b918e1ebffc.1527244201.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 04:01:53PM +0530, Viresh Kumar wrote:
> The cooling device properties, like "#cooling-cells" and
> "dynamic-power-coefficient", should either be present for all the CPUs
> of a cluster or none. If these are present only for a subset of CPUs of
> a cluster then things will start falling apart as soon as the CPUs are
> brought online in a different order. For example, this will happen
> because the operating system looks for such properties in the CPU node
> it is trying to bring up, so that it can register a cooling device.
> 
> Add such missing properties.
> 
> Fix other missing properties (clocks, OPP, clock latency) as well to
> make it all work.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm/boot/dts/exynos3250.dtsi | 16 ++++++++++++++++
>  arch/arm/boot/dts/exynos4210.dtsi | 13 +++++++++++++
>  arch/arm/boot/dts/exynos4412.dtsi |  9 +++++++++
>  arch/arm/boot/dts/exynos5250.dtsi | 23 +++++++++++++++++++++++
>  4 files changed, 61 insertions(+)
> 

Thanks, applied.

Best regards,
Krzysztof

