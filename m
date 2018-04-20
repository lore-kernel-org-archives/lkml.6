Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752593AbeDTVwS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 17:52:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51930 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751865AbeDTVwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 17:52:16 -0400
Date: Fri, 20 Apr 2018 14:52:12 -0700
From: Darren Hart <dvhart@infradead.org>
To: Mario Limonciello <mario.limonciello@dell.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] platform/x86: Kconfig: Fix dell-laptop dependency chain.
Message-ID: <20180420215212.GE11546@fury>
References: <1524246131-17621-1-git-send-email-mario.limonciello@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524246131-17621-1-git-send-email-mario.limonciello@dell.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 12:42:11PM -0500, Mario Limonciello wrote:
> As reported by Randy Dunlap:
> >> WARNING: unmet direct dependencies detected for DELL_SMBIOS
> >>   Depends on [m]: X86 [=y] && X86_PLATFORM_DEVICES [=y]
> >>	&& (DCDBAS [=m] ||
> >> DCDBAS [=m]=n) && (ACPI_WMI [=n] || ACPI_WMI [=n]=n)
> >>   Selected by [y]:
> >>   - DELL_LAPTOP [=y] && X86 [=y] && X86_PLATFORM_DEVICES [=y]
> >> && DMI [=y]
> >> && BACKLIGHT_CLASS_DEVICE [=y] && (ACPI_VIDEO [=n] ||
> >>	ACPI_VIDEO [=n]=n)
> >> && (RFKILL [=n] || RFKILL [=n]=n) && SERIO_I8042 [=y]
> >>
> 
> Right now it's possible to set dell laptop to compile in but this
> causes dell-smbios to compile in which breaks if dcdbas is a module.
> 
> Dell laptop shouldn't select dell-smbios anymore, but depend on it.

Ugh. Indeed.

One of the goals of the previous maelstrom of dell* kconfig depencency
changes was to make it so DELL_LAPTOP was visible without having to
toggle DELL_SMBIOS*.  But, having "select DELL_SMBIOS" avoids the
dependency check causing this failure (I'm surprised and dismayed this
made it through all the config permutation testing this saw).

I'll apply this patch, and I guess it should go to stable, and for the
next version I think it's time for a new "CONFIG DELL_EXTRAS" which will
allow us to default DELL_SMBIOS to y and make the menu more consistent.

Thank you for the catch. Grrrrrr :-(

-- 
Darren Hart
VMware Open Source Technology Center
