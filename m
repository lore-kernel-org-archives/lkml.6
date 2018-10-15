Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D24C28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BE7A2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BE7A2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbeJOP4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 11:56:38 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:13844 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726590AbeJOP4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 11:56:38 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w9F88wkb029886;
        Mon, 15 Oct 2018 10:09:51 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2n35u5a998-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 15 Oct 2018 10:09:51 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0B7783F;
        Mon, 15 Oct 2018 08:09:50 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C16282587;
        Mon, 15 Oct 2018 08:09:50 +0000 (GMT)
Received: from [10.201.23.29] (10.75.127.49) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 15 Oct
 2018 10:09:49 +0200
Subject: Re: [PATCH v2 2/3] mtd: rawnand: stm32_fmc2: add STM32 FMC2 NAND
 flash controller driver
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1538732520-2800-1-git-send-email-christophe.kerello@st.com>
 <1538732520-2800-3-git-send-email-christophe.kerello@st.com>
 <20181005115809.55356782@bbrezillon>
From:   Christophe Kerello <christophe.kerello@st.com>
Message-ID: <b10a3919-7b86-c177-2254-30d32ac6f25e@st.com>
Date:   Mon, 15 Oct 2018 10:09:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181005115809.55356782@bbrezillon>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG8NODE1.st.com (10.75.127.22) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-15_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/05/2018 11:58 AM, Boris Brezillon wrote:
> On Fri, 5 Oct 2018 11:41:59 +0200
> <christophe.kerello@st.com> wrote:
> 
>> +struct stm32_fmc2 {
> 
> You should inherit from nand_controller even if the nand_chip already
> embeds a dummy nand controller object.
> 
> 	struct nand_controller base;
> 

Hi Boris,

Ok, i will add and handle the nand controller structure.

Regards,
Christophe Kerello.

>> +	struct stm32_fmc2_nand nand;
>> +	struct device *dev;
>> +	void __iomem *io_base;
>> +	void __iomem *data_base[FMC2_MAX_CE];
>> +	void __iomem *cmd_base[FMC2_MAX_CE];
>> +	void __iomem *addr_base[FMC2_MAX_CE];
>> +	phys_addr_t io_phys_addr;
>> +	phys_addr_t data_phys_addr[FMC2_MAX_CE];
>> +	struct clk *clk;
>> +
>> +	struct dma_chan *dma_tx_ch;
>> +	struct dma_chan *dma_rx_ch;
>> +	struct dma_chan *dma_ecc_ch;
>> +	struct sg_table dma_data_sg;
>> +	struct sg_table dma_ecc_sg;
>> +	u8 *ecc_buf;
>> +	int dma_ecc_len;
>> +
>> +	struct completion complete;
>> +	struct completion dma_data_complete;
>> +	struct completion dma_ecc_complete;
>> +
>> +	u8 cs_assigned;
>> +	int cs_sel;
>> +};
