Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608A4C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B3C820869
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvNK6CdX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbeLSWuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 17:50:23 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42688 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728355AbeLSWuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 17:50:21 -0500
Received: by mail-lj1-f194.google.com with SMTP id l15-v6so18828244lja.9;
        Wed, 19 Dec 2018 14:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lL6VuU05xhyZZNNjsDLIZB0TivGZQe3e6R0urwV27nc=;
        b=KvNK6CdXLsyM/6Upw6RorgzC448kKDKTro0RKfuSdwzdxisa1b8Z1mxNBOypG/c4o2
         7naXbC9MJKaEtLLK7gw3+XYZdN1FndRbB/G7vyrgsIWwxU94/Ul9ojU84c7X2AlSC2aV
         Fdn6IU8gjEnttnQuoyRU1v9h5WndOX7XA+YtPF3zSaJQUI2sEiUsQczxN4PcHp3kZLCU
         DrqEoLlWeonCVNNEmZdyoF8URbG/luEfkzYU9q3GRIdR/k3/wUO3vcMZLy7Tt2dQLMdK
         3WuUyNDdwIog9l2YHhdGtExamWVtCXowuizQ9lqn3QVS0WZEdlQXbH8zeYJV2DdNTysB
         anKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lL6VuU05xhyZZNNjsDLIZB0TivGZQe3e6R0urwV27nc=;
        b=Tm7ErUGCU+EuO8/+XHFgxpBGMI8hWuSOD/t2Xd2ZYuAHYnXSOqdDF1xvDysyaY4dvu
         QUpe0sC2OyMln+BM5MYeR39aiBW9Pj0uhpVrZTF+hQJxY5DB4V1B9y9vCwoJ+nloGlYJ
         ZPC4yqq7KuSxo0lDEBTriZNeVDjPWinGOufavD0EvvWuRM0oEY6yFfhuWYbchz20nI7P
         ABvV0IUV8JYcPB95Rfvif/CodwMErqW+uFpplFCEUvQTYBUMi1js9+E1xsHJJ7hru1W2
         VGxpBnZKu4nB7ZcD1KJerXk69ICFHwmNVGbaol+cobpayrEKECd7x/3UWZ5Lp+rYFUgq
         guoQ==
X-Gm-Message-State: AA+aEWYm1ykjJwl+PbeG+HFvXK52WhPXAND1ba6cYMECY0DkGH8jQr+q
        eqqCCavYNYZTra4Rmsmt9o4vZ884ihA=
X-Google-Smtp-Source: AFSGD/W+aF0CzMAEbw0L4ujsDio5pqmdz8rplfxqdUnX55t16gKI9pqeN3fOqZvahbsqUH3wE5dM+w==
X-Received: by 2002:a2e:9603:: with SMTP id v3-v6mr11660171ljh.15.1545259818062;
        Wed, 19 Dec 2018 14:50:18 -0800 (PST)
Received: from ?IPv6:2001:14bb:51:a4c8:5c24:24d7:ca5f:e7d2? (dmhwpt3bffxn8z3-j6k-4.rev.dnainternet.fi. [2001:14bb:51:a4c8:5c24:24d7:ca5f:e7d2])
        by smtp.gmail.com with ESMTPSA id h203sm4063348lfe.44.2018.12.19.14.50.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 14:50:17 -0800 (PST)
Subject: Re: [PATCH 2/6] __wr_after_init: write rare for static allocation
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20181204121805.4621-1-igor.stoppa@huawei.com>
 <20181204121805.4621-3-igor.stoppa@huawei.com>
 <CALCETrVvoui0vksdt0Y9rdGL5ipEn_FtSXVVUFdH03ZC93cy_A@mail.gmail.com>
 <20181212104900.0af52c34@mschwideX1>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <cff2bb8d-bd61-c4a0-4e63-4de2133a7b38@gmail.com>
Date:   Thu, 20 Dec 2018 00:50:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181212104900.0af52c34@mschwideX1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/12/2018 11:49, Martin Schwidefsky wrote:
> On Wed, 5 Dec 2018 15:13:56 -0800
> Andy Lutomirski <luto@kernel.org> wrote:

>> Hi s390 and powerpc people: it would be nice if this generic
>> implementation *worked* on your architectures and that it will allow
>> you to add some straightforward way to add a better arch-specific
>> implementation if you think that would be better.
> 
> As the code is right now I can guarantee that it will not work on s390.

OK, I have thrown the towel wrt developing at the same time for multiple 
architectures.

ATM I'm oriented toward getting support for one (x86_64), leaving the 
actual mechanism as architecture specific.

Then I can add another one or two and see what makes sense to refactor.
This approach should minimize the churning, overall.


--
igor
