Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECC5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A87C20838
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTj7vfXg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440465AbfBNWQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 17:16:58 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43461 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440409AbfBNWQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 17:16:56 -0500
Received: by mail-ed1-f65.google.com with SMTP id m35so2417049ede.10;
        Thu, 14 Feb 2019 14:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5XAjx2yY0lsjk5SfOG6go48OCH9fthlrV/dIsNHxbVw=;
        b=NTj7vfXgCgjRshMCXEYScspOWiZopQ7EbzlFysV7h2RMyiqNW45EX0b6PlJV7g6rMK
         OHT3v5hK7nBrsi32WuQ4MQB6r89pMek9mruEIhgnlpDaTNS74aMcssgCY6+D9uhttlBt
         FfGRWc3XNcXUtqystUbRnKuyrJLgvwFKQespIR9jQJ/6zfAixYOC7PgBfcJSskJ26gtI
         a80zpv6R0j8uPonwdfw09rU6qah3Yz4Hvg9GoptAec93dCBB9QjLyS/DfW3lS8/txVxp
         1CPTlIn/Z+bDMU54wU7EQ4TZ3SF7O3lPZMKefN+N2g7WbTrag9E7CJ+lgrlaHjmtNvJl
         0hYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5XAjx2yY0lsjk5SfOG6go48OCH9fthlrV/dIsNHxbVw=;
        b=ujrCaJUOV5hyvE9kLdNrQAsAt5DY4wTDxOutsKoAoNZntkChY/nRZY+wMnSz6B5p7O
         A/BJjY7zEe2Yh/O6mumXn+4+ZlaPihd3a12fUT+zVcy/j9T/eY+VDZLlLtrbdL5qnuV8
         QsiRH0q5SlvOka9JsmhTzn+Y/SpQZVufJFf5w8zolxWRMFaLcxEc7uk24Q0bZckIFC3l
         UqdMJbq0gD3sisQ+9xnb8bMyfw2PuJHsXhz8xVIXEWP7f7BEwSJsNJ0miJgGduRpWVjZ
         rj1lFN7yU4rIWEWdp9wb84R5ihZappQGoces6W2/Hs2h01hV4h4WTZmXADykmm8u92d5
         etLA==
X-Gm-Message-State: AHQUAuYJ9Cnd3HUNzRvS9ksT98hJ8Kds5++XyVaX+ak9PJnvssH+VVV1
        rolYArScaG0DmG2zCBaEcHI=
X-Google-Smtp-Source: AHgI3IYgG21tC8vS2VF1GCmnCfviAktEt4rCaQ4MPQSrqf3mrZ5tmPKAvPragWyx6AOCEj23ocVeBg==
X-Received: by 2002:a05:6402:6c3:: with SMTP id n3mr4901838edy.74.1550182614254;
        Thu, 14 Feb 2019 14:16:54 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id y24sm991200eds.35.2019.02.14.14.16.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 14:16:53 -0800 (PST)
Date:   Thu, 14 Feb 2019 22:16:52 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        "Tobin C. Harding" <tobin@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xarray: Document erasing entries during iteration
Message-ID: <20190214221652.rwctk7wrocpojtfy@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20190212072958.17373-1-tobin@kernel.org>
 <20190212135129.GL12668@bombadil.infradead.org>
 <20190213144744.ifejzbxrbaltivwc@master>
 <20190213161258.GS12668@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213161258.GS12668@bombadil.infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 08:12:58AM -0800, Matthew Wilcox wrote:
>On Wed, Feb 13, 2019 at 02:47:44PM +0000, Wei Yang wrote:
>> On Tue, Feb 12, 2019 at 05:51:29AM -0800, Matthew Wilcox wrote:
>> >That is _fine_.  As you know I hope to get rid of the radix tree soon ;-)
>> 
>> You mean replace radix tree in whole kernel? That would be a big effort.
>
>Already mostly done.
>
>http://git.infradead.org/users/willy/linux-dax.git/shortlog/refs/heads/xarray-conv
>
>The only remaining user of the radix tree in that tree is the IDR.  So
>now I'm converting the IDR users over to the XArray as well.
>

Wow, really a HUGE work.

>
>But that isn't what I was talking about.  At the moment, the radix
>tree and the XArray use the same data structure.  It has good best-case
>performance, but shockingly bad worst-case performance.  So we're looking
>at replacing the data structure, which won't require changing any of the
>users (maybe the page cache ... that has some pretty intimate knowledge
>of exactly how the radix tree works).
>

Two questions from my curiosity:

1. Why you come up the idea to replace radix tree with XArray even they
   use the same data structure?
2. The worst-case performance is related to the data structure itself?

>> BTW, have we compared the performance difference?
>
>It's in the noise.  Sometimes the XArray does a little better because
>the APIs encourage the user to do things in a more efficient way.
>Some of the users are improved just because the original author didn't
>know about a more efficient way of doing what they wanted to do.
>

So sometimes XArray does a little worse?

Why this happens whey XArray and radix tree has the same data structure?

Interesting.

-- 
Wei Yang
Help you, Help me
