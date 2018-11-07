Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AF0C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE5920882
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="IXoMOegI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FE5920882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731498AbeKHClv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:41:51 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39018 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbeKHClv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:41:51 -0500
Received: by mail-lf1-f65.google.com with SMTP id n18so12025194lfh.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 09:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=zDIhYkzMY+HCQjf2J5WFnxiR9Vbk2YpGCGFl3l2kxCE=;
        b=IXoMOegI+ZfvccEazZyDDwt3xQsszwIqwlxY2v/lITp0I3fkeETHqz2y/SGz/3wpJ3
         nR/g3H8edRVWM/5/zYhAstc5wibrplaWkAQNRLh2c6B9ZaOFppXaTnB78e3QcSH5/Lgp
         Ss3hBtR57Gyz9NXoiBoPmUeIMPsHqtqSzlqIhpOZsW516/7RgLakptwp2ijabC4MCX9a
         75XIGdrKea7zi+zCOWZI9NcJqIvvrwWQS0z+b8hBWaqbWqG6OQLEZa07P2pSaFBqQJCV
         Cdz9VjiKA8GruygXlUOONN8wB3Hzqk3u7XBAR5SPPn/KZQKoGcIgu3erdudjBOiKtyCr
         1/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=zDIhYkzMY+HCQjf2J5WFnxiR9Vbk2YpGCGFl3l2kxCE=;
        b=gsYNMSzQzbq+Z6oLmvjz8VgYgDHx7t1wotwg/aM27zSt9P+14rqs8a7sOtJQH5qgPU
         7lbhQl0XAHxnbfezx3RQlLzJoWxDUgcmExmQE1eHPUadeexCIDx6rDYFAUtWOywbzQ3L
         IHDJaPj706HUDSV+6SlQvM7gGFcYU8BPwytH8k1jWrrQ49RNgB3gWjdFmgJMThUO012a
         fsQcJhQrijo7EPC2S7l425Xry1swiVsRuX6kzjjGSoSQTQ2LWA8bXv8M7P+an/ZATiVa
         T0WtgICjrBI6YXcz2rNu0mcsdTpP2p41TNeIvagGcxdwoyJmC8ZuVQv/Rr7yQ1sPET+I
         JbOA==
X-Gm-Message-State: AGRZ1gKagS/RU235nb/tpaQYEbrcsFZC2uZrvxrRfj7ryTWulnNIGKQX
        yyYpoK2PqPwVYpDzProda/ZuRg==
X-Google-Smtp-Source: AJdET5e3pElmm4MPpdtzyCJufrvim5AfVVJi5+tX6HOBfi3rXoMJeuHIH2Nr9h7419JKr/nKBKKrWg==
X-Received: by 2002:a19:1d0d:: with SMTP id d13mr617834lfd.74.1541610633096;
        Wed, 07 Nov 2018 09:10:33 -0800 (PST)
Received: from localhost ([85.30.9.151])
        by smtp.gmail.com with ESMTPSA id l21-v6sm208732ljj.48.2018.11.07.09.10.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 09:10:30 -0800 (PST)
Date:   Wed, 7 Nov 2018 09:10:23 -0800
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     olof@lixom.net, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20181107171023.zoo6qox5eewy3pmk@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please merge. Thanks!


-Olof

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to a89f84a56ec95fd66b839bf9c545f8a59a4ffcd5:

  Merge tag 'stratix10_dts_fix_for_v4.20' of git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux into fixes (2018-11-07 08:09:50 -0800)

----------------------------------------------------------------
ARM: SoC fixes

A few more fixes that have come in, and one revert of a previous fix.

I was a bit too trigger happy to enable PREEMPT on multi_v7_defconfig,
and it ended up regressing at least BeagleBone XM boards. While we get
that debugged for next merge window, let's disable it again.

Beyond that:

 - Stratix change to fix multicast filtering
 - Minor DT fixes for Renesas and i.MX
 - Ethernet fix for a Renesas board (switching main interfaces)
 - Ethernet phy regulator fix for i.MX6SX

----------------------------------------------------------------
Aaro Koskinen (1):
      arm64: dts: stratix10: fix multicast filtering

Fabrizio Castro (1):
      dt-bindings: arm: Fix RZ/G2E part number

Kuninori Morimoto (1):
      arm64: dts: renesas: r8a7795: add missing dma-names on hscif2

Leonard Crestez (1):
      ARM: dts: imx6sx-sdb: Fix enet phy regulator

Oleksij Rempel (1):
      ARM: dts: imx6sll: fix typo for fsl,imx6sll-i2c node

Olof Johansson (4):
      ARM: defconfig: Disable PREEMPT again on  multi_v7
      Merge tag 'imx-fixes-4.20' of git://git.kernel.org/.../shawnguo/linux into fixes
      Merge tag 'renesas-fixes-for-v4.20' of https://git.kernel.org/.../horms/renesas into fixes
      Merge tag 'stratix10_dts_fix_for_v4.20' of git://git.kernel.org/.../dinguyen/linux into fixes

Rob Herring (1):
      ARM: dts: fsl: Fix improperly quoted stdout-path values

Sergei Shtylyov (1):
      arm64: dts: renesas: condor: switch from EtherAVB to GEther

 Documentation/devicetree/bindings/arm/shmobile.txt |  2 +-
 arch/arm/boot/dts/imx53-ppd.dts                    |  2 +-
 arch/arm/boot/dts/imx6sll.dtsi                     |  2 +-
 arch/arm/boot/dts/imx6sx-sdb.dtsi                  |  7 +++-
 arch/arm/boot/dts/vf610m4-colibri.dts              |  4 +-
 arch/arm/configs/multi_v7_defconfig                |  1 -
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  |  3 ++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           |  2 +-
 arch/arm64/boot/dts/renesas/r8a77980-condor.dts    | 47 +++++++++++-----------
 9 files changed, 39 insertions(+), 31 deletions(-)
