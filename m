Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0CEC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A50621746
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GM3Fo30k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A50621746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbeH0MIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 08:08:24 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37938 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbeH0MIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 08:08:17 -0400
Received: by mail-lj1-f196.google.com with SMTP id p6-v6so11638125ljc.5;
        Mon, 27 Aug 2018 01:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=hy96WSGyk9n9yG0a0L2PRDsUVo4Lgg8GvUhoza4cHUU=;
        b=GM3Fo30kH4SLrZpYq/eF9/G/Y+i/mWJ5BtOAi+jkEF0RJeFq0wgONQ32xGQU0+e8s6
         ARFYDdsUnMkubB4eK30uiS9Y8flwP4avAWVHYG31ktPeHjRxvGIop/f2rH6Is9bQLoQi
         YtAXl5JVnzdU2+B/r330JDnAFrSvqZD7rRWA46q0iGWgNVad81AdlHXtuXgmv7N9FFJM
         ovjaJWuyb4LAoT2BS2gweCVj70oBORA4W4OrssE8mLaVlccc4aLZUmd3YuFeqHyUlyDT
         +cuMR2219+lkQ+fJ6Gl2CAp6mza1EhIUxAk0D4jgM/9HNJNRaJpfLdvL6wdN5ZulttDC
         otug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=hy96WSGyk9n9yG0a0L2PRDsUVo4Lgg8GvUhoza4cHUU=;
        b=SbMt44OOjeJodkQ9qLzKbX8BQLqMjgTuby+WDSjDFrfGBXVFwb9b2AByR+dF2nSqAw
         uDz7UrX8EFRFjwVvBnmQ68nT3SFnX1A5IriKcfCCH/etEMun99yPm8IV+dTAD4F+7KQT
         O8nY5shWezhl0ontVoYclhsUvcrS++D2ji1B7bng2qNrJ+DTKSFrKH9S7yG75slMWFp6
         p5JsY+5gT27KqbQR+jrVk3nnut/JYAut5vQ8TdN9CKNpIK4xrvcriVMh+UtUiqfJ1A1T
         JFGyTGmkac8AGWOCKYhoYkZAStknXgq5LImaRkod3M9UXlHEqy3TRi+1pSrA9RC6vLUq
         tHig==
X-Gm-Message-State: APzg51Bje/M20ay6xaxWF41hvcoNYkONseTZyFb6DGWp+q+VP4AnXYJJ
        Ry5/PuVuskLy4sRbkNXn+UE=
X-Google-Smtp-Source: ANB0VdZz+6umflNZYTtNGdkKWN8YGyDCK1NGNt9RPkhSTJT80nsk7TLXUyYpU1r3a3qXT1XRA9eTUw==
X-Received: by 2002:a2e:9791:: with SMTP id y17-v6mr7574283lji.41.1535358159114;
        Mon, 27 Aug 2018 01:22:39 -0700 (PDT)
Received: from xi.terra ([85.230.190.116])
        by smtp.gmail.com with ESMTPSA id o11-v6sm2768201lfl.1.2018.08.27.01.22.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 01:22:36 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1fuCn6-0005sO-GM; Mon, 27 Aug 2018 10:22:28 +0200
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
        Sebastian Reichel <sre@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 0/9] of: fix compatible-child-node lookups
Date:   Mon, 27 Aug 2018 10:21:44 +0200
Message-Id: <20180827082153.22537-1-johan@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several drivers currently use of_find_compatible_node() to lookup child
nodes while failing to notice that the of_find_ functions search the
entire tree depth-first (from a given start node) and therefore can
match unrelated nodes.

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
submaintainers for the coming year as well. ;)

Johan


Changes in v2
 - fix !CONFIG_OF build by adding missing inline keyword
 - amend commit messages and explicitly mention that the of_find
   functions search the entire tree from a given start node
 - add Sebastian's and Martin's Reviewed-by and Acked-by to patches 4/9
   and 9/9 respectively
 - drop or fix a couple of CC addresses that bounced


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

