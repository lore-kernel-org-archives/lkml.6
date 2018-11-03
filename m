Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F6EC0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 18:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC682081B
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 18:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Gif/GQ5L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC682081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbeKDD5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 23:57:47 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44338 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbeKDD5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 23:57:47 -0400
Received: by mail-lf1-f67.google.com with SMTP id m18-v6so3434914lfl.11
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 11:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=FV/pq+hAvOyCHNo9WKSSlWc+JQWHnfv4o5hvrUmdr4k=;
        b=Gif/GQ5LXVvvS8WsXXNF83Zvm8qewuM2ai/ZYZ2p67D+/Smk4hM9T/mm3tRAItBMhk
         WIymhabfvW6VaEVOkiC+vfzXzfzJDdiEerJH/EeW0jrADrYJ7RUxjApM+zeQLzXP0IJL
         J35F70XllOmKQMn4Sp1lbwaK0kEakeFy8Cpcd9zCeC1ByVWEvRRTzzjt9MP98xBPYXyM
         wjuWV3TjN/LOXW4LdW30IQurQTtnx1k+YrlUuZ1vXqKJMbIU28+L3tJ1UZTsaaaLU+D1
         RwACmXxkG0gJj0K8NUUueXfOkuQp5fAAnY05pc+fzCwEnuCpxojHCxerw1zcnw+fCkY0
         Adcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=FV/pq+hAvOyCHNo9WKSSlWc+JQWHnfv4o5hvrUmdr4k=;
        b=p0MdpOkz1cbSnhmiB/sPVNuvosV65RucapOFpZeQdE07P7xjVFG66O8I83KdfXtBwj
         56U6rkJRQUWy4pFzJgMUcjuv5SreyyJSV8g+GqHUpTHyto9NQj3BU8kL8Dm8QtVkA0tX
         64VfrZzRtfJ4Ed0e6wZcSav7DvQALWb/pbCjT0ml2RW1pDx6icmLbUOXn35CWuf1D24x
         rHLuZ1RLdeoJ9cXMDcIIc4Bz6+NAR9PBNYB0Ev6RN9SWtrZ+s1vc9qpKkvNASr71hDi7
         /7GCtVnOooHqMqwkx8NyN4ipGXrJRu/SoS5hmpDCtHymmJLcvfKZE1CT1EAoL186GU+3
         /yCQ==
X-Gm-Message-State: AGRZ1gIVwE6HQk5VFKpcrs6VG7va9Gh/4SGabi1KiewckCcDyEUwNjjd
        +LfrdSTgO0hYbWFwaGQXDINx3QwJc2TpVQ==
X-Google-Smtp-Source: AJdET5d/XbyUueDUSarL1M0rZkWEEUzv5NUFJw7gp2XfMkRlx2H7MiwE9cutQ+jXJDm6RccGPyOsmA==
X-Received: by 2002:a19:a9d2:: with SMTP id s201mr9065403lfe.154.1541270740302;
        Sat, 03 Nov 2018 11:45:40 -0700 (PDT)
Received: from localhost ([85.30.9.151])
        by smtp.gmail.com with ESMTPSA id q5-v6sm5706344lfj.85.2018.11.03.11.45.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 03 Nov 2018 11:45:38 -0700 (PDT)
Date:   Sat, 3 Nov 2018 11:45:28 -0700
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     olof@lixom.net, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20181103184528.apzyn447zjk27dat@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 4b42745211af552f170f38a1b97f4a112b5da6b2:

  Merge tag 'armsoc-soc' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc (2018-10-29 15:37:33 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to 8008cc78d3d6f5191ffcb2b85a423d516000e7f4:

  Merge tag 'omap-for-v4.20/omap1-fix-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into fixes (2018-11-02 22:31:40 -0700)

----------------------------------------------------------------
ARM: SoC fixes

A few fixes who have come in near or during the merge window:

 - Removal of a VLA usage in Marvell mpp platform code
 - Enable some IPMI options for ARM64 servers by default, helps testing
 - Enable PREEMPT on 32-bit ARMv7 defconfig
 - Minor fix for stm32 DT (removal of an unused DMA property)
 - Bugfix for TI OMAP1-based ams-delta (-EINVAL -> IRQ_NOTCONNECTED)

----------------------------------------------------------------
Alexandre Torgue (1):
      ARM: dts: stm32: update HASH1 dmas property on stm32mp157c

Arnd Bergmann (1):
      ARM: orion: avoid VLA in orion_mpp_conf

Janusz Krzysztofik (1):
      ARM: OMAP1: ams-delta: Fix impossible .irq < 0

John Garry (1):
      arm64: defconfig: Enable some IPMI configs

Linus Walleij (1):
      ARM: defconfig: Update multi_v7 to use PREEMPT

Marc Zyngier (1):
      soc: ti: QMSS: Fix usage of irq_set_affinity_hint

Olof Johansson (1):
      Merge tag 'omap-for-v4.20/omap1-fix-signed' of git://git.kernel.org/.../tmlind/linux-omap into fixes

 arch/arm/boot/dts/stm32mp157c.dtsi    |  2 +-
 arch/arm/configs/multi_v7_defconfig   |  1 +
 arch/arm/mach-omap1/board-ams-delta.c |  8 ++------
 arch/arm/plat-orion/mpp.c             |  7 ++++++-
 arch/arm64/configs/defconfig          |  3 +++
 drivers/soc/ti/knav_qmss.h            |  4 ++--
 drivers/soc/ti/knav_qmss_acc.c        | 10 +++++-----
 drivers/soc/ti/knav_qmss_queue.c      | 22 +++++++++++++++-------
 8 files changed, 35 insertions(+), 22 deletions(-)
