Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3AAC282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B91E42085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="LSYSIrRY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfBHA5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 19:57:23 -0500
Received: from mail.efficios.com ([167.114.142.138]:41278 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfBHA5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 19:57:22 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 00FF0B0AA0;
        Thu,  7 Feb 2019 19:57:21 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 9te1p3v9tejL; Thu,  7 Feb 2019 19:57:20 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 7BFD2B0A9B;
        Thu,  7 Feb 2019 19:57:20 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 7BFD2B0A9B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1549587440;
        bh=inFiIK0U2v+cT37Ej826lD0zogSvwLplp2DNUer/8Ow=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=LSYSIrRYajg5Ni0thXzv3qyvhVLr2p0pMtz9RwvR6L2QvxTzGC3Fp4HSgb11YX+8l
         wACpe2EWElaWXXCIR4o/3HKV8w5Ie1uYL2rECNpu1BjhY/da3c+2wuFD8LuuCEzW8K
         ZXRnDEvJ15HN0UXZllne/nJRV2kX88zu1rEdJZxid7Gbi7dX0QtE4gqwhTSiFDb1er
         cwbRSmqmG5Y1UGh0XHjjV5LFoLKrPa45htGYPVLPORVnaRC1q8Gm1NiejCPwLWu7RE
         A30jOtUmsl+vsCsST88pastIfGREwNSJN66y4il+1AiELuN4mIFFl5kDfRPhcMZdcv
         DyOZ8bd1kJgrA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id QG_AkIe49h1z; Thu,  7 Feb 2019 19:57:20 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 5A829B0A77;
        Thu,  7 Feb 2019 19:57:20 -0500 (EST)
Date:   Thu, 7 Feb 2019 19:57:20 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     ndesaulniers@google.com
Cc:     yamada masahiro <yamada.masahiro@socionext.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Adrian Reber <adrian@lisas.de>,
        Richard Guy Briggs <rgb@redhat.com>,
        linux-kernel@vger.kernel.org
Message-ID: <563751355.221.1549587440037.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190207220155.81351-1-ndesaulniers@google.com>
References: <20190207220155.81351-1-ndesaulniers@google.com>
Subject: Re: [PATCH 1/4] init/Kconfig: add config support for detecting
 linker
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3758 (zclient/8.8.10_GA_3758)
Thread-Topic: init/Kconfig: add config support for detecting linker
Thread-Index: +WOiDQqgJ7agtZglbzszGUWH6p3Cng==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


----- ndesaulniers@google.com wrote:
> Similar to how we differentiate between CONFIG_CC_IS_GCC and
> CONFIG_CC_IS_CLANG, add CONFIG_LD_IS_BFD, CONFIG_LD_IS_GOLD, and
> CONFIG_LD_IS_LLD.
> 
> This simiplifies patches to Makefiles that need to do different things
> for different linkers.

What guarantees that the linker used for e.g. make defconfig is the same linker used for make ?

Is it required with this patch ?

How does it work in a cross compile environment ?

Thanks,

Mathieu


> 
> Cc: Nathan Chancellor <natechancellor@gmail.com>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
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

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
