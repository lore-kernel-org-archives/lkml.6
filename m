Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 00E23C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94FF82084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="InvEsOX+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94FF82084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934280AbeFLVYs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 17:24:48 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:53468 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934131AbeFLVYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 17:24:46 -0400
Received: by mail-it0-f67.google.com with SMTP id a195-v6so1169345itd.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 14:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hDbMHkgx6HoF9CN7Hngb3yYGrHPppa05xoNhug1VoMc=;
        b=InvEsOX+RWkvDjcnjw4+qyH6g29U2GII7V0Lx8d7dpE43Qdob+QdwdRPoZmnuqW+09
         s7iNfH2i2/vGCCpLD+t9k5BvpUjy185/kQu4oRA08dNBYBOjcJN+PBIDHfxfH91Vsd+L
         15ePIsgGyIjtHfaXHzi+p27Uxk61EtqDn1EZfdhM6ifMBMB9+THjhilKEi92RrEhA5V4
         5cVVh1bYTvuSdA30Nj56ndZTYfrtnigyMfzj/8rPUlB+yNkl1IwwhzYz980Ed8ymLDyl
         n3AHsJtL2FTKSZWQO3UE1DczKgJ620XPScDJxR0D5SIVFbmVwcC7YOwSB5RkbPZFtqus
         tXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hDbMHkgx6HoF9CN7Hngb3yYGrHPppa05xoNhug1VoMc=;
        b=AfLQjGRkhpnwl5uslU5BN/qUixRgkj1CjukK91IWs6NZ7cwMIFkGWMvo3H8/hS/SzU
         90wOBwQZeG2QTEN6cDbaaJuxUpGdcaGHjDyHLvnpQ1a+sKR0+OWro8o+E0wEhZHPuvay
         /TChbQrWnm1SlfFN7U6mtcectz0954NZLINae72y+vaKiuZQeT4iGc+BdpLhezS/gwip
         kzi+9Rbn669vVNsliN0HVmbp8cIISwG7ZrQLVxX6kHgAoLclzOWb7kT4BEjdPr62PO6P
         F36CMW3KHCHOFlJBEwjWG0Pp6NE4fmHoWaBST6TkcsjkcfHk6fDdrqleGTUZKL9UchNj
         zmpQ==
X-Gm-Message-State: APt69E3I3w/Ogx3mqpo+Jj3wRRbDVBNrXZSpADJeeaPe8lHJts2SG730
        cQ/GviznwBOtQSxbz4Io3dGzzHbfWHs=
X-Google-Smtp-Source: ADUXVKKNxW3yIfpXYN/Mkb2VIxXyHpAgLYZ8MPa4SaQ1M+AV0ZnbLEGnD5UkXx1P2UdkcJjs9O4g7w==
X-Received: by 2002:a24:1848:: with SMTP id 69-v6mr2031024itr.57.1528838685291;
        Tue, 12 Jun 2018 14:24:45 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id z11-v6sm258398ioc.8.2018.06.12.14.24.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 14:24:43 -0700 (PDT)
Subject: Re: [PATCH v4 4/6] mtd: rawnand: add NVIDIA Tegra NAND Flash
 controller driver
To:     Stefan Agner <stefan@agner.ch>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Dmitry Osipenko <digetx@gmail.com>, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        dev@lynxeye.de, miquel.raynal@bootlin.com, richard@nod.at,
        marcel@ziswiler.com, krzk@kernel.org, benjamin.lindqvist@endian.se,
        jonathanh@nvidia.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        mirza.krak@gmail.com, gaireg@gaireg.de,
        linux-mtd@lists.infradead.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180611205224.23340-1-stefan@agner.ch>
 <20180611205224.23340-5-stefan@agner.ch> <4258393.O1xtUOGbca@dimapc>
 <cb6f2ef0a5a41e001a2019caa1a18c23@agner.ch>
 <20180612102734.0ea3bfa5@bbrezillon>
 <53e36cff80e38e489959aa18471d0782@agner.ch>
 <1fcde0fa-d1e8-1cc3-8c3d-0e8c4097cb91@kernel.dk>
 <bb2b5e0de922dd928ad923c185bb5da8@agner.ch>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7985c118-af47-624e-bfcc-cd5d8726742a@kernel.dk>
Date:   Tue, 12 Jun 2018 15:24:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <bb2b5e0de922dd928ad923c185bb5da8@agner.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/18 2:20 PM, Stefan Agner wrote:
> On 12.06.2018 17:24, Jens Axboe wrote:
>> On 6/12/18 3:17 AM, Stefan Agner wrote:
>>> [also added Jens Axboe]
>>>
>>> On 12.06.2018 10:27, Boris Brezillon wrote:
>>>> On Tue, 12 Jun 2018 10:06:42 +0200
>>>> Stefan Agner <stefan@agner.ch> wrote:
>>>>
>>>>> On 12.06.2018 02:03, Dmitry Osipenko wrote:
>>>>>> On Monday, 11 June 2018 23:52:22 MSK Stefan Agner wrote:
>>>>>>> Add support for the NAND flash controller found on NVIDIA
>>>>>>> Tegra 2 SoCs. This implementation does not make use of the
>>>>>>> command queue feature. Regular operations/data transfers are
>>>>>>> done in PIO mode. Page read/writes with hardware ECC make
>>>>>>> use of the DMA for data transfer.
>>>>>>>
>>>>>>> Signed-off-by: Lucas Stach <dev@lynxeye.de>
>>>>>>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>>>>>>> ---
>>>>>>>  MAINTAINERS                       |    7 +
>>>>>>>  drivers/mtd/nand/raw/Kconfig      |    6 +
>>>>>>>  drivers/mtd/nand/raw/Makefile     |    1 +
>>>>>>>  drivers/mtd/nand/raw/tegra_nand.c | 1248 +++++++++++++++++++++++++++++
>>>>>>>  4 files changed, 1262 insertions(+)
>>>>>>>  create mode 100644 drivers/mtd/nand/raw/tegra_nand.c
>>>>>>>
>>>>> [snip]
>>>>>>> +static int tegra_nand_cmd(struct nand_chip *chip,
>>>>>>> +			 const struct nand_subop *subop)
>>>>>>> +{
>>>>>>> +	const struct nand_op_instr *instr;
>>>>>>> +	const struct nand_op_instr *instr_data_in = NULL;
>>>>>>> +	struct tegra_nand_controller *ctrl = to_tegra_ctrl(chip->controller);
>>>>>>> +	unsigned int op_id, size = 0, offset = 0;
>>>>>>> +	bool first_cmd = true;
>>>>>>> +	u32 reg, cmd = 0;
>>>>>>> +	int ret;
>>>>>>> +
>>>>>>> +	for (op_id = 0; op_id < subop->ninstrs; op_id++) {
>>>>>>> +		unsigned int naddrs, i;
>>>>>>> +		const u8 *addrs;
>>>>>>> +		u32 addr1 = 0, addr2 = 0;
>>>>>>> +
>>>>>>> +		instr = &subop->instrs[op_id];
>>>>>>> +
>>>>>>> +		switch (instr->type) {
>>>>>>> +		case NAND_OP_CMD_INSTR:
>>>>>>> +			if (first_cmd) {
>>>>>>> +				cmd |= COMMAND_CLE;
>>>>>>> +				writel_relaxed(instr->ctx.cmd.opcode,
>>>>>>> +					       ctrl->regs + CMD_REG1);
>>>>>>> +			} else {
>>>>>>> +				cmd |= COMMAND_SEC_CMD;
>>>>>>> +				writel_relaxed(instr->ctx.cmd.opcode,
>>>>>>> +					       ctrl->regs + CMD_REG2);
>>>>>>> +			}
>>>>>>> +			first_cmd = false;
>>>>>>> +			break;
>>>>>>> +		case NAND_OP_ADDR_INSTR:
>>>>>>> +			offset = nand_subop_get_addr_start_off(subop, op_id);
>>>>>>> +			naddrs = nand_subop_get_num_addr_cyc(subop, op_id);
>>>>>>> +			addrs = &instr->ctx.addr.addrs[offset];
>>>>>>> +
>>>>>>> +			cmd |= COMMAND_ALE | COMMAND_ALE_SIZE(naddrs);
>>>>>>> +			for (i = 0; i < min_t(unsigned int, 4, naddrs); i++)
>>>>>>> +				addr1 |= *addrs++ << (BITS_PER_BYTE * i);
>>>>>>> +			naddrs -= i;
>>>>>>> +			for (i = 0; i < min_t(unsigned int, 4, naddrs); i++)
>>>>>>> +				addr2 |= *addrs++ << (BITS_PER_BYTE * i);
>>>>>>> +			writel_relaxed(addr1, ctrl->regs + ADDR_REG1);
>>>>>>> +			writel_relaxed(addr2, ctrl->regs + ADDR_REG2);
>>>>>>> +			break;
>>>>>>> +
>>>>>>> +		case NAND_OP_DATA_IN_INSTR:
>>>>>>> +			size = nand_subop_get_data_len(subop, op_id);
>>>>>>> +			offset = nand_subop_get_data_start_off(subop, op_id);
>>>>>>> +
>>>>>>> +			cmd |= COMMAND_TRANS_SIZE(size) | COMMAND_PIO |
>>>>>>> +				COMMAND_RX | COMMAND_A_VALID;
>>>>>>> +
>>>>>>> +			instr_data_in = instr;
>>>>>>> +			break;
>>>>>>> +
>>>>>>> +		case NAND_OP_DATA_OUT_INSTR:
>>>>>>> +			size = nand_subop_get_data_len(subop, op_id);
>>>>>>> +			offset = nand_subop_get_data_start_off(subop, op_id);
>>>>>>> +
>>>>>>> +			cmd |= COMMAND_TRANS_SIZE(size) | COMMAND_PIO |
>>>>>>> +				COMMAND_TX | COMMAND_A_VALID;
>>>>>>> +
>>>>>>> +			memcpy(&reg, instr->ctx.data.buf.out + offset, size);
>>>>>>> +			writel_relaxed(reg, ctrl->regs + RESP);
>>>>>>> +
>>>>>>> +			break;
>>>>>>> +		case NAND_OP_WAITRDY_INSTR:
>>>>>>> +			cmd |= COMMAND_RBSY_CHK;
>>>>>>> +			break;
>>>>>>> +
>>>>>>> +		}
>>>>>>> +	}
>>>>>>> +
>>>>>>> +	cmd |= COMMAND_GO | COMMAND_CE(ctrl->cur_cs);
>>>>>>> +	writel_relaxed(cmd, ctrl->regs + COMMAND);
>>>>>>> +	ret = wait_for_completion_io_timeout(&ctrl->command_complete,
>>>>>>> +					     msecs_to_jiffies(500));
>>>>>>
>>>>>> It's not obvious to me whether _io_ variant is appropriate to use here, would
>>>>>> be nice if somebody could clarify that. Maybe block/ already does the IO
>>>>>> accounting itself and hence the IO time would be counted twice in that case.
>>>>>
>>>>> Good that you bring this up.
>>>>>
>>>>> I don't think that there is any higher layer which could take care of
>>>>> accounting. Usually, with raw nand there is no block layer involved
>>>>> anyway.
>>>>>
>>>>> In a quick test it seems that only when using wait_for_completion_io I/O
>>>>> is properly accounted in the "wait" section of top.
>>>>>
>>>>> So far only a single driver (omap2) used the _io variant, but I think it
>>>>> is the right thing to do! After all, it is I/O...
>>>>>
>>>>> Boris or any other MTD maintainer, any comment on this?
>>>>
>>>> Given this definition of io_schedule_timeout() [1] (which is used when
>>>> you call wait_for_completion_io_timeout()), I'd say it's not useful to
>>>> use the _io_ version, simply because MTD devs are not exposed as blk
>>>> devices, and thus don't need the blk_schedule_flush_plug() that is done
>>>> is io_schedule_prepare(). But that also means MTD I/Os are not
>>>> accounted as I/Os :-(.
>>>
>>> Documentation of wait_for_completion_io says:
>>> "The caller is accounted as waiting for IO (which traditionally means
>>> blkio only)."
>>>
>>> Which sounds as if it using _io is only an accounting thing...
>>
>> Yes, you should only use it for waiting for IO off a system call
>> read path. So block IO, or file system IO. Don't use it for internal
>> IO that isn't related to that.
> 
> I guess that would be the case here, since MTD page read/writes are
> typically file system IOs (e.g. UBIFS).
> 
> The problem is just that is not block related at all since it uses the
> MTD subsystem... And it seems that the _io variants besides accounting,
> also take a role in the block subsystems device plugging mechanism. What
> is unclear to me if using the _io variant from the MTD subsystem
> potentially disturbs the plugging mechanism...

No, it has nothing to do with plugging at the block level. So if you're
doing regular user IO, then you should use the _io variants.

-- 
Jens Axboe

