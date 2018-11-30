Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B68C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA56920660
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="YLAMpuqt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA56920660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbeLALIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 06:08:53 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45949 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbeLALIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 06:08:24 -0500
Received: by mail-lf1-f65.google.com with SMTP id b20so5298168lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 15:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lQKM5yXiGSf4lMQEmO7w25LIcorfD4s+FFvHlS1HwgQ=;
        b=YLAMpuqtisgajgnx/KnAPjK/ruX8082ySsAlOh/wzYZkQbJNl6WclFMEEUAtpizVtM
         STD7r64ZlEqNXoCmYJcWOl65yKgBlMtl8hExA7kmfSGrERFkltdtaGr5Z/zRPp6dCLIc
         gsjKya+cpElK2W4D/NIKBFKbDKkwTRK4GfDDy4q1tnbBppW2HOVcHkGi0RRoDTz9MYMt
         al59C4FM/nxVXoSLBKkOX1nJtOsFN+YuRo1hgjnaxYVxQC4Grj4mWqZbE3G6GxvJeNjg
         EXAg5cP9FmX+zS123YRaLrCXDSBou5vYvX3dCA/1DHW5hd1JMOc5OUpn8n/ttTSsN2/q
         i3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lQKM5yXiGSf4lMQEmO7w25LIcorfD4s+FFvHlS1HwgQ=;
        b=SXUj0j14XoGE7TfOabXLygfFDSExTgejt+O2rK1QuA5zqmhKcyXK0IiaQ/R8LmmYXE
         WA5HOqhA8MnMiZxF9+QaVO3cCy4+gGWnVYo1rnRnS50sMFqZT+jnjZAzy9vOt04+50r2
         BQ+CWv3YRsEkecsp7xEMaqE7sziCD1MPH5YRmhmDkQXtkg8rg0Wx+xOrm0JDvMZFe4/D
         4Vkak8spF1cZFO2oahHPrjsSav7H+PYTM7JVjlFEcxgJOLC7NzgM08+rLLUf2CpEm1U4
         ilm3Sdn6E2QHatxTdUxAtV+x2sNC/0pY1iauziTH8c2t5hG8Q6QIXWl9erUjVHFL0+t2
         PZhA==
X-Gm-Message-State: AA+aEWa9YieQJs1KkW9T0LUquyhub3RNNM8rIDELNZAPQrkju/4x4SJ5
        gZRxVP5ZCOX6MThakqyapfQccw==
X-Google-Smtp-Source: AFSGD/XDvMIxsMADCdpnBXvY4qilKJNeiowM4OEi/H9HYtuWtlBRtWRG9iJq9Afd4Om9TX9AvuVZaA==
X-Received: by 2002:a19:d242:: with SMTP id j63mr5076300lfg.26.1543622239609;
        Fri, 30 Nov 2018 15:57:19 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id b17sm1054424lfc.21.2018.11.30.15.57.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 15:57:18 -0800 (PST)
Date:   Fri, 30 Nov 2018 15:44:24 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     lkundrak@v3.sk, arm-soc <arm@kernel.org>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Pavel Machek <pavel@ucw.cz>, quozl@laptop.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/20] MMP platform fixes
Message-ID: <20181130234424.vx5y46wqvziywbk2@localhost>
References: <20181128175324.163202-1-lkundrak@v3.sk>
 <CAK8P3a0jN1PBy1oKHrx5abX4OKHVxjgevbUcXbUDPbU+VdvUPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0jN1PBy1oKHrx5abX4OKHVxjgevbUcXbUDPbU+VdvUPg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 28, 2018 at 10:39:06PM +0100, Arnd Bergmann wrote:
> On Wed, Nov 28, 2018 at 6:53 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
> >
> > Hi,
> >
> > this series contains contains a bunch of MMP2 platform fixes.
> >
> > Previous spins of the patch set were sent out over the course of last
> > three months to the MMP platform maintainers, with Arnd and
> > linux-arm-kernel@lists.infradead.org on copy.
> >
> > Unfortunatelly, MMP maintainers (Eric Miao and Haojian Zhuang) don't
> > seem to respond anymore. That's a shame, because the MMP2 support seems to
> > in need for some love. The DT/multiplatform kernels can't even boot without
> > 14/20, 15/20 and perhaps more.
> >
> > I'm wondering if this cat gen in via the arm-soc tree? Would it be
> > appropriate if I followed up with a MAINTAINERS update in that case?
> 
> Yes, sounds good to me. I looked through the series again, and
> found one patch that seems wrong to me. Everything else should
> just go in.

I've applied the DT patches and the ones that touch only arch/arm/mach-*.
There are a few driver patches here that should be reviewed/acked by the
corresponding maintainers as well, so I didn't apply most of them yet.

> > The patch set has been tested on an OLPC XO-1.75 laptop.
> 
> Excellent!

OOooh, I have one of those... somewhere.


-Olof
