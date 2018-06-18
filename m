Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5FEC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C0220852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="QrdruBvq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C0220852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935194AbeFRKv7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:51:59 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:55778 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932612AbeFRKv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 06:51:56 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id F052E5C00F6;
        Mon, 18 Jun 2018 12:51:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1529319114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Wtp+OMiqpQa9hbGe/uDtSIE1vEfRcochXnZGooTROM=;
        b=QrdruBvqbBOHTIZ77QzY/6VJ6ukphcaTFxOy8/KW9+uP2kyIxN7470dFl8xz1254A56Rwd
        0eT+rrVB+Pd/BVA7exwIdS+cJ/CbE1PMPEKlcDniqvHV4Qp3MaPy7pJTPVMGl9GpecFSmp
        t38ii5b7NTMlm5qUQqbwXoCUJX5GfmM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Mon, 18 Jun 2018 12:51:52 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        thierry.reding@gmail.com, dev@lynxeye.de,
        miquel.raynal@bootlin.com, richard@nod.at, marcel@ziswiler.com,
        krzk@kernel.org, digetx@gmail.com, benjamin.lindqvist@endian.se,
        jonathanh@nvidia.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        mirza.krak@gmail.com, gaireg@gaireg.de,
        linux-mtd@lists.infradead.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/6] mtd: rawnand: add NVIDIA Tegra NAND flash support
In-Reply-To: <20180618115806.7be25499@bbrezillon>
References: <20180617204605.4648-1-stefan@agner.ch>
 <20180618115806.7be25499@bbrezillon>
Message-ID: <95279b61ce2630c1276669359b163933@agner.ch>
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
         ASN(0.00)[asn:29691, ipnet:2a02:418::/29, country:CH];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.00)[32.81%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.06.2018 11:58, Boris Brezillon wrote:
> On Sun, 17 Jun 2018 22:45:59 +0200
> Stefan Agner <stefan@agner.ch> wrote:
> 
>> Changes definitly calm down, most noteably probably the changes
>> around checking whether a page is empty if the stack reports ECC
>> errors.. I verified the code using raw nandwrites with OOB to
>> simulate an empty page which has some bits flipped in the OOB area,
>> everthing seems to work as I would expect it.
>>
>> For now I do not check extra OOB bytes since those are at variable
>> locations depending on algorithm.
> 
> Hm, if you expose them as free OOB bytes, you should also check them,
> otherwise you might end up with corrupted data without noticing it. Note
> that, depending on whether those free OOB bytes are ECC-protected or
> not, you should change the way you do the check:
> 
> - non-protected OOB bytes: all bytes should be 0xff (no bitflips
>   allowed)
> - data+free OOB bytes protected by the same ECC bytes: you should pass
>   the free OOB bytes buffer to nand_check_erased_ecc_chunk() along with
>   the data and ECC buffers
> - free OOB bytes have their own ECC bytes: call
>   nand_check_erased_ecc_chunk() separately and pass it the ECC + free
>   OOB buffers.

This graphic taken from the public Tegra 2 Technical Reference Manual is
quite useful:
https://imgur.com/a/0Hqzbkc

Tegra basically has all of the above, which makes the whole business
really tricky...

I am not sure if we really could do variant 1, non-protected OOB, but
since we have the option of protected OOB, we probably anyway would do
that.

RS/Hamming implements variant 3.

BCH implements variant 2. OOB is protected with the last data buffer.

So this would require a algorithm depending implementation, which is
probably not a big deal.

But there is one more issue with BCH: Only if extra data are actually
transferred, tag space is actually allocated. If no tag bytes are
transferred, parity follows immediately skip bytes. As far as I know the
MTD stacks OOB layout assumes that is always the same layout, no matter
whether we write extra OOB data or not. For the Tegra NAND controller
this would mean that we have to always transfer tag bytes and therefor
penalize the use case we are most interested in (which is no extra OOB
bytes, since UBI does not make use of it)...

Furthermore I realized that testing is not easily possible since
nandwrite with --oob seems not to make use of "oob_required" in the main
page write but issues a separate OOB write command. I did not found a
way to issue a write from user space which sets oob_required...

Due to all this I rather prefer to not implement extra OOB support at
this point.

How do I do this properly? Set mtd_ooblayout_ops.free to NULL?

--
Stefan

> 
>>
>> --
>> Stefan
>>
>> Changes since v1:
>> - Split controller and NAND chip structure
>> - Add BCH support
>> - Allow to select algorithm and strength using device tree
>> - Improve HW ECC error reporting and use DEC_STATUS_BUF only
>> - Use SPDX license identifier
>> - Use per algorithm mtd_ooblayout_ops
>> - Use setup_data_interface callback for NAND timing configuration
>>
>> Changes since v2:
>> - Set clock rate using assigned-clocks
>> - Use BIT() macro
>> - Fix and improve timing calculation
>> - Improve ECC error handling
>> - Store OOB layout for tag area in Tegra chip structure
>> - Update/fix bindings
>> - Use more specific variable names (replace "value")
>> - Introduce nand-is-boot-medium
>> - Choose sensible ECC strenght automatically
>> - Use wait_for_completion_timeout
>> - Print register dump on completion timeout
>> - Unify tegra_nand_(read|write)_page in tegra_nand_page_xfer
>>
>> Changes since v3:
>> - Implement tegra_nand_(read|write)_raw using DMA
>> - Implement tegra_nand_(read|write)_oob using DMA
>> - Name registers according to Tegra 2 Technical Reference Manual (v02p)
>> - Use wait_for_completion_io_timeout to account for IO
>> - Get chip select id from device tree reg property
>> - Clear interrupts and reinit wait queues in case command/DMA times out
>> - Set default MTD name after nand_set_flash_node
>> - Move MODULE_DEVICE_TABLE after declaration of tegra_nand_of_match
>> - Make (rs|bch)_strength static
>>
>> Changes since v4:
>> - Pass OOB area to nand_check_erased_ecc_chunk
>> - Pass algorithm specific bits_per_step to tegra_nand_get_strength
>> - Store ECC layout in chip structure
>> - Fix pointer assignment (use NULL)
>> - Removed obsolete header delay.h
>> - Fixed newlines
>> - Use non-_io variant of wait_for_completion_timeout
>>
>> Lucas Stach (1):
>>   ARM: dts: tegra: add Tegra20 NAND flash controller node
>>
>> Stefan Agner (5):
>>   mtd: rawnand: add Reed-Solomon error correction algorithm
>>   mtd: rawnand: add an option to specify NAND chip as a boot device
>>   mtd: rawnand: tegra: add devicetree binding
>>   mtd: rawnand: add NVIDIA Tegra NAND Flash controller driver
>>   ARM: dts: tegra: enable NAND flash on Colibri T20
>>
>>  .../devicetree/bindings/mtd/nand.txt          |    6 +-
>>  .../bindings/mtd/nvidia-tegra20-nand.txt      |   64 +
>>  MAINTAINERS                                   |    7 +
>>  arch/arm/boot/dts/tegra20-colibri-512.dtsi    |   16 +
>>  arch/arm/boot/dts/tegra20.dtsi                |   15 +
>>  drivers/mtd/nand/raw/Kconfig                  |    6 +
>>  drivers/mtd/nand/raw/Makefile                 |    1 +
>>  drivers/mtd/nand/raw/nand_base.c              |    4 +
>>  drivers/mtd/nand/raw/tegra_nand.c             | 1268 +++++++++++++++++
>>  include/linux/mtd/rawnand.h                   |    7 +
>>  10 files changed, 1393 insertions(+), 1 deletion(-)
>>  create mode 100644 Documentation/devicetree/bindings/mtd/nvidia-tegra20-nand.txt
>>  create mode 100644 drivers/mtd/nand/raw/tegra_nand.c
>>
