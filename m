Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDD9C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78240214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=innovation.ch header.i=@innovation.ch header.b="M1Eu6upY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbfBDIT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 03:19:58 -0500
Received: from chill.innovation.ch ([216.218.245.220]:56390 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfBDITz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 03:19:55 -0500
Received: from localhost (localhost [127.0.0.1])
        by chill.innovation.ch (Postfix) with ESMTP id 6C1E164013A;
        Mon,  4 Feb 2019 00:19:54 -0800 (PST)
X-Virus-Scanned: amavisd-new at 
Received: from chill.innovation.ch ([127.0.0.1])
        by localhost (chill.innovation.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id xI81bttMYJGj; Mon,  4 Feb 2019 00:19:52 -0800 (PST)
From:   =?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch C7EA7640132
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1549268392;
        bh=5q2qbhsxgYrOmW2H24j9M9uerx04Cxb7KBz33NpNA3U=;
        h=From:To:Cc:Subject:Date:From;
        b=M1Eu6upY7wjEKajPP05/jdEJGe+ktWm3kxfiZbmieve/QnsbaLCfCOkxyhh2h3vrD
         +NG4fjSFdseo7YNj0J2f2XEKLNMiy/6l2HlebZ6H6ZS1m41WPrJa01hwZA21Rf/x6z
         01VLzuMEEhyt2pqWPVghbQQfpJyLiHA4QA54zWdFrpqitMu0jQlb5tlira0aCuuN2A
         AXlIGU7SpD5VA+oy/UgXjUc4YjCABTYD4eeVuON5fNG8SD0TYtxb6mZ3nphQ5E4C/C
         tL50npwl/YFYg6RmrWS/4feR1KvzkhQdDYKAUw1TLooDlu+liqTKdJX8967MnGzIKt
         y94Qh3WiPdIKA==
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Federico Lorenzi <federico@travelground.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add Apple SPI keyboard and trackpad driver
Date:   Mon,  4 Feb 2019 00:19:45 -0800
Message-Id: <20190204081947.25152-1-ronald@innovation.ch>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This changeset adds a driver for the SPI keyboard and trackpad on recent
MacBook's and MacBook Pro's. The driver has seen a fair amount of use
over the last 2 years (basically anybody running linux on these
machines), with only relatively small changes in the last year or so.
For those interested, the driver development has been hosted at
https://github.com/cb22/macbook12-spi-driver/ (as well as my clone at
https://github.com/roadrunner2/macbook12-spi-driver/).

The first patch is just a placeholder for now and is provided in case
somebody wants to compile the driver while it's being reviewed here; the
real patch has been submitted to dri-devel and is being discussed there,
with the intent/hope that I can get an Ack and permission to merge it
through the input subsystem tree here as part of this patch series.

Ronald Tschalär (2):
  drm/bridge: sil_sii8620: depend on INPUT instead of selecting it.
  Input: add Apple SPI keyboard and trackpad driver.

 drivers/gpu/drm/bridge/Kconfig    |    2 +-
 drivers/input/keyboard/Kconfig    |   13 +
 drivers/input/keyboard/Makefile   |    1 +
 drivers/input/keyboard/applespi.c | 1919 +++++++++++++++++++++++++++++
 4 files changed, 1934 insertions(+), 1 deletion(-)
 create mode 100644 drivers/input/keyboard/applespi.c

-- 
2.20.1

