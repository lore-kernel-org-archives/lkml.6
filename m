Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB58CECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 06:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C8A2086E
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 06:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="GpFz4104"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C8A2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbeGOGWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 02:22:38 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:37940 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbeGOGWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 02:22:38 -0400
Received: by mail-lf0-f68.google.com with SMTP id a4-v6so29998010lff.5
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 23:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=sDGsdEPu5YYAQ3demoLNQLXvZncY1GnAMqg/DQp65/s=;
        b=GpFz4104eR2kOkmZ3Rm3DW9IWlNrzn3V7V+Ilr2oKtCZgJhS2WF4/VOlHZTchvExHQ
         wLXXhj1Dlh0GHwTtd9C6P5aqqmSoiHBcoIdSYcdQqjlGmSIpW1xKb/bQEy5zRTi9XdKn
         R7D48ibXecFOSKz1cb2yubz1OzDoha/rFBfv/U9rvuLCL5DDtiOt2tB9FPBfBAnwoQDH
         3XLjDD+D+wn8EWvl+epAv993nHSMFeWgHJh4pzx+tAo36l3CXhRUPipfRPDcvPgNTqi4
         nRRAqebHHf/u3pQXoTvbgJYYsFgFnMU5SsrAOJ5Rhh9dpsR284tsC8WIbDuJtgIOvPLy
         FP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=sDGsdEPu5YYAQ3demoLNQLXvZncY1GnAMqg/DQp65/s=;
        b=SJwSKg2f0CA4UYuxelcUA0Dy7cjQA4iTjqhEoPII+BVCjEwLVvwCQ24DaTDtPsj8aT
         2ZZdJDyr+AzzKao7++z/v7np5yliTle3KDYDr67xmwhpcQEcdseoYIGYz6i1s9XyW4yu
         +3+RJaPFHr0dB2SAAXmrqYi7ZWaSXgorJbVRCsThTQ4BLwhOoBmo+25zFDH+iJ3pWG4P
         lj//YAWwvpMZX57FEtsRtoqPY7H2KWwGyCb6oXm7Wq2Y3Z2fQKAUua385r/4rvG7ZSpI
         ys/LWNf5Cm2YMUbFSDIB1ewSpiwPQbXeZUDyFuu20toCg+o13TY0UvaMwDseC4osHukK
         oeRA==
X-Gm-Message-State: AOUpUlFTlrWSKt5+GBRwzjevhCx6PtqMJCt+q83zyDkv/WriGEZl+ZvO
        UpFP/HYSuc9JmXCrH8QiYtooxQ==
X-Google-Smtp-Source: AAOMgpePymxXjFUnTWNDiB++U+uv9FpwpFIHmgu1Vn8ZuS2vIldJfgwtqfaOSyFDw/gmdrK9nlS97Q==
X-Received: by 2002:a19:ca09:: with SMTP id a9-v6mr8407579lfg.142.1531634453137;
        Sat, 14 Jul 2018 23:00:53 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id z10-v6sm2561698ljh.57.2018.07.14.23.00.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Jul 2018 23:00:51 -0700 (PDT)
Date:   Sat, 14 Jul 2018 23:00:40 -0700
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     olof@lixom.net, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20180715060040.ni7w7mierlxk3wrv@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit f0463f3619fd10e0cbaa5195bf2bc264a77a586d:

  Merge tag 'omap-for-v4.18/fixes-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into fixes (2018-07-05 14:59:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to 13e66ceea1600f1061181acc2d4e0fac1a7d0333:

  Merge tag 'omap-for-v4.18/fixes-rc4-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into fixes (2018-07-14 15:14:02 -0700)

----------------------------------------------------------------
ARM: SoC fixes for 4.18-rc

 - A fix for OMAP5 and DRA7 to make the branch predictor hardening
   settings take proper effect on secondary cores
 - Disable USB OTG on am3517 since current driver isn't working
 - Fix thermal sensor register settings on Armada 38x
 - Fix suspend/resume IRQs on pxa3xx

----------------------------------------------------------------
Adam Ford (1):
      ARM: dts: am3517.dtsi:  Disable reference to OMAP3 OTG controller

Baruch Siach (1):
      ARM: dts: armada-38x: use the new thermal binding

Daniel Mack (1):
      ARM: pxa: irq: fix handling of ICMR registers in suspend/resume

Nishanth Menon (1):
      ARM: DRA7/OMAP5: Enable ACTLR[0] (Enable invalidates of BTB) for secondary cores

Olof Johansson (3):
      Merge tag 'pxa-fixes-4.18' of https://github.com/rjarzmik/linux into fixes
      Merge tag 'mvebu-fixes-4.18-1' of git://git.infradead.org/linux-mvebu into fixes
      Merge tag 'omap-for-v4.18/fixes-rc4-signed' of git://git.kernel.org/.../tmlind/linux-omap into fixes

 arch/arm/boot/dts/am3517.dtsi     |  5 +++++
 arch/arm/boot/dts/armada-38x.dtsi |  2 +-
 arch/arm/mach-omap2/omap-smp.c    | 41 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-pxa/irq.c           |  4 ++--
 4 files changed, 49 insertions(+), 3 deletions(-)
