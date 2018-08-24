Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B08C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 01:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1073121557
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 01:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="IV6EH0mG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1073121557
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeHXFO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 01:14:56 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:62416 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725735AbeHXFOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 01:14:55 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id w7O1fPqx000411;
        Fri, 24 Aug 2018 10:41:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w7O1fPqx000411
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1535074886;
        bh=xUEXYBN1XcgRdYmw7YfObfKyCZhwWupHF6xy0uo5zyg=;
        h=From:To:Cc:Subject:Date:From;
        b=IV6EH0mG9DgW27cc3vV74HmLHTWzdMXc8UR+v8NAgzpVtgj2ZoR7Nqth99kzyflsd
         37qx60f5C5LW/JNFzBxmRZJFUpinnx8UHaeOekLm76tk7gCYU7p2X1TkwUxm42WaYW
         pibK8GvPbMz5EcTV+a9h+/VJfjAOxwJZ10SYjpivwCv4XWO/HPGJx/8najOqrVo7xr
         bIU/79o8t3YxIaEmZ5m+oCBpkfdkR2XIh9YAPwMLJpww1kEccXzQ1GaVEbE+zHx5d6
         u0UBAXGC/bHtgR2rN0PVX7N2edGo+vfIsuAoMgaLWLpzdRhoPFdSt1YQVNZHcf9XkE
         Okh5KbU63wkQQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/2] dmaengine: add UniPhier MIO DMAC driver
Date:   Fri, 24 Aug 2018 10:41:11 +0900
Message-Id: <1535074873-15617-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1/2: DT-binding
2/2: driver


Masahiro Yamada (2):
  dt-bindings: dmaengine: add DT binding for UniPhier MIO DMAC
  dmaengine: uniphier-mdmac: add UniPhier MIO DMAC driver

 .../devicetree/bindings/dma/uniphier-mio-dmac.txt  |  25 ++
 MAINTAINERS                                        |   1 +
 drivers/dma/Kconfig                                |  11 +
 drivers/dma/Makefile                               |   1 +
 drivers/dma/uniphier-mdmac.c                       | 481 +++++++++++++++++++++
 5 files changed, 519 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/uniphier-mio-dmac.txt
 create mode 100644 drivers/dma/uniphier-mdmac.c

-- 
2.7.4

