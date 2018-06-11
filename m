Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id tEDYCtI9HlsiTwAAmS7hNA
	; Mon, 11 Jun 2018 09:16:10 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 47A0060792; Mon, 11 Jun 2018 09:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1528708570;
	bh=tI8Dxyuo/kuzlpJ0K/xAif26VJvvQRhk+GUh7Hj0QIY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=SCP7TfAP5CsfESo9x9Njc5t9toOOSFA7563GEZFaiChnjVzCFW7l+aRtdFkX+Eg9k
	 fcnKt9Vyjc9C/XanjS2O3A4RoivBufq/tQ1mKcOYVR1cGv5foIXFPezwM+S/D45Qnw
	 fBQjV6e09LjrCVvm3DNtG1oeCCpaPveUmh9Wj/KE=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7CB9660791;
	Mon, 11 Jun 2018 09:16:09 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gKiO9UlG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EjYWoVB7"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7CB9660791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754192AbeFKJQG (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 05:16:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40516 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754010AbeFKJQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 05:16:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8ED9C608CD; Mon, 11 Jun 2018 09:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528708561;
        bh=tI8Dxyuo/kuzlpJ0K/xAif26VJvvQRhk+GUh7Hj0QIY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gKiO9UlGkgofMate3TD4xdX2C6fVpWF0StQLj7bweOg/9bpM9ZSZQ83IQxVPNyZxd
         pJM9Fy0txN42fwG/+tQ2l5Lrls41QkEPLGQKeYM6q2Eyazcg8s9NmPfrcZBf4U9Xe0
         fALBAC1OWziNDDw8RoDJSl0c4dyv1MwNhd93HmHg=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 19307600D0;
        Mon, 11 Jun 2018 09:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528708560;
        bh=tI8Dxyuo/kuzlpJ0K/xAif26VJvvQRhk+GUh7Hj0QIY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EjYWoVB7YZMjpWiEAA1MLhvTsQW3tO9m7tywmUcWOsHjI8xtTODM00yKczFbY/zWh
         TXQsRTPqm4I7eG+2rbVxTz4pxgucvTHMnFVoiK1NF1LnjFlAI0lgSsTUShUSKfb8TC
         0krexscft0IgjW8kSAA0l1X/eh/mBhRN2JQPlgNI=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Mon, 11 Jun 2018 14:46:00 +0530
From: Abhishek Sahu <absahu@codeaurora.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Andy Gross <andy.gross@linaro.org>,
        Archit Taneja <architt@codeaurora.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v3 01/16] mtd: rawnand: helper function for setting up ECC
 configuration
In-Reply-To: <20180607143759.361edb3f@xps13>
References: <1527250904-21988-1-git-send-email-absahu@codeaurora.org>
 <1527250904-21988-2-git-send-email-absahu@codeaurora.org>
 <20180526095807.5caf5800@xps13>
 <44d4939cf8411a0dc693b8dd11fb57c7@codeaurora.org>
 <20180607143759.361edb3f@xps13>
Message-ID: <7cf002e3d7ebd46476554477dd92716f@codeaurora.org>
X-Sender: absahu@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-07 18:07, Miquel Raynal wrote:
> Hi Abhishek,
> 
> On Mon, 28 May 2018 11:16:29 +0530, Abhishek Sahu
> <absahu@codeaurora.org> wrote:
> 
>> On 2018-05-26 14:12, Miquel Raynal wrote:
>> > Hi Abhishek,
>> > > On Fri, 25 May 2018 17:51:29 +0530, Abhishek Sahu
>> > <absahu@codeaurora.org> wrote:
>> > >> commit 2c8f8afa7f92 ("mtd: nand: add generic helpers to check,
>> >> match, maximize ECC settings") provides generic helpers which
>> >> drivers can use for setting up ECC parameters.
>> >> >> Since same board can have different ECC strength nand chips so
>> >> following is the logic for setting up ECC strength and ECC step
>> >> size, which can be used by most of the drivers.
>> >> >> 1. If both ECC step size and ECC strength are already set
>> >>    (usually by DT) then just check whether this setting
>> >>    is supported by NAND controller.
>> >> 2. If NAND_ECC_MAXIMIZE is set, then select maximum ECC strength
>> >>    supported by NAND controller.
>> >> 3. Otherwise, try to match the ECC step size and ECC strength closest
>> >>    to the chip's requirement. If available OOB size can't fit the chip
>> >>    requirement then select maximum ECC strength which can be fit with
>> >>    available OOB size.
>> >> >> This patch introduces nand_ecc_choose_conf function which calls the
>> >> required helper functions for the above logic. The drivers can use
>> >> this single function instead of calling the 3 helper functions
>> >> individually.
>> >> >> CC: Masahiro Yamada <yamada.masahiro@socionext.com>
>> >> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
>> >> ---
>> >> * Changes from v2:
>> >> >>   1. Renamed function to nand_ecc_choose_conf.
>> >>   2. Minor code reorganization to remove warning and 2 function calls
>> >>      for nand_maximize_ecc.
>> >> >> * Changes from v1:
>> >>   NEW PATCH
>> >> >>  drivers/mtd/nand/raw/nand_base.c | 42 >> ++++++++++++++++++++++++++++++++++++++++
>> >>  drivers/mtd/nand/raw/nand_base.c | 31 +++++++++++++++++++++++++++++++
>> >>  include/linux/mtd/rawnand.h      |  3 +++
>> >>  2 files changed, 34 insertions(+)
>> >> >> diff --git a/drivers/mtd/nand/raw/nand_base.c >> b/drivers/mtd/nand/raw/nand_base.c
>> >> index 72f3a89..e52019d 100644
>> >> --- a/drivers/mtd/nand/raw/nand_base.c
>> >> +++ b/drivers/mtd/nand/raw/nand_base.c
>> >> @@ -6249,6 +6249,37 @@ int nand_maximize_ecc(struct nand_chip *chip,
>> >>  }
>> >>  EXPORT_SYMBOL_GPL(nand_maximize_ecc);
>> >> >> +/**
>> >> + * nand_ecc_choose_conf - Set the ECC strength and ECC step size
>> >> + * @chip: nand chip info structure
>> >> + * @caps: ECC engine caps info structure
>> >> + * @oobavail: OOB size that the ECC engine can use
>> >> + *
>> >> + * Choose the ECC configuration according to following logic
>> >> + *
>> >> + * 1. If both ECC step size and ECC strength are already set (usually >> by DT)
>> >> + *    then check if it is supported by this controller.
>> >> + * 2. If NAND_ECC_MAXIMIZE is set, then select maximum ECC strength.
>> >> + * 3. Otherwise, try to match the ECC step size and ECC strength >> closest
>> >> + *    to the chip's requirement. If available OOB size can't fit the >> chip
>> >> + *    requirement then fallback to the maximum ECC step size and ECC >> strength.
>> >> + *
>> >> + * On success, the chosen ECC settings are set.
>> >> + */
>> >> +int nand_ecc_choose_conf(struct nand_chip *chip,
>> >> +			 const struct nand_ecc_caps *caps, int oobavail)
>> >> +{
>> >> +	if (chip->ecc.size && chip->ecc.strength)
>> >> +		return nand_check_ecc_caps(chip, caps, oobavail);
>> >> +
>> >> +	if (!(chip->ecc.options & NAND_ECC_MAXIMIZE) &&
>> >> +	    !nand_match_ecc_req(chip, caps, oobavail))
>> >> +		return 0;
>> >> +
>> >> +	return nand_maximize_ecc(chip, caps, oobavail);
>> > > I personally don't mind if nand_maximize_ecc() is called twice in
>> > the function if it clarifies the logic. Maybe the following will be
>> > more clear for the user?
>> 
>>   Thanks Miquel.
>>   Both the implementations are fine.
>>   The above implementation (which was in Denali NAND driver) code was 
>> also
>>   clear. We can go for any of these implementation.
>> 
>>   Shall I update this ?
> 
> Yes, please :)
> 

  Thanks Miquel for confirming.
  I will update accordingly.

  Also, one more question.

  Shall I make other functions (nand_check_ecc_caps, nand_maximize_ecc
  and nand_match_ecc_req) static.  Since currently,
  Denali NAND driver was only using these functions.

  And Now, this nand_ecc_choose_conf will be help
  in all the cases.

  For nand_check_ecc_caps: call nand_ecc_choose_conf with
                            chip->ecc.size && chip->ecc.strength

  For nand_maximize_ecc: call nand_ecc_choose_conf with
                         NAND_ECC_MAXIMIZE

  For other cases, nand_match_ecc_req will be called.

  So we will have one external function which will be
  easy to maintain in future.

  Thanks,
  Abhishek

>> 
>> > > 	if (chip->ecc.size && chip->ecc.strength)
>> > 		return nand_check_ecc_caps(chip, caps, oobavail);
>> > > 	if (chip->ecc.options & NAND_ECC_MAXIMIZE)
>> > 		return nand_maximize_ecc(chip, caps, oobavail);
>> > > 	if (!nand_match_ecc_req(chip, caps, oobavail))
>> > 		return 0;
>> > > 	return nand_maximize_ecc(chip, caps, oobavail);
>> > > Also, I'm not sure we should just error out when nand_check_ecc_caps()
>> > fails. What about something more robust, like:
>> >
>>   But again, It will lead in overriding the DT ECC strength parameter.
>>   We started our discussion from that point. :-)
> 
> As Boris said, let's error out instead of overriding the DT ECC
> parameters.
> 
> 
> Thanks,
> Miquèl
