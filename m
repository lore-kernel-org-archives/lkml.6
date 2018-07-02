Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A0BC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D130925C57
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="C3R7izzZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D130925C57
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752162AbeGBMKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 08:10:19 -0400
Received: from mail-lf0-f45.google.com ([209.85.215.45]:45521 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752031AbeGBMKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 08:10:18 -0400
Received: by mail-lf0-f45.google.com with SMTP id m13-v6so11834720lfb.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 05:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=euwizESmUNkwp2u75ve+Arl5eOXF3ftmRtzYdlFCnjI=;
        b=C3R7izzZBKH1hSFGis+FZuPgLTDhtsjNq4yzkYs68vieYSQif/ZptcHes/Tkd3dcWp
         +wsGyMu9p9GD9oWfqZ4BOiNLgf7UNSfMXfNTAG2GwL4te1X/HemebDnvKQyFVDfT9ySv
         yhVzTvf6AcgUX4VQ8T/skAgZ3V60I/y+cXN6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=euwizESmUNkwp2u75ve+Arl5eOXF3ftmRtzYdlFCnjI=;
        b=onMUz0+Z9Fox4FVWQwKkZUNq6kurEED9A4nGz7sog7jLyYpTFaevD8INOgPDNivWKy
         OTsbRrSxIhx+AVWCDJGiNSwq1a8GeLcyMg0q1iIlYRd8N899lLsmJyv4qq7su4ui8Him
         mvS1yD/zTbzr2R54yD3M2h/+JRN5n3jAtfUNdZwPub17IYh6TP2oDdeG0nASMwcILb2E
         5KEhd2WIgiHtGGA9nI4fdXNGZA5VQ056fhpSKSkpBBc0eVHEjzJ5qjIuLnh8NDnJ/Zb+
         TMFVYyXPh+Pv9n25qw14KkNjGFJ2okG4Jk4eypPl7iScLGGr/tqXpX3YOn+KJHcRDFxy
         RK9g==
X-Gm-Message-State: APt69E1Ny/YcmkLjCW+4fF2gZhoxOj3CMe+nGNvaG2b2DsaMFz8QsXkw
        vCCiT+mh65g5BHX9epZZcTBwIg==
X-Google-Smtp-Source: AAOMgpcQkXa06989YQW9SNWF1Omxh7zHNiFd5iG/VLv727fdxHbB7RDWLeTaXIJywW0+s7VCjvstdA==
X-Received: by 2002:a19:e803:: with SMTP id f3-v6mr15989246lfh.84.1530533416114;
        Mon, 02 Jul 2018 05:10:16 -0700 (PDT)
Received: from jax.urgonet (h-84-45.A175.priv.bahnhof.se. [79.136.84.45])
        by smtp.gmail.com with ESMTPSA id s139-v6sm740167lfe.86.2018.07.02.05.10.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 05:10:15 -0700 (PDT)
Date:   Mon, 2 Jul 2018 14:10:13 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm-soc <arm@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: [GIT PULL] tee driver for v4.18
Message-ID: <20180702121013.GA17791@jax.urgonet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull these small tee driver enhancements. There's a new config
option for the OP-TEE driver, OPTEE_SHM_NUM_PRIV_PAGES. Also the OP-TEE
driver reads current time with ktime_get_real_ts64() from now on.

Thanks,
Jens

The following changes since commit 29dcea88779c856c7dc92040a0c01233263101d4:

  Linux 4.17 (2018-06-03 14:15:21 -0700)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-drv-for-4.18

for you to fetch changes up to 3249527f19d660c5adfb2b6f4ffd4ca0506b8755:

  tee: optee: making OPTEE_SHM_NUM_PRIV_PAGES configurable via Kconfig (2018-06-20 11:20:36 +0200)

----------------------------------------------------------------
Misc enhancement for tee driver subsystem

* Replaces getnstimeofday64() with ktime_get_real_ts64()
* Adds OPTEE_SHM_NUM_PRIV_PAGES to configure how many pages should be
  statically reserved for driver private allocations

----------------------------------------------------------------
Arnd Bergmann (1):
      tee: replace getnstimeofday64() with ktime_get_real_ts64()

Sahil Malhotra (1):
      tee: optee: making OPTEE_SHM_NUM_PRIV_PAGES configurable via Kconfig

 drivers/tee/optee/Kconfig | 8 ++++++++
 drivers/tee/optee/core.c  | 2 +-
 drivers/tee/optee/rpc.c   | 2 +-
 3 files changed, 10 insertions(+), 2 deletions(-)
