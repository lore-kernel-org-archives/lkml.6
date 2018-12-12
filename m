Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721EAC67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 368AA20870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="PV2WW8Ox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 368AA20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbeLLWRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 17:17:07 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46243 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbeLLWRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 17:17:04 -0500
Received: by mail-lj1-f195.google.com with SMTP id v15-v6so17669189ljh.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 14:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Fu+rlcVKij1eE1U6dtMPJ8S7J2eje5tMdNABI/Ki/SE=;
        b=PV2WW8OxjvSyx89dHcJKC0/+rAezcX28SrNzndPmQ0q4EFi7aHXOzvmRgJlokw3/wL
         sW0T0s5P1aLbbmQZ1dVDoaJpX70o56pGqKUNukAhlLUwmnqn62u9LmXjwHCHAbhk/4a+
         Lv2eOGJRQi57SuLQ79uwY1f3P1G8+fwYpUa0AKOU01fe4TTnqR3+KUbrJYj0TMHskyuB
         U+gtN7o3f+XZajs7K7c4XhMhYRbVr8djND5wf4PXOQoAfi8CQiKVII08TwWjkrx4c3e6
         7AmX2rDoLhvLlVYVvtbx8dZBxXiFDBwzECqppoNKOXhUNjg6+44NUY1vcPThN+UrWF4g
         DLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fu+rlcVKij1eE1U6dtMPJ8S7J2eje5tMdNABI/Ki/SE=;
        b=B3S7pyvd0+3YFwcUXLSOcdAYfzsSE4jwn4T3Txm9gJnKAYiKNt5vZfNIpwcCYrGSmN
         KAJRya80IKPleNwsC+HzgrV5VGgXs8/tUTQlhvu677Cue0lwsmplskCczjonqV4Gfl64
         fqkeBkmm6lZnyEp2qmWUA0gtBXP6JZTDjK1HPDRC6vf6Y7/z1yBXG+sIosNU3D/Wg+Ti
         WwngxSx4HvzlPVKkzmgPytykJaZmjozplgzbo2+rnyVcDpzXuGxJ+vcahbi94y8P9ycK
         8C3TT/f7X9mr/AG0FO57jiYqJ4guQi7WmcpD+KK+0Ll2oFWspBs88oy8RN8xorni519w
         XGoQ==
X-Gm-Message-State: AA+aEWaZAON3KNnAwknPVLUsJjy9L5t5lM2dMVloXxtOInarjekd94JB
        x/y1PgsjuCHJ/nQn3qIKCrbBQg==
X-Google-Smtp-Source: AFSGD/VBu2gIgFeI47xRpsJHXPx03lssDwEw3XewMqTeYCVwsFLdUJIPxAFY0JNjjRXiy37FTO9VBQ==
X-Received: by 2002:a2e:4a19:: with SMTP id x25-v6mr12839540lja.19.1544653022335;
        Wed, 12 Dec 2018 14:17:02 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id d190sm6701lfe.9.2018.12.12.14.17.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 14:17:01 -0800 (PST)
Date:   Wed, 12 Dec 2018 13:57:41 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm-soc <arm@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] ARM: tegra: avoid section mismatch warning
Message-ID: <20181212215741.uvkbvf5cvcvvod42@localhost>
References: <20181210215856.2238253-1-arnd@arndb.de>
 <20181210215856.2238253-2-arnd@arndb.de>
 <20181211100550.GD14426@ulmo>
 <CAK8P3a1zbmYMFZB8R+rs=vdJY=KNqgRPBCQNO91LcSSTR0O03Q@mail.gmail.com>
 <20181211102856.GI14426@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211102856.GI14426@ulmo>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 11:28:56AM +0100, Thierry Reding wrote:
> On Tue, Dec 11, 2018 at 11:08:53AM +0100, Arnd Bergmann wrote:
> > On Tue, Dec 11, 2018 at 11:05 AM Thierry Reding
> > <thierry.reding@gmail.com> wrote:
> > >
> > > On Mon, Dec 10, 2018 at 10:58:37PM +0100, Arnd Bergmann wrote:
> > > > WARNING: vmlinux.o(.text+0x39ecc): Section mismatch in reference from the function tegra114_gic_cpu_pm_registration() to the (unknown reference) .init.rodata:(unknown)
> > > > The function tegra114_gic_cpu_pm_registration() references
> > > > the (unknown reference) __initconst (unknown).
> > > > This is often because tegra114_gic_cpu_pm_registration lacks a __initconst
> > > > annotation or the annotation of (unknown) is wrong.
> > > >
> > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > > ---
> > > >  arch/arm/mach-tegra/irq.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > I'm not seeing these. Do I need to enable any special options to trigger
> > > these? Or are these just so new that I haven't run into them yet?
> > 
> > My guess would be that this is a result of the CONFIG_NO_AUTO_INLINE
> > option that is now available in linux-next.
> 
> Okay, that would explain. It's not set in my configurations currently.
> 
> Do you want to apply this to ARM-SoC directly with my Acked-by, or
> should I queue it up for v4.22?

I'm picking up a few others of these, so I'll include it in that batch.

Applied to arm-soc next/soc.


Thanks!


-Olof

