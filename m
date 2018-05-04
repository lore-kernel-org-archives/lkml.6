Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751248AbeEENNs (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 09:13:48 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38584 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbeEENNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 09:13:45 -0400
Date: Fri, 04 May 2018 22:08:59 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <66cb778b7f9844eda89d2eec11158acc@ausx13mpc120.AMER.DELL.COM>
References: <201805050216.HVwTWQoD%fengguang.wu@intel.com> <66cb778b7f9844eda89d2eec11158acc@ausx13mpc120.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: RE: drivers/platform/x86/dell-smbios-smm.c:99: undefined reference to `dcdbas_smi_request'
To: Mario.Limonciello@dell.com, lkp@intel.com
CC: kbuild-all@01.org, linux-kernel@vger.kernel.org
From: dvhart@infradead.org
Message-ID: <7CD00CD3-D122-4F02-9CD4-4171EE61E785@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w45DDr5G011289

No, your fix is in next, but needs to go to Linus via the fixes branch. I have 2 to send on to him. I am traveling and was planning to do it this weekend.

On May 4, 2018 8:27:00 PM GMT+02:00, Mario.Limonciello@dell.com wrote:
>Darren,
>
>Is this with that fix of mine merged?  
>
>> -----Original Message-----
>> From: kbuild test robot [mailto:lkp@intel.com]
>> Sent: Friday, May 4, 2018 1:24 PM
>> To: Limonciello, Mario
>> Cc: kbuild-all@01.org; linux-kernel@vger.kernel.org; Darren Hart
>(VMware)
>> Subject: drivers/platform/x86/dell-smbios-smm.c:99: undefined
>reference to
>> `dcdbas_smi_request'
>> 
>> Hi Mario,
>> 
>> FYI, the error/warning still remains.
>> 
>> tree:  
>https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>master
>> head:   625e2001e99e82ea3eb5b0370a428a4328b9166b
>> commit: 25d47027e1003546bfd8964b4423cb39bc2d53e9 platform/x86: dell-
>> smbios: Link all dell-smbios-* modules together
>> date:   8 weeks ago
>> config: x86_64-randconfig-s1-05050043 (attached as .config)
>> compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
>> reproduce:
>>         git checkout 25d47027e1003546bfd8964b4423cb39bc2d53e9
>>         # save the attached .config to linux build tree
>>         make ARCH=x86_64
>> 
>> All errors (new ones prefixed by >>):
>> 
>>    drivers/platform/x86/dell-smbios-smm.o: In function
>`dell_smbios_smm_call':
>> >> drivers/platform/x86/dell-smbios-smm.c:99: undefined reference to
>> `dcdbas_smi_request'
>> 
>> vim +99 drivers/platform/x86/dell-smbios-smm.c
>> 
>> 549b4930 Mario Limonciello 2017-11-01   84
>> 549b4930 Mario Limonciello 2017-11-01   85  int
>dell_smbios_smm_call(struct
>> calling_interface_buffer *input)
>> 549b4930 Mario Limonciello 2017-11-01   86  {
>> 549b4930 Mario Limonciello 2017-11-01   87  	struct smi_cmd command;
>> 549b4930 Mario Limonciello 2017-11-01   88  	size_t size;
>> 549b4930 Mario Limonciello 2017-11-01   89
>> 549b4930 Mario Limonciello 2017-11-01   90  	size = sizeof(struct
>> calling_interface_buffer);
>> 549b4930 Mario Limonciello 2017-11-01   91  	command.magic =
>> SMI_CMD_MAGIC;
>> 549b4930 Mario Limonciello 2017-11-01   92  	command.command_address
>=
>> da_command_address;
>> 549b4930 Mario Limonciello 2017-11-01   93  	command.command_code =
>> da_command_code;
>> 549b4930 Mario Limonciello 2017-11-01   94  	command.ebx =
>> virt_to_phys(buffer);
>> 549b4930 Mario Limonciello 2017-11-01   95  	command.ecx =
>0x42534931;
>> 549b4930 Mario Limonciello 2017-11-01   96
>> 549b4930 Mario Limonciello 2017-11-01   97  	mutex_lock(&smm_mutex);
>> 549b4930 Mario Limonciello 2017-11-01   98  	memcpy(buffer, input,
>size);
>> 549b4930 Mario Limonciello 2017-11-01  @99 
>	dcdbas_smi_request(&command);
>> 549b4930 Mario Limonciello 2017-11-01  100  	memcpy(input, buffer,
>size);
>> 549b4930 Mario Limonciello 2017-11-01  101 
>	mutex_unlock(&smm_mutex);
>> 549b4930 Mario Limonciello 2017-11-01  102  	return 0;
>> 549b4930 Mario Limonciello 2017-11-01  103  }
>> 549b4930 Mario Limonciello 2017-11-01  104
>> 
>> :::::: The code at line 99 was first introduced by commit
>> :::::: 549b4930f057658dc50d8010e66219233119a4d8 platform/x86:
>dell-smbios:
>> Introduce dispatcher for SMM calls
>> 
>> :::::: TO: Mario Limonciello <mario.limonciello@dell.com>
>> :::::: CC: Darren Hart (VMware) <dvhart@infradead.org>
>> 
>> ---
>> 0-DAY kernel test infrastructure                Open Source
>Technology Center
>> https://lists.01.org/pipermail/kbuild-all                   Intel
>Corporation

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
