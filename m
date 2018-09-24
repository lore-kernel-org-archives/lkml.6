Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCEAECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4886C20989
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="1HiMlKX7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4886C20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbeIXPzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 11:55:12 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45567 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbeIXPzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 11:55:12 -0400
Received: by mail-lj1-f194.google.com with SMTP id x16-v6so11191004ljd.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 02:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yu0mDz6OGYXcQJKG1HbQ7Ywzq+ByLvivtrx+JoNOxDY=;
        b=1HiMlKX7wjdac/JJPBhKqyzlW1Pj2r5kF9NXy96VMPfYXAEmFR4g80+ve16CrLAmUm
         2F/qSaJXiw7PNkO4RWBEgL7vvF8bvUEY04LDwD4GzRVQfsMT/OUfMiIk4mTkc4Z8PVPB
         zQG//gw57r2eL3HBZDj0hug120gdMc5UWxmsk3ZT0wP7uVgOamkSsM49LeoZ2RYqrf8v
         j5jG4JHb0gu9NmqYS9ksDqLQdMzqcRTbBkjnP+GBDulLnfypBAeFV9nywXF9o5NP1Sgc
         LrieGAyhzSpyqcB1JnRx0BfuvUjWuqPrmgbMfst3602aAuiYET5q5ISgHD9vRDgUQIKT
         TTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yu0mDz6OGYXcQJKG1HbQ7Ywzq+ByLvivtrx+JoNOxDY=;
        b=DjBT+0i248ERykNvgqglP4VhATTAl9gHSv6vVm6tR5fMtM+h0YyEzwYoV69j42LwEd
         nd/3JcsonfmOZROh09UXQIrST7kl9IIvfkZ7GpvUO5larAUfTTjx9tzgLpJ4lbLULS8z
         fcMj1TrFPeysHtRw/Lsxl+cKiUREBenhMF7GH6kf+pJ9lJeGYL/AwBaa3KNJ5r07OiEI
         7L+WX46DPO7sB4ImdTTma1tS9hlH4UOWyQOUmY7XVzIZyUY9eT73l2KAYrRNv91J2pQB
         /zjUBRnRqjqVTEjZIKlflBuV0FcxDNtRoFiN+OQl+abDtnMBl1kR32X6BaMKlNgyGEti
         y4yA==
X-Gm-Message-State: ABuFfojs4/chxmGISzn+VF0dvNQMTiueFAbDOqNIgZzeSsg6H6/5DXjC
        QTWvmIVxOmKaZlc0nTKmGZUsuQ==
X-Google-Smtp-Source: ANB0VdYg4JDdpo0q9jPko9zAVid5Bne9Fyb9shEAWmMf4fr1+svUgpoF+MmK1Fbpz/fQcjp2KcI3Yg==
X-Received: by 2002:a2e:4557:: with SMTP id s84-v6mr9723977lja.47.1537782836229;
        Mon, 24 Sep 2018 02:53:56 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id u24-v6sm6400446lji.4.2018.09.24.02.53.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 02:53:54 -0700 (PDT)
Date:   Mon, 24 Sep 2018 02:53:32 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        jason@lakedaemon.net, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com, linux@armlinux.org.uk,
        ylefloch@online.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] ARM: mvebu: use dt_fixup to provide fallback for
 enable-method
Message-ID: <20180924095332.lrfobc5dhxahm6g5@localhost>
References: <20180726034856.20743-1-chris.packham@alliedtelesis.co.nz>
 <8736u3jhc3.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8736u3jhc3.fsf@bootlin.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 12:05:48PM +0200, Gregory CLEMENT wrote:
> Hi Chris,
>  
>  On jeu., juil. 26 2018, Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:
> 
> > We need to maintain backwards compatibility with device trees that don't
> > define an enable method. At the same time we want the device tree to be
> > able to specify an enable-method and have it stick.
> >
> > Previously by having smp assigned in the DT_MACHINE definition this
> > would be picked up by setup_arch() and override whatever
> > arm_dt_init_cpu_maps() had configured. Now we move the initial
> > assignment of default smp_ops to a dt_fixup and let
> > arm_dt_init_cpu_maps() override that if the device tree defines an
> > enable-method.
> >
> > Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> 
> I made several tests on an Armada XP based board: OpenBlock AX3: I
> modify the enable-method in the decvice tree, and I confirm that without
> your patch it is not taken into account whereas with this patch the
> enable-method is applied form the device tree. I also didn't see any
> regression with the original dtb.
> 
> So I added my:
> Tested-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> 
> and applied on mvebu/soc

Hi,

Looks like this broke non-SMP. Not a huge deal, but please apply this as
closely as possible on top of the previous patch (or squash it in).


- 8< - 8< - 8< - 8< - 8< - 8< - 8< - 8< - 8< - 8< - 8< - 8< - 8< - 8< -



From 3190d9502607995c7aecce79beec36714574d494 Mon Sep 17 00:00:00 2001
From: Olof Johansson <olof@lixom.net>
Date: Mon, 24 Sep 2018 02:37:31 -0700
Subject: [PATCH] ARM: mvebu: fix !SMP build

Wrap set_smp_ops() in CONFIG_SMP.

Fixes: d6ec59de9a0a8 ("ARM: mvebu: use dt_fixup to provide fallback for enable-method")
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-mvebu/board-v7.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index 5bbde5e..0b10acd 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -147,7 +147,9 @@ static void __init mvebu_dt_init(void)
 
 static void __init armada_370_xp_dt_fixup(void)
 {
+#ifdef CONFIG_SMP
 	smp_set_ops(smp_ops(armada_xp_smp_ops));
+#endif
 }
 
 static const char * const armada_370_xp_dt_compat[] __initconst = {
-- 
2.8.6

