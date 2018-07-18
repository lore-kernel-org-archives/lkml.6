Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10B0ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 677222084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="ZxI+Vrv1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 677222084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbeGRS7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 14:59:51 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:38800 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbeGRS7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 14:59:51 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH v2 00/17] JZ4780 DMA patchset v2
Date:   Wed, 18 Jul 2018 20:20:06 +0200
Message-Id: <20180718182023.8182-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1531938042; bh=mPdINxxdHVMuf+vePSdZ2HjJ+KrzVlCN6oTxHng266g=; h=From:To:Cc:Subject:Date:Message-Id; b=ZxI+Vrv1ieM/xM81BRKnQ9wXQfrN07UAhc6ZGM05A91ETJJX9kGSSINBHEzMLoqZL9O8QeGVqpPPpCy+12IyAfDXyiATRUcVkr+2tGQyI2JRi6e8ns/NcEjtfGukE/+J/GBaL3TJJw6yM1y7LP49Oo5m8p2Lqet5Z40RcAQXuLE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the version 2 of my jz4780-dma driver update patchset.

Changelog:

- All documentation changes have been moved to one single patch [01/17].

- The new patch [02/17] enforces that we're probed from devicetree.

- The driver will not fail if only one memory resource has been supplied
  in the devicetree, to keep compatibility with old devicetree files.

- A new patch [17/17] adds a devicetree node for the DMA driver in the
  JZ4740 DTS file.

- Some other small changes; see per-file changelog.

Regards,
-Paul

