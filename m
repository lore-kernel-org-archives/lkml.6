Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F94C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7300C26831
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="GM3KcWMy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7300C26831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934362AbeFZLTu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 07:19:50 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50609 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933880AbeFZLTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 07:19:48 -0400
Received: by mail-wm0-f66.google.com with SMTP id e16-v6so1457066wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 04:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dFk2a73yNvmx/ag8Bs3W7C5/h3ttpubUvZ/7CYBiWoM=;
        b=GM3KcWMylAFV9r+0Ikd/TAwN6I55E76RKukseWf3JyzgSF86nSynPL02x7YyPLz4DO
         o6t2yp+KdOl8aS6/bn7+fLPvmOLdp8dpUdw4OrLX+um3xMfSXLV+5YoZxO15nm8QNCLp
         UqgR1WBQQPscod0aesGQ6x4AQKRTM7E5uMm0Xe7f2Z5RXMeehqtpLrlzZkFWwGY1PYLL
         YJt4y0RjWJrJ/jkeSVMyPqhHMTHiA06XJIt/XutZDCGQZnXUqDpTgs7rfglygBcNnT9E
         Slnij/VuN6fOjqCDyetKRCn0qxhppA4j3KT/AVpUiDGY37KOHB10vc7cD9mFhM9w3vOm
         xjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dFk2a73yNvmx/ag8Bs3W7C5/h3ttpubUvZ/7CYBiWoM=;
        b=UL99+uZrKGDu/NNc0unx5/W79lQ5gAAdKw00kk/wrcFupjECjVHDb8sGiQ04eSi17J
         pP4sC3iJQekjQeXrr51hq85xHTTmueaO0p84D9CSGLNuHgy+JUp9FR3fnwhPpnJJSmXQ
         NXqCpzgkonYv+qT2Yjy67d/EP6u5Geuxjh3vXvNKesBSty3iixlamVk1+6o3VLs83o/Y
         0o7db/uiaV64opgmKRdEJp2OKCAsTesrXSvVXmoVMzDCeNAGQXFqMGFfspfscE60J0cP
         vyh2NVP/fDFLV2I0ygek6WJYCg7BcfU7jR0IGXN5wNQMw+fwksB91vk7EH0wG75UHoiF
         XQdA==
X-Gm-Message-State: APt69E1Zx4enShHv6gW49LSXlyLrFTgZ3TqrGkRbHAZmdHM/X4mhO2If
        wpns5wAjvgPk+vDdxMi2nbqmig==
X-Google-Smtp-Source: AAOMgpfMVBd/unba/ySW202QEjjoMPLc6FjFVFx7BuJjONbvKPXca6yeRvqt2lGoZ0Fj7u7HYDgprw==
X-Received: by 2002:a1c:894f:: with SMTP id l76-v6mr1239129wmd.103.1530011987409;
        Tue, 26 Jun 2018 04:19:47 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y193-v6sm1977446wmy.13.2018.06.26.04.19.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 04:19:46 -0700 (PDT)
Message-ID: <1530011985.2900.45.camel@baylibre.com>
Subject: Re: [PATCH 0/2] clk: meson: drop clk-audio-divider
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 26 Jun 2018 13:19:45 +0200
In-Reply-To: <20180620100610.29010-1-jbrunet@baylibre.com>
References: <20180620100610.29010-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-06-20 at 12:06 +0200, Jerome Brunet wrote:
> As explained in the commit descriptions, clk-audio-divider was a poor
> solution to make sure PLL rates would be high enough while using CCF
> rate propagation to determine audio clock rates.
> 
> Stopping rate propagation before the PLLs is actually simpler and provides
> better results. It also allow to get rid of clk-audio-divider.
> 
> Off tree sound cards using these clocks should add the following to the
> sound card DT to properly setup the PLLs:
> 
> 	assigned-clocks = <&clkc CLKID_MPLL2>,
> 	                  <&clkc CLKID_MPLL0>,
> 	                  <&clkc CLKID_MPLL1>;
> 	assigned-clock-parents = <0>, <0>, <0>;
> 	assigned-clock-rates = <294912000>,
> 	                       <270950400>,
> 	                       <393216000>;
> 
> * MPLL2: 294912000Hz: 192Khz * 32 * 24 * 2
>   used 24, 48, 96, 192Khz
> 
> * MPLL0: 270950400Hz: 176.4Khz * 32 * 24 * 2
>   used for 5.512, 10.025, 20.05, 44.1, 88.2 and 176,4Khz
> 
> * MPLL1: 393216000Hz: 64Khz * 32 * 24 * 8
>   used for 8, 16, 32 and 64Khz
> 
> Jerome Brunet (2):
>   clk: meson: stop rate propagation for audio clocks
>   clk: meson: remove unused clk-audio-divider driver
> 
>  drivers/clk/meson/Makefile            |   2 +-
>  drivers/clk/meson/clk-audio-divider.c | 110 ----------------------------------
>  drivers/clk/meson/clkc.h              |   7 ---
>  drivers/clk/meson/gxbb.c              |  16 +++--
>  4 files changed, 8 insertions(+), 127 deletions(-)
>  delete mode 100644 drivers/clk/meson/clk-audio-divider.c
> 

Rebased and applied with Neil's ack.
