Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFE3C67872
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5960D2080F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="ZdsqXMa5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5960D2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbeLMGvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 01:51:50 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35922 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbeLMGvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 01:51:47 -0500
Received: by mail-lj1-f196.google.com with SMTP id g11-v6so799584ljk.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 22:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O7gdbVA269HOE3Wf1R3qu159FiwaixM6OJOLHRAtKsA=;
        b=ZdsqXMa5Wl5e7hIP+GqqOJFUsvhsFWX80S5sC5EJYHFZpRUjXgVWd5Wc2KpTRrWTAt
         GWhnvStyn7POns5BiOFLOpzm1uZNhXn0xkpgSg7gKgQjPmnyhb+ucspFXSSNyQhH53Hn
         sqjuluYXSffgHQuA37RyffmNfh2nHckFA870/Drd6UFrIZxQLta7tBdgRerBbDOtATSc
         /1PWYITGc8azXOcAbobf2KYReuhpTvv7RpV7+Xkmi0/48cB66Rx6nAgafJUxViwabYBU
         pHKZdT/v2PTWWXPGPy4KzV/ny8Vq0Wr1w5o2sryG4gcTdADfsFiuDO968JnlJ5qfLYMb
         A9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O7gdbVA269HOE3Wf1R3qu159FiwaixM6OJOLHRAtKsA=;
        b=as0BSszAh7jfSykE7/UWRJxcYAZTcaHumM8t8+8chDTgUjbvfVSHJGWhP9cG8dLoJU
         a3h9JdVacsYFCk7sYcDx9b8JJIHGsdYz9/EN/NvcQ0li+TDumEkor13J+mOKOhk9GIKy
         tzXMKWPLiUYqtfPBincN3H6va77+2Lh3hljwjJOGzEiMLrSECCvqdX2biBVBkYghV5rB
         2Mh093LYESIl4IDHHn2ifiSnIQ621e5kMLq4z6dK3f8VtgMewl6ZrD2ZNr2cQHnSIzaT
         yfq6DM8LZ2Xn85B7GYa6vVod1H2NXNBvyif/po4hg72NjkF9N7oE47z3Ao6T4ZZGSP4i
         l2qw==
X-Gm-Message-State: AA+aEWaj3FIN7mFNf1SVWLjbI+ca28UOQ962RzRWn2NN1g9SxoZ8kku9
        qTvUyxoh6LULfdLdHnXuttcOPA==
X-Google-Smtp-Source: AFSGD/W4pIXTG/eKWM+tMGPqcBZpWzHhrbfqL7JljT666tcMJHFyRcLSBTmGpoXMl4d6IvRXGh3e0g==
X-Received: by 2002:a2e:8007:: with SMTP id j7-v6mr14093866ljg.22.1544683905475;
        Wed, 12 Dec 2018 22:51:45 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id i75sm176942lfb.58.2018.12.12.22.51.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 22:51:44 -0800 (PST)
Date:   Wed, 12 Dec 2018 22:50:25 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 9/9] arm64: defconfig: Drop redundant sound codec
 options
Message-ID: <20181213065025.3j5gximuyormpbct@localhost>
References: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
 <a285bc62-bfaa-d53a-129b-165df255b3ed@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a285bc62-bfaa-d53a-129b-165df255b3ed@free.fr>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 02:08:41AM +0100, Marc Gonzalez wrote:
> SND_SOC_RK3399_GRU_SOUND selects SND_SOC_DA7219, SND_SOC_MAX98357A,
> SND_SOC_RT5514, SND_SOC_RT5514_SPI.
> 
> SND_SOC_ROCKCHIP_RT5645 selects SND_SOC_RT5645.
> 
> SND_SOC_RL6231 is pulled in for SND_SOC_RT5514 and SND_SOC_RT5645.
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---
>  arch/arm64/configs/defconfig | 6 ------
>  1 file changed, 6 deletions(-)

Also covered by patch 1.


-Olof
