Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15914C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C51D920873
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="09ynGEqh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C51D920873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbeLLVOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 16:14:53 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35274 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbeLLVOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 16:14:52 -0500
Received: by mail-lj1-f196.google.com with SMTP id x85-v6so17613625ljb.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 13:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uBU0ZtbX+J8Oz0EhyXuCXoVaGe3O8alSybyV+RtW7io=;
        b=09ynGEqh4NrTAb9cyVM/T2cdq0VTebI0os3rid0agB21XHaYJvpe//1xdeNWy0ELPP
         Any+ioZYGOt4ymLHhAgFjB9GgRZI24inS+WyZC9s8oH9PHHFHeEdAEZNuWNE0ELa/3XR
         AtKZ9cHzdfXsuRjjEv7kVFkQqR7/vkAQMwbqlxoPaqNBSkA53W9wkt4QPtzLRqKbSxHK
         22n2zTD6CUbGAmxth0KujHZPEggUPy+hrFApKK8eaQMATq3f0xmnEWr4BgZS/DR8DF9x
         sU6U27y6xHLNeFctlVi43QFpLEuNG3QM66NmXj/Jx70JuGKed/GjU8erI6cXku0EV1Ni
         9Z+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uBU0ZtbX+J8Oz0EhyXuCXoVaGe3O8alSybyV+RtW7io=;
        b=PVkXyTYh+gdsF8Na+CUTIf4Ltw0ytZS6XpLmK1jzkZoKkjg3nGH43zdOM6QsoLMQgZ
         ERjBKPAALUATs5IrDg8vhGtyUNuTjQrJwX7fZv9JaFzLNa4lDH8C/jZDW2j0/oR51htX
         j6uJdFImEUIbhMjVuYp1SsskT3jCNSxcOTVY7DIZT5z7VN912qU80b+5yIUUQXxR4UZF
         yhXOB9z7C49Ydb2gpSTWBJmu0drOOMBCijE8qOf6zZneC2PuZIOiL+2/1Ygn2yKJzbRd
         35JlMGXr0Fi4kxvX8kqczkHjV8UjpNHK34kXhuFGTXNFXLJ4SugIemVqFNcL4BKCJmbc
         jqOA==
X-Gm-Message-State: AA+aEWYqm6R4oEx1+v/EihcrwTFbyNkUFsgljMDbH2gbw8hnZbrlv1sE
        n1WilbJeCeCB6yZYFKSWPX9tBw==
X-Google-Smtp-Source: AFSGD/VCn8YCZjXpoP+vYeusq/p/5yr9z3Y9848D3XWqLk6f43NaKS4YbpwfnomiH1WIF9k8zWogfA==
X-Received: by 2002:a05:651c:14e:: with SMTP id c14mr6742766ljd.20.1544649289290;
        Wed, 12 Dec 2018 13:14:49 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id b69sm3474519lfl.28.2018.12.12.13.14.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 13:14:48 -0800 (PST)
Date:   Wed, 12 Dec 2018 12:51:06 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     arm@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [GIT PULL] Qualcomm ARM64 DT updates for 4.21 - Part 2
Message-ID: <20181212205106.op7elifexbn4llpt@localhost>
References: <1544245994-4228-1-git-send-email-andy.gross@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544245994-4228-1-git-send-email-andy.gross@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 11:13:13PM -0600, Andy Gross wrote:
> The following changes since commit 70827d9f6bc4f481fafe790dd6654ba568526768:
> 
>   arm64: dts: qcom: msm8998: Fix compatible of scm node (2018-11-30 07:59:02 -0600)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-for-4.21-2
> 
> for you to fetch changes up to 1504b91c819359b574b55c269c850352260b8d19:
> 
>   arm64: dts: msm8996: Use dwc3-qcom glue driver for USB (2018-12-07 14:10:56 -0600)
> 
> ----------------------------------------------------------------
> Qualcomm ARM64 Updates for v4.21 Part 2
> 
> * Switch to use dwc3-qcom glue driver on MSM8996
> * Fix issue with xo clk name on MSM8998
> * Add cooling maps on MSM8916
> * Add UART nodes on SDM845
> * Add camera subsystem support on MSM8996 and MSM8916

Merged, thanks.


-Olof
