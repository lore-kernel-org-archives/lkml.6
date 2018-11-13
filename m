Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB3CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC845223C8
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:55:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC845223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbeKNFyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 00:54:40 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35914 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbeKNFyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 00:54:40 -0500
Received: by mail-ed1-f68.google.com with SMTP id f23so2357169edb.3;
        Tue, 13 Nov 2018 11:55:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a7KjC7kywQgCEcxjXF2om1ZnMlO3DfI+tGhEZ4319dw=;
        b=d0JQWKgiQTQJSHV5gLHnY30xW7/Bl9DwwaSIAagPKlQUi8ZI/bx63yzxdq0bHVtWpF
         XkRrofTy+fzd2+9pS0BDBWdUBZt5BDFJ9X0r9kaWY2UeiTVD0F1amfD/Bor93R7O28Zf
         5H2wo24Mb6EE2qCIiLHShH2jM52x0aI4VEjL55vI+LhPdxmrk0EUoOGYPJrJExO9eD8O
         SKPOxkoFvqz4K3TxKFKK4bxYWNFKKZgn1XqxqIBMIj0mUbpro81NjR4UHSg2/M5oLK74
         D1f/H9z+jTusLimF9gv/OJ+in3pQzayDWyGGh4tFXzG/fYpGfjwH55R8AfAtidPapvWe
         RV8g==
X-Gm-Message-State: AGRZ1gLqijnXIJ5wTmGjeroEIeJy/hsVZdNlZaXl4uzHU8Zzkewx81HH
        IagUBVCDZJgj74wv2pCsCs0=
X-Google-Smtp-Source: AJdET5fPF5ZdVQfB8rt146b0fICC0u7uq2VwJ5yy9qwcWdb0ZqDzi0WlIsHI6VQHadHk5jLFd8r0YA==
X-Received: by 2002:a50:aece:: with SMTP id f14mr8840018edd.259.1542138899548;
        Tue, 13 Nov 2018 11:54:59 -0800 (PST)
Received: from kozik-lap ([178.38.103.27])
        by smtp.googlemail.com with ESMTPSA id d1-v6sm5543972edd.32.2018.11.13.11.54.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 11:54:58 -0800 (PST)
Date:   Tue, 13 Nov 2018 20:54:56 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCHv5 4/6] ARM: dts: exynos: Add pin configuration for SD
 write protect on Odroid XU3/XU4
Message-ID: <20181113195456.GF2418@kozik-lap>
References: <20180927140738.1006-1-linux.amoon@gmail.com>
 <20180927140738.1006-5-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180927140738.1006-5-linux.amoon@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 02:07:36PM +0000, Anand Moon wrote:
> Add SD card write-protect pin configuration to be sure that it will be
> properly pulled down to indicate write access.
> 
> Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> Changes since v4:
> 1. Remove cd-gpios and wp-gpios leaving only WP pin configuration (after
>    Marek Szyprowski feedback).
> 2. Pull pin down.
> 3. change the subject and commit message.
> Sorry Krzysztof if I have copied your commit message to describe the
> changes.

Thanks, applied.

Best regards,
Krzysztof

