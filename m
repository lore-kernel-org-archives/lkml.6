Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9741C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B4F720823
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbfBHRMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:12:40 -0500
Received: from gateway31.websitewelcome.com ([192.185.143.51]:19124 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726522AbfBHRMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:12:39 -0500
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 9A87B297FB
        for <linux-kernel@vger.kernel.org>; Fri,  8 Feb 2019 11:12:04 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id s9h6ggqh62PzOs9h6gClCi; Fri, 08 Feb 2019 11:12:04 -0600
X-Authority-Reason: nr=8
Received: from [189.250.49.191] (port=49994 helo=[192.168.1.76])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gs9h3-003Wqt-CG; Fri, 08 Feb 2019 11:12:01 -0600
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Wan ZongShun <mcuos.com@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Kees Cook <keescook@chromium.org>
References: <20190128181520.GA25887@embeddedor>
 <20190205135521.622f82c2@xps13>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Openpgp: preference=signencrypt
Autocrypt: addr=gustavo@embeddedor.com; keydata=
 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
 VtSixD1uOgytAP7RWS474w==
Subject: Re: [PATCH v2] mtd: rawnand: mark expected switch fall-throughs
Message-ID: <ee3bbe49-6de4-9d75-4887-bdb0916490a5@embeddedor.com>
Date:   Fri, 8 Feb 2019 11:11:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190205135521.622f82c2@xps13>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.49.191
X-Source-L: No
X-Exim-ID: 1gs9h3-003Wqt-CG
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.49.191]:49994
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Miquel,

On 2/5/19 6:55 AM, Miquel Raynal wrote:
> Hi Gustavo,
> 
> "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote on Mon, 28 Jan
> 2019 12:15:20 -0600:
> 
>> In preparation to enabling -Wimplicit-fallthrough, mark switch
>> cases where we are expecting to fall through.
>>
>> This patch fixes the following warning:
>>
>> drivers/mtd/nand/onenand/onenand_base.c:3264:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>> drivers/mtd/nand/onenand/onenand_base.c:3288:17: warning: this statement may fall through [-Wimplicit-fallthrough=]
>> drivers/mtd/nand/raw/nand_base.c:5538:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>> drivers/mtd/nand/raw/nand_base.c:5557:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>> drivers/mtd/nand/raw/nand_base.c:5595:13: warning: this statement may fall through [-Wimplicit-fallthrough=]
>> drivers/mtd/nand/raw/nand_legacy.c:332:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>> drivers/mtd/nand/raw/nand_legacy.c:483:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>> drivers/mtd/nand/raw/nandsim.c:2254:22: warning: this statement may fall through [-Wimplicit-fallthrough=]
>> drivers/mtd/nand/raw/omap_elm.c:512:4: warning: this statement may fall through [-Wimplicit-fallthrough=]
>> drivers/mtd/nand/raw/omap_elm.c:517:4: warning: this statement may fall through [-Wimplicit-fallthrough=]
>> drivers/mtd/nand/raw/omap_elm.c:466:37: warning: this statement may fall through [-Wimplicit-fallthrough=]
>> drivers/mtd/nand/raw/omap_elm.c:471:37: warning: this statement may fall through [-Wimplicit-fallthrough=]
>> drivers/mtd/nand/raw/nuc900_nand.c: In function ‘nuc900_nand_command_lp’:
>> ./arch/x86/include/asm/io.h:91:22: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>  #define __raw_writel __writel
>> drivers/mtd/nand/raw/nuc900_nand.c:52:2: note: in expansion of macro ‘__raw_writel’
>>   __raw_writel((val), (dev)->reg + REG_SMCMD)
>>   ^~~~~~~~~~~~
>> drivers/mtd/nand/raw/nuc900_nand.c:196:3: note: in expansion of macro ‘write_cmd_reg’
>>    write_cmd_reg(nand, NAND_CMD_READSTART);
>>    ^~~~~~~~~~~~~
>> drivers/mtd/nand/raw/nuc900_nand.c:197:2: note: here
>>   default:
>>   ^~~~~~~
>>
>> Warning level 3 was used: -Wimplicit-fallthrough=3
>>
>> This patch is part of the ongoing efforts to enabling
>> -Wimplicit-fallthrough.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>> Changes in v2:
>>  - Add extra /* fall through */ comment in nandsim.c file.
>>
>>  drivers/mtd/nand/onenand/onenand_base.c | 2 ++
>>  drivers/mtd/nand/raw/diskonchip.c       | 1 +
>>  drivers/mtd/nand/raw/nand_base.c        | 3 +++
>>  drivers/mtd/nand/raw/nand_legacy.c      | 3 ++-
>>  drivers/mtd/nand/raw/nandsim.c          | 6 ++++--
>>  drivers/mtd/nand/raw/nuc900_nand.c      | 3 ++-
>>  drivers/mtd/nand/raw/omap_elm.c         | 4 ++++
>>  7 files changed, 18 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/onenand/onenand_base.c b/drivers/mtd/nand/onenand/onenand_base.c
>> index 4ca4b194e7d7..e9b71ad24f50 100644
>> --- a/drivers/mtd/nand/onenand/onenand_base.c
>> +++ b/drivers/mtd/nand/onenand/onenand_base.c
> 
> onenand changes should probably be in a separate patch prefixed
> 
>         mtd: onenand:
> 
> When you are unsure, please run
> 
>         git log --oneline --follow drivers/mtd/nand/onenand/
> 

OK. Got it.

>> @@ -3280,12 +3280,14 @@ static void onenand_check_features(struct mtd_info *mtd)
>>  			if ((this->version_id & 0xf) == 0xe)
>>  				this->options |= ONENAND_HAS_NOP_1;
>>  		}
>> +		/* fall through */
>>  
>>  	case ONENAND_DEVICE_DENSITY_2Gb:
>>  		/* 2Gb DDP does not have 2 plane */
>>  		if (!ONENAND_IS_DDP(this))
>>  			this->options |= ONENAND_HAS_2PLANE;
>>  		this->options |= ONENAND_HAS_UNLOCK_ALL;
>> +		/* fall through */
> 
> This looks strange.
> 
> In ONENAND_DEVICE_DENSITY_2Gb:
> ONENAND_HAS_UNLOCK_ALL is set unconditionally.
> 
> But then, under ONENAND_DEVICE_DENSITY_1Gb, the same option is set only
> if process is evaluated to true.
> 
> Same problem with ONENAND_HAS_2PLANE:
> - it is set in ONENAND_DEVICE_DENSITY_4Gb only if ONENAND_IS_DDP()
> - it is unset in ONENAND_DEVICE_DENSITY_2Gb only if !ONENAND_IS_DDP()
> 
> Maybe this portion should be reworked because I am unsure if this is a
> missing fall through or a bug.
> 

OK. Then, I should probably skip this file for now.

>>  
>>  	case ONENAND_DEVICE_DENSITY_1Gb:
>>  		/* A-Die has all block unlock */
>> diff --git a/drivers/mtd/nand/raw/diskonchip.c b/drivers/mtd/nand/raw/diskonchip.c
>> index 53f57e0f007e..ead54c90f2d1 100644
>> --- a/drivers/mtd/nand/raw/diskonchip.c
>> +++ b/drivers/mtd/nand/raw/diskonchip.c
>> @@ -1477,6 +1477,7 @@ static int __init doc_probe(unsigned long physadr)
>>  			break;
>>  		case DOC_ChipID_DocMilPlus32:
>>  			pr_err("DiskOnChip Millennium Plus 32MB is not supported, ignoring.\n");
>> +			/* fall through */
>>  		default:
>>  			ret = -ENODEV;
>>  			goto notfound;
> 
> This is fine.
> 
>> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
>> index 96cadead262e..e05ecf2e4269 100644
>> --- a/drivers/mtd/nand/raw/nand_base.c
>> +++ b/drivers/mtd/nand/raw/nand_base.c
>> @@ -5537,6 +5537,7 @@ static int nand_scan_tail(struct nand_chip *chip)
>>  		}
>>  		if (!ecc->read_page)
>>  			ecc->read_page = nand_read_page_hwecc_oob_first;
>> +		/* fall through */
>>  
>>  	case NAND_ECC_HW:
>>  		/* Use standard hwecc read page function? */
>> @@ -5556,6 +5557,7 @@ static int nand_scan_tail(struct nand_chip *chip)
>>  			ecc->read_subpage = nand_read_subpage;
>>  		if (!ecc->write_subpage && ecc->hwctl && ecc->calculate)
>>  			ecc->write_subpage = nand_write_subpage_hwecc;
>> +		/* fall through */
>>  
>>  	case NAND_ECC_HW_SYNDROME:
>>  		if ((!ecc->calculate || !ecc->correct || !ecc->hwctl) &&
>> @@ -5593,6 +5595,7 @@ static int nand_scan_tail(struct nand_chip *chip)
>>  			ecc->size, mtd->writesize);
>>  		ecc->mode = NAND_ECC_SOFT;
>>  		ecc->algo = NAND_ECC_HAMMING;
>> +		/* fall through */
>>  
>>  	case NAND_ECC_SOFT:
>>  		ret = nand_set_ecc_soft_ops(chip);
> 
> These three already are in nand/next.
> 

Great.

>> diff --git a/drivers/mtd/nand/raw/nand_legacy.c b/drivers/mtd/nand/raw/nand_legacy.c
>> index 43575943f13b..f2526ec616a6 100644
>> --- a/drivers/mtd/nand/raw/nand_legacy.c
>> +++ b/drivers/mtd/nand/raw/nand_legacy.c
>> @@ -331,6 +331,7 @@ static void nand_command(struct nand_chip *chip, unsigned int command,
>>  		 */
>>  		if (column == -1 && page_addr == -1)
>>  			return;
>> +		/* fall through */
>>  
>>  	default:
>>  		/*
>> @@ -483,7 +484,7 @@ static void nand_command_lp(struct nand_chip *chip, unsigned int command,
>>  		chip->legacy.cmd_ctrl(chip, NAND_CMD_NONE,
>>  				      NAND_NCE | NAND_CTRL_CHANGE);
>>  
>> -		/* This applies to read commands */
>> +		/* fall through - This applies to read commands */
>>  	default:
>>  		/*
>>  		 * If we don't have access to the busy pin, we apply the given
> 
> Already fixed in nand/next too.
> 

OK. Great.

>> diff --git a/drivers/mtd/nand/raw/nandsim.c b/drivers/mtd/nand/raw/nandsim.c
>> index 933d1a629c51..edf5fd3d5f07 100644
>> --- a/drivers/mtd/nand/raw/nandsim.c
>> +++ b/drivers/mtd/nand/raw/nandsim.c
>> @@ -2251,9 +2251,11 @@ static int __init ns_init_module(void)
>>  
>>  	switch (bbt) {
>>  	case 2:
>> -		 chip->bbt_options |= NAND_BBT_NO_OOB;
>> +		chip->bbt_options |= NAND_BBT_NO_OOB;
>> +		/* fall through */
>>  	case 1:
>> -		 chip->bbt_options |= NAND_BBT_USE_FLASH;
>> +		chip->bbt_options |= NAND_BBT_USE_FLASH;
>> +		/* fall through */
>>  	case 0:
>>  		break;
>>  	default:
> 
> This is fine.
> 
>> diff --git a/drivers/mtd/nand/raw/nuc900_nand.c b/drivers/mtd/nand/raw/nuc900_nand.c
>> index 38b1994e7ed3..56fa84029482 100644
>> --- a/drivers/mtd/nand/raw/nuc900_nand.c
>> +++ b/drivers/mtd/nand/raw/nuc900_nand.c
>> @@ -192,8 +192,9 @@ static void nuc900_nand_command_lp(struct nand_chip *chip,
>>  		return;
>>  
>>  	case NAND_CMD_READ0:
>> -
>>  		write_cmd_reg(nand, NAND_CMD_READSTART);
>> +		/* fall through */
>> +
>>  	default:
>>  
>>  		if (!chip->legacy.dev_ready) {
> 
> This is fine too.
> 
>> diff --git a/drivers/mtd/nand/raw/omap_elm.c b/drivers/mtd/nand/raw/omap_elm.c
>> index a3f32f939cc1..94c6401ef32f 100644
>> --- a/drivers/mtd/nand/raw/omap_elm.c
>> +++ b/drivers/mtd/nand/raw/omap_elm.c
>> @@ -465,11 +465,13 @@ static int elm_context_save(struct elm_info *info)
>>  					ELM_SYNDROME_FRAGMENT_5 + offset);
>>  			regs->elm_syndrome_fragment_4[i] = elm_read_reg(info,
>>  					ELM_SYNDROME_FRAGMENT_4 + offset);
>> +			/* fall through */
>>  		case BCH8_ECC:
>>  			regs->elm_syndrome_fragment_3[i] = elm_read_reg(info,
>>  					ELM_SYNDROME_FRAGMENT_3 + offset);
>>  			regs->elm_syndrome_fragment_2[i] = elm_read_reg(info,
>>  					ELM_SYNDROME_FRAGMENT_2 + offset);
>> +			/* fall through */
>>  		case BCH4_ECC:
>>  			regs->elm_syndrome_fragment_1[i] = elm_read_reg(info,
>>  					ELM_SYNDROME_FRAGMENT_1 + offset);
>> @@ -511,11 +513,13 @@ static int elm_context_restore(struct elm_info *info)
>>  					regs->elm_syndrome_fragment_5[i]);
>>  			elm_write_reg(info, ELM_SYNDROME_FRAGMENT_4 + offset,
>>  					regs->elm_syndrome_fragment_4[i]);
>> +			/* fall through */
>>  		case BCH8_ECC:
>>  			elm_write_reg(info, ELM_SYNDROME_FRAGMENT_3 + offset,
>>  					regs->elm_syndrome_fragment_3[i]);
>>  			elm_write_reg(info, ELM_SYNDROME_FRAGMENT_2 + offset,
>>  					regs->elm_syndrome_fragment_2[i]);
>> +			/* fall through */
>>  		case BCH4_ECC:
>>  			elm_write_reg(info, ELM_SYNDROME_FRAGMENT_1 + offset,
>>  					regs->elm_syndrome_fragment_1[i]);
> 
> And this is ok as well.
> 

I'll leave out the files that have already been addressed and send v3 shortly.

I appreciate your feedback.

Thanks
--
Gustavo
