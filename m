Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D806C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D5A2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="vx9FWQ+y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2D5A2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbeLLWRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 17:17:00 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38858 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728664AbeLLWQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 17:16:55 -0500
Received: by mail-lj1-f196.google.com with SMTP id c19-v6so7644lja.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 14:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PzCQNydjYFV8qa2UITl5l8DVJtRvpAqEai7cgBY6pLg=;
        b=vx9FWQ+y6/nzhOFZJx7+jKr9eAT6Ur3n5elFRYNy3BFZt0rJcDxCP18jjE7geccpAQ
         h0MMYBazgJ22fp3613o617VUknNwxj8KA/0hLVauvyW1XY9d4HeDNcTIT+08haPg3k17
         dh3EkdLl17KF5xIzL0/U8cNOZmdrsK25pDSy1EMAFfW54/4XjGjK/RB/EfQXDwCiqItB
         rrX3jksQFWduez4GBVvdPEAzQn1cS06/OwFPM1LPIC8HxUxTuViesv76Ibfruo/xRt3T
         k1F04qrB7pcCxXDdcbxvOyu9Z8bwM16dYgGZTs54qpdFhv4z/I9kg3ivyFl0lZxx7BeL
         Lnig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PzCQNydjYFV8qa2UITl5l8DVJtRvpAqEai7cgBY6pLg=;
        b=ebz6BzopAexVNi+zhTObx95IFbOow46KY2ST0XjnYCgVKJj/CNSRBCDRxLJRSL5Rcz
         hd/CtEyfFpq+D+gJL6UsScwK6Rn7V+5UMxyxljsp/uFJ14mKLqKhL6cvPuopjULJzfYf
         5Yjz84781z1klfAgJRZfJCQ8hFQy06cUx7SZFs1Kmz4mtB1l2TaqA3B5RiYFwpaJ4s//
         lZCrjpqIjd1/oiIfgHgDsP3KKdObDpwClZM29dHbY0YBrxXR4r8hMnhE8xZfMJwG9TgL
         4XUfvypjvTAF4hlbEq0mwap7R+bCc/G5WGVQ4kkaO3hFTunOywInWJx4s6yzxn1wE7wg
         +nNw==
X-Gm-Message-State: AA+aEWbNzuufkao6L/30JzjITkuJzagEv1S1XXupaXjyqZ1qBQKeARUz
        4hgPnmdWi1xBruESoLnSFvPmlpchrE2e2g==
X-Google-Smtp-Source: AFSGD/UtNHPVQyZaBNNLafxYvHxLvtYnvcph12uhaRHI2clu3qsnXMU+acnpN5KzokM+LG+RdYKzDQ==
X-Received: by 2002:a2e:8156:: with SMTP id t22-v6mr12827012ljg.32.1544653012611;
        Wed, 12 Dec 2018 14:16:52 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id q127-v6sm2304ljq.45.2018.12.12.14.16.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 14:16:51 -0800 (PST)
Date:   Wed, 12 Dec 2018 13:55:22 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     arm@kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: mmp: fix timer_init calls
Message-ID: <20181212215522.hbydhfpsdvdcshji@localhost>
References: <20181210204340.2269622-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210204340.2269622-1-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 09:43:01PM +0100, Arnd Bergmann wrote:
> The change to passing the timer frequency as a function argument
> was a good idea, but caused a build failure for one user that
> was missed in the update:
> 
> arch/arm/mach-mmp/time.c: In function 'mmp_dt_init_timer':
> arch/arm/mach-mmp/time.c:242:2: error: implicit declaration of function 'timer_init'; did you mean 'hrtimer_init'? [-Werror=implicit-function-declaration]
> 
> Change that as well to fix the build error, and rename the
> function to put it into a proper namespace and make it clearer
> what is actually going on.
> 
> I saw that the high 6500000 HZ frequency was previously only
> set with CONFIG_MMP2, but is now also used with MMP (pxa910),
> so I'm changing that back here. Please make sure that the
> frequencies are all correct now.
> 
> Fixes: f36797ee4380 ("ARM: mmp/mmp2: dt: enable the clock")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to next/soc where the rest of the MMP material lives this cycle.


-Olof
