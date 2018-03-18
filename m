Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754714AbeCRQHj (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 12:07:39 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:57104 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754575AbeCRQHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 12:07:36 -0400
Date: Sun, 18 Mar 2018 12:07:34 -0400 (EDT)
Message-Id: <20180318.120734.1936832399192758981.davem@davemloft.net>
To: helgaas@kernel.org
Cc: khalid.aziz@oracle.com, sparclinux@vger.kernel.org,
        linux-pci@vger.kernel.org, yinghai@kernel.org,
        linux-kernel@vger.kernel.org, david.ahern@oracle.com, linux@iam.tj
Subject: Re: [PATCH v1 0/2] PCI: Sparc 64-bit resource fixups
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180220233935.GE32228@bhelgaas-glaptop.roam.corp.google.com>
References: <20180215151118.196756.99622.stgit@bhelgaas-glaptop.roam.corp.google.com>
        <20180220233935.GE32228@bhelgaas-glaptop.roam.corp.google.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <helgaas@kernel.org>
Date: Tue, 20 Feb 2018 17:39:35 -0600

> Both these patches are on my pci/sparc branch and appeared in the
> Feb 19 linux-next tree.
> 
> Any testing and feedback (especially on the second patch, which should
> change /proc/iomem) would be great.
> 
> They're headed for v4.17 unless I hear about issues.
> 
> It would be useful to hear about what's still broken so I can try to
> pull in the other patches.

I don't understand why you put the SYSTEM and Video ROM at addresses
relative to absolute zero.  The result of this is that it might
overlap real physical memory.

If a VGA card is present, it's ROM will respond to those addresses
relative to the PCI controller's MEM space area.

Their legacy resources are "hardwired", but those hardwired addresses
need to be relative to the PCI host controller's MEM areas in order
for them to be accessible.

I could understand removing the System ROM resource altogether, that
makes a lot of sense to me.

Thanks.
