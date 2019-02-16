Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BA6C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 15:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB2F222A3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 15:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTsB3uV3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbfBPPPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 10:15:44 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42846 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbfBPPPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 10:15:43 -0500
Received: by mail-lj1-f196.google.com with SMTP id l7-v6so10799724ljg.9;
        Sat, 16 Feb 2019 07:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wdTsZwTAaPhrPSYQ7SDKMQoj7M1FkPvkbIiKXhOxM1o=;
        b=fTsB3uV3xHqZz9A3cBt/r5vwxdxs4oXujXCiC23mQ4ZTp9ZkQOEHUN7rO0o6ancVh9
         dBeq279h+6PLlQ3/TBnSvhdh84GNxMsZUSDQYsfAJ6PpA6WSbhNbQpRg9v2OLssyaZFV
         FAPykvIJwxRyqb6TuMk0XLnZoAFpVccdmQF3ITvdR8ju+dWk1FBLly2vgeFxk/Rh0zQ5
         ZZtWhKfMgowQpmsmByI6Wsgy0Ji2MqkJzoK2+mIxxDeSXAaMAAcHYJG+Lk5EaYX9o8iU
         VGbe6mF3IXi9bwzxEZXE06N03BdJKzGZc8iIYAHswC8mCrdoe9TJiTCOFXmtvF7z3Bgp
         EhWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wdTsZwTAaPhrPSYQ7SDKMQoj7M1FkPvkbIiKXhOxM1o=;
        b=Sp5WLqriRd7Y9Fm0ZARYKSRfY7qZe3B3VvRQiK9oepY4xHpktAWDsaAeQavmWCXVFN
         J8ZBB76Z9HbnQ8XLzR/uY1X1V/WEOcjQ2sB0ntt83y84ZY/JWQ3AyCl3++QkDoxbxaYo
         BTBoS6ZBGDGilS4ED9bX7jCognq4JOy3rVu8hIUkeFVHF5b6Bi5fPmxH/+Epsdqz3g5Q
         eYZStUdL3xL3/Ci9WosTn7jsUc9q8MlI0KfmJPEaCkU/fN2oAg9kG5GS2kHptaaORjkD
         J6wKkaSTkSwBmeGpV6izyYmNXcg4U7YlJjjD4+3xMiWdgKAeNtOBFwBsJ+37K03llGjz
         dAFg==
X-Gm-Message-State: AHQUAuYXIzX5mEj7mlL9looD/h3PLN0i9494mZOMe5WxtsqZOHNm8N4K
        VArsaMAbvKAfVcFzkHbFUBdn73uzDFA=
X-Google-Smtp-Source: AHgI3IY7YpKG/T9n2PPQdafMl8YMC1f7twBEfDyXT15eGXEM7uukiZTWpEIvigeNDNaYa54ZwZC8UA==
X-Received: by 2002:a2e:4942:: with SMTP id b2-v6mr8241086ljd.168.1550330140849;
        Sat, 16 Feb 2019 07:15:40 -0800 (PST)
Received: from [192.168.10.160] (91-159-62-191.elisa-laajakaista.fi. [91.159.62.191])
        by smtp.gmail.com with ESMTPSA id p14sm2306998lfk.16.2019.02.16.07.15.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Feb 2019 07:15:39 -0800 (PST)
Subject: Re: [RFC PATCH v5 03/12] __wr_after_init: Core and default arch
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Igor Stoppa <igor.stoppa@huawei.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Nadav Amit <nadav.amit@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ahmed Soliman <ahmedsoliman@mena.vt.edu>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1550097697.git.igor.stoppa@huawei.com>
 <b99f0de701e299b9d25ce8cfffa3387b9687f5fc.1550097697.git.igor.stoppa@huawei.com>
 <20190214112849.GM32494@hirez.programming.kicks-ass.net>
 <6e9ec71c-ee75-9b1e-9ff8-a3210030e85d@gmail.com>
 <20190215085736.GO32494@hirez.programming.kicks-ass.net>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <7cfb5d06-96a6-41a0-9f57-d9df1204f45e@gmail.com>
Date:   Sat, 16 Feb 2019 17:15:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190215085736.GO32494@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/02/2019 10:57, Peter Zijlstra wrote:

> Where are the comments and Changelog notes ? How is an arch maintainer
> to be aware of this requirement when adding support for his/her arch?

Yes, it will be fixed in the next revision. I've added comment to the 
core wr_assign function and also to the changelogs for the patches 
enabling it on x86_64 and arm64, respectively.

Should I add mention of it also in the documentation?

--
igor

