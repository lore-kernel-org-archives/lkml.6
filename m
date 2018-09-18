Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0885EECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E6562146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QL7Gq4Fq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E6562146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730456AbeISFC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 01:02:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35338 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbeISFC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 01:02:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id p12-v6so1749355pfh.2;
        Tue, 18 Sep 2018 16:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BpGSiAICmIavRhhMn7mZEwLTU1xruMCg7GgldrWCXSc=;
        b=QL7Gq4FqMrbMDnonX2nTG64iOA8lr780brgGcIvoZJ1V0rbrZCm2M5VfmGd5W59YVy
         l1YTz9YcgrqOOLtPflDyOwifzmEHgYBK+4YohDIg1iBJh2v2mB/5yAIwpjI33ZXSkdhV
         byaNsUE9/9YtZ1AaC1w7soRbHiGOP2uWfumNg1dQpTguQgKJp3YhMI4E4r3GJtHxt85O
         lLje4kNdEPMJjilUDe9T9IyMNBdA09YhnUWKoD15Qufd3EpmwbAZbbQ+kCFoqqRh275l
         wmp9GcEttCpcZZBhIARSh3gPmK25qdrdzJEqn5Dn7qcwzao18TbH4EubKzb1Ktz6aq3e
         7+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BpGSiAICmIavRhhMn7mZEwLTU1xruMCg7GgldrWCXSc=;
        b=iWNMdP45dNv8Lac2gG3XLfOQsl6kUDfRFdcWquh2HVaE9D2JCEMRO4WL6jOgBLrufC
         lExHG3cLVvwvxh4zNB2jTOKPlm1kiGbHZHijzo9t5v38Fx07rKM+ZvbPAuyMn1HN2raX
         kZnKM1zxc30sqeOq0cny5vwhSXUu+E1sVoep+9RpsSku/GIU6/WldqrNMcabRXvyoZYK
         1Ws/Yx8LkcgbFXcqpclBAkdyyCcSW7jYx2befFI8iQ9X2B8bj5/EtqYuDQF53GEZnE/m
         YB9KEH5NSqm1Ojkc2yVz8b+Do2/dXr09GR3BIjst1O94r1QrSKIEDWkDg//ZDhhoNlsJ
         vHow==
X-Gm-Message-State: APzg51CqMlVta2MF0oGqJDVYrctqfl+UqxEMqzhuB14LG0XD7at9ekM1
        k3LDA+zO6+sNhLp9EKOVhnk=
X-Google-Smtp-Source: ANB0VdbdO8P5Z049LJ+t+4yeImk3Pw+knpX/pnMb1zFJ2g5CUffngVInKbq2jgDhUzubCRx5xBWFVA==
X-Received: by 2002:a62:3241:: with SMTP id y62-v6mr33057401pfy.4.1537313250481;
        Tue, 18 Sep 2018 16:27:30 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id z22-v6sm26992542pgc.67.2018.09.18.16.27.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 16:27:29 -0700 (PDT)
Subject: Re: [PATCH] net: apm: xgene: force XGene enet driver to re-balance
 IRQ usage
To:     Florian Fainelli <f.fainelli@gmail.com>, ahs3@redhat.com,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
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
 <cdb8a00c-a3bf-72e0-38b2-3c4b2427270a@gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <c32598b4-3f80-f83f-9b86-1c168752d1e2@gmail.com>
Date:   Tue, 18 Sep 2018 16:27:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <cdb8a00c-a3bf-72e0-38b2-3c4b2427270a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/18/2018 04:21 PM, Florian Fainelli wrote:
> On 09/18/2018 04:15 PM, Al Stone wrote:
>> On 09/18/2018 05:09 PM, Lendacky, Thomas wrote:
>>>
>>>
>>> On 09/17/2018 09:35 PM, David Miller wrote:
>>>> From: Al Stone <ahs3@redhat.com>
>>>> Date: Mon, 17 Sep 2018 17:35:33 -0600
>>>>
>>>>> @@ -866,8 +866,11 @@ static int xgene_enet_napi(struct napi_struct *napi, const int budget)
>>>>>  	processed = xgene_enet_process_ring(ring, budget);
>>>>>  
>>>>>  	if (processed != budget) {
>>>>> +		struct irq_desc *desc = irq_to_desc(ring->irq);
>>>>> +
>>>>>  		napi_complete_done(napi, processed);
>>>
>>> The problem could be that the driver isn't checking the
>>> napi_complete_done() return code.  It was changed to return a bool and
>>> the check should be more like:
>>>
>>>   if ((processed != budget) && napi_complete_done(napi, processed)) {
>>>
>>> If it returns false, then the driver will get called for polling again
>>> after having issued enable_irq() and it well then issue the enable_irq()
>>> a second (or more) time without having the matching diable_irq().
>>>
>>> Thanks,
>>> Tom
>>
>> Aha, that might be.  My apologies -- I play in ACPI but seldom in the network
>> drivers, so was not fully aware of that change.  I can give that a try.
>>
>> Thanks for the pointer.
> 
> FWIW this is being discussed in this thread as well:
> 
> https://www.spinics.net/lists/netdev/msg523760.html
> 
> there should be an update to drivers that have a ndo_poll_controller()
> and don't check napi_complete_done(), though I am not clear who is doing
> that yet.

That might be tricky.

I remember one of the napi_complete_done() change had to be reverted,
for some obscure reason.

So clearly, doing a mass update (without being able to test the driver on real hardware) might be risky.


