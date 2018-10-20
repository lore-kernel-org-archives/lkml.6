Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC31AC67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 11:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C6D21523
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 11:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpE5Gd+/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1C6D21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbeJTTwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 15:52:03 -0400
Received: from mail-it1-f180.google.com ([209.85.166.180]:55962 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbeJTTwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 15:52:02 -0400
Received: by mail-it1-f180.google.com with SMTP id c23-v6so7122614itd.5
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 04:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Fsjs6Vx6DG41/3EUm2VSQUxGo+m9up1+YS8XV7B6P3k=;
        b=EpE5Gd+/rUYe7u9y0aTUj1arxvgEigKPU/G/WkRxihjeYck7+WSiZD/2wwU9i+r2fA
         WIu/zehQo/6vxAwNQdXggRhkxwqQIzJUEHgPFcpIIS7GapjQBLfESFpzZzfMeeR0vuum
         HEvdDPvLnOWwp/kbFs77kY0UXuq0uhZEHvzLwx+lflrVyFNJU4GHvGx/lNHdEqGLW226
         m2zdOQWB/z3mWbH7+M8Fdgvqk/f8qjFrzQWWnmUJMwPXeBDWXZ5V3DiJzfUC1LkgkkX6
         WTmKVv7W1nvChGMQR9hecAoUsutKATfSClNN6hD7X2LXNcQyz7bIzFrShl4t5Fi11VkN
         pY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Fsjs6Vx6DG41/3EUm2VSQUxGo+m9up1+YS8XV7B6P3k=;
        b=gaEMDeHhvceE2gtxKpJvQkQ9pDksDNTRSbYsm1mdb9ffwz+O9z7ALYedBM+ZEZ9B7o
         zRkYQ5B11tSa9bS1siKCTzkOBm007edGFiH5sWdUIBWF+8yXo7uFSqBlLgUPO3zX0k8C
         R0O4VOeoEmI7gSwlCFwo0WHcPrpcemuv0P0IFadU0pzdU0XVRI2qet1HbUPxwLbaUltE
         Q0/Eyjl9Ci/cXyCY+T8TVcqf/nbiyFkfBWKOzPy7J8IX7qamRi4cEhCU7TpSoKQYfGu0
         ECeIbWSyDRn5lRmpSuxB1OOaRoAgS1DNpxFnGleSxcNQG037ytbRksACvjES1hO3m/pA
         H8dw==
X-Gm-Message-State: ABuFfoigfHKMqPgQmkIacOLNQfQzMz4kAWPBiWCXzvi6FVki0RPvwxOO
        EnYwwbPMO/j1V6+c8ZUp9oHSjSWQaOmvQqmIzxMPIco=
X-Google-Smtp-Source: ACcGV601l1gGuR2xt4KiSI7z2t0QxAiGiYyker7Li/BVixaJWX/woXnYgh6FpEKwJ2ntY1G66/jYfrRgP7cGyKi8kjk=
X-Received: by 2002:a24:c6c3:: with SMTP id j186-v6mr5194633itg.105.1540035711725;
 Sat, 20 Oct 2018 04:41:51 -0700 (PDT)
MIME-Version: 1.0
From:   Spock <dairinin@gmail.com>
Date:   Sat, 20 Oct 2018 14:41:40 +0300
Message-ID: <CADa=ObrwYaoNFn0x06mvv5W1F9oVccT5qjGM8qFBGNPoNuMUNw@mail.gmail.com>
Subject: Memory management issue in 4.18.15
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a workload, which creates lots of cache pages. Before 4.18.15,
the behavior was very stable: pagecache is constantly growing until it
consumes all the free memory, and then kswapd is balancing it around
low watermark. After 4.18.15, once in a while khugepaged is waking up
and reclaims almost all the pages from pagecache, so there is always
around 2G of 8G unused. THP is enabled only for madvise case and are
not used.

The exact change that leads to current behavior is
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-4.18.y&id=62aad93f09c1952ede86405894df1b22012fd5ab
