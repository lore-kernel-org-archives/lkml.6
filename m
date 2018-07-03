Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FA6C3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 03:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1145822412
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 03:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="W4aNS2fi";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="otPbden5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1145822412
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932739AbeGCDaI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 23:30:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57408 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932301AbeGCDaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 23:30:06 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8228760B67; Tue,  3 Jul 2018 03:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530588605;
        bh=1QJCvMaFcA5vFBcTC+hoiH/OKuJ1yPHJLvL00X9HP0k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W4aNS2fiBgNtbdcBb7Mm7NUpYbjgvLMRv/T0ZBKB4B8CaEtR0S703tvJCt0Xhp/Bp
         JyXGTGsqMvAMw1G4Youxeu0UKcQ8J7ZA34/RiUaPu3vwkZkIL40ZLE/fvFEi182yiz
         YSje6Y59M5+vbIyBQAUfVxQTuFt9pHo+V8TUbndw=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 1231960452;
        Tue,  3 Jul 2018 03:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530588604;
        bh=1QJCvMaFcA5vFBcTC+hoiH/OKuJ1yPHJLvL00X9HP0k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=otPbden5oqv7cQcN8gz2BOfxIhQJcEDl99Kq7jB/WTieESQEJwal6c/YwCQCjpKHX
         EiJ0q/D65NXmO/uQ7dAe/TDKJ46a9d5wJrW1tlc8f4WJpm1vVg/qMHgD0vyrxiQq31
         ytKWc2ymiL8bmrY4IyRa2gdTtpsnlrkkItG4/4MI=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 03 Jul 2018 09:00:04 +0530
From:   Abhishek Sahu <absahu@codeaurora.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Andy Gross <andy.gross@linaro.org>,
        Archit Taneja <architt@codeaurora.org>
Subject: Re: [PATCH v4 00/15] Update for QCOM NAND driver
In-Reply-To: <20180701200959.2edb3306@xps13>
References: <1529479662-4026-1-git-send-email-absahu@codeaurora.org>
 <20180701200959.2edb3306@xps13>
Message-ID: <275b38646a2b629ad7122f4cb4348371@codeaurora.org>
X-Sender: absahu@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-01 23:39, Miquel Raynal wrote:
> Hi Abhishek,
> 
> Abhishek Sahu <absahu@codeaurora.org> wrote on Wed, 20 Jun 2018
> 12:57:27 +0530:
> 
>> * v4:
>> 
>> 1. Added patch to make other ECC configurations function static.
>> 2. Clubbed the DT update patches.
>> 3. Removed the bad block related patch. Discussion is going on
>>    related with for proper solution so planning to submit separate
>>    patch series for all bad block related changes.
>> 4. Made the single codeword raw read function and used the same
>>    for raw page read.
>> 5. Changes in erased codeword detection to raw read function.
>> 
>> * v3:
>> 
>> 1. Addressed all review comments in v2.
>> 2. Added patch for removing redundant nand-ecc-step-size DT property.
>> 3. Renamed ECC configuration setup function with minor code changes.
>> 4. Modified comments and commit message for few patches.
>> 
>> * v2:
>> 
>> 1. Addressed all review comments in v1.
>> 1. Make the generic helper function for NAND ECC parameters setup
>>    and used this helper function for QCOM and Denali nand driver
>>    for ECC setup.
>> 2. Modified commit message for some of the patches and added more
>>    comments.
>> 3. Added new patch for fixing ‘return 0’ for raw read.
>> 4. Removed the read last codeword part for nand oob write.
>> 5. Reorganized bad block check function and removed the
>>    read_last_cw function completely.
>> 
>> * v1:
>> 
>> This patch series mainly deals with error handling and erased page
>> bitflip detection for QCOM NAND driver.
>> 
>> 1. The error handling was missing for some of the cases so fixed
>>    the same.
>> 
>> 2. Add the support for taking ECC strength from ONFI parameter.
>>    The earlier QCOM boards were coming with 4-bit ECC chip but
>>    now the same boards are coming with 8-bit ECC chip since the
>>    earlier 4-bit parts are obsolete from some vendors.
>> 
>> 3. We got few issues related with NAND erased page bitflips. The
>>    QCOM NAND controller can’t detect the bitflip in completely erased
>>    page so added the support to detect the same. It implemented the
>>    logic mentioned in patch [1] which didn’t go in mainline and later
>>    the generic functions were provided [2] to count the number of
>>    bitflips and make all 0xff. This patch series did some optimization
>>    logic to prevent the unnecessary full page raw read and data copy
>>    from QCOM NAND controller to DMA.
>> 
>> 4. Following are the testing done for these patches in QCOM IPQ8074
>>    HK01 (4-bit and 8-bit ECC chip) and IPQ806x AP148 boards.
>>     a. Run all mtd test and check if it passes
>>     b. Introduce custom bitflips in erased page and check if it
>>        returns no error/EUCLEAN/EBADMSG depending upon number of
>>        bitflips and position.
>>     c. Introduce failure condition for operational failure and
>>        check if it detects the same.
>> 
>> [1]: https://patchwork.ozlabs.org/patch/328994/
>> [2]: https://patchwork.ozlabs.org/patch/509970/
>> 
>> Abhishek Sahu (15):
>>   mtd: rawnand: helper function for setting up ECC configuration
>>   mtd: rawnand: denali: use helper function for ecc setup
>>   dt-bindings: qcom_nandc: update for ECC strength and step size
>>   mtd: rawnand: qcom: remove dt property nand-ecc-step-size
>>   mtd: rawnand: qcom: use the ecc strength from device parameter
>>   mtd: rawnand: qcom: wait for desc completion in all BAM channels
>>   mtd: rawnand: qcom: erased page detection for uncorrectable errors
>>     only
>>   mtd: rawnand: qcom: fix null pointer access for erased page 
>> detection
>>   mtd: rawnand: qcom: parse read errors for read oob also
>>   mtd: rawnand: qcom: modify write_oob to remove read codeword part
>>   mtd: rawnand: qcom: fix return value for raw page read
>>   mtd: rawnand: qcom: check for operation errors in case of raw read
>>   mtd: rawnand: qcom: code reorganization for raw read
>>   mtd: rawnand: qcom: erased page bitflips detection
>>   mtd: rawnand: provide only single helper function for ECC conf
>> 
>>  .../devicetree/bindings/mtd/qcom_nandc.txt         |   7 +-
>>  drivers/mtd/nand/raw/denali.c                      |  30 +-
>>  drivers/mtd/nand/raw/nand_base.c                   |  72 ++-
>>  drivers/mtd/nand/raw/qcom_nandc.c                  | 491 
>> ++++++++++++++-------
>>  include/linux/mtd/rawnand.h                        |  10 +-
>>  5 files changed, 380 insertions(+), 230 deletions(-)
>> 
> 
> Thank you very much for the series and the changes you have done.
> 

  Thanks a lot Miquel for your great support and help in
  reviewing and merging these patches :-)

> Applied all patches but "erased page bitflips detection" because I'm
> waiting for one small modification on this one.

  Sure. I will send that updated patch.

  Regards,
  Abhishek
