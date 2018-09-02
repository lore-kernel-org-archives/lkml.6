Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E06AC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 11:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F358B20658
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 11:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F358B20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbeIBPiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 11:38:22 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:56433 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbeIBPiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 11:38:22 -0400
Received: from localhost.localdomain ([37.4.249.97]) by
 mrelayeu.kundenserver.de (mreue101 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 0MTQ5X-1gN3Zv1b3X-00SPxa; Sun, 02 Sep 2018 13:22:08 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Phil Elwell <phil@raspberrypi.org>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH RFC 0/2] hwmon: Add RPi PoE HAT fan driver
Date:   Sun,  2 Sep 2018 13:20:49 +0200
Message-Id: <1535887251-29515-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:TpjAAA3/EXvRpMTq2O4xqR89lOWOYoXF/FOZeK0Esf5GpLpisIV
 xAzqg8sIRgXCocI/sEVzpcBm3YYs5hM+kmKBC0nvTcQXe8mjZ/YKqwRwxG0dmOj/zxYJEMw
 DDVVvJ6Rg0+GFfVWolJ9dZ9/cIF9pMn2xYQPkPzPpY+VPEkSuGROLv9nM6f7PB/3tVEnj5m
 N8WdXBZNpot2uhHqwYEsA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qNQLwyNTlus=:pGArnJ1m6H6CmYPP10XP8E
 l83iJmuSJtZLei7irhqs/UPR3AIiyJWwy/pxJ4B/iFpAomgDnwevlZBpK+Wslwh8RFyxpb3oA
 PiC8qH5f4/2Vzct1vb57fzC6JI93bv3qIHFQ6jwVuhwA3xcwgjw9FDUhyAc26fnOy/CV8JmqJ
 /JX/ERZKrqEL7YvnalVGC8VgxoUNlUE9wDDcuftbrImlXrZgPTvPhY5p/08RbkH7KFrkueSBM
 2XXhj01asvH17YOKbYuAHxp+xbaZBiOTr/+Did55tDQpMq3za2Dh4nAxNgDyu1W/02gRH3bWo
 vOHL64XChnBVvek2+IMOYnM/zcThP6OQBw3Jhp9Ww9Ep9F/K/p9/OBCHjO7Pcdatc71NeeqeG
 psI9lJ/R6tamke3jUOkFsYL6LgzEGb/+2VyzpoHmqB3IY1QAPMEIsNN/TUj5JkVsN0KVD7U2e
 tWcNCJXlaYMRg1HjZpf/29TfirZi96zuO26UB3NzEr1HmxVf9U4DAX1fAnkVO34utbyHAg3Tr
 PZzeyptSsQsxR+JQwsk9B/F6vOjgOeZJRjO/ml1pvIyLqjMnmV6rJecXHmSguGJiCv4ReiE0i
 XVpHsq+G2YkISO2pB5ndVkCZEfG0ckN7CwU6a51pXrQMj9ETT71gS3Dkoi3Cc0/mDjgAF0yjv
 3G3eGQtfO+EIxwarsesZD+j5R/DgX8+++yZpbdooQjTF8kDAm4cziEzUmw37GiK5OVuw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is an early stage of the hwmon driver for the fan on the
Raspberry Pi Power over Ethernet HAT [1]. At the end this should use a
Device Tree Overlay.

Changes by Stefan based on [2]:
- reformat the downstream patches for submission
- drop reboot notification
- fix remaining checkpatch issues
- add COMPILE_TEST to Kconfig

The driver is mostly copy & paste from pwm-fan, which isn't good. Personally
i see two options:

1) integrate the driver function into the pwm-fan driver (new compatible)
2) implement the core function as a PWM driver and use the pwm-fan driver on top

[1] - https://www.raspberrypi.org/products/poe-hat/
[2] - https://github.com/raspberrypi/linux/commit/0f937c8dc3201ebffa6c617c616fd7c65db65959

Serge Schneider (2):
  dt-bindings: hwmon: Add RPi PoE HAT documentation
  hwmon: Add RPi PoE HAT fan driver

 .../devicetree/bindings/hwmon/rpi-poe-fan.txt      |  55 +++
 Documentation/hwmon/rpi-poe-fan                    |  15 +
 drivers/hwmon/Kconfig                              |  11 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/rpi-poe-fan.c                        | 414 +++++++++++++++++++++
 include/soc/bcm2835/raspberrypi-firmware.h         |   2 +
 6 files changed, 498 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/rpi-poe-fan.txt
 create mode 100644 Documentation/hwmon/rpi-poe-fan
 create mode 100644 drivers/hwmon/rpi-poe-fan.c

-- 
2.7.4

