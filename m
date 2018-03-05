Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932661AbeCEXTj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 18:19:39 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33021 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932218AbeCEXTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 18:19:38 -0500
X-Google-Smtp-Source: AG47ELtgUzsSrP1nYgOt+e7pJxolASku5NtEL269AtVTJWifYgO0ki22fQcGJklpZxLP3Dv5+LH+5w==
Date: Mon, 5 Mar 2018 15:19:36 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Rob Herring <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Move declaration of of_irq_parse_and_map_pci under
 OF_IRQ
Message-ID: <20180305231936.GA14751@roeck-us.net>
References: <1519687145-9430-1-git-send-email-linux@roeck-us.net>
 <20180305215737.oxelfzdgsro6poee@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305215737.oxelfzdgsro6poee@rob-hp-laptop>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 03:57:37PM -0600, Rob Herring wrote:
> On Mon, Feb 26, 2018 at 03:19:05PM -0800, Guenter Roeck wrote:
> > Since commit 4670d610d5923 ("PCI: Move OF-related PCI functions into
> > PCI core"), sparc:allmodconfig fails to build with the following error.
> > 
> > pcie-cadence-host.c:(.text+0x4c4):
> > 	undefined reference to `of_irq_parse_and_map_pci'
> > pcie-cadence-host.c:(.text+0x4c8):
> > 	undefined reference to `of_irq_parse_and_map_pci'
> > 
> > of_irq_parse_and_map_pci is now only available if OF_IRQ is enabled.
> > Make its declaration and its dummy function dependent on OF_IRQ
> > to solve the problem.
> > 
> > Fixes: 4670d610d5923 ("PCI: Move OF-related PCI functions into PCI core")
> > Cc: Rob Herring <robh@kernel.org>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  include/linux/of_pci.h | 17 ++++++++++-------
> >  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> Bjorn should take this. Can you resend to linux-pci so it is in his 
> queue.
> 
MAINTAINERS lists you as maintainer and devicetree@vger.kernel.org as
mailing list. But, sure, no problem.

Guenter
