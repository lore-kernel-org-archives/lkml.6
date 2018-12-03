Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D0AC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A18E2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="JQz7oFR4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A18E2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbeLCUsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 15:48:24 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40074 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbeLCUsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 15:48:23 -0500
Received: by mail-lj1-f196.google.com with SMTP id n18-v6so12743282lji.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 12:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7fqI4qtZaSILDNeE2ryuu9AEhVlXWVvdWKX+QGjCY7k=;
        b=JQz7oFR47VXlTlYct4DUSKWsWJ62GFGGMF1pVd6qswUzFOkoI7G6G70Wg28y2WaIQQ
         /bg28uoFax2nIYpH+Hijf1xHI0zBLQJsLhk182vhCbDBIyEkfNWlXCThvDDbRWP/Hp9U
         Pyw6SwTk+li8YWjkiStlY+zXKfoky6uwHQBdONmYcxNJeyKqaUv/MiFzDJVk40uzcnnL
         7mOsTrgPqrOvNJY2krEl6vBGTskEY0NCBTMvFtufagC3qOy4EYU9GFA8B5+3BkvzOdYd
         5SptFePBG4k9hVq2B/u8azVGTaYBwEj/af/Ui3dk6KwaLy0lW/qyETA2el52GYCmRitv
         XFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7fqI4qtZaSILDNeE2ryuu9AEhVlXWVvdWKX+QGjCY7k=;
        b=Sb7Ga3TtzNyU7rdIU8KzRMhYNoUDmiWsBRJWTtMT355Ja4nY99T7NzocBGYoQ6lWgw
         bOhob0uFWt4W+5UKaP8rspA6RZ2/0VS3B9RjHlZp+67w2EEMEtJkh6C9Uds/McuLQYsG
         nCaoojSn0dR4H+3OBiwTGs0FHucrTX7pDt8pdNaXcbbpUDz5xGQ6290/irmavpe9B0K2
         NAwOyHvjj/KzpylxFYYjpgzi8q8p1lC0v3xKGf6vf/lRE1RT30cJI+DIPXozG+Sdx7jp
         vUMwzTgCzJP+QYjIuzvEIYKhYqt3W36E/IE4Xxnk6vvXXdJViRehAnB9zqDBu5HGYbaj
         HrTA==
X-Gm-Message-State: AA+aEWZk+qKJEj0gGbp0uHz9TwnVw6/ntrQJQHPF4DnVLiqxjy1wBm9i
        dc4isXdORGVET5SYoJIfgjP+yQ==
X-Google-Smtp-Source: AFSGD/UiqOabnvQ8foIS7eN61/LS6KR+/mqq0Lx0H9oIInCPsHBPrN+R+dAcQOXJZqwafHFEaTMcmg==
X-Received: by 2002:a2e:1603:: with SMTP id w3-v6mr11004552ljd.33.1543870100956;
        Mon, 03 Dec 2018 12:48:20 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id u21-v6sm2707473lju.46.2018.12.03.12.48.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 12:48:19 -0800 (PST)
Date:   Mon, 3 Dec 2018 12:39:41 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Lubomir Rintel <lkundrak@v3.sk>, arm-soc <arm@kernel.org>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, quozl@laptop.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: mmp/mmp2: fix cpu_is_mmp2() on mmp2-dt
Message-ID: <20181203203941.5xwlklfirraf7svm@localhost>
References: <20181202111224.1450-1-lkundrak@v3.sk>
 <CAK8P3a3rEuccqhAgpNR6tP1g826m8o-mWtM1vNmGMb_-H8YMoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3rEuccqhAgpNR6tP1g826m8o-mWtM1vNmGMb_-H8YMoA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 02, 2018 at 04:53:07PM +0100, Arnd Bergmann wrote:
> On Sun, Dec 2, 2018 at 12:12 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
> >
> > cpu_is_mmp2() was equivalent to cpu_is_pj4(), wouldn't be correct for
> > multiplatform kernels. Fix it by also considering mmp_chip_id, as is
> > done for cpu_is_pxa168() and cpu_is_pxa910() above.
> >
> > Moreover, it is only available with CONFIG_CPU_MMP2 and thus doesn't work
> > on DT-based MMP2 machines. Enable it on CONFIG_MACH_MMP2_DT too.
> >
> > Note: CONFIG_CPU_MMP2 is only used for machines that use board files
> > instead of DT. It should perhaps be renamed. I'm not doing it now, because
> > I don't have a better idea.
> >
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> I'd suggest adding
> 
> Cc: stable@vger.kernel.org
> 
> since this fixes bugs on other platforms when CONFIG_MMP2 is enabled
> in a multiplatform kernel.

Applied to fixes with those tags. Thanks!


-Olof
