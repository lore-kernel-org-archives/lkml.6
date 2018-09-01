Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F3FC433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 09:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DD232083C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 09:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCMTjM6Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DD232083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbeIAOIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 10:08:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42543 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbeIAOIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 10:08:11 -0400
Received: by mail-wr1-f68.google.com with SMTP id v17-v6so13310191wrr.9
        for <linux-kernel@vger.kernel.org>; Sat, 01 Sep 2018 02:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y68SOC07le/SZ4yltDqOkzxDrSzriWveq7jDunIYiys=;
        b=eCMTjM6Zq3r+jZYgemwXGMaZD+P2vWI+f/SqcABfCB6tv03gTTqXrhIVVheYFVFpyV
         ucMsjRSgG8KBjUhC8wYNnKOQz9houd0CqpfHIxMLwOwoYFl3l3P77XFf96M+RI4eixr2
         un+jtrqhnTySzLBEUE7P92aCefBToCeCC16gVJnhCs1uO1ivgX7VUFWDkx8j71kJLU4F
         Qp63F8o0amwd3d3r9WVXyneS4na1j3bTd1JsXvI9sTv+eNFJ4ZtO+NMF1FgkS3rFMg0X
         xu8ZwJqvr3L7MJnUr8fUMjomoDO5lQRFc1i1PDtm23K/Dpw5ZXt1wafnKhqs7Bm9bdFd
         JYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y68SOC07le/SZ4yltDqOkzxDrSzriWveq7jDunIYiys=;
        b=dE27RtIicl9oHHeM1FE2IMJ5/r7yEUQKI0mKzyuYigMLATB2PO/SbR+YXXh/DYSa2z
         ysYlG1dzEjVeX52/P2x5GkPVEnEbNGdknAESdLrV8yvD4ETtwJB2aoDk9OLU8nIWAL7T
         rrlUV+2YcbVjnKe9NYAcCseMhFAjaILMFsRbIunzHs4L5TFor8Jd0iVUkgjL3tbXbmtH
         WIaP94bnv8M76jbFmWXn+def6Zfd5y3pmQrJciZ1Uz/fIb9oLCJKiOMjUqAXgOZXhnbE
         x3m9e8Xg3NHDu8NAYYUVHW87Km/XuLleNyfUixBVdDgXRCKVs6jIzr/1RiMtHxVTYozH
         yRYg==
X-Gm-Message-State: APzg51DAU/T+d4g6WpH3z9vvnUjUqpNVXgzB1yHY2csm5DdDR6HNduAO
        gjasDrYjSZLBA5dW29HfpWA=
X-Google-Smtp-Source: ANB0VdazkfsgOMl0u0K95QyMa6ouSj0DUXdqMykHRFiW9kKvLW9dbY+1bROwzvt1OjljtZ+riPoOVg==
X-Received: by 2002:adf:9c12:: with SMTP id f18-v6mr14058664wrc.93.1535795802392;
        Sat, 01 Sep 2018 02:56:42 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:4006:df00:8852:4a4c:95e8:7a2])
        by smtp.gmail.com with ESMTPSA id w18-v6sm24683751wrc.38.2018.09.01.02.56.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Sep 2018 02:56:41 -0700 (PDT)
Date:   Sat, 1 Sep 2018 11:56:40 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
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
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 7/7] Compiler Attributes: use feature checks instead of
 version checks
Message-ID: <20180901095639.ms6kkzywazkvs376@ltop.local>
References: <20180831170514.24665-1-miguel.ojeda.sandonis@gmail.com>
 <20180831170514.24665-7-miguel.ojeda.sandonis@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831170514.24665-7-miguel.ojeda.sandonis@gmail.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 07:05:14PM +0200, Miguel Ojeda wrote:
> Instead of using version checks per-compiler to define (or not)
> each attribute, use __has_attribute to test for them, following
> the cleanup started with commit 815f0ddb346c
> ("include/linux/compiler*.h: make compiler-*.h mutually exclusive").
> 
> All the attributes that are fairly common/standard (i.e. those that
> do not require extra logic to define them) have been moved
> to a new file include/linux/compiler_attributes.h.
> 
> In an effort to make the file as regular as possible, comments
> stating the purpose of attributes have been removed. Instead,
> links to the compiler docs have been added (i.e. to gcc and,
> if available, to clang as well). In addition, they have been sorted.
> 
> Finally, if an attribute is optional (i.e. if it is guarded
> by __has_attribute), the reason has been stated for future reference.
> 
> diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
> new file mode 100644
> index 000000000000..a9dfafc8fd19
> --- /dev/null
> +++ b/include/linux/compiler_attributes.h
> @@ -0,0 +1,226 @@
> +#ifndef __LINUX_COMPILER_ATTRIBUTES_H
> +#define __LINUX_COMPILER_ATTRIBUTES_H
> +
> +/*
> + * This file is meant to be sorted (by actual attribute name,
> + * not by #define identifier).
> + *
> + * Do not add here attributes which depend on others or require extra logic.
> + *
> + * If an attribute is optional, state the reason in the comment.
> + */
> +
> +/*
> + * To check for optional attributes, we use __has_attribute, which is supported
> + * on gcc >= 5, clang >= 2.9 and icc >= 17. In the meantime, to support
> + * 4.6 <= gcc < 5, we implement __has_attribute by hand.
> + */
> +#ifndef __has_attribute
> +#define __has_attribute(x) __GCC4_has_attribute_##x
> +#define __GCC4_has_attribute_externally_visible 1
> +#define __GCC4_has_attribute_noclone 1
> +#define __GCC4_has_attribute_optimize 1
> +#if __GNUC_MINOR__ >= 8
> +#define __GCC4_has_attribute_no_sanitize_address 1
> +#endif
> +#if __GNUC_MINOR__ >= 9
> +#define __GCC4_has_attribute_assume_aligned 1
> +#endif
> +#endif

For sparse (which doesn't support __has_attribute() yet and defines
__GNUC_MINOR__ depending on the compiler used to build it) it won't
be totally correct since the concerned attributes here will be
incorrectly considered as not supported. But, since these attributes
have no semantic effects for sparse, it won't matter.

So, for sparse:
Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

-- Luc
