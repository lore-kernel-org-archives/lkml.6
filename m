Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68D1C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87998245D6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="UimHgRqr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87998245D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753294AbeGCMcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 08:32:32 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:45560 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752612AbeGCMca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 08:32:30 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH 00/14] dma-jz4780 improvements
Date:   Tue,  3 Jul 2018 14:32:00 +0200
Message-Id: <20180703123214.23090-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1530621147; bh=/bFB1seiv8a/cfcw4LntnjrrWQLk0ur0HVnu1fOspP4=; h=From:To:Cc:Subject:Date:Message-Id; b=UimHgRqrZ3UVHCA3PWP90Ve1wW3Bwt/pu4JJQu5dT4vNhZvajb8WaLUGxL9vpsRsgSRCXZ9BjLxInslW+xDAfVY5aiFj5oaRIMbUXSyiC2j/dnWQrKYzKYAEaW1EVml4h+pgzEwS9lrqhAxmPr1pQRPKsxDQLybtN6XKw+x6768=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This set of patches by myself and Daniel extends the dma-jz4780 driver
to support other SoCs (JZ4770, JZ4740, JZ4725B).

Some fixes are also included, for proper residue reporting, which fixes
errors with ALSA.

Finally, the last two patches update the devicetree bindings for the
JZ4780 SoC and add a binding for the JZ4770 SoC.

This patchset was tested on JZ4780, JZ4770 and JZ4725B, but was not tested
on the JZ4740, so it would be fantastic if somebody could test it there.

Regards,
-Paul

