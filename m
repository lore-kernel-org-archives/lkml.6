Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934394AbeEILl1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 07:41:27 -0400
Received: from bmailout2.hostsharing.net ([83.223.90.240]:34551 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933832AbeEILl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 07:41:26 -0400
Date: Wed, 9 May 2018 13:41:24 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Paul Menzel <pmenzel+linux-pci@molgen.mpg.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinan Kaya <okaya@codeaurora.org>
Subject: Re: pciehp 0000:00:1c.0:pcie004: Timeout on hotplug command 0x1038
 (issued 65284 msec ago)
Message-ID: <20180509114124.GA20639@wunner.de>
References: <8770820b-85a0-172b-7230-3a44524e6c9f@molgen.mpg.de>
 <20180427192207.GG8199@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427192207.GG8199@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 02:22:07PM -0500, Bjorn Helgaas wrote:
> Sinan mooted the idea of using a "no-wait" path of sending the "don't
> generate hotplug interrupts" command.  I think we should work on this
> idea a little more.  If we're shutting down the whole system, I can't
> believe there's much value in *anything* we do in the pciehp_remove()
> path.
> 
> Maybe we should just get rid of pciehp_remove() (and probably
> pcie_port_remove_service() and the other service driver remove methods)
> completely.  That dates from when the service drivers could be modules that
> could be potentially unloaded, but unloading them hasn't been possible for
> years.

Every Thunderbolt device contains a PCIe switch with at least one
(downstream) hotplug port, so pciehp_remove() is executed on unplug
of a Thunderbolt device and the assumption that it's unnecessary
simply because it's builtin isn't correct.

Thanks,

Lukas
