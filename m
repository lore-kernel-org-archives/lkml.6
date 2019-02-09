Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AD4C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F12C217D8
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5o2YCiY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbfBIRgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 12:36:42 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35605 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbfBIRgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 12:36:41 -0500
Received: by mail-lj1-f195.google.com with SMTP id j13-v6so5607916ljc.2;
        Sat, 09 Feb 2019 09:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=14SHX6gOpkpcYinVjnT6VYgcZFI4T3ul/sfiG/oKpuI=;
        b=l5o2YCiYUtZfB6vKWJ8J+QjlkMOw08lWO+YTIeHWFXKHtrSl5lGLZICUHn+U3v+maQ
         X03b5Y76/KBfTJC6L924YEO6XvLVRfareSzTQ7yBtkSkEWirg0fGYASeYdoYs8gPNw6y
         RAIv8kRuRSxwt9lkxzvT98SkWaScGNevfsDtnYi+RnYiLF63j/BQai1WKHOYdErMuaYy
         YAltd6iuZE4C3G01CizUqnO9SwZPQTc5dK/WoP8UGIO7MO1kXliLjB1wVkyq2NioGyP8
         EK1WmbREs8K51Q5xplDjr4R/XMd8hhSBFBuheJhgCQuRaFrdpGxHDDpv7bt6F3yeqON/
         yIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=14SHX6gOpkpcYinVjnT6VYgcZFI4T3ul/sfiG/oKpuI=;
        b=bZ0GokelSTSUnF+LGDO5B+k/r5zRUvM2FsPV9EDq8SBbwVVNxbjlq6LuWhzpRVP65a
         5Cj2IgE500wn9TE2bXFVI7U5OuhmMW/XGfHQPRWmHEqyWYzakMOJS19a3YRexn5Awg8C
         mglyb8tYAe3Mm2hRAVcWxPlwRUTjXjZuvoTZhUmEYnjJV9aa/X3iD2cmTMxGrK9+pSMl
         SvPwg9bX9w5T1xpggaO8owR06MUWDlDNAEHQaGv96ZxCI1qU4KPcVXaDYQlOUbEXiF+r
         4fvm/WF5s03yUUKi1qKiR7gnMOgSCBgomt6aM4yKLtNK6ojyb43FGxAraatYwpWD1Ty4
         QEfw==
X-Gm-Message-State: AHQUAuYhAkpyBhVt33BFYXpNZEFUtT3TmaGXgFOPNndRlbmHBBFIW4Lz
        PTwR9SRS/B8A0PBsACxGf+CTg0xhen0=
X-Google-Smtp-Source: AHgI3IbdlorMob9/pWYq2Yka+3fPY/0oNtYbInMDrbP4hWZXolE0+wuw6sj3iyoYWMqhLiWMVT9Wbw==
X-Received: by 2002:a2e:9706:: with SMTP id r6-v6mr14114510lji.171.1549733798613;
        Sat, 09 Feb 2019 09:36:38 -0800 (PST)
Received: from arch.domain.name (89-70-37-207.dynamic.chello.pl. [89.70.37.207])
        by smtp.gmail.com with ESMTPSA id n12-v6sm1080508ljj.32.2019.02.09.09.36.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Feb 2019 09:36:37 -0800 (PST)
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, jic23@jic23.retrosnub.co.uk, pmeerw@pmeerw.net,
        johan@kernel.org, Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH v4 0/3] add support for PMS7003 PM sensor
Date:   Sat,  9 Feb 2019 18:36:06 +0100
Message-Id: <20190209173609.13220-1-tduszyns@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for Plantower PMS7003 PM matter sensor.

Unfortunately datasheet is not available for download from the Plantower
website so one needs to find it elsewhere, for instance here:

https://download.kamami.com/p564008-p564008-PMS7003%20series%20data%20manua_English_V2.5.pdf

v4:
 * add vendor prefix to set-gpios property

v3:
 * fix whitespaces
 * drop unused printk format specifier
 * make vcc-supply mandatory in dt binding
 * use a generic node name (air-pollution-sensor) instead of a sensor model

v2:
 * check number of bytes returned from serdev_device_write()
   (due to changes in linux 5.0 serdev api)
 * add missing pins descriptions to the driver binding
 * keep commands in the lookup table
 * buffer data and process everything in one go instead of using state machine
 * keep pm offset in channel address to simplify reading measurements

Tomasz Duszynski (3):
  iio: chemical: add support for Plantower PMS7003 sensor
  dt-bindings: add Plantower to the vendor prefixes
  dt-bindings: iio: chemical: pms7003: add device tree support

 .../iio/chemical/plantower,pms7003.txt        |  20 ++
 .../devicetree/bindings/vendor-prefixes.txt   |   1 +
 drivers/iio/chemical/Kconfig                  |  10 +
 drivers/iio/chemical/Makefile                 |   1 +
 drivers/iio/chemical/pms7003.c                | 340 ++++++++++++++++++
 5 files changed, 372 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
 create mode 100644 drivers/iio/chemical/pms7003.c

--
2.20.1

