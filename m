Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793E9C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F42B20875
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWqoXo22"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F42B20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937683AbeFSLC4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 07:02:56 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36376 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937591AbeFSLCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 07:02:54 -0400
Received: by mail-lf0-f66.google.com with SMTP id n24-v6so13709430lfh.3;
        Tue, 19 Jun 2018 04:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k2AjFWH5VJWYmqWsfsTFaDjaSvUX9Qc+cO59Tjwor+k=;
        b=jWqoXo22WnqKGYu7L7WFTcyHhiYILtGGCG1EAcjqePwE2QDfxyCI8EKiCvXAhLzOx7
         cgYDmMSGzVuEpaZctj8RvzneAPtAxv2vIxWMRMTGysGWesUk2C69ERa4Ji1FPzCCMdnf
         Iu2Dsirta4sHsj8nrORptOtolbM89xGD3M8R+uV7exWMIAKKsqQt2aiHX09mIGeqMbUC
         HKK1c86i1KvZw+9x5h0qbyDh/O3I4xEYuzsCsGpflhihxolTxewqHxe+7UcXH3uwsk1f
         iicr7A2OYI+LrfATowYx9YJNrrUa8h55198ugovvFKSsKxHxLiz47irxBTSkZzH6OJ5L
         GFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k2AjFWH5VJWYmqWsfsTFaDjaSvUX9Qc+cO59Tjwor+k=;
        b=qfQ+plFCDiLFns6OPywwr+gJiEV0J38jJbDiWzbUi09C61g1PyxOC0Y+BXbbI/OxEP
         /UXMbaj5Rtf66SZ7PUzomZlYD/pqENpqTwd12AMat7z3v9rhceHOGfPdBTP8m28XLySi
         J20+BvpO/ulOoFgQkPjHhvjW/LDKSMsxN1RrzPQ2drrzBUt6/jFmVzxV/YmaJ4BTs4y8
         LrsXeNNgbx58t0ncrO8xy0wtFe7dxMxbyRB8mH6Petumi88ak4njTAvi6944vD/c0FaX
         aADBkwyVDjkOgLc2Ny04CJl7UnmtInjwqATAFZox5PWQRUhUT3vW8iIMn9/wV8dohE6i
         2rXQ==
X-Gm-Message-State: APt69E3S98gRnMtSMyxwA0Tb3gteMzFfIvr25KT5w6rhbzlFewiTAOd+
        Jr88VQXDOcwkJCkZI0SKLXY=
X-Google-Smtp-Source: ADUXVKId+slNCLbFFJqYRoxV18tWK0q+QAA97p1Y6in4sWZp/Fx0JgjZ0IIHMNbLKkC43gPHkqGywA==
X-Received: by 2002:a2e:8549:: with SMTP id u9-v6mr10535125ljj.10.1529406172538;
        Tue, 19 Jun 2018 04:02:52 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-84.nat.spd-mgts.ru. [109.252.91.84])
        by smtp.gmail.com with ESMTPSA id m84-v6sm3118543lje.91.2018.06.19.04.02.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 04:02:51 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 0/5] Initial support of Trusted Foundations on Tegra30
Date:   Tue, 19 Jun 2018 14:00:22 +0300
Message-Id: <20180619110027.16935-1-digetx@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series of patches brings initial support of Trusted Foundations to
Tegra30, that is to the consumer-grade Tegra30 devices which do not allow
to easily replace the proprietary bootloader. Support is initial because
this series implements only a proper CPU boot-up (main + secondary cores)
and a basic L2 cache maintenance that is done using the TF firmware.
Suspend-resume support is missing yet as I couldn't get it to work
(CPU hangs on resume from suspend after awhile and seems that is related
to inappropriately done cache maintenance during of suspend-resume using
the firmware), it is work-in-progress for now.

This patchset is partially based on the work done by Michał Mirosław [0].

[0] https://www.spinics.net/lists/linux-tegra/msg30368.html

Changelog:

v2:
	- The "Don't apply CPU erratas in insecure mode" patch got some
	  cleanup, in particular resolved the messiness in
	  __tegra_cpu_reset_handler_data.

	- Added a comment to tf_cache_write_sec(), justifying the warning
	  message.

Dmitry Osipenko (5):
  ARM: trusted_foundations: Implement L2 cache initialization callback
  ARM: trusted_foundations: Provide information about whether firmware
    is registered
  ARM: tegra: Setup L2 cache using Trusted Foundations firmware
  ARM: tegra: Don't apply CPU erratas in insecure mode
  ARM: tegra: Always boot CPU in ARM-mode

 arch/arm/firmware/trusted_foundations.c    | 32 ++++++++++++++++++++++
 arch/arm/include/asm/trusted_foundations.h |  7 +++++
 arch/arm/mach-tegra/reset-handler.S        | 25 +++++++++--------
 arch/arm/mach-tegra/reset.c                |  5 +++-
 arch/arm/mach-tegra/reset.h                |  9 ++++--
 arch/arm/mach-tegra/sleep-tegra20.S        |  4 +++
 arch/arm/mach-tegra/tegra.c                | 15 ++++++++++
 7 files changed, 82 insertions(+), 15 deletions(-)

-- 
2.17.1

