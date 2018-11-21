Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA7FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7DC20989
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiR2C8f2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD7DC20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbeKUVkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 16:40:13 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33122 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728114AbeKUVkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 16:40:13 -0500
Received: by mail-lj1-f196.google.com with SMTP id v1-v6so4469250ljd.0;
        Wed, 21 Nov 2018 03:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jFPWHyZAjAggUIVzrbs3G+fYFLNlqzeCxZZheT3QbS0=;
        b=jiR2C8f2U3QcNnkRVEZukKevTrAAVodfsuS1TXviRQqGwL9CZiR7Qm2UY9H18ZFDf1
         dH6WaMn/mghKWhDyb7eklzhxNJ27J2tFtBllVqvaW7J+Oo5KbfQGp11fEvfR0OT5nWH5
         /6H4ZJKdUR8BsXQdySZPtxdDmklUsg+QsQ6c08DHnm6TFodNajyVsot4wQM9+t0FRhsx
         PWJb/N5GD+kNYyRv6DRsRFm+3in3uW46vnoTWy7B84/lB5jzw0HmGcvr8+0pPnVM7KA4
         CoOqOWKuW8F+RQLPw2pXAXrkEv0uBhXxKzitEzTbwOXFJGpsShRqHFQ3KG4P8/B5gPCF
         /n3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jFPWHyZAjAggUIVzrbs3G+fYFLNlqzeCxZZheT3QbS0=;
        b=CCGeIU7xReaBDAS1bM+9uBWy/3Zo8ToEEvuHEkimlviE8ToYdAuO/Xl8aoSa2MchHH
         oQS2uRgc381ydv4Z7eBnyCmvBWxvYs9hRbpcdbsrOsUlslJCXjmpvWHJHtaZm9uFYjM3
         Dwz3+Z5zqgfEzr9GN+/cFakNezJhs5lX341AA4ChSL+0Le6V5Uyx2VpZjwrNHsRyGp9S
         RI+wOrbmTNIYw+6bFGv18dg46CHgEX/iOm4c58gDJrIh9Bm9EOlsVjZaS5EWatw1L7zw
         p8R7eDsyzoUK0+sjGIrafO+zL7/NLwmKcKrPx9L9CLEXJsm6PqpDqWI1nvm7FtsUMxkp
         GzEA==
X-Gm-Message-State: AA+aEWZZvTjwzGIHSWXmTfrrKiU/gRJrMnbQV7wFSp4I6ah6wIeqlibv
        hwRBKi8J+p8ibgV8RDMAkiA=
X-Google-Smtp-Source: AFSGD/VEol6P6RH106aDGXPMaBDGthh+m7LKze/z5u8bccez3BHtDBcRWUl+s1g9smb05hOT+YktdQ==
X-Received: by 2002:a2e:568b:: with SMTP id k11-v6mr3744503lje.105.1542798373363;
        Wed, 21 Nov 2018 03:06:13 -0800 (PST)
Received: from z50.intranet (78-10-164-223.static.ip.netia.com.pl. [78.10.164.223])
        by smtp.gmail.com with ESMTPSA id x11sm7280047lfd.81.2018.11.21.03.06.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 03:06:12 -0800 (PST)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Subject: [PATCH v4 0/4] mtd: rawnand: ams-delta: Use GPIO API for data I/O
Date:   Wed, 21 Nov 2018 12:08:02 +0100
Message-Id: <20181121110806.32076-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20180813223448.21316-1-jmkrzyszt@gmail.com>
References: <20180813223448.21316-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Finalize implementation of the idea suggested by Artem Bityutskiy and
Tony Lindgren, described in commit b027274d2e3a ("mtd: ams-delta: fix
request_mem_region() failure"). Use pure GPIO consumer API, as reqested
by Boris Brezillon.

Janusz Krzysztofik (4):
      ARM: OMAP1: ams-delta: Provide GPIO lookup table for NAND data port
      mtd: rawnand: ams-delta: Request data port GPIO resource
      mtd: rawnand: ams-delta: Use GPIO API for data I/O
      ARM: OMAP1: ams-delta: Drop obsolete NAND resources

 arch/arm/mach-omap1/board-ams-delta.c |   22 ++----
 drivers/mtd/nand/raw/ams-delta.c      |  120 +++++++++++++++++++---------------
 2 files changed, 80 insertions(+), 62 deletions(-)

Performance on Amstrad Delta is now acceptable after recent extensions
to GPIO API and rawnanad enhancements.

Series intented to be merged via mtd tree, should not conflict with
other OMAP1 patches submitted for 4.21.

Changelog:
v4:   
- drop patches 1/7, 2/7, 5/7 6/7 - changes already merged,
- reintroduce postponed PATCH v2 06/12 as 4/4,
- rebase on nand-next for 4.21.

v3:
[PATCH v3 1/7] mtd: rawnand: ams-delta: show parent device in sysfs
- renamed and an explanation added based on other similar patches on
 Marek Vasut request, thanks.
[PATCH v3 2/7] mtd: rawnand: ams-delta: Use private structure
- no changes.
[PATCH v3 3/7] ARM: OMAP1: ams-delta: Provide GPIO lookup table for NAND
 data port
- no changes.
[PATCH v3 4/7] mtd: rawnand: ams-delta: request data port GPIO resource
- no changes.
[PATCH v3 5/7] mtd: rawnand: ams-delta: Set port direction when needed
- modified to set port direction only when needed instead of on each
 transfer as suggested by Boris, thanks, though I kept separate 
 *_next_byte() functions to maximize performance as much as possible,
- moved back in front of "mtd: rawnand: ams-delta: use GPIO API for data
 I/O" with a comment added referring to the planned switch to GPIO API.
[PATCH v3 6/7] mtd: rawnand: ams-delta: Simplify pointer resolution
- moved back in front of "mtd: rawnand: ams-delta: use GPIO API for data 
 I/O" on Boris request, thanks.
[RFC PATCH v3 7/7] mtd: rawnand: ams-delta: use GPIO API for data I/O
- rebased back on top of the two mentioned above,
- not intended to apply it yet due to performance issues on Amstrad Delta.
Removed from the series:
[RFC PATCH v2 09/12] gpiolib: Identify GPIO descriptor arrays with direct
 mapping
[RFC PATCH v2 10/12] gpiolib: Introduce bitmap get/set array API extension
[RFC PATCH v2 11/12] mtd: rawnand: ams-delta: Use GPIO API bitmap extension
[RFC PATCH v2 12/12] gpiolib: Add fast processing path to bitmap API functions
- intended to be still iterated in a follow up series until performance
 issues are resolved.
[RFC PATCH v2 06/12] ARM: OMAP1: ams-delta: drop obsolete NAND resources
- postponed until acceptable performance on Amstrad Delta is achieved.

v2:
[RFC PATCH v2 00/12] mtd: rawnand: ams-delta: Use GPIO API for data I/O
- renamed from former [RFC PATCH 0/8] mtd: rawnand: ams-delta: Use
  gpio-omap accessors for data I/O
[RFC PATCH v2 01/12] mtd: rawnand: ams-delta: Assign mtd->dev.parent,
                        not mtd->owner
- split out from former [RFC PATCH 1/8] on Boris request, thanks.
[RFC PATCH v2 02/12] mtd: rawnand: ams-delta: Use private structure
- remaining part of the former [RFC PATCH 1/8].
[RFC PATCH v2 03/12] ARM: OMAP1: ams-delta: Provide GPIO lookup table
                        for NAND data port
- split out from former [RFC PATCH 5/8] on Boris requesst, thanks,
[RFC PATCH v2 04/12] mtd: rawnand: ams-delta: request data port GPIO resource
- remaining part of the former [RFC PATCH 5/8],
[RFC PATCH v2 05/12] mtd: rawnand: ams-delta: use GPIO API for data read/write
- reworked from former [RFC PATCH 8/8] on Boris requesst to use pure
  GPIO API, thanks,
- moved up in front of former [RFC PATCH 3/8] on Boris request, thanks.
[RFC PATCH v2 06/12] ARM: OMAP1: ams-delta: drop obsolete NAND resources
- split out from former [RFC PATCH 8/8].
[RFC PATCH v2 07/12] mtd: rawnand: ams-delta: Set port direction once per
                        transfer
- reworked from former [RFC PATCH 3/8] on top of [RFC PATCH v2 05/12].
[RFC PATCH v2 08/12] mtd: rawnand: ams-delta: Simplify pointer resolution
                        on read/write
- reworked from former [RFC PATCH 4/8] on top of [RFC PATCH v2 08/12],
- renamed from 'Optimize' to 'Simplify' on Boris request, thanks.
[RFC PATCH v2 09/12] gpiolib: Identify GPIO descriptor arrays with direct
                        mapping
- new patch.
[RFC PATCH v2 10/12] gpiolib: Introduce bitmap get/set array API extension
- new patch.
[RFC PATCH v2 11/12] mtd: rawnand: ams-delta: Use GPIO API bitmap extension
- new patch.
[RFC PATCH v2 12/12] gpiolib: Add fast processing path to bitmap API functions
- new patch.
Removed from the series:
[RFC PATCH 2/8] mtd: rawnand: ams-delta: Write protect device during probe
- postponed on Boris request, thanks.
[RFC PATCH 6/8] gpio: omap: Add get/set_multiple() callbacks
- already applied by Linux in linux-gpio tree, thanks.
[RFC PATCH 7/8] mtd: rawnand: ams-delta: Check sanity of data GPIO resource
- most controversial one, no longer needed after switching to GPIO API.

Thanks,
Janusz

