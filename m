Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6926EC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13D9020E20
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="udRx+Oja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13D9020E20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbeHURwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 13:52:19 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34433 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbeHURwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 13:52:19 -0400
Received: by mail-ed1-f65.google.com with SMTP id h1-v6so10787671eds.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 07:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CNWtDR7TB5nZpThij1DAKBZpnQSiWMHK3Swze1sOoLQ=;
        b=udRx+Oja3/1uaLNaz4VR+a5237ab5+htZK0WYG0g7fKsw9+PsaiOnS19gY6x+Kx0JO
         R0XM3zOZHVG5dOe5T+7jkQjuK0I5vV8uspL5NGse6wlao9KEwCGBc5+VshqiBDRgPYKC
         4WmiFfKNSg9slY8+GkwnUPoHqq0HnHvwCfHoZeG72Hv15qJfvVBZ19oi6l4FIPhvN5FK
         F0u2o5vFMW/AmAEXux1HXPqz/tqsw/KA9QEn+6lQr8MzpcQCZInzYHc3gUs7XJskeyVL
         RsQa0qZHLCCa7vyA7EwThnGF2qjUox1eAnwwOrbzNPLI3GGWBaBOQT+EAKOazm6kwuwv
         BzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CNWtDR7TB5nZpThij1DAKBZpnQSiWMHK3Swze1sOoLQ=;
        b=dzGyzM1JaAD55js5E95f+rv88aRgVOwftJdUmkNmfvXhRepMQsD57J/30lBa+9ckOz
         9fdNOGyrfcXNOhqBkWtzOFLOTHmb9n1M2j3T/jX1Ad9AdbFn4ZFn7Pp5VBFC1A8Mjyv5
         mxDh4wr4HFiVmyMTsy9cVFvdCOES1nmHJexm4OyotqyntgkiSeCX4pAw5MuhM+/N9c+x
         X7trx6d0ZzrcZCQh+8sVpCAi055hz3q13utpgyAF6gL0dbUjD2suUiYJY3CApma3jmv2
         OesoBOjUgzQ4o0rJPfP9slFigArotwVXXmpDMk4FDNgjc+UyAo1RS1G9Pup+uyrPKUHQ
         UDug==
X-Gm-Message-State: AOUpUlG+SN/0PW2uWNgj7gVi5wQU7KT+MVqru5zAYQSiKpACpUZLwN18
        BlYipxgscMBbuVwkmrEuInc=
X-Google-Smtp-Source: AA+uWPwxi+bLdLcL/zth4OazVLUhkpVxQQq1OhU/3XcbBf+E6XNjgsAbFlAMZXCICcg0rKQhFXOe+Q==
X-Received: by 2002:a50:98a3:: with SMTP id j32-v6mr60327685edb.6.1534861915195;
        Tue, 21 Aug 2018 07:31:55 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id n17-v6sm6766144edq.10.2018.08.21.07.31.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 07:31:53 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH 0/8] gpio-addr-flash: Support for device-tree and cleanup
Date:   Tue, 21 Aug 2018 16:31:44 +0200
Message-Id: <20180821143152.32293-1-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series does the following:

1) Fix bug regarding ioremap size
2) Cleanup code to use new APIs
3) Simplify numerical operations
4) Add support for device-tree devices

Thanks!

Ricardo Ribalda Delgado (8):
  mtd: maps: gpio-addr-flash: Replace custom printk
  mtd: maps: gpio-addr-flash: Fix ioremapped size
  mtd: maps: gpio-addr-flash: Use devm_* functions
  mtd: maps: gpio-addr-flash: Use order insted of size
  mtd: maps: gpio-addr-flash: Replace array with an integer
  mtd: maps: gpio-addr-flash: Split allocation in two
  mtd: maps: gpio-addr-flash: Add support for device-tree devices
  dt-binding: mtd: Document gpio-addr-flash

 .../bindings/mtd/gpio-addr-flash.txt          |  46 +++
 drivers/mtd/maps/gpio-addr-flash.c            | 277 ++++++++++++------
 2 files changed, 237 insertions(+), 86 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/gpio-addr-flash.txt

-- 
2.18.0

