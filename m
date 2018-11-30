Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7441AC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3826320660
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="1iDIb8DV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3826320660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbeLALIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 06:08:20 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34519 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbeLALIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 06:08:19 -0500
Received: by mail-lf1-f68.google.com with SMTP id p6so5337677lfc.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 15:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dhyFZxjm+qrU3kTFxwVNuC9ciy5QCHeSf2aApRloaKE=;
        b=1iDIb8DVJSx2VjupcwxK0GZb802ShEHPzT5AKJJhe7JjXLoT5ev0VZhd5qNJZv6Ypl
         CH97hkJzmQ8bK/t3thGAV9a7lJyIsasJ/6WqKU/9JYOXdoyDom0q1QqFwR1mhAf/iDQ/
         EM0zjf0rtrR09R/C/T/XP6jSzEnI3W8xwSxCrZRbI7ITvGvtPEFiNOaprxVcQgukM0Ht
         WoWNhO9Kt7U7iuG8R1LyDYtNpUwQv8dLubJQGPmlfi3iL7Y2slO5uKAkoxFo7DEVbd7P
         0ojC+4VMahZMgUhmSaeG3pAPYtRplFPjF3hYG+h8HGeu4HjGml6KIm1mCk+wIAe6o/LO
         DqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dhyFZxjm+qrU3kTFxwVNuC9ciy5QCHeSf2aApRloaKE=;
        b=nNEy/otXV+I9rtsKUhiHVmVs/GPNqSYqTW2Tw8DS2awRuMsPOnFekp4wFf5TFzZQ9V
         iqdAsQszedVkTbftZpq0Mc549jz4CcXF0+6XBHhvqxZ92yzH3dvmtqYtcNuD/tcQ6F4n
         4sKdcTvZxXvpnUZZ2SQCWQx0N8JtPxN/JnQT6LzSBJdSRgDsOgFOegBMRugp5ba7Tcy3
         gEeZThcHu+S0odQGaCZ62L/v9HSK9GniKeNm7C9vLAwo4nZfmoSpXmfIovdAVJLpViOh
         vnVw0czGZ+RnzwHnGdYr6xALU2BIq0t0WeTDt1/98+UsJy/B1OP/hzMUACdvlXMGg0Fk
         V12Q==
X-Gm-Message-State: AA+aEWaoWwg1fVY1Gfcyw5DzCqlKECTJJHnCrU9YD8i1xzhgPS5JIBCH
        hW8L2GhO1+ThhtPjtMh8avBg0OGGaG3dnQ==
X-Google-Smtp-Source: AFSGD/WValPcBdgoCflTY1N6N8hYK3VKt7tT1WaIcyMbkpcOSEb68JnVd8XsBlwzLb8204ucVaBajg==
X-Received: by 2002:a19:d70f:: with SMTP id o15mr4891031lfg.134.1543622235062;
        Fri, 30 Nov 2018 15:57:15 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id b22sm1040464lfg.32.2018.11.30.15.57.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 15:57:14 -0800 (PST)
Date:   Fri, 30 Nov 2018 15:42:05 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     arm@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Pavel Machek <pavel@ucw.cz>, James Cameron <quozl@laptop.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 19/20] USB: phy-mv-usb: use phy-pxa-usb
Message-ID: <20181130234205.nejqtrsvwtocpq2t@localhost>
References: <20181128175324.163202-1-lkundrak@v3.sk>
 <20181128175324.163202-20-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128175324.163202-20-lkundrak@v3.sk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 06:53:23PM +0100, Lubomir Rintel wrote:
> Use a proper PHY driver, instead of hooks to a board support package.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Tested-by: Pavel Machek <pavel@ucw.cz>

These should have an ack from the USB PHY maintainer before we apply them.
I don't see him cc:d on these patches though (Felipe)?


-Olof
