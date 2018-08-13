Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C2BC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BE9321709
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMHgvyGA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BE9321709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732248AbeHNBSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 21:18:53 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39481 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729230AbeHNBSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 21:18:53 -0400
Received: by mail-lj1-f194.google.com with SMTP id l15-v6so13832380lji.6;
        Mon, 13 Aug 2018 15:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E/pecawERtjJIxLEh1DU7x47/6hRfEvwWGaPsttKek8=;
        b=KMHgvyGA+Bfkxywhq5Ya+7yljcsBIheKJWkdDgitUFMCCvKEEfVojMhoESSWjT+BKH
         9L9b/K22b2aJy+qIx3v0T33EVRwfFJPenC6qBHzEGcT1uE2codHIDMn1isIRiTNVdONQ
         kbUFdOPTzNKuE0sx/T3Y5RsxxMqGADHZC8aK/iN8WnTrGXCoCyjnEKRXNggaxggafKky
         QZIFA7h62zFnT358ECiwEbu4k+29pHiCyXH2deIB6E+Sy0Nj5EJmxnYSXwn40E+KQPpi
         jlq1COhdedzlXt1OkbdSgci3Si8Q9KdckrI/lMYnguF0r9RGXL7K2rKgDwMDKZ0H9FhC
         uEww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E/pecawERtjJIxLEh1DU7x47/6hRfEvwWGaPsttKek8=;
        b=SmyJD3hd25Ua5TehC4Fk6tgD8GnTczgvHxJ/xJsIn3+2bQezZS6JKgcNUSkoHgJBO0
         qUAaCDy+cERSLRodZ3yp1ycg65Rzx8zh8vk/qc+KF+T98Dl7GesVk4uLEOPwkiQJbv0n
         YdTT1a5denxxWGxZKBA84l7fa563tEfjlpvSMaHSbollfhiWEi0iHNDyh5zBAA1+VIyP
         +6PgGJhhHuuVuXeneAOvcNL+iDaQfAmDJHAmI1i1XW79/mISTfm46/0LUzH3DYidEewE
         m6LGKl+duhabgMKWhzgGgjnD3/i+q2trssRFnPjYZzN+a0Npdwmy5nb3feSM3+gnX4Yr
         0Z/w==
X-Gm-Message-State: AOUpUlGTwIm2PSUAy5FPJyo/Yp0brsEBJznXsw1D68vNsa9aVN5t9Llv
        VJcKu9eGgA2GMtuytCjdnK0=
X-Google-Smtp-Source: AA+uWPzlCEI8p9R0JoxmnQeyE1mXjv89EKMoR75wr0UYcaSxXsiIQj6YhHSgbC2nT+SoAUJud7f7Fw==
X-Received: by 2002:a2e:7c12:: with SMTP id x18-v6mr1079340ljc.71.1534199677055;
        Mon, 13 Aug 2018 15:34:37 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id f136-v6sm3572702lfe.71.2018.08.13.15.34.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 15:34:35 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v3 0/7] mtd: rawnand: ams-delta: Use GPIO API for data I/O
Date:   Tue, 14 Aug 2018 00:34:41 +0200
Message-Id: <20180813223448.21316-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180806222918.12644-1-jmkrzyszt@gmail.com>
References: <20180806222918.12644-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Implement the idea suggested by Artem Bityutskiy and Tony Lindgren,
described in commit b027274d2e3a ("mtd: ams-delta: fix
request_mem_region() failure"). Use pure GPIO API as suggested by
Boris Brezillon.


Janusz Krzysztofik (7):
      mtd: rawnand: ams-delta: show parent device in sysfs
      mtd: rawnand: ams-delta: Use private structure
      ARM: OMAP1: ams-delta: Provide GPIO lookup table for NAND data port
      mtd: rawnand: ams-delta: request data port GPIO resource
      mtd: rawnand: ams-delta: Set port direction when needed
      mtd: rawnand: ams-delta: Simplify pointer resolution on read/write
      mtd: rawnand: ams-delta: use GPIO API for data I/O


Changelog:
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


diffstat
 arch/arm/mach-omap1/board-ams-delta.c |   11 -
 drivers/mtd/nand/raw/ams-delta.c      |  351 +++++++++++++++++++---------------
 2 files changed, 209 insertions(+), 153 deletions(-)

Thanks,
Janusz

