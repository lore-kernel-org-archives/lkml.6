Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAC0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 926B420868
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="aD13Kdz2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbfAQUDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 15:03:24 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40871 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728494AbfAQUDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 15:03:23 -0500
Received: by mail-pf1-f196.google.com with SMTP id i12so5338928pfo.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 12:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=hIlhBjUpNVmhVeFqkagr6YgEYKL0wp8AtqQdEiDvviA=;
        b=aD13Kdz2grJBnVSGAPgVuYWonzn1LgeA2Y/mmi1YZyVxF3RnXxeLsnTqwCtukb113+
         RaZFtIVNohstxLc+1v0uVmfkJ6t6iV9RzbYUxjiOuxEFLQmIdd9C5Szn1uMMXGnItvsi
         V/zxrmjYomi5yaUWDvBdDQ/tU7x6TcymiIxzhYnaP3SMxRXmK/QalAzBKmbOiASk+Yzu
         rwG+NwWY1NjOX2mxsIwYlZb2NRflyVgS96phoP6HvXMmuWd9Z+aoL/dDkjDAF+Cjto/C
         Ut8U0cih1ppLucimxxzHcjvmvyNsIaDuMsU8+YxZeHExv8vyehaZbq+8SLfWB4GXGqP8
         8TnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=hIlhBjUpNVmhVeFqkagr6YgEYKL0wp8AtqQdEiDvviA=;
        b=ciW8X33vEnlJi4LO48SDAVz1A3l/FnHDctt1IKYxqMCwb0Sjkkh/Sw6nVPqYV7zicS
         CsT4kUXhgH1R8Yz+HCVosef/RnfeOcN3lHcXEuuXiOY2sFBTrWNQy16mte8z3p9q7bIS
         mjcxlzEiLsgWYytOYWBkMF2BWEmYogUHy2Kn4b2/PERJgSMDL3dbxwJImOg3rQFhC5zb
         I9tp2mjQkRBz+bFpyt4IOB/BDdKmhnQFJYPiudqd8pozxfvswZ6uCrjcqE984Cryf++X
         FsAFV+G9pU8vvxIpPaY23zojPBNqkDE9f0uCX21ON2VIMxED0jWC323YDhrA4MnEPF8M
         emfw==
X-Gm-Message-State: AJcUukdbVHPDAzzRd+WVEaeBW03gQTUoMsx7Rx34/KMS2DiOLj5/7OpC
        LysKYggaoVNdkfjmTpZWEXmQBg==
X-Google-Smtp-Source: ALg8bN5vHwVvegLMW8riGwQ5aIJB820UMJaxf1UPeLZIlfWDYTSMw5WKAtjJ9HexCFrpZMfLtc575g==
X-Received: by 2002:a62:1542:: with SMTP id 63mr16368299pfv.230.1547755402881;
        Thu, 17 Jan 2019 12:03:22 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:e076:9fe9:59e2:1e0b])
        by smtp.googlemail.com with ESMTPSA id y5sm3191723pge.49.2019.01.17.12.03.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 12:03:22 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
Subject: Re: [PATCH] arm64: dts: meson: s400: enable sdr104 on sdio
In-Reply-To: <20190116175913.5907-1-jbrunet@baylibre.com>
References: <20190116175913.5907-1-jbrunet@baylibre.com>
Date:   Thu, 17 Jan 2019 12:03:21 -0800
Message-ID: <7htvi7aw6u.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> The bcm wifi/bt device on SDIO support SDR104 and it seems to work
> well following the recent mmc driver update, so enable this
> ultra high speed mode
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Queued for v5.1,

Thanks,

Kevin
