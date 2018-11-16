Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D9CC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 15:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F23CA2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 15:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/Phfb3O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F23CA2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389961AbeKQBt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 20:49:56 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44624 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbeKQBt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 20:49:56 -0500
Received: by mail-wr1-f68.google.com with SMTP id j17-v6so25302839wrq.11;
        Fri, 16 Nov 2018 07:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AXLQmSVToMHYBZ74VljjxPo5yIDZrVqWergThQIRuxw=;
        b=Q/Phfb3OIebP7FkIyZnYvhtAIj1KvGXeRdQ8rbVHGVLZsFV4v8tB0jsK2z3GjHlrSR
         v3yehvelaAFg0RslDrBgZT3GMuRpQlTNq67UiQ9jAPU7bfisgmoEzsKxMNIZceLBPxoG
         qqu33Yw+fgmDnf+aihHK3a7Ydr/0bVjy8D4WvWUP0ARwRdSFS+1I0/aQipsJAWapZh6V
         36QwUqaaCDKZWPXwL0Nv49hkM5Cw+TBv31uwFO4b4AF9wSsbkxs4XQJ9JEbReJexDI6R
         t5MtJJYqTia30hOvmnZ6DMXsT3O4Yv1DUTDImuXGi0SOZlDYbGlQw7Ek5Cz23TqDe6Rq
         ToEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AXLQmSVToMHYBZ74VljjxPo5yIDZrVqWergThQIRuxw=;
        b=BHmYpVBmqehfTSzU6mUoMDuOq0QzCQmo94TsSyT6d7c7r88O3iph929kzkoBAv2w5Q
         ByQUzMSNR0opqGtbnxilG3gqLr/sAwmmEhd+eipgn+xeHrqescwsiEF4LXWNkPHP6dAS
         c55rpl9yROnzk8caG3Jx1zI55sgN50QWdDlmonmHqzXFnvbWJozj/xYg5LxEO4AeyEOZ
         u/eGvSQSroSfPjA5BgzuMamSDdMetKsCgN18wgY0t3mg0ZmadBqfx/tBRvSa4Z2IbPfO
         +RZ/CrAyo4h9Djh/FvjLCrbwAmITxP6Lqkj9T3czNj4Crtp5AdsF4a31RE7zpn55hPkX
         WrzQ==
X-Gm-Message-State: AGRZ1gJFEnLaSZ0Ibvj0Uo6fBaRHJz5Y1hCCzrSPu5fYjjuRXFrB4qHy
        lrK4VR4FBM8vYaEKvGWava8=
X-Google-Smtp-Source: AJdET5d3Xch8sk1Yt1WjtXS/K/5/NBqe1YQDE4R6oI57VbX5q/btJaDmU78cnJdkitRMtoB/whh1gQ==
X-Received: by 2002:adf:a20a:: with SMTP id p10-v6mr9771137wra.249.1542382623656;
        Fri, 16 Nov 2018 07:37:03 -0800 (PST)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id i9sm3104788wrs.34.2018.11.16.07.37.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 07:37:03 -0800 (PST)
Date:   Fri, 16 Nov 2018 08:37:01 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     Joe Perches <joe@perches.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] geneve: Use empty braces for addr6
 initializer
Message-ID: <20181116153701.GA16184@flashbox>
References: <20181112221248.11477-1-natechancellor@gmail.com>
 <20181113061146.12182-1-natechancellor@gmail.com>
 <20181116150432.2408a075@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116150432.2408a075@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 03:04:32PM +0100, Stefano Brivio wrote:
> On Mon, 12 Nov 2018 23:11:47 -0700
> Nathan Chancellor <natechancellor@gmail.com> wrote:
> 
> > Clang warns:
> > 
> > drivers/net/geneve.c:428:29: error: suggest braces around initialization
> > of subobject [-Werror,-Wmissing-braces]
> >                 struct in6_addr addr6 = { 0 };
> >                                           ^
> >                                           {}
> > 
> > Most initializations of structs in the kernel seem to use this format.
> 
> Actually, even with this, we get a warning with gcc 4.4 and 4.8. I tried a
> few compilers:
> 
> $ gcc-4.4 --version | head -n1
> rhel-6.9-gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-18)
> $ gcc-4.8 --version | head -n1
> rhel-7.5-gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28)
> $ gcc-7.3 --version | head -n1
> gcc-7.3-gcc (GCC) 7.3.0
> $ gcc-8.2 --version | head -n1
> gcc (Debian 8.2.0-9) 8.2.0
> $ clang --version | head -n1
> clang version 6.0.1-9.2 (tags/RELEASE_601/final)
> 
> $ cat init.c
> #include <linux/in6.h>
>  
> int main()
> {
>         struct in6_addr addr6 = INIT;
>  
>         return addr6.in6_u.u6_addr8[0];
> }
> 
> $ gcc-4.4 -DINIT="{ }" -S -Wall -Wextra -o init init.c 2>&1 | grep warning | head -n1
> init.c:5: warning: missing initializer
> $ gcc-4.4 -DINIT="{ 0 }" -S -Wall -Wextra -o init init.c 2>&1 | grep warning | head -n1
> init.c:5: warning: missing braces around initializer
> $ gcc-4.4 -DINIT="{ { { 0 } } }" -S -Wall -Wextra -o init init.c 2>&1 | grep warning | head -n1
> 
> $ gcc-4.8 -DINIT="{ }" -S -Wall -Wextra -o init init.c 2>&1 | grep warning | head -n1
> init.c:5:16: warning: missing initializer for field 'in6_u' of 'struct in6_addr' [-Wmissing-field-initializers]
> $ gcc-4.8 -DINIT="{ 0 }" -S -Wall -Wextra -o init init.c 2>&1 | grep warning | head -n1
> init.c:5:16: warning: missing braces around initializer [-Wmissing-braces]
> $ gcc-4.8 -DINIT="{ { { 0 } } }" -S -Wall -Wextra -o init init.c 2>&1 | grep warning | head -n1
> 
> $ gcc-7.3 -DINIT="{ }" -S -Wall -Wextra -o init init.c 2>&1 | grep warning | head -n1
> $ gcc-7.3 -DINIT="{ 0 }" -S -Wall -Wextra -o init init.c 2>&1 | grep warning | head -n1
> $ gcc-7.3 -DINIT="{ { { 0 } } }" -S -Wall -Wextra -o init init.c 2>&1 | grep warning | head -n1
> 
> $ gcc-8.2 -DINIT="{ }" -S -Wall -Wextra -o init init.c 2>&1 | grep warning | head -n1
> $ gcc-8.2 -DINIT="{ 0 }" -S -Wall -Wextra -o init init.c 2>&1 | grep warning | head -n1
> $ gcc-8.2 -DINIT="{ { { 0 } } }" -S -Wall -Wextra -o init init.c 2>&1 | grep warning | head -n1
> 
> $ clang -DINIT="{ }" -S -Wall -Wextra -o init init.c 2>&1 | grep warning | head -n1
> $ clang -DINIT="{ 0 }" -S -Wall -Wextra -o init init.c 2>&1 | grep warning | head -n1
> init.c:5:33: warning: suggest braces around initialization of subobject [-Wmissing-braces]
> $ clang -DINIT="{ { { 0 } } }" -S -Wall -Wextra -o init init.c 2>&1 | grep warning | head -n1
> 
> So { { { 0 } } } seems to be the safest option. We could go with static
> but it looks even uglier to me.
> 
> Joe, suggestions?
> 
> -- 
> Stefano

Yes, I used the wrong number of braces in the initial patch hence this
one. I'm fine with pushing that change as v3 if everyone agrees that is
fine.

Thanks for looking into this!
Nathan
