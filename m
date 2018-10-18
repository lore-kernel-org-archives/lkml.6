Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13079ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D296A2087A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D296A2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbeJRTVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 15:21:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:54926 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727470AbeJRTVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 15:21:46 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6624DAC082A15;
        Thu, 18 Oct 2018 19:21:10 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.399.0; Thu, 18 Oct 2018
 19:21:02 +0800
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
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <df892248-4f9c-c095-df9b-885f1e650ba0@huawei.com>
Date:   Thu, 18 Oct 2018 19:20:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <15c4ab00-3bfa-0eb8-a341-fc7a2be857f7@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

>>>>
>>> Now, the biggest question of them all: how does it work with ACPI? Last
>>> time I checked, there was no DT support for platforms using the MBIGEN.
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/hisilicon/hip07.dtsi
>> This DT describes how platform devices using the MBIGEN.
> 
> That's not how my own D05 boots. It is ACPI only. How is that going to
> work on this platform?

D05 is ACPI only so it has no dtb in the firmware, that's why we can
boot D05 without acpi=on in the boot cmdline, but if you want to
boot D05 with dtb, you could try to specify the dtb in the grub
(seems centos based):

menuentry "example" --id example{
        linux /Image-kernel root=... rdinit=...
        initrd /example.img
        devicetree /d05.dtb
}

Hope it helps.

Thanks
Hanjun

