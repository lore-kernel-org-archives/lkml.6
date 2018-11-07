Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7719BC32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 300C620844
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZSJwnC3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 300C620844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388886AbeKGKMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 05:12:33 -0500
Received: from mail-pg1-f176.google.com ([209.85.215.176]:34363 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388515AbeKGKMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 05:12:33 -0500
Received: by mail-pg1-f176.google.com with SMTP id k1-v6so6590192pgq.1;
        Tue, 06 Nov 2018 16:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eOsyCb+7b3NbXf5l9+0ygB2zfudPiLkUWEMF/EXtl1w=;
        b=kZSJwnC3fHMb9vceiNHTA64KeTpYeXk96oDNEmVhhwudt+pcV+4bdygg5QpalVbiiO
         1c7T6i67f5mVuhu+YyiHxCwpdQ8vijp8rkyDXFp2ySI/7JRWPooVsrphjswUb+0cPA4y
         vG5bGA2ujUNz5Gr83YTaEaV1hOsiAFOv1JRRoPM1ImqoDq59nqF/CvcXDq2PTCbuiOg7
         NkWIqsjtg7DFIamIiWHcLMqnp9c/LCNSt736cMoAmUHLB8JgO3kvE16zxNQ+LDRg8P0X
         1x6bS1ADZ5bHJ0jgdyFJc+84DjqczpcP0rwF82kfeEdtv+o4bi9GABuSmkYxZRgZdcn4
         woLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eOsyCb+7b3NbXf5l9+0ygB2zfudPiLkUWEMF/EXtl1w=;
        b=gdHmyqchMXb66KExksY7VroYdRjW29eLw+nehiTCA0X0Es0QDpwyMva3IynE3XCxOa
         b/9+pEf6pZiglEJDRxaQx0GrN7qYN7P5GxwHdg80GGjPgXDPnzjfcF686519DEJqVRbh
         aGoWKcVEOirw6si1t6UM6J8suo6u3WK4h2w1WCyAwoGmgoagY8c3D57XInviHC9tt86s
         1OXYzfGAHczgNGF1XECCD/wNEm9aa4I2OnClRguhAuAJfECQMafS5+MqLEjTYBhgzeke
         vd6XsDCegHV2lK8d/UQMbL1Mnj9zA8MordSTxbC7BH/sGymVJP2yZXkfc5eKNh7/HTTc
         kF+g==
X-Gm-Message-State: AGRZ1gK3tQ+9PyNzCQ9Ypmzcn+zTzUiDA0bB62o3khhbhKz5uSoWZZa8
        K/bSAkIvzcM1oWG0+GD7hH0=
X-Google-Smtp-Source: AJdET5faTe06676HubCFOuXfQLVGtuVF2wbMyZjru+mrxn01HdpUA+Qb7N/LCXn/xI3F4HbI3FnEVw==
X-Received: by 2002:a63:65c7:: with SMTP id z190mr25765093pgb.249.1541551475481;
        Tue, 06 Nov 2018 16:44:35 -0800 (PST)
Received: from [172.27.227.138] ([216.129.126.118])
        by smtp.googlemail.com with ESMTPSA id j186-v6sm14670867pfg.117.2018.11.06.16.44.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 16:44:34 -0800 (PST)
Subject: Re: [RFC perf,bpf 5/5] perf util: generate bpf_prog_info_event for
 short living bpf programs
To:     Alexei Starovoitov <ast@fb.com>, David Miller <davem@davemloft.net>
Cc:     Song Liu <songliubraving@fb.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "acme@kernel.org" <acme@kernel.org>
References: <b984776a-ce69-ab16-ed87-1cea89c9d79a@gmail.com>
 <6C5A9FBD-F50D-444C-9038-E9557EC850D2@fb.com>
 <27fc8327-3390-ba5a-6063-89c9e7165e7b@fb.com>
 <20181106.153647.1701013551426767213.davem@davemloft.net>
 <39fe6abc-5c3e-bac3-0c0b-cf68bea23ab0@fb.com>
 <0a05a14c-3a79-e894-ae48-cbe1df4feb91@gmail.com>
 <82745121-339e-2751-c9db-d1fca02d0b33@fb.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <7d0b100b-a64b-0d30-8ec0-2689ef44423d@gmail.com>
Date:   Tue, 6 Nov 2018 17:44:13 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <82745121-339e-2751-c9db-d1fca02d0b33@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/18 5:26 PM, Alexei Starovoitov wrote:
> On 11/6/18 4:23 PM, David Ahern wrote:
>> On 11/6/18 5:13 PM, Alexei Starovoitov wrote:
>>> On 11/6/18 3:36 PM, David Miller wrote:
>>>> From: Alexei Starovoitov <ast@fb.com>
>>>> Date: Tue, 6 Nov 2018 23:29:07 +0000
>>>>
>>>>> I think concerns with perf overhead from collecting bpf events
>>>>> are unfounded.
>>>>> I would prefer for this flag to be on by default.
>>>>
>>>> I will sit in userspace looping over bpf load/unload and see how the
>>>> person trying to monitor something else with perf feels about that.
>>>>
>>>> Really, it is inappropriate to turn this on by default, I completely
>>>> agree with David Ahern.
>>>>
>>>> It's hard enough, _AS IS_, for me to fight back all of the bloat that
>>>> is in perf right now and get it back to being able to handle simple
>>>> full workloads without dropping events..
>>>
>>> It's a separate perf thread and separate event with its own epoll.
>>> I don't see how it can affect main event collection.
>>> Let's put it this way. If it does affect somehow, then yes,
>>> it should not be on. If it is not, there is no downside to keep it on.
>>> Typical user expects to type 'perf record' and see everything that
>>> is happening on the system. Right now short lived bpf programs
>>> will not be seen. How user suppose to even know when to use the flag?
>>
>> The default is profiling where perf record collects task events and
>> periodic samples. So for the default record/report, the bpf load /
>> unload events are not relevant.
> 
> Exactly the opposite.
> It's for default 'perf record' collection of periodic samples.
> It can be off for -e collection. That's easy.
> 

So one use case is profiling bpf programs. I was also considering the
auditing discussion from some weeks ago which I thought the events are
also targeting.

As for the overhead, I did not see a separate thread getting spun off
for the bpf events, so the events are processed inline for this RFC set.
