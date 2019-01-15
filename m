Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0107EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB7CA20883
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391462AbfAOXgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 18:36:45 -0500
Received: from mga01.intel.com ([192.55.52.88]:48235 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728841AbfAOXgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 18:36:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2019 15:36:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,483,1539673200"; 
   d="scan'208";a="267422316"
Received: from yoojae-mobl1.amr.corp.intel.com (HELO [10.7.153.143]) ([10.7.153.143])
  by orsmga004.jf.intel.com with ESMTP; 15 Jan 2019 15:36:43 -0800
Subject: Re: [PATCH v10 06/12] peci: Add a PECI adapter driver for Aspeed
 AST24xx/AST25xx
To:     Joel Stanley <joel@jms.id.au>
Cc:     devicetree <devicetree@vger.kernel.org>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        James Feist <james.feist@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Haiyue Wang <haiyue.wang@linux.intel.com>
References: <20190107214136.5256-1-jae.hyun.yoo@linux.intel.com>
 <20190107214136.5256-7-jae.hyun.yoo@linux.intel.com>
 <CACPK8XfMyXfomepZEPJCr=A-cCPw-CVAZ0B2CuKn7oXCNz6LbQ@mail.gmail.com>
 <abaef001-a769-ec5d-45f0-02a994fdbee6@linux.intel.com>
 <CACPK8XdBSYHB+S8Sp8Y=J0cK9D=coa+coQj3S7TEFs9DJ8Ljxg@mail.gmail.com>
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <17179a43-9ac7-366a-bfe6-044e80875a06@linux.intel.com>
Date:   Tue, 15 Jan 2019 15:36:43 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CACPK8XdBSYHB+S8Sp8Y=J0cK9D=coa+coQj3S7TEFs9DJ8Ljxg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/2019 3:14 PM, Joel Stanley wrote:
> On Tue, 15 Jan 2019 at 09:49, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>>>> +       /**
>>>> +        * We check that the regmap works on this very first access,
>>>> +        * but as this is an MMIO-backed regmap, subsequent regmap
>>>> +        * access is not going to fail and we skip error checks from
>>>> +        * this point.
>>>
>>> Why do you use a regmap for this driver? AFAICT it has exclusive
>>> ownership over the register range it uses, which is sometimes a reason
>>> to use a regmap over a mmio region.
>>>
>>> I'm not sure if you've ever disassembled drivers/base/regmap/regmap.o,
>>> but if you do you will find that a single mmio read turns into
>>> hundreds of instructions.
>>>
>>
>> No specific reason. regmap makes some overhead as you mentioned but it
>> also provides some advantages on access simplification, endianness
>> handling and register dump at run time. I would not insist using of
>> regmap if you prefer using of raw readl and writel. Do you want replace
>> regmap with readl and writel in this driver?
> 
> I think that would be best.
> 
> You raise some good points about the regmap API, and you're not alone
> in using it for these reasons. We should look in to providing a
> suitable API without the overhead, or making regmap more efficient for
> the mmio case.
> 

Okay. I'll rewrite this driver code using readl and writel instead of 
regmap mmio. Thanks again for your review!

Regards,
Jae
