Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B757CC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 08:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ACA720866
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 08:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lo4OCL8r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ACA720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbeIIMux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 08:50:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43822 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeIIMux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 08:50:53 -0400
Received: by mail-wr1-f67.google.com with SMTP id k5-v6so18697561wre.10;
        Sun, 09 Sep 2018 01:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jDGlzm2jPs1aAcPeol3KAmuPuPOupgwwIlOtgvzbT7Y=;
        b=Lo4OCL8rtZLkMoRPAnf7Y3xdghpdpzRnVk5ti1mAh/VwIc8x97LZH6E9JLSlgmRJF6
         jhj052NTXyPret9ZkbHVk10m3VP/D4tfJnYK43hy72mq8a8vr/xNGwN6Igb0bB2b0wxn
         hIm5LTt95cA/XBEIw6otXMfkDNgPnLw205VAMRDEL1S8TyJMLusmsUJmGd5q90CxYNWa
         6lWvxGdbLFbGDvmfQDl8A2aBXtPhRi3Xg0ciNveOJ3HOW5LRXN3kjT38LRs+M2+z7Eie
         HkOhVotGmcN3w5iLnQiQJ2utwu+I+Rn9x/1eaVd5E/UQGUPZAFeqj61CCnpbRDAtkC/U
         DKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jDGlzm2jPs1aAcPeol3KAmuPuPOupgwwIlOtgvzbT7Y=;
        b=lgNpMpjYFRALJ6mxxSYG1y+VK6G/dyLqqftEy0YCN2kGB/k+0fmGIhhWSC+cpJfIYA
         Sp43awvUcfvoeemJkG5YcIMnwYNiWPi3MucD58qQZUBx1zHiF3xUeWFHcXvHfS/BNkLp
         ZiiUTxxMpqv7e3BJS3EYBTlYl/ETjNsNfFJclHbFYzsKuowq2qyG/7o5BEEW9Lvf+NbE
         ed18tkWbuI++ajZ59E7q9eXBBcKMsp/9mnEe8m10/qOVq3TWV/uZqUbbm6PFOwCrocdh
         fqRZW6HDWChZXmy7Ya8rf5XNp2/cSQrciUX3MYUEZMCENFPlG5UdUNyd4xLaqcYFOGc9
         1OdQ==
X-Gm-Message-State: APzg51Cj8Hc4H36+wtf6twqRR2FFT6nq3xH9hdK53Qmjh6BMRo3JrD0u
        RcJt4lbsIVjT+0FtNj9Lcds=
X-Google-Smtp-Source: ANB0VdYERSgT1PkgxoG46SCG9P0SotK6brlUmrwGP251POmAuROkBHX7NAwnXCKeW0QHqtj2mMslSA==
X-Received: by 2002:adf:eb0d:: with SMTP id s13-v6mr10999058wrn.174.1536480123545;
        Sun, 09 Sep 2018 01:02:03 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:4006:df00:469:6049:d9c:1c28])
        by smtp.gmail.com with ESMTPSA id j20-v6sm8924583wmh.9.2018.09.09.01.02.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 01:02:02 -0700 (PDT)
Date:   Sun, 9 Sep 2018 10:02:01 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-sparse@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 00/13] Compiler Attributes
Message-ID: <20180909080200.xn7z4gctf2vrqzst@ltop.local>
References: <20180908212459.19736-1-miguel.ojeda.sandonis@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180908212459.19736-1-miguel.ojeda.sandonis@gmail.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 08, 2018 at 11:24:46PM +0200, Miguel Ojeda wrote:
> The Compiler Attributes series is an effort to disentangle
> the include/linux/compiler*.h headers and bring them up to date.
> 
> The main idea behind the series is to use feature checking macros
> (i.e. __has_attribute) instead of compiler version checks (e.g. GCC_VERSION),
> which are compiler-agnostic (so they can be shared, reducing the size
> of compiler-specific headers) and version-agnostic.
> 
> Other related improvements have been performed in the headers as well,
> which on top of the use of __has_attribute it has amounted to a significant
> simplification of these headers (e.g. GCC_VERSION is now only guarding 4
> non-attribute macros).
> 
> This series should also help the efforts to support compiling the kernel
> with clang and icc. A fair amount of documentation and comments have also
> been added, clarified or removed; and the headers are now more readable,
> which should help kernel developers in general.
> 
> The series was triggered due to the move to gcc >= 4.6. In turn, this series
> has also triggered Sparse to gain the ability to recognize __has_attribute
> on its own.
> 
> You can also fetch it from:
> 
>   https://github.com/ojeda/linux/tree/compiler-attributes-v4
> 
> Enjoy!

It's a nice and welcomed cleanup!
Everything look good to me, so feel free to add my
    Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>


Cheers,
-- Luc
