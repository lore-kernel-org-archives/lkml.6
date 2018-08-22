Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E07C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 20:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AE4820936
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 20:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVkpNC7n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AE4820936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbeHVXsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 19:48:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45129 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbeHVXsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 19:48:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id 20-v6so2631422wrb.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 13:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t5uPrUDmNlK04MQOuJY0LHy/NNtg3cNiuXD4u9yAW4E=;
        b=nVkpNC7n7/EC/CGbfRyOzF2N7hnPMcYSgfvHlUY2IsiY0QmHMskY5F71be4TL/AG/t
         ZxrIsUs7WpuMFRpuzDUYgQAgVJW8PC/QzMsGmtF1NKQcrMpRMYB8di1RW5USF8ypqtTC
         CYF4P86AdD42GrNMiQmLk3ekH6w8/k6H31Fkrl1nVu8Oa2B3xUzkXcvUuXQ3qGz0nUUq
         3sTgtrnmBYnOWc3ignbAXJ8RQIxvOTdIP9RTEIMRG7dFtOOBubzBpv+9rNrMYrFVBbfu
         5slFDLnVvX/SVmaAJsev6ziDVHwiigQvLETFgje5g9A4h1CB+rGK2vCJYo5O74zq0sEd
         DfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t5uPrUDmNlK04MQOuJY0LHy/NNtg3cNiuXD4u9yAW4E=;
        b=UT/K70DpUKfLKpN5lAxVVh+m72R7QCTvWHCLTXFgg9uTDwv1e4Xl5E+Os6NYnRAfOP
         YvpnOl9k9f5DJcN736Y5x43LzBSm5G64a9TwKSSRlZ30TXuBQqu8TK+YgpSKOEkF6yTq
         /qpNhmwZoChFd2mhJdxWT+f5lChnpGxpAPNUk3iqdMRfISBQ+Ob1bnM1qWqKlMr0Xtco
         U8mJFJUl3nZ+detuG2vc9XsfLPjObnVeOBo8yh/kEEDNz8WJ/PAI1R5v6Vih+zsW76JE
         gz3XqgIdYF33uqNKNi7gcJydAUCUf5/TktCi/r5Q6gitjc5m9axvxdFkG7L9KFXdblIy
         Gf5w==
X-Gm-Message-State: AOUpUlHeSJ/sIcADIBUHtJm6naxtgRbPaNEyJkF5CsL5lhexI56v4wel
        +IWisMtKZQHYEermtSxTMWg=
X-Google-Smtp-Source: AA+uWPzlz21juBLaO/swmQiVTGxKFvbroyXQMsKkoAa7Q9WKizjNJrI565JhgYbGjGBBGagrxEol1g==
X-Received: by 2002:a5d:6a92:: with SMTP id s18-v6mr36672641wru.44.1534969301508;
        Wed, 22 Aug 2018 13:21:41 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-107-50.net.upcbroadband.cz. [86.49.107.50])
        by smtp.gmail.com with ESMTPSA id n7-v6sm642138wmc.2.2018.08.22.13.21.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 13:21:40 -0700 (PDT)
Subject: Re: [PATCH] ARM: spectre-v2: Try to set IBE bit for Cortex-A15 and
 Brahma-B15
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Luca Scalabrino <luca.scalabrino@arm.com>, marc.zyngier@arm.com,
        Russell King <linux@armlinux.org.uk>,
        open list <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <20180607225804.28771-1-f.fainelli@gmail.com>
 <e4db9ef9-398f-114a-b5a8-8d8de0b0f85e@gmail.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <3698a520-00cd-f904-a031-a7d6f22c8885@gmail.com>
Date:   Wed, 22 Aug 2018 22:21:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <e4db9ef9-398f-114a-b5a8-8d8de0b0f85e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2018 03:58 PM, Marek Vasut wrote:
> On 06/08/2018 12:58 AM, Florian Fainelli wrote:
>> Per the ARM reference manual for the Cortex-A15, The ACTLR:
>>
>>  Is a read/write register.
>>
>>  Common to the Secure and Non-secure states.
>>
>>  Is only accessible from PL1 or higher, with access rights that depend
>>  on the mode:
>>
>>     * Read/write in Secure PL1 modes.
>>
>>     * Read-only and write-ignored in Non-secure PL1 and PL2 modes
>>       if NSACR.NS_SMP is 0.
>>
>>     * Read/write in Non-secure PL1 and PL2 modes if NSACR.NS_SMP
>>       is 1. In this case, all bits are write-ignored except for the SMP bit.
>>
>> We can attempt to set this bit from within the kernel, which helps
>> avoiding firmware side modifications to set the IBE bit when that is
>> impractical. We do this within __v7_ca15mp_setup and __v7_b15mp_setup
>> because by then we already took those labels because the processors we
>> run on do match.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> I believe this would help on selected R-Car Gen2 SoCs which have CA15
> cores. Those cores are released from reset by Linux directly and jump to
> the reset vector set up by Linux in Secure mode.
> 
> I was looking for a generic solution after discussing how to mitigate
> the spectrev2 on such SoCs with Catalin on IRC and this seems to be one
> option. There was also a suggestion that Russell is working on some sort
> of generic solution too. Can you comment on that please ?

Is there any feedback on this ?

>> ---
>>  arch/arm/mm/proc-v7.S | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
>> index 6fe52819e014..a21cf3729efa 100644
>> --- a/arch/arm/mm/proc-v7.S
>> +++ b/arch/arm/mm/proc-v7.S
>> @@ -284,10 +284,16 @@ __v7_cr8mp_setup:
>>  	b	1f
>>  __v7_ca7mp_setup:
>>  __v7_ca12mp_setup:
>> +	b	2f
>>  __v7_ca15mp_setup:
>>  __v7_b15mp_setup:
>> +#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
>> +	mrc	p15, 0, r0, c1, c0, 1
>> +	orr	r0, r0, #1			@ Enable IBE bit
>> +	mcr	p15, 0, r0, c1, c0, 1
>> +#endif
>>  __v7_ca17mp_setup:
>> -	mov	r10, #0
>> +2:	mov	r10, #0
>>  1:	adr	r0, __v7_setup_stack_ptr
>>  	ldr	r12, [r0]
>>  	add	r12, r12, r0			@ the local stack
>>
> 
> 


-- 
Best regards,
Marek Vasut
