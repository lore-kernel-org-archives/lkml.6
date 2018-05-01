Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbeEAFaN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 01:30:13 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:44424 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbeEAFaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 01:30:12 -0400
X-Google-Smtp-Source: AB8JxZoH2Ajf2RebOm+N81YJgD7dJID63SM6cye/yY9XqxJ2wRtnwJQ6Genyozt/kyZ5ofh9UjZXdg==
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-kernel@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Aleksander Morgado <aleksander@aleksander.es>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 0/2] RAVE SP EEPROM driver
Date: Mon, 30 Apr 2018 22:29:50 -0700
Message-Id: <20180501052952.26765-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Srinivas:

This series is a third iteration of the patchset adding NVMEM support
for EEPROMs connected to RAVE SP MFD device (support for which landed
in 4.15).

Chagnes since [v2]:

	- Added verbiage about data cells, fixed captial case hex
          number as well as lack of address in node name in
          zii,rave-sp-eeprom.txt

	- Added optional DT property "zii,eeprom-name", to allow
          giving more descriptive names to NVMEM devices created by
          the driver

Changes since [v1]:

	- Patchset rebased on latest master from Linus which contains
          all necessary dependencies

	- Added sizes.h to include in patch 1/2 to avoid build breaks
          reported by build-bot

	- Added missing #size-cells, #address-cells as well as example
	  cell to DT bindings documentation (pointed out by Rob)

Feedback is wellcome!

Thanks,
Andrey Smirnov

[v2] lkml.kernel.org/r/20180411015948.19562-1-andrew.smirnov@gmail.com
[v1] lkml.kernel.org/r/20180321134710.29757-1-andrew.smirnov@gmail.com

Andrey Smirnov (2):
  dt-bindings: nvmem: Add binding for RAVE SP EEPROM driver
  nvmem: Add RAVE SP EEPROM driver

 .../bindings/nvmem/zii,rave-sp-eeprom.txt          |  40 +++
 drivers/nvmem/Kconfig                              |   6 +
 drivers/nvmem/Makefile                             |   3 +
 drivers/nvmem/rave-sp-eeprom.c                     | 357 +++++++++++++++++++++
 4 files changed, 406 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt
 create mode 100644 drivers/nvmem/rave-sp-eeprom.c

-- 
2.14.3
