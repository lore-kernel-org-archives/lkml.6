Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9B7C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3361920851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zXrbRjyW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3361920851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbeLKSNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 13:13:00 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36409 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbeLKSM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 13:12:59 -0500
Received: by mail-pl1-f196.google.com with SMTP id g9so7288471plo.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 10:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=pT2whDOmBW/Okp7OjEGSRsFNRFC0UEQR4Gv61kcBsns=;
        b=zXrbRjyWsLwaMEUKrTMpnGKkHiecDb1b44rg8zMenwgaCmtwJeuXUiGcUvQ+OB4OZV
         ZbwOIVIfgbPPHkRXX92CtQpUTEP1X/2RA8+jydDtdX3fDIgfwD4xvkQJNOrkOZy3n/7K
         00azzdax/53RSnxmi0vjy4wefttUOJeGi42dY7YwIG1rUQJ/g/8YjXcaIAT7/OtRS3vZ
         1j0q7bQeIXq8UZvUaiHZkNBvoKgpV4XpoR2cgT07jmnEaznzeMFmNCtGVz3jgsny0lDE
         blpAMvKja21q47bEqnMiGRcB7NS5oE3A3G57hbYshRLRdmKp6bq7LyE3x/gMwvtOsX6D
         FOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=pT2whDOmBW/Okp7OjEGSRsFNRFC0UEQR4Gv61kcBsns=;
        b=enpBO5lzTU5tjr+SViCwT5bF4+v0FeCa1x6KiuajgBd99gjwuVGZM70UgQm9SY0J/J
         T3NrefD02J3esXjgR7ya21+pF2xUGZ8ot+NZvRS5to+3JIup6p11sGfpt5N2IU0OAxDF
         SnntupLHBXPaSJaPsJe6wKz0OOPZGXMNJO/BpekF72F6sy01l6GOkltEGS5A88OXt+NP
         BFae4lf5IP/ZTAHtP5NvzB3olojXpaSeyLi0GnlRgRfcNaTswEujCtJVvIC7A8oAQDPA
         Dru+LF6LK6L1loN03r2nXo4cEO0wX7hixLOlNMhYj88f4gOD8dsB3gBvzy7VfPOA+nmo
         xmQw==
X-Gm-Message-State: AA+aEWYj1n3eGgsBt90fajibCZvB3stT5eji4OpZpxEhdRK0gJ6Bs2bm
        OgCLLxymam22Nb7AnKLW+406XQ==
X-Google-Smtp-Source: AFSGD/XAwhD8if9V+9G0iZ73WSXdZcEO8xOoEVTvVllOTltGPS9aDxLI42qna+5CzPxEKckNrAqGtA==
X-Received: by 2002:a17:902:8f83:: with SMTP id z3mr16471574plo.328.1544551978831;
        Tue, 11 Dec 2018 10:12:58 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id 84sm33973130pfk.134.2018.12.11.10.12.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 10:12:57 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        Kevin Hilman <khilman@kernel.org>,
        Tony Lindgren <tony@atomide.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Dave Gerlach <d-gerlach@ti.com>,
        Keerthy <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] ARM: omap2: avoid section mismatch warning
In-Reply-To: <20181210215856.2238253-1-arnd@arndb.de>
References: <20181210215856.2238253-1-arnd@arndb.de>
Date:   Tue, 11 Dec 2018 10:12:57 -0800
Message-ID: <7h1s6oue3a.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> WARNING: vmlinux.o(.text+0x27530): Section mismatch in reference from the function am43xx_suspend_init() to the function .init.text:am43xx_map_scu()
> The function am43xx_suspend_init() references
> the function __init am43xx_map_scu().
> This is often because am43xx_suspend_init lacks a __init
> annotation or the annotation of am43xx_map_scu is wrong.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
