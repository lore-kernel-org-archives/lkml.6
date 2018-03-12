Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932376AbeCLUXX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 16:23:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46592 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932214AbeCLUXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 16:23:22 -0400
Date: Mon, 12 Mar 2018 13:23:19 -0700
From: Darren Hart <dvhart@infradead.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: mario.limonciello@dell.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Dell Inc. XPS 13 9343/0TM99H fails to boot v4.16-rc5
Message-ID: <20180312202319.GA88572@localhost.localdomain>
References: <20180312185357.GA1672@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312185357.GA1672@light.dominikbrodowski.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 07:53:57PM +0100, Dominik Brodowski wrote:
> Mario,
> 
> unfortunately, my Dell Inc. XPS 13 9343/0TM99H, BIOS A11 12/08/2016 fails to
> boot v4.16-rc5. More exactly, I could bisect it down to commit 25d47027e10
> ("platform/x86: dell-smbios: Link all dell-smbios-* modules together").
> Usually, I have enabled
> 
> CONFIG_SENSORS_DELL_SMM=y
> CONFIG_DELL_SMBIOS=y
> CONFIG_DELL_SMBIOS_WMI=y
> CONFIG_DELL_SMBIOS_SMM=y
> CONFIG_DELL_LAPTOP=y
> CONFIG_DELL_WMI=y
> CONFIG_DELL_WMI_DESCRIPTOR=y
> # CONFIG_DELL_WMI_AIO is not set
> # CONFIG_DELL_WMI_LED is not set
> # CONFIG_DELL_SMO8800 is not set
> # CONFIG_DELL_RBTN is not set
> # CONFIG_DELL_RBU is not set
> 
> For v4.16-rc5 to work, I need to manually disable DELL_SMBIOS_WMI:
> 
> -CONFIG_DELL_SMBIOS_WMI=y
> +# CONFIG_DELL_SMBIOS_WMI is not set
> 
> Any ideas?

We're working on a dependency fix, but I think the problem you have here is
likely to be ACPI_WMI=m instead of =y while you have DELL_SMBIOS=y

The fix won't allow that configuration. I'll include you in Cc of v2 of that
fix which I'll send shortly.

-- 
Darren Hart
VMware Open Source Technology Center
