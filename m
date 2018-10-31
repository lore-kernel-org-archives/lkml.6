Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6212C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D3EE20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t9gt0lTI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D3EE20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbeKAEn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 00:43:59 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:34921 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbeKAEn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 00:43:59 -0400
Received: by mail-it1-f195.google.com with SMTP id p64-v6so19995964itp.0;
        Wed, 31 Oct 2018 12:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a2fTxHgK/j0y/WZpd2t83mON9LgtrOzR9B4EZ/+F2oU=;
        b=t9gt0lTI92H9QXBCHKZDA/NykrnhVnBW+wYbqobGHRCaPtI7QPYNsGB+GGcXrxJD+v
         Il7+BgdzyQXm/O1uv66w94Z5wJugYgCgz+odehwVP9TnE0cdvFhYwPoI7To5FFwGLOlM
         vKlrJjx38l3prnNYJVt9KimTOnVXRK41k3tJ+rwEzW2SLIqXLJkFZkXdbI8RgeETR8Jv
         8i2tblYKj1dUcvY3S+RVQOJD4UjqW9D9V8pKnlZxJXsHLJy2GwbgQL9LIOsDWWYBjr8L
         vzKCo/rA/9lU04S4u0Q95jSzszDEyDSaTo5bXA9CjoyTSVP5i7ptAuIUu5Xo+NV4pww7
         nVVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a2fTxHgK/j0y/WZpd2t83mON9LgtrOzR9B4EZ/+F2oU=;
        b=fsyes0rsnumJbM0xLeLXGm4xGCWUtNinRm/dVnPuVHrPpzAZgmWsOop21ZZhQNmywI
         j0Zb+tTnvNjUYNBF9cIaMZnZXd2IJqpjVQxMlVlg2HSuR2ySGAR36m8OAvvpAJjhkrHH
         lVCwUuLDgI1mFIE03SCcqEiRVH32iRtWg/xfX4lJwoowJroLBt2sq17ICr5uzkGR3nTt
         +2vhW3SlcQEXjGBAcYQaD/c7se+EhgZ7MBLw5B0xgCApm4kH9yTqJbP4s6JQ2wbVvPFl
         O8uHsXov9YH3JVoCNrZmZQWAqELuwv16ZDHVeu+2QjoI9PqEVtiZJ8EGBt7kPcNr6dGr
         Tr8w==
X-Gm-Message-State: AGRZ1gJSm6I5aarF5VVSROPkP90BM2vG1ek5igYxYiLfkGgdeT5IO/KD
        Anaki/vMo7ywLmeINnf4nBM=
X-Google-Smtp-Source: AJdET5cqC0G7rLztL0aBCb3WmOOJLos9qH11Z/U5C8Xz3/TCwrKcv+hzJFJ1JV+QVUcFW9xSxd7haA==
X-Received: by 2002:a24:cb05:: with SMTP id u5-v6mr3481004itg.157.1541015069325;
        Wed, 31 Oct 2018 12:44:29 -0700 (PDT)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id u142-v6sm7136606itb.13.2018.10.31.12.44.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 12:44:28 -0700 (PDT)
From:   thesven73@gmail.com
X-Google-Original-From: TheSven73@googlemail.com
To:     svendev@arcx.com, lee.jones@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, afaerber@suse.de, treding@nvidia.com,
        david@lechnology.com, noralf@tronnes.org, johan@kernel.org,
        monstr@monstr.eu, michal.vokac@ysoft.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, linus.walleij@linaro.org,
        maxime.ripard@bootlin.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH anybus v2 0/5] Support HMS Profinet Card over Anybus
Date:   Wed, 31 Oct 2018 15:44:20 -0400
Message-Id: <20181031194425.32132-1-TheSven73@googlemail.com>
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
custom h/w designed by Arcx. Its driver is modeled as a misc device, which
exposes a dual reset controller, plus a power readout unrelated to the anybus.

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

Sven Van Asbroeck (5):
  misc: support the Arcx anybus bridge.
  dt-bindings: anybus-bridge: document devicetree binding.
  bus: support HMS Anybus-S bus.
  dt-bindings: anybuss-host: document devicetree binding.
  misc: support HMS Profinet IRT industrial controller.

 .../bindings/bus/arcx,anybuss-host.txt        |   36 +
 .../bindings/misc/arcx,anybus-bridge.txt      |   34 +
 .../devicetree/bindings/vendor-prefixes.txt   |    1 +
 Documentation/ioctl/ioctl-number.txt          |    1 +
 drivers/bus/Kconfig                           |   10 +
 drivers/bus/Makefile                          |    1 +
 drivers/bus/anybuss-host.c                    | 1498 +++++++++++++++++
 drivers/misc/Kconfig                          |   19 +
 drivers/misc/Makefile                         |    2 +
 drivers/misc/anybus-bridge.c                  |  301 ++++
 drivers/misc/hms-profinet.c                   |  753 +++++++++
 include/linux/anybuss-client.h                |  100 ++
 include/uapi/linux/hms-common.h               |   14 +
 include/uapi/linux/hms-profinet.h             |  102 ++
 14 files changed, 2872 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/arcx,anybuss-host.txt
 create mode 100644 Documentation/devicetree/bindings/misc/arcx,anybus-bridge.txt
 create mode 100644 drivers/bus/anybuss-host.c
 create mode 100644 drivers/misc/anybus-bridge.c
 create mode 100644 drivers/misc/hms-profinet.c
 create mode 100644 include/linux/anybuss-client.h
 create mode 100644 include/uapi/linux/hms-common.h
 create mode 100644 include/uapi/linux/hms-profinet.h

-- 
2.17.1

