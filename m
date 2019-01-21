Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1606CC2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E434C2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbfAUNgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:36:25 -0500
Received: from mga11.intel.com ([192.55.52.93]:8938 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728693AbfAUNgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:36:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2019 05:36:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,503,1539673200"; 
   d="scan'208";a="293173028"
Received: from mylly.fi.intel.com (HELO [10.237.72.159]) ([10.237.72.159])
  by orsmga005.jf.intel.com with ESMTP; 21 Jan 2019 05:36:21 -0800
Subject: Re: linux-next: Tree for Jan 18 (i2c-designware-platdrv.c)
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Baruch Siach <baruch@tkos.co.il>, linux-i2c@vger.kernel.org
References: <20190118152404.41ecbe4e@canb.auug.org.au>
 <590dd86f-93ce-16c3-932e-c5ce53035ab2@infradead.org>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <018b454e-ecd8-0ebe-40cc-ab64d3deea00@linux.intel.com>
Date:   Mon, 21 Jan 2019 15:36:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <590dd86f-93ce-16c3-932e-c5ce53035ab2@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 1/18/19 6:27 PM, Randy Dunlap wrote:
> On 1/17/19 8:24 PM, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20190117:
>>
> 
> on i386 or x86_64:
> 
> ld: drivers/i2c/busses/i2c-designware-platdrv.o: in function `dw_i2c_plat_resume':
> i2c-designware-platdrv.c:(.text+0x4b): undefined reference to `i2c_dw_prepare_clk'
> ld: drivers/i2c/busses/i2c-designware-platdrv.o: in function `dw_i2c_plat_suspend':
> i2c-designware-platdrv.c:(.text+0x95): undefined reference to `i2c_dw_prepare_clk'
> ld: drivers/i2c/busses/i2c-designware-platdrv.o: in function `dw_i2c_plat_probe':
> i2c-designware-platdrv.c:(.text+0x63f): undefined reference to `i2c_dw_prepare_clk'
> ld: i2c-designware-platdrv.c:(.text+0x686): undefined reference to `i2c_dw_read_comp_param'
> ld: i2c-designware-platdrv.c:(.text+0x7b7): undefined reference to `i2c_dw_probe_slave'
> ld: i2c-designware-platdrv.c:(.text+0x7c1): undefined reference to `i2c_dw_probe'
> 
> 
> probably related to:
> 
> WARNING: unmet direct dependencies detected for I2C_DESIGNWARE_PLATFORM
>    Depends on [n]: I2C [=y] && HAS_IOMEM [=y] && (ACPI [=y] && COMMON_CLK [=n] || !ACPI [=y])
>    Selected by [y]:
>    - MFD_TPS68470 [=y] && HAS_IOMEM [=y] && ACPI [=y] && I2C [=y]=y
> 
Thanks, this is due CONFIG_MFD_TPS68470 which selects the 
I2C_DESIGNWARE_PLATFORM but not the dependencies. There are two others 
in drivers/mfd/Kconfig. I'll send a patch changing them to depend on 
I2C_DESIGNWARE_PLATFORM=y.

-- 
Jarkko
