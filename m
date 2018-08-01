Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D53C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 553D920844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 553D920844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388636AbeHAKYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 06:24:48 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:39623 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387532AbeHAKYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 06:24:47 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 41gRZT3LWpz1qwBs;
        Wed,  1 Aug 2018 10:40:01 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 41gRZS6fypz1qrVp;
        Wed,  1 Aug 2018 10:40:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id q7pa1LtlTEBw; Wed,  1 Aug 2018 10:39:58 +0200 (CEST)
X-Auth-Info: KVd1PqIwZ1GoaF3BAnU8Qc9nbgPElC+ySq9xCyDtEQ4=
Received: from antares.denx.de (unknown [62.91.23.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed,  1 Aug 2018 10:39:58 +0200 (CEST)
Cc:     pn@denx.de, kbuild-all@01.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mp-cs@actions-semi.com, jeff.chen@actions-semi.com,
        thomas.liau@actions-semi.com, linux@cubietech.com
Subject: Re: [PATCH v4 5/5] arm64: dts: actions: Add pinctrl node for Actions
 Semi S700
To:     kbuild test robot <lkp@intel.com>,
        Saravanan Sekar <sravanhome@gmail.com>,
        manivannan.sadhasivam@linaro.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, afaerber@suse.de
References: <20180731194743.13678-6-sravanhome@gmail.com>
 <201808010805.DWcXxX04%fengguang.wu@intel.com>
From:   Parthiban Nallathambi <pn@denx.de>
Message-ID: <2e0c0f5b-40a0-4f62-756f-1377f587d9a0@denx.de>
Date:   Wed, 1 Aug 2018 10:39:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <201808010805.DWcXxX04%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 08/01/2018 02:45 AM, kbuild test robot wrote:
> Hi Saravanan,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on pinctrl/devel]
> [also build test ERROR on next-20180731]
> [cannot apply to v4.18-rc7]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Saravanan-Sekar/pinctrl-actions-define-constructor-generic-to-Actions-Semi-SoC-s/20180801-042834
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
> config: arm64-defconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          GCC_VERSION=7.2.0 make.cross ARCH=arm64
> 
> All errors (new ones prefixed by >>):
> 
>>> Error: arch/arm64/boot/dts/actions/s700.dtsi:172.19-20 syntax error
>>> FATAL ERROR: Unable to parse input tree

Device tree entry in this patch depends on actions clock patch [1],
and it is not yet merged. The above build error is because of the
dependency.

[1] https://patchwork.kernel.org/patch/10533959/

> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 

-- 
Thanks,
Parthiban Nallathambi

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
