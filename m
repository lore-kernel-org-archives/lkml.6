Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0CDC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 00:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE525219D2
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 00:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acj4Tzfi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE525219D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbeHRDts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 23:49:48 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44067 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbeHRDtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 23:49:47 -0400
Received: by mail-pl0-f67.google.com with SMTP id ba4-v6so4408804plb.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 17:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cbhzoVXUYC5E83YJ3pm9rF5nz9oGF+T1q5UisTNENks=;
        b=acj4Tzfil2yiQWFvD+Lw7w0fKzp4uwG86a5upY4hgVGyANuaWcCYl3B7bPYl/CX0MM
         WqS51AIk7HwOrjzBq+utGZKSZbrKrrfZH8qB3Zuv0Zjqc/guAPh+6f0HLKLt6lQ+axca
         IuUhZa5yPd/hCuG1BdlJFDXuqcgu3XBh+jyHi43LuWcacHUdUKT6yie/XqRqtp0W6FAF
         ysAr5rvlroA8ixDwkrm8xdLUp8gNrTCmARtMmmCLeCCdm0PLQsfO7VA4Pm0XfgV6HD4+
         RKfzOdfx4g0/xjOjPxl+vHGqKaf2Fr3H7tf6tasP+IiZ7OI+mJ3XKuxGNLKejYM3QZ7T
         zjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cbhzoVXUYC5E83YJ3pm9rF5nz9oGF+T1q5UisTNENks=;
        b=mlDLn1UPzu6Cld+/n+asgKS8x23cBCKVeR2RO2sX94OvzRayIGRTV4GPbgZL8Oj+eC
         2TvYMhXUJ296lzTtZT17fdHUeyslhgZ3sKBdDeRFUy69NerUrf2lHU9mE45eIqC6n41U
         DqY38MKA0yJ+URpeSzy9BeSCt3AP/PifjAnj/WQe3N0uPu+AdFJzIS+JCv/S7RcVfAoT
         yN7gxpdr2phxrBWmwGoGXK+KTwGtpnb0552wuKvXZnAYknm7zffg7FIXeX8Y9OLVmtit
         AEtrbT7xOEawPmb0gHj6JICyQUTmA3aZwQlOKAQ9P1/sL6C86jQWcUDWCGmJz8C0AeIe
         mEIA==
X-Gm-Message-State: AOUpUlGpk6wm4dGqtqurdPpyh0LoM4FXTyvSh43Q428/31aAV9dwGTqS
        A3K33Fd1Pevv5KXMQuc5uVI=
X-Google-Smtp-Source: AA+uWPylc3LnU87AuvQsmeT0RD6b37B5uitpzuKX6LbbsSmNs14oCKXGGgnb3JR1aOn6vuoudI1/qA==
X-Received: by 2002:a17:902:bd97:: with SMTP id q23-v6mr35967815pls.311.1534553050893;
        Fri, 17 Aug 2018 17:44:10 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id 143-v6sm5567147pfy.156.2018.08.17.17.44.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 17:44:10 -0700 (PDT)
Subject: Re: Crash in MM code in v4.4.y, v4.9.y with TRANSPARENT_HUGEPAGE
 enabled
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        the arch/x86 maintainers <x86@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>
References: <20180817222733.GA18575@roeck-us.net>
 <CA+55aFw6KDEts1bk7F-HYVn_dSuFQHZZh89Ydqh1rFn-c5V+eQ@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <be29b1fe-301d-7306-863d-ce7b80d2d816@roeck-us.net>
Date:   Fri, 17 Aug 2018 17:44:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CA+55aFw6KDEts1bk7F-HYVn_dSuFQHZZh89Ydqh1rFn-c5V+eQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/17/2018 05:25 PM, Linus Torvalds wrote:
> On Fri, Aug 17, 2018 at 3:27 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> [    6.649970] random: crng init done
>> [    6.689002] BUG: unable to handle kernel paging request at ffffeafffa1a0020
> 
> Hmm. Lots of bits set.
> 
>> [    6.689082] RIP: 0010:[<ffffffff8116ba10>]  [<ffffffff8116ba10>] page_remove_rmap+0x10/0x230
>> [    6.689082] RSP: 0018:ffffc900007abc18  EFLAGS: 00000296
>> [    6.689082] RAX: ffffea0005e58000 RBX: ffffeafffa1a0000 RCX: 0000000020200000
>> [    6.689082] RDX: 00003fffffe00000 RSI: 0000000000000001 RDI: ffffeafffa1a0000
> 
> Is that RDX value the same value as PHYSICAL_PMD_PAGE_MASK?
> 
> If I did my math right, it would be, if your CPU has 46 bits of
> physical memory. Might that be the case?
> 
Yes.

> The reason I mention that is because we had the bug with spurious
> inversion of the zero pte/pmd, fixed by
> 
>    f19f5c49bbc3 ("x86/speculation/l1tf: Exempt zeroed PTEs from inversion")
> 
I applied that patch, but it didn't help. I get exactly the same crash and
traceback.

> and that would make a zeroed pmd entry be inverted by
> PHYSICAL_PMD_PAGE_MASK, and then you get odd garbage page pointers
> etc.
> 
> Maybe. I could have gotten the math wrong too, but it sounds like the
> register contents _potentially_ might match up with something like
> this, and then we'd zap a bogus hugepage because of some confusion.
> 
> Although then I'd have expected the bisection to hit
> "x86/speculation/l1tf: Invert all not present mappings" instead of the
> one you hit, so I don't know.
> 
> Plus I'd have expected the problem to have been in mainline too, and
> apparently it's just the 4.4 and 4.9 backports.
> 
Personally I suspect that something went wrong or is missing in the backport
from 4.14 to 4.9. 5-level paging was introduced in between, and thp support
was extended to support additional architectures. With all those changes,
it is easy to miss something. Only I have no idea what that might be.

Guenter

