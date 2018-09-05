Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E3EC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA97120857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRyiHNqQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA97120857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbeIETHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 15:07:21 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34638 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbeIETHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 15:07:21 -0400
Received: by mail-ed1-f65.google.com with SMTP id u1-v6so6285950eds.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 07:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gjwy2eS0+FgR3QMwCu5mspdsFjXZq/i7p6gkYNRpF4Q=;
        b=KRyiHNqQaZlf7xyP7XuK/2QRZ0zyYaUiR34i5VWOLd6fZLXGia8kNpbhm/7Utfq5ub
         iyXIuxBKUQU4iOr4eAtmDQ2d0Qj/ag0KTdYYp0OaAJ8w5CF1+WOuqPD3zV9lUtZFs9HU
         6igtzu6xhKZEC8tqearG3MAqmj+ow9LUlsdU5isz17BZkJ+J9HmlXXA/x+Yde0wvYfHR
         59D+8XBw/CyfGACruc3wDxwiNTgYJgIW5W9hqwPT1j3GDZTkexWTr1odStWPkV0CBnD9
         HhcyFT5b6KgO2QQjFAm9bNGMIS5rs9O7hu/pjkrjbudh1pQEUXv2403lFXddQp4LlZ/1
         SdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gjwy2eS0+FgR3QMwCu5mspdsFjXZq/i7p6gkYNRpF4Q=;
        b=gLBFW2xCQuHF5haf0YTPIkbJhGCFNiMyKrBzMmo5jQXXX0EMmLPh0iyGeStPGZKzlt
         IyO6AefvsSPWu1M7oeAxNY6iWbtAA4wQtKJqG4M0kxzBRiqhrcsAGZ6NaFKfc2HqvW4v
         YH02pNssJEEpe1BcM5sQ1F/+2WUJwUR+tVTqeJm5kzyFIM9qnIV74B9EnetOKRMVDcVt
         0kag3HGibLSZacsZp4RUMMYkRORldSVMVXmvj2PV1U2ZFa4SlXbGgGS9u2/aEeDjQWdM
         rwNrpjp30U5LszxOdCTf6ylLxKS+8d45ZQKs+wZTYcejxwBBA59BLdlQL9RG3Ad5PS8M
         SgUA==
X-Gm-Message-State: APzg51A6CvatORAYkbd6ON73PgcFkgZ4byiIkVdqHQXq4tmSI28teJsN
        lFmLdmrKDI1h5fgdBx/a4fA=
X-Google-Smtp-Source: ANB0VdbVOjIBkGYT6Xx0fnJSQvAkOSR/fVyUmxqN8I9sVQu/7VGXoaUtw8f6vPEqRZX109Spaxs/JA==
X-Received: by 2002:a50:b7af:: with SMTP id h44-v6mr37796857ede.297.1536158211670;
        Wed, 05 Sep 2018 07:36:51 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id u53-v6sm1556413edm.51.2018.09.05.07.36.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 07:36:50 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org (open list)
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v2 0/8] gpio-addr-flash: Support for device-tree and cleanup
Date:   Wed,  5 Sep 2018 16:36:35 +0200
Message-Id: <20180905143643.9871-1-ricardo.ribalda@gmail.com>
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

Changelog v2:

From Boris Brezillon:
-Add Fixes and cc:stable

From kbuild:
- Fix warnings

- Rebase

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
 drivers/mtd/maps/gpio-addr-flash.c            | 276 ++++++++++++------
 2 files changed, 236 insertions(+), 86 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/gpio-addr-flash.txt

-- 
2.18.0

