Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A72DEC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB68208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="MjR1hJlx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB68208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933674AbeFLIGq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 04:06:46 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:46394 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932448AbeFLIGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 04:06:44 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 86C895C0F0B;
        Tue, 12 Jun 2018 10:06:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1528790802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y0XaSBEkmuUo0AatyJN+C1ULhxDq2NyHShkZgeppDI4=;
        b=MjR1hJlxwJpDCjo4tnV8zrS7z49fKzUZ14Pp3X/y7xrpoGWvYfcQ5seXU2BRo5ur/x+rMM
        N2QRhu4Qk+d2lpNSJbO47iReTInGTD/I8VCCglJ6s6LtkEAp2UiZfXK2blpO2lbExlwnRL
        tUcPTNvZ0wXQ6OIsWeRcrzGmqTUroj0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Tue, 12 Jun 2018 10:06:42 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Dmitry Osipenko <digetx@gmail.com>, boris.brezillon@bootlin.com
Cc:     dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        thierry.reding@gmail.com, dev@lynxeye.de,
        miquel.raynal@bootlin.com, richard@nod.at, marcel@ziswiler.com,
        krzk@kernel.org, benjamin.lindqvist@endian.se,
        jonathanh@nvidia.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        mirza.krak@gmail.com, gaireg@gaireg.de,
        linux-mtd@lists.infradead.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] mtd: rawnand: add NVIDIA Tegra NAND Flash
 controller driver
In-Reply-To: <4258393.O1xtUOGbca@dimapc>
References: <20180611205224.23340-1-stefan@agner.ch>
 <20180611205224.23340-5-stefan@agner.ch> <4258393.O1xtUOGbca@dimapc>
Message-ID: <cb6f2ef0a5a41e001a2019caa1a18c23@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-3.10 / 15.00];
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
         ASN(0.00)[asn:29691, ipnet:2a02:418::/29, country:CH];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.06.2018 02:03, Dmitry Osipenko wrote:
> On Monday, 11 June 2018 23:52:22 MSK Stefan Agner wrote:
>> Add support for the NAND flash controller found on NVIDIA
>> Tegra 2 SoCs. This implementation does not make use of the
>> command queue feature. Regular operations/data transfers are
>> done in PIO mode. Page read/writes with hardware ECC make
>> use of the DMA for data transfer.
>>
>> Signed-off-by: Lucas Stach <dev@lynxeye.de>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>>  MAINTAINERS                       |    7 +
>>  drivers/mtd/nand/raw/Kconfig      |    6 +
>>  drivers/mtd/nand/raw/Makefile     |    1 +
>>  drivers/mtd/nand/raw/tegra_nand.c | 1248 +++++++++++++++++++++++++++++
>>  4 files changed, 1262 insertions(+)
>>  create mode 100644 drivers/mtd/nand/raw/tegra_nand.c
>>
[snip]
>> +static int tegra_nand_cmd(struct nand_chip *chip,
>> +			 const struct nand_subop *subop)
>> +{
>> +	const struct nand_op_instr *instr;
>> +	const struct nand_op_instr *instr_data_in = NULL;
>> +	struct tegra_nand_controller *ctrl = to_tegra_ctrl(chip->controller);
>> +	unsigned int op_id, size = 0, offset = 0;
>> +	bool first_cmd = true;
>> +	u32 reg, cmd = 0;
>> +	int ret;
>> +
>> +	for (op_id = 0; op_id < subop->ninstrs; op_id++) {
>> +		unsigned int naddrs, i;
>> +		const u8 *addrs;
>> +		u32 addr1 = 0, addr2 = 0;
>> +
>> +		instr = &subop->instrs[op_id];
>> +
>> +		switch (instr->type) {
>> +		case NAND_OP_CMD_INSTR:
>> +			if (first_cmd) {
>> +				cmd |= COMMAND_CLE;
>> +				writel_relaxed(instr->ctx.cmd.opcode,
>> +					       ctrl->regs + CMD_REG1);
>> +			} else {
>> +				cmd |= COMMAND_SEC_CMD;
>> +				writel_relaxed(instr->ctx.cmd.opcode,
>> +					       ctrl->regs + CMD_REG2);
>> +			}
>> +			first_cmd = false;
>> +			break;
>> +		case NAND_OP_ADDR_INSTR:
>> +			offset = nand_subop_get_addr_start_off(subop, op_id);
>> +			naddrs = nand_subop_get_num_addr_cyc(subop, op_id);
>> +			addrs = &instr->ctx.addr.addrs[offset];
>> +
>> +			cmd |= COMMAND_ALE | COMMAND_ALE_SIZE(naddrs);
>> +			for (i = 0; i < min_t(unsigned int, 4, naddrs); i++)
>> +				addr1 |= *addrs++ << (BITS_PER_BYTE * i);
>> +			naddrs -= i;
>> +			for (i = 0; i < min_t(unsigned int, 4, naddrs); i++)
>> +				addr2 |= *addrs++ << (BITS_PER_BYTE * i);
>> +			writel_relaxed(addr1, ctrl->regs + ADDR_REG1);
>> +			writel_relaxed(addr2, ctrl->regs + ADDR_REG2);
>> +			break;
>> +
>> +		case NAND_OP_DATA_IN_INSTR:
>> +			size = nand_subop_get_data_len(subop, op_id);
>> +			offset = nand_subop_get_data_start_off(subop, op_id);
>> +
>> +			cmd |= COMMAND_TRANS_SIZE(size) | COMMAND_PIO |
>> +				COMMAND_RX | COMMAND_A_VALID;
>> +
>> +			instr_data_in = instr;
>> +			break;
>> +
>> +		case NAND_OP_DATA_OUT_INSTR:
>> +			size = nand_subop_get_data_len(subop, op_id);
>> +			offset = nand_subop_get_data_start_off(subop, op_id);
>> +
>> +			cmd |= COMMAND_TRANS_SIZE(size) | COMMAND_PIO |
>> +				COMMAND_TX | COMMAND_A_VALID;
>> +
>> +			memcpy(&reg, instr->ctx.data.buf.out + offset, size);
>> +			writel_relaxed(reg, ctrl->regs + RESP);
>> +
>> +			break;
>> +		case NAND_OP_WAITRDY_INSTR:
>> +			cmd |= COMMAND_RBSY_CHK;
>> +			break;
>> +
>> +		}
>> +	}
>> +
>> +	cmd |= COMMAND_GO | COMMAND_CE(ctrl->cur_cs);
>> +	writel_relaxed(cmd, ctrl->regs + COMMAND);
>> +	ret = wait_for_completion_io_timeout(&ctrl->command_complete,
>> +					     msecs_to_jiffies(500));
> 
> It's not obvious to me whether _io_ variant is appropriate to use here, would 
> be nice if somebody could clarify that. Maybe block/ already does the IO 
> accounting itself and hence the IO time would be counted twice in that case.

Good that you bring this up.

I don't think that there is any higher layer which could take care of
accounting. Usually, with raw nand there is no block layer involved
anyway.

In a quick test it seems that only when using wait_for_completion_io I/O
is properly accounted in the "wait" section of top.

So far only a single driver (omap2) used the _io variant, but I think it
is the right thing to do! After all, it is I/O...

Boris or any other MTD maintainer, any comment on this?

--
Stefan
