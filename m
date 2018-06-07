Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id iikyCpk/GVtOXAAAmS7hNA
	; Thu, 07 Jun 2018 14:22:30 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8B9B26089E; Thu,  7 Jun 2018 14:22:30 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sr4kr1Pp"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,FSL_HELO_FAKE,MAILING_LIST_MULTI
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8A9A26063F;
	Thu,  7 Jun 2018 14:22:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8A9A26063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933657AbeFGOW1 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:22:27 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:38729 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933172AbeFGOWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:22:24 -0400
Received: by mail-wr0-f171.google.com with SMTP id e18-v6so1814070wrs.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 07:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=edNYmV4HaII+y9wzaH14bd/YIjQcJC1ozIC9kRfCXk4=;
        b=sr4kr1PpDeWW8y++ET6HJ5Es/L6KdWXmJGpPZe6H8f+4UYTC/r32pPPmM0bPISD2+G
         hz6lcY0xPV0UYnSxJ2TXjEsjrRmLArBjKEAig5plXUi8Xxyi+1wtMoJ+GGm6R2FQkrUA
         WFU3k4U/p2AN3P960Lhi/VFyuNJv/JblobIn1PO+iGyVTVBIWUUakZTFSiMw4EXrhzvg
         oBZIe9d60YMkBIBEFVythO0ujFxltIgqp+CkB2cdTn7v5WVxIYJfPHpekx602WfBfYQn
         lLXBrim7pkV1Za6j7v6baXLzjK9ycaLFL4I2RI3AtyrCjIZwJ6NWUASxsmTSb4wBh1IP
         lJNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=edNYmV4HaII+y9wzaH14bd/YIjQcJC1ozIC9kRfCXk4=;
        b=YR0UazE/B0Ee/9PUjp9Bsg9ujXFKnUSdG50Jd/YBGhQl2Kvc6y0kyb3JzDoz8NXSMf
         rzGlYGRD3wwMZoNFxkuKtnjfsGudxzE0m8bIsVTzTTdh7ucUM4I5Hrn5+rHhj5pYOYWG
         KTRxhuB4MGaDP9pdMAU5wG/ZGORC3E73GxP8zHh8Ctp91oAxIPj5IuksII6G6T6Bt2CN
         HUWxGW2W1/wpxlZDuhRg4ll8f3rpINeAGcyaRWCFOXza6BDAJcm4HNa9NOo0lfRbiqvG
         931UNc9FsjrGYyDWbU2SBYAad3uYwo56hwUVR/9iG0WRhbAJnYqSkJIBD0A8sC1D32le
         gTQA==
X-Gm-Message-State: APt69E0ST1D72f2gaMUO6tY/hJwVi3PciuAYLjtgUprhfMCKaHbxtn6S
        xhOHW4tAfqhxIc2iz0rwazo=
X-Google-Smtp-Source: ADUXVKLc6fl+WJRncJUlCobXLkI3TVRUIe/txlZBR1lqteFE3wveXXDnfFqCWro2rEl0xeiZTXL34A==
X-Received: by 2002:adf:a148:: with SMTP id r8-v6mr1866587wrr.104.1528381343426;
        Thu, 07 Jun 2018 07:22:23 -0700 (PDT)
Received: from gmail.com (79.108.126.37.dyn.user.ono.com. [79.108.126.37])
        by smtp.gmail.com with ESMTPSA id n71-v6sm2773150wmi.14.2018.06.07.07.22.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 07:22:22 -0700 (PDT)
Date: Thu, 7 Jun 2018 16:22:09 +0200
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Robert Abel <rabel@robertabel.eu>, Sean Young <sean@mess.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] auxdisplay for v4.18-rc1
Message-ID: <20180607142209.5w5uitasnq4jfs7h@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 0adb32858b0bddf4ada5f364a84ed60b196dbcda:

  Linux 4.16 (2018-04-01 14:20:27 -0700)

are available in the git repository at:

  https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v4.18-rc1

for you to fetch changes up to 351f683b9823a3d1bffb6e2e3f381601aa0b2671:

  auxdisplay: Replace licenses with SPDX identifiers (2018-04-12 19:02:45 +0200)

----------------------------------------------------------------
Mostly small fixes and cleanups, plus a non-trivial fix for charlcd

  - charlcd: fixes and cleanups
    From Robert Abel and Sean Young

  - Kconfig fixes
    From Randy Dunlap, Corentin Labbe and Ulf Magnusson

  - cfag12864bfb: const cleanup
    From Gustavo A. R. Silva

  - Docs/licenses/warnings cleanups

----------------------------------------------------------------
Corentin Labbe (1):
      auxdisplay: img-ascii-lcd: fix typo on select SYSCON/MFD_SYSCON

Gustavo A. R. Silva (1):
      auxdisplay: cfag12864bfb: constify fb_fix_screeninfo and fb_var_screeninfo structures

Miguel Ojeda (5):
      Doc: misc-devices: move lcd-panel-cgram.txt to auxdisplay/
      MAINTAINERS: auxdisplay: remove obsolete webpages
      auxdisplay: arm-charlcd: Fix struct charlcd doc line
      auxdisplay: charlcd: Fix and clean up handling of x/y commands
      auxdisplay: Replace licenses with SPDX identifiers

Randy Dunlap (2):
      auxdisplay: fix broken menu
      auxdisplay: make PANEL a menuconfig

Robert Abel (4):
      auxdisplay: charlcd: use null character instead of zero literal to terminate strings
      auxdisplay: charlcd: replace octal literal with form-feed escape sequence
      auxdisplay: charlcd: fix two-line command ^[[LN not marked as processed
      auxdisplay: charlcd: fix hex literal ranges for graphics command

Sean Young (1):
      auxdisplay: charlcd: no need to call charlcd_gotoxy() if nothing changes

Ulf Magnusson (1):
      auxdisplay: img-ascii-lcd: kconfig: Remove MIPS_SEAD3 reference

 .../lcd-panel-cgram.txt                            |   0
 MAINTAINERS                                        |   8 --
 drivers/auxdisplay/Kconfig                         |  16 +--
 drivers/auxdisplay/arm-charlcd.c                   |   4 +-
 drivers/auxdisplay/cfag12864b.c                    |  16 +--
 drivers/auxdisplay/cfag12864bfb.c                  |  20 +---
 drivers/auxdisplay/charlcd.c                       | 119 +++++++++++++++------
 drivers/auxdisplay/hd44780.c                       |   6 +-
 drivers/auxdisplay/ht16k33.c                       |  10 +-
 drivers/auxdisplay/ks0108.c                        |  16 +--
 drivers/auxdisplay/panel.c                         |   6 +-
 include/linux/cfag12864b.h                         |  16 +--
 include/linux/ks0108.h                             |  16 +--
 samples/auxdisplay/cfag12864b-example.c            |  16 +--
 14 files changed, 111 insertions(+), 158 deletions(-)
 rename Documentation/{misc-devices => auxdisplay}/lcd-panel-cgram.txt (100%)
