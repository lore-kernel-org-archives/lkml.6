Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD37BC32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 15:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F292081B
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 15:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oTjuVVKN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72F292081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730840AbeKEBKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 20:10:39 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:54270 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730742AbeKEBKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 20:10:39 -0500
Received: by mail-it1-f194.google.com with SMTP id r12-v6so6627244ita.3;
        Sun, 04 Nov 2018 07:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I2lap+u1+sqNgzoSWBicJN2TPhiwcFHPrXKYdyBYJLA=;
        b=oTjuVVKN8bKCJ+ckefyxUEPgFm5qi6xw2ZTyQD3H4JFiZ8WYYqkNmlWERnzDmGsA/Y
         M/ZaHwZwRr7XBhxoeePuQbqP3pE5FoMjoNdVm6GQA/efvVeI8smGF10KYsmW2IMvnMDG
         o5jM7BlQcB2dwc8cYQst/X+D9qUi5ejPmO6+pBHiPv9YQQMU4E4nXJAl2tPtmjJJyIhg
         jR2KLIo9Lai2MFepBpxhsI5eIHQSDXHeOb+rUjJjkVXGKwM+2ACY0QDUQwTD76NDGhXN
         gHmgbn67gUJkpvTy758CAOwJfmhnKcjGZeudGcZKoldPTKNXcOiH3HxdXatyoQtLcPNI
         NIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I2lap+u1+sqNgzoSWBicJN2TPhiwcFHPrXKYdyBYJLA=;
        b=OEU4vWFg48AgGxKmFb9HA6VmxlfRhG2Y2aENOZToWkT29ovZ3Q4e0BZebdYT/a8p/0
         sGi33DD8Ez7HEiFgXcLp6XVmeHVRvsbBvGS98PwrCNdtJ8omX0D5mESuq8+IA6BJqay7
         Xiap5zrxqZET60F3GL8ceqqDf1rIDgrX+a7JgRP50I3xKiP0SQNSTEDcrdSIgmWi9hpk
         DndrEvzPYtpZ3CjtKRV7dmWsW6IYGhLKZ0b+Urs0/cTfG7CC10zcfBkk6Ufyd+4wTwK3
         byEB7S5olxo0TYX/+nAd7R6zQJjbsmietEqcMswgwStgJKdXmX4IvP3+LvF+PMl/qBlU
         I07Q==
X-Gm-Message-State: AGRZ1gJ/FEkFMDXKbyddkzPeoinqIB8LWUVhUZsS5Anb6O4/4EdK1TzP
        o4CJ0TuLQ45J/6Op9UAvjLo=
X-Google-Smtp-Source: AJdET5cSy4rhjH55qJzrgv9jRcw3IzguTz8+AiIvttK7hVKIEwSfX8b4X3aV1/pMyUGTIaozIVwBEg==
X-Received: by 2002:a24:4e13:: with SMTP id r19-v6mr4237758ita.175.1541346912415;
        Sun, 04 Nov 2018 07:55:12 -0800 (PST)
Received: from localhost.localdomain ([198.52.185.227])
        by smtp.gmail.com with ESMTPSA id j13-v6sm2887482ita.27.2018.11.04.07.55.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Nov 2018 07:55:11 -0800 (PST)
From:   thesven73@gmail.com
X-Google-Original-From: TheSven73@googlemail.com
To:     svendev@arcx.com, robh+dt@kernel.org, linus.walleij@linaro.org
Cc:     lee.jones@linaro.org, mark.rutland@arm.com, afaerber@suse.de,
        treding@nvidia.com, david@lechnology.com, noralf@tronnes.org,
        johan@kernel.org, monstr@monstr.eu, michal.vokac@ysoft.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, maxime.ripard@bootlin.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH anybus v3 0/6] Support HMS Profinet Card over Anybus
Date:   Sun,  4 Nov 2018 10:54:55 -0500
Message-Id: <20181104155501.14767-1-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Van Asbroeck <svendev@arcx.com>

This patch set adds support for the HMS Industrial Networks AB Profinet card.

Profinet is an industry technical standard for data communication over
Industrial Ethernet, designed for collecting data from, and controlling,
equipment in industrial systems, with a particular strength in delivering data
under tight time constraints (on the order of 1ms or less).

The profinet card itself is connected to the system via an industrial bus
called 'anybus'.

I have followed the bus driver/client driver pattern, and created an anybus
bus driver, plus a client driver for the profinet card.

In case this patch set gets (eventually) accepted, drivers for other anybus
client cards may follow: flnet, cc-link, ...

The anybus slot on the host is located on an 'anybus bridge', which is
custom h/w designed by arcx. Its driver is modeled as a misc device, which
exposes a dual reset controller, plus a power readout unrelated to the anybus.

v3:
	devicetree-bindings
		adding the vendor prefix is now a separate commit
	anybus-bridge:
		moved misc driver to drivers/bus/
		converted of_gpio_* to gpiod_* abstractions
		can power readout is now a fixed-voltage regulator
	anybuss-host:
		converted refcounts from atomic_t to refcount_t
		fixed potential use-after-free
	hms-profinet:
		applied minor kernel build robot suggestion

v2:
	added architecture overview comments to host driver
	completely reworked anybus-bridge driver, it becomes a reset controller
	anybuss-host driver now needs devicetree entry, link to reset controller
	I will hold off on kernel-doc until the overall architecture gets
		more validation / approval
	fixed Kconfig, comment-style, document ioctl magic numbers
	removed redundant pwm dependency
	renamed enable-gpios to reset-gpios
	stop driving reset-gpio after unloading driver
	use interrupt-parent / interrupts method to describe interrupts
		in the devicetree
	convert references 'i.MX WEIM parallel bus' to 'parallel bus'
	replace devicetree functions with more generic platform_get_resource()
							platform_get_irq()
	added device unique data to add_device_randomness()

v1:
	first shot

Sven Van Asbroeck (6):
  misc: support the Arcx anybus bridge
  dt-bindings: Add vendor prefix for arcx / Archronix
  dt-bindings: anybus-bridge: document devicetree binding
  bus: support HMS Anybus-S bus
  dt-bindings: anybuss-host: document devicetree binding
  misc: support HMS Profinet IRT industrial controller

 .../bindings/bus/arcx,anybuss-host.txt        |   36 +
 .../bindings/misc/arcx,anybus-bridge.txt      |   34 +
 .../devicetree/bindings/vendor-prefixes.txt   |    1 +
 Documentation/ioctl/ioctl-number.txt          |    1 +
 drivers/bus/Kconfig                           |   20 +
 drivers/bus/Makefile                          |    2 +
 drivers/bus/anybus-bridge.c                   |  321 ++++
 drivers/bus/anybuss-host.c                    | 1503 +++++++++++++++++
 drivers/misc/Kconfig                          |   10 +
 drivers/misc/Makefile                         |    1 +
 drivers/misc/hms-profinet.c                   |  753 +++++++++
 include/linux/anybuss-client.h                |  100 ++
 include/uapi/linux/hms-common.h               |   14 +
 include/uapi/linux/hms-profinet.h             |  102 ++
 14 files changed, 2898 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/arcx,anybuss-host.txt
 create mode 100644 Documentation/devicetree/bindings/misc/arcx,anybus-bridge.txt
 create mode 100644 drivers/bus/anybus-bridge.c
 create mode 100644 drivers/bus/anybuss-host.c
 create mode 100644 drivers/misc/hms-profinet.c
 create mode 100644 include/linux/anybuss-client.h
 create mode 100644 include/uapi/linux/hms-common.h
 create mode 100644 include/uapi/linux/hms-profinet.h

-- 
2.17.1

