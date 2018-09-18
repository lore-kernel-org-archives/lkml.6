Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD43C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C2772146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmixnZaS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C2772146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730395AbeISFAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 01:00:37 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39202 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbeISFAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 01:00:36 -0400
Received: by mail-pf1-f195.google.com with SMTP id j8-v6so1739202pff.6;
        Tue, 18 Sep 2018 16:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D27mXoeHYpKnR002BVsYWxS1k1v6H61tmb7MdMg5AkI=;
        b=WmixnZaSsZMUca4fYjQtj0KQXtMhniG1QMMRTzW49fxeVKXSgV3Zmqt2AOAhdaZ7Nz
         FLoKbQQZ61V/c5bxfDy8BsXbvhyqtRm/DD9Cb+3AccPOQKSbthVLMRKtBVA+5lkYkejX
         6ubzT82unNTveivGFfM+sKXS5rl2nauEgb6ndHDAxAFTpilsxlMuks0/DHYaW5kRSR0d
         GZpLhZwN+/UXYd9ZihqTeyh7QhuH1OSbybqKcsVkcJ641CVI/xxghTQvSWdQOLx5wsPP
         FIGbpd5cAOaK7rCabx18gZL4BelW8L2W7ARfy9eZtL9cb2pR/yPLd4N3g/6EBvOXPsdZ
         pd5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D27mXoeHYpKnR002BVsYWxS1k1v6H61tmb7MdMg5AkI=;
        b=tZhfdAPsIQEMch3ynTWcyhz0PI5wXW2q4VGFps4iWIw9ngHJgUvyLeVSB789YW/B75
         XGQgJYOdUK7udXaiLZ1uejwWJ2eXPo2bu+DZUZotgxn5USvswlcUaapH3aKk68C4vVKV
         WU2X8BEriFQcOfWt1eXEQe3gRYirbaUiNfNMZOgnUmzOUl8thB/hDNgpZ/FYJ0U6PzED
         i79tMkOtqkG8bBgGpmaoEsDmv5uVO/R1CtYRo3NNjc45WdSB8GB+hYS2BseRHa0HP5hC
         BTY9lURh05iS0Gu9oL+dYGODUiJ4S62UzmCkzNY2bkqtAcnwraeYE8+jMh4ziiHSm9+P
         +JVw==
X-Gm-Message-State: APzg51C4eoufKwhH5dK0Iq+/WfSbjdZ38G0qZXTNAdbGXZw6/6SKtxTx
        QrnHT9ZghpNGMVibnGl6ugo=
X-Google-Smtp-Source: ANB0VdbYD/BQe4wNrDC15ET9xgPrnsNjjlq87cLoKeSP0ad3hK+czqsPf6rQcj+eTXDiGgo3sdgmNg==
X-Received: by 2002:a63:7d48:: with SMTP id m8-v6mr30298210pgn.0.1537313141305;
        Tue, 18 Sep 2018 16:25:41 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id m25-v6sm23819021pgn.1.2018.09.18.16.25.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 16:25:40 -0700 (PDT)
Subject: Re: [PATCH] net: apm: xgene: force XGene enet driver to re-balance
 IRQ usage
To:     ahs3@redhat.com, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        David Miller <davem@davemloft.net>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "isubramanian@apm.com" <isubramanian@apm.com>,
        "kchudgar@apm.com" <kchudgar@apm.com>,
        "qnguyen@apm.com" <qnguyen@apm.com>
References: <20180917233533.28626-1-ahs3@redhat.com>
 <20180917.193531.1424852853827678152.davem@davemloft.net>
 <a5adee73-dde7-d00f-e7ef-1f81dc7c813a@amd.com>
 <4929e93d-508a-4670-9450-66e4fc85be7e@redhat.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <32ee17f8-8b89-9d8c-90a6-6d513be6b2b7@gmail.com>
Date:   Tue, 18 Sep 2018 16:25:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <4929e93d-508a-4670-9450-66e4fc85be7e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/18/2018 04:15 PM, Al Stone wrote:
> On 09/18/2018 05:09 PM, Lendacky, Thomas wrote:
>>
>>
>> On 09/17/2018 09:35 PM, David Miller wrote:
>>> From: Al Stone <ahs3@redhat.com>
>>> Date: Mon, 17 Sep 2018 17:35:33 -0600
>>>
>>>> @@ -866,8 +866,11 @@ static int xgene_enet_napi(struct napi_struct *napi, const int budget)
>>>>  	processed = xgene_enet_process_ring(ring, budget);
>>>>  
>>>>  	if (processed != budget) {
>>>> +		struct irq_desc *desc = irq_to_desc(ring->irq);
>>>> +
>>>>  		napi_complete_done(napi, processed);
>>
>> The problem could be that the driver isn't checking the
>> napi_complete_done() return code.  It was changed to return a bool and
>> the check should be more like:
>>
>>   if ((processed != budget) && napi_complete_done(napi, processed)) {
>>
>> If it returns false, then the driver will get called for polling again
>> after having issued enable_irq() and it well then issue the enable_irq()
>> a second (or more) time without having the matching diable_irq().
>>
>> Thanks,
>> Tom
> 
> Aha, that might be.  My apologies -- I play in ACPI but seldom in the network
> drivers, so was not fully aware of that change.  I can give that a try.
> 
> Thanks for the pointer.
> 

Yes, please look at commit d7aba644ffdebf756e51e26a2229055211838e89
("amd-xgbe: Enable IRQs only if napi_complete_done() is true")
