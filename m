Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A425FC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 532B424069
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="ev/SoUK2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 532B424069
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932963AbeFVKjW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 06:39:22 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:45277 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754297AbeFVKjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 06:39:16 -0400
Received: by mail-ed1-f53.google.com with SMTP id i16-v6so946437eds.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 03:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ngHdYxqET2TOjuHKvH0Nzgp2oqx/d2AwESfxdE4iBJs=;
        b=ev/SoUK2pciUqkMMEpou76mfIf39rLFoEKfW1ffS4bky036DGjn1GxozypZhAdALsW
         ERzONxe2N9hFN3o0g2gCTJyxjqaEP9HkSJGhEnKwpaEV53cBAIV/bLj+hlk+GYsObHfC
         SxInRLWaqBEiKXWXWKy5CyTrFkoo5avu5CHn0nKQOW+EIh2QZud2ts7VAZSRqUictvGe
         py+Tr4Q7r1q61bWOAVSIE4xlYf/F/SZrt1d7TwWzf3ZwPRdhDmhVuOUHXXP9bi0Dbz8t
         IBeGqiPjXEhHmUcsOPGIJuQKhetaNxMMLQSZ9zQEZyD0OJutYJclX6lmBDmjfk9JBIB8
         7zVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ngHdYxqET2TOjuHKvH0Nzgp2oqx/d2AwESfxdE4iBJs=;
        b=OhQRGWn2mFUF6ml9F8Ps/267F5X40BkPeFMve7QnxTR3G1we6FgpFW87unzQkHuKiE
         u2kJReRT8nH9kahXgQEdKqTZWpY1p/QhQbebiVUFF3eVrO8th3rEtDOhaUidgG4SUsha
         G7+4hWUq+fpdXpXWyQlK5iqXiyTAryVHGiEOR3l7sqJMYXxEd5HUBCaLn39wGuGMtI8K
         n1QqOi6Uw50yc016UXDudgKdLGqQ1EkxP7I3fLILHctkr8iWQn+gZ+VgW/JEKrnyRuBA
         iLAESKasGy4d09ltIlVOyPxh1zZr0vlg1GSJYKjEkOiQVHaER/i05DJTGrBETjv1DFsE
         15NA==
X-Gm-Message-State: APt69E10A+5DZnQ6mBwO0nW+zKEk2beGYuHwypgL1s6enuLPlJYA6bM9
        MkWodRv5CNyoCnwTupFzVgWKgXmK
X-Google-Smtp-Source: ADUXVKK4rlVmysHKeeI9P3jtOIaZQZEAH8x/c5RJsbTUnogRFPKjrDcj7jbwgQtF8hKe5Yrc8fPz/g==
X-Received: by 2002:a50:ace6:: with SMTP id x93-v6mr1391321edc.209.1529663955261;
        Fri, 22 Jun 2018 03:39:15 -0700 (PDT)
Received: from [172.20.1.93] (host-79-78-33-110.static.as9105.net. [79.78.33.110])
        by smtp.gmail.com with ESMTPSA id n30-v6sm3171740edd.36.2018.06.22.03.39.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 03:39:14 -0700 (PDT)
Subject: Re: [PATCH bpf-next 2/3] bpf: btf: add btf json print functionality
To:     Okash Khawaja <osk@fb.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
References: <20180620203051.223156973@fb.com>
 <20180620203703.101156292@fb.com>
 <3db6047a-101a-2ed1-9ca3-9e90b45ea00f@netronome.com>
 <20180622102428.GA3050@w1t1fb>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quentin.monnet@netronome.com; prefer-encrypt=mutual; keydata=
 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
 RHhSHGnKaQ6MfrTge5Q0h5A=
Message-ID: <a598aea7-e967-1779-5092-937565a69c0b@netronome.com>
Date:   Fri, 22 Jun 2018 11:39:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180622102428.GA3050@w1t1fb>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-22 11:24 UTC+0100 ~ Okash Khawaja <osk@fb.com>
> On Thu, Jun 21, 2018 at 11:42:59AM +0100, Quentin Monnet wrote:
>> Hi Okash,
> hi and sorry about delay in responding. the email got routed to
> incorrect folder.
>>
>> 2018-06-20 13:30 UTC-0700 ~ Okash Khawaja <osk@fb.com>
>>> This consumes functionality exported in the previous patch. It does the
>>> main job of printing with BTF data. This is used in the following patch
>>> to provide a more readable output of a map's dump. It relies on
>>> json_writer to do json printing. Below is sample output where map keys
>>> are ints and values are of type struct A:
>>>
>>> typedef int int_type;
>>> enum E {
>>>         E0,
>>>         E1,
>>> };
>>>
>>> struct B {
>>>         int x;
>>>         int y;
>>> };
>>>
>>> struct A {
>>>         int m;
>>>         unsigned long long n;
>>>         char o;
>>>         int p[8];
>>>         int q[4][8];
>>>         enum E r;
>>>         void *s;
>>>         struct B t;
>>>         const int u;
>>>         int_type v;
>>>         unsigned int w1: 3;
>>>         unsigned int w2: 3;
>>> };
>>>
>>> $ sudo bpftool map dump -p id 14
>>> [{
>>>         "key": 0
>>>     },{
>>>         "value": {
>>>             "m": 1,
>>>             "n": 2,
>>>             "o": "c",
>>>             "p": [15,16,17,18,15,16,17,18
>>>             ],
>>>             "q": [[25,26,27,28,25,26,27,28
>>>                 ],[35,36,37,38,35,36,37,38
>>>                 ],[45,46,47,48,45,46,47,48
>>>                 ],[55,56,57,58,55,56,57,58
>>>                 ]
>>>             ],
>>>             "r": 1,
>>>             "s": 0x7ffff6f70568,
>>
>> Hexadecimal values, without quotes, are not valid JSON. Please stick to
>> decimal values.
> ah sorry, i used a buggy json validator. this should be a quick fix.
> which would be better:  pointers be output hex strings or integers?

I would go for integers. Although this is harder to read for humans, it
is easier to process for machines, which remain the primary targets for
JSON output.

Quentin
