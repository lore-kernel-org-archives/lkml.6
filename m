Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED60C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E0420645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58E0420645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbeIFAJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 20:09:21 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:40273 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727837AbeIFAJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 20:09:20 -0400
Received: by mail-oi0-f67.google.com with SMTP id l202-v6so15923528oig.7;
        Wed, 05 Sep 2018 12:37:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4APqHNciYZjZS3EugIoFs9GFE85Jl8bHAT/cKmZ9y58=;
        b=SZR9PvClDsDB4FjK+15f3f0vqxbGc2elukEFxgPQBsv6DdvxUh3SfmrzRZecDXvkGx
         XSnftPD3kPfyvbNY3hJOtzVd9CQJBwQdjEVo2BQQAAtxsLEluOCZnSTaWuwFSStjBdLs
         aykkX090YpBWSS+5ypPFQGc4JQHAIc6ZwIYO4tbrv0R7UOS3Vcpm9cfIDFcIrlx6YceY
         K47o7Ubtn8PJ3fvifEJwGRsdw501LA4s+6HYMqjIxVfSakyn4Ug2K3U8L+Nh5lgx9IQe
         c/lH5fK2dw/+v1E+8GLpzu2ZvyXRD2YL51Y8FdgpE8F+UzbfIswaVL5g2knWZWOAsFLh
         03mQ==
X-Gm-Message-State: APzg51C5Q+Xhc/wgWmhng5nkCc1k48s92shNsnfMtUIyVGcmMXltY2xa
        pYVyUkSPxtGZzeIrePUlahK0/Xc=
X-Google-Smtp-Source: ANB0VdYvbIYoBZ9f2BtttdNY9AmkVGIM+oNDjHTZljQbfq9Mr9aAzgV5JKb9HySdPry0/gKPHonhwQ==
X-Received: by 2002:aca:b585:: with SMTP id e127-v6mr30608185oif.119.1536176261256;
        Wed, 05 Sep 2018 12:37:41 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u21-v6sm2296053oie.22.2018.09.05.12.37.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 12:37:40 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        dri-devel@lists.freedesktop.org, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        Jonas Bonn <jonas@southpole.se>,
        Ley Foon Tan <lftan@altera.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Mark Salter <msalter@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Rich Felker <dalias@libc.org>,
        Simon Horman <horms@verge.net.au>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Bordug <vitb@kernel.crashing.org>,
        Will Deacon <will.deacon@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-clk@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org
Subject: [PATCH 00/21] DT cpu node iterator
Date:   Wed,  5 Sep 2018 14:37:17 -0500
Message-Id: <20180905193738.19325-1-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds an iterator for cpu nodes and converts users over to use
it or of_get_cpu_node in some cases. This allows us to remove the
dependency on device_type property for cpu nodes though removing that
from DTS files will have to wait for some time. In some cases, this makes
the DT search more strict by only looking in /cpus child nodes rather
than any node with the device_type == cpu. The iterator also honors the
status property which is often forgotten.

I've only tested on ARM under QEMU and compiled powerpc.

Rob

Rob Herring (21):
  of: Add cpu node iterator for_each_of_cpu_node()
  of: Support matching cpu nodes with no 'reg' property
  ARM: use for_each_of_cpu_node iterator
  ARM: topology: remove unneeded check for /cpus node
  ARM: shmobile: use for_each_of_cpu_node iterator
  arm64: use for_each_of_cpu_node iterator
  c6x: use for_each_of_cpu_node iterator
  microblaze: get cpu node with of_get_cpu_node
  nios2: get cpu node with of_get_cpu_node
  openrisc: use for_each_of_cpu_node iterator
  powerpc: use for_each_of_cpu_node iterator
  powerpc: 4xx: get cpu node with of_get_cpu_node
  powerpc: 8xx: get cpu node with of_get_cpu_node
  riscv: use for_each_of_cpu_node iterator
  SH: use for_each_of_cpu_node iterator
  x86: DT: use for_each_of_cpu_node iterator
  clk: mvebu: use for_each_of_cpu_node iterator
  edac: cpc925: use for_each_of_cpu_node iterator
  iommu: fsl_pamu: use for_each_of_cpu_node iterator
  of: use for_each_of_cpu_node iterator
  fbdev: fsl-diu: get cpu node with of_get_cpu_node

 arch/arm/kernel/devtree.c                 |  5 +--
 arch/arm/kernel/topology.c                |  6 ---
 arch/arm/mach-shmobile/pm-rcar-gen2.c     |  8 +---
 arch/arm/mach-shmobile/pm-rmobile.c       |  2 +-
 arch/arm/mach-shmobile/timer.c            | 10 +----
 arch/arm64/kernel/smp.c                   |  2 +-
 arch/c6x/kernel/setup.c                   | 11 ++---
 arch/microblaze/kernel/cpu/cpuinfo.c      |  4 +-
 arch/nios2/kernel/cpuinfo.c               |  4 +-
 arch/openrisc/kernel/setup.c              |  3 +-
 arch/powerpc/platforms/4xx/soc.c          |  2 +-
 arch/powerpc/platforms/8xx/m8xx_setup.c   |  5 ++-
 arch/powerpc/platforms/powermac/feature.c | 51 ++++++++---------------
 arch/powerpc/platforms/powermac/setup.c   | 15 +++----
 arch/riscv/kernel/smpboot.c               |  2 +-
 arch/sh/boards/of-generic.c               |  2 +-
 arch/x86/kernel/devicetree.c              |  2 +-
 drivers/clk/mvebu/clk-cpu.c               |  4 +-
 drivers/edac/cpc925_edac.c                | 20 +--------
 drivers/iommu/fsl_pamu.c                  |  2 +-
 drivers/of/base.c                         | 43 ++++++++++++++++++-
 drivers/of/of_numa.c                      | 15 +------
 drivers/video/fbdev/fsl-diu-fb.c          |  2 +-
 include/linux/of.h                        | 11 +++++
 24 files changed, 111 insertions(+), 120 deletions(-)

--
2.17.1
