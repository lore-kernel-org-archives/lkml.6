Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90126C04EBA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E2E32148E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+U5KVvA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E2E32148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731639AbeKTEVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 23:21:09 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39471 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731402AbeKTEVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 23:21:09 -0500
Received: by mail-pg1-f195.google.com with SMTP id w6so1896900pgl.6;
        Mon, 19 Nov 2018 09:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jYulbVosGi/9fvD3So5cJFK0PExpJWwoT2t0QGEcK3g=;
        b=h+U5KVvAwiz+7PJu5JBztBcfHWKTmyimV1fLGlP7wORxcJ1TOxD89ysymBYzszVz3X
         4r18OMsciYNDVfqxTJH1xq14vvLwRmTLO6j9/KdSAa75gBW0CBagLSYd63AaPuJNV++Q
         pXk5LTyE0b6VMhn7bW1LHQT7sULtzOupWNzsE+IHePOMZ6Bzu4kB9ct2pWnCvd0Ny7jE
         bM7r3suFtKsYQP6UIUhyzrSIMG4z5MIZs593p8LpiqhmYLp6qh7zOTtZ8NMhpC622cCf
         ripgAxWKxGNwyQVYihiIyR2DWWVZL5IK7yTaRqL4RwQ8PfU8/BVERIHMATmSJUMyrjkd
         8iAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jYulbVosGi/9fvD3So5cJFK0PExpJWwoT2t0QGEcK3g=;
        b=LvyoGlOBUcH4WGI2fmz2yKbNbVOWLlAWol8LwY/8Gpdv266b0+eD07PHtyeCaYZxGO
         IBCJUaz2yn0gTo9d9uavIXyj9pp+THcYdCdI/iIxGtvE0pj+371WBqq+2i6d1jsE5rlq
         XvxseJDGSx96T346cGQnMAGuvbqoOte1+QOqvsadayemsKAISIDPljpgN5wUBPIXKB+n
         J/kn0K/+FEpL3o1dhJAeniShNikref3RcjAL5HVJT/jjO2N5lEC+q9LvazCyxqBLRfeU
         Rde4sbSaAUQBESsztblI6SOV8zngXdLUxW6XY6NvWt9OudeWxlOP1Qv/rgm3alERlI9v
         4OiA==
X-Gm-Message-State: AGRZ1gIKvIRwqfgGZ5QCx8EgWLuQUtT2Q+TrHW1U9YJ0KLTQSkJfx2Jm
        uRnsghyS+BdWynCalR9vIoQ=
X-Google-Smtp-Source: AJdET5dSS9A8MPA9odiuQg/oDgl6vP90CB+8o7bR8d4RGUQCY1mAlmEP79dhCY4BBKGwArs4xdg4cA==
X-Received: by 2002:a62:6001:: with SMTP id u1-v6mr12772773pfb.130.1542650195992;
        Mon, 19 Nov 2018 09:56:35 -0800 (PST)
Received: from stbirv-lnx-3.igp.broadcom.net (igp-prod-emp-gw.vpn.broadcom.com. [192.19.223.250])
        by smtp.gmail.com with ESMTPSA id x123-v6sm56159846pfb.124.2018.11.19.09.56.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Nov 2018 09:56:35 -0800 (PST)
From:   Doug Berger <opendmb@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Doug Berger <opendmb@gmail.com>
Subject: [PATCH net-next v2 0/2] net: bcmgenet: fix aborted suspend
Date:   Mon, 19 Nov 2018 09:56:00 -0800
Message-Id: <1542650162-9229-1-git-send-email-opendmb@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not enough to return an error code from the driver suspend
routine. The driver must also restore the device functionality.

This commit corrects the issue introduced by commit 0db55093b566 
("net: bcmgenet: return correct value 'ret' from bcmgenet_power_down")
by calling the driver resume function if the suspend function returns
an error.

Changes in v2:
- Removed accidentally included write to HFB register

Doug Berger (2):
  net: bcmgenet: code movement
  net: bcmgenet: abort suspend on error

 drivers/net/ethernet/broadcom/genet/bcmgenet.c     | 63 +++++++++++-----------
 drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c |  2 +
 2 files changed, 35 insertions(+), 30 deletions(-)

-- 
2.7.4

