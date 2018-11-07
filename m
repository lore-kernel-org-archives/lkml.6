Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D22C32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D7920827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTPhr6CE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0D7920827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388363AbeKGJvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 04:51:21 -0500
Received: from mail-pl1-f175.google.com ([209.85.214.175]:40909 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730885AbeKGJvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 04:51:20 -0500
Received: by mail-pl1-f175.google.com with SMTP id q19-v6so4006366pll.7;
        Tue, 06 Nov 2018 16:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Dls76p0eWgFvyL0Gd9YyNIfjDQgofUni5koSjPrUFqg=;
        b=ZTPhr6CEfJffRjbE9jr3qmDQEWnMN27lHmGiB7tKpqpPHWnbBK/dM9hnndAFGzDPZT
         DseYtoJklsLzMptNbfTSUc6gKqAA8moLxahjAbHH6OHrLj0Sd5LpwkGm5MzGJGfTllWg
         pRyZdjBCUAIK7Tv0TxayGC0trwGFxd/+abjtJCQ5G3H9q3QFwwpeO7vksz+ykYOjOrAD
         MyNd+CAuzE6QJfWJRwWkxwbgxjZWKlCAkTKaXd6YUd3kB84IxXWhb+l5omfItKmiCENe
         AlFMTTCbgi/zFq6fUmbVRdk9ze1WdojsLt1mYr5LsPbBptohsubw+J1osGp+onK4/ot3
         W1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dls76p0eWgFvyL0Gd9YyNIfjDQgofUni5koSjPrUFqg=;
        b=qUH3im8nADrTY9Gw3TavcjU/kTp7BB6pr0vjittkSVGnhkSNq2+JozfC6jn8YgPmue
         TDdBq3XHLYjtpNeCO+medXZ72duFfzg6Z2wSFYxHWEtSKW8SKBgqXoEP+65EEzcI3aeD
         JdgvUwwV5Tr6CY4RxyX838fwfcG50FRyt39UCsVpkWKMtFxFcQIG8Zhz8PX8dIg68sXc
         nNBweuseEJqPbUuNUg0YT2vzCQiFpIhpDRKeFRg7yjeAZaYmiyNbNu2bZwrlETU9sOqk
         k+dSN2yuMYctlG1nYtgZr0unSpsdLY2UUuxjOrFLnsq1X5Z20nhAnGba4aAUcELfNVoq
         WKhQ==
X-Gm-Message-State: AGRZ1gLn1XJjj55W14zbJj9CUydkCacPgE7/OpZhdq7ikZHUc7yHDMqq
        jc370hZKZluiPs1tJQLmPrk=
X-Google-Smtp-Source: AJdET5eVC3duujqOnNBZWjhsg2oTcIqcRMfieqKuCD2C8V7HUTg8TlZTj1iMtPs1NJbRrSyfy6ztxw==
X-Received: by 2002:a17:902:5590:: with SMTP id g16-v6mr28488280pli.56.1541550208388;
        Tue, 06 Nov 2018 16:23:28 -0800 (PST)
Received: from ?IPv6:2601:280:a:e2f8:c080:1705:befd:aeb0? ([2601:280:a:e2f8:c080:1705:befd:aeb0])
        by smtp.googlemail.com with ESMTPSA id u19-v6sm77370217pfj.115.2018.11.06.16.23.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 16:23:27 -0800 (PST)
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
From:   David Ahern <dsahern@gmail.com>
Message-ID: <0a05a14c-3a79-e894-ae48-cbe1df4feb91@gmail.com>
Date:   Tue, 6 Nov 2018 17:23:25 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <39fe6abc-5c3e-bac3-0c0b-cf68bea23ab0@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/18 5:13 PM, Alexei Starovoitov wrote:
> On 11/6/18 3:36 PM, David Miller wrote:
>> From: Alexei Starovoitov <ast@fb.com>
>> Date: Tue, 6 Nov 2018 23:29:07 +0000
>>
>>> I think concerns with perf overhead from collecting bpf events
>>> are unfounded.
>>> I would prefer for this flag to be on by default.
>>
>> I will sit in userspace looping over bpf load/unload and see how the
>> person trying to monitor something else with perf feels about that.
>>
>> Really, it is inappropriate to turn this on by default, I completely
>> agree with David Ahern.
>>
>> It's hard enough, _AS IS_, for me to fight back all of the bloat that
>> is in perf right now and get it back to being able to handle simple
>> full workloads without dropping events..
> 
> It's a separate perf thread and separate event with its own epoll.
> I don't see how it can affect main event collection.
> Let's put it this way. If it does affect somehow, then yes,
> it should not be on. If it is not, there is no downside to keep it on.
> Typical user expects to type 'perf record' and see everything that
> is happening on the system. Right now short lived bpf programs
> will not be seen. How user suppose to even know when to use the flag?

The default is profiling where perf record collects task events and
periodic samples. So for the default record/report, the bpf load /
unload events are not relevant.

> The only option is to always pass the flag 'just in case'
> which is unnecessary burden.

People who care about an event enable the event collection of the event.
