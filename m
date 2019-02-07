Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6DFC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A023A21872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549563476;
	bh=4jcdpPFqeJsRseAZEwMbif4YewT22YZhpuZFl/7C8wU=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=q3WcoQswF58eHicob24tbRF8+g4w4dl4e4DSPLv2jUgn7I1bPnuq0YfnewOhtR9/V
	 CIzCNUSFLcrjvXl40vR7R538K8Fq3gX4njEdH9h32VR5gcZyZBo6gkf00/ppetP/iZ
	 8kzkw6LtRrYa8QrVPq/Ehd8mdeG83CIP3hbbZj0g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfBGSRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 13:17:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:47396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbfBGSRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 13:17:54 -0500
Received: from [192.168.1.31] (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13C9D2175B;
        Thu,  7 Feb 2019 18:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549563472;
        bh=4jcdpPFqeJsRseAZEwMbif4YewT22YZhpuZFl/7C8wU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WtU5+NpRujlY+k87vMMRQsA4wAAh0xhutlm/bK7ymmRVu+rALTQW+lYQPahhdGsdU
         o7N3CeG75YA9qQHud3RaVN06OQawZXHJ28Y4HU89eTzz8zEVnhjbDbO9gmUa8swhKL
         FpiqMgfwHpgHqY63fXe7LnjriQen7s0RwOLxrMe8=
Subject: Re: [PATCH] mtd: rawnand: denali_dt: remove single anonymous clock
 support
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <bbrezillon@kernel.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
References: <1547539894-12898-1-git-send-email-yamada.masahiro@socionext.com>
 <20190115092229.59e09c2d@xps13>
 <CAK7LNATnfTQXHrXJQp7732-e7hvd8ORcYubyDmz0KHaRXRMDqQ@mail.gmail.com>
 <20190128112007.440046e6@xps13>
 <da2ea926-30e9-c7b9-8b1f-ee65ccc0fb7a@kernel.org>
 <20190131182644.366a54a5@bbrezillon> <20190205141853.4b7ed954@xps13>
From:   Dinh Nguyen <dinguyen@kernel.org>
Openpgp: preference=signencrypt
Autocrypt: addr=dinguyen@kernel.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <ea245b53-59c9-0d7f-f33a-44aa93db99ac@kernel.org>
Date:   Thu, 7 Feb 2019 12:17:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190205141853.4b7ed954@xps13>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/5/19 7:18 AM, Miquel Raynal wrote:
> Hi Dinh,
> 
> Boris Brezillon <bbrezillon@kernel.org> wrote on Thu, 31 Jan 2019
> 18:26:44 +0100:
> 
>> Hi Dinh,
>>
>> On Thu, 31 Jan 2019 11:24:16 -0600
>> Dinh Nguyen <dinguyen@kernel.org> wrote:
>>
>>> On 1/28/19 4:20 AM, Miquel Raynal wrote:  
>>>> Hi Dinh,
>>>>
>>>> Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Wed, 16 Jan
>>>> 2019 10:27:11 +0900:
>>>>     
>>>>> (+CC Dinh Nguyen)
>>>>>
>>>>> On Tue, Jan 15, 2019 at 5:22 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:    
>>>>>>
>>>>>> Hi Masahiro,
>>>>>>
>>>>>> Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Tue, 15 Jan
>>>>>> 2019 17:11:34 +0900:
>>>>>>      
>>>>>>> Commit 6f1fe97bec34 ("mtd: rawnand: denali_dt: add more clocks based
>>>>>>> on IP datasheet") introduced a more correct binding that requires
>>>>>>> three named clocks.
>>>>>>>
>>>>>>> Now that all upstream DT files migrated over to it, remove the single
>>>>>>> anonymous clock support.      
>>>>>>
>>>>>> I would love to do that but I think this is against the "DT backward
>>>>>> compatibility rule".      
>>>>>
>>>>> Yeah, I know this rule, but we break DT binding from time to time.
>>>>>
>>>>>
>>>>>    
>>>>>> Anyway, IIRC it is accepted that this kind of
>>>>>> rule might be broken if decided per the arch-maintainer (in this
>>>>>> case, you I suppose). So if this is really what you want, I'll queue
>>>>>> it.      
>>>>>
>>>>> My platform is fine, but this driver is used by SOCFPGA boards as well.
>>>>>
>>>>> I CCed the SOCFPGA maintainer, Dinh Nguyen.
>>>>>    
>>>>
>>>> Gentle ping on this topic.
>>>>     
>>>
>>> This patch looks fine to be. Feel free to add:
>>>
>>> Tested-by: Dinh Nguyen <dinguyen@kernel.org>  
>>
>> I think Miquel is waiting for an Acked-by to confirm that you're okay
>> breaking backward compat with old DT.
> 
> Yes, I am waiting for your Acked-by.
> 
> 

Acked-by: Dinh Nguyen <dinguyen@kernel.org>

Dinh
