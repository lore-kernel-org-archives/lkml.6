Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB104C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4E02205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="eNE8GXiA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391195AbfAPOVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 09:21:32 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46689 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390688AbfAPOVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 09:21:31 -0500
Received: by mail-pf1-f195.google.com with SMTP id c73so3118671pfe.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 06:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g.ncu.edu.tw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bbKwYk8Ugq+hYJpEp6iOjORLC965cd+4tEfHQSRgheo=;
        b=eNE8GXiAIbOp+MU52J1G5ODJnd97SdqP0xyihesLWspooqmPQTvbXuLoL2sbQuRdEe
         9bZNzaNvg0LrU4JFCvKg0zdCqRfGkKQT4L1LXinUPG0YPT6IlJlSfhVXx2L0F2VFX0ER
         VnvVn+OQmbeKv9ociq5eICMgSAGo3I952Rc14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bbKwYk8Ugq+hYJpEp6iOjORLC965cd+4tEfHQSRgheo=;
        b=jy6SLxXiorfnLLCwlX2h1So2pWqPkWQWa9KIVW/JCTgTJazlQh+0thmWzTVloc7vJm
         RGvBaildKjI1KYw5M47dSZqEl6N1IMqIFzHO/hp008g4/S+BauZPmk5Tnrv94EvS0CK/
         mPvleYhYpkjDPToazKqEykuSbA7DFa4XCTJqyQThzTy0x/r7QqUwxnehfmHMi4gpyVpn
         2DabUsLjgsIAARa8FA4iLYAYiHylJ6r9PJswuJeJd1cWhHha5Ppf+SHi5ibs56yw1FOy
         +VDOCrAaqHzj6FvEBHjCneJiikVA+0lvptQnbmW7kmvw4tA7sNJEceqTAYlW6Xj6D9zv
         FS6w==
X-Gm-Message-State: AJcUukd69dZW+Tfkgh9MKDPaHjzDhNZ4NU0ia39gySpuNAid8PAEvxur
        SF3b8YiMZciaubBuNzaVyljsmw==
X-Google-Smtp-Source: ALg8bN69vTyiZi9StAr48mY+qhovwRgKIsBdKUd/3m3095E7MjTPFkzrLjAHDSan60LMaosJdxzGKA==
X-Received: by 2002:a62:d701:: with SMTP id b1mr9938324pfh.34.1547648490885;
        Wed, 16 Jan 2019 06:21:30 -0800 (PST)
Received: from starnight.local ([150.116.255.181])
        by smtp.gmail.com with ESMTPSA id b2sm13430967pgg.87.2019.01.16.06.21.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 06:21:30 -0800 (PST)
From:   Jian-Hong Pan <starnight@g.ncu.edu.tw>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Cc:     Ben Whitten <ben.whitten@lairdtech.com>,
        linux-lpwan@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jian-Hong Pan <starnight@g.ncu.edu.tw>
Subject: [RFC PATCH 0/5] net: lorawan: Refine the lorawan protocol module
Date:   Wed, 16 Jan 2019 22:20:49 +0800
Message-Id: <20190116142048.19446-1-starnight@g.ncu.edu.tw>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jian-Hong Pan (5):
  net: lorawan: Refine the coding style
  net: lorawan: Remove unused lrw_dev_hard_header function
  net; lorawan: Fix net device leakage
  net: lorawan: Fulfill the help text of Kconfig
  net: lorawan: Split skb definitions into another header

 include/linux/lora/lorawan_netdev.h | 25 +----------
 include/linux/lora/lorawan_skb.h    | 33 ++++++++++++++
 net/lorawan/Kconfig                 |  3 +-
 net/lorawan/socket.c                | 68 +++++++++++------------------
 4 files changed, 62 insertions(+), 67 deletions(-)
 create mode 100644 include/linux/lora/lorawan_skb.h

-- 
2.20.1

