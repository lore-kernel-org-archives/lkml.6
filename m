Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74A9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 05:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 901B920865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 05:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W56uKNp8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 901B920865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbeKZQ2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 11:28:20 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37560 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbeKZQ2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 11:28:20 -0500
Received: by mail-pf1-f194.google.com with SMTP id u3-v6so6006198pfm.4
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 21:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UASEVsBr/lMSjsse1LkWTVfsgjxLgJj3/bMR5xsyChI=;
        b=W56uKNp8fyOscLP1LXcH7/Zh3MhPlbEu1mBz4vBFEzxAYy6xMlQ+MAeKgbYDbqti2k
         mQsYu+5I86ZK9k+6RWT0+nFFPnlFQmfMTlGu2SnQkwv3Jq2aELnVSA9jJOv5GdCDkBiJ
         L+UA727E9l3Lpu24v2g6xowXAssqs+cYw4yU8lwlhIiuiMTZnmqzhOd+SX0fsXfUB0gI
         6o8fLdsLpe1Eh/HndfJIiL/bl2gSdRisyg3wYl1ATYmsg17hHVGSQLZt5A2rPHa55jaa
         acTuMi8K/JELc5dsAhJ2zrPxcbCRFx64EaeDVQOgKf0Ve1U8CiQhGiagM5x/cafT+zsZ
         nYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UASEVsBr/lMSjsse1LkWTVfsgjxLgJj3/bMR5xsyChI=;
        b=IJIFCM2CsJN9gfR768nw69BOwKhremu+s1CBw73lSsM6XjALsN2hrlYmoVTA9YiTTf
         FbarweR/I9c0297p3S65Z4MC/mtORzrrNUbPso5waJ4zhILJvAmNERoU+QAmuHYn1AYL
         IP6tBjOb48YczvoxRNhNubWf05ocA9pgzNIB1nu5QHjXmXyPRM5pDdbY9La+k0R+cBF/
         kQMKuqVwIVwFafOU/+kIae6dSisgR1DQGVAYIWFLczeFPHrCLPk+p2QJnMd8dik0dfd4
         TiJnoHe8+SiHCxeba/xz5Wb9QqMT9CTMJTPlLZW3Thl/+Rh87yKpMb2frXhqZVsmYLOJ
         IzKA==
X-Gm-Message-State: AA+aEWah2vWZjM0cMUNrzmz1g4RVSxrvvIVnC/x34QlTVnAj2lwgPiVI
        Qj5hRwwzc4lRbi4O3vJAUOTlMa0h
X-Google-Smtp-Source: AFSGD/XUD8/9ScWXyKfyT9IGyGIvHOb5aPjW3n4ECmG8NqYsj2xJcSVKV8M2wKUSu5MdW5/9JRSUjQ==
X-Received: by 2002:a63:5207:: with SMTP id g7mr23666535pgb.253.1543210521603;
        Sun, 25 Nov 2018 21:35:21 -0800 (PST)
Received: from localhost ([175.223.33.236])
        by smtp.gmail.com with ESMTPSA id f64sm144482100pfh.0.2018.11.25.21.35.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 21:35:20 -0800 (PST)
Date:   Mon, 26 Nov 2018 14:35:17 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Joe Perches <coupons@perches.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: RFC: script to convert vsprintf uses of %pf to %ps and %pF to %pS
Message-ID: <20181126053517.GF540@jagdpanzerIV>
References: <8eb7769cb8550e82105b71ba67fd603394e23b1e.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8eb7769cb8550e82105b71ba67fd603394e23b1e.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
