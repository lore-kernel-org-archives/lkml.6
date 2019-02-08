Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B21C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 05:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 100C120863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 05:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaGNj6qS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfBHFOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 00:14:49 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41129 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfBHFOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 00:14:49 -0500
Received: by mail-ed1-f65.google.com with SMTP id p15so1753887edy.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 21:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vs4bUubttQaRrgqX59SKfDkHmiyTz8gi93GWUZb1r0E=;
        b=YaGNj6qS3SMc9R+P4ZNtrQXtWAv8YCiDjHs6RKj8Rh5VpsQ/omge0qX+xMUgFC1O5V
         8Ojoc1uHhpKVzGo8oCrAQ9x/HIuBswdGJPDQwc9FJ9Tahd3hbwBUz4opMh16/QQvJ/FQ
         hqzDKtoGlM+cVBYu7huz8mi4CmOyd/hJuzjmaKrBvFDJCbE4GEPLzXPyofnjJQ7UNz6d
         Kn7n52gy+2+jmvHp6Ok9z18Wmka3KNjbhOYvANUhrXuSQJCcXZ/Tol09fxBdtjNqVCKp
         XThn6kDoLFiEaohJJk2OipcTcMlpi40C0RfjpHh3HZOTQ4EqqzNo+jDABFUMqxKz7dBD
         AzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vs4bUubttQaRrgqX59SKfDkHmiyTz8gi93GWUZb1r0E=;
        b=ML1qllY9/u4U11ZfpMzdRkTrhZP0nZk6vgZj3u3YYnGIQvMKdEkJJWMwqbkj+KfyOe
         sFV0nZrhYocFJiarEwxL1v3zFWbh5TmWsPgKG3lgJ0ybWffrwrNuOZ+GLBw5TkOZfplu
         ap4vQqOrXnkkVEp56Ivfm3oIZurEvsECN+8jKPinmsKTmZD9LS5hZ0AxJJI3tLWx5Yy+
         czYGnozrAHuaqJ6Kw9AO6rveSe4JuUN1yeST8a45Y3Ufx1G0L7HdG0+Zeknl/L6RA5So
         UWJ31aWsJlJ8kJXX54rDmxeCzsMPu78yboiybxeclpBNQy1Z4dIgY2Vr0htcDewp1xby
         e9ow==
X-Gm-Message-State: AHQUAuZTAxpSsadE2AsDNgN5PLDggzSuTBZ5ApAuqcBjfHk4PBM9oFC7
        u+RnDe7AbCoORht/JJCotMG7bZ1FPu0yQQ==
X-Google-Smtp-Source: AHgI3IYMYEXuKMKkcFKNMRmsDZWal9b0ZiESIbjJqKXDpYHYaugU0o9PYosCvqr0oxrDNKWZD1V3Zg==
X-Received: by 2002:a50:98a6:: with SMTP id j35mr15208174edb.141.1549602886973;
        Thu, 07 Feb 2019 21:14:46 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id s46sm354053edd.9.2019.02.07.21.14.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 07 Feb 2019 21:14:46 -0800 (PST)
Date:   Thu, 7 Feb 2019 22:14:44 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     ndesaulniers@google.com
Cc:     yamada.masahiro@socionext.com,
        Sami Tolvanen <samitolvanen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Adrian Reber <adrian@lisas.de>,
        Richard Guy Briggs <rgb@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] init/Kconfig: add config support for detecting linker
Message-ID: <20190208051444.GA9647@archlinux-ryzen>
References: <20190207220155.81351-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207220155.81351-1-ndesaulniers@google.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 02:01:49PM -0800, ndesaulniers@google.com wrote:
> Similar to how we differentiate between CONFIG_CC_IS_GCC and
> CONFIG_CC_IS_CLANG, add CONFIG_LD_IS_BFD, CONFIG_LD_IS_GOLD, and
> CONFIG_LD_IS_LLD.
> 
> This simiplifies patches to Makefiles that need to do different things
> for different linkers.
> 
> Cc: Nathan Chancellor <natechancellor@gmail.com>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  init/Kconfig | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index c9386a365eea..b6046dcf7794 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -26,6 +26,15 @@ config CLANG_VERSION
>  config CC_HAS_ASM_GOTO
>  	def_bool $(success,$(srctree)/scripts/gcc-goto.sh $(CC))
>  
> +config LD_IS_BFD
> +	def_bool $(success,$(LD) --version | head -n 1 | grep -q 'GNU ld')
> +
> +config LD_IS_GOLD
> +	def_bool $(success,$(LD) --version | head -n 1 | grep -q 'GNU gold')
> +
> +config LD_IS_LLD
> +	def_bool $(success,$(LD) --version | head -n 1 | grep -q 'LLD')
> +
>  config CONSTRUCTORS
>  	bool
>  	depends on !UML
> -- 
> 2.20.1.791.gb4d0f1c61a-goog
> 
