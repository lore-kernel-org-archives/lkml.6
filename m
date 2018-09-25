Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA48C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 504802087A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:15:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504802087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbeIYPVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:21:47 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:46543 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727526AbeIYPVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:21:47 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w8P9AUpL026643;
        Tue, 25 Sep 2018 11:14:14 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2mnb6xb3eq-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 25 Sep 2018 11:14:14 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1065D59;
        Tue, 25 Sep 2018 09:14:13 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CC8062906;
        Tue, 25 Sep 2018 09:14:12 +0000 (GMT)
Received: from [10.201.23.29] (10.75.127.47) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 25 Sep
 2018 11:14:11 +0200
Subject: Re: [PATCH 1/3] dt-bindings: mtd: stm32_fmc2: add STM32 FMC2 NAND
 controller documentation
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <richard@nod.at>, <linux-kernel@vger.kernel.org>,
        <marek.vasut@gmail.com>, <robh+dt@kernel.org>,
        <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        <computersforpeace@gmail.com>, <dwmw2@infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1537199260-7280-1-git-send-email-christophe.kerello@st.com>
 <1537199260-7280-2-git-send-email-christophe.kerello@st.com>
 <20180922103440.12575714@xps13> <c9925c9c-af40-8044-8dbe-866fbe3a2f99@st.com>
 <20180924191725.2439fd10@bbrezillon>
From:   Christophe Kerello <christophe.kerello@st.com>
Message-ID: <88321fb8-08a4-e8a2-9ac5-2bef910cd53a@st.com>
Date:   Tue, 25 Sep 2018 11:14:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180924191725.2439fd10@bbrezillon>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-25_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 09/24/2018 07:17 PM, Boris Brezillon wrote:
> Hi Christophe,
> 
> On Mon, 24 Sep 2018 18:36:27 +0200
> Christophe Kerello <christophe.kerello@st.com> wrote:
> 
>>>> +- st,fmc2_timings: array of 8 bytes for NAND timings. The meanings of
>>>> +  these bytes are:
>>>> +  byte 0 TCLR      : CLE to RE delay in number of AHB clock cycles, only 4 bits
>>>> +                     are valid. Zero means one clock cycle, 15 means 16 clock
>>>> +                     cycles.
>>>> +  byte 1 TAR       : ALE to RE delay, 4 bits are valid. Same format as TCLR.
>>>> +  byte 2 THIZ      : number of HCLK clock cycles during which the data bus is
>>>> +                     kept in Hi-Z (tristate) after the start of a write access.
>>>> +                     Only valid for write transactions. Zero means 1 cycle,
>>>> +                     255 means 256 cycles.
>>>> +  byte 3 TWAIT     : number of HCLK clock cycles to assert the command to the
>>>> +                     NAND flash in response to SMWAITn. Zero means 1 cycle,
>>>> +                     255 means 256 cycles.
>>>> +  byte 4 THOLD_MEM : common memory space timing
>>>> +                     number of HCLK clock cycles to hold the address (and data
>>>> +                     when writing) after the command deassertion. Zero means
>>>> +                     1 cycle, 255 means 256 cycles.
>>>> +  byte 5 TSET_MEM  : common memory space timing
>>>> +                     number of HCLK clock cycles to assert the address before
>>>> +                     the command is asserted. Zero means 1 cycle, 255 means 256
>>>> +                     cycles.
>>>> +  byte 6 THOLD_ATT : attribute memory space timing
>>>> +                     number of HCLK clock cycles to hold the address (and data
>>>> +                     when writing) after the command deassertion. Zero means
>>>> +                     1 cycle, 255 means 256 cycles.
>>>> +  byte 7 TSET_ATT  : attribute memory space timing
>>>> +                     number of HCLK clock cycles to assert the address before
>>>> +                     the command is asserted. Zero means 1 cycle, 255 means 256
>>>> +                     cycles.
>>>
>>> Let me review the driver but this array of timings is really
>>> suspicious. I am pretty sure you don't need it in the DT.
>>
>> "st,fmc2-timings" is an optional property that allow the end user to
>> overwrite the timings calculated by setup_data_interface callback. By
>> setting this property in the NAND flash memory device tree node, the end
>> user could have a better throughput. For NON ONFI SLC NAND, timing mode
>> 0 is often used.
> 
> Exactly the kind of tweaking I'd like to avoid. If the NAND is not ONFI,
> the vendor driver (nand_<manufacturer>.c) can overwrite
> chip->default_onfi_timing_mode, and if the ONFI timings modes are not
> exactly matching the NAND spec and you need the exact timings, then we
> should consider adding a manufacturer hook to let the manufacturer
> driver tweak the timings. In any case, I'm not willing to accept
> timings description in the DT.
> 

Ok, I understand the way it should work. This property will be removed 
from the device tree bindings and the timings will be only calculated by 
calling setup_data_interface callback in the driver.

Regards,
Christophe Kerello.

> Regards,
> 
> Boris
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
> 
