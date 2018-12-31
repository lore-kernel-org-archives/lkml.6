Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A051CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 22:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A9E72075D
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 22:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyZqisAA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbeLaWUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 17:20:45 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46721 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbeLaWUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 17:20:44 -0500
Received: by mail-pl1-f194.google.com with SMTP id t13so13000790ply.13
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 14:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=+PDK9/lu0G1G1t89bIHctXq/HbZ9oIUQeFKkVGMnq6w=;
        b=ZyZqisAA9lIGuPGLAQWL84/juQjHEVutXY+rk//IRwfpiyY4BhjcxFA0QLHkJ52sFK
         BWpA0vR5C2PsOySLWcbEcFY3FREFoefj8IaBkj/2SBBWtLNuZuk2/2Ye0RaJejEkD1Oq
         Cr9zOIeWSmIV+0RWYMg7UutYH1IyVyuVoZES/ndsisWDU0GeTD4dlKw27jsLyACT57iK
         ZVVh3hcLDgRcxL+6y3uD+DVQ1QZoVkZ5VK7Ch39ba9NbWB7dq7c3koZiA560nFAZc1Vo
         Q13BeOTAYOO64eS8yx5Ag16IhdW1HTTCbCXcu6ugKKtA4qOEt1P6EOta7Hg/fOjByxZk
         Ql7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=+PDK9/lu0G1G1t89bIHctXq/HbZ9oIUQeFKkVGMnq6w=;
        b=Vr+SDKsDkvS0mLV8A4ZdKrJDlhPzfC16XAbNU/I4rGFHNuEKcVDj2ylTR7jkuXwTzs
         AHV940ARAZJaCOX27/YzYdDKZlasqASkNrgf5gfbiLANsvaq3n4BgfZ8APxUclaqM4u8
         I0/q69uZvpWmxbV8BMdU0p/TFpvDKaSPTMF9DS2W59QS2KacQnSPVaJOf+/C3a1MZDDz
         o7s+2bAuD++/cXK5cpbSmvNPTv++HxQxBd3BRwU+izOD/iW1Za9CkIhtbINo2shholEh
         Qko9aQ+6ZfEbhTVe2le/gqvTIFxw1U88imqNk2aFhJKqe4X9pw2B7pLi8Y7YCTVY8h+i
         zawQ==
X-Gm-Message-State: AJcUuke8lJcuuHUdaolTCdmu3AOBMKqOV7F9pf6Vw72qn4uLOH16qRVi
        Hjvakm0/Y8iuqSYCfL7D4+8AEbO1
X-Google-Smtp-Source: ALg8bN6YEwvocyclobt0G3oPHDnsIGOWpVRrvedNy/CB+v2xYje4lIt0BClXVAgRT0ABosLKEXJbrg==
X-Received: by 2002:a17:902:3124:: with SMTP id w33mr38813130plb.241.1546294844332;
        Mon, 31 Dec 2018 14:20:44 -0800 (PST)
Received: from localhost (g206.124-44-15.ppp.wakwak.ne.jp. [124.44.15.206])
        by smtp.gmail.com with ESMTPSA id t12sm75401873pfi.45.2018.12.31.14.20.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 31 Dec 2018 14:20:43 -0800 (PST)
Date:   Tue, 1 Jan 2019 07:20:41 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] v4.21 Updates for OpenRISC
Message-ID: <20181231222041.GM3235@lianli.shorne-pla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please consider for pull,

The following changes since commit 7566ec393f4161572ba6f11ad5171fd5d59b0fbd:

  Linux 4.20-rc7 (2018-12-16 15:46:55 -0800)

are available in the Git repository at:

  git://github.com/openrisc/linux.git tags/for-linus

for you to fetch changes up to 57ce8ba0fd3a95bf29ed741df1c52bd591bf43ff:

  openrisc: Fix broken paths to arch/or32 (2018-12-20 00:04:39 +0900)

----------------------------------------------------------------
OpenRISC updates for 4.21

Just one change for 4.21:
 - Update comments for name change or32 -> or1k from Geert Uytterhoeven

----------------------------------------------------------------
Geert Uytterhoeven (1):
      openrisc: Fix broken paths to arch/or32

 arch/openrisc/kernel/entry.S | 2 +-
 arch/openrisc/kernel/head.S  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
