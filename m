Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 270ECC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D134C208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="slD8wVaa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D134C208D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755179AbeFNLcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 07:32:52 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:22926 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754810AbeFNLct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 07:32:49 -0400
Received: from mail-vk0-f51.google.com (mail-vk0-f51.google.com [209.85.213.51]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w5EBWeLx009367;
        Thu, 14 Jun 2018 20:32:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w5EBWeLx009367
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1528975961;
        bh=HB2/qwaOs6XsjCIezhblRK9JLkDNWcBThovqLttfd18=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=slD8wVaam3aT+wLB96aoen0rtxdaS+4Q3qiiWaug8TT5ZpgjmiVFQTsL8Zjz4eSAN
         0UMZFgmzhWhz8xtu6bsQTcTCXH2S6muEjbA3O3cLLFQZB4cgHoipfCOo3RF18+gVb5
         L7aGFXyjuOAG9FIpi5Av5CmrQ9S/OfUAMgkMDtm6PHS05BM42EabkRToAiEyWMxXGu
         9epMi8fb2KUOBMxEZXxnFBWFfz2KUOEq5WDrVGJGdvPVb//f/OqOEQPmXW1QOZh0vy
         d6/D9Le0OCqz9zG7teY//74zykZ+o1IUiVmaBWRFm0+w7rfKYAffCMiAFuF9RHL2tX
         KlSEtM4qq7/ig==
X-Nifty-SrcIP: [209.85.213.51]
Received: by mail-vk0-f51.google.com with SMTP id b77-v6so3443490vkb.5;
        Thu, 14 Jun 2018 04:32:41 -0700 (PDT)
X-Gm-Message-State: APt69E3FLiuvtkEDMq6uxyJ/sjIxb5B3rIryNUXA6mAr49T3EXntc2u4
        KYoH5zseGtHou/vpE9oN0t9FJEqmmzjrSl5P2nY=
X-Google-Smtp-Source: ADUXVKKfm8rEc7G7XicAk69bUq+EbblOQVCLcAmCSe56KW2i9238y/wTvDeIZmjQoAbF/BziT2A9p+FNGpryNiJVcNM=
X-Received: by 2002:a1f:b143:: with SMTP id a64-v6mr1264033vkf.65.1528975960083;
 Thu, 14 Jun 2018 04:32:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:20ab:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 04:31:59
 -0700 (PDT)
In-Reply-To: <20180614093835.5c3bf426@bbrezillon>
References: <1528953067-24324-1-git-send-email-yamada.masahiro@socionext.com>
 <6557713.S7AzxIg9TS@blindfold> <CAK7LNASoV9nHTFax1nD_8pvkEjTzXkFpDFRf_xuoOnPPf9K23A@mail.gmail.com>
 <20180614093835.5c3bf426@bbrezillon>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 14 Jun 2018 20:31:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNARfnTtESsVdUtvreLh50+awtL42nCLY9tHzbp2UN2kpBw@mail.gmail.com>
Message-ID: <CAK7LNARfnTtESsVdUtvreLh50+awtL42nCLY9tHzbp2UN2kpBw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] mtd: rawnand: denali: add new clocks and improve setup_data_interface
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Philipp Rosenberger <p.rosenberger@linutronix.de>,
        Richard Weinberger <richard@sigma-star.at>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

2018-06-14 16:38 GMT+09:00 Boris Brezillon <boris.brezillon@bootlin.com>:
> On Thu, 14 Jun 2018 16:29:59 +0900
> Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
>
>> Hi Richard,
>>
>> 2018-06-14 16:25 GMT+09:00 Richard Weinberger <richard@sigma-star.at>:
>> > Masahiro,
>> >
>> > Am Donnerstag, 14. Juni 2018, 07:11:04 CEST schrieb Masahiro Yamada:
>> >>
>> >> The ->setup_data_interface() hook needs to know the clock frequency.
>> >> In fact, this IP needs three clocks, bus "which clock?" is really
>> >> confusing.  (It is not described in the DT-binding at all.)
>> >>
>> >> This series adds more clocks.  In the new binding, three clocks
>> >> are required: core clock, bus interface clock, ECC engine clock.
>> >>
>> >> This series also takes care of the backward compatibility by
>> >> providing hardcoded values in case the new clocks are missing.
>> >> So, existing DT should work.
>> >>
>> >>
>> >> Changes in v2:
>> >>   - Split patches into sensible chunks
>> >>
>> >> Masahiro Yamada (3):
>> >>   mtd: rawnand: denali_dt: use dev as a shorthand of &pdev->dev
>> >>   mtd: rawnand: denali_dt: add more clocks based on IP datasheet
>> >>   mtd: rawnand: denali: optimize timing parameters for data interface
>> >
>> > This still means that we need to feed at least 2/3 and 3/3 into -stable to
>> > unbreak the driver.
>>
>>
>> 3/3 is not mandatory.
>>
>> You can only back-port 1/3 and 2/3.
>
> Well, patch 1 is not a fix, can we move it after patch 2 so that only
> patch 2 is flagged with the Fixes+Cc-stable tags?


OK, will do that.

If you try to port this back to v4.14.*
you need to fix-up the file path
since the driver did not reside in the raw/ sub-directory at that time.


Except that, I do not see backport issue.




> Thanks,
>
> Boris
>
>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/



-- 
Best Regards
Masahiro Yamada
