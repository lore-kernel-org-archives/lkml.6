Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57C7C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 23:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3927B2146B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 23:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uzsRlFAh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3927B2146B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754795AbeFZXcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 19:32:32 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:42838 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752441AbeFZXca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 19:32:30 -0400
Received: by mail-pf0-f193.google.com with SMTP id w7-v6so75319pfn.9;
        Tue, 26 Jun 2018 16:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=1RzXHFGeSM130pufeKLdLU5IFJl2YXuHbr0RuzWF2jA=;
        b=uzsRlFAhFIKY3U1Ce7z21KPIb6NNwpmTfJ27O7kfYFM0ePmiGeAtGE+SeVnXom81c7
         e/2j0+Jud5Td0j6qtj0f/AIPeCXFubQ+chpcWz7BqLA3mCGJj59g1w9G1hQOjXbtXQ7J
         RpViex+JSrhlN2q2QLyXT1w46vAXfDaW/KzifPJ+FRbMc4FEtua5ZkhAv2u+VW+7KcBE
         bB7rwM11BCExO1AcA5vT6AaH133LaXOUaa5Y3bQ8yFNrQsonSE9T+6vhSHdW9KRE4oXr
         7x5++DKH2Qe08I1lrn43Hxqy5x+tnAH4GuXSL7IJ8STVWh0ZOwDbWyHvkgy6ty5RJqhI
         Z5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=1RzXHFGeSM130pufeKLdLU5IFJl2YXuHbr0RuzWF2jA=;
        b=e2iN/xNW+h+vvEZB0J5DkmmgKuRVQfQM2uwzpzp35TJUa6sr5eLruy+1U+193ijCef
         zwc6v0AMUbVeN4kYUHOinIa9G6JZlZ/i/4aT8+2cKn4fl7+oQ9ltdPzJ0fQhdjzDkoaC
         q3as8VVY/pnxY9xvYf3rNS5AWFTNumrKV8oXUQ7xmj+wr/S2eK+t9omzaaGhWkm179vT
         HJ83r81bUErUMVqfvujXkc21IqOGvLojclIX3KdIlweHrXfJTpjBToEblngxkqrnurK1
         MuAOSEzGhKKjfioRZ9kFeg/lQXpgnLDwV7jRTUJ8BibTPNfb8NJ7dGrWuziVMEw/DffJ
         kYdA==
X-Gm-Message-State: APt69E3z6OOOp276w8ky2re4ozTZxLTv7+kFSAOCy/xDAWMLRlYqWJAk
        3ljK0TaUShMV6q3de0kitEp7BKwD
X-Google-Smtp-Source: AAOMgpcvk5Wi3VDGpp7e6S3D5JilMdq4p8c3eeZC7w73YoPkY9cnzVWZ0wekyEV6y97s0MsguOESJQ==
X-Received: by 2002:a62:4bc8:: with SMTP id d69-v6mr3475878pfj.244.1530055949412;
        Tue, 26 Jun 2018 16:32:29 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id f16-v6sm4711930pff.57.2018.06.26.16.32.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 16:32:28 -0700 (PDT)
Date:   Tue, 26 Jun 2018 16:32:26 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v4.18-rc2
Message-ID: <20180626233226.GA170294@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem:

- the main change is a fix for my brain-dead patch to PS/2 button
  reporting for some protocols that made it in 4.17

- there is a new driver for Spreadtum vibrator that I intended to send
  during merge window but ended up not sending the 2nd pull request.
  Given that this is a brand new driver we should not see regressions
  here

- a fixup to Elantech PS/2 driver to avoid decoding errors on Thinkpad
  P52

- addition of few more ACPI IDs for Silead and Elan drivers

- RMI4 is switched to using IRQ domain code instead of rolling its own
  implementation


Changelog:
---------

??? (1):
      Input: elantech - fix V4 report decoding for module with middle key

Aaron Ma (1):
      Input: elantech - enable middle button of touchpads on ThinkPad P52

Alexandr Savca (1):
      Input: elan_i2c - add ELAN0618 (Lenovo v330 15IKB) ACPI ID

Ben Hutchings (1):
      Input: elan_i2c_smbus - fix more potential stack buffer overflows

Dmitry Torokhov (3):
      Input: make input_report_slot_state() return boolean
      Input: do not assign new tracking ID when changing tool type
      Input: psmouse - fix button reporting for basic protocols

Enno Boland (1):
      Input: xpad - fix GPD Win 2 controller name

Hans de Goede (1):
      Input: silead - add MSSL0002 ACPI HID

Lucas Stach (1):
      Input: synaptics-rmi4 - fix axis-swap behavior

Nick Dyer (1):
      Input: synaptics-rmi4 - convert irq distribution to irq_domain

Roman Kiryanov (1):
      Input: goldfish_events - fix checkpatch warnings

Wei Yongjun (1):
      Input: synaptics-rmi4 - fix the error return code in rmi_probe_interrupts()

Xiaotong Lu (1):
      Input: add Spreadtrum vibrator driver

Diffstat:
--------

 .../bindings/input/sprd,sc27xx-vibra.txt           |  23 +++
 drivers/input/input-mt.c                           |  12 +-
 drivers/input/joystick/xpad.c                      |   2 +-
 drivers/input/keyboard/goldfish_events.c           |   9 +-
 drivers/input/misc/Kconfig                         |  10 ++
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/sc27xx-vibra.c                  | 154 +++++++++++++++++++++
 drivers/input/mouse/elan_i2c.h                     |   2 +
 drivers/input/mouse/elan_i2c_core.c                |   3 +-
 drivers/input/mouse/elan_i2c_smbus.c               |  10 +-
 drivers/input/mouse/elantech.c                     |  11 +-
 drivers/input/mouse/psmouse-base.c                 |  12 +-
 drivers/input/rmi4/Kconfig                         |   1 +
 drivers/input/rmi4/rmi_2d_sensor.c                 |  34 +++--
 drivers/input/rmi4/rmi_bus.c                       |  50 ++++++-
 drivers/input/rmi4/rmi_bus.h                       |  10 +-
 drivers/input/rmi4/rmi_driver.c                    |  52 +++----
 drivers/input/rmi4/rmi_f01.c                       |  10 +-
 drivers/input/rmi4/rmi_f03.c                       |   9 +-
 drivers/input/rmi4/rmi_f11.c                       |  42 +++---
 drivers/input/rmi4/rmi_f12.c                       |   8 +-
 drivers/input/rmi4/rmi_f30.c                       |   9 +-
 drivers/input/rmi4/rmi_f34.c                       |   5 +-
 drivers/input/rmi4/rmi_f54.c                       |   6 -
 drivers/input/touchscreen/silead.c                 |   1 +
 include/linux/input/mt.h                           |   2 +-
 include/linux/rmi.h                                |   2 +
 27 files changed, 366 insertions(+), 124 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/sprd,sc27xx-vibra.txt
 create mode 100644 drivers/input/misc/sc27xx-vibra.c

Thanks.


-- 
Dmitry
