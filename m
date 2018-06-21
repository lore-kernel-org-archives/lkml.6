Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C88CC43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99DB22496
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:11:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D99DB22496
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933910AbeFUWLL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 18:11:11 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:34197 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933446AbeFUWLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 18:11:09 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id w5LMAAPO024324;
        Fri, 22 Jun 2018 01:10:10 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 59FE162FF8; Fri, 22 Jun 2018 01:10:10 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, jdelvare@suse.com,
        linux@roeck-us.net, avifishman70@gmail.com, yuenn@google.com,
        brendanhiggins@google.com, venture@google.com, joel@jms.id.au
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, openbmc@lists.ozlabs.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v3 0/2] hwmon: Add NPCM7xx PWM and Fan driver support
Date:   Fri, 22 Jun 2018 01:09:55 +0300
Message-Id: <20180621220957.206638-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds Pulse Width Modulation (PWM) and Fan tacho
support for the Nuvoton NPCM7xx Baseboard Management Controller (BMC).

The Nuvoton BMC NPCM7xx has two identical PWM controller modules,
each module has four PWM controller outputs and eight identical Fan
controller modules, each module has two Fan controller inputs.

The hwmon driver provides sysfs entries through which the user can
configure and get the duty cycle between 0 (disable the specific PWM)
to 255 of particular PWM output port.

The driver support cooling device creation, that could be bound
to a thermal zone for the thermal control.

The NPCM7xx PWM and Fan driver tested on NPCM750 evaluation board.

Addressed comments from:.
 - Guenter Roeck: https://www.spinics.net/lists/kernel/msg2834515.html
				  https://www.spinics.net/lists/kernel/msg2835363.html
 
Changes since version 2:
 - Adding hwmon documentation
 - Using dev_function instead pr_function
 - Removing all typecast
 - Removing unused definitions
 - Adding () in macros parameters.
 - dt-binding documentation haven't changed
 
Changes since version 1:
 - Rename driver name
 - Adding Fan Controller support
 - Adding cooling device support
 - Modifying dt-binding documentation for Fan and cooling binding

Tomer Maimon (2):
  dt-binding: hwmon: Add NPCM7xx PWM and Fan controller documentation
  hwmon: npcm750: add NPCM7xx PWM and Fan driver

 .../devicetree/bindings/hwmon/npcm750-pwm-fan.txt  |   84 ++
 Documentation/hwmon/npcm750-pwm-fan                |   22 +
 drivers/hwmon/Kconfig                              |    7 +
 drivers/hwmon/Makefile                             |    1 +
 drivers/hwmon/npcm750-pwm-fan.c                    | 1073 ++++++++++++++++++++
 5 files changed, 1187 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/npcm750-pwm-fan.txt
 create mode 100644 Documentation/hwmon/npcm750-pwm-fan
 create mode 100644 drivers/hwmon/npcm750-pwm-fan.c

-- 
2.14.1

