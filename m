Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB0AC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25F232081C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:53:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25F232081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbeLGQxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 11:53:54 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:48122 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726018AbeLGQxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 11:53:53 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wB7GpNjL028385;
        Fri, 7 Dec 2018 17:53:03 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2p3wt73rht-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 07 Dec 2018 17:53:03 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2325D34;
        Fri,  7 Dec 2018 16:53:02 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D51555481;
        Fri,  7 Dec 2018 16:53:01 +0000 (GMT)
Received: from [10.201.23.29] (10.75.127.47) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 7 Dec
 2018 17:53:02 +0100
Subject: Re: [ v3 2/3] mtd: rawnand: stm32_fmc2: add STM32 FMC2 NAND flash
 controller driver
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Boris Brezillon <boris.brezillon@bootlin.com>,
        =?UTF-8?Q?Miqu=c3=a8l_Raynal?= <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Mark Vasut <marek.vasut@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1543509663-26128-1-git-send-email-christophe.kerello@st.com>
 <1543509663-26128-3-git-send-email-christophe.kerello@st.com>
 <CACRpkdb83-kEwrip+t8g2VVFiREXspfWKQa2=Zd1ah1sSLNHjQ@mail.gmail.com>
From:   Christophe Kerello <christophe.kerello@st.com>
Message-ID: <7c295246-8756-9363-a891-856ddf7af92b@st.com>
Date:   Fri, 7 Dec 2018 17:53:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CACRpkdb83-kEwrip+t8g2VVFiREXspfWKQa2=Zd1ah1sSLNHjQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-07_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/18 10:06 AM, Linus Walleij wrote:
> Hi Christophe,
> 
> On Thu, Nov 29, 2018 at 5:42 PM Christophe Kerello
> <christophe.kerello@st.com> wrote:
> 
>> +/* FMC2 Controller Registers */
>> +#define FMC2_BCR1                      0x0
>> +#define FMC2_PCR                       0x80
> (...)
>> +/* Register: FMC2_BCR1 */
>> +#define FMC2_BCR1_FMC2EN               BIT(31)
> 
> Well this looks like an especially clever register map and a specific choice
> of bit 31 in the fist register to activate FMC2. Registers 0x04 thru
> 0x7c are completely unused save for one bit.
> 
> It's almost like this is the good old FSMC integrated in parallel with FMC2,
> so that if you don't set bit 31, this becomes something that can be used
> with drivers/mtd/nand/raw/fsmc_nand.c, and FMC2 mode is activated
> by setting this bit, activating all the new registers.
> 
> It wouldn't surprise me given how HW designers like to work.
> 
> Is this the case?
> 

Hi Linus,

Based on FMC2 datasheet,
The FMC2 controller includes 2 memory controllers:
  - the NOR/PSRAM memory controller
  - the NAND memory controller

The NOR/PSRAM controller mapping is starting at 0.
The NAND controller mapping is starting at 0x80.

We have only planned to develop a driver for the NAND memory controller.
There is currently no customer request to develop the NOR/PSRAM memory 
controller.

The bit FMC2_BCR1_FMC2EN is not used to switch from an IP version to 
another. After reset, the FMC2 controller is disabled. Once all the used 
memory controllers are configured, the FMC2 controller must be enabled 
by setting the FMC2EN bit in the FMC2_BCR1 register. If this bit is not 
set, the controller stays in disabled state.

Regards,
Christophe Kerello.

> If that is the case I think it should at least be mentioned in commit
> logs and DT bindings and possibly in a comment on the driver
> itself.
> 
> Yours,
> Linus Walleij
> 
