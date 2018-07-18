Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2798DECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D4F20854
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLTqTdwI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2D4F20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730220AbeGSAhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 20:37:09 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36762 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeGSAhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 20:37:09 -0400
Received: by mail-lf0-f66.google.com with SMTP id b22-v6so4704623lfa.3;
        Wed, 18 Jul 2018 16:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xdixj3OeGQYJgtl+g91dtgYitIL+SXBKZ6gWmqkdchE=;
        b=eLTqTdwInMo4SCR5lZC7jTZ16WKN/kmDqWGdVlU4NBsEkiybY7cmlRIcc5hfEvgy25
         OePyY26DdP62r60HUBoMCdISjdBoXNxWhVU32RYbgQ7cWNAyumvQ3pLUumv+VnTJ7NSC
         tcK7DH6NUS+GE3zfJion5MPf4DUljYL6hcjMsp4NRB6dlviKXBPGXsKBqliZcUrhPdG8
         ATtoDKTscfKB7mKAW6iQd4B9liu1gjsZx1WEwTxJnpFJcqNBvQuc08vxw/ZyneZrwbN6
         +O/1geA5jrS0nEhEsVXtEFzJ7fyM8OoWo4/+DZOW1q4iiE4oelh1uaPCKrQlmqX1T7mr
         HgjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xdixj3OeGQYJgtl+g91dtgYitIL+SXBKZ6gWmqkdchE=;
        b=U/i7z7Bep7tE8qSHuMppyElVDUqWcInurrTZbwpkCCZSOsllZ2s1/dOIgN5OCAIlLD
         gpWU0s9XSRqbJOpw7FPntISD2Wl4//lAbhfmL3Taqz7YnRqeAy79aRQPZdSqjjlR/bfm
         9c7S5P2mhoxc1r8odYMtHKLdICrm2HHqkhFhykqWoMrka68sKLUxOp/Pla5acQm0HFlE
         1Xeu2EfGjfO2YZUULupCXRtdl7Spwn/K7kZ/YhKaWHhYarvRBCIfSRJe2owAfMdWunhU
         QYLjiUDaLf1esTqFQ9YrOGzbZ3MgqtaRnwMKY0lhqN1Aj2379kmSFZ8fe6+Yo2JF6bLf
         QRYg==
X-Gm-Message-State: AOUpUlHyKr9i/qlMit8PTXz5wLmMzTQh26yVam8W8TuWSvq9wqfcMxcw
        GPUPGqUDr7qww6sSuupAid0=
X-Google-Smtp-Source: AAOMgpcR6pa1PfZypGzpKx8yoZE2d6XMhxyNXGh0hCpPhFmIPc0tPx56RPloiH2U3ZkQfGxsar/Eng==
X-Received: by 2002:a19:2c4f:: with SMTP id s76-v6mr5420092lfs.25.1531958209448;
        Wed, 18 Jul 2018 16:56:49 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id h7-v6sm826584ljk.27.2018.07.18.16.56.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 16:56:48 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: [RFC PATCH 0/8] mtd: rawnand: ams-delta: Use gpio-omap accessors for data I/O
Date:   Thu, 19 Jul 2018 01:57:02 +0200
Message-Id: <20180718235710.18242-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Implement the idea suggested by Artem Bityutskiy and Tony Lindgren
described in commit b027274d2e3a ("mtd: ams-delta: fix
request_mem_region() failure").

 arch/arm/mach-omap1/board-ams-delta.c |   22 -
 drivers/gpio/gpio-omap.c              |   88 ++++++
 drivers/mtd/nand/raw/ams-delta.c      |  436 +++++++++++++++++++++-------------
 3 files changed, 376 insertions(+), 170 deletions(-)

