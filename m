Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4FCC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1963120840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dZtAvm67";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DnnG/vrE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1963120840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbeKIP5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 10:57:38 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:54368 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbeKIP5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 10:57:38 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A011A6038E; Fri,  9 Nov 2018 06:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541744313;
        bh=RSEk8KvZCHbvz1+x2kOXQX0T+ynq2gt98m8DofjYOE8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dZtAvm678jbjMu0NhgUlhcviJB3yc+Nflr9odOgrO2zrpzgZcMUv5MwItWIR10f3L
         4yFKQ2WeHso5aj2GAn6Q5J0w+RZyGtVGtAe+X3+TgdMrVpP6imgUM3Cu3b8UC2ZTFk
         3M01CLahCSo1WmALUdfRdedFpLm9SOWGVzs+WTwI=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id CADEF601D1;
        Fri,  9 Nov 2018 06:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541744312;
        bh=RSEk8KvZCHbvz1+x2kOXQX0T+ynq2gt98m8DofjYOE8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DnnG/vrETMQcw3C0ayNQ5srb6cnMnFsyMVQEszRyHdaDolaGRsiGEYbYU6znAMHzV
         6nN/GNkDmJlt28HHaHeXo0G3zvCNAYvCYor0LEnelsBW2BTRDGSIA44Z2qKyDYqRtv
         ErMyCvGMT+XB0s4huni+UD90NXit2bKzBOnffCcE=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 09 Nov 2018 11:48:32 +0530
From:   Abhishek Sahu <absahu@codeaurora.org>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Andy Gross <andy.gross@linaro.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 2/5] mtd: rawnand: qcom: remove driver specific
 block_markbad function
In-Reply-To: <20181104165627.293773a8@bbrezillon>
References: <1530863519-5564-1-git-send-email-absahu@codeaurora.org>
 <1530863519-5564-3-git-send-email-absahu@codeaurora.org>
 <20180718232350.3eaade9a@xps13> <20180718234358.6bb5e8a0@bbrezillon>
 <7ab0be154272b71f9beb2a7fb830c7be@codeaurora.org>
 <20180720150348.592c8984@bbrezillon> <20181104165627.293773a8@bbrezillon>
Message-ID: <453b3e058e972dc0644f06c2f0969802@codeaurora.org>
X-Sender: absahu@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-04 21:26, Boris Brezillon wrote:
> Hi Abhishek,
> 
> On Fri, 20 Jul 2018 15:03:48 +0200
> Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> 
>> On Fri, 20 Jul 2018 17:46:38 +0530
>> Abhishek Sahu <absahu@codeaurora.org> wrote:
>> 
>> > Hi Boris,
>> >
>> > On 2018-07-19 03:13, Boris Brezillon wrote:
>> > > On Wed, 18 Jul 2018 23:23:50 +0200
>> > > Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>> > >
>> > >> Boris,
>> > >>
>> > >> Can you please check the change in qcom_nandc_write_oob() is
>> > >> valid? I think it is but as this is a bit of a hack I prefer double
>> > >> checking.
>> > >
>> > > Indeed, it's hack-ish.
>> > >
>> > >>
>> > >> Thanks,
>> > >> Miquèl
>> > >>
>> > >>
>> > >> Abhishek Sahu <absahu@codeaurora.org> wrote on Fri,  6 Jul 2018
>> > >> 13:21:56 +0530:
>> > >>
>> > >> > The NAND base layer calls write_oob() by setting bytes at
>> > >> > chip->badblockpos with value non 0xFF for updating bad block status.
>> > >> > The QCOM NAND controller skips the bad block bytes while doing normal
>> > >> > write with ECC enabled. When initial support for this driver was
>> > >> > added, the driver specific function was added temporarily for
>> > >> > block_markbad() with assumption to change for raw read in NAND base
>> > >> > layer. Moving to raw read for block_markbad() seems to take more time
>> > >> > so this patch removes driver specific block_markbad() function by
>> > >> > using following HACK in write_oob() function.
>> > >> >
>> > >> > Check for BBM bytes in OOB and accordingly do raw write for updating
>> > >> > BBM bytes in NAND flash or normal write for updating available OOB
>> > >> > bytes.
>> > >
>> > > Why don't we change that instead of patching the qcom driver to guess
>> > > when the core tries to mark a block bad? If you're afraid of breaking
>> > > existing drivers that might rely on the "write/read BBM in non-raw
>> > > mode" solution (I'm sure some drivers are), you can always add a new
>> > > flag in chip->options (NAND_ACCESS_BBM_IN_RAW_MODE) and only use raw
>> > > accessors when this flag is set.
>> > >
>> >
>> >   We started with that Only
>> >
>> >   http://patchwork.ozlabs.org/patch/508565/
>> >
>> >   and since we didn't conclude, we went for driver
>> >   specific bad block check and mark bad block functions.
>> >
>> >   Now, we wanted to get rid of driver specific functions
>> >
>> >   1. For bad block check, we found the way to get the BBM bytes
>> >      with ECC read. Controller updates BBM in separate register
>> >      which we can read and update the same in OOB. Patch #1 of
>> >      series does the same.
>> >
>> >   2. For bad block mark, there is no way to update in ECC mode
>> >      that's why we went for HACK to get rid of driver specific
>> >      function.
>> >
>> >   If adding flag is fine now then this HACK won't be required.
>> 
>> Yep. I'm fine with that. Can you rebase the patch you pointed out on 
>> top
>> of nand/next and move the flag to chip->options instead of
>> chip->bbt_options + prefix it with NAND_ instead of NAND_BBT_?
> 
> I'm currently trying to get rid of chip->block_bad() (now placed in
> chip->legacy.block_bad()), and I wanted to know if you were still
> planning to submit the changes we discussed in this thread. If you
> don't have time, please let me know and I'll try to do it.
> 

  Sorry Boris, I couldn't work on these patches.

  Currently, I am working on non open source projects so
  I can't submit any patches in open source till this project
  completion due to legal guidelines.

  If this is urgent then you can try. I will help in
  QCOM related stuffs and testing.

  Thanks,
  Abhishek

