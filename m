Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DFAC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 06:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66CA521916
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 06:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6QAn2pG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfBHGHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 01:07:42 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37838 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfBHGHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 01:07:42 -0500
Received: by mail-ed1-f66.google.com with SMTP id g4so1843591eds.4;
        Thu, 07 Feb 2019 22:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4kEPACT+cGX8sOqnTw34J+1Wi5NSgOceF8oPzUQ/5s0=;
        b=l6QAn2pGqMp5uCwuPrlHle+YBgBMON1MYpzCw9LEfeY3MUaNqWFKMOZb/26QjRoVpJ
         JFEUS4fZgQ5F1jyxhX6oDVaCPtH5ezafmA1FgrQ5k5W39Q+kIpjzYzUrPK6hn/FQZJVJ
         /EY00ygar3sIpO0TXj2UlamkebfD3pHIbZCnnyIBQmnOUmBxEUY6Sj1JL+k68AQEomAg
         xSxHVfTSPhTYwkshUtTwi9ls85+0I6y92uedoqWWh6ezBbxNXF7vXraZ1g1oDUERo0pw
         ec8wP6j7+R+IARX+TIKAeQJ3jl9Y70CmPDOGnJU3+ouGW1a5kTeGAzafBxeSXKIeRZS0
         KYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4kEPACT+cGX8sOqnTw34J+1Wi5NSgOceF8oPzUQ/5s0=;
        b=INzIRAB9u0IzzsWqR14Lh3QzX8KhJtZfR8KkQhSDvwmTZ/NcrbfEbFBkoDjZvxAwjB
         erigLhjP2H+kdBuPVoxnin55cmCV0y8l/MMN+RtMQZGRX3WPWZlO4DvPzzfzJGu3v0ON
         54NWU73EmcaaaqJG73cqjk47E7gt3UGa7rYJIlPjjfn8+mo60liklcg8nJ206O3H1ITk
         rN+ySZwRF2kNkaMfbL6KepO3QPIU884N6gcpw0Qf+eeX4gJl+inEawc3XZTZYvc1cnGL
         rZjkMQ6zg4qx6iGZxy4+LqG7aqZizmQ8ylLl9EAz4+Yqf4ISEPOODa4oBLh7BAuHJJwz
         d+gg==
X-Gm-Message-State: AHQUAua0lajW/j7hkczdrhQPTxsPsUJUjdvb6LcpbbHEj3+lWyzBngRX
        HSqs1TTAaMKcw89sP5XRAY8=
X-Google-Smtp-Source: AHgI3IYdJzqWymmvYzdd8VHzR7klzkuMKpuNzm5Rjl4eDKAoE5GK/mR2pA38t5nTaV4gpQRnz9zEvg==
X-Received: by 2002:aa7:d802:: with SMTP id v2mr10213253edq.225.1549606060207;
        Thu, 07 Feb 2019 22:07:40 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id z9sm378169edr.61.2019.02.07.22.07.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 07 Feb 2019 22:07:39 -0800 (PST)
Date:   Thu, 7 Feb 2019 23:07:37 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     ndesaulniers@google.com
Cc:     yamada.masahiro@socionext.com, Rui Ueyama <ruiu@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] Makefile: lld: set -O2 linker flag when linking with
 LLD
Message-ID: <20190208060737.GA12027@archlinux-ryzen>
References: <20190207220155.81351-1-ndesaulniers@google.com>
 <20190207220155.81351-4-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207220155.81351-4-ndesaulniers@google.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 02:01:52PM -0800, ndesaulniers@google.com wrote:
> -O2 enables tail merging of string table strings.
> 
> For arm64:
> 0.34% size improvement with lld -O2 over lld for vmlinux.
> 3.30% size improvement with lld -O2 over lld for Image.lz4-dtb.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/343
> Suggested-by: Rui Ueyama <ruiu@google.com>
> Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index 6307c17259ea..c07208ec49d4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -718,6 +718,10 @@ else
>  KBUILD_CFLAGS += -Wno-unused-but-set-variable
>  endif
>  
> +ifdef CONFIG_LD_IS_LLD
> +KBUILD_LDFLAGS += -O2
> +endif
> +
>  KBUILD_CFLAGS += $(call cc-disable-warning, unused-const-variable)
>  ifdef CONFIG_FRAME_POINTER
>  KBUILD_CFLAGS	+= -fno-omit-frame-pointer -fno-optimize-sibling-calls
> -- 
> 2.20.1.791.gb4d0f1c61a-goog
> 
