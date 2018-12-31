Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F21C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EF5921720
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="s0oTUVTd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbeLaVey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 16:34:54 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44489 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728107AbeLaVew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 16:34:52 -0500
Received: by mail-lj1-f195.google.com with SMTP id k19-v6so24277674lji.11
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 13:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6lLcK8xprX6a7/hE9IcLFZK8c7AsFCfb5lOkKsasDws=;
        b=s0oTUVTdvwLVhCGnhUD8UIcV86XqWiJD1aouCZxnqJGk4UdL1Z5SmIesvu5c+8M0/D
         g69Ssmt9p5PnOfcYnLjl9PXBfzzPm/L7sIk86e1ifBeo75q3hJTzHfYuPTR4Rshxqy3m
         eVOldIUdlEgxDS2ZK7Ozuj4iT3vlOrOd4JJekXfS9B2kUC398vMb72pb1Mgmv/3y09q/
         Ysj6Fu2pwpI8zaLT/vg7DDxKSCI8wR3FwN6vgdTnJmz8RdaQC96EjzvdbaN79Jnrq0ea
         JqLKTcDIXiC5og8e1Uy/8cSpUTqtnMBXLLj2QHgooArMp92iqbjl6I7VRzJ2if8iWScf
         B5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6lLcK8xprX6a7/hE9IcLFZK8c7AsFCfb5lOkKsasDws=;
        b=CMDdB6Q/1UH4AC9ZKsFWZtywI7DpEmUHjsd6F3Ej4R7pFgVyaLIVltvAHPVhHnFPqd
         e64i+lizjjLK9Cc0f8VUTLmDQI4hVobaJfQlXOp04PQryzybNwt1GmIDdDWEMPMIn0tr
         zuBT82miKaNbUtzMTQ88CWTHJvq9VQJZGvF+iAf6tooG1hi2y9YuWtMhG2ZsvKX2aLki
         FW4cUGtHmN9sI20C6OfZ+8a77zdd6Zoo/oTZ9NfVUZVsb7AsXPIZqmJip/yCTTn4MFpH
         0vJljkVRUkgPKDtv9fK8IZ7K8myRgYaM5x0DioBKigAchPs4CuCyywb1bpoUue88pic0
         2cKQ==
X-Gm-Message-State: AJcUukc6mTuMZ3p6t/NToXkxnGOFJydLC6gj/aTd00Ig1/OYWvFrBreb
        Xl267NR0ZKaumX95IbgRD+B/fg==
X-Google-Smtp-Source: ALg8bN7aXNZ0eQGDqM4H3o3kTT3TGzjPJfW6nZd/rPPn0UyYc2fRML6eGbCybJ3QU4ncAFt6afU18g==
X-Received: by 2002:a2e:2d4:: with SMTP id y81-v6mr22109373lje.62.1546292090298;
        Mon, 31 Dec 2018 13:34:50 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id b17-v6sm10423335ljj.93.2018.12.31.13.34.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 31 Dec 2018 13:34:49 -0800 (PST)
Date:   Mon, 31 Dec 2018 13:11:22 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 2/2] arm64: dts: exynos: Second round for v4.21
Message-ID: <20181231211122.7itlvetzx3tpuua6@localhost>
References: <20181218201003.12806-1-krzk@kernel.org>
 <20181218201003.12806-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218201003.12806-2-krzk@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 09:10:03PM +0100, Krzysztof Kozlowski wrote:
> Hi,
> 
> On top of previous pull request.
> 
> Best regards,
> Krzysztof
> 
> 
> The following changes since commit 9deffb5ee78e41e2a5d6c448874a24caec6467d0:
> 
>   arm64: dts: exynos: Add all CPUs in cooling maps (2018-11-18 15:18:42 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-4.21-2
> 
> for you to fetch changes up to 74ebbdda7cecf789661c208faccbeef10a7f05da:
> 
>   arm64: dts: exynos: Add Bluetooth chip to TM2(e) boards (2018-12-17 20:23:32 +0100)

Merged into next/late.


Thanks,

-Olof
