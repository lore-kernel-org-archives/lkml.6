Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F85ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 11:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B654A20857
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 11:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="e4VY0M9c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B654A20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbeGUL75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 07:59:57 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:41234 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbeGUL75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 07:59:57 -0400
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
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH v3 00/18] JZ4780 DMA patchset v3
Date:   Sat, 21 Jul 2018 13:06:25 +0200
Message-Id: <20180721110643.19624-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1532171254; bh=tccPmS0+AXzeM8qeRY0jErccGTxGelWcD54wPadIWKg=; h=From:To:Cc:Subject:Date:Message-Id; b=e4VY0M9cJ/vueBEkJhoHsthiZpNtSzznBfFdZgOG0E1HjNGHPumW92HLtDQMxKO64ki3WFF8TPkQnG2hev9ekPCJDulTZtU2WFS3KYsli86TM7TYSf2MQzCKFwuIYGLWmg1aEce87NHmjIGxM4TA9gzuoXPnTA+vET1TUIE7p/w=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the version 3 of my jz4780-dma driver update patchset.

Apologies to the DMA people, the v2 of this patchset did not make it to
their mailing-list; see the bottom of this email for a description of
what happened in v2.

Changelog from v2 to v3:

- Modified the devicetree bindings to comply with the specification

- New patch [06/18] allows the JZ4780 DMA driver to be compiled within a
  generic MIPS kernel.

Changelog from v1 to v2:

- All documentation changes have been moved to one single patch [01/17].

- The new patch [02/17] enforces that we're probed from devicetree.

- The driver will not fail if only one memory resource has been supplied
  in the devicetree, to keep compatibility with old devicetree files.

- A new patch [17/17] adds a devicetree node for the DMA driver in the
  JZ4740 DTS file.

- Some other small changes; see per-file changelog.

Regards,
-Paul


