Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2ADC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8048E256D3
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8048E256D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031028AbeGARp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:45:28 -0400
Received: from bmailout2.hostsharing.net ([83.223.90.240]:50277 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753091AbeGARpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 13:45:10 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id D17C12800B4B6;
        Sun,  1 Jul 2018 19:45:08 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 5CCE8D1E11; Sun,  1 Jul 2018 19:45:08 +0200 (CEST)
Date:   Sun, 1 Jul 2018 19:45:08 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] PCI: Document patch submission hints
Message-ID: <20180701174508.GB28249@wunner.de>
References: <153030390808.57832.2200774416664543563.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <153030405971.57832.12860154795039493576.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153030405971.57832.12860154795039493576.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 03:27:39PM -0500, Bjorn Helgaas wrote:
> --- /dev/null
> +++ b/Documentation/PCI/submitting-patches.txt
> @@ -0,0 +1,153 @@
> +Start with Documentation/process/submitting-patches.rst for general
> +guidance.
> +
> +These are things I look at when reviewing patches.

For an uninitiated reader who doesn't know that you're currently the
(sole) maintainer of the PCI subsystem, this sentence might look odd.
Who's "I"?  What happens if you onboard co-maintainers, are you
going to change this to "we"?


> +  - Wrap code and comments to fit in 80 columns.  Exception: I prefer
> +    printk strings to be in one piece for searchability, so don't split
> +    quoted strings to make them fit in 80 columns.

This is a duplication of Documentation/process/coding-style.rst, section 2.


> +  - Follow the existing convention  Run "git log --oneline <file>" and make
> +    your subject line match previous changes in format, capitalization, and
> +    sentence structure.  For example, native host bridge driver patch
> +    titles look like this:
> +
> +      PCI: vmd: Remove IRQ affinity so we can allocate more IRQs
> +      PCI: mediatek: Add MSI support for MT2712 and MT7622
> +      PCI: rockchip: Remove IRQ domain if probe fails

A quick "git log --oneline --no-merges drivers/pci" shows that the prefixes
in use aren't consistent at all:  Sometimes a slash is used to separate
"PCI" from the subpart touched by the patch, sometimes a colon, e.g.
"PCI/AER: " versus "PCI: shpchp: ".  Your own patches aren't consistent
in that respect.  Sometimes, only "PCI: " is given as prefix, even though
the commit only touches a subpart such as "sysfs", so could easily specify
more precisely what it's touching.

If you value consistency, it would be good to codify the preferred form
right here.


> +  - Include specific details, e.g., write "Add XYZ controller support"
> +    instead of "add support for new generation controller".

Why not simply "Support XYZ controller"?  One word less, more succinct.


> +  - Always copy linux-pci@vger.kernel.org and linux-kernel@vger.kernel.org.

I'd drop linux-kernel here.  The volume on that list is already like
drinking from a firehose, I doubt it adds much value to cc it.

Thanks,

Lukas
