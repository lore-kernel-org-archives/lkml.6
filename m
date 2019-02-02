Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C34C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 23:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DAE02084A
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 23:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="eNRjaBEA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfBBXTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 18:19:47 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:52370 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbfBBXTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 18:19:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1549149583; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=kHFNaBMJjrQPd5BXuqAmkwVDhqX1yrvQGdQDiBFNjms=;
        b=eNRjaBEAuxOhVuL10DANDCjfN2FsQMbBmhEIKFEb8LNZuzT2ObgRuOHIFJhAcyFr0W1UP9
        6Oyqtqi9lwnVHpG6/CS62wGbS3xn3Em9Ho9TMCIt2DzLJ9WOXhTRihFhHrTGOnoLxMqsz9
        q/URvldHSImufwy51ZFvuegJctHCXlE=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/9] Ingenic JZ4780 NAND patchset v2
Date:   Sat,  2 Feb 2019 20:19:17 -0300
Message-Id: <20190202231926.2444-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As requested by Boris, I added a patch to move all the Ingenic NAND
drivers to their own directory.

In this V2 I added support for the JZ4740 SoC. The combo of the
jz4780-nemc, jz4780-nand and jz4740-bch now obsolete the old and dusty
jz4740-nand driver.

To support the only upstream JZ4740-based board we have, the Ben
Nanonote, I added an option to specify the OOB layout of that device
from a device property string.

Finally, I dropped the last two patches that moved the platform NAND
code to devicetree; I will upstream them as part of a different
patchset.

Cheers,
-Paul

