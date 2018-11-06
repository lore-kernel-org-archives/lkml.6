Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3910C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E5820869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="mpe0M/nw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71E5820869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388309AbeKFW6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:58:54 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:36716 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388111AbeKFW6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 17:58:53 -0500
Received: by mail-it1-f196.google.com with SMTP id w7-v6so17603422itd.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 05:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=56kHi9j0wGZevuI7rRWeoo7guXBMz/aip8CvDcy64JQ=;
        b=mpe0M/nwQOPwzTv+tCJvTqSaFX1cuSkXyoKrANyw6wHzWkmfis0FDaDvNMuEqp5ac8
         1RWOmOHrts09vZcEYlmr/EahhAXMIhbI+Xn23i3y4xdupyW2x+Ou8ZfgesAa4NHRctyN
         o19JMeKJ/BbLwuPAmwC66NNQXuPbOym87dpFxhEwnl3Fr5LI94BcT16E/RULFvU8V/7h
         w8kz6l6jDFAh9JJDyTly1M8BpZwjfTVwP4qVBFiTlCICpngKERt18qwTBlg35ja623Oq
         KkTtTHD2BD2+9IBb05VYy0WJK/fxOJBnSOGox+jLy2k5+kWAOZjrOTFG7FROEa0C3/qG
         0eIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=56kHi9j0wGZevuI7rRWeoo7guXBMz/aip8CvDcy64JQ=;
        b=qOvLCX3kKB+01cEgdDZSKQbUuHJ6EzMlvBXtQDjgJEYCypyTv4vpsZL6hWYS35fO6y
         vCPkCYZaHu/fkGahQ8q2oyNB/HjXu167PWAOIh2LXVQu0l4DGnePbPn2aarVM5/oka/F
         c56qNatQ87NbGRdMRS8j+ctuDx4KIsaMd7Jli8XgfjcxNAVqmM7FiFhXpw3SUfqyFWyS
         dnpYf9iLSpqB/8UotlYDhsDj1J2BYPDgAGA3Kj+R6+h7wWnhsfi7yijrKV7VPpWIQ21d
         Yx1BZxj+CHBk0U9mRAkbG5EC2SqJyVZf1zeRESjwZC2gzQGXRXLUCqlo+Rlt8MnrOHWz
         lPNg==
X-Gm-Message-State: AGRZ1gJiolFE9RWhYlH+eCIrvEDoxSJJ3WhHorbHUBlfD6wvY+ycNqXw
        3wSxxRhLEyv7t7rDcJEwYkm5J2WeeFJaww==
X-Google-Smtp-Source: AJdET5eI+69JEeInrRBgGBaIh2yEm8YoKHqmG6ga9IISIpLm9yD8LIwsci22tK1hCKdiLCTygMdE5g==
X-Received: by 2002:a02:3545:: with SMTP id y5-v6mr582649jae.7.1541511218609;
        Tue, 06 Nov 2018 05:33:38 -0800 (PST)
Received: from ch-lap-hans.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id u132-v6sm897282itb.21.2018.11.06.05.33.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 05:33:38 -0800 (PST)
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     Javier Gonzales <javier@cnexlabs.com>,
        Sebastien Boisvert <sboisvert@gydle.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH v3 0/7] PBLK Bugfixes and cleanups
Date:   Tue,  6 Nov 2018 14:33:23 +0100
Message-Id: <20181106133330.26570-1-hans.ml.holmberg@owltronix.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

This series is a slew of bugfixes and cleanups for PBLK, mostly
fixing issues found during corner-case testing in QEMU.

Changes since v1:
	Messed up from:, now the patches apply with the correct author
	Pardon the mess.

Changes since v2:
	Fixed kbuild reported issue and potential divide by zero in:
		("lightnvm: pblk: set conservative threshold for user writes")
	Fixed commit message nitpicks reported by Sebastien

The patch-set applies on top of:
	remote https://github.com/OpenChannelSSD/linux.git
	branch for-4.21/core

Hans Holmberg (7):
  lightnvm: pblk: fix resubmission of overwritten write err lbas
  lightnvm: pblk: account for write error sectors in emeta
  lightnvm: pblk: stop writes gracefully when running out of lines
  lightnvm: pblk: set conservative threshold for user writes
  lightnvm: pblk: remove unused macro
  lightnvm: pblk: fix pblk_lines_init error handling path
  lightnvm: pblk: remove dead code in pblk_recov_l2p

 drivers/lightnvm/pblk-init.c     | 45 ++++++++++++++++++--------
 drivers/lightnvm/pblk-map.c      | 47 ++++++++++++++++-----------
 drivers/lightnvm/pblk-recovery.c |  1 -
 drivers/lightnvm/pblk-rl.c       |  5 ++-
 drivers/lightnvm/pblk-write.c    | 55 +++++++++++++++++++++++---------
 drivers/lightnvm/pblk.h          | 16 ++++++++--
 6 files changed, 116 insertions(+), 53 deletions(-)

-- 
2.17.1

