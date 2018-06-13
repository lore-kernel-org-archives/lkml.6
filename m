Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BEF06C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F1E8208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F1E8208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964785AbeFMOpf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:45:35 -0400
Received: from lucky1.263xmail.com ([211.157.147.131]:36282 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935345AbeFMOpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:45:33 -0400
Received: from shawn.lin?rock-chips.com (unknown [192.168.167.232])
        by lucky1.263xmail.com (Postfix) with ESMTP id 814FB96584;
        Wed, 13 Jun 2018 22:45:10 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from [192.168.10.112] (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id A2119308;
        Wed, 13 Jun 2018 22:45:11 +0800 (CST)
X-RL-SENDER: shawn.lin@rock-chips.com
X-FST-TO: linux-arm-kernel@lists.infradead.org
X-SENDER-IP: 220.200.58.208
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-UNIQUE-TAG: <98bba4af37268b80eda2a189c1ba4b46>
X-ATTACHMENT-NUM: 0
X-SENDER: lintao@rock-chips.com
X-DNS-TYPE: 0
Received: from [192.168.10.112] (unknown [220.200.58.208])
        by smtp.263.net (Postfix) whith ESMTP id 2743535R9W0;
        Wed, 13 Jun 2018 22:45:12 +0800 (CST)
Cc:     shawn.lin@rock-chips.com, linux-rockchip@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM64: dts: rockchip: add some pins to rk3399
To:     klaus.goger@theobroma-systems.com, Randy Li <ayaka@soulik.info>
References: <20180612152544.3812-1-ayaka@soulik.info>
 <B649911B-28E0-4466-B3F0-15875FFB9D43@theobroma-systems.com>
From:   Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <e9584bfe-a098-1b90-2660-c27f82ed513c@rock-chips.com>
Date:   Wed, 13 Jun 2018 22:44:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <B649911B-28E0-4466-B3F0-15875FFB9D43@theobroma-systems.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/6/13 2:21, klaus.goger@theobroma-systems.com wrote:
> Hi Randy,

-----8<-------------

>> 		pcie {
>> +			pcie_clkreqn: pci-clkreqn {
>> +				rockchip,pins =
>> +					<2 26 RK_FUNC_2 &pcfg_pull_none>;
>> +			};
>> +
>> +			pcie_clkreqnb: pci-clkreqnb {
>> +				rockchip,pins =
>> +					<4 24 RK_FUNC_1 &pcfg_pull_none>;
>> +			};
>> +
> 
> I’m not sure if pci-clkreqn is functional at all. If not I’m not sure if we should add it to the dtsi.
> Shawn may know more about it.

Please refer to commit 461a00bb9d539e
("arm64: dts: rockchip: kill pcie_clkreqn and pcie_clkreqnb for rk3399")

CLKREQ# is used for PCI-PM L1.x, but it's not functional for rk3399, so
we have to support CPM(clock power management), thus I kill them last
year.

> 
>> 			pcie_clkreqn_cpm: pci-clkreqn-cpm {
>> 				rockchip,pins =
>> -					<2 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
>> +					<2 26 RK_FUNC_GPIO &pcfg_pull_none>;
>> 			};
>>
>> 			pcie_clkreqnb_cpm: pci-clkreqnb-cpm {
>> 				rockchip,pins =
>> -					<4 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>;
>> +					<4 24 RK_FUNC_GPIO &pcfg_pull_none>;
>> 			};
>> 		};
>>
>> -- 
>> 2.14.4
> 
> 
> Could we actually use RK_Pxx for all new pin definitions? Would increase readability a lot.
> 
> Thanks,
> Klaus
> 
> 


-- 
Best Regards
Shawn Lin

