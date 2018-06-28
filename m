Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE76C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE2927142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="q+kf/8h4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EE2927142
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935024AbeF1JMj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 05:12:39 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:38516 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932761AbeF1JMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 05:12:37 -0400
Received: by mail-pf0-f169.google.com with SMTP id j17-v6so2308967pfn.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 02:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uGpksren+IV0V/e2X1/wR6PBVgFKD239SV0XekVeCtY=;
        b=q+kf/8h46QI7G9CaR5YhkspxcCemsseF1BNW3sf1F2TR/q8DLrIgmlw40fy0GbyQ+D
         N1Nk6fvWn7pqfHSfKpdrz3dLnjgQZXpxkGpXC3t4OZ6ADgxc9BHBpH0d+TEir119qXnc
         61kNOBw2LDKz8RlEVr3pqG4C47AEphq75TCRAsawV098KbmiZ/YWdqDJS5ojvMwmvs6R
         kaoZA8XuFCZOqFsUAjImNdPFzBSBdVwOPUrTvSwL2te8AJgxCEFBxeXXQDJsCmhgr0O3
         2V/gPlF51E9DvY++vg/wm2JmE4lj9/Qgf+KmCT1tOWVt74kg7wDnx5EtmXoSK47XKmRQ
         t3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uGpksren+IV0V/e2X1/wR6PBVgFKD239SV0XekVeCtY=;
        b=qk3YUSC5lKvxGbvH4FuOr1cRUAgfARWK+lUjogMA3C8cFEw6i6wFirMHeAdoWr0LeF
         y/XbmrQxZGjmbXG2V4bNWiWEVIOFOHQJucbutv/eWk1BnWdV9aw//nIApHjFOrFwPVMO
         oqqcGmI0suxEfVnW36oBlbJEdkxv9kMXdm4QOosPyKTKiDtCSdJi4ld8AMxFjGlXe/kl
         SopSka0Ly4+GyWWKTtE+cbPINjXo2daCVef3pJ8akgcin8R50pYgIannncckJk+0V6Br
         PsjwQNr/mZYeH7AELe4ZLyvx5Z09rrLsVLpfe9usVaNipYJrjVwr4YMbFKBzjSqx8Qzr
         LABA==
X-Gm-Message-State: APt69E0aHpDTkTfxLvZO9GaOWzeLOiP8VVDV6QiqSfZU9cbfhrRa09Rk
        bs/cRl9P5wFqayQJZamrxvvQdg==
X-Google-Smtp-Source: ADUXVKIVagfXpJ9PxhefeKqyFlcx0iSUbFkYf7qLDM7fTD7aRsXVyOSlMOlRLiD+HKTtwqhEF+u+tA==
X-Received: by 2002:a65:62ce:: with SMTP id m14-v6mr8145163pgv.407.1530177156245;
        Thu, 28 Jun 2018 02:12:36 -0700 (PDT)
Received: from ch-wrk-javier.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id x6-v6sm2223454pfx.185.2018.06.28.02.12.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Jun 2018 02:12:35 -0700 (PDT)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To:     mb@lightnvm.io
Cc:     hans.holmberg@cnexlabs.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH] lightnvm: pblk: recover chunk state on 1.2 devices
Date:   Thu, 28 Jun 2018 11:12:00 +0200
Message-Id: <1530177121-24908-1-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matias,

As discussed, here you have the patch reconstructing the state for 1.2
devices.

As mentioned in the patch itself, we make a tradeoff by doing this, as
writes might fail (or be more unstable) in case that a block has been
erased long before it is in used, and 1.2 does not have a way to
communicate this. The only thing the device can do is force an erase on
write when this happens, but if the device is responsible for this, one
could argue that it could prevent double-erases - which follows better
the predictability model we seek in Open-Channel.

Thoughts?

If we go this way, I will push a patch to the qemu 1.2 branch, as in the
initialization, we need to match empty page reporting with the block
metadata representing that the block is indeed erased. Ping me if you
want this patch in advance for testing.

Thanks,
Javier

Javier González (1):
  lightnvm: pblk: recover chunk state on 1.2 devices

 drivers/lightnvm/pblk-init.c | 138 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 124 insertions(+), 14 deletions(-)

-- 
2.7.4

