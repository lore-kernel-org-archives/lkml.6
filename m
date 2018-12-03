Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2E3C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D1A20850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="TB5zV8Pl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40D1A20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbeLCVRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:17:06 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33012 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeLCVRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 16:17:05 -0500
Received: by mail-lj1-f193.google.com with SMTP id v1-v6so12833980ljd.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 13:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8loA5B9sISBo1TgumK+JeKTngqGfXbNi43zNTUj0UNc=;
        b=TB5zV8Pl4UBjfI8+RknyrGQgSMbiK0vHKPgOJwDjL+zsAifjgPt3O8VJXVI+JttV/E
         giBoMNE9amTQ/50eM6TkVueEmBcXLBBchlShN2Zcxnponv/wf5MgwCd7fowGBN0jLAaU
         cxZDNfdDhE8DcV9deKL2LsfByuLCuD9UP+0C28TLmhMHuecQKVqatQr7m1W1spF7vPs1
         R9kDEfJaQ4dW3pU2+i8hPEjVwgr6hHtrinuZH/euoz8sgUFi9ieT90smfWJVwkXNZQYk
         6gNxHianwdbC98a5whTaZLTW8Oel+TEMIK4K2SmkrxfeBuQ59jr5+QjRXmNuplYI5lob
         FfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8loA5B9sISBo1TgumK+JeKTngqGfXbNi43zNTUj0UNc=;
        b=dNwZIov+jwQG312AYnRt3eixe6tm/JgYLm7buikzVtmxfyo3BxkJh40gwy9gSZTnNl
         38a0Vn6/iWK+RpkrwU1no7eq6/S1KNd+4yjfswsCJoil5cTre23UWDl1VPsG/bpu8Jna
         PoKxItroRAfGdNZpMx+5GDa7qQ9CxDo54Hza7U3p5KdHvj6yrZpAkwEj1zO2AHNVCZTh
         pXaiPmSY9kUVbqMYwp3nBjGevMWQH2lnLZ4JdA/8iuLUuLXxJGkty8JyrIJ4zVpEbBSJ
         rI2cZuQtFua0oBnwhU3SA9NqPX4YN+u80Dol7Vlk+MBve/WxP04M2TVRBw+Md8by9erK
         KMNw==
X-Gm-Message-State: AA+aEWY3H4M5bQHf7Zi6MgGtkvUwh7zG8Jy8Iikd+4U/SewQbBoT4tz9
        7Az9Zi8p5aQ3UYrGNcUGnN7JBw==
X-Google-Smtp-Source: AFSGD/UTdfCdAIeAODgn1aEsMGfBY69HZUGGqVjXjtPwSfiVUfv7IdswfG55HiZQyX6roOHkpNQInQ==
X-Received: by 2002:a2e:9957:: with SMTP id r23-v6mr10625397ljj.98.1543871823593;
        Mon, 03 Dec 2018 13:17:03 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id q11sm2540422lfc.92.2018.12.03.13.17.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 13:17:02 -0800 (PST)
Date:   Mon, 3 Dec 2018 12:55:27 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     arm-soc <arm@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, James Cameron <quozl@laptop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: mmp2: DT: be compatible with mrvl,mmp2
Message-ID: <20181203205527.dchun3lac5pc3c63@localhost>
References: <20181202113848.2763-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181202113848.2763-1-lkundrak@v3.sk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 02, 2018 at 12:38:48PM +0100, Lubomir Rintel wrote:
> There are more boards that can work with mmp2-dt than just Brownstone.
> The OLPC XO-1.75 device tree root is compatible with "mrvl,mmp2" only.
> 
> The "mrvl,mmp2-brownstone" string is safe to remove: the Brownstone
> device tree contains the "mrvl,mmp2" compatible string too.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Applied to next/dt. Thanks!


-Olof
