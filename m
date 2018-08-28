Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA96FC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D9920878
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7iY2F4K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55D9920878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbeH1O3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 10:29:21 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36343 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeH1O3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 10:29:21 -0400
Received: by mail-wr1-f65.google.com with SMTP id m27-v6so1103103wrf.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 03:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=lr5wdBvpdMbAy4l8EF1nVebP7wkdOcuvs0b3N5juoSo=;
        b=k7iY2F4Kl77E6Mki9P3zfxHteMHjw1U1UZpAdOMWQ1gx0Uqpwri0TEjRL+58GX9FCM
         krTAorTu3DQKhTgep66iHeLxEvI/4bVvydeWepyVTknQLz6FqZlQL6ZfKHxIByAqh5RC
         m/D+SDrzEAJ3LiTD8HFo1smumLTXg2ormmsdGtwKpSO6kpwvDpmRi774Qd5+PifAqad5
         3zNIdLCPqWxOyk+Fy9+zk2CG/Z4m/GfOIIrcnJOc0ckRmxvxteGAY5LpIdAkQw6Uqaa4
         GvIwWVh1+dRmUsubHW4hGWLWJi5efEiEc3XEItEfDqnVOHD9ea225E/AOiBY6fKuEhKC
         hNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lr5wdBvpdMbAy4l8EF1nVebP7wkdOcuvs0b3N5juoSo=;
        b=Atl2piSAL5GmZWnu+dLmdKWEYyQvP72DQtRgvFwIRpbJGvhcTUoT3esNGHgE7hBmgF
         tkCgFcYNZHjW1hN12JkpfPhUxjK3rPtVjFgKIEasvqLLtz6k5pu/KuAow7gPUllEdSxl
         5rwl/YH8im9zTQNFvvTA9rgcP4TPS+AqDsgt3nPsTDwwhAv+lkjtng/0S+aKthBdBmW/
         v96YQobGH3fiosOhxdTc+U0dlU324Do3OWsqFWc7oZgbml5Vrv1p+zuCAjVkoo4yN6+z
         AO5cajuZf2rcKgN+qyNhMv6qjfw2THfB3t1qjEHpPYWl0tneT6+HukpKmlvaZ5fVjuAv
         gf1g==
X-Gm-Message-State: APzg51BvJwdZj0JEm5iOFEJC+jUD46i4m4ODvkS16eU39Yfn6E9ROgKz
        qfsNgMARMfHSJNI7mmgSLso=
X-Google-Smtp-Source: ANB0VdYX3ZhuC6WY9eK2ngc9g1986vjSwuh2JGJO9YAz5wDrRJI3wMt/8vXYsuT0+wXRz4sPq39OKQ==
X-Received: by 2002:adf:bc44:: with SMTP id a4-v6mr750458wrh.255.1535452699225;
        Tue, 28 Aug 2018 03:38:19 -0700 (PDT)
Received: from do-kernel ([142.93.171.10])
        by smtp.gmail.com with ESMTPSA id l10-v6sm1284799wre.0.2018.08.28.03.38.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 03:38:18 -0700 (PDT)
Date:   Tue, 28 Aug 2018 10:38:17 +0000
From:   "Ahmed S. Darwish" <darwish.07@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Simon Que <sque@chromium.org>,
        Todd Poynor <toddpoynor@google.com>,
        linux-kernel@vger.kernel.org, devel@linuxdriverproject.org
Subject: Re: [GIT PULL] Staging/IIO driver patches for 4.19-rc1
Message-ID: <20180828103817.GB1397@do-kernel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180818155724.GA22569@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ re-send; forgotten lkml CC added; sorry ]

Hi,

On Sat, 18 Aug 2018 17:57:24 +0200, Greg KH wrote:
[...]
> addition of some new IIO drivers.  Also added was a "gasket" driver from
> Google that needs loads of work and the erofs filesystem.
> 

Why are we adding __a whole new in-kernel framework__ for
developing basic user-space drivers?

We already have a frameowrk for that, and it's UIO. [1] The UIO
code is a very stable and simple subsystem; it's also heavily used
in the embedded industry..

I've looked at the gasket documentation [2], and the first user
of this new in-kernel API [3], and this is almost replicating UIO
it's not funny. [4] True, the gasket APIs adds some extra new
conveniences (PCI BAR re-mapping, MSI, ..), but there's no
technical reason this cannot be added to the UIO code instead.

More-over, the exposed user-space API is just some ioctls. So if
google hase some shipped user-space code that is using this,
hopefully the driver can still be re-implemented through UIO
without changing these bits..

Thanks,

[1] https://www.kernel.org/doc/html/v4.18/driver-api/uio-howto.html
[2] drivers/staging/gasket/gasket_core.h :: struct gasket_driver_desc
[3] drivers/staging/gasket/apex_driver.c
[4] include/linux/uio_driver.h

--
Darwi
http://darwish.chasingpointers.com
