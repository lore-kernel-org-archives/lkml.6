Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DA229C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90FA0208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="MIBcRvYu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90FA0208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754751AbeFNHav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 03:30:51 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:19955 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754673AbeFNHap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 03:30:45 -0400
Received: from mail-vk0-f49.google.com (mail-vk0-f49.google.com [209.85.213.49]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w5E7Uf0v012183;
        Thu, 14 Jun 2018 16:30:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w5E7Uf0v012183
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1528961442;
        bh=q8t0dlBwWsk+sp0hm2BsxlTeYvnBZxz0DP1iPtkpQ9Q=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=MIBcRvYuiIzt0r3ALi90aVAfCQWnL/G6qZPgswgR+9bcz8HXIuwwb3n3/nEeJCU9a
         twNBT5lB5y51xMAyT6sRlgMS2UKjNyM7w8n689kT5XpwD0uQPvuLH9af1MCurdzu2u
         mWdJEwE4JDy91Wull4sVqgeMVNQ49mK0ZdLhly7/1KUQ8R6CkcXCFUArUg14E5TjCX
         S3ycSOea018KMs/PgrES8mBY2mz0pPJ1WGFDCeyCGR6sB7Cj74lphAj3F40RZ9chXN
         7WujN4ucQ6+J0cf+ObzhWaxGnF71ypV3/yMQi1Cjk8wIOc2LQtBsZSR7bO5ukKyktD
         imcybp0+s4cUA==
X-Nifty-SrcIP: [209.85.213.49]
Received: by mail-vk0-f49.google.com with SMTP id s187-v6so3070123vke.9;
        Thu, 14 Jun 2018 00:30:41 -0700 (PDT)
X-Gm-Message-State: APt69E3Y8eDBbC8CNeE95N6PXLcRD+c8531X9a0dn/OFkBrQMG8pjyIn
        r2IZ93MMeAuAXgOwEsLcchIPRdgPs+Pp1eK5nBk=
X-Google-Smtp-Source: ADUXVKIXXqsduE5jd7eawPs1+k/FMoE1EmKK5XWr3FXXABGoduf948iiU68UoZx63KDEQo01bTkIqxPc00wsYXpwvlo=
X-Received: by 2002:a1f:cc85:: with SMTP id c127-v6mr857603vkg.166.1528961440780;
 Thu, 14 Jun 2018 00:30:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:20ab:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 00:29:59
 -0700 (PDT)
In-Reply-To: <6557713.S7AzxIg9TS@blindfold>
References: <1528953067-24324-1-git-send-email-yamada.masahiro@socionext.com> <6557713.S7AzxIg9TS@blindfold>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 14 Jun 2018 16:29:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNASoV9nHTFax1nD_8pvkEjTzXkFpDFRf_xuoOnPPf9K23A@mail.gmail.com>
Message-ID: <CAK7LNASoV9nHTFax1nD_8pvkEjTzXkFpDFRf_xuoOnPPf9K23A@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] mtd: rawnand: denali: add new clocks and improve setup_data_interface
To:     Richard Weinberger <richard@sigma-star.at>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Philipp Rosenberger <p.rosenberger@linutronix.de>,
        Rob Herring <robh@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

2018-06-14 16:25 GMT+09:00 Richard Weinberger <richard@sigma-star.at>:
> Masahiro,
>
> Am Donnerstag, 14. Juni 2018, 07:11:04 CEST schrieb Masahiro Yamada:
>>
>> The ->setup_data_interface() hook needs to know the clock frequency.
>> In fact, this IP needs three clocks, bus "which clock?" is really
>> confusing.  (It is not described in the DT-binding at all.)
>>
>> This series adds more clocks.  In the new binding, three clocks
>> are required: core clock, bus interface clock, ECC engine clock.
>>
>> This series also takes care of the backward compatibility by
>> providing hardcoded values in case the new clocks are missing.
>> So, existing DT should work.
>>
>>
>> Changes in v2:
>>   - Split patches into sensible chunks
>>
>> Masahiro Yamada (3):
>>   mtd: rawnand: denali_dt: use dev as a shorthand of &pdev->dev
>>   mtd: rawnand: denali_dt: add more clocks based on IP datasheet
>>   mtd: rawnand: denali: optimize timing parameters for data interface
>
> This still means that we need to feed at least 2/3 and 3/3 into -stable to
> unbreak the driver.


3/3 is not mandatory.

You can only back-port 1/3 and 2/3.


3/3 is an optimization.
It will make the device access a little faster,
but you do not have to take it if you do not want to.




> I'd really prefer a single self-hosting fix that can go into -stable and then
> patches on top of the fix can prettify the driver.
>
> Thanks,
> //richard
>
> --
> sigma star gmbh - Eduard-Bodem-Gasse 6 - 6020 Innsbruck - Austria
> ATU66964118 - FN 374287y
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
