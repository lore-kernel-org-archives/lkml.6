Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5102AC3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 16:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1042208D5
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 16:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="LHgENm2y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1042208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932383AbeGHQcU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 12:32:20 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37379 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754213AbeGHQcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 12:32:19 -0400
Received: by mail-lj1-f196.google.com with SMTP id v9-v6so2038300ljk.4
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 09:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=YX0ZmiWPq8K6ekcnG7lTmysl2VGtKqtc73/KO5+C0Ko=;
        b=LHgENm2yWrRvePaeX8yWGrQ/EK4aAjUE4goGtNGannkHWvI3yXe0JiPssSsbrCBLEg
         hz+uos7/yRNWdiN2/8WZrjfnWL4JbdA+RSzknWENiubs2rznsj4271lfPYRbFNN4/jt+
         z9RuUdNnVteyzKHyvhCt2VjMn4+HJQf/Nsg9zAN0n/gN2ngHx43Cjef+GMO8dxNcOoEc
         1cX87tWkUJfM4bGf6gpAjtaV68o5iEUEKlS0ZDdZ3kznxq6nT6c1flbT9UG4msBr35+v
         onOhONA1cm3nznjlhxafWxaJ/zGb3TUr0oFFMzcYEj6JcQwg+UVsM/adxnlyyhmwadEP
         7AyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=YX0ZmiWPq8K6ekcnG7lTmysl2VGtKqtc73/KO5+C0Ko=;
        b=bvvr7RTeWpMid/rH8s2jPoJ0ysjYpWfBc1vlDaN7sLE5l8Jy8q0tZddSDwnlJp8aJ0
         D/7BddEd2IEtq64eiBefNfBd1iKqOW5XWMgLScug1vSyMAgWvFYM/o49IiOUuXYvMDsa
         NT3Y3rYjfjPGcAVnJozw7UWrSua6lRvr/wL4vtLR4obFI1i5Q5mE2LlI57NQAqCxzn2K
         j6OennA7mUMlT77mdf6HYbrzuAB+vrSrs0ZWGh20o8VDXZ34DLUb5Mubz9stLbmdkCsn
         4VlqHPY3vhalwP5tPxkamDij0Fogd3AhoH9DCe2PQHS6XAMbX61nPU3mfYgWi6fuiF+S
         EZ6w==
X-Gm-Message-State: APt69E0ahC9RvGhaHsHU5AQfwBmpt3r9btZrEjJCXFQ7KWAgG7iF2ZIF
        GUvcVr6SYEY62bkQjc5JzwuK9NDe
X-Google-Smtp-Source: AAOMgpeRu+er7DUPlXA44Khnb4mgwc0ehkp9j0PyOS3U+j5BJJekp3c/9fwS+Eq0nJiFaEW9HSjvnA==
X-Received: by 2002:a2e:5810:: with SMTP id m16-v6mr10522610ljb.134.1531067537683;
        Sun, 08 Jul 2018 09:32:17 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id e20-v6sm3415490lff.41.2018.07.08.09.32.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 09:32:15 -0700 (PDT)
Date:   Sun, 8 Jul 2018 09:32:08 -0700
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     olof@lixom.net, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20180708163208.hljszsjjt2q3jrt3@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 021c91791a5e7e85c567452f1be3e4c2c6cb6063:

  Linux 4.18-rc3 (2018-07-01 16:04:53 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to f0463f3619fd10e0cbaa5195bf2bc264a77a586d:

  Merge tag 'omap-for-v4.18/fixes-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into fixes (2018-07-05 14:59:20 -0700)

----------------------------------------------------------------
ARM: SoC fixes for 4.18-rc

A small collection of fixes, sort of the usual at this point, all for
i.MX or OMAP:
 - Enable ULPI drivers on i.MX to avoid a hang
 - Pinctrl fix for touchscreen on i.MX51 ZII RDU1
 - Fixes for ethernet clock references on am3517
 - mmc0 write protect detection fix for am335x
 - kzalloc->kcalloc conversion in an OMAP driver
 - USB metastability fix for USB on dra7
 - Fix touchscreen wakeup on am437x

----------------------------------------------------------------
Adam Ford (1):
      ARM: dts: omap3: Fix am3517 mdio and emac clock references

Daniel Mack (1):
      ARM: dts: am437x: make edt-ft5x06 a wakeup source

Fabio Estevam (2):
      ARM: imx_v6_v7_defconfig: Select ULPI support
      ARM: imx_v4_v5_defconfig: Select ULPI support

Kees Cook (1):
      bus: ti-sysc: Use 2-factor allocator arguments

Nick Dyer (1):
      ARM: dts: imx51-zii-rdu1: fix touchscreen pinctrl

Olof Johansson (2):
      Merge tag 'imx-fixes-4.18-2' of git://git.kernel.org/.../shawnguo/linux into fixes
      Merge tag 'omap-for-v4.18/fixes-signed' of git://git.kernel.org/.../tmlind/linux-omap into fixes

Robert Nelson (1):
      ARM: dts: am335x-bone-common: Fix mmc0 Write Protect

Roger Quadros (1):
      ARM: dts: dra7: Disable metastability workaround for USB2

Tony Lindgren (1):
      Merge branch 'omap-for-v4.19/ti-sysc' into omap-for-v4.18/fixes

 arch/arm/boot/dts/am335x-bone-common.dtsi | 1 -
 arch/arm/boot/dts/am3517.dtsi             | 4 ++++
 arch/arm/boot/dts/am437x-sk-evm.dts       | 2 ++
 arch/arm/boot/dts/dra7.dtsi               | 2 +-
 arch/arm/boot/dts/imx51-zii-rdu1.dts      | 2 +-
 arch/arm/configs/imx_v4_v5_defconfig      | 2 ++
 arch/arm/configs/imx_v6_v7_defconfig      | 2 ++
 drivers/bus/ti-sysc.c                     | 8 ++++----
 8 files changed, 16 insertions(+), 7 deletions(-)
