Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751838AbeEDS1O (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 14:27:14 -0400
Received: from esa8.dell-outbound.iphmx.com ([68.232.149.218]:18014 "EHLO
        esa8.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751760AbeEDS1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 14:27:13 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GWAAD0pOxahz+a6ERcGwEBAQEDAQEBC?=
 =?us-ascii?q?QEBAYQleigKi2WMcYF4gQ+PAYQagXgLGAsLhD4CgjkhNBgBAgEBAQEBAQIBAQI?=
 =?us-ascii?q?QAQEBCgsJCCgjDII1IhFLLwEBAQEBAQEBASQBAQEBAQEjAg1jAQEBBAE5PwwEA?=
 =?us-ascii?q?gEIEQQBAR8JBygeCQgCBA4FCIUMD6pciEOCPQWIJYITgQ+DC4J6FwWHMQKMG4w?=
 =?us-ascii?q?CCIVkhQyDVIxiK4kXhwSBJRyCC3CDE4IuGohIhT5vAY5egRgBAQ?=
X-IPAS-Result: =?us-ascii?q?A2GWAAD0pOxahz+a6ERcGwEBAQEDAQEBCQEBAYQleigKi2W?=
 =?us-ascii?q?McYF4gQ+PAYQagXgLGAsLhD4CgjkhNBgBAgEBAQEBAQIBAQIQAQEBCgsJCCgjD?=
 =?us-ascii?q?II1IhFLLwEBAQEBAQEBASQBAQEBAQEjAg1jAQEBBAE5PwwEAgEIEQQBAR8JByg?=
 =?us-ascii?q?eCQgCBA4FCIUMD6pciEOCPQWIJYITgQ+DC4J6FwWHMQKMG4wCCIVkhQyDVIxiK?=
 =?us-ascii?q?4kXhwSBJRyCC3CDE4IuGohIhT5vAY5egRgBAQ?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.187
X-IronPort-AV: E=Sophos;i="5.49,363,1520917200";
   d="scan'208";a="650510153"
X-DLP: DLP_GlobalPCIDSS
To: <lkp@intel.com>
CC: <kbuild-all@01.org>, <linux-kernel@vger.kernel.org>,
        <dvhart@infradead.org>
Subject: RE: drivers/platform/x86/dell-smbios-smm.c:99: undefined reference to
 `dcdbas_smi_request'
Thread-Topic: drivers/platform/x86/dell-smbios-smm.c:99: undefined reference
 to `dcdbas_smi_request'
Thread-Index: AQHT49U4cp6Qu6gdQEiz7AsK+og9taQf40Ww
Date: Fri, 4 May 2018 18:27:00 +0000
Message-ID: <66cb778b7f9844eda89d2eec11158acc@ausx13mpc120.AMER.DELL.COM>
References: <201805050216.HVwTWQoD%fengguang.wu@intel.com>
In-Reply-To: <201805050216.HVwTWQoD%fengguang.wu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w44IRJQl031714

Darren,

Is this with that fix of mine merged?  

> -----Original Message-----
> From: kbuild test robot [mailto:lkp@intel.com]
> Sent: Friday, May 4, 2018 1:24 PM
> To: Limonciello, Mario
> Cc: kbuild-all@01.org; linux-kernel@vger.kernel.org; Darren Hart (VMware)
> Subject: drivers/platform/x86/dell-smbios-smm.c:99: undefined reference to
> `dcdbas_smi_request'
> 
> Hi Mario,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   625e2001e99e82ea3eb5b0370a428a4328b9166b
> commit: 25d47027e1003546bfd8964b4423cb39bc2d53e9 platform/x86: dell-
> smbios: Link all dell-smbios-* modules together
> date:   8 weeks ago
> config: x86_64-randconfig-s1-05050043 (attached as .config)
> compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
> reproduce:
>         git checkout 25d47027e1003546bfd8964b4423cb39bc2d53e9
>         # save the attached .config to linux build tree
>         make ARCH=x86_64
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/platform/x86/dell-smbios-smm.o: In function `dell_smbios_smm_call':
> >> drivers/platform/x86/dell-smbios-smm.c:99: undefined reference to
> `dcdbas_smi_request'
> 
> vim +99 drivers/platform/x86/dell-smbios-smm.c
> 
> 549b4930 Mario Limonciello 2017-11-01   84
> 549b4930 Mario Limonciello 2017-11-01   85  int dell_smbios_smm_call(struct
> calling_interface_buffer *input)
> 549b4930 Mario Limonciello 2017-11-01   86  {
> 549b4930 Mario Limonciello 2017-11-01   87  	struct smi_cmd command;
> 549b4930 Mario Limonciello 2017-11-01   88  	size_t size;
> 549b4930 Mario Limonciello 2017-11-01   89
> 549b4930 Mario Limonciello 2017-11-01   90  	size = sizeof(struct
> calling_interface_buffer);
> 549b4930 Mario Limonciello 2017-11-01   91  	command.magic =
> SMI_CMD_MAGIC;
> 549b4930 Mario Limonciello 2017-11-01   92  	command.command_address =
> da_command_address;
> 549b4930 Mario Limonciello 2017-11-01   93  	command.command_code =
> da_command_code;
> 549b4930 Mario Limonciello 2017-11-01   94  	command.ebx =
> virt_to_phys(buffer);
> 549b4930 Mario Limonciello 2017-11-01   95  	command.ecx = 0x42534931;
> 549b4930 Mario Limonciello 2017-11-01   96
> 549b4930 Mario Limonciello 2017-11-01   97  	mutex_lock(&smm_mutex);
> 549b4930 Mario Limonciello 2017-11-01   98  	memcpy(buffer, input, size);
> 549b4930 Mario Limonciello 2017-11-01  @99  	dcdbas_smi_request(&command);
> 549b4930 Mario Limonciello 2017-11-01  100  	memcpy(input, buffer, size);
> 549b4930 Mario Limonciello 2017-11-01  101  	mutex_unlock(&smm_mutex);
> 549b4930 Mario Limonciello 2017-11-01  102  	return 0;
> 549b4930 Mario Limonciello 2017-11-01  103  }
> 549b4930 Mario Limonciello 2017-11-01  104
> 
> :::::: The code at line 99 was first introduced by commit
> :::::: 549b4930f057658dc50d8010e66219233119a4d8 platform/x86: dell-smbios:
> Introduce dispatcher for SMM calls
> 
> :::::: TO: Mario Limonciello <mario.limonciello@dell.com>
> :::::: CC: Darren Hart (VMware) <dvhart@infradead.org>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
