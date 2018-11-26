Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C69C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 06:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D1A220672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 06:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WY0RKO/l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D1A220672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbeKZRBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 12:01:31 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40670 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeKZRBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 12:01:31 -0500
Received: by mail-pg1-f193.google.com with SMTP id z10so5651106pgp.7
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 22:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UYcdky/l+c+XWuq4HXeP9bNj8kp02ugjgL3zyOT1IjQ=;
        b=WY0RKO/lpVaDQUpjAkmR/4ytkVsAef9S5k3q2lHtuXXDSkzG2tdNDxAHgvzeLCBTKO
         U/DkjQQjTUy85lax1f6XEWet1sB+dTSa+XINGJ9Vtsutp58mOsOucGGy2LzOnGEhjmDM
         ivg06rsc6QEk1feHgQMLRuN27HImDFYr35RBg9EHedTO4QI46AxN1daLbAsczu6NXreh
         uUeuDJ9o2hX0f9qZqOdB/E03lltL7xEikmujNLfz+1vEyOmg3RCijkq8jMjeOx91tfFJ
         j0joYHjxVy2d/T24j6WAHcCUPJh7ZPf54wJq6Lc7TTMjSJsLu+7yuerDh1A0FG5250zR
         PYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UYcdky/l+c+XWuq4HXeP9bNj8kp02ugjgL3zyOT1IjQ=;
        b=dr8Kwc6srsKgsLR/tSmXD2C4kAjjQigGi3hqNNY0c+K4j9oPAW/XrfDGjg2DJv7r31
         5gYq7BzWpasLBtB5Hf0jKl+pKLSNUnXnt2EPlYXwLQLIEvFWb2iH5olVQ2KKLYqYVtL9
         NZrs9wtwf2Xmke5ugQ65YHIFIE3yC9Bv4dd6qAqZzTJDFP91dXyhkwR2yXXXucQca+Ow
         1eM+caIGFmJsW/JXfJ0vUrz1VPC8APkslFjNG+JUhcwETOMVxk/anRiigSnv/EgzsBiB
         MoCZnJkd1CmW5KF4m+4LqdT2bMEDJgqh7W57K4Irtg/UmQRR+lBW4xrFeGNis5rVKU8b
         5Waw==
X-Gm-Message-State: AA+aEWboKZzt0p8G3/ZpE7ImDbkrSZv/BEbIBA9c6wxGt5MV/2sJ2vhs
        Ywv4QczenpZi8k7JXQ/Juy4=
X-Google-Smtp-Source: AFSGD/V+C+86a6Lc38JrTS9sSUux0bUl645q/1HQczBpd4+bfDHYijvgRhs9QG2oYqnbH+iyYfymSA==
X-Received: by 2002:a63:9c1a:: with SMTP id f26mr23752859pge.381.1543212508512;
        Sun, 25 Nov 2018 22:08:28 -0800 (PST)
Received: from localhost ([175.223.33.236])
        by smtp.gmail.com with ESMTPSA id 19sm74958975pfs.108.2018.11.25.22.08.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 22:08:27 -0800 (PST)
Date:   Mon, 26 Nov 2018 15:08:24 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Joe Perches <coupons@perches.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: RFC: script to convert vsprintf uses of %pf to %ps and %pF to %pS
Message-ID: <20181126060824.GG540@jagdpanzerIV>
References: <8eb7769cb8550e82105b71ba67fd603394e23b1e.camel@perches.com>
 <20181126053517.GF540@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126053517.GF540@jagdpanzerIV>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And I forgot to actually Cc Petr and Steven...
Top-posting.

-------

Hi,

Cc-ing Petr and Steven

On (11/25/18 01:13), Joe Perches wrote:
> commit 04b8eb7a4ccd ("symbol lookup: introduce dereference_symbol_descriptor()}"
> 
> deprecated vsprintf extension %pf and %pF.
> 
> There are approximately these total uses of the symbolic
> lookup vsprintf extensions %p[SsFf]:
> 
> $ git grep '".*[^%]%p[SsFf]' | \
>   grep -oh '%p[SsFf]' | sort | uniq -c | sort -rn
>     231 %pS
>      65 %ps
>      60 %pf
>      47 %pF

I didn't bother to remove "pf/pF" because I didn't want to count on:
  a) everyone running checkpatch.pl
  b) everyone testing all printk-s they added

I guess pf/pF still can sneak in.

But I don't have a really strong opinion on this. If general
consensus is that we shall remove deprecated specifiers, then
I'm fine.

> which is about a 3:1 ratio favoring %pS
> 
> so a script to convert all the %pf uses to %ps and %pF uses to %pS
> could be useful.
> 
> There are a few files that appear should not be converted.
> 
> $ git grep -w --name-only -i '%pf'| \
>   grep -vP '^(?:Documentation|tools|include/linux/freezer.h)'| \
>   xargs sed -i -e 's/%pf/%ps/g' -e 's/%pF/%pS/g'
> 
> If that script above is run, it leaves the following patch
> to be applied:

After running this script I still have a bunch of leftovers:

//
// these two are probably not really relevant, but still - %pF/%pf
//
tools/lib/traceevent/event-parse.c:             if (asprintf(&format, "%%pf: (NO FORMAT FOUND at %llx)\n", addr) < 0)
tools/lib/traceevent/event-parse.c:     if (asprintf(&format, "%s: %s", "%pf", printk->printk) < 0)

arch/um/kernel/sysrq.c: pr_info(" [<%08lx>] %s%pF\n", address, reliable ? "" : "? ",
arch/x86/xen/multicalls.c:                              printk(KERN_DEBUG "  call %2d/%d: op=%lu arg=[%lx] result=%ld\t%pF\n",
kernel/async.c:         pr_debug("calling  %lli_%pF @ %i\n",
kernel/async.c:         pr_debug("initcall %lli_%pF returned 0 after %lld usecs\n",

	-ss
