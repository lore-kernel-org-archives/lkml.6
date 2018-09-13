Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149E6C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 00:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B62A121471
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 00:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="SrR/CL/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B62A121471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbeIMF7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 01:59:20 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:59790 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbeIMF7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 01:59:19 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id w8D0pLtQ019994;
        Thu, 13 Sep 2018 09:51:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w8D0pLtQ019994
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1536799882;
        bh=ZPxqcYyQvKXPnXBKv+aof7ZHN2If0a9xvmPy7GWiW04=;
        h=From:To:Cc:Subject:Date:From;
        b=SrR/CL/8xPE6kVeqOyrNShIgfMr0lGQcLd+CIHJRpZG8/0PPN7BgWIjG2jGmhsCun
         AMF2n+yg/Qpd+JnZNSHR82JB21LCmqACQ0Eh1EoOeH1VskH6VisiF252mW+51XUqw7
         2c4yIAOqdgfZ7c+2qNeCGUzGmB9oCmcWepfUBKBOXon9bJsZfHUxy3w30D6rn3jZ7O
         BFbgx77dWG1pOr5GfBZzW3MKo7zt/vzAMQvCMnXoNWeG2m4uGoqBT1jYGYKVB2YiYR
         +hYF9SctDgfOZbfUiuUHnlKM8C7lAHNtbW66YvSHT3q09AW0N6b6l6O+CJhDIrTmmu
         iJSfH+089yulA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/2] dmaengine: add UniPhier MIO DMAC driver
Date:   Thu, 13 Sep 2018 09:51:07 +0900
Message-Id: <1536799869-10643-1-git-send-email-yamada.masahiro@socionext.com>
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
 drivers/dma/uniphier-mdmac.c                       | 495 +++++++++++++++++++++
 5 files changed, 533 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/uniphier-mio-dmac.txt
 create mode 100644 drivers/dma/uniphier-mdmac.c

-- 
2.7.4

