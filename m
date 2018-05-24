Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965496AbeEXIxG convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 04:53:06 -0400
Received: from smtp2.it.da.ut.ee ([193.40.5.67]:33760 "EHLO smtp2.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965007AbeEXIxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 04:53:04 -0400
Date: Thu, 24 May 2018 11:34:26 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Bjorn Helgaas <helgaas@kernel.org>
cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: Re: [PATCH v1 0/4] sparc/PCI: VGA resource and other fixes
In-Reply-To: <20180522130217.GA161672@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <alpine.LRH.2.21.1805241133450.13830@math.ut.ee>
References: <152694888798.59585.8779818482732387864.stgit@bhelgaas-glaptop.roam.corp.google.com> <20180522130217.GA161672@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-7
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> [+cc sparclinux, sorry I missed this first time around]

> >       sparc/PCI: Use dev_printk() when possible

This patch causes compile errors for me:

  CC      arch/sparc/kernel/pci.o
In file included from ./include/linux/pci.h:31:0,
                 from arch/sparc/kernel/pci.c:18:
arch/sparc/kernel/pci.c: In function ¡pcibios_enable_device¢:
arch/sparc/kernel/pci.c:754:53: error: ¡old_cmd¢ undeclared (first use in this function)
   pci_info(dev, "enabling device (%04x -> %04x)\n", old_cmd, cmd);
                                                     ^
./include/linux/device.h:1384:58: note: in definition of macro ¡dev_info¢
 #define dev_info(dev, fmt, arg...) _dev_info(dev, fmt, ##arg)
                                                          ^
arch/sparc/kernel/pci.c:754:3: note: in expansion of macro ¡pci_info¢
   pci_info(dev, "enabling device (%04x -> %04x)\n", old_cmd, cmd);
   ^
arch/sparc/kernel/pci.c:754:53: note: each undeclared identifier is reported only once for each function it appears in
   pci_info(dev, "enabling device (%04x -> %04x)\n", old_cmd, cmd);
                                                     ^
./include/linux/device.h:1384:58: note: in definition of macro ¡dev_info¢
 #define dev_info(dev, fmt, arg...) _dev_info(dev, fmt, ##arg)
                                                          ^
arch/sparc/kernel/pci.c:754:3: note: in expansion of macro ¡pci_info¢
   pci_info(dev, "enabling device (%04x -> %04x)\n", old_cmd, cmd);
   ^
scripts/Makefile.build:312: recipe for target 'arch/sparc/kernel/pci.o' failed


-- 
Meelis Roos (mroos@linux.ee)
