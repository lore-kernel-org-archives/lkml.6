Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751855AbeELScM (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 14:32:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53418 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbeELScL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 14:32:11 -0400
Date: Sat, 12 May 2018 11:32:07 -0700
From: Darren Hart <dvhart@infradead.org>
To: kbuild test robot <lkp@intel.com>
Cc: Mario Limonciello <mario.limonciello@dell.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org
Subject: Re: drivers/platform/x86/dell-smbios-smm.c:99: undefined reference
 to `dcdbas_smi_request'
Message-ID: <20180512183207.GA5102@fedora>
References: <201805121703.jgrY5zId%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201805121703.jgrY5zId%fengguang.wu@intel.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 12, 2018 at 05:28:05PM +0800, kbuild test robot wrote:
> Hi Mario,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   f0ab773f5c96c29a5227234c4b5a820f5591b74d
> commit: 25d47027e1003546bfd8964b4423cb39bc2d53e9 platform/x86: dell-smbios: Link all dell-smbios-* modules together
> date:   9 weeks ago
> config: x86_64-randconfig-s5-05121617 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> reproduce:
>         git checkout 25d47027e1003546bfd8964b4423cb39bc2d53e9

This failure:

$ zcat config.gz | grep DCDBAS
CONFIG_DCDBAS=m            <----------

$ zcat config.gz | grep SMBIOS
CONFIG_DELL_SMBIOS=y       <----------
ddCONFIG_DELL_SMBIOS_WMI=y
CONFIG_DELL_SMBIOS_SMM=y   <----------

Is no longer possible as of:

cc69c88 platform/x86: dell-smbios: Resolve dependency error on DCDBAS

+#
+# If the DELL_SMBIOS_SMM feature is enabled, the DELL_SMBIOS driver
+# becomes dependent on the DCDBAS driver. The "depends" line prevents a
+# configuration where DELL_SMBIOS=y while DCDBAS=m.
+#
 config DELL_SMBIOS
        tristate "Dell SMBIOS driver"
+       depends on DCDBAS || DCDBAS=n

-- 
Darren Hart
VMware Open Source Technology Center
