Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BC4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A08121479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z94wua6x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A08121479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731164AbeKVBmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:42:05 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:35399 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729828AbeKVBmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:42:04 -0500
Received: by mail-it1-f196.google.com with SMTP id v11so9324896itj.0;
        Wed, 21 Nov 2018 07:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mqFZ3m7DCD/G9EPHBuSBBQYmwret+6LrzpAX1ty+GYM=;
        b=Z94wua6xH7DlJ4MZmI6uS4ZfPMIAWIgEqhZxxRWp3PsnuWBeb0hCPaQjktghaPud7u
         pPTVLhd/fiezS7SJYc44bZ1JXlR/cKR48hdZNw8yrjMftVQNeXe/czQmLiAn/Map45FM
         x6y8E0l3an/qDO2jg0Ym3q1OEwg/CLt9bU0dwVJHeGdufvutk+J51vBXcwmGOHKwiIuR
         Sv7rBfw6KQkc7uO0PK+xBrOnLsVEtucKqTKhbIO0XsptW8JyfeMxj7iZeNgkLeATi08k
         iIoP4jDovRPcV10GjZY80bIn9Be0fpObAc8R0wbI+o5hR6p503rdcmPTMK1meLFR+JHJ
         c+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mqFZ3m7DCD/G9EPHBuSBBQYmwret+6LrzpAX1ty+GYM=;
        b=Ycdr8UahokcAJYvRTrc+sgGuXhmUEdd+V/G5Ig/3AN2ghisR61VfL8+hsCBz699ww3
         LyCZiKyH62cjYGhFHULPOBm1yCzBU4bMW+duma5LkmTmWAvlsaJzEgBmDsMfaMzY6KlP
         YBkC3f+oJ+zd00bYt6vbUiRwm3dOwqN4G9AzQrmido+qYgaCKwxSI1LZIX48fYKZ+DKT
         xdIuNr+cdoQtX5bXgOwI8RA1l1Tvt7ROqeIflacfECZnFXRBS0jmwByEQoB5Mx83Z6RJ
         Jnl6b2Sc78BscG9kYy7VnhM+IVmIbVkJVGFVAmMz6ODQ9321t72tqeY1O8joCndq7wop
         4bpQ==
X-Gm-Message-State: AGRZ1gLoYBuq+13dS9gqw3j5rbhmlgNHa51uYyaF40RD/Nzi+tkDYoYr
        tcYVXirysY1T9KGAUzudGhE=
X-Google-Smtp-Source: AJdET5dXvgOavTs2zYIzeo7As/y7vO5+Fw76+amoShOdJ8+EoIOpH4ZOgTp8f7pvg6/hDgahhkGBiw==
X-Received: by 2002:a24:2493:: with SMTP id f141-v6mr6430603ita.46.1542812835583;
        Wed, 21 Nov 2018 07:07:15 -0800 (PST)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id c3sm5113119ioi.2.2018.11.21.07.07.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 07:07:14 -0800 (PST)
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
Subject: [PATCH anybus v4 0/7] Add Fieldbus subsystem + support HMS Profinet card
Date:   Wed, 21 Nov 2018 10:07:02 -0500
Message-Id: <20181121150709.6030-1-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch:
  1. adds a Fieldbus subsystem
  2. adds support for the HMS Industrial Networks AB Profinet card.

1. Fieldbus subsystem
---------------------

Fieldbus device (client) adapters allow data exchange with a PLC aka.
"Fieldbus Controller" over a fieldbus (Profinet, FLNet, etc.)
They are typically used when a Linux device wants to expose itself
as an actuator, motor, console light, switch, etc. over the fieldbus.
The framework is designed to provide a generic interface to Fieldbus
Devices from both the Linux Kernel and the userspace.

2. Add support for HMS Profinet Card
------------------------------------

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

v4:
	general
		create fieldbus_dev subsystem, with standardized 'simple'
			userspace interface (sysfs + cdev)
		remove redundant __packed keywords
		use __be16/32 types wherever values are explicitly big-endian
	hms-profinet:
		remove configuration code, and uapi headers: not supported (yet)
			when registering as a fieldbus_dev.
	anybuss-host:
		use struct kref to reference-count tasks
		replace busy loops with usleep_range() loop after 10 tries
		use threaded irq so time_before_eq(jiffies, timeout) will
			continue to work
		allow client devices to be assigned a devicetree node,
			in the same way as pci/mmc/...

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


Sven Van Asbroeck (7):
  fieldbus_dev: add Fieldbus Device subsystem.
  fieldbus: support the Arcx anybus bridge
  dt-bindings: Add vendor prefix for arcx / Archronix
  dt-bindings: anybus-bridge: document devicetree binding
  fieldbus: support HMS Anybus-S bus
  dt-bindings: anybuss-host: document devicetree binding
  fieldbus_dev: support HMS Profinet IRT industrial controller

 Documentation/ABI/testing/fieldbus-dev-cdev   |   31 +
 .../ABI/testing/sysfs-class-fieldbus-dev      |   63 +
 .../bindings/fieldbus/arcx,anybus-bridge.txt  |   34 +
 .../bindings/fieldbus/arcx,anybuss-host.txt   |   66 +
 .../devicetree/bindings/vendor-prefixes.txt   |    1 +
 Documentation/fieldbus_dev/fieldbus_dev.txt   |   66 +
 drivers/Kconfig                               |    2 +
 drivers/Makefile                              |    1 +
 drivers/fieldbus/Kconfig                      |   56 +
 drivers/fieldbus/Makefile                     |   12 +
 drivers/fieldbus/anybus-bridge.c              |  321 ++++
 drivers/fieldbus/anybuss-host.c               | 1497 +++++++++++++++++
 drivers/fieldbus/dev_core.c                   |  355 ++++
 drivers/fieldbus/hms-profinet.c               |  223 +++
 include/linux/anybuss-client.h                |  104 ++
 include/linux/fieldbus_dev.h                  |  106 ++
 16 files changed, 2938 insertions(+)
 create mode 100644 Documentation/ABI/testing/fieldbus-dev-cdev
 create mode 100644 Documentation/ABI/testing/sysfs-class-fieldbus-dev
 create mode 100644 Documentation/devicetree/bindings/fieldbus/arcx,anybus-bridge.txt
 create mode 100644 Documentation/devicetree/bindings/fieldbus/arcx,anybuss-host.txt
 create mode 100644 Documentation/fieldbus_dev/fieldbus_dev.txt
 create mode 100644 drivers/fieldbus/Kconfig
 create mode 100644 drivers/fieldbus/Makefile
 create mode 100644 drivers/fieldbus/anybus-bridge.c
 create mode 100644 drivers/fieldbus/anybuss-host.c
 create mode 100644 drivers/fieldbus/dev_core.c
 create mode 100644 drivers/fieldbus/hms-profinet.c
 create mode 100644 include/linux/anybuss-client.h
 create mode 100644 include/linux/fieldbus_dev.h

-- 
2.17.1

