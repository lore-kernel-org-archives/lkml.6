Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0A1C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B152086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="JbrW9wpu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2B152086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbeLLVO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 16:14:59 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41868 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbeLLVO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 16:14:58 -0500
Received: by mail-lf1-f67.google.com with SMTP id c16so14636541lfj.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 13:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3HkVUwkO7mSE5UKMfNW+Ny/9ELdxA2fRG0WljPCDgs8=;
        b=JbrW9wpuqkNyC5aWMhkJFKRZKlOzfVwvz+u7NGVAwjnTBSmWAAmpqRusj/aWNk7uDZ
         sLLc/9Hak/gc9ghM1NOL2id3gVU6LEHwmVp+EE0zHL1tGb5zyjbzL/r4VE5YS183Yn+B
         dX/dOrgw47QAWvsJmFFGcrFq5A1j87xHAYaWwSpqvx23dX9kjUApzqJO10Tis4KB1U1Q
         RJFbJsq0XeDdEEgRoUd2WMtn94j/0eE21WrdtQVEGTyor3jvwu69ZRpwla8gaF0/0QpM
         /9gJhOqzbjHEYNmaOCeEyVJDI3Cg89Kz2Ow00m2N88sYaplAmGrw83IH7D7LWSx56Brn
         l/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3HkVUwkO7mSE5UKMfNW+Ny/9ELdxA2fRG0WljPCDgs8=;
        b=cbPGCsKO1b8iadBxj4l74qp9CzTQ0W7IQVBXF+bLmEHw+zq3DRbqFLgIYdivMi/l6r
         Zow/4pmstptMm/clznkZgCki1r6vr0e4CU5Bt99IGtkEM1elXddGG4it+Pa5Q2Ya7Tw9
         r9lFDaVtbsrY8aGI9+mOCoJUlohE2y7hhMXbwh7QjYp02tCgZ0NL/nmC1Eemb3PsemxV
         Z1VmPbL2NFqKtFcq/XrCd1XmjK1IIVZaH6hiz8HhSWRy2rgtZ0izrcROjuLgp8hgYlYJ
         dNj4+LXF8968SE8b4PQE81AV1hIq8VDeHHPDd60s9SBER2KnvxzH6kCAUI8LSEXh//8B
         iVoQ==
X-Gm-Message-State: AA+aEWb9DZ8H0woTQzEoKaU6huLOft2pP2NNjPToJ2ZNVIT07dc6FW+S
        OsPK44EJLelIOvAGxwopD9Vp1A==
X-Google-Smtp-Source: AFSGD/Xfi4Ba5L7+c6qHbuOPCnA78nqHN9nNp8AgqNAtuKn33MwOUeLl0cNEf4pVBN3w5sRFeS4syg==
X-Received: by 2002:a19:c18d:: with SMTP id r135mr434830lff.59.1544649296487;
        Wed, 12 Dec 2018 13:14:56 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id r29-v6sm3329487ljd.44.2018.12.12.13.14.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 13:14:55 -0800 (PST)
Date:   Wed, 12 Dec 2018 12:53:18 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 3/4] arm64: dts: exynos: Pull for v4.21
Message-ID: <20181212205318.tyfeilorpgfu6qbd@localhost>
References: <20181209114911.25194-1-krzk@kernel.org>
 <20181209114911.25194-4-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181209114911.25194-4-krzk@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09, 2018 at 12:49:10PM +0100, Krzysztof Kozlowski wrote:
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-4.21
> 
> for you to fetch changes up to 9deffb5ee78e41e2a5d6c448874a24caec6467d0:
> 
>   arm64: dts: exynos: Add all CPUs in cooling maps (2018-11-18 15:18:42 +0100)
> 
> ----------------------------------------------------------------
> Samsung DTS ARM64 changes for v4.21
> 
> 1. Update DWC3 hardware modules to Exynos5433 specific variant.
> 2. Update cooling maps to include all CPU devices in multiple DTS files.

Merged, thanks!


-Olof

