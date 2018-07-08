Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32478C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 03:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D514E208B5
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 03:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D514E208B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754558AbeGHDAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 23:00:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59824 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754488AbeGHC75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 22:59:57 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1504E406E897;
        Sun,  8 Jul 2018 02:59:56 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 82C762156889;
        Sun,  8 Jul 2018 02:59:50 +0000 (UTC)
Date:   Sun, 8 Jul 2018 10:59:46 +0800
From:   Baoquan He <bhe@redhat.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, robh+dt@kernel.org,
        dan.j.williams@intel.com, nicolas.pitre@linaro.org,
        josh@joshtriplett.org, fengguang.wu@intel.com, bp@suse.de,
        andy.shevchenko@gmail.com, brijesh.singh@amd.com,
        devicetree@vger.kernel.org, airlied@linux.ie,
        linux-pci@vger.kernel.org, richard.weiyang@gmail.com,
        keith.busch@intel.com, jcmvbkbc@gmail.com,
        baiyaowei@cmss.chinamobile.com, frowand.list@gmail.com,
        lorenzo.pieralisi@arm.com, sthemmin@microsoft.com,
        linux-nvdimm@lists.01.org, patrik.r.jakobsson@gmail.com,
        linux-input@vger.kernel.org, gustavo@padovan.org,
        dyoung@redhat.com, vgoyal@redhat.com, thomas.lendacky@amd.com,
        haiyangz@microsoft.com, maarten.lankhorst@linux.intel.com,
        jglisse@redhat.com, seanpaul@chromium.org, bhelgaas@google.com,
        tglx@linutronix.de, yinghai@kernel.org, jonathan.derrick@intel.com,
        chris@zankel.net, monstr@monstr.eu, linux-parisc@vger.kernel.org,
        gregkh@linuxfoundation.org, dmitry.torokhov@gmail.com,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        devel@linuxdriverproject.org, linuxppc-dev@lists.ozlabs.org,
        davem@davemloft.net
Subject: Re: [PATCH v6 2/4] resource: Use list_head to link sibling resource
Message-ID: <20180708025946.GI3047@MiWiFi-R3L-srv>
References: <20180704041038.8190-3-bhe@redhat.com>
 <201807042347.hfDcKxmG%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201807042347.hfDcKxmG%fengguang.wu@intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Sun, 08 Jul 2018 02:59:56 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Sun, 08 Jul 2018 02:59:56 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07/05/18 at 01:00am, kbuild test robot wrote:
> Hi Baoquan,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.18-rc3 next-20180704]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

Thanks for telling. 

I cloned 0day-ci/linut to my local pc.
https://github.com/0day-ci/linux.git

However, I didn't find below branch. And tried to open it in web
broswer, also failed.


> url:    https://github.com/0day-ci/linux/commits/Baoquan-He/resource-Use-list_head-to-link-sibling-resource/20180704-121402
> config: mips-rb532_defconfig (attached as .config)
> compiler: mipsel-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=mips 

I did find a old one which is for the old version 5 post.

[bhe@linux]$ git remote -v
0day-ci	https://github.com/0day-ci/linux.git (fetch)
0day-ci	https://github.com/0day-ci/linux.git (push)
[bhe@dhcp-128-28 linux]$ git branch -a| grep Baoquan| grep resource
  remotes/0day-ci/Baoquan-He/resource-Use-list_head-to-link-sibling-resource/20180612-113600

Could you help have a look at this?

Thanks
Baoquan

> 
> All error/warnings (new ones prefixed by >>):
> 
> >> arch/mips/pci/pci-rc32434.c:57:11: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
>      .child = &rc32434_res_pci_mem2
>               ^
>    arch/mips/pci/pci-rc32434.c:57:11: note: (near initialization for 'rc32434_res_pci_mem1.child.next')
> >> arch/mips/pci/pci-rc32434.c:51:47: warning: missing braces around initializer [-Wmissing-braces]
>     static struct resource rc32434_res_pci_mem1 = {
>                                                   ^
>    arch/mips/pci/pci-rc32434.c:60:47: warning: missing braces around initializer [-Wmissing-braces]
>     static struct resource rc32434_res_pci_mem2 = {
>                                                   ^
>    cc1: some warnings being treated as errors
> 
> vim +57 arch/mips/pci/pci-rc32434.c
> 
> 73b4390f Ralf Baechle 2008-07-16  50  
> 73b4390f Ralf Baechle 2008-07-16 @51  static struct resource rc32434_res_pci_mem1 = {
> 73b4390f Ralf Baechle 2008-07-16  52  	.name = "PCI MEM1",
> 73b4390f Ralf Baechle 2008-07-16  53  	.start = 0x50000000,
> 73b4390f Ralf Baechle 2008-07-16  54  	.end = 0x5FFFFFFF,
> 73b4390f Ralf Baechle 2008-07-16  55  	.flags = IORESOURCE_MEM,
> 73b4390f Ralf Baechle 2008-07-16  56  	.sibling = NULL,
> 73b4390f Ralf Baechle 2008-07-16 @57  	.child = &rc32434_res_pci_mem2
> 73b4390f Ralf Baechle 2008-07-16  58  };
> 73b4390f Ralf Baechle 2008-07-16  59  
> 
> :::::: The code at line 57 was first introduced by commit
> :::::: 73b4390fb23456964201abda79f1210fe337d01a [MIPS] Routerboard 532: Support for base system
> 
> :::::: TO: Ralf Baechle <ralf@linux-mips.org>
> :::::: CC: Ralf Baechle <ralf@linux-mips.org>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


