Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1BBC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C60920673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="y3ttTtLa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C60920673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbeGZIph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 04:45:37 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33255 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728925AbeGZIpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 04:45:36 -0400
Received: by mail-lj1-f195.google.com with SMTP id s12-v6so636376ljj.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 00:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bWnnbgK9Yhr6HWJCJ1TCY9elZEptNpf0JagwRfleQPQ=;
        b=y3ttTtLac1ArSwn6by+T8NrZ/QDsWIVIqDX8Azkgtcj5pSEdqUtmeQlob5cqMEG1En
         Qoru5ocmFwESbAYnGJapzu3Abv8zAVO4XCVoLnmBHPjrKPQr4xPC06eaRo2tpW5tDgUF
         RvrXehSmpZ+9L5hs0bvKUjbgabuAloCXdjI2rzKczHxTVdgV5klzt9W/iwYSBlv3G/r3
         U0F86+y4j02/3mZi14u7JyvsVQJVSmbBKBroRA51eCcVdpu4DTLVPjsGButGcODX89Q9
         2jU0ZVkVL3qJJVTFzO29XabyrNoSzYQgm3SwgGKcx9t9X8z1HXKpHFkF6Amf393daEJL
         KzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bWnnbgK9Yhr6HWJCJ1TCY9elZEptNpf0JagwRfleQPQ=;
        b=k4W/3q2E3AAUb+T9tu6/XwVH8CG88YQiBH6kXmkhOh5Z675yS87jYGBBWmBO0Q9ra8
         aFA40hDZ6XC9BGFClP98K2oiN3nqCWj/6e7Zjt92VS8ct5EUb0XBGbQqC0KwYP0Jc9hU
         winL65W/b0KTTnZSypyXUhNZeuWMg9dOvJurIB/rSS9Dff7ABNzunVaEyhuBRkU0UiDa
         MY9YGAooQ8jHPram873mGPbK+XXUNaChUMQ426gRYUviM3wTm9NYVZQbII9zwBWGEfzm
         ZbhxBrbxKtthaV8kXji9Z/GNU3RZpxxyoul1Z2dniB5L0uCb9hocQaM0EfzLXcaHjB6f
         wyvA==
X-Gm-Message-State: AOUpUlEhhZwl/ahUwy95OMHBRzrWPgbmaAuU5HEWxNp9HtVtFAnm6cBs
        oyYk2CTKBibvwmdLV/zP3ybHvxl9p56geA==
X-Google-Smtp-Source: AAOMgpfM7bGyKE9D8XeUSOG4ZWtsh97GBiIks1hutg1YcTD/C17YcE9XgwGXrBtlanRozXG6uan5BQ==
X-Received: by 2002:a2e:9e17:: with SMTP id e23-v6mr680117ljk.14.1532590204102;
        Thu, 26 Jul 2018 00:30:04 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id n24-v6sm106551ljc.7.2018.07.26.00.30.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 00:30:02 -0700 (PDT)
Date:   Wed, 25 Jul 2018 23:57:41 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 2/3] ARM: dts: exynos: Second round for v4.19
Message-ID: <20180726065741.2j66wexoeehb3wcy@localhost>
References: <20180725162340.7488-1-krzk@kernel.org>
 <20180725162340.7488-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725162340.7488-2-krzk@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 06:23:39PM +0200, Krzysztof Kozlowski wrote:
> Hi,
> 
> On top of previous pull request.
> 
> 
> Best regards,
> Krzysztof
> 
> 
> The following changes since commit 57f4e8bc1c3ebbd06a278107edeb6af95b53e5bf:
> 
>   dt-bindings: samsung: Document bindings for SGH-T959P board (2018-07-07 12:28:07 +0200)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-4.19-2
> 
> for you to fetch changes up to 965228d33cd2b47adb493bb1864761420c632e41:
> 
>   ARM: dts: exynos: Configure Midas SD card CD pin (2018-07-23 19:12:01 +0200)
> 
> ----------------------------------------------------------------
> Samsung DTS ARM changes for v4.19, part 2
> 
> 1. Add missing interrupts to PWM nodes on Exynos5.
> 2. Add missing interrupt pin pull up/down configuration on Exynos4412
>    Midas boards.  The interrupts were mostly working thanks to initial
>    configuration by bootloader.

Merged, thanks!


-Olof
