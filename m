Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759442AbeD0V5c (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 17:57:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47178 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759307AbeD0V52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 17:57:28 -0400
Subject: Re: drivers/platform/x86/dell-smbios-wmi.c:66: undefined reference to
 `wmidev_evaluate_method'
To: Mario.Limonciello@dell.com, lkp@intel.com
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, dvhart@infradead.org
References: <201804272139.CYzGSbEr%fengguang.wu@intel.com>
 <0ccd04a5-2461-61b3-93b1-90ca4e96440d@infradead.org>
 <c354e68ba5f54d8e891631fae3cfa877@ausx13mpc120.AMER.DELL.COM>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7e56091f-18a1-0b18-4584-0142c44bc95b@infradead.org>
Date: Fri, 27 Apr 2018 14:57:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <c354e68ba5f54d8e891631fae3cfa877@ausx13mpc120.AMER.DELL.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/27/2018 11:01 AM, Mario.Limonciello@dell.com wrote:
>> -----Original Message-----
>> From: Randy Dunlap [mailto:rdunlap@infradead.org]
>> Sent: Friday, April 27, 2018 12:56 PM
>> To: kbuild test robot; Limonciello, Mario
>> Cc: kbuild-all@01.org; linux-kernel@vger.kernel.org; Darren Hart (VMware)
>> Subject: Re: drivers/platform/x86/dell-smbios-wmi.c:66: undefined reference to
>> `wmidev_evaluate_method'
>>
>> On 04/27/2018 06:43 AM, kbuild test robot wrote:
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>> head:   0644f186fc9d77bb5bd198369e59fb28927a3692
>>> commit: 25d47027e1003546bfd8964b4423cb39bc2d53e9 platform/x86: dell-
>> smbios: Link all dell-smbios-* modules together
>>> date:   7 weeks ago
>>> config: x86_64-randconfig-b0-04271930 (attached as .config)
>>> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
>>> reproduce:
>>>         git checkout 25d47027e1003546bfd8964b4423cb39bc2d53e9
>>>         # save the attached .config to linux build tree
>>>         make ARCH=x86_64
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>>    drivers/platform/x86/dell-smbios-wmi.o: In function `run_smbios_call':
>>>>> drivers/platform/x86/dell-smbios-wmi.c:66: undefined reference to
>> `wmidev_evaluate_method'
>>>    drivers/platform/x86/dell-smbios-wmi.o: In function `dell_smbios_wmi_probe':
>>>>> drivers/platform/x86/dell-smbios-wmi.c:157: undefined reference to
>> `dell_wmi_get_descriptor_valid'
>>>>> drivers/platform/x86/dell-smbios-wmi.c:167: undefined reference to
>> `dell_wmi_get_size'
>>>>> drivers/platform/x86/dell-smbios-wmi.c:171: undefined reference to
>> `dell_wmi_get_hotfix'
>>>>> drivers/platform/x86/dell-smbios-wmi.c:182: undefined reference to
>> `set_required_buffer_size'
>>>    drivers/platform/x86/dell-smbios-wmi.o: In function `init_dell_smbios_wmi':
>>>>> drivers/platform/x86/dell-smbios-wmi.c:271: undefined reference to
>> `__wmi_driver_register'
>>>    drivers/platform/x86/dell-smbios-wmi.o: In function `exit_dell_smbios_wmi':
>>>>> drivers/platform/x86/dell-smbios-wmi.c:276: undefined reference to
>> `wmi_driver_unregister'
>>>
>>>
>>> :::::: The code at line 66 was first introduced by commit
>>> :::::: 1a258e670434f404a4500b65ba1afea2c2b29bba platform/x86: dell-smbios-
>> wmi: Add new WMI dispatcher driver
>>>
>>> :::::: TO: Mario Limonciello <mario.limonciello@dell.com>
>>> :::::: CC: Darren Hart (VMware) <dvhart@infradead.org>
>>
>> Hi,
>>
>> To anyone contemplating this build error, there is already a fix for it from
>> Mario on 2018-04-20.  (Seems odd that the patch does not show up on
>> https://patchwork.kernel.org/project/platform-driver-x86/list/ )
>>
>> See lkml.kernel.org/r/1524246131-17621-1-git-send-email-
>> mario.limonciello@dell.com
>>
>>
>> --
> 
> I'm wondering if that is enough of a fix though.  This "new" build error is actually
> with WMI stuff which might need adjusting too..?
> 

Hi,

CONFIG_DELL_SMBIOS=y
CONFIG_DELL_SMBIOS_WMI=y
# CONFIG_DELL_SMBIOS_SMM is not set
CONFIG_DELL_LAPTOP=y
# CONFIG_DELL_WMI is not set
CONFIG_DELL_WMI_DESCRIPTOR=m
# CONFIG_DELL_WMI_AIO is not set
CONFIG_DELL_WMI_LED=m
CONFIG_ACPI_WMI=m

kconfig tells us:

WARNING: unmet direct dependencies detected for DELL_SMBIOS
  Depends on [m]: X86 [=y] && X86_PLATFORM_DEVICES [=y] && (DCDBAS [=y] || DCDBAS [=y]=n) && (ACPI_WMI [=m] || ACPI_WMI [=m]=n)
  Selected by [y]:
  - DELL_LAPTOP [=y] && X86 [=y] && X86_PLATFORM_DEVICES [=y] && DMI [=y] && BACKLIGHT_CLASS_DEVICE [=y] && (ACPI_VIDEO [=n] || ACPI_VIDEO [=n]=n) && (RFKILL [=y] || RFKILL [=y]=n) && SERIO_I8042 [=y]


The crux of the problem is that DELL_SMBIOS=y (is builtin) but DELL_WMI_DESCRIPTOR=m,
so calls from dell-smbios-wmi.c cannot see the dell-wmi-descriptor.c APIs.

DELL_WMI_DESCRIPTOR depends on ACPI_WMI [which =m in the problem .config],
so ... Wait!

DELL_SMBIOS depends on ACPI_WMI so when ACPI_WMI=m, DELL_SMBIOS should never =y.
Your DELL_LAPTOP Kconfig patch does fix this, I believe, because when DELL_LAPTOP=y,
its select DELL_SMBIOS incorrectly makes DELL_SMBIOS=y.


so if we can get your patch merged, we can see if any more breakage happens... :)

-- 
~Randy
