Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753525AbeBFWLd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 17:11:33 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:39895 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753133AbeBFWLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 17:11:30 -0500
X-Google-Smtp-Source: AH8x224kn1khOQQAYca4aA4V4H3CgFxP7BQXHrZPNUc07MY322Tx7dSndKf3q8T/NtyIAOJZ8dPOgQ==
From: Ulf Magnusson <ulfalizer@gmail.com>
To: helgaas@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        tfiga@chromium.org, paul.burton@mips.com, m.szyprowski@samsung.com,
        egtvedt@samfundet.no, linus.walleij@linaro.org, vgupta@synopsys.com,
        mgorman@techsingularity.net, hch@lst.de, mina86@mina86.com,
        robh@kernel.org, sboyd@codeaurora.org, paulus@ozlabs.org,
        will.deacon@arm.com, tony@atomide.com, npiggin@gmail.com,
        yamada.masahiro@socionext.com, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        Ulf Magnusson <ulfalizer@gmail.com>
Subject: [PATCH v2 20/20] x86/PCI: VMD: Fix malformed Kconfig default
Date: Tue,  6 Feb 2018 23:11:06 +0100
Message-Id: <20180206221106.16620-1-ulfalizer@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <0180206191126.GB98765@bhelgaas-glaptop.roam.corp.google.com>
References: <0180206191126.GB98765@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'default N' should be 'default n', though they happen to have the same
effect here, due to undefined symbols (N in this case) evaluating to n
in a tristate sense.

Remove the default instead of changing it. bool and tristate symbols
implicitly default to n.

Discovered with the
https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
script.

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
---
Changes in v2:
Make it clear that Kconfig is involved.

 drivers/pci/host/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index a4ed7484d127..dc8a2a175f19 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -215,7 +215,6 @@ config PCIE_TANGO_SMP8759
 config VMD
 	depends on PCI_MSI && X86_64 && SRCU
 	tristate "Intel Volume Management Device Driver"
-	default N
 	---help---
 	  Adds support for the Intel Volume Management Device (VMD). VMD is a
 	  secondary PCI host bridge that allows PCI Express root ports,
-- 
2.14.1
