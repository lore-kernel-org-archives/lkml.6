Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644A3C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 04:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB7F219DA
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 04:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F85adlDz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CB7F219DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732250AbeHGGQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 02:16:50 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33391 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728468AbeHGGQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 02:16:50 -0400
Received: by mail-qk0-f195.google.com with SMTP id 27-v6so10556615qkv.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 21:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=/3NQwNuORsdcbD+wWAXFT19mvOS4EupVeuS8V7BAM1U=;
        b=F85adlDzND4PMmm1NP5YtAmtWy7vjWHCfooClyPeLHRrRHId/j7NH34K0HBUGxATEK
         Lw0R31qJ8/1JD1IzCQ1qu20Osvk52gi6/F25X8sw41DafHXzM24+dV2N+82iYin/O9gS
         WVoNvQKzCE8P0PjMzFypHEIg80XHGpYqxD9zljruelfLReQFAwSdPGMZp1/JwZrHUV14
         MCkLlMLY5HbOGXocu4aA6QNh/oL8hPDPEF9L2PzuXteddBM01NsK6MGYcpJW4cD00433
         o94hBFs/PoftjZp3ZnogEah3LndMFl1ZR0Gc8FjRoE9Y44i/C58Vp+XoolZR5+TPahiv
         MGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=/3NQwNuORsdcbD+wWAXFT19mvOS4EupVeuS8V7BAM1U=;
        b=cMxYYKQ93A1BAf4eYOxPYvT+UUWGfMRuWHwALrq/j8pHN9ZjQUF6ZPVT5Jk22i2v2v
         I5WMvhbSAYSVCn6VLkb5Z5caqXiekNEeF+TGmDPXe7QYGfXP/k+Tjtb4ZsGBTPHFsm/I
         Ak6nac8EdFfyCqUzLjYZkG/vFwiSBONMqXx3sbMvh6tTCgpHuJBXlkGFNLPyamNXw/dY
         VFBoZJpunesNdfH98iLf37uPlD79eRUgpkRUWdQ00eUblm1P9ypsc2U/HOSfij4TfbJx
         bTpEDaaM//2vDTaiyL6V2LJT/tM24XWEgbz5kQgFHavXyYxoqkjUp/nELr8BNt43YPv2
         F8gA==
X-Gm-Message-State: AOUpUlE/m6dyz7btJHjgGA/m4EoOPkEMblubA2sfyrANas7bzH1PE54O
        kWIUSD2+nJa8TKk8IY4Yeb0=
X-Google-Smtp-Source: AAOMgpe/F+oyli+2p+uK25yWXSNUDBrjlJN2iMNIbjsGXVCqHB7LR19N8tKlqU1VJr4vqGtJ8DbLkQ==
X-Received: by 2002:a37:9904:: with SMTP id b4-v6mr15966608qke.102.1533614669153;
        Mon, 06 Aug 2018 21:04:29 -0700 (PDT)
Received: from WindFlash ([201.82.148.26])
        by smtp.gmail.com with ESMTPSA id c11-v6sm201629qkb.22.2018.08.06.21.04.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 21:04:28 -0700 (PDT)
Date:   Tue, 7 Aug 2018 01:04:22 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] Style Fixes on fbtft
Message-ID: <cover.1533614243.git.leobras.c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I did some style fixes on staging/fbtft using scripts/checkpatch.pl.

Please feel free to suggest any changes.


Leonardo Brás (11):
  staging: fbtft: Changes udelay(n) to usleep_range(n, n + 1). - Style
  staging: fbtft: Puts macro arguments in parenthesis to avoid
    precedence issues - Style
  staging: fbtft: Fixes some alignment and line > 80 char issues - Style
  staging: fbtft: Adjust some empty-line problems - Style
  staging: fbtft: Erases some repetitive usage of function name - Style
  staging: fbtft: Fixes some defines styles - Style
  staging: fbtft: Includes description to mutex and spinlock - Style
  staging: fbtft: Add spaces around /  - Style
  staging: fbtft: Corrects long index line  - Style
  staging: fbtft: Replaces (1 << n) for macro BIT(n) - Style
  staging: fbtft: Includes parenthesis around macro parameters and
    avoids multiple usage of macro parameter - Style

 drivers/staging/fbtft/fb_agm1264k-fl.c |   2 +-
 drivers/staging/fbtft/fb_hx8347d.c     |   2 +-
 drivers/staging/fbtft/fb_ili9163.c     |   2 +-
 drivers/staging/fbtft/fb_ili9320.c     |   2 +-
 drivers/staging/fbtft/fb_ili9325.c     |   2 +-
 drivers/staging/fbtft/fb_ili9341.c     |   2 +-
 drivers/staging/fbtft/fb_ra8875.c      |   4 +-
 drivers/staging/fbtft/fb_s6d02a1.c     |   1 -
 drivers/staging/fbtft/fb_s6d1121.c     |   3 +-
 drivers/staging/fbtft/fb_sh1106.c      |   2 +-
 drivers/staging/fbtft/fb_ssd1289.c     |   9 +-
 drivers/staging/fbtft/fb_ssd1306.c     |   5 +-
 drivers/staging/fbtft/fb_ssd1325.c     |   2 +-
 drivers/staging/fbtft/fb_ssd1331.c     |  11 ++-
 drivers/staging/fbtft/fb_ssd1351.c     |  43 ++++++---
 drivers/staging/fbtft/fb_st7735r.c     |  21 ++--
 drivers/staging/fbtft/fb_st7789v.c     |  13 ++-
 drivers/staging/fbtft/fb_tinylcd.c     |   2 +-
 drivers/staging/fbtft/fb_uc1611.c      |   2 +-
 drivers/staging/fbtft/fb_upd161704.c   |  19 ++--
 drivers/staging/fbtft/fb_watterott.c   |  33 ++++---
 drivers/staging/fbtft/fbtft-bus.c      |  31 +++---
 drivers/staging/fbtft/fbtft-core.c     |  65 ++++++++-----
 drivers/staging/fbtft/fbtft-io.c       |  17 ++--
 drivers/staging/fbtft/fbtft-sysfs.c    |  10 +-
 drivers/staging/fbtft/fbtft.h          | 129 +++++++++++++++----------
 drivers/staging/fbtft/fbtft_device.c   |  46 ++++-----
 drivers/staging/fbtft/flexfb.c         |  46 +++++----
 28 files changed, 317 insertions(+), 209 deletions(-)

-- 
2.18.0

