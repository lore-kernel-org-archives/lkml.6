Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E46C677FF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF1F920659
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="gI0k40/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF1F920659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730280AbeJLAKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 20:10:08 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:50023 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729991AbeJLAKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 20:10:07 -0400
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id w9BGf9b8007909;
        Fri, 12 Oct 2018 01:41:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w9BGf9b8007909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539276070;
        bh=RLvPRQLu1dBgwdiVTQW1tc9303ecN0ma5ULldiMX0+Q=;
        h=From:To:Cc:Subject:Date:From;
        b=gI0k40/+Rrn/NJysbfDYvMKM3Qe7/twUUw3n6+qp6+J4WPmansm963lYA/AVS/Uj6
         ZQ/M39+f+zewc4FJsriwFNmvheE+DT9MpjzHBpHbxoHjl9f3XIZqK7Qa93I6CYq7lB
         +4nWu6XDnRqOq5Q/xv+pWpYRDyVFENUp1mOKXj3i32IvGfk9CtD/B9FQ4RTPyjQzxy
         W09SCrrtZ4v9h5NuKfXes+BhTc2n1maywmjGgJVPlKybMTnYe0KUMb0IObM0cHIedQ
         m0WXnXfjGmBZirx+Bl1d5Ks00eG+fBVJChjLh5geU2KDvOWAbYe41i5tqwEJhBXFG8
         Wlqsu46YqZnsA==
X-Nifty-SrcIP: [218.220.227.105]
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
Subject: [PATCH v4 0/2] dmaengine: add UniPhier MIO DMAC driver
Date:   Fri, 12 Oct 2018 01:41:01 +0900
Message-Id: <1539276063-5103-1-git-send-email-yamada.masahiro@socionext.com>
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

 .../devicetree/bindings/dma/uniphier-mio-dmac.txt  |  25 +
 MAINTAINERS                                        |   1 +
 drivers/dma/Kconfig                                |  11 +
 drivers/dma/Makefile                               |   1 +
 drivers/dma/uniphier-mdmac.c                       | 506 +++++++++++++++++++++
 5 files changed, 544 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/uniphier-mio-dmac.txt
 create mode 100644 drivers/dma/uniphier-mdmac.c

-- 
2.7.4

