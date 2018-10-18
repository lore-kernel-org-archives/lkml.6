Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A37FC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47032083A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C47032083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbeJRU4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 16:56:23 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13673 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726695AbeJRU4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 16:56:22 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C20C0BEEF1DEB;
        Thu, 18 Oct 2018 20:54:59 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.399.0; Thu, 18 Oct 2018
 20:54:51 +0800
Subject: Re: [PATCH 3/4] irqchip/mbigen: add support for a MBIGEN generating
 SPIs
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>
References: <1539681316-19300-1-git-send-email-yangyingliang@huawei.com>
 <1539681316-19300-4-git-send-email-yangyingliang@huawei.com>
 <a8ea3f08-8d60-13bf-edcc-03298a9cfb0d@arm.com> <5BC800EB.5070201@huawei.com>
 <15c4ab00-3bfa-0eb8-a341-fc7a2be857f7@arm.com>
 <df892248-4f9c-c095-df9b-885f1e650ba0@huawei.com>
 <223d7d7f-54b4-fd7f-1f83-95c9476136b7@arm.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <fde290c2-01e3-d5a8-eaa9-e7faaabf84ec@huawei.com>
Date:   Thu, 18 Oct 2018 20:54:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <223d7d7f-54b4-fd7f-1f83-95c9476136b7@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/18 19:56, Marc Zyngier wrote:
> Hi Hanjun,
> 
> On 18/10/18 12:20, Hanjun Guo wrote:
>> Hi Marc,
>>
>>>>>>
>>>>> Now, the biggest question of them all: how does it work with ACPI? Last
>>>>> time I checked, there was no DT support for platforms using the MBIGEN.
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/hisilicon/hip07.dtsi
>>>> This DT describes how platform devices using the MBIGEN.
>>>
>>> That's not how my own D05 boots. It is ACPI only. How is that going to
>>> work on this platform?
>>
>> D05 is ACPI only so it has no dtb in the firmware, that's why we can
>> boot D05 without acpi=on in the boot cmdline, but if you want to
>> boot D05 with dtb, you could try to specify the dtb in the grub
>> (seems centos based):
>>
>> menuentry "example" --id example{
>>         linux /Image-kernel root=... rdinit=...
>>         initrd /example.img
>>         devicetree /d05.dtb
>> }
> 
> Sure. But what I'm asking here is how this change in the MBIGEN driver
> can be beneficial to people who need ACPI, for better or worse? For
> example, you cannot get the PCIe SMMU without ACPI. Good-bye VFIO.
> 
> If it is DT only, I seriously doubt anyone will be able to use it.

We have another ARM64 SoC for wireless base station which with the
same CPU DIE but different IO DIE, they share the same mbigen controller.

Since we use big-endian on wireless base station so only DT is available
(EFI stub is little-endian), we need to reuse this mbigen driver
on this SoC (not the one for D05) as well, not sure if this makes sense
to you, please let us know.

Thanks
Hanjun

