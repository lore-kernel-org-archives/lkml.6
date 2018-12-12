Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFA9C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C408C20851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="olILnwti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C408C20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbeLLWQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 17:16:30 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33706 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbeLLWQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 17:16:29 -0500
Received: by mail-lj1-f196.google.com with SMTP id v1-v6so28957ljd.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 14:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bwP1nicwuZKsjMYpzwflT/kUMeqSpqvcgoPpmj5aZ78=;
        b=olILnwti3VlSInWp2LcxTQkC9p8I2iCDcArkbcE3ZO0LVP8uUPDhm81OGhsYpVAipR
         b7d9ZvN6R0JnKbVWxtbGXSIZbTBEsxGisKfmxJGd6NSUBZSN861c2IeRASDl7y7CuemT
         Bbv0hgRtMIqjKta2VKsVdRKok2Fo0KtT6tKaTjA9XLoW+PPx13iVZto3zVZ5HGYUGyK9
         Bi0Fo97r80FSXe1wnZzcA/1pkH/VTKKgVmkqXN5tl+AYLF2AvtIcq1e8vwvCbyLWmrZN
         JkTV24NVOEWuzp2PWVghL32fsgbqHAvHfH2qiLG8VSgh8MMJZ9pSTWG49xXecuJWUzzu
         TNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bwP1nicwuZKsjMYpzwflT/kUMeqSpqvcgoPpmj5aZ78=;
        b=Hdd75tkb/gtLzMgJlfmckLG49NyiVbmlWu4Pn+hV/fHrgCv8tLfrZk84ed/8sM2CI3
         wLs2paYd50owmpUudOwWC6h0MXEAHn/YH2EES1roFM9+HjHT8r8rQ9W1qG/ramG3S4iN
         9PnU+4lNlY5/J+Qh8Pc/HghdaMViuRYbQTKRWHBJ8Cz5ptUcdx9dmwIcjTUs7p6BpjEu
         oRzHWCJ/IY5lXboyZpGQVN5zg4C7nrXGXxQ/CqLvvq/m2dskhY7at+FXEk0vHzJKBLDs
         hljxf2PgNCiJ9LcovIVdGsN2zWVGhfswFl7w0lCTGzfuorSk7MSD+I0iGgUouDAzBExm
         WXZA==
X-Gm-Message-State: AA+aEWYtQWYKgWoCCEtSmCt5VgAxpruET13kRjl/MOpo2tLfUk3oLZ5c
        mPESRyChX0sUjbyC86w11vGrIw==
X-Google-Smtp-Source: AFSGD/XFG4dRRVSi8NBvVOuxo9F3Y1Uax2xs1cngKBf8tWA57PnnS/492AsyWhkAZa/1tFz1ustJ8w==
X-Received: by 2002:a2e:5054:: with SMTP id v20-v6mr13171829ljd.45.1544652986859;
        Wed, 12 Dec 2018 14:16:26 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id p19-v6sm1913ljb.47.2018.12.12.14.16.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 14:16:25 -0800 (PST)
Date:   Wed, 12 Dec 2018 13:47:06 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 1/4] ARM: defconfig: Exynos for v4.21
Message-ID: <20181212214706.tvxl7iojz5fvlemv@localhost>
References: <20181209114911.25194-1-krzk@kernel.org>
 <20181209114911.25194-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181209114911.25194-2-krzk@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09, 2018 at 12:49:08PM +0100, Krzysztof Kozlowski wrote:
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-defconfig-4.21
> 
> for you to fetch changes up to 24c8e4b85399b00f4ae96e7957b0eeaa374e9380:
> 
>   ARM: multi_v7_defconfig: Add TOSHIBA TC358764 bridge driver (2018-12-07 20:18:47 +0100)
> 
> ----------------------------------------------------------------
> Samsung defconfig changes for v4.21
> 
> Enable drivers in exynos and multi_v7 defconfigs for MAX8952, MAX8998
> (Samsung UniversalC210 board) and TC358764 (Arndale board).

Merged, thanks!


-Olof
