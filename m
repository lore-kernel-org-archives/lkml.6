Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4BDECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A739820661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GBnyxHvp";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MXdZFkLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A739820661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731109AbeGTNEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:04:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46816 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731054AbeGTNEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:04:37 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D510160452; Fri, 20 Jul 2018 12:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532088999;
        bh=lsLefNt3qlS5L03zyUFEPwvce0MF2JzH71VCNe4v7H4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GBnyxHvp+/jfn9O5q+CAVTUs53hN3t7LO9QMKcC3Dre0MuyzPaNY57bRI/lWlly80
         ZEjfd5I2s2YmsfXcL5Uw62oFxThi8SsgjkVlegLokswwmcBlUVmKSOAsNEqZk+VDWh
         +kVDY0Vczsixo9iKDyLNFU2hb2XmYd+el/KnLf5o=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 53A1360452;
        Fri, 20 Jul 2018 12:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532088998;
        bh=lsLefNt3qlS5L03zyUFEPwvce0MF2JzH71VCNe4v7H4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MXdZFkLP1MEEEkblN1BeWChuAXnraRpatGBNCuT3DrtMPK5OO+BRjqDuh+Drz3lVv
         agjOn98weF9DED4lWPbs1a08hGVKptUSn3PBrU8Bu8Jpt3MOnZsCdzGILVl3Rb5fu4
         hFvaV+HEhtEIPyJ8PZKstomQ+pPGkxGaGF3/LPHY=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 20 Jul 2018 17:46:38 +0530
From:   Abhishek Sahu <absahu@codeaurora.org>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH 2/5] mtd: rawnand: qcom: remove driver specific
 block_markbad function
In-Reply-To: <20180718234358.6bb5e8a0@bbrezillon>
References: <1530863519-5564-1-git-send-email-absahu@codeaurora.org>
 <1530863519-5564-3-git-send-email-absahu@codeaurora.org>
 <20180718232350.3eaade9a@xps13> <20180718234358.6bb5e8a0@bbrezillon>
Message-ID: <7ab0be154272b71f9beb2a7fb830c7be@codeaurora.org>
X-Sender: absahu@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 2018-07-19 03:13, Boris Brezillon wrote:
> On Wed, 18 Jul 2018 23:23:50 +0200
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> 
>> Boris,
>> 
>> Can you please check the change in qcom_nandc_write_oob() is
>> valid? I think it is but as this is a bit of a hack I prefer double 
>> checking.
> 
> Indeed, it's hack-ish.
> 
>> 
>> Thanks,
>> Miquèl
>> 
>> 
>> Abhishek Sahu <absahu@codeaurora.org> wrote on Fri,  6 Jul 2018
>> 13:21:56 +0530:
>> 
>> > The NAND base layer calls write_oob() by setting bytes at
>> > chip->badblockpos with value non 0xFF for updating bad block status.
>> > The QCOM NAND controller skips the bad block bytes while doing normal
>> > write with ECC enabled. When initial support for this driver was
>> > added, the driver specific function was added temporarily for
>> > block_markbad() with assumption to change for raw read in NAND base
>> > layer. Moving to raw read for block_markbad() seems to take more time
>> > so this patch removes driver specific block_markbad() function by
>> > using following HACK in write_oob() function.
>> >
>> > Check for BBM bytes in OOB and accordingly do raw write for updating
>> > BBM bytes in NAND flash or normal write for updating available OOB
>> > bytes.
> 
> Why don't we change that instead of patching the qcom driver to guess
> when the core tries to mark a block bad? If you're afraid of breaking
> existing drivers that might rely on the "write/read BBM in non-raw
> mode" solution (I'm sure some drivers are), you can always add a new
> flag in chip->options (NAND_ACCESS_BBM_IN_RAW_MODE) and only use raw
> accessors when this flag is set.
> 

  We started with that Only

  http://patchwork.ozlabs.org/patch/508565/

  and since we didn't conclude, we went for driver
  specific bad block check and mark bad block functions.

  Now, we wanted to get rid of driver specific functions

  1. For bad block check, we found the way to get the BBM bytes
     with ECC read. Controller updates BBM in separate register
     which we can read and update the same in OOB. Patch #1 of
     series does the same.

  2. For bad block mark, there is no way to update in ECC mode
     that's why we went for HACK to get rid of driver specific
     function.

  If adding flag is fine now then this HACK won't be required.
  Moving to RAW mode for every one still looks risky.

  Thanks,
  Abhishek


