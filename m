Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F371C43615
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEFFE214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGbb8p0e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEFFE214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbeHVOVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 10:21:44 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40719 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728355AbeHVOVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 10:21:43 -0400
Received: by mail-lj1-f194.google.com with SMTP id j19-v6so1090405ljc.7;
        Wed, 22 Aug 2018 03:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=wSs1l6PmM4K4/Ve834uTzWQTw3quXKXXanO8Je85/wc=;
        b=LGbb8p0emylOWoSTc24ySPHVbX4LBMmOkKSu38ijl4uoztrH5yOlapbdF07+4XCADG
         jO/BgK524VeLKoLxVg/UVz6PbNhUvBMrbepD+PwhV0jQmEEgijf/AvwQBc0vJ3CCYTqy
         WqcFd3JtSqxQGoewj7jH1Fa8waAqmRqTyILlBG1Pvz+hOuqVfKCpvEA4RWl3mqBovJ9o
         ZVymqOflXKsO0sFHYor4/9qzn4Jnf4cACADXUa+Eb7NzkUcnpOEgPXLpq6kEdcHkoDzM
         sAPOtL1ctOf/aqKGVZQvj/M40mjixnnb730s7u7E+9mz/TXHalJntLzVYRHnCeqF8a5d
         9I/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=wSs1l6PmM4K4/Ve834uTzWQTw3quXKXXanO8Je85/wc=;
        b=Pb1JyhRA+YiWGgCjBSR5K3CGkwe5/sLP/hpPVhOY8Afyw5j6WRwbBsHGEcOVREZxQE
         yBlujFYCu+i7qYAroNa98kcMXYtUC3uX22RNGmMU8B6aDFBIQ7IP1R56jsKIsBF9vnjv
         kGT++HAKs90lqOedtnyKIpGYPrTE22GuwdvbnwNkxSQtDJfB/2w6y4PkUm8m0CbyHr4L
         f6E+CDFx8qzsf8qob/V9H4mBOcT8yq2sn22z3JRdbc4sPI4ifIccgz+sOF9Y3AFrA3ed
         oIgvxbSsxN19yEUGqjoY5b7lHl2iO1qZ0SGT7vg6lrFwtnAJ1QaOm/QAVeZVx+Co6/7d
         SYag==
X-Gm-Message-State: APzg51ADXNQY/CYw75qAEApD6JRaWonP+0akQPhFQRehd5QM9KSNa4Eu
        ZBVweYkK5O5V/sTBTAKznPA=
X-Google-Smtp-Source: ANB0VdZb0n8dQlaQYBqWcICaY69VW/+RRMw9flth14hi2EDcTuJanZ9hAyvIA4Ch6++8aBh99DF58g==
X-Received: by 2002:a2e:3c1a:: with SMTP id j26-v6mr4348454lja.149.1534935437889;
        Wed, 22 Aug 2018 03:57:17 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id z18-v6sm253692lfj.89.2018.08.22.03.57.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 03:57:16 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1fsQpB-0002X9-R4; Wed, 22 Aug 2018 12:57:18 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Josh Wu <rainyfeeling@outlook.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 0/9] of: fix compatible-child-node lookups
Date:   Wed, 22 Aug 2018 12:55:38 +0200
Message-Id: <20180822105547.9634-1-johan@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several drivers currently use of_find_compatible_node() to lookup child
nodes while failing to notice that the of_find_ functions search the
entire tree depth-first and therefore can match unrelated (non-child)
nodes.

The fact that these functions also drop a reference to the node they
start searching from (e.g. the parent node) is typically also
overlooked, something which can lead to use-after-free bugs (e.g. after
probe deferrals).

This series adds a new helper, similar to of_get_child_by_name(), 
that can be used to lookup compatible child nodes, and uses the new
helper to fix child-node lookups throughout the tree.

This is related to the fixes I posted about a year ago, which addressed
a similar anti-pattern when looking up child nodes by name. Since it
took me more than a year to get all those fixes into Linus' tree (one
fix is still pending), and as these fixes depend on the new helper, I'm
suggesting that these all go in through Rob's or Greg's trees.

Alternatively, the helper could go into to -rc2, and I'll be pinging
submaintainers for coming year as well. ;)

Johan


Johan Hovold (9):
  of: add helper to lookup compatible child node
  drm/mediatek: fix OF sibling-node lookup
  drm/msm: fix OF child-node lookup
  mmc: meson-mx-sdio: fix OF child-node lookup
  mtd: nand: atmel: fix OF child-node lookup
  net: bcmgenet: fix OF child-node lookup
  net: stmmac: dwmac-sun8i: fix OF child-node lookup
  NFC: nfcmrvl_uart: fix OF child-node lookup
  power: supply: twl4030-charger: fix OF sibling-node lookup

 drivers/gpu/drm/mediatek/mtk_hdmi.c           |  5 ++--
 drivers/gpu/drm/msm/adreno/adreno_gpu.c       |  5 ++--
 drivers/mmc/host/meson-mx-sdio.c              |  8 ++++--
 drivers/mtd/nand/raw/atmel/nand-controller.c  | 11 +++++---
 drivers/net/ethernet/broadcom/genet/bcmmii.c  |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 12 +++++++--
 drivers/nfc/nfcmrvl/uart.c                    |  5 ++--
 drivers/of/base.c                             | 25 +++++++++++++++++++
 drivers/power/supply/twl4030_charger.c        |  5 ++--
 include/linux/of.h                            |  8 ++++++
 10 files changed, 68 insertions(+), 18 deletions(-)

-- 
2.18.0

