Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753090AbeBSOtz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 09:49:55 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:59732 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752853AbeBSOtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 09:49:53 -0500
Date: Mon, 19 Feb 2018 09:49:51 -0500 (EST)
Message-Id: <20180219.094951.2098243214524004486.davem@davemloft.net>
To: dwmw@amazon.co.uk
Cc: sparclinux@vger.kernel.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] sparc: Use generic pci_mmap_resource_range()
From: David Miller <davem@davemloft.net>
In-Reply-To: <1519045452-22645-1-git-send-email-dwmw@amazon.co.uk>
References: <1519045452-22645-1-git-send-email-dwmw@amazon.co.uk>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Woodhouse <dwmw@amazon.co.uk>
Date: Mon, 19 Feb 2018 13:04:12 +0000

> Commit f719582435 ("PCI: Add pci_mmap_resource_range() and use it for
> ARM64") added this generic function with the intent of using it
> everywhere and ultimately killing the old arch-specific implementations.
> 
> Let's get on with that eradication...
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

David, the generic code is definitely doing different things.

For one, the sparc specific code allows mmap'ing any address range
within a PCI bus device.  The generic code does not allow that.

I know this was used by the X server and that's why the logic is
there.

So we can't just use the generic code without breaking things, sorry.
