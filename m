Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8FCC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE1E020843
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="cyCjP75Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE1E020843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730614AbeKCD5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:57:21 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39347 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729393AbeKCD5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:57:20 -0400
Received: by mail-lj1-f196.google.com with SMTP id a28-v6so2604829ljd.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 11:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VyQl4W0hSMIUAwi4tEGKqvFqiP6q7C0NVzk/i90nmS8=;
        b=cyCjP75QEwe9G05pbdfmdDDSlKpD1BmWumXmW6M7HEp3F6s2umDnU5Sbc7olVuChLr
         vOwnSS87viDky3qJHe0TBWs/9p07eOxj9XYSvn8g4K1lpCcDs4yl9CmWrnQ27P0888tg
         oC1Qo3ygT+ni7pseHRDOIdQgCHYlSLYJ1Qi/wiFdznhNkMiYOrr/vujWrbE4YKQnXAK7
         OfE6QChbljQggIJUj7VWytED70q0DwT6hnQNn0pGwKYLu5+0gzR/GO0CEp9gMxJviQfj
         EcD6ye+y8WLHqZQluZ6YqC8aJtnSI9DsinQev/lXIkpb6VT3sssb2EovT179ZR/UyrM+
         y4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VyQl4W0hSMIUAwi4tEGKqvFqiP6q7C0NVzk/i90nmS8=;
        b=HBcuEap6wmz7pgANymn0nKnrs3BnlSxgVDNy6empiAT22t5YapcaX3p9FUXdkaA0sC
         SixBRB24x1kZT5BOwEN7FuP4Yr6a1fFk2yFhyAi0cfFzqm0T/qeQz9qq8HAWTxL5ckAJ
         i7hL/SbDNLPi36aZlR8BBasBgUwh7rfDajwgWMICp3L2WB82ONiZBSwbRHReu+zUhYhO
         K7JmGrQSKz2KJ3MLk12utHFEYr6rEMkxBb1SfyUojtGBetxKM5I2HP8J9o+LYbXeeHJH
         GzKHQxdj0y1UUXd+rZTe6uy4eUio2FWaZF5/kL9c8jh0xSMLA8Enfi3WVgTKxyq3H9KV
         vRGw==
X-Gm-Message-State: AGRZ1gI/FV+Iauyy6kKVMZLAyXkykGD3YqaDGCDdiPmwm3NoEMjHUjk8
        v7Jo7YJ0+6V8VD+klcbDfkYvKQ==
X-Google-Smtp-Source: AJdET5c3yw47zoP70I4H1vIsn5B2B6+cbyVMI+JDp49mGKJZK9NZy1jhfG/2AW0aA7xmny76KLVmiQ==
X-Received: by 2002:a2e:9d05:: with SMTP id t5-v6mr8478351lji.57.1541184544699;
        Fri, 02 Nov 2018 11:49:04 -0700 (PDT)
Received: from localhost ([85.30.9.151])
        by smtp.gmail.com with ESMTPSA id k9-v6sm805781ljk.97.2018.11.02.11.49.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 11:49:03 -0700 (PDT)
Date:   Fri, 2 Nov 2018 11:28:36 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: orion: avoid VLA in orion_mpp_conf
Message-ID: <20181102182836.z7rabntfzyfcll7k@localhost>
References: <20181005161601.875388-1-arnd@arndb.de>
 <CAGXu5j+GWO6qB-Raq7XKKoFvwWpg_ZtzYBAEbXiU+N=dTs5YHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5j+GWO6qB-Raq7XKKoFvwWpg_ZtzYBAEbXiU+N=dTs5YHA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 09:33:28AM -0700, Kees Cook wrote:
> On Fri, Oct 5, 2018 at 9:15 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > Testing randconfig builds found an instance of a VLA that was
> > missed when determining that we have removed them all:
> >
> > arch/arm/plat-orion/mpp.c: In function 'orion_mpp_conf':
> > arch/arm/plat-orion/mpp.c:31:2: error: ISO C90 forbids variable length array 'mpp_ctrl' [-Werror=vla]
> 
> Ah! Thanks for catching this. It seems "allmodconfig" isn't quite "all". ;)
> 
> > This one is fairly straightforward: we know what all three
> > callers are, and the maximum length is not very long.
> >
> > Fixes: 68664695ae57 ("Makefile: Globally enable VLA warning")
> > Cc: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  arch/arm/plat-orion/mpp.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/plat-orion/mpp.c b/arch/arm/plat-orion/mpp.c
> > index 5b4ff9373c89..8a6880d528b6 100644
> > --- a/arch/arm/plat-orion/mpp.c
> > +++ b/arch/arm/plat-orion/mpp.c
> > @@ -28,10 +28,15 @@ void __init orion_mpp_conf(unsigned int *mpp_list, unsigned int variant_mask,
> >                            unsigned int mpp_max, void __iomem *dev_bus)
> 
> arch/arm/mach-dove/mpp.c:       orion_mpp_conf(mpp_list, 0, MPP_MAX,
> DOVE_MPP_VIRT_BASE);
> arch/arm/mach-dove/mpp.c-
> --
> arch/arm/mach-mv78xx0/mpp.c:    orion_mpp_conf(mpp_list, mv78xx0_variant(),
> arch/arm/mach-mv78xx0/mpp.c-                   MPP_MAX, DEV_BUS_VIRT_BASE);
> --
> arch/arm/mach-orion5x/mpp.c:    orion_mpp_conf(mpp_list, orion5x_variant(),
> arch/arm/mach-orion5x/mpp.c-                   MPP_MAX,
> ORION5X_DEV_BUS_VIRT_BASE);
> 
> arch/arm/mach-dove/mpp.h:#define MPP_MAX                        23
> arch/arm/mach-mv78xx0/mpp.h:#define MPP_MAX            49
> arch/arm/mach-orion5x/mpp.h:#define MPP_MAX                     19
> 
> >  {
> >         unsigned int mpp_nr_regs = (1 + mpp_max/8);
> > -       u32 mpp_ctrl[mpp_nr_regs];
> > +       u32 mpp_ctrl[8];
> 
> Largest possible is 1 + 49 / 8 == 7. But 8 makes it nice an round. :)
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

Applied, thanks!


-Olof
