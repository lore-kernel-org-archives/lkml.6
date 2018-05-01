Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751294AbeEAUNh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 16:13:37 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:52923 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750785AbeEAUNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 16:13:35 -0400
Date: Tue, 1 May 2018 13:13:29 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Thomas Gleixner <tglx@linutronix.de>,
        Clemens Ladisch <clemens@ladisch.de>, Jean Delvare <jdelvare@suse.com>,
        Borislav Petkov <bp@suse.de>, Yazen Ghannam <Yazen.Ghannam@amd.com>,
        Brian Woods <brian.woods@amd.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v2 2/2] hwmon: (k10temp) Use API function to access
 System Management Network
Message-ID: <20180501201329.GA15515@roeck-us.net>
References: <1525199182-10474-2-git-send-email-linux@roeck-us.net>
 <201805020322.y0mYt3Nk%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201805020322.y0mYt3Nk%fengguang.wu@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2018 at 03:39:19AM +0800, kbuild test robot wrote:
> Hi Guenter,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on tip/auto-latest]
> [also build test ERROR on v4.17-rc3 next-20180501]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Guenter-Roeck/x86-amd_nb-Add-support-for-Raven-Ridge-CPUs/20180502-024535
> config: i386-randconfig-x016-201817 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/hwmon/k10temp.c: In function 'read_tempreg_nb_f17':
> >> drivers/hwmon/k10temp.c:126:15: error: implicit declaration of function 'amd_pci_dev_to_node_id'; did you mean 'pci_set_of_node'? [-Werror=implicit-function-declaration]
>      amd_smn_read(amd_pci_dev_to_node_id(pdev),
>                   ^~~~~~~~~~~~~~~~~~~~~~
>                   pci_set_of_node
>    cc1: some warnings being treated as errors
> 

What would we do without 0day. The driver needs to depend on CONFIG_AMD_NB,
which makes sense anyway. I'll add that dependency in v3.

Guenter

> vim +126 drivers/hwmon/k10temp.c
> 
>    123	
>    124	static void read_tempreg_nb_f17(struct pci_dev *pdev, u32 *regval)
>    125	{
>  > 126		amd_smn_read(amd_pci_dev_to_node_id(pdev),
>    127			     F17H_M01H_REPORTED_TEMP_CTRL_OFFSET, regval);
>    128	}
>    129	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
