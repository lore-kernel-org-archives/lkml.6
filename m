Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7697DECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CEFB20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vBSeXOJL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CEFB20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388440AbeGXQyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:54:50 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:46413 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388321AbeGXQyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:54:49 -0400
Received: by mail-qk0-f195.google.com with SMTP id o2-v6so2898849qkc.13;
        Tue, 24 Jul 2018 08:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6J8LFw4+U18ZvMEM7u1zDKwmb/5T0ZqyeUvPFIZQP1w=;
        b=vBSeXOJLkTUM5kuf46HmBrd4UBry7aIaBbvg7WqxJ/oD7TU30I9Ijc+GAg2H1LavK+
         vxAILAeywRfrEvJSGA33u+k0KLVpdUvDN0yRDqKg1IC6oSHg+NV7cuTAfyWybpYo3CmU
         Dgh5Pqnu8G2S9w5bGYT22j9qUp/Hs4EO8tMWn8qM7IFT5lwrslNSncfe2NJTm5fhFprV
         G2re575fjrsGanF5t6+sg8GIIXD60HYbF3TxS0OoxuzOvHyBEIXd+Ug1ng8rTqgvwBj3
         g0yKYAFZkwbA3OHNwKHkfZB93kE4lLI0eJEkKVVWur6ghzGUh2PmntWGUkbTM+c7RmNB
         kQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6J8LFw4+U18ZvMEM7u1zDKwmb/5T0ZqyeUvPFIZQP1w=;
        b=ZKUDv9StAoynCmKikqU25J/4o/UDMNhedN2mHvZ6c39mJqTiBxkh0aeBEZe/J1qHdV
         ofY1ZfaDAx8q75gO884aWqMtzdzaFICTYv/1gxTbNDVVd5xwi9bvQN9xZQfMUSR0N6jh
         JnjP8qXEzHa+8cZppt9ViL7HHi9hejGTzc9LG9E4n3hQBQ8ZhtiEgYGeXvKmL5Kbdtes
         9cLBR++ybORQAe2/M0AWB68JCPSM7SU3JxVe6/QqzBouzJaJhse0lfRSjKxk2ecNphtM
         uQdfvfdfK6bNxKbjWbl7tnRVJB6DCFU9EF8KUDA3slmhQIkSzrbfyyKDa6tR4h2E9dOK
         k+kQ==
X-Gm-Message-State: AOUpUlHxuB2nfNGxHdQbbvy+QdCJsGPYnyLnKW3Kq+kzQ2O/LFOLffR9
        x3UXdsNash7Xv99sJh/d32hedsSQD00=
X-Google-Smtp-Source: AAOMgpfNoMtlQni/oVfhT1of5mtnSozjH9sbJUVm7kUyoR9LtuOq82YxXg7Vuxg3JIbKwzaS2hAHiQ==
X-Received: by 2002:a37:32cd:: with SMTP id y196-v6mr16321404qky.411.1532447263284;
        Tue, 24 Jul 2018 08:47:43 -0700 (PDT)
Received: from [192.168.44.96] (180.sub-174-226-6.myvzw.com. [174.226.6.180])
        by smtp.gmail.com with ESMTPSA id f64-v6sm14498461qkf.2.2018.07.24.08.47.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 08:47:42 -0700 (PDT)
Subject: Re: [PATCH 00/15] ARM: dts: tegra: apalis-tk1: major revamp
To:     Dmitry Osipenko <digetx@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "mperttunen@nvidia.com" <mperttunen@nvidia.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20180724104309.21741-1-marcel@ziswiler.com>
 <2076484.gx54F3eiOq@dimapc> <1532443499.6124.31.camel@toradex.com>
 <4715215.NZcU7pUVUy@dimapc>
From:   Peter Geis <pgwipeout@gmail.com>
Message-ID: <79afd852-af93-dfa1-0d65-11be7507f81f@gmail.com>
Date:   Tue, 24 Jul 2018 11:47:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <4715215.NZcU7pUVUy@dimapc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/24/2018 10:48 AM, Dmitry Osipenko wrote:
> On Tuesday, 24 July 2018 17:45:01 MSK Marcel Ziswiler wrote:
>> On Tue, 2018-07-24 at 17:31 +0300, Dmitry Osipenko wrote:
>>
>>> On Tuesday, 24 July 2018 17:16:33 MSK Marcel Ziswiler wrote:
>>>
>>>> On Tue, 2018-07-24 at 15:44 +0300, Dmitry Osipenko wrote:
>>>>
>>>>
>>>>> On Tuesday, 24 July 2018 15:24:34 MSK Marcel Ziswiler wrote:
>>>>>
>>>>>
>>>>>> Sorry, I meant to write "minor revamp" in the subject line here
>>>>>> as
>>>>>> Apalis TK1 was already in quite good a shape but this are still
>>>>>> some
>>>>>> worthy improvements (;-p).
>>>>>>
>>>>>> On Tue, 2018-07-24 at 12:42 +0200, Marcel Ziswiler wrote:
>>>>>>
>>>>>
>>>>>
>>>>>
>>>>> Marcel,
>>>>>
>>>>> All your emails that are sent from "toradex.com" are treated as
>>>>> spam
>>>>> by Gmail
>>>>> because "This message has a from address in toradex.com but has
>>>>> failed
>>>>> toradex.com's required tests for authentication.", is there
>>>>> anything
>>>>> you could
>>>>> do to fix that?
>>>>
>>>>
>>>>
>>>> Hi Dmitry
>>>>
>>>> Hm, unfortunately, Toradex was an M$ only shop when I joined more
>>>> then
>>>> 7 years ago and so far I was unable to convince our IT to switch to
>>>> some grown up email system. Therefore, I am stuck with Exchange,
>>>> Office
>>>> 365 or whatever M$ nowadays seem to call it. Anyway, I really
>>>> thought
>>>> sending from Android or Evolution via their resp. Exchange
>>>> connectors
>>>> would properly do SPF, DKIM and even DMARC. I just confirmed this
>>>> when
>>>> sending something to my gmail address and doing "Show original".
>>>>
>>>> Since Linus himself pointed out any of my patches ending up in his
>>>> spam
>>>> folder I do send them via my private email which while not having
>>>> any
>>>> advanced security configured should still be valid. Moving it to a
>>>> fully secure configuration including DNSSEC and stuff is still
>>>> pending
>>>> on my side.
>>>>
>>>> Can you please tell me which exact email it is that you got this
>>>> reported on so I may further investigate what is going on?
>>>
>>>
>>> This email from you looks okay. Unfortunately all of your previous
>>> emails from
>>> "toradex.com" were getting into the spam folder.
>>
>>
>> You sure they were from "toradex.com"? The patches should have been
>> coming from "ziswiler.com" resp. "perfora.net".
> 
> The patches from "ziswiler.com" are fine, only your emails specifically from
> "toradex.com" had an issue. Looks like you've resolved it now.
> 

Dmitry,
Gmail normally suspends flagging emails as spam from addresses you 
respond to.
It may pick up again though, so I would add toradex.com to your allow list.


> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
