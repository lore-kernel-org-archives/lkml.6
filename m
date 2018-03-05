Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753190AbeCEV5n (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 16:57:43 -0500
Received: from mail-ot0-f171.google.com ([74.125.82.171]:46457 "EHLO
        mail-ot0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752756AbeCEV5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 16:57:40 -0500
X-Google-Smtp-Source: AG47ELuRFCnQaDn9rIgiDKeIcuwe1agwgJdVp3lIpcX89MgCqLVryta8FpXfps1mTPaZdyeD7T5Kyg==
Date: Mon, 5 Mar 2018 15:57:37 -0600
From: Rob Herring <robh@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Move declaration of of_irq_parse_and_map_pci under
 OF_IRQ
Message-ID: <20180305215737.oxelfzdgsro6poee@rob-hp-laptop>
References: <1519687145-9430-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519687145-9430-1-git-send-email-linux@roeck-us.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 03:19:05PM -0800, Guenter Roeck wrote:
> Since commit 4670d610d5923 ("PCI: Move OF-related PCI functions into
> PCI core"), sparc:allmodconfig fails to build with the following error.
> 
> pcie-cadence-host.c:(.text+0x4c4):
> 	undefined reference to `of_irq_parse_and_map_pci'
> pcie-cadence-host.c:(.text+0x4c8):
> 	undefined reference to `of_irq_parse_and_map_pci'
> 
> of_irq_parse_and_map_pci is now only available if OF_IRQ is enabled.
> Make its declaration and its dummy function dependent on OF_IRQ
> to solve the problem.
> 
> Fixes: 4670d610d5923 ("PCI: Move OF-related PCI functions into PCI core")
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  include/linux/of_pci.h | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)

Bjorn should take this. Can you resend to linux-pci so it is in his 
queue.

Acked-by: Rob Herring <robh@kernel.org>

Rob
