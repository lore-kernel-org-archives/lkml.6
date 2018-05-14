Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752100AbeENIFf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:05:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:52201 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751853AbeENIFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:05:33 -0400
Date: Mon, 14 May 2018 10:05:30 +0200
From: Jean Delvare <jdelvare@suse.de>
To: kbuild test robot <lkp@intel.com>
Cc: Tony Luck <tony.luck@intel.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>
Subject: Re: drivers/edac/skx_edac.c:399: undefined reference to
 `nfit_get_smbios_id'
Message-ID: <20180514100530.3f2d0667@endymion>
In-Reply-To: <201805130419.XbKBtNfM%fengguang.wu@intel.com>
References: <201805130419.XbKBtNfM%fengguang.wu@intel.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 May 2018 04:51:21 +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   427fbe89261d8f11cd20b5a4ba94e977061f69d6
> commit: 58ca9ac1463d07d24b9fa8befe065192abca6f76 EDAC, skx_edac: Detect non-volatile DIMMs
> date:   8 weeks ago
> config: x86_64-randconfig-v0-05130337 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> reproduce:
>         git checkout 58ca9ac1463d07d24b9fa8befe065192abca6f76
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/edac/skx_edac.o: In function `get_nvdimm_info':
> >> drivers/edac/skx_edac.c:399: undefined reference to `nfit_get_smbios_id'

This is caused by the following combination of options:

CONFIG_ACPI_NFIT=m
CONFIG_EDAC_SKX=y

Built-in code (skx_edac) can't reference a function from a module
(nfit).

I'll send a candidate fix shortly.

-- 
Jean Delvare
SUSE L3 Support
