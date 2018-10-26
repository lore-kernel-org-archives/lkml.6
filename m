Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B681DECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6362B20868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yl2UCMAg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6362B20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbeJ0ELz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 00:11:55 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37412 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeJ0ELy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 00:11:54 -0400
Received: by mail-lf1-f68.google.com with SMTP id a82-v6so1756219lfa.4;
        Fri, 26 Oct 2018 12:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GJOhQPWjNJWc47h5RHXoaFfzyEX612uR9+ckyp4oTqQ=;
        b=Yl2UCMAg10fQIFyI4EeL2uyrtHP2ZYxCq/IfHzlJG6J/Pg/mDYKx5GO3JbrfbwUYAe
         f51y5TlIL7x3FW590eTW9gZzOXMZmg1vOSIhht2jWcpO7ev6a8dp1hEbdlkR46qFDj5G
         wsxRxR9OeJXiJTkMwrGXZzgwm6v4LS44ZS/Z01KoVjskTtkmEUeqOOAhYXCsD5GhfCNh
         yUIFMxyApNFF9fMtUbiJB21h7l7nZKI/Af87NQJvEDW0m07AxjIDvKME8RgCEeM2W30j
         oyhyAmTBRuPSqbGVmWmSWmnt2QRi4vhMzrarPgddpNYp53LNiWig2HxHNxFA8ZEGP7hT
         mOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GJOhQPWjNJWc47h5RHXoaFfzyEX612uR9+ckyp4oTqQ=;
        b=QpqPemybOiaID0lO8XgLqrEwx1bW9ECfL//xopuE6bc5UypuJ5rdyn4OuV7AV0RulO
         DqsRvH1yaSxxIctO580HqgXgNM7DjypXfMfIepNF4zJuyvS9BKW63kvXXS0/tjuCLUQs
         hp+irtUY/QB3uKy8O4rjAX3DB8Mm/8h91wYsz11SAb4ySNbshu/qjfApMRfMB5FBRisq
         HBnLID5tj3w4P+rMrA8zyF2YFKCWDVmW1QzLImrrrAoBLtHSt6nEEjFdD+5dOvgVZdGM
         7tIJCi84oT6WBhaMaUcH+jNvStBkIe7oQP4Led1Il9eIKv3kDO7k6Ha93wgntqIbsbDV
         QMsQ==
X-Gm-Message-State: AGRZ1gKFugEgjqAU1Vd4Ob8iT/ImYkb1uAZCmzs+6qVVQp3KpjSl/anQ
        r1QBZM9Aw7DUaAUKJkBLOJw=
X-Google-Smtp-Source: AJdET5fXCmISywzPcLPpKVqNDPs5kPHqwBBpIZpKoyWQDIlZ9sQr57g/C9hyw3Rxc68H4dU1eWizMQ==
X-Received: by 2002:a19:641d:: with SMTP id y29mr662452lfb.14.1540582415268;
        Fri, 26 Oct 2018 12:33:35 -0700 (PDT)
Received: from i4790k.home (bfy71.neoplus.adsl.tpnet.pl. [83.28.62.71])
        by smtp.gmail.com with ESMTPSA id l25-v6sm1684662ljg.52.2018.10.26.12.33.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Oct 2018 12:33:34 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        jacek.anaszewski@gmail.com, liviu@dudau.co.uk
Subject: [GIT PULL] LED fix for 4.20-rc1
Date:   Fri, 26 Oct 2018 21:33:28 +0200
Message-Id: <1540582408-6422-1-git-send-email-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull one LED fix for 4.20-rc1.

The patch fixes regression introduced by the commit
45d4c6de4e49 ("leds: gpio: Try to lookup gpiod from device").

The following changes since commit 8dbac65f5c181e4723586ab738b703bb23bc3f2a:

  leds: sc27xx: Add pattern_set/clear interfaces for LED controller (2018-10-11 21:59:11 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds.git tags/led-fix-for-4.20-rc1

for you to fetch changes up to 72b8ad40e14302f869382656a914bb803796b4ed:

  leds: gpio: set led_dat->gpiod pointer for OF defined GPIO leds (2018-10-26 20:51:36 +0200)

Thanks,
Jacek Anaszewski

----------------------------------------------------------------
LED fix for 4-20-rc1
----------------------------------------------------------------
Liviu Dudau (1):
      leds: gpio: set led_dat->gpiod pointer for OF defined GPIO leds

 drivers/leds/leds-gpio.c | 2 ++
 1 file changed, 2 insertions(+)
