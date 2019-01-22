Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D86C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFABA20879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkH9S1h3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbfAVPVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:21:19 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:53077 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728934AbfAVPVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:21:19 -0500
Received: by mail-it1-f193.google.com with SMTP id g76so21947774itg.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 07:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8XnmIObsdCJuDup2kxs4Z3rOI8zwJJNkNe3FOAw8C3U=;
        b=IkH9S1h3Qye5lQ7eKeFY0orav4/hBSWDSsj7rsM7O5hdz5sgWUNKq2smMGiu81fpxO
         ySJeDP5RPZfNRhSlm+pcYwyzNS0t5CaGgV5/iJijJMuEb4bV14arHSGdTbCWlqBdksWK
         dvI1078gShuodwMU0o/6YuaZfStNLuTY5AhoBinAi0/GvPQcQirXCUTScopyRBBhZDQe
         d93rf5sgaLxQY2xclYllQHB7SXsU3pVTsouIXrWBjTJ0QctfT7/6mxwZAkEvXCD+8PMP
         b9Y4dolbSCbqMJ5zEF/9p9RnELPMEYujr6WgbPSI3ura/ZnbcQVYdu63u8RcOf9foh5t
         +iQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8XnmIObsdCJuDup2kxs4Z3rOI8zwJJNkNe3FOAw8C3U=;
        b=f/BjexIqc51tfXZv3+oPJ4NvIKxATQyLFgQDvQzfoGmGUfPrjzAsNoeaW/Zf4YRPCl
         GWqg02RXIRI2mw5ObZd6c+B3w75iQdj4TBQ9IIET7yljqMcT8nd/QrQbIvz6NiRnxe9T
         yReoF5FHquyAe6KzOQJDQ/AN+hsk+wq9vCnFUZiZb7I5e4S5your63lOBGIE2WqaQnTM
         Z/LzHVoCaJaQadeShy15iz+BbtDzh74mpUJquWmVMltAgHE+eyMhjP8lLTPYisC8BPNo
         mNA+JUmqKVal9GT66GlDrzJmrlocbFCEsgERNtBAdhqDr7GbtVN8Ij37oJVP80lL+Zys
         kqBw==
X-Gm-Message-State: AJcUukfT3SawvGnRe1pHbfMMer5HXlpkJAx2VhhOiOej6yXUIpAFPMd1
        qmerxpId0xDm60mjDc5DRTpsveNr
X-Google-Smtp-Source: ALg8bN4AnTYk6y2Tc9GNI6b4bPbn/Gws0rKSFOG+tx9cSX0emxE/2Dy7/o0hUF0VYDusOA3PeMD1bw==
X-Received: by 2002:a05:660c:a50:: with SMTP id j16mr2097001itl.52.1548170478177;
        Tue, 22 Jan 2019 07:21:18 -0800 (PST)
Received: from localhost.localdomain ([198.52.185.227])
        by smtp.gmail.com with ESMTPSA id b192sm7658509itb.12.2019.01.22.07.21.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 07:21:17 -0800 (PST)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@googlemail.com>
To:     svendev@arcx.com, robh+dt@kernel.org, linus.walleij@linaro.org
Cc:     lee.jones@linaro.org, mark.rutland@arm.com, afaerber@suse.de,
        treding@nvidia.com, david@lechnology.com, noralf@tronnes.org,
        johan@kernel.org, monstr@monstr.eu, michal.vokac@ysoft.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, maxime.ripard@bootlin.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/6] Add Fieldbus subsystem + support HMS Profinet card
Date:   Tue, 22 Jan 2019 10:21:03 -0500
Message-Id: <20190122152109.30488-1-TheSven73@googlemail.com>
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

The anybus slot on the host is located on an 'anybus controller', which is
custom h/w designed by arcx. It exposes a dual anybus host implementation,
plus a power readout unrelated to the anybus.

v7:
	use %zu printf formatter to display size_t

v6:
	Randy Dunlap:
	correctly/consistently indent Kconfig
	spelling/punctuation improvements

	Greg KH:
	suggestion: simplify /sys/class/fieldbus_dev/fieldbus_devX/ -> /sys/class/fieldbus_dev/X/
		can't simplify: create_device() also determines the name of the
		associated char device. simplification would result in a char device
		named /dev/X ?
	applied above suggestion to arcx-controller driver, this works ok as it does not
		have associated char device
	class name left as-is (fieldbus_dev) to differentiate between
		"fieldbus controller" and "fieldbus device" in the future
	makefile clean-up
	sysfs attributes: snprintf -> sprintf
		except card_name, as it's externally provided and could potentially
		be > PAGE_SIZE
	enabled/online sysfs attributes converted to "0/1" values
		using kstrtobool()

v5:
	Greg KH:
		fix licence nit
		consistent use of e-mail address
		replaced raw sysfs attribute with kobject_uevent() call
		keep __ATTRIBUTE_GROUPS because we need is_visible field
	Rob Herring:
		controller devicetree entry now requires multiple address
			regions and interrupts
		controller child node(s) now mapped to child devices by
			slot/host position (using devicetree reg = <>)
		architectural overhaul to align closely to existing pci arch:

				pci			anybus			
--------------------------------------------------------------------------------
Common bus code (spec),		pci/pci_driver.c	anybus/dev_core.c
  calls bus_register()		no of compatible	no of compatible
--------------------------------------------------------------------------------
Device on bus, calls
  XXX_client_driver_register()	hwmon/k8temp.c		fieldbus/hms-profinet.c
--------------------------------------------------------------------------------
Controller, silicon driver	pci/pcie-tango.c	anybus/arcx-anybus.c
				platform_driver calls	platform_driver calls
				pci_host_probe()	anybus_host_common_probe()

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

Sven Van Asbroeck (6):
  fieldbus_dev: add Fieldbus Device subsystem.
  anybus-s: support HMS Anybus-S bus
  anybus-s: support the Arcx anybus controller
  dt-bindings: anybus-controller: document devicetree binding
  dt-bindings: Add vendor prefix for arcx / Archronix
  fieldbus_dev: support HMS Profinet IRT industrial controller

 Documentation/ABI/testing/fieldbus-dev-cdev   |   31 +
 .../ABI/testing/sysfs-class-fieldbus-dev      |   62 +
 .../fieldbus/arcx,anybus-controller.txt       |   71 +
 .../devicetree/bindings/vendor-prefixes.txt   |    1 +
 Documentation/fieldbus_dev/fieldbus_dev.txt   |   66 +
 drivers/Kconfig                               |    2 +
 drivers/Makefile                              |    1 +
 drivers/fieldbus/Kconfig                      |   18 +
 drivers/fieldbus/Makefile                     |   10 +
 drivers/fieldbus/anybuss/Kconfig              |   39 +
 drivers/fieldbus/anybuss/Makefile             |   10 +
 drivers/fieldbus/anybuss/arcx-anybus.c        |  399 +++++
 drivers/fieldbus/anybuss/hms-profinet.c       |  223 +++
 drivers/fieldbus/anybuss/host.c               | 1459 +++++++++++++++++
 drivers/fieldbus/dev_core.c                   |  348 ++++
 include/linux/anybuss-client.h                |  104 ++
 include/linux/anybuss-controller.h            |   47 +
 include/linux/fieldbus_dev.h                  |  105 ++
 18 files changed, 2996 insertions(+)
 create mode 100644 Documentation/ABI/testing/fieldbus-dev-cdev
 create mode 100644 Documentation/ABI/testing/sysfs-class-fieldbus-dev
 create mode 100644 Documentation/devicetree/bindings/fieldbus/arcx,anybus-controller.txt
 create mode 100644 Documentation/fieldbus_dev/fieldbus_dev.txt
 create mode 100644 drivers/fieldbus/Kconfig
 create mode 100644 drivers/fieldbus/Makefile
 create mode 100644 drivers/fieldbus/anybuss/Kconfig
 create mode 100644 drivers/fieldbus/anybuss/Makefile
 create mode 100644 drivers/fieldbus/anybuss/arcx-anybus.c
 create mode 100644 drivers/fieldbus/anybuss/hms-profinet.c
 create mode 100644 drivers/fieldbus/anybuss/host.c
 create mode 100644 drivers/fieldbus/dev_core.c
 create mode 100644 include/linux/anybuss-client.h
 create mode 100644 include/linux/anybuss-controller.h
 create mode 100644 include/linux/fieldbus_dev.h

-- 
2.17.1

