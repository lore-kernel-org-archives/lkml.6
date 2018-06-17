Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C71C5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 16:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 888D4208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 16:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="Ox9oM4vQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 888D4208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934264AbeFQQ5l (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 12:57:41 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:48038 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934030AbeFQQ5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 12:57:36 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 36A935C00F6;
        Sun, 17 Jun 2018 18:57:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1529254655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K+y0BAmFNf2PRRJPEuTfx7Kuny/ElzN9u9Jp6F4bV6w=;
        b=Ox9oM4vQCoLzAWm7xwuK8YHGX9kfKE6zk/O+K4lFUEOTfMUAUPvsHyRDw6a+g5EWjPyZRh
        xxAvqPCn8/d2Rz8T1GXDhWoAy05lw59m7E0r5w8PjX3H8rSS+dhHpMFuoU9mXEXtgxt3IB
        oh3vBGFnOmQOkWOH6Z9SAZeegJHjjkw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Sun, 17 Jun 2018 18:57:33 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        dev@lynxeye.de, miquel.raynal@bootlin.com, richard@nod.at,
        marcel@ziswiler.com, krzk@kernel.org, benjamin.lindqvist@endian.se,
        jonathanh@nvidia.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        mirza.krak@gmail.com, gaireg@gaireg.de,
        linux-mtd@lists.infradead.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] mtd: rawnand: add NVIDIA Tegra NAND Flash
 controller driver
In-Reply-To: <20180612101319.528da20c@bbrezillon>
References: <20180611205224.23340-1-stefan@agner.ch>
 <20180611205224.23340-5-stefan@agner.ch> <2945591.o6hPPARSMh@dimapc>
 <fd15fcac50d25281fa8f7d97a738bf6a@agner.ch>
 <20180612101319.528da20c@bbrezillon>
Message-ID: <0be3de74809d0ebe32a808eebfd61dcd@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-0.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[23];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.00)[25.59%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.06.2018 10:13, Boris Brezillon wrote:
> On Tue, 12 Jun 2018 10:02:12 +0200
> Stefan Agner <stefan@agner.ch> wrote:
> 
>> >> +static int tegra_nand_read_page_hwecc(struct mtd_info *mtd,
>> >> +				      struct nand_chip *chip,
>> >> +				      uint8_t *buf, int oob_required, int page)
>> >> +{
>> >> +	struct tegra_nand_controller *ctrl = to_tegra_ctrl(chip->controller);
>> >> +	struct tegra_nand_chip *nand = to_tegra_chip(chip);
>> >> +	void *oob_buf = oob_required ? chip->oob_poi : 0;
>> >> +	u32 dec_stat, max_corr_cnt;
>> >> +	unsigned long fail_sec_flag;
>> >> +	int ret;
>> >> +
>> >> +	tegra_nand_hw_ecc(ctrl, chip, true);
>> >> +	ret = tegra_nand_page_xfer(mtd, chip, buf, oob_buf, nand->tag.length,
>> >> +				   page, true);
>> >> +	tegra_nand_hw_ecc(ctrl, chip, false);
>> >> +	if (ret)
>> >> +		return ret;
>> >> +
>> >> +	/* No correctable or un-correctable errors, page must have 0 bitflips */
>> >> +	if (!ctrl->last_read_error)
>> >> +		return 0;
>> >> +
>> >> +	/*
>> >> +	 * Correctable or un-correctable errors occurred. Use DEC_STAT_BUF
>> >> +	 * which contains information for all ECC selections.
>> >> +	 *
>> >> +	 * Note that since we do not use Command Queues DEC_RESULT does not
>> >> +	 * state the number of pages we can read from the DEC_STAT_BUF. But
>> >> +	 * since CORRFAIL_ERR did occur during page read we do have a valid
>> >> +	 * result in DEC_STAT_BUF.
>> >> +	 */
>> >> +	ctrl->last_read_error = false;
>> >> +	dec_stat = readl_relaxed(ctrl->regs + DEC_STAT_BUF);
>> >> +
>> >> +	fail_sec_flag = (dec_stat & DEC_STAT_BUF_FAIL_SEC_FLAG_MASK) >>
>> >> +			DEC_STAT_BUF_FAIL_SEC_FLAG_SHIFT;
>> >> +
>> >> +	max_corr_cnt = (dec_stat & DEC_STAT_BUF_MAX_CORR_CNT_MASK) >>
>> >> +		       DEC_STAT_BUF_MAX_CORR_CNT_SHIFT;
>> >> +
>> >> +	if (fail_sec_flag) {
>> >> +		int bit, max_bitflips = 0;
>> >> +
>> >> +		/*
>> >> +		 * Check if all sectors in a page failed. If only some failed
>> >> +		 * its definitly not an erased page and we can return error
>> >> +		 * stats right away.
>> >> +		 *
>> >> +		 * E.g. controller might return fail_sec_flag with 0x4, which
>> >> +		 * would mean only the third sector failed to correct.
> 
> That works because you have NAND_NO_SUBPAGE_WRITE set (i.e. no partial
> page programming), probably something you should state here.
> 

Ok, will add a note.

>> >> +		 */
>> >> +		if (fail_sec_flag ^ GENMASK(chip->ecc.steps - 1, 0)) {
>> >> +			mtd->ecc_stats.failed += hweight8(fail_sec_flag);
>> >> +			return max_corr_cnt;
>> >> +		}
>> >> +
>> >> +		/*
>> >> +		 * All sectors failed to correct, but the ECC isn't smart
>> >> +		 * enough to figure out if a page is really completely erased.
>> >> +		 * We check the read data here to figure out if it's a
>> >> +		 * legitimate ECC error or only an erased page.
>> >> +		 */
>> >> +		for_each_set_bit(bit, &fail_sec_flag, chip->ecc.steps) {
>> >> +			u8 *data = buf + (chip->ecc.size * bit);
>> >> +
>> >> +			ret = nand_check_erased_ecc_chunk(data, chip->ecc.size,
>> >> +							  NULL, 0,
> 
> You should also check that the ECC bytes are 0xff here, otherwise you
> won't detect corruption of pages almost filled 0xff but with a few bits
> set to 0.
> 
> When you use nand_check_erased_ecc_chunk(), it's important to always
> pass the data along with its associated ECC bytes.
> 

Hm, I see this is important in case bitflips accumulate in OOB area
only.

>> >> +							  NULL, 0,
> 
> If you support writing extra OOB bytes, you should also pass them here.
> 

I see. OOB bytes handled together with the last subpage.

>> >> +							  chip->ecc.strength);
>> >> +			if (ret < 0)
>> >> +				mtd->ecc_stats.failed++;
>> >> +			else
>> >> +				max_bitflips = max(ret, max_bitflips);

I guess I should also increment ecc_stats.corrected here.

Is it correct that I increment for every step?

So if I have an ECC strength of 16, an empty page could have 8 bitflips
in the first step, and 12 in the second, I would increment
mtd->ecc_stats.corrected by 20 but return 12 (maximum number of bitflips
per step)?

--
Stefan

>> >> +		}
>> >> +
>> >> +		return max_t(unsigned int, max_corr_cnt, max_bitflips);
>> >> +	} else {
>> >> +		int corr_sec_flag;
>> >> +
>> >> +		corr_sec_flag = (dec_stat & DEC_STAT_BUF_CORR_SEC_FLAG_MASK) >>
>> >> +				DEC_STAT_BUF_CORR_SEC_FLAG_SHIFT;
>> >> +
>> >> +		/*
>> >> +		 * The value returned in the register is the maximum of
>> >> +		 * bitflips encountered in any of the ECC regions. As there is
>> >> +		 * no way to get the number of bitflips in a specific regions
>> >> +		 * we are not able to deliver correct stats but instead
>> >> +		 * overestimate the number of corrected bitflips by assuming
>> >> +		 * that all regions where errors have been corrected
>> >> +		 * encountered the maximum number of bitflips.
>> >> +		 */
>> >> +		mtd->ecc_stats.corrected += max_corr_cnt * hweight8(corr_sec_flag);
>> >> +
>> >> +		return max_corr_cnt;
>> >> +	}
>> >> +
