Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538F0C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0659C21A60
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cW/GmVyH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0659C21A60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387511AbeHGAkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 20:40:41 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:35292 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728948AbeHGAkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 20:40:41 -0400
Received: by mail-lj1-f169.google.com with SMTP id p10-v6so11873440ljg.2;
        Mon, 06 Aug 2018 15:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=usb2fgfDg3TO/g+peaW5Ch4SG2Z/w0jNQ8VCIoDw1Xg=;
        b=cW/GmVyHlyYbRkr75Y3qbwI2oora9J4myg5ZtYJK31gyZV6whSMc1wiyIrCESz5202
         oZk1HoCP3TnmyT+I1EKocRePrMOMjbcX7f2b9qawtXctHZOiNrxsronl2TLz6dcZCL/G
         bsSeybGPOCn4Asxtue8byCv9fcy8/DTImwWLUQ4q1FGkCd6N0X3eBlZI3piIvPwuczz4
         SMLv0HXRXKWmEtBWd+Euucxqkhq4tdyTbniBUSYE+hc3MR1CDR+g7Y8k2ZXNnHa8JMwq
         xiIoGfqQ0cxB3Ecj3WjiGawS0OfxQejPBi2umaF37XQavWXHpocwl1KQqr5oqbvjDQd4
         o7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=usb2fgfDg3TO/g+peaW5Ch4SG2Z/w0jNQ8VCIoDw1Xg=;
        b=PSq2vwCJDPsdmNwdZKfliB8j2bzH/KmAeHciF7qJTze5YiRFvK/vFdTqEwKDrDmk8f
         3TzIiTsjcRMb3dorCUkeA7vrG32UyjN5auwN5WAt+e8EV270+3uNv/aJo2iM1xCeIk7w
         airETF9Qyp5cVjbYl+B91Y9DBTfBI52orbDyG3MmfYn6kjOP0HaNGD2/V41UCdobqeVw
         82DKbs36nbTnDKp+Of2fpH1tjG88og6DZO4f4+lVKadB8fmw+V4QTsMY2B2yLBW0yJtZ
         Nr9UyZap9CrdGI2QewR7plM87L0Ezur2JKSqUq4/u5hSq7lp3+avyUUPxZjlv4hcMrUg
         3iiw==
X-Gm-Message-State: AOUpUlHth4szt6kH1g+l5n5EOF/S7RJknq3N0g6Izfk2mG/gUsdMeSHJ
        5uGLk2W1l92qW5IiN7ei+9o=
X-Google-Smtp-Source: AAOMgpc9zi/mnHkBghq+bccjidovyVvGqMMYTx9ziNu2phTZZTv3lpW1ATRKAxGczeXL/Pg8Gq5+rA==
X-Received: by 2002:a2e:429c:: with SMTP id h28-v6mr13651612ljf.67.1533594567406;
        Mon, 06 Aug 2018 15:29:27 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id o4-v6sm2438561ljc.67.2018.08.06.15.29.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 15:29:26 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2] mtd: rawnand: ams-delta: Use GPIO API for data I/O
Date:   Tue,  7 Aug 2018 00:29:06 +0200
Message-Id: <20180806222918.12644-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180718235710.18242-1-jmkrzyszt@gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the idea suggested by Artem Bityutskiy and Tony Lindgren,
described in commit b027274d2e3a ("mtd: ams-delta: fix
request_mem_region() failure"). Use pure GPIO API as suggested by
Boris Brezillon.


Janusz Krzysztofik (12):
      mtd: rawnand: ams-delta: Assign mtd->dev.parent, not mtd->owner
      mtd: rawnand: ams-delta: Use private structure
      ARM: OMAP1: ams-delta: Provide GPIO lookup table for NAND data port
      mtd: rawnand: ams-delta: request data port GPIO resource
      mtd: rawnand: ams-delta: use GPIO API for data read/write
      ARM: OMAP1: ams-delta: drop obsolete NAND resources
      mtd: rawnand: ams-delta: Set port direction once per transfer
      mtd: rawnand: ams-delta: Simplify pointer resolution on read/write
      gpiolib: Identify GPIO descriptor arrays with direct mapping
      gpiolib: Introduce bitmap get/set array API extension
      mtd: rawnand: ams-delta: Use GPIO API bitmap extension
      gpiolib: Add fast processing path to bitmap API functions


Changelog:
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


diffstat:
 Documentation/driver-api/gpio/consumer.rst |   36 ++
 arch/arm/mach-omap1/board-ams-delta.c      |   22 -
 drivers/gpio/gpiolib.c                     |  237 +++++++++++++++++++
 drivers/mtd/nand/raw/ams-delta.c           |  350 +++++++++++++++--------------
 include/linux/gpio/consumer.h              |   15 +
 5 files changed, 485 insertions(+), 175 deletions(-)

