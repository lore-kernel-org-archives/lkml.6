Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884FDC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5A620892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:54:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F5A620892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbeLGKyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:54:00 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:19838 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725994AbeLGKx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 05:53:59 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wB7ApFaX002996;
        Fri, 7 Dec 2018 11:53:13 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2p3uhna39j-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 07 Dec 2018 11:53:13 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2152431;
        Fri,  7 Dec 2018 10:53:12 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E468F2AB7;
        Fri,  7 Dec 2018 10:53:11 +0000 (GMT)
Received: from [10.201.23.29] (10.75.127.47) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 7 Dec
 2018 11:53:12 +0100
Subject: Re: [ v3 2/3] mtd: rawnand: stm32_fmc2: add STM32 FMC2 NAND flash
 controller driver
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <boris.brezillon@bootlin.com>, <richard@nod.at>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1543509663-26128-1-git-send-email-christophe.kerello@st.com>
 <1543509663-26128-3-git-send-email-christophe.kerello@st.com>
 <20181207111808.144fc3f0@xps13>
From:   Christophe Kerello <christophe.kerello@st.com>
Message-ID: <cb694a48-9b81-1d7d-08ea-910f37772aed@st.com>
Date:   Fri, 7 Dec 2018 11:53:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181207111808.144fc3f0@xps13>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-07_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquèl,

This patchset already takes into account new framework modifications 
done by Boris (3rd batch of cleanups).

The select_chip hook is not used any more in this patchset and 
exec_op/setup_data_interface hooks have been moved to 
nand_controller_ops structure.

static const struct nand_controller_ops stm32_fmc2_nand_controller_ops = {
	.attach_chip = stm32_fmc2_attach_chip,
	.exec_op = stm32_fmc2_exec_op,
	.setup_data_interface = stm32_fmc2_setup_interface,
};

Regards,
Christophe Kerello.

On 12/7/18 11:18 AM, Miquel Raynal wrote:
> Hi Christophe,
> 
> Christophe Kerello <christophe.kerello@st.com> wrote on Thu, 29 Nov
> 2018 17:41:02 +0100:
> 
>> The driver adds the support for the STMicroelectronics FMC2 NAND
>> Controller found on STM32MP SOCs.
>>
>> This patch is based on FMC2 command sequencer.
>> The purpose of the command sequencer is to facilitate the programming
>> and the reading of NAND flash pages with the ECC and to free the CPU
>> of sequencing tasks.
>> It requires one DMA channel for write and two DMA channels for read
>> operations.
>>
>> Only NAND_ECC_HW mode is actually supported.
>> The driver supports a maximum 8k page size.
>> The following ECC strength and step size are currently supported:
>>   - nand-ecc-strength = <8>, nand-ecc-step-size = <512> (BCH8)
>>   - nand-ecc-strength = <4>, nand-ecc-step-size = <512> (BCH4)
>>   - nand-ecc-strength = <1>, nand-ecc-step-size = <512> (Extended ECC
>>     based on Hamming)
>>
>> This patch has been tested on Micron MT29F8G08ABACAH4 and
>> MT29F8G16ABACAH4
>>
>> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
>> ---
> 
> The driver look's good to me. However, Boris contributed new
> cleanups that I would like you to take into account before doing
> another 'deep' review. Please rebase on top of nand/next and have
> a look at the followingcommits. For the ->select_chip() hook, it
> should not be exposed anymore and switches should be handled
> locally by the driver (you have examples).
> 
> 7a08dbaedd36 mtd: rawnand: Move ->setup_data_interface() to nand_controller_ops
> f2abfeb2078b mtd: rawnand: Move the ->exec_op() method to nand_controller_ops
> 7d6c37e90cf9 mtd: rawnand: Deprecate the ->select_chip() hook
> 1770022ffa85 mtd: rawnand: ams-delta: Stop implementing ->select_chip()
> 653c57c7da08 mtd: rawnand: vf610: Stop implementing ->select_chip()
> 2ace451cae22 mtd: rawnand: tegra: Stop implementing ->select_chip()
> b25251414f6e mtd: rawnand: marvell: Stop implementing ->select_chip()
> 550b9fc4e3af mtd: rawnand: fsmc: Stop implementing ->select_chip()
> 02b4a52604a4 mtd: rawnand: Make ->select_chip() optional when ->exec_op() is implemented
> ae2294b10b0f mtd: rawnand: Pass the CS line to be selected in struct nand_operation
> 1d0178593d14 mtd: rawnand: Add nand_[de]select_target() helpers
> 
> While at it, could you also address Linus W. comments.
> 
> Thanks,
> Miquèl
> 
