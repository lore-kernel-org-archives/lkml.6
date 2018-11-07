Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A971C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32ECB20862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glNTkWrI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32ECB20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbeKHDoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 22:44:22 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34307 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbeKHDoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 22:44:21 -0500
Received: by mail-pl1-f196.google.com with SMTP id f12-v6so7030127plo.1;
        Wed, 07 Nov 2018 10:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WJulaHyZTW+3D3nyyBUhImJNKnq+eB6poijbUDSXIco=;
        b=glNTkWrI+TIs8RzbgQiNkFYj9ozMXd8KeAcw2gP1IgvDLBAMTp30kkKKIxFzuzcwSs
         rRAmqPLFFm6zGOAqcXllGgLYiBxtxS4dhoRlv2860a3w0ioo5P5MnB+EQ3s3Ml4YMgU9
         Ko+enxSQy9MSe6na822bvFojY1a1K9PW+3/DWdtuXxyO9hBZ51A61uqe8vAq5am0yOmz
         h++J+lRZcWwE/xo2ztoLjHpFR1hG4TIQ494T+KRyvu14Ccql0yPgbKjSIjIBPdcChCoN
         /+XiOVsvUKxWdbWzyDPiKq7I9zGjq68U3DhSic9a5TMAB8LMU7kdcErhE3KEktS7WyNh
         a9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WJulaHyZTW+3D3nyyBUhImJNKnq+eB6poijbUDSXIco=;
        b=so6dD0CkEunq0R6kJZBaqTRQ92jODWDISfKBqQO0N8WY/7RKL8xcxtUscpOTxSBRb1
         iO5OQLhPq0vdmqwL4CVMIlkAjAH4NKlYcCWT/Ff70N85VPhpFw+8dU4BZVps0vyPFoXH
         E7XYnKxbcrz8ed8tJUB4rmW98be0KMcSsIBplfnu7loYVjIV11cmmxaM1nol9XJdg0qf
         h9Kt0s4Nj4EM6wwzrJhNRdBXj9RNmO/lH4HaoK4pgQAwvyLhWoz0XhoB6vzLxUGhWZ9O
         zB6w2QW4n/AG2mOGwoHd32k3KcB7IW9giH0RE9FPVOE1tYttYWQUTsxcHfM2kwLX3TlI
         H1dg==
X-Gm-Message-State: AGRZ1gKK+krX3kezJAnhf41glkJ/XOpTQLMEpGgOZ1gwRX9JU831ppD1
        WsTLxKHcGJwA3eWbcpJ99sGJjmSs
X-Google-Smtp-Source: AJdET5d1tx/4lG4dBauyM7vcyR6MnanBedWxI/WT0UDIsu7a7kqsLdK7LDq65dP+H0SZ+ZRbF6HtQw==
X-Received: by 2002:a17:902:3a3:: with SMTP id d32-v6mr1240048pld.304.1541614368588;
        Wed, 07 Nov 2018 10:12:48 -0800 (PST)
Received: from ?IPv6:2601:282:800:fd80:b9ef:3cc7:d955:8635? ([2601:282:800:fd80:b9ef:3cc7:d955:8635])
        by smtp.googlemail.com with ESMTPSA id c127-v6sm1401935pfa.31.2018.11.07.10.12.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 10:12:47 -0800 (PST)
Subject: Re: [RFC perf,bpf 5/5] perf util: generate bpf_prog_info_event for
 short living bpf programs
To:     Alexei Starovoitov <ast@fb.com>, David Ahern <dsahern@gmail.com>,
        David Miller <davem@davemloft.net>
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
 <7d0b100b-a64b-0d30-8ec0-2689ef44423d@gmail.com>
 <edda462f-a32c-bc25-94c8-8d06a47bd480@fb.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <c1355a46-77b7-f340-855e-6237b223e43a@gmail.com>
Date:   Wed, 7 Nov 2018 11:12:45 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <edda462f-a32c-bc25-94c8-8d06a47bd480@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/18 6:09 PM, Alexei Starovoitov wrote:
> On 11/6/18 4:44 PM, David Ahern wrote:
>>
>> So one use case is profiling bpf programs. I was also considering the
>> auditing discussion from some weeks ago which I thought the events are
>> also targeting.
> 
> yes. there should be separate mode for 're: audit discussion' where
> only bpf events are collected. This patch set doesn't add that to
> perf user space side.
> The kernel side is common though. It can be used for bpf load/unload
> only and for different use case in this set. Which is making
> bpf program appear in normal 'perf report'.

It would be good for perf-script to work in the next version. Users
should be able to dump the event from the kernel and the synthesized
events. Should be trivial to add and allows a review of both
perspectives -- profiling and monitoring events.
