Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757432AbeD0Rzs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 13:55:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57710 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751728AbeD0Rzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 13:55:47 -0400
Subject: Re: drivers/platform/x86/dell-smbios-wmi.c:66: undefined reference to
 `wmidev_evaluate_method'
To: kbuild test robot <lkp@intel.com>,
        Mario Limonciello <mario.limonciello@dell.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
        "Darren Hart (VMware)" <dvhart@infradead.org>
References: <201804272139.CYzGSbEr%fengguang.wu@intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0ccd04a5-2461-61b3-93b1-90ca4e96440d@infradead.org>
Date: Fri, 27 Apr 2018 10:55:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <201804272139.CYzGSbEr%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/27/2018 06:43 AM, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   0644f186fc9d77bb5bd198369e59fb28927a3692
> commit: 25d47027e1003546bfd8964b4423cb39bc2d53e9 platform/x86: dell-smbios: Link all dell-smbios-* modules together
> date:   7 weeks ago
> config: x86_64-randconfig-b0-04271930 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> reproduce:
>         git checkout 25d47027e1003546bfd8964b4423cb39bc2d53e9
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/platform/x86/dell-smbios-wmi.o: In function `run_smbios_call':
>>> drivers/platform/x86/dell-smbios-wmi.c:66: undefined reference to `wmidev_evaluate_method'
>    drivers/platform/x86/dell-smbios-wmi.o: In function `dell_smbios_wmi_probe':
>>> drivers/platform/x86/dell-smbios-wmi.c:157: undefined reference to `dell_wmi_get_descriptor_valid'
>>> drivers/platform/x86/dell-smbios-wmi.c:167: undefined reference to `dell_wmi_get_size'
>>> drivers/platform/x86/dell-smbios-wmi.c:171: undefined reference to `dell_wmi_get_hotfix'
>>> drivers/platform/x86/dell-smbios-wmi.c:182: undefined reference to `set_required_buffer_size'
>    drivers/platform/x86/dell-smbios-wmi.o: In function `init_dell_smbios_wmi':
>>> drivers/platform/x86/dell-smbios-wmi.c:271: undefined reference to `__wmi_driver_register'
>    drivers/platform/x86/dell-smbios-wmi.o: In function `exit_dell_smbios_wmi':
>>> drivers/platform/x86/dell-smbios-wmi.c:276: undefined reference to `wmi_driver_unregister'
> 
> 
> :::::: The code at line 66 was first introduced by commit
> :::::: 1a258e670434f404a4500b65ba1afea2c2b29bba platform/x86: dell-smbios-wmi: Add new WMI dispatcher driver
> 
> :::::: TO: Mario Limonciello <mario.limonciello@dell.com>
> :::::: CC: Darren Hart (VMware) <dvhart@infradead.org>

Hi,

To anyone contemplating this build error, there is already a fix for it from
Mario on 2018-04-20.  (Seems odd that the patch does not show up on
https://patchwork.kernel.org/project/platform-driver-x86/list/ )

See lkml.kernel.org/r/1524246131-17621-1-git-send-email-mario.limonciello@dell.com


-- 
~Randy
