Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A4EECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DCE220874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:12:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DCE220874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388888AbeGWSPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 14:15:07 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36619 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388662AbeGWSPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 14:15:07 -0400
Received: by mail-ed1-f68.google.com with SMTP id k15-v6so1609755edr.3;
        Mon, 23 Jul 2018 10:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Po6Co2fJ8bapMbF8/RPAdOkklnmmloYtKS5/Qbro71k=;
        b=KohcsXPvBt6x2UBqtWZbRlpBxv/AQU3z+1e/BWGucE4C2w2lbgK5U1D+IF9Yig6Rrm
         miv4+bEUpK5i28teGB+kAn6Cr2g9MJ8t+xYw+R5rtbFBmtNpzfcxif8UqrYT6NNmnNHO
         qnQDeLPoDP/HMfI6p2Z/HchB1r6ZPLiYxudmEIjBNGZTUWBsDV9R39vtuNXQ/JKFJVdK
         Kg9WRzoMVH3prfoI4/dKaMP/cp3AFdDBGtujIJij6KlcZoh794sYJfFzhd8aNxBAWYdB
         uo3GsXQYfnRpJpQXSHa8ZhTpon/EPTxHrv+5olI7JQilbPjwj7uxjLaTztciXre5u4bl
         4P5g==
X-Gm-Message-State: AOUpUlGtY2kyY9xUp9mLL21ZD0ZdDkUMwLRY/HuATN5cCkqeKl0RSMh+
        YSRaWIbyC5R1/PrpiD55xbc=
X-Google-Smtp-Source: AAOMgpfdBJ9kkCItgqNn7RI4Fca0tdB7SadXy/vp5MTlvDuCJJC9I0eECWuE/aR6ZEeeJqXDMeHnJg==
X-Received: by 2002:a50:b2c6:: with SMTP id p64-v6mr14938481edd.293.1532365974807;
        Mon, 23 Jul 2018 10:12:54 -0700 (PDT)
Received: from kozik-lap (xdsl-188-155-58-14.adslplus.ch. [188.155.58.14])
        by smtp.googlemail.com with ESMTPSA id u12-v6sm4542133edj.37.2018.07.23.10.12.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 10:12:54 -0700 (PDT)
Date:   Mon, 23 Jul 2018 19:12:52 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Simon Shields <simon@lineageos.org>
Cc:     linux-samsung-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] ARM: dts: exynos: add pinctrl config for midas keys
Message-ID: <20180723171252.2z2sdetuan4snoq2@kozik-lap>
References: <20180721125128.31498-1-simon@lineageos.org>
 <20180721125128.31498-3-simon@lineageos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180721125128.31498-3-simon@lineageos.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 21, 2018 at 10:50:50PM +1000, Simon Shields wrote:
> This pins are externally pulled up, and so we should explicitly
> configure them to disable the SoC-internal pull-downs. Previously
> we relied on the bootloader doing this in order to allow the buttons
> to function properly.
> 
> Signed-off-by: Simon Shields <simon@lineageos.org>
> ---
>  arch/arm/boot/dts/exynos4412-midas.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)

Thanks, applied.

Best regards,
Krzysztof

