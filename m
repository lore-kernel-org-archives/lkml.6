Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B385C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 03:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E870621920
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 03:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545534363;
	bh=eF1MWsFxq+VYLDQjewSGfdNnKMVyuD2JMb4MXie+qVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YeBsFCsQgiMVpBIY+fQLv9POKzIDegEnrsGfMd2zhTWXmeUKxFIxMheiapmSJg6fG
	 rYKjjuyh3EkoXsv1pJXKF7btzfIjL+tefZ47Pl5WVe5n3RSDBC/1rAZt0QgoAINQ0j
	 xF1M52MrdMQSGDDdxk6gLR1kkRp/9PH3UUr7AjK8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393087AbeLWDGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 22:06:02 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33084 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732371AbeLWDGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 22:06:01 -0500
Received: by mail-pl1-f195.google.com with SMTP id z23so4266598plo.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 19:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pGvINoIzrAlx7O2oJvw/TjsAxJO7A2TS6yzyr0/KpQ8=;
        b=M6io82MbSlljZ1bURF3273tcNO5evULk6Vk4YKEb4Vf1Gd5UZZ6wG/czqq23ma6fbo
         +R2bsRvkzx+UaX76Vxlizm2lbEdssLDfjWfv6+6NhMrxIHgBERgTleFIKABwkD1OCYTI
         7I64IyHEEytfuyXeVN4RuT4iysx9FLzdUASpr1CjNC0PciToa79wPY2NHgljZHs92Ao7
         /VWLsuf7cHgidHAepFwWrwQWReCfGiqFooiOpIYcbttIbNObDzql4ohiQmGIX/6Tzy1Q
         xxP/JdlONXuin6dyctMSoHVWeQBBTS1ZtI7BR+SNHMubPN+ghINjpSkN3ikuXi5UYkVI
         cabA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=pGvINoIzrAlx7O2oJvw/TjsAxJO7A2TS6yzyr0/KpQ8=;
        b=NdtS0gJEfSCuEScdLdbfnJrVTsEpaUDa9Vb3TgzwOj8d+QgMHGGeJGkHpVoQ2ABWRw
         koyw9cwfLoeqrFizO6tLYng9QiVQzwNho5kW94n9lx+Lkbj6Zlo9qeDavHsb3FphUbhN
         U/bF6lo1xGcCLVtUeRSWLRKy1ckZ8YiSa20DqCoH9BEXInxCm40EmYEZXgfalTuFL9EG
         yJ3623IYdO9zbK3nYt6kksy+B6qA0ELN8sksxP1itlJ37nzlHIcacMFrCizwvKP6yWVG
         5eNYf6Rri0sS1Sf3yc1FNMrIEJ4mW8lLVh+ORXSto1Sbcjza0lkGlBmF6Pzi6lcu4VaB
         G7pg==
X-Gm-Message-State: AJcUukeSjllFMO5L4d5saJC7Wr+j9iGOUGJIMO72h4QvlOj6p0tZWMXU
        GLTcY0JhnzrIqKiEvpwFqQM=
X-Google-Smtp-Source: ALg8bN6XaW2D7mO2BffvABcrYskiaEccz8OJxq/MFHUzlhU0urveaQNQTUF3crFDNrpoEs09TzwrgA==
X-Received: by 2002:a17:902:968d:: with SMTP id n13mr8580277plp.109.1545534359796;
        Sat, 22 Dec 2018 19:05:59 -0800 (PST)
Received: from danjae.aot.lge.com ([182.210.106.196])
        by smtp.gmail.com with ESMTPSA id v89sm39747744pfk.12.2018.12.22.19.05.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Dec 2018 19:05:58 -0800 (PST)
Date:   Sun, 23 Dec 2018 12:05:52 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>, kernel-team@lge.com
Subject: Re: [PATCH v4] string.h: Add str_has_prefix() helper function
Message-ID: <20181223030552.GA11421@danjae.aot.lge.com>
References: <20181221231924.4583e90b@vmware.local.home>
 <20181222093346.GB7610@danjae.aot.lge.com>
 <20181222072404.27a7e9a3@vmware.local.home>
 <20181222142411.GA10058@danjae.aot.lge.com>
 <20181222101244.7da017c9@vmware.local.home>
 <20181222111630.24a4444a@vmware.local.home>
 <20181222164605.GA10792@danjae.aot.lge.com>
 <20181222121911.68603488@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181222121911.68603488@vmware.local.home>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2018 at 12:19:11PM -0500, Steven Rostedt wrote:
> On Sun, 23 Dec 2018 01:46:05 +0900
> Namhyung Kim <namhyung@kernel.org> wrote:
> 
> 
> > > What I meant by that is if a string is allocated at a end of a page,
> > > and the next page is marked as not present. A read into that page will
> > > cause a page fault, and since memcmp() does not stop at the '\0' it
> > > will read into that not-present memory and trigger a fault, and that
> > > read wont be in the exception table, and it will then BUG.  
> > 
> > Why it doesn't stop at the '\0' if one has it and the other doesn't?
> > It's not because it's '\0', it's because they are different.  The '\0'
> > should be in the prev page (otherwise it's already a BUG) so it should
> > be detected and stopped before going to next page IMHO.
> > 
> 
> Because memcmp() isn't required to test byte by byte. In fact, most
> implementations don't which is why memcmp is faster than strcncmp.
> 
> It can be checking in 8 byte chunks or more (although perhaps not
> likely). Perhaps there's an arch command that lets you compare 32 bytes
> at a time, if the size passed to memcmp is 32 or more, the
> implementation is allowed to read both src and dst of 32 bytes at a
> time. If there was a '\0' followed by not present memory, you will
> still get that fault.

I thought such implementation would check the alignment and not cross
the page boundary in a single read.  But it's implementation's choice
and I found that glibc's default implementation for misaligned pointer
reads next chunk as well to form an aligned chunk using shifts.  So
for the safety it'd be better to use strcmp()..

Thanks for your time and the explanation,
Namhyung
