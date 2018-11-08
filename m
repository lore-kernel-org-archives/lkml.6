Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC72ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 19:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB86204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 19:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtTe3Vyg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB86204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbeKIFGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 00:06:14 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37659 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbeKIFGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 00:06:14 -0500
Received: by mail-lj1-f194.google.com with SMTP id e5-v6so14922399lja.4;
        Thu, 08 Nov 2018 11:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=96XksKF66So0MldFrodJPIL7MvbSVAgZNb6Ic+qZpoc=;
        b=HtTe3VygohsBVCuFE5XJdvJQlE+NQpO5mBhuHTnBh7cuWdGkcCMmSZSXbLacl38yu3
         d9RlAQNskzEUNBcXMLH8Zfk/yDsLCstHan/c7YZcJy71Alw2/rEjFNlPxa4LfqWo6pWk
         dKERhdEv75EK32e8CLLwumoHYp3oaE4RAvfTaLLpf7rw8nXjI/lkBNjQrfF8F14EPFkR
         ZrvdpglJwAnrRGfH7Ac6cMAb/YFWKgj2EKCVd+w+CpNqr0wkwDPWDyy1L8ENK0ia0sdO
         1HWTqCcMrjPUB/O26oLLCpz4K9GnTjJ6C2eidua0N9/z+zmzles/h4MNVhxU4ktyUO4d
         759w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=96XksKF66So0MldFrodJPIL7MvbSVAgZNb6Ic+qZpoc=;
        b=ORwZBG0uCXm3vy/UmCRdBL6mebmhJz3UXjucSW6IoO1dtoQn5jEBIYnkknd9vKMRj+
         APpBDFpfT79l3fUDB707su0izEcHdthyt5s1yWpvjJYvQ1Sq64C5A23ruJQXbDizeB5T
         VhcJrT2iCABKolVVN+qQ2ItxGV7LopCHCCR739CZmd89dT+wvl6LrsA9tS4mQlbRw0E/
         qhiSDmL5MqNSfCXhkhoktYKQ1SgdVmpMJgMVDewn5s50oKomOdB3q7bYjU248XcwFLm2
         ejpzEcKp16s5N/xt5t3dlcJhDh2gSMYRpCWvnH/sZDiRoHTg2KgBvzxBVZ7QQRSxBrMN
         A8xQ==
X-Gm-Message-State: AGRZ1gIjcKz5b6use5HYbNlp+vU5oNJ4kxsNwOh7LZyh9OZFcNE/dPii
        Eziqv2PARewEA9V3b13UzwM=
X-Google-Smtp-Source: AJdET5cnpP7XJ3J4H+iY5ZcN2xl4jJ3DFdf8vGvnE2McWGS70tLTeeepbNKw3GLckjdbY5QJk+2xRA==
X-Received: by 2002:a2e:45d:: with SMTP id 90-v6mr3742514lje.110.1541705358790;
        Thu, 08 Nov 2018 11:29:18 -0800 (PST)
Received: from i4790k.home (dkl219.neoplus.adsl.tpnet.pl. [83.24.15.219])
        by smtp.gmail.com with ESMTPSA id w16-v6sm802954ljw.11.2018.11.08.11.29.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Nov 2018 11:29:18 -0800 (PST)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        jacek.anaszewski@gmail.com, baolin.wang@linaro.org,
        geert+renesas@glider.be, pavel@ucw.cz
Subject: [GIT PULL] LED fixes for 4.20-rc2
Date:   Thu,  8 Nov 2018 20:29:08 +0100
Message-Id: <1541705348-4615-1-git-send-email-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull LED fixes for 4.20-rc2.

All three fixes are related to the newly added pattern trigger:

- remove mutex_lock() from timer callback, which would trigger problems
  related to sleeping in atomic context, the removal is harmless since
  mutex protection turned out to be redundant in this case
- fix pattern parsing to properly handle intervals with brightness == 0
- fix typos in the ABI documentation

The following changes since commit 8dbac65f5c181e4723586ab738b703bb23bc3f2a:

  leds: sc27xx: Add pattern_set/clear interfaces for LED controller (2018-10-11 21:59:11 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds.git tags/led-fixes-for-4.20-rc2

for you to fetch changes up to 406e7f986b2e4499295351bcfff5c93b0d34022a:

  Documentation: ABI: led-trigger-pattern: Fix typos (2018-11-07 21:43:46 +0100)

Thanks,
Jacek Anaszewski

----------------------------------------------------------------
LED fixes for 4.20-rc2
----------------------------------------------------------------
Baolin Wang (1):
      leds: trigger: Fix sleeping function called from invalid context

Geert Uytterhoeven (1):
      Documentation: ABI: led-trigger-pattern: Fix typos

Pavel Machek (1):
      Fix pattern handling optimalization

 .../ABI/testing/sysfs-class-led-trigger-pattern    |  4 ++--
 drivers/leds/trigger/ledtrig-pattern.c             | 27 +++++++---------------
 2 files changed, 10 insertions(+), 21 deletions(-)
