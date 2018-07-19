Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE704ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F44520693
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:14:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F44520693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731458AbeGSI4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 04:56:20 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:46803 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbeGSI4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 04:56:20 -0400
Received: from [192.168.90.200] (10.18.20.235) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Thu, 19 Jul
 2018 16:13:39 +0800
Subject: Re: [PATCH 2/2] mtd: rawnand: meson: add support for Amlogic NAND
 flash controller
To:     Boris Brezillon <boris.brezillon@bootlin.com>
References: <20180613161314.14894-1-yixun.lan@amlogic.com>
 <20180613161314.14894-3-yixun.lan@amlogic.com>
 <20180624213844.2207ca6f@bbrezillon>
 <76d428ff-376a-dce3-cb51-d238564b7c3e@amlogic.com>
 <20180718210849.493f0087@bbrezillon>
CC:     <yixun.lan@amlogic.com>, Rob Herring <robh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Liang Yang <liang.yang@amlogic.com>,
        <linux-mtd@lists.infradead.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        <linux-amlogic@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jerome Brunet <jbrunet@baylibre.com>
From:   Yixun Lan <yixun.lan@amlogic.com>
Message-ID: <45c1a96c-0d14-dece-37cf-ac428bb98621@amlogic.com>
Date:   Thu, 19 Jul 2018 16:13:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20180718210849.493f0087@bbrezillon>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.20.235]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Boris:

thanks for the quick response.

On 07/19/18 03:08, Boris Brezillon wrote:
> Hi Yixun,
> 
> On Wed, 18 Jul 2018 17:38:56 +0800
> Yixun Lan <yixun.lan@amlogic.com> wrote:
> 
>>>> +
>>>> +#define NFC_REG_CMD		0x00
>>>> +#define NFC_REG_CFG		0x04
>>>> +#define NFC_REG_DADR		0x08
>>>> +#define NFC_REG_IADR		0x0c
>>>> +#define NFC_REG_BUF		0x10
>>>> +#define NFC_REG_INFO		0x14
>>>> +#define NFC_REG_DC		0x18
>>>> +#define NFC_REG_ADR		0x1c
>>>> +#define NFC_REG_DL		0x20
>>>> +#define NFC_REG_DH		0x24
>>>> +#define NFC_REG_CADR		0x28
>>>> +#define NFC_REG_SADR		0x2c
>>>> +#define NFC_REG_PINS		0x30
>>>> +#define NFC_REG_VER		0x38
>>>> +  
>>>
>>> Can you put the reg offsets next to their field definitions?
>>>   
>> actually, we would prefer to put all the CMD definition below the reg
>> offset, so it will better reflect what's it belong to.
> 
> Just to be clear, I meant something like:
> 
> #define NFC_CMD				0x00
> #define NFC_CMD_DRD			(0x8 << 14)
> #define NFC_CMD_IDLE			(0xc << 14)
> ...
> 
> #define NFC_CFG				0x04
> #define NFC_CFG_XXX			xxx
> ...
> 
> I find it easier to guess which register the fields are attached to when
> it's defined like that, but I won't block the driver for such a tiny
> detail. 
> 
yes, this is exactly what I mean

>>>> +static void meson_nfc_cmd_ctrl(struct mtd_info *mtd,
>>>> +					int cmd, unsigned int ctrl)  
>>>   
>>> ->cmd_ctrl() has recently been deprecated in favor of ->exec_op(). You  
>>> can have a look at the marvell, v610 or fsmc drivers if you want to
>>> have an idea of how ->exec_op() should be implemented. Miquel and I are
>>> also here to help if you have any questions.
>>>   
>>
>> follow your suggestion, we have implemented the exec_op() interface,
>> we'd really appreciate if you can help to review this ..
> 
> Sure, just send a v2 and we'll review it.
> 
> 
>>>> +
>>>> +static void meson_nfc_cmd_m2n(struct meson_nfc *nfc, int raw)  
>>>
>>> n2m -> nand2mem ?
>>>   
>> yes, it is
> 
> Then please use nand2mem, it's clearer.
we end at dropping the n2m function. by converting them into

static void
meson_nfc_cmd_access(
struct meson_nfc *nfc,
struct mtd_info *mtd, int raw, bool dir)


> 
>>>> +static int meson_nfc_wait_dma_finish(struct meson_nfc *nfc)
>>>> +{
>>>> +	meson_nfc_cmd_idle(nfc, 0);
>>>> +	meson_nfc_cmd_idle(nfc, 0);  
>>>
>>> Two calls to cmd_idle(), is this expected or a copy&paste error? If
>>> that's expected it definitely deserves a comment explaining why?
>>>   
>>
>> yes, it is intentional
>>
>> we will put these comments into the function.
>> 	/*
>>          * The Nand flash controller is designed as two stages pipleline -
>>          *  a) fetch and b) excute.
>>          * So, there might be cases when the driver see command queue is
>> empty,
>>          * but the Nand flash controller still has two commands buffered,
>>          * one is fetched into NFC request queue (ready to run), and another
>>          * is actively executing.
>>          */
>>
> 
> So pushing 2 "IDLE" commands guarantees that the pipeline is emptied,
> right? The comment looks incomplete, you should explain what those
> meson_nfc_cmd_idle() are for.
> 
thanks

the meson_nfc_cmd_idle() function itself is quite straightforward, and
we feel explain that inserting 2 "IDLE" commands to drain out the
pipeline is enough.

>>>> +static int meson_nfc_ecc_init(struct device *dev, struct mtd_info *mtd)
>>>> +{
>>>> +	struct nand_chip *nand = mtd_to_nand(mtd);
>>>> +	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
>>>> +	struct meson_nfc *nfc = nand_get_controller_data(nand);
>>>> +	struct meson_nand_ecc *meson_ecc = nfc->data->ecc;
>>>> +	int num = nfc->data->ecc_num;
>>>> +	int nsectors, i, bytes;
>>>> +
>>>> +	/* support only ecc hw mode */
>>>> +	if (nand->ecc.mode != NAND_ECC_HW) {  
>>>
>>> Given that you support raw accesses, I'm pretty sure you can support
>>> ECC_NONE, ECC_SOFT and ECC_ON_DIE with zero effort.
>>>   
>>
>> is this a block for this driver to be accepted by upstream?
> 
> Nope.
> 
>> otherwise we'd like to implement this feature later in separate patch.
>>
> 
> That's fine.
> 
>>>> +	nsectors = mtd->writesize / nand->ecc.size;
>>>> +	bytes =(meson_chip->user_mode == NFC_USER2_OOB_BYTES) ? nsectors * 2 : 16;
>>>> +	if (mtd->oobsize < (nand->ecc.bytes * nsectors + bytes))
>>>> +		return -EINVAL;  
>>>
>>> It's probably worth looking at what is being proposed here [2] for the
>>> ECC config selection logic.
>>>   
>>
>> sure, we'd happy to adopt the ECC config helper function, and seems it
>> is possible ;-)
>>
>> sounds the proposed ECC config patch is still under review, and we
>> would like to adjust our code once it's ready (probably we will still
>> keep this version in patch v2, then address it in v3 later)
> 
> It's been merged, and should be available in the nand/next branch [1].
> 
em... I'd leave this to Liang Yang to implement this, so it's not fixed
in next PATCH v2, but will address this in v3.

thanks

>>>> +static int meson_nfc_buffer_init(struct mtd_info *mtd)
>>>> +{
>>>> +	struct nand_chip *nand = mtd_to_nand(mtd);
>>>> +	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
>>>> +	struct meson_nfc *nfc = nand_get_controller_data(nand);
>>>> +	struct device *dev = nfc->dev;
>>>> +	int info_bytes, page_bytes;
>>>> +	int nsectors;
>>>> +
>>>> +	nsectors = mtd->writesize / nand->ecc.size;
>>>> +	info_bytes = nsectors * PER_INFO_BYTE;
>>>> +	page_bytes = mtd->writesize + mtd->oobsize;
>>>> +
>>>> +	if ((meson_chip->data_buf) && (meson_chip->info_buf))
>>>> +		return 0;
>>>> +
>>>> +	meson_chip->data_buf = devm_kzalloc(dev, page_bytes, GFP_KERNEL);
>>>> +	if (!meson_chip->data_buf)
>>>> +		return  -ENOMEM;
>>>> +
>>>> +	meson_chip->info_buf = devm_kzalloc(dev, info_bytes, GFP_KERNEL);
>>>> +	if (!meson_chip->info_buf)
>>>> +		return  -ENOMEM;  
>>>
>>> You're doing DMA on those buffers, and devm_kzalloc() is not
>>> DMA-friendly (returned buffers are not aligned on a cache line). Also,
>>> you don't have to allocate your own buffers because the core already
>>> allocate them (chip->data_buf, chip->oob_poi). All you need to do is
>>> set the NAND_USE_BOUNCE_BUFFER flag in chip->options to make sure
>>> you're always passed a DMA-able buffer.
>>>   
>>
>> thanks for the suggestion, we've migrated to use the
>> dmam_alloc_coherent() API
> 
> kzalloc() should be just fine, no need to alloc a DMA coherent region. 
> 

we're a little bit confused here, isn't devm_kzalloc (previously we are
using) a variant of kzalloc? and since the NAND controller is doing DMA
here, using DMA coherent API is more proper way?

> 
>>
>>>> +	nand->setup_data_interface = meson_nfc_setup_data_interface;
>>>> +
>>>> +	nand->chip_delay = 200;  
>>>
>>> This should not be needed if you implement ->exec_op() and  
>>> ->setup_data_interface().  
>>>   
>> will drop this
>>
>>>> +	nand->ecc.mode = NAND_ECC_HW;
>>>> +
>>>> +	nand->ecc.write_page_raw = meson_nfc_write_page_raw;
>>>> +	nand->ecc.write_page = meson_nfc_write_page_hwecc;
>>>> +	nand->ecc.write_oob_raw = nand_write_oob_std;
>>>> +	nand->ecc.write_oob = nand_write_oob_std;
>>>> +
>>>> +	nand->ecc.read_page_raw = meson_nfc_read_page_raw;
>>>> +	nand->ecc.read_page = meson_nfc_read_page_hwecc;
>>>> +	nand->ecc.read_oob_raw = meson_nfc_read_oob_raw;
>>>> +	nand->ecc.read_oob = meson_nfc_read_oob;
>>>> +
>>>> +	mtd = nand_to_mtd(nand);
>>>> +	mtd->owner = THIS_MODULE;
>>>> +	mtd->dev.parent = dev;
>>>> +	mtd->name = devm_kasprintf(nfc->dev, GFP_KERNEL,
>>>> +				   "%s:nand", dev_name(dev));
>>>> +	if (!mtd->name) {
>>>> +		dev_err(nfc->dev, "Failed to allocate mtd->name\n");
>>>> +		return -ENOMEM;
>>>> +	}  
>>>
>>> You set the name after nand_scan_ident() and make it conditional (only
>>> if ->name == NULL) so that the label property defined in the DT takes
>>> precedence over the default name.  
>>
for setting mtd->name conditional, do you mean doing something like this?

if (!mtd->name)
	mtd->name = devm_kasprintf(..)

but we found mtd->name = "ffe07800.nfc" after function
nand_scan_ident(), which is same value as dev_name(dev)..
and there is no cs information encoded there.


>> we can do this, but as second consideration, we'd prefer simply to drop
>> this customization of mtd->name here (we didn't understand your next cs
>> id suggestion).
> 
> No, you really should set a well-known name, so that people can pass
> mtdparts on the kernel command line.
> 
ok

>>
>>> Also, I recommend suffixing this name
>>> with the CS id, just in case you ever need to support connecting several
>>> chips to the same controller. 
>>>   
>>
>> we actually didn't get the point here, cs is about chip selection with
>> multiple nand chip? and how to get this information?
> 
> Well, you currently seem to only support one chip per controller, but I
> guess the IP can handle several CS lines. So my recommendation is about
> choosing a name so that you can later easily add support for multiple
> chips without breaking setups where mtdparts is used.
> 
> To sum-up, assuming your NAND chip is always connected to CS0 (on the
> controller side), I'd suggest doing:
> 
yes, this is exactly how the hardware connected.
> 	mtd->name = devm_kasprintf(nfc->dev, GFP_KERNEL,
> 				   "%s:nand.%d", dev_name(dev), cs_id);
> 
> where cs_id is the value you extracted from the reg property of the
> NAND node.
> 
Ok, you right.
current, the NAND chip is only use one CS (which CE0) for now, what's in
the DT is

nand@0 {
 reg = < 0 >;
 ..
};

so for the multiple chips it would something like this in DT?

nand@0 {
  reg = < 0 >;
};

nand@1 {
  reg = < 1 >;
};

or even
nand@0 {
  reg = < 0 2 >;
};

nand@1 {
  reg = < 3 4 >;
};

do we need to encode all the cs information here? not sure if we
understand this correctly, but could send out the patch for review..


> Regards,
> 
> Boris
> 
> [1]http://git.infradead.org/linux-mtd.git/shortlog/refs/heads/nand/next
> 
> .
> 

