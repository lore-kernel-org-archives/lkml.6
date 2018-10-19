Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754EBECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 10:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E86A21486
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 10:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="QF6RwptW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E86A21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbeJSSh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 14:37:27 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:26774 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbeJSShR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 14:37:17 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id w9JAUbDe007220;
        Fri, 19 Oct 2018 19:30:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w9JAUbDe007220
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539945038;
        bh=hGhXNwDSLWmhXNF5F50S1tZ1VFRS3q4RjdMPD4QR8Cc=;
        h=From:To:Cc:Subject:Date:From;
        b=QF6RwptWkCQ9EsuoRiwwCbeuW3+wCDOpnNVtVPu/vomvxjfSCjJQMRDMKoq8qQ0ui
         rXpOGYNhjg18fJo6vJrAmjJyrzk+sEFZJpPfQ5UgxOfyBx0h6gjF/mW54IhyUiYHC5
         Vicxdl7azn1FTyXONhI1EyjN0Y9ZyAaTXOo6FwDglaR52S2po4GrEKBIka3w5IJd+E
         rnJTk4+gy7a3FAIbToOE7SJFd0NHy7OFcEiuyfd7go/CwivJu70VOE/F7nOXAXn5t2
         cXfAae9c+AZSKq7AhkbpNcVJqza/KkW4LGYrsENDagc2gYhByUM/DdTPFE/W/IhRfF
         /IlhXcOvrsh+Q==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     arm@kernel.org, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v3 0/2] dt-bindings: uniphier: two trivial DT bindings patches
Date:   Fri, 19 Oct 2018 19:30:16 +0900
Message-Id: <1539945019-24950-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arnd, Olof,

I know it is very late in this development cycle.

If possible, could you directly apply these two patches
to your ARM-SoC, aiming for the upcoming v4.20-rc1 MW?

If not, I can wait for v4.21-rc1.

Thanks,
Masahiro


Changes in v3:
  - Capitalize 'Board' consistently
  - Add Rob's Reviewed-by

Changes in v2:
  Changes suggested by Rob.
  - Move the file to
    Documentation/devicetree/bindings/arm/socionext/uniphier.txt
  - Group boards by each SoC
  Previous post:
  v1: https://patchwork.ozlabs.org/patch/842010/
  - New patch

Masahiro Yamada (2):
  dt-bindings: uniphier: add bindings for UniPhier SoC family
  dt-bindings: uniphier: move cache-uniphier.txt to vendor directory

 .../arm/{uniphier => socionext}/cache-uniphier.txt |  0
 .../devicetree/bindings/arm/socionext/uniphier.txt | 47 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 3 files changed, 48 insertions(+)
 rename Documentation/devicetree/bindings/arm/{uniphier => socionext}/cache-uniphier.txt (100%)
 create mode 100644 Documentation/devicetree/bindings/arm/socionext/uniphier.txt

-- 
2.7.4

