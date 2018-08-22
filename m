Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FB0C43615
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 19:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA5820B6F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 19:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPTgTkgZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FA5820B6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbeHVWwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 18:52:46 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46327 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbeHVWwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 18:52:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id b129-v6so1350157pga.13;
        Wed, 22 Aug 2018 12:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZbwCYXGXmVaoODa1GSnw9aCGQgvrwo0LX5UwUOvGn7k=;
        b=EPTgTkgZhIZFq8wHLwx3xOuBYA3dsdVWPOAvLjFXHozKuBOTGrBzMAe9dLJOUdRXyi
         RqWsAGmWEFuPzESv9VDv+b0Cj6Mc+FGe7abcqiBmd+cRBiHnM4Z16BCfsRwttjW53wbl
         uTDa/UbHfrzx/RlV4TNRkuod3HgUmXXJJmTYcb9YdmTSdgPIbIOqLLVArsrEnX+l8wxK
         +mEsd09pDzYfHNO2WPq6lqYRCZQOMy8bGqSZxR9ZlOiAU+PrI2WvWJhQx67BZmH31qdA
         RsJm7cEBmGpNJlfNpN5zY8NgNWwY55SOXm/Q8UpJ+BhvyZpyDKqlj9amiJpyImxyGdOW
         Y2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZbwCYXGXmVaoODa1GSnw9aCGQgvrwo0LX5UwUOvGn7k=;
        b=jI+yVaVdXVmEEgS7UxM8obMoG6Z8FkElh7Ocdg181HX7d1QUpXo6Zbf3wjzVmZmB8O
         tg+YyZ5Jk2tU0PuoIP7IHqpeXrw5NHbbwXLXldJvA+9p3IEL2D8L+QNk454IpmB+vNmf
         qrAxRONxUnN87rOQIeLxQxfzqPxrgmG3DrbqPFYIRnQUrPdA1p9guz/iicI0Fz9aMaQ6
         JjJXDISN1UNj9AphuD5ABfm6cG1dwotOy0SwCMr38cGzsQArPfREhes2gCLwjOfIcIkP
         E+Lg/oto2jHDO7hHyYFM99F/0Sdc/BYh1Grev0dqHBeLgVfXxCxWpL2dKjNY+ams+t7d
         xPqQ==
X-Gm-Message-State: AOUpUlGZsVeZGT4DJWF3etYp1urp1MnB7uf7blC3Zp/bZSeIlscAewkg
        AMPVwIqcuHz+9LYHqXycnUunNkFrG0eKv6i/5OCRiq+OMuQ=
X-Google-Smtp-Source: AA+uWPwAmm6Q5TyeaUf+vN7z/LzBG+npjsh7NuJBZ+FOG65Ol+qqNJ/UYUApoC7L7OnMaB27jkkPcBYDrDJnEdz3o0k=
X-Received: by 2002:aa7:88d3:: with SMTP id p19-v6mr52750295pfo.160.1534965996797;
 Wed, 22 Aug 2018 12:26:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180822080449.5887e244@canb.auug.org.au>
In-Reply-To: <20180822080449.5887e244@canb.auug.org.au>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Wed, 22 Aug 2018 12:26:24 -0700
Message-ID: <CAM_iQpUDjemL5OQt=D3hr6dCfqcKoi1w-CM9SHyTRcZ=aPeWsQ@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the net tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Miller <davem@davemloft.net>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 3:04 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the net tree, today's linux-next build (KCONFIG_NAME)
> produced this warning:
>
> drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c: In function 'tc_fill_actions':
> drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c:64:6: warning: unused variable 'i' [-Wunused-variable]
>   int i;
>       ^
>
> Introduced by commit
>
>   244cd96adb5f ("net_sched: remove list_head from tc_action")

I bet you have CONFIG_NET_CLS_ACT=n?

Here is a quick fix:

diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index c17d51865469..9ec471ffaa5d 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -303,7 +303,7 @@ static inline void tcf_exts_put_net(struct tcf_exts *exts)
        for (i = 0; i < TCA_ACT_MAX_PRIO && ((a) = (exts)->actions[i]); i++)
 #else
 #define tcf_exts_for_each_action(i, a, exts) \
-       for (; 0; )
+       for ((void)i, (void)a; 0; )
 #endif

 static inline void

Interestingly, neither my compiler nor kbuild-bot's compiler doesn't
catch this.

Thanks.
