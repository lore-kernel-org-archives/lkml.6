Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E11C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 11:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ECB9223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 11:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ECB9223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388213AbeKOVcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 16:32:31 -0500
Received: from mail-sz2.amlogic.com ([211.162.65.114]:37250 "EHLO
        mail-sz2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388030AbeKOVca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 16:32:30 -0500
Received: from [10.28.18.44] (10.28.18.44) by mail-sz2.amlogic.com
 (10.28.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Thu, 15 Nov
 2018 19:25:08 +0800
Subject: Re: [PATCH v6 2/2] mtd: rawnand: meson: add support for Amlogic NAND
 flash controller
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Rob Herring <robh@kernel.org>, Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Richard Weinberger <richard@nod.at>,
        Yixun Lan <yixun.lan@amlogic.com>,
        <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Jian Hu <jian.hu@amlogic.com>, <linux-mtd@lists.infradead.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        <linux-amlogic@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Wolfram Sang <wsa@the-dreams.de>
References: <1541090542-19618-1-git-send-email-jianxin.pan@amlogic.com>
 <1541090542-19618-3-git-send-email-jianxin.pan@amlogic.com>
 <20181105165321.7ea2b45f@bbrezillon>
 <a571904e-6296-bf62-e1fe-e25bf90040bb@amlogic.com>
 <20181106102851.61deb97a@bbrezillon>
 <ff02373e-c97b-182d-5b43-83d1e8f6d51a@amlogic.com>
 <20181106112206.65a70a81@bbrezillon> <20181112171351.4ac3506b@xps13>
 <20181112175416.247e3203@bbrezillon> <20181112184518.6c02ac6d@bbrezillon>
From:   Liang Yang <liang.yang@amlogic.com>
Message-ID: <27769252-ac5e-e787-6792-d6a06e7af0e4@amlogic.com>
Date:   Thu, 15 Nov 2018 19:25:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181112184518.6c02ac6d@bbrezillon>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.18.44]
X-ClientProxiedBy: mail-sz2.amlogic.com (10.28.11.6) To mail-sz2.amlogic.com
 (10.28.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

I have implemented dma access base on these helpers you provided below.
we prepare to send v7 version now, so when will these helpers be pushed?

On 2018/11/13 1:45, Boris Brezillon wrote:
> On Mon, 12 Nov 2018 17:54:16 +0100
> Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> 
>> +Wolfram to give some inputs on the DMA issue.
>>
>> On Mon, 12 Nov 2018 17:13:51 +0100
>> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>>
>>> Hello,
>>>
>>> Boris Brezillon <boris.brezillon@bootlin.com> wrote on Tue, 6 Nov 2018
>>> 11:22:06 +0100:
>>>    
>>>> On Tue, 6 Nov 2018 18:00:37 +0800
>>>> Liang Yang <liang.yang@amlogic.com> wrote:
>>>>      
>>>>> On 2018/11/6 17:28, Boris Brezillon wrote:
>>>>>> On Tue, 6 Nov 2018 17:08:00 +0800
>>>>>> Liang Yang <liang.yang@amlogic.com> wrote:
>>>>>>          
>>>>>>> On 2018/11/5 23:53, Boris Brezillon wrote:
>>>>>>>> On Fri, 2 Nov 2018 00:42:21 +0800
>>>>>>>> Jianxin Pan <jianxin.pan@amlogic.com> wrote:
>>>>>>>>             
>>>>>>>>> +
>>>>>>>>> +static inline u8 meson_nfc_read_byte(struct mtd_info *mtd)
>>>>>>>>> +{
>>>>>>>>> +	struct nand_chip *nand = mtd_to_nand(mtd);
>>>>>>>>> +	struct meson_nfc *nfc = nand_get_controller_data(nand);
>>>>>>>>> +	u32 cmd;
>>>>>>>>> +
>>>>>>>>> +	cmd = nfc->param.chip_select | NFC_CMD_DRD | 0;
>>>>>>>>> +	writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>>>>>>> +
>>>>>>>>> +	meson_nfc_drain_cmd(nfc);
>>>>>>>>
>>>>>>>> You probably don't want to drain the FIFO every time you read a byte on
>>>>>>>> the bus, and I guess the INPUT FIFO is at least as big as the CMD
>>>>>>>> FIFO, right? If that's the case, you should queue as much DRD cmd as
>>>>>>>> possible and only sync when the user explicitly requests it or when
>>>>>>>> the INPUT/READ FIFO is full.
>>>>>>>>             
>>>>>>> Register 'NFC_REG_BUF' can holds only 4 bytes, also DRD sends only one
>>>>>>> nand cycle to read one byte and covers the 1st byte every time reading.
>>>>>>> i think nfc controller is faster than nand cycle, but really it is not
>>>>>>> high efficiency when reading so many bytes once.
>>>>>>> Or use dma command here like read_page and read_page_raw.
>>>>>>
>>>>>> Yep, that's also an alternative, though you'll have to make sure the
>>>>>> buffer passed through the nand_op_inst is DMA-safe, and use a bounce
>>>>>> buffer when that's not the case.
>>>>>>          
>>>>> ok, i will try dma here.
>>>>
>>>> We should probably expose the bounce buf handling as generic helpers at
>>>> the rawnand level:
>>>>
>>>> void *nand_op_get_dma_safe_input_buf(struct nand_op_instr *instr)
>>>> {
>>>> 	void *buf;
>>>>
>>>> 	if (WARN_ON(instr->type != NAND_OP_DATA_IN_INSTR))
>>>> 		return NULL;
>>>>
>>>> 	if (virt_addr_valid(instr->data.in) &&
>>>> 	    !object_is_on_stack(instr->data.buf.in))
>>>> 		return instr->data.buf.in;
>>>>
>>>> 	return kzalloc(instr->data.len, GFP_KERNEL);
>>>> }
>>>>
>>>> void nand_op_put_dma_safe_input_buf(struct nand_op_instr *instr,
>>>> 				    void *buf)
>>>> {
>>>> 	if (WARN_ON(instr->type != NAND_OP_DATA_IN_INSTR) ||
>>>> 	    WARN_ON(!buf))
>>>> 		return;
>>>>
>>>> 	if (buf == instr->data.buf.in)
>>>> 		return;
>>>>
>>>> 	memcpy(instr->data.buf.in, buf, instr->data.len);
>>>> 	kfree(buf);
>>>> }
>>>>
>>>> const void *nand_op_get_dma_safe_output_buf(struct nand_op_instr *instr)
>>>> {
>>>> 	void *buf;
>>>>
>>>> 	if (WARN_ON(instr->type != NAND_OP_DATA_OUT_INSTR))
>>>> 		return NULL;
>>>>
>>>> 	if (virt_addr_valid(instr->data.out) &&
>>>> 	    !object_is_on_stack(instr->data.buf.out))
>>>> 		return instr->data.buf.out;
>>>>
>>>> 	return kmemdup(instr->data.buf.out, GFP_KERNEL);
>>>> }
>>>>
>>>> void nand_op_put_dma_safe_output_buf(struct nand_op_instr *instr,
>>>> 				    void *buf)
>>>> {
>>>> 	if (WARN_ON(instr->type != NAND_OP_DATA_OUT_INSTR) ||
>>>> 	    WARN_ON(!buf))
>>>> 		return;
>>>>
>>>> 	if (buf != instr->data.buf.out)
>>>> 		kfree(buf);
>>>> }
>>>
>>> Not that I am against such function, but maybe they should come with
>>> comments stating that there is no reliable way to find if a buffer is
>>> DMA-able at runtime and these are just sanity checks (ie. required, but
>>> probably not enough).
>>
>> It's not 100% reliable, but it should cover most cases. Note that the
>> NAND framework already uses virt_addr_valid() to decide when to use its
>> internal bounce buffer, so this should be fixed too if we want a fully
>> reliable solution.
>>
>>> This is my understanding of Wolfram's recent talk
>>> at ELCE [1].
>>
>> Yes, you're right, but the NAND framework does not provide any guarantee
>> on the buf passed to ->exec_op() simply because the MTD layer does not
>> provide such a guarantee. Reworking that to match how the i2c framework
>> handles it is possible (with a flag set when the buffer is known to be
>> DMA-safe), but it requires rewriting all MTD users if we want to keep
>> decent perfs (the amount of data transfered to a flash is an order of
>> magnitude bigger than what you usually receive/send from/to an I2C
>> device). Also, I'm not even sure the DMA_SAFE flag covers all weird
>> cases like the "DMA engine embedded in the controller is not able to
>> access the whole physical memory range" one.
> 
> I forgot that this problem was handled at dma_map time (a bounce
> buffer is allocated if needed, and this decision is based on
> dev->dma_mask).
> 
>> So ideally we should have
>> something that checks if a pointer is DMA-safe at the device level and
>> then at the arch level.
>>
>> A temporary solution would be to add a hook at the nand_controller
>> level:
>>
>> 	bool (*buf_is_dma_safe)(struct nand_chip *chip, void *buf,
>> 				size_t len);
>>
>> And then fallback to the default implementation when it's not
>> implemented:
>>
>> static bool nand_buf_is_dma_safe(struct nand_chip *chip, void *buf,
>> 				 size_t len)
>> {
>> 	if (chip->controller->ops && chip->controller->ops->is_dma_safe)
>> 		return chip->controller->ops->is_dma_safe(chip, buf,
>> 							  len);
>>
>> 	return virt_addr_valid(buf) && !object_is_on_stack(buf);
>> }
>>
>>> I suppose using the CONFIG_DMA_API_DEBUG option could help
>>> more reliably to find such issues.
>>
>> Actually, the problem is not only about detecting offenders but being
>> able to detect when a buffer is not DMA-safe at runtime in order to
>> allocate/use a bounce buffer.
> 
> .
> 
