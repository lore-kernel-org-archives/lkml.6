Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E22C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F14B32081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJJKkQJf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F14B32081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbeK2NUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 08:20:37 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38330 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbeK2NUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 08:20:36 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so218847pfi.5;
        Wed, 28 Nov 2018 18:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=IPR5nIyHZDdPLDZfkU2TiFWAFZrkV8aoha9yy8TDNg0=;
        b=UJJKkQJfCb66cMGRj8enZVuby41zZmg55ovQgw9hENmQOjOFgxdMpnx5YsXVNCa2CF
         2eGm8lrswYxRnW7Cv8mWNQcMRu/ZQHVxSWXcUIm2HAXFGCThyvi4FDlrIfEK0G86sxB/
         J43YmTDhvS80om2exn2d3rmp3PvOGmiJHLdSE+3JNTRxrFLBDeO/++q48tV7Pde8nXEa
         k0jLzSRvCsr5fbvfex7+1uSBHC2ZhcdzMWX9q/BaqOt06oEJbubpiH0VfwTfOQJfefxc
         GYVPJzIGwmTXii0y3ljU7YQOrRTVtpaO+0pYVNaARZb+m3j5lnPbqeHg/hp/bth6jiRK
         TlpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=IPR5nIyHZDdPLDZfkU2TiFWAFZrkV8aoha9yy8TDNg0=;
        b=WdvHdMe5IC4JDX/A9lR1VXhElaC+teGdOyxFDgCHntRqhqh++agk4/l61PrrjiKUn7
         jklt9d9gQYfyZ762wrZuYs965gVuOa/3/2ZSjs+oJyD/kg47XAdwqj/mN+Dr0Zy4Z0Ba
         3lgnlZ+c7HzFaX68N2Q6d4yk/F5Ctont4GTCJdvyIKICQ0hAw4Sw3oFRX7HcTQQPIqp3
         JveQoz2xwQZWPma6PlLUL4dXy28XPo/bWQPFq+cem7PvGirvmCnRiqziwgWB+XSDpJN9
         t72O+J9qfG7uOinMs49Ru3hy9GYVnTCAPO+7pQvroh4vncTUVI9ZQohqZFk+OfnfpN5P
         RUig==
X-Gm-Message-State: AA+aEWYuZFkE05pcB2zGA+xajadO/lvGB+mb4ceWQOjWcokdNdQQ7MSm
        o1lUR8L7uKCKJA4HajyA3AI=
X-Google-Smtp-Source: AFSGD/WEWzxpSqRGljfrplGrh/MxClhr9wNvImOZPHkkpJ0cjHM4YtZTDvaMsCh1BN4SKIu8iVCUpg==
X-Received: by 2002:a63:6506:: with SMTP id z6mr35160024pgb.334.1543457813424;
        Wed, 28 Nov 2018 18:16:53 -0800 (PST)
Received: from bytedancedeMacBook-Air.local ([61.120.150.66])
        by smtp.gmail.com with ESMTPSA id m65sm359118pfg.180.2018.11.28.18.16.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 18:16:52 -0800 (PST)
Date:   Thu, 29 Nov 2018 10:16:35 +0800
From:   Xiaozhou Liu <lxz1983@gmail.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        jakub.kicinski@netronome.com, quentin.monnet@netronome.com
Subject: Re: [PATCH] Compiler Attributes: move kernel-only attributes into
 __KERNEL__
Message-ID: <20181129021635.rzmehzzfgt2jvpgi@bytedancedeMacBook-Air.local>
References: <20181128140852.178260-1-liuxiaozhou@bytedance.com>
 <CANiq72kzHqQ-M2Gyrf7iy1BQMabM6txChYwa8hrDkMmc3w8ORw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kzHqQ-M2Gyrf7iy1BQMabM6txChYwa8hrDkMmc3w8ORw@mail.gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miguel,

On Wed, Nov 28, 2018 at 06:35:18PM +0100, Miguel Ojeda wrote:
> Hi Xiaozhou,
> 
> On Wed, Nov 28, 2018 at 3:09 PM Xiaozhou Liu <liuxiaozhou@bytedance.com> wrote:
> >
> > Attributes such as `__gnu_inline' are meant to be used within the
> > kernel. When userspace somehow includes <linux/compiler.h>
> > (eg. tools/bpf), compilation errors would be shown:
> >
> >         "error: unknown type name ‘__gnu_inline’"
> >
> > So just move these things into __KERNEL__ and the behavior is kept
> > as before.

By `these' I mean inline and the like, to be clear.

> That is not exactly correct -- a3f8a30f3f00 moved some attributes to
> another file, moving them into __KERNEL__ (in particular,__gnu_inline
> is).

Yes, that is what a3f8a30f3f00 did. Sorry.
Turns out the commits in question are 815f0ddb346c and a3f8a30f3f00.

> The problem is, instead, that __gnu_inline is not anymore defined
> outside __KERNEL__, but something else that uses it is (the inline
> macro definition, if I had to guess).

Yes and no. Let's recall the whole story.

Before 815f0ddb346c("include/linux/compiler*.h: make compiler-*.h mutually exclusive"),
__gnu_inline and inline were both *in* __KERNEL__ as the were in
<linux/compiler-gcc.h>, which was entirely put to __KERNEL__ in
<linux/compiler_types.h>. Everything was fine.

Then 815f0ddb346c moved inline and __gnu_inline *out* of __KERNEL__
and put them in <linux/compiler_types.h> so userspace could see them
both. Not sure if it's intended behavior, but everything looked fine.

Then a3f8a30f3f00 moved __gnu_inline back into __KERNEL__ and left
inline behind. Since inline depends on __gnu_inline, error showing
"unknown type name ‘__gnu_inline’" pops up.

> If your problem is fixed by putting __gnu_inline into __KERNEL__
> again, it means we can simply move the inline definition inside
> __KERNEL__ too. That way, we don't pollute userspace users with macro
> definitions.

It'd be good. That's exactly what my patch does.

> Having said that, does someone know whether userspace should have
> access to those attributes (or rather, other code that uses in turn
> those attributes)?

It'd be better to keep those attributes out of userspace, as is the
case before 815f0ddb346c.

BTW, the userspace code failed to compile in my case is under
directory tools/bpf/.


Thanks,
Xiaozhou
