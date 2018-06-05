Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751832AbeFEPZs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 11:25:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:38342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751662AbeFEPZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 11:25:47 -0400
Date: Tue, 5 Jun 2018 17:25:24 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: host: xhci-plat: Iterate over parent nodes for
 finding quirks
Message-ID: <20180605152524.GA23280@kroah.com>
References: <1528212056-28390-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528212056-28390-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 08:50:56PM +0530, Anurag Kumar Vulisha wrote:
> In xhci_plat_probe() both sysdev and pdev->dev are being used
> for finding quirks. There are some drivers(like dwc3 host.c)
> which adds quirks(like usb3-lpm-capable) into pdev and the logic
> present in xhci_plat_probe() checks for quirks in either sysdev
> or pdev for finding the quirks. Because of this logic, some of
> the quirks are getting missed(usb3-lpm-capable quirk added by dwc3
> host.c driver is getting missed).This patch fixes this by iterating
> over all the available parents for finding the quirks. In this way
> all the quirks which are present in child or parent are correctly
> updated.
> 
> Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>

So this is a bugfix?  If so, how far back in the kernel releases should
it go to?

thanks,

greg k-h
